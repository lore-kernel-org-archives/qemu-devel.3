Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9890606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kgFA/vaP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HOtcZ3sL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgG-000425-6h; Sat, 24 Oct 2026 13:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg4-0003yu-Mb
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg3-0008Hk-01
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF03sw1863231
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3QEdI+TdXDWqiVhS/+AXbHFCLaPlnPSv70qcFhuQAOs=; b=kgFA/vaPKxFamOft
 CXuCvNnR9a3TmiO3hLY+QGggitLqA4lNkKgefyS0z80Tn+/buocHSlnb866OfNH0
 W/EcMo4L6BZWI2kJ4T48Db4/7yKcP9pszTLB4NKxu6C/R2Kg8bkawVppeouyXHNK
 u4fvD53Q+iDyq1km3gFlC+Me2GkXkSvkixkGvGZIFtpQ4iYkJg894CC9/pmQBj9U
 ltP/wnA9jJZxJX/Ou78tzBu74pF131yz2nhS8hTFi5v8Eh+ps8XPwrnhMMv0Pw3i
 Ik3XbjiEZ3OoggQPfLuhtJOFfp48dPr48tNJJ4/wQxxnDghqt3gxf4WNtYH3dgcv
 rMpNyw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhesw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3addd73e66bso856423a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863425; x=1793468225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3QEdI+TdXDWqiVhS/+AXbHFCLaPlnPSv70qcFhuQAOs=;
 b=HOtcZ3sLmytZ3Iwf0WKAp1Mfr4N+K34TLPZoUzwIiOSw3DmzOBeGjHFIr2gQpPu1i/
 jNy0w1cIlpUNs0CM/g1VuRpUj1eXbcfIqtA+D0a7C/Out72MbIgDYi8MyMlbt5KciiiY
 8RWwgGmfD04ECSisaW8PaR5UH+KOCJyMu8YkHdFIgBKVkguUEhqakpMLcg6iydT/OH5J
 ABK8YzZ/8jJrOcTjvggpNAfX3kqpzAYIxMFcsKxbOZmU8CbgP53HoglzRRPRmdlbU2b2
 o/OjfXf1ElxK3DwUM9ucUuckI5pyR3h3YqAxg8Qz4ue/6VE4RIzEiJAfAKmylbIf2wE9
 yn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863425; x=1793468225;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3QEdI+TdXDWqiVhS/+AXbHFCLaPlnPSv70qcFhuQAOs=;
 b=rMbEJ+4PAL26YnYEN60ilOFVJcoO6GVAzcMEi1nvOT/1uZ4KJcvlj1qdN2phJWTq8R
 HUtOZxC0PlV8jQUu0fIbSM2O1m7JQVBOlCJi1yKLPjJr4XUsi4XK6AaYwFXzUvgrK4Qs
 sH3VccewOBqXSwzu2UTN5dmlmScw5WJzbufk0b0CZjudgdRWnZrIirmxylGwv2hwt5ce
 KVMko6AJqVnyAaCPRRO+vqkYRm4pqcICraVDrJUis0DSSrx0mG0xycbFkxjqxypnAR6P
 DvQH+rvz5hJ0FK4E8DYRfJM9Gsy9wKcZ0qOkqHq2XRpQVp2v0SSritLKmR9UmWKaQBN4
 aHOw==
X-Gm-Message-State: AFq9FYLrotbGFjvYVFvsBiWKBeBBQG0xnn8ZX5QAmpxqVqKMYtt2WZqM
 OgFScBkwm8bsATn3Ys1K7P2LhV4jcavxx1CvLMJuXXHTYtcOBt6cwAjRHvyeVEUppwzhLHhjwe9
 8AQ15w5EfuVMskNpW/0ic80WdD9zlI+dy3RwHcoPsL0bFA9jF/hgs1TPUh4spZLZjyw==
X-Gm-Gg: AYBFou03g8r8dkTJ8zS14MSm1sxjTS3F106bX9sPLrRQm+CjX85BnRMWB7Cbv01Kg6B
 OSjNsLP75nSv1gNIFMiq7veTYSu1TlTz4n7tb8P1OqXXgfdUzYT4FzFkZbDIcal6RTWf+1MchjE
 sdJlQIXT0s9027XdBvoH9WEzknI7evPL+ISPZYlq2xvrn9BOft1Xc4kPNnc9cf13X4n6tJDNOKf
 48h7ASakdWZPD6V0KDcnidbvXhceigOZ0yTLYS5EumHCuN/mXCXAEdFlDTG9YJe6mh8n2l0D9nN
 di/i16pSb0Gjgif/gjeephH7kefy54wMIwvMsDB8B3HOMGRP3ZA6e4UX65W3sNfadFNQ0ySSg1Q
 B+PyFBV3I3DuCxeRXzo8chj7j2hyEHm/tiS/GbWEjwYUOhue7GSx5ADNjIvP7EdE=
X-Received: by 2002:a17:90b:35cc:b0:3ad:1b31:92d8 with SMTP id
 98e67ed59e1d1-3adeb16ecffmr1918588a91.60.1792863424866; 
 Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:3ad:1b31:92d8 with SMTP id
 98e67ed59e1d1-3adeb16ecffmr1918574a91.60.1792863424359; 
 Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/20] target/or1k: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:38 +0000
Message-ID: <20261024173649.7405-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXwmHuqGEaQ8iP
 3jC43Vn2ggUMyov0xWLjmKWpreMbyscwqOKbGIRKhsNthUbCBzgnSk+s1WKG5/sP/kjeUZaeR2y
 +q2mfqZzPVbmkV/whFi3zVlfFjh1sXuTrgAT1EcrYBU/p/fKtWr2KhFv7hvDly/dXN3PsG4RBov
 T1FDlFV4GnwpGrFuwDzVifD07JEDtO93/Gt4HY/PbO5mwnoAA3Lu2+Dm3H1kxTPNzsMSEFGmlHT
 PBIVBS7IAbtvcwhfkrcbqGMnko2UiGsoKmzaT7r3d3dGCzWtc3oRaEc1IQ0P1399swhXyOum4+T
 I4cOZIFU6LAQo9ga5kRqJKrDSnKPFV3IN+i7JAmX7du0UWPvK0lwWj9b8EUt/KEBwl+f4yBvW8E
 3Y2a5xJtBAKLOQ4KP7CXW9fbsHVBdDFJuoPZuxswmfAlhewtFuokm6/23El3DlCpnzSpF64Vvkr
 tzf/liiBLXCV1DOQL6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX0sIAmSDJK1l+
 1gNA8jXuPRs3qU8LE8i1cXJvJZ6fL3LdM6KjEdVcgfcgtMUBlMWajqu0sWjIEIER0xg1xByStvC
 EE9mApGLztF3KAQhMSMUdCzdCLuxSxU=
X-Proofpoint-ORIG-GUID: QfVqpjH4tA9OwGpXQrMwbXh4Bv0P3c4j
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adcecc1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=s0g2yuqVZqAqKHCRF2MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: QfVqpjH4tA9OwGpXQrMwbXh4Bv0P3c4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit f24061e40d2978a51bf15d7c6fcd7576c709c099
"target/or1k: prefix symbols conflicting with other arch"

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-10-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/or1k/helper.h           | 2 +-
 target/or1k/interrupt_helper.c | 2 +-
 target/or1k/translate.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/or1k/helper.h b/target/or1k/helper.h
index 9f74bed93af..e0a8d402271 100644
--- a/target/or1k/helper.h
+++ b/target/or1k/helper.h
@@ -59,7 +59,7 @@ FOP_CMP(ult)
 #undef FOP_CMP
 
 /* interrupt */
-DEF_HELPER_FLAGS_1(or1k_rfe, 0, void, env)
+DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
 /* sys */
 DEF_HELPER_FLAGS_3(mtspr, 0, void, env, i32, i32)
diff --git a/target/or1k/interrupt_helper.c b/target/or1k/interrupt_helper.c
index 91dd2227442..1553ebc71b0 100644
--- a/target/or1k/interrupt_helper.c
+++ b/target/or1k/interrupt_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-void HELPER(or1k_rfe)(CPUOpenRISCState *env)
+void HELPER(rfe)(CPUOpenRISCState *env)
 {
     env->pc = env->epcr;
     env->lock_addr = -1;
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index 6972dc7d630..e00ef45b9b7 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -1110,7 +1110,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        gen_helper_or1k_rfe(tcg_env);
+        gen_helper_rfe(tcg_env);
         dc->base.is_jmp = DISAS_EXIT;
     }
     return true;
-- 
2.43.0


