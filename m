Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C9606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG2OWFea;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dbXHGTNK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzvw-0001DX-DG; Tue, 24 Nov 2026 18:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvO-0000uG-6Q
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:27:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvM-0007dS-FQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:27:45 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMavsm2140400
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DGmlmRo8/L4rvb2338i/Bw8F4Xex46DZNi4OWzwfOow=; b=PG2OWFea+z7Jl9jH
 IKgX1XdqxMiflkzkKd3FniAQY3gIVe35TXiNGxIt0RGTqFl8xE3S/uZXBd6t2C/E
 kmIoqLjygb5pTs48R22PgxdJT49moPIZG/N2WMuZimt7VMqsyqXI9nSUhj6QXmAB
 IcpyhEFkOktZf+Cp0KZj2VqEM6VB4soN0shI2WOJFNUuqCy8Fu9wEDKI1C/dqZ7n
 3vUzpEjH65NCn7r5MG1P9ehkrA9zu3N+MsLtg76ZRYINUIT4dx+fQUwA578D1Hm6
 N9ZwFpQ2wncNPBr0d19hLLQVjHrWLiUJ/W/UB+1INuVcQWZ3M4ArC6oIjG9fsem3
 /ojwmQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gns8sde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d2c5f10ddso103918691cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562861; x=1796167661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DGmlmRo8/L4rvb2338i/Bw8F4Xex46DZNi4OWzwfOow=;
 b=dbXHGTNKkISFpNtNAwpkbVFNPWGjT4SQ/jHzPjDWhPxh/0lrOJO2HD5+56veJBTHLZ
 xiIMFyZZRbz1VOWBs3T9CwjA/Z51BT2+nr9V7TsoTDRUvQH1OghSvCtdigNAzJAQtSnq
 Jgp5xj2K8KyFSpuTsnDj2cYmL8ltnQzQiZRCSFSLKZoB1cf4i0NvwlQNt9zYT3bPeLmB
 hRpK1jiBrGatg9Ag5Cm2aWdbeIpT/DkHI6Fo5V5L4LeJ7iXv/YnJ+usBBwcC0kp9s8I/
 TxoZiqPS03ClyxEKI50eLbuxJM16ihsJVjr26ORjYnvCCzwFe8z/+MLEOZamUi/RODH7
 kzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562861; x=1796167661;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DGmlmRo8/L4rvb2338i/Bw8F4Xex46DZNi4OWzwfOow=;
 b=tCzwgFiMgMmneivP2DD0AMKhVY2Mc6q165z80sLWe88DFVDtKabTFPT1tiNeYtcm8i
 8sxsSZWxOKp1JhpsJNw7zM5MI2gi/jPNWhcIMcr8wLzpZdo0kjV1Zyek1QhD7KcLL78C
 tkwpDBZvg2jYZ+NQSxtrkvFATXrzcsRopoznM+1V9QrL7P0dznklPtOeKsnzlucesU6c
 w74F/Es0OsYGD1h7kXzJK8KA4M7eILl7/r6503LuBdQUl7KfR2GYghJNavfNhERVXIKX
 rM9hLxilv6LGbHZXkF2dt50qUqXkO7xt/zkwDosH5UevuFw+vfUW178OsGleiFjajFie
 ZKUQ==
X-Gm-Message-State: APuU4Z8AWov9tt8OmsL2V6LgEUdTmOqcjbRF4JR/Z5iPsaGoFKosjfpi
 XQSBDxbDMvI6zitMO7e8Vn6D+Cfrgq4M9C+Eoo+5kgdQdCVdC4r53Ee7hwYIMHBvkJPG50LhHhK
 8+EAxfnt99vlUCdRyBb8tFF1jHtllqnGLh7U9nMxoJwYWNYXjchpKqrjeyYwQHg75eOhk
X-Gm-Gg: AZFdTZf/ksEmwE7xDR6iMsS/g12lZI6waFLO02DLnMUHeObD45nu/eRojcf41Fkg+ke
 VcArizRjRnXDF7repKOIhIQjayRUqaNppd8SIi2Ij1OdqSFha3WwG8vW7nXKOIVbJvAjgHu1r8x
 cVdhvA+LrilsXUU39/nV5RqP5E6g0Mgf0Adj3+xVtdC8xq44u5aVPOk4uNEIxq23OOj1ZmI+0H3
 QXa2irsK39xInNC3XWaJFiF7mNdt+F8wTZOUUkq5Iv52D+ZcVbAWs2ahkDe2p2wkxCc+UUuhlM6
 avWk7uTrgo2sQ6xwKnQnj2vxwWyrtFxbHfzzMNxihCYSIHFo+Sv5iltjstjKCFOTXnR3WBUkcJ8
 od3gCGsVanXULMPsyEyM9/GoCVfV/Sk9Z3EQo9dsQdIXS8qrzIi2j9lTbUkAjSgDL/Qf47pWfp9
 ATp5dvt4tE7E+cbw==
X-Received: by 2002:a05:620a:1332:b0:949:402b:f1b3 with SMTP id
 af79cd13be357-949bab3e8f5mr2476352285a.70.1795562861570; 
 Tue, 24 Nov 2026 15:27:41 -0800 (PST)
X-Received: by 2002:a05:620a:1332:b0:949:402b:f1b3 with SMTP id
 af79cd13be357-949bab3e8f5mr2476349885a.70.1795562861096; 
 Tue, 24 Nov 2026 15:27:41 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm6721397f8f.54.2026.11.24.15.27.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:27:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] Revert "target/arm: don't pass env to the sev helper"
Date: Wed, 25 Nov 2026 00:27:06 +0100
Message-ID: <20261124232722.90234-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CkFR15W1eQ8pQy88jNffAasoU81PnAuD
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b061d6e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX8WiMqAPZLwQe
 Up1rMBfb/MdcY+249UxeQB3bQX3olt8Xd3TfNU2zSZ2rsY04HK61OJMfISM9Jw1ewtJa62AJZOC
 74ULaHX1DPbjbVnlV7fvn3+kzGJkapc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX/5zoOrjjy+6n
 KJTsi8NTsD+Qgzrnlt3S1KF32yTpNAGR/FCaUfrc0NKRiFpF6gL/CiRMh4GrVGW/A4AI/LpYMNf
 AFY4+G/zw+uRE0tS09Cw34a0bEb4V8wjoIA622rg4m+h6iIkNxPsGeFpQfiD7KvnLKqtMzlx00Q
 sqoa5F4AUdbvogg1lTlU6auhPlG7IG1MTy4BWQvcRze7cPVTpbxCL152kIN5buAwtljqf6SdLYT
 l8/t9ZXwZzmeYB6ciltZTojhzRQqk6fYXJxzgZ6zrIsTwlEaygOKgiQQH9kD/5h0N6i2F9iU+CT
 GltUuo4G5CRF86WFQAnmCeF+CO7wuYpmZlJPnmzGwv0SuU8YNQPLtAwumSr90v8fpqfh5mmncZF
 Xwb4Dpie044DNwUqE8XZ7F2Fk8JkZhOWTCHe42ZY/dDbQyQqPeAWa92qkimgvrt44bZegpzzbTT
 rUoIulUYuHAY0CIWB/A==
X-Proofpoint-ORIG-GUID: CkFR15W1eQ8pQy88jNffAasoU81PnAuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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

SEV needs the issuing CPU to distinguish it from other vCPUs
sharing its host thread under round-robin TCG. Restore the
explicit environment argument before fixing that comparison,
avoiding a dependency on the global current_cpu pointer in
the helper.

This reverts commit c5ec1bfad10346aefb8d7a18cea5118f2056f8a6.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261119225514.4080-4-philmd@oss.qualcomm.com>
---
 target/arm/tcg/helper-defs.h   | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 4f9736e6796d..269ac5150657 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -60,7 +60,7 @@ DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
 DEF_HELPER_1(vesb, void, env)
-DEF_HELPER_0(sev, void)
+DEF_HELPER_1(sev, void, env)
 
 DEF_HELPER_3(cpsr_write, void, env, i32, i32)
 DEF_HELPER_2(cpsr_write_eret, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index b6113096b53b..a862b9eb02da 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -468,7 +468,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 #endif
 }
 
-void HELPER(sev)(void)
+void HELPER(sev)(CPUARMState *env)
 {
     CPUState *cs;
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49472f7d9757..14888202bada 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2148,7 +2148,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
      * SEV is a NOP for user-mode emulation.
      */
 #ifndef CONFIG_USER_ONLY
-    gen_helper_sev();
+    gen_helper_sev(tcg_env);
 #endif
     return true;
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 442c34ce84fc..9d80294c9bb2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3282,7 +3282,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
 #ifndef CONFIG_USER_ONLY
     if (arm_dc_feature(s, ARM_FEATURE_M) ||
         arm_dc_feature(s, ARM_FEATURE_V6K)) {
-        gen_helper_sev();
+        gen_helper_sev(tcg_env);
     }
 #endif
     return true;
-- 
2.55.0


