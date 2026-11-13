Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF30606D473
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaIldVxL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PHhwEOF2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtt2-0000G2-Kz; Fri, 13 Nov 2026 11:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtt0-0000Ao-RV
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtsy-0007y7-Tm
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:22 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRCmT3618642
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yIQ0VBk9x85SSwFc16JDHUr7PmsxK0U5Bk1vv0PXlhI=; b=eaIldVxLcCWnEq4U
 6PttTkkKsQ/nbxvHdNFp6zO7jzZN/k9wLsEF5HduqaQPpwNagi8og4MiOjh1OWP/
 Kkvyh2eQ1r+jMIlnquK+CNKl3krftTlZKnIwJ2Sx3LTCY9BntZMikkqngNs4gcjJ
 OZMCSbyD6NAMrCh/D95F1jR4LyfrT+KwKUPNWV9j39FdS1l60TjH180CNxffVYAa
 KTIQyprl/7s8piLLOsdyrDKVWs2oNQJ1/4b1rn5PFQeS+Bh69CMYnWOAfejzlczF
 v0VnJ+/irJAg1NzGYheP4Nx83uoc3wK6jGdrWvl/9VmR72puPgzx3NUqjoqdjtIL
 sVgWsg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bcsta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:19 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ecffb6a384so1006748e0c.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586338; x=1795191138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yIQ0VBk9x85SSwFc16JDHUr7PmsxK0U5Bk1vv0PXlhI=;
 b=PHhwEOF2Fq6MwvXo6pTqmTby9Y/QLNTPBfzL43orxkHkdI3HpSRQ7RiicHyGBToH3l
 PLMVDOfxKMhPXp/gJLIdDKRc5l1xzKaWOcO5xqdeVcpJIOMo+Qt7c+r/sXYhpy5y2YXj
 FCqhzPBFFJPnYZdOtFtDbP+4TP1OOCKW4T0eX0L2sOBq2LuyEoCTmrymfhXcdRzwVLc1
 VV3fY7tzpcaCz69Cx1wikdBU/3rLI+Nxx2iqte12U1yRbtzTy5kU0Jj+3JCKX6wS82wz
 92qRw55H1Ro6WLC6qbI2xLDJS4ob00ajXE/qNR+3r0JLxlvoxeK4frSmCjOX5eAwSRqe
 ZNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586338; x=1795191138;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yIQ0VBk9x85SSwFc16JDHUr7PmsxK0U5Bk1vv0PXlhI=;
 b=2pPxunrwqp9FoXh/4CCCtsMFXdVFS4MjXk782p1wwUjUpdSonnqF9hh6s5mRCtLg2e
 JMrFVtpYDWTfvVTHsryLJN+jx2fSxdDSwK3QP7wJcjgRRI9W5/qrM5zcT5lpP03YnzUE
 OPol/tnLMwNK2E8YhPl+cy4wp2EV+vKfbQmT6CNUwaCNiZD1kWqmHISwIyuqPgBoKlp3
 Hq/72gj1+k+eWBV++MFc7c9Z9T7gXgrDQdyZ9V8YOKBzdsaK9CKILQeNWR8Q0uogud76
 N+5ATpHa8ogWXDeiT+wMYGy4SyYjEZ/1C5C8X74lIOOkJV4+7CfR0FHZ4Udlb9e6tUii
 YYTw==
X-Gm-Message-State: APuU4Z9y6fvsJF/zinFPLT7i243tH156A8LNdy04mo09HrPmWz0pZbc+
 1tfXB9SQXEQL3zJsJEntSUPcBCAaI4S4ntYsUvZvqNETR68cDROW9+vXP2oXfk3gZT6UAmwj3MZ
 6ppNGDVe+AtHVpx0OVC2ZbMUm9K9bxwGN+cMNyN75TF4ptnp+Rf2kymPpjg3AJiXHnLyx
X-Gm-Gg: AYBFou388+VTKp1jAm0PzxNNr8FQkDyiHgQ2sFonEXNxfARbqgKmDBcA4Ca6ZGWINDv
 jFcF3Y7F63M88+3FBzxqZrGOvXLXjIDJodXFhniA+h4bmailhJFDXqWKcvfMHTmLhBvcUxYn0LL
 i67ts+nPbkO64Fz6wObtOHKFgwn8888hrVtIqQsMPO7iihgw+abbzEVCq2nvmhK/Uk/tM2XV6la
 BMBDAqSf+V9sfRbJRP0PYDa+x8W9zNNNn2qUtphb6AiO+YjMdR7eOpsZ4I4AJ/zdt4Pnr64Uxds
 QdsVy8FRQbnlbo2hYK6RWsexaEbGsseR+/WUn/HNoXpxP40Ly7gmFFWSdiSrdE3Jml0NEfls2QQ
 YtBM95vazyzqvbV5QSyOe2LLZGUIh3OJKYtw4JiSoglJWZ9hAJC9QKQAMGmJfy4a7tNCiTtHJQz
 zUfSK1JtBqvSXOLw==
X-Received: by 2002:a05:6122:1d51:b0:5ea:ddfd:3e99 with SMTP id
 71dfb90a1353d-5ee34a7e5d8mr1230413e0c.10.1794586338223; 
 Fri, 13 Nov 2026 08:12:18 -0800 (PST)
X-Received: by 2002:a05:6122:1d51:b0:5ea:ddfd:3e99 with SMTP id
 71dfb90a1353d-5ee34a7e5d8mr1230358e0c.10.1794586337768; 
 Fri, 13 Nov 2026 08:12:17 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm6958142f8f.0.2026.11.13.08.12.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 02/19] target/mips: Require rt == 0 when decoding BLEZL/BGTZL
Date: Fri, 13 Nov 2026 17:11:40 +0100
Message-ID: <20261113161158.25811-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af736e3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4L-gAl4iwDZZ7NynZboA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: VxkPCMbePpDRAAPp2EcoxL2oaiJv461T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX73OA5zUCOVbm
 8wO3URHTVFqvpX/pDMCvVF2Fj5Me5wC0QKnKrMOpa+SarMAm1rbEVV9ZV7XHJmoPbu4umpF489W
 tsK0H9ydnJaBOplhFBxQ3SdyDrX0eiVp0G5jOuHwbtQVzbiukj39sFOF6mtEzcsNFXzo7unRcy8
 MJ0INx3afJTE+9gRWXfP85+EVQkQVskNM/fSoKrxRW4ruUcMuU0c+y58/K3Lu4RdacBjiE0yggL
 fByI2if0fYCRfAyQUUAmZBiJJT/yXlsRsMC0glWyoZGwgnLrgJX5ei/lRHXiYNaLBaOgJA5IjfU
 7kbatxVBU7toABDOLlfVAGdpeWeRl4q2lEVeHEaC/ac6gypiyJbpxxqzs0uqWkRc8AOaaCwEbAr
 GdboW7GhvnvELdFE/9wDIynPZF4Qeun+Nl+akA1dDMRONFylhJVk/imgeNcDT4RxFySY2CgEg0w
 QtIDIGj4AcxoHXfqf8Q==
X-Proofpoint-ORIG-GUID: VxkPCMbePpDRAAPp2EcoxL2oaiJv461T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXxgm1Dd7aSU8L
 XjOv8VQaWtlt1R9vx2gvsT1TZEqMB7gZ40eOJln4ZYjEnWmTL4EmN57EtecSjAnz3Dl5SorM1Lg
 udfAFlX89AvhtP2+BT0h71+tHIFDOxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


