Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52300606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0ZC2Yrp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H38AC1rp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwH-0001Zb-F2; Tue, 24 Nov 2026 18:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvy-0001K9-5w
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvw-0007h6-Nx
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:21 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMbUSk032074
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RtKyEDVhJJWmhuCXR5/6aHzd0EsmQuLnWUW6RqyGqfg=; b=l0ZC2Yrp4sOua1QF
 mg30/0qWmNuIbWK1OOmOlgWl64vhEtP5b7CrutgS7oQYEGahCvtC5CUmH7ryFva1
 /t9gY1kc9OjZvcrWkWxs7mxSo+Ku2pi/s/3VURztrgrrODyibyUCfoTb5ZlZ33EZ
 4/Y4fZ6jEhQFfwi/fGd+dV1zAjeWUWOW9j6Om8M9IDVsTvs7e+fgqjlB/KWtWiar
 g26qKtYcDJXdLS0TVPyQSSXQRzXB5zqqnceZCugTA4NmyUoMg65RTkHgQ2u8bEKh
 zwQV3vYk56z6qXzVWDmE8qXpN8baYi6S4QY0xGsuo2LoxbG9RQz3VtjqaQR0RavM
 UvguWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7tr17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960bd17b5so838803985a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562899; x=1796167699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RtKyEDVhJJWmhuCXR5/6aHzd0EsmQuLnWUW6RqyGqfg=;
 b=H38AC1rpueffOPJklowIkVuQJBFq+XujrMo3XbR53XRPJLTsBup8aVd5XwUE9od22Z
 05X2Q6r+0yIyLzVdlhDKGa/evNhsaWxnK2I5yFQiCmGRtjE4EwyH5ew/31ciaWnHhiEN
 /JZe6pMfsI3LBr/j7mdmFhhVLDPmSDDwXHf0uKShv0+GgISMYFOoAgdQ6izI7L/0E7CZ
 nBiu7Y1usB0fveDy4LVT+EMP+jkP9TLkyDy96fgcFc6NjXG9zLSImNeVMUo/UG8tRuMX
 oA1bHM6PsILjijGktBfL/vvRVEUjZRTqdmglNB7KbR+bgTeQrsqIAPSEvIHXc2ZPg0cf
 bH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562899; x=1796167699;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RtKyEDVhJJWmhuCXR5/6aHzd0EsmQuLnWUW6RqyGqfg=;
 b=dOgjEkUf6GljMVs4hsyQ1s4Q7Muj3I11yAqC49qB5n7FUMR6EKEaNOwSUrlmjLBInQ
 kw4ya9qpmrkkyd8E+pcg8b05LPsqhgCrms44u1j6Bwb40uWOn6JEY3k3g4hAGr6rl5o4
 mtiEMm4QEfqAH6D9y5RmSv0CdjHw67g7ARMiqlN4lqG8rvCuVlT9odGQE3g55MjqJ3BF
 ssS3215dzSUp32GYVPONzizXvMTWSnAYybKMEYy/YSIQvkV35Qxrh14p8URivtdcyWmg
 N78S9FHqdHdF+YBot+c3FoFYt5TL4CKfl4Z7rwYCFScYbudy47yPutge459n4xFgFoLn
 AboA==
X-Gm-Message-State: APuU4Z+jfX0J5pmGSiHDjnEmq+7kik6l9seq1wxfhMmJsfMHdNk40JQG
 E1uE+VmdjzT87Mx8ZpJSIxT6w1BSLicYnYGkYw4YenFHOod0ADcIeDnqqfEZ2Ls30eXmz228TkQ
 IxVj6gIYPmiAn8HWg7SOjm+36cfQo7tH6o80/K/N8f0pBUZPGPn9AUB8MqAszY5Uw9W2I
X-Gm-Gg: AZFdTZecOYVgWFGgrUZDjqB+qlrzrQWmbVU1MfTRm9uHu7xEV9l/XLaJ2RonH3TL4k4
 cSNvR6mu8igokpYTRKe35nNrhxsZxBqK4RZWE8sag1Y+Pw4CqzqW80q9I18Z2QYXShbjcyJP+LK
 YDeRryg/sc0GPGbHsboDrsV87ZVXW4IiZdcbapnYYtkVoVOsfHYeielCJZJ42XIEDWejv4GTpNz
 0t27PiNYQlfp7gXUkHUevEiuMPXBY39Up2iituiKvTInoCcYifkr2OuK5Bskqkb/Jp98WmoVSOn
 mP9ZfkJINFcdAgyUtII6viHbKAHgXk0RY88ZrB4LGP13pA10zb/x9hErakmED9igEHP/e1aqIdm
 ga82vOb8NSxals6+o5+kqEtNYYXn33w13wtK+TeFHRnGroLxILnCW0+5s6gYrC0byjRRoXl1ueK
 pb4KUr/x3wR2Xdrg==
X-Received: by 2002:a05:620a:17ab:b0:939:a003:7127 with SMTP id
 af79cd13be357-949ba9da872mr2635100185a.52.1795562898620; 
 Tue, 24 Nov 2026 15:28:18 -0800 (PST)
X-Received: by 2002:a05:620a:17ab:b0:939:a003:7127 with SMTP id
 af79cd13be357-949ba9da872mr2635096985a.52.1795562898147; 
 Tue, 24 Nov 2026 15:28:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa397asm31396698f8f.48.2026.11.24.15.28.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] target/mips: Require rt == 0 when decoding BLEZL/BGTZL
Date: Wed, 25 Nov 2026 00:27:11 +0100
Message-ID: <20261124232722.90234-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXxdH9DM+KTt8Q
 +3aZwJrp3ePL0TdsXjMqwwBOOYAbj+9KgaUvgOEyVPwHcnqe8wJ+9y415tX7TLqczFXpXTAZkNY
 2yJNC+7c6Ybyg7d2kNW5eZukmFbW1G8=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b061d93 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX0xjUyInhhcCY
 pchxRHVLJ3mATo2fefmUVx7KnxCTryDkE0/xM5Gr1KMCwra78wJueup67zNrqZGgoOL2Pu5YpOS
 A5AUjGLXLPfGN2BhiDg1H3nlTaNkb1ROjyYmDAlwMyus/NvXH7dXO7aMOVyJJl3QSF9J6JSErVt
 TP13e8/y/Sz7TS+Kb8Z8HBeQpg0Z/lr4STG+MGunCrXddp4z6sRiW9+4q05T0GTqz5kaHuZdnjw
 W2jSonNtF9mus6o5qW4gY1G04PSYLhv1Qiw6yMcjj9j4PW1rZ3QslJVfhV0uw3pRpmF6URUNnPE
 HDhS0r4obFEk9fab2C6jyDDz4ohp44GsFaqJVvUWGFZFXe8AoY6pRMOUxNUfcLNqt4iHhs46388
 y/06mgov1+vbNoYR++UNN4JSjQVFB/sI+GbJFV9ynhoh9dG2vi2wA4MMDzztMrt1gQnkgJQM7go
 FIvM2cZT/3dGQUgU7mA==
X-Proofpoint-ORIG-GUID: pwQrUZEhMoQ1EgycM-h8KWykuHPyl3lk
X-Proofpoint-GUID: pwQrUZEhMoQ1EgycM-h8KWykuHPyl3lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BLEZL and BGTZL encodings fix rt to 00000. The legacy
decoder ignored rt on non-R6 CPUs, executing reserved encodings
as BLEZL/BGTZL instead of raising Reserved Instruction. On R6
these opcodes are the compact branches, which already reject
rt == 0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-3-philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index f521e0ec5bd0..6e7e1a0f758e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14621,6 +14621,10 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BLEZL */
+            if (rt != 0) {
+                gen_reserved_instruction(ctx);
+                break;
+            }
             check_insn(ctx, ISA_MIPS2);
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
@@ -14635,6 +14639,10 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BGTZL */
+            if (rt != 0) {
+                gen_reserved_instruction(ctx);
+                break;
+            }
             check_insn(ctx, ISA_MIPS2);
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
-- 
2.55.0


