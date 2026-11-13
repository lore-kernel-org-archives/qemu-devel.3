Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B4606A33D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ezjynO0B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZWbNT8GB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRttG-0000gK-D1; Fri, 13 Nov 2026 11:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttF-0000UB-0G
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttD-0007za-Gp
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:36 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFj8MA780979
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vsbPvbCyp2iXj+FSMV+5ZmoYySkWwyx6/jiMWtrxUWk=; b=ezjynO0Bd5mQZkQz
 D9+7f5D9KtxtP/dpK97zRcnLwsaD8XvVZBKTX7W9U4bJyWOYAv8vhgTHgYy3ZNRX
 Nwm9OJD6r4soda7HxS6nhTj6d57VR4O60nNEooGNFf0VnaYid7/MWXrHLgfcDbL6
 Kx3/4Ie0KGY+92mrxsyLZdoW1TO7gRwzHBPS2hXgQPp/BHP6XFCsLCSVXTFGj0Gd
 8u+YjlJlL/5bwTYr+O+j3Pi4O5rzhnoXhXadzKLmJekmd6C4Fl29t9x1+RZVoPhB
 4JmS5IlRCNq4R1hYvR3Hlnm0txICoqsFmp4jdZsDjKWBbGqytYq8LVoVOJwtCpHE
 kVHRdw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37j99e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:34 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ecffb6a384so1007000e0c.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586354; x=1795191154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vsbPvbCyp2iXj+FSMV+5ZmoYySkWwyx6/jiMWtrxUWk=;
 b=ZWbNT8GBRu1k9wf1oTOob5IqXJyQWcdEULgGsrI6OA8Hn9nEeO3YDJLTJFzxqqrOI6
 GA038GMDfvj9KhQx8ii5YwvkeHqEplD5wrg4Ot46gGfHLdTBcRtfyoqtd+Z7T9WF/e2P
 rXcFAdLyOlIf0dcARvY47/HRefACQwcbozvGsu6QSwQb7C7qF9u0uMVk1G7wZOWl0lQv
 kDh/w8VjJFViQXiScWznv7CgUOoC5dkwJQzLsOTYrlmfO5h5Swtkog2r6Y01pC7uV7bj
 AxqzgoLoXTNU+vnjmWiif6O3cCZa1uoy1h/iS13hAYGFJod/XsXNm/OAQfSyo0BZuwUN
 2fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586354; x=1795191154;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vsbPvbCyp2iXj+FSMV+5ZmoYySkWwyx6/jiMWtrxUWk=;
 b=uxhIXwIPgJGVJ9OtPgfmXKO874XjrG/5TpR3GOVKVKhqjMX7TzNDLvcAF4d2/IWLza
 tbeUcC2cqQYs+LxhBbypHKUuz1I1TvRjwCXwh5WiCeVxNv8fhKUoPzYZgA4d7jYy9oV+
 jD4rShJ9fnu5UvZAMcT48nFObxoIgxtNnMRxgliAXUP8qu9Fh8C1D/e6gihtFrMel6Ag
 i+P2G3Lta5kwzAQp02kSuJa4M20PIM9DrtSs8GzhUP7vDquoHok55H6jWTZvhDC+JpMn
 oET0A3eGdNzQeav4M4/hA21i3/jhJyk2YRTUdoX7UzNREfJtDteW9RhM6merX1HAcvUH
 mYNA==
X-Gm-Message-State: APuU4Z+eWw6v/WQzroFb0aTDC0dh4Kr6b9hS+2CrBPO1Itkop4VGIrSc
 O0hoROES9Qru2wzo7YK7RrAZpDcaXDdZ/mQ5fhPEHPfq3WtIfbYWUpG/P5XAmU0YqPGKIYp/qKG
 DYvKFTjaQIO+ZMojT/i04ylBBSuYiu052uJxWYk0ppBTEpgoiZhXzPsPtVyFjTWxgSk34
X-Gm-Gg: AYBFou16JsrdOFpkO6CDt4NDFNqMKlpw6t1vbPLhWCt2HLTkOyHTqmU4sCz2nRi5U0A
 2Gq2XReaF5Ox0kE1X2RXR1VsQOQyou2AVMXuPmX6w7QfhGlKqvAs1dj7UCWGZREdxAZDgajDM2r
 G+Iw8EKgWOiuBWqfWkSTZDOQoWwl97mlHK01aBHhITzQ7Ju+dYdlXfey7gXp9RvqdhiQ8TKyw5P
 Sp0AUY5Uxwqs35jniE0CyPtyd45vuZdmes/x7vF4Y3+wtHJLKeskWUMA1aB0cPfijjkA8pTlru+
 UWmc/QSXrDGnxcnb3NTHeOEQRSU9jeZfOnMnbe+Qj+nIocPOuiyLDxN5O2FkxgDWHeP9dPgK3Ne
 2DJZVfBCfNPyLmRcsJjFMvBz0NKOeFwIEZKHhy+gI42ha9Gt7IFAvLT91Gbc4L9lkSa1uok7sdz
 oP4Y0YUOGn1XelVA==
X-Received: by 2002:a05:6122:178b:b0:5ec:3e18:a8fa with SMTP id
 71dfb90a1353d-5ee34afd0b3mr1271873e0c.20.1794586353717; 
 Fri, 13 Nov 2026 08:12:33 -0800 (PST)
X-Received: by 2002:a05:6122:178b:b0:5ec:3e18:a8fa with SMTP id
 71dfb90a1353d-5ee34afd0b3mr1271823e0c.20.1794586353238; 
 Fri, 13 Nov 2026 08:12:33 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29d24dsm168023975e9.11.2026.11.13.08.12.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:32 -0800 (PST)
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
Subject: [PATCH 04/19] target/mips: Reject the PMON encoding on Release 6
Date: Fri, 13 Nov 2026 17:11:42 +0100
Message-ID: <20261113161158.25811-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXwTvGDKbZPBgi
 BkPtnbxxd3coA8fGMOtf14QlmlpFgyVycxkUjCG7Jp+XarTOMXnY9xTUxZjdKkq2JDOXNTlLiTT
 JTEbiPlLCnX0JJBASfGpmvxIp+kWKDo=
X-Proofpoint-ORIG-GUID: gy1vLNxMk7R3ZvdEbRur39EFuiw6sE0s
X-Proofpoint-GUID: gy1vLNxMk7R3ZvdEbRur39EFuiw6sE0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX/yfkdW0s1myg
 vjoWjxpB2xVp16UhdSkh2+1Ku+MTtuaQEfWpQDUiFJqCf932rY2tjdimBJp/yeBhAnnV/8AsIz2
 HFF80ObIlKfiSKnongHWo9CbXtFyonPW7ZvRQX8sJ5WlG0U4oZzZCjqEK8jk92fUs1Ur0bp7ata
 kp+R2+xHoytvSKsYSiDrssNc1BImwDMMhmsH9GwCtIk97JJRjSzf/YK/UqSg2F/Jr0kFcl0jaIb
 g8AdD99R7ZW5jV0B25TsrVKwkja4qZqP/8s86LKe7vfqLC2qnVO7KfTf8si6Du8BCyegL1tagNt
 cXseBlAwZVDqN2e9Mo3TsbnALKDx2FSI5cpBQ7/R0UpyNrga5qPPze+KeUNOY7P9qA+auOQWo/Q
 YgXo3UozTbrofcfdv8w/14wzZU/3K8HZeIJ2j01KM1PqYqn7PuEskD+Q5OTy7dg4yEs1OjozheO
 NimW5lZyuG+++9V1ZrQ==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af736f2 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3-RNiPaCXex81d4jzlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130064
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

On R6, SPECIAL funct 0x05 is LSA, which decodetree matches only
when bits 10:8 are zero. Other encodings fell through to the
non-standard PMON hook instead of raising Reserved Instruction.

Fixes: 0e9524af2dd5 ("target/mips: Remove unreachable [D]LSA code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c434da714b0c..d1be32bfd9f5 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13301,6 +13301,10 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
         MIPS_INVAL("PMON / selsl");
         gen_reserved_instruction(ctx);
 #else
+        if (ctx->insn_flags & ISA_MIPS_R6) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
         gen_helper_pmon(tcg_env, tcg_constant_i32(sa));
 #endif
         break;
-- 
2.55.0


