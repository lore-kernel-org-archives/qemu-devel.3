Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8911606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pynBaP7Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OBj7hqj5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegN-00010Y-Rs; Sat, 24 Oct 2026 12:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegM-00010A-NQ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegL-0002PI-6D
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExuNZ1563068
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IeaKx09VkelEI+/lpmwVUc91Pu+1Q9ldW0MuIot0qVk=; b=pynBaP7ZbpJmMvdX
 yFZpJFsntbxVgyoSb5QhkkWJFRiLhlSGlEyMZAMNfH4l+3T8lqDVX6LTliew6+rD
 IhF1j8EZSeFJJQUXTY0WqP7l1exQ+43k5yl3STEUz455Yi0VH6A92HBxFRMZ5+lT
 /PPN7t7nmzrPrEnSEXA0x74qpk1jKoLd47VnejHBUedFt2sknn72+VzPQCsBaRQR
 pSND0NlHN7oJBh6LOg/xLX4HFcTbtaoDY5P3FhwN3XX2EtwxYWJhdiUI20JrsT5F
 4WNxae6Tz0wgXIcN/c06c/zBJQxTEjuZjmuHui3CIfDJkF3gCQi/+o8MhIDBkCrw
 maAV6A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0ghf03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1591003a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859599; x=1793464399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IeaKx09VkelEI+/lpmwVUc91Pu+1Q9ldW0MuIot0qVk=;
 b=OBj7hqj5H5jX3OgkpOO44pRXiRJICv8RrYv30ooFbzNpkoqyEGo7U4NbbuqwfO4OMC
 Aj5niL2FVOgl0tn3acBQyYH920sKUwfLVhXAmrXZKpZfc6P8uuzvEeEasWtE1gQ7NBGM
 S5g0eIJXHiUXa/lkoShyhfMxab6xYOIohx38yD3J8p9yhYwPwVpqNXgQqc2eVBjVljVY
 cEZI/LPti+CJAwQvZa1zKME5KJTkeI+vH7r3426XeEAnY0E17csN933AuhN2LKH55PVC
 eI8ti2hICdAoxtKelNL/YZS3SkPvuCbgXGZPnZna8jOCivRfT0UevBWB/1N3Xx2axMd7
 M5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859599; x=1793464399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IeaKx09VkelEI+/lpmwVUc91Pu+1Q9ldW0MuIot0qVk=;
 b=whhEf1eGGRGhjUQOB0WX4kaoDFFAdNq3RFStrgUnLkvQneFsyiCrrE5jlVjlwgFND4
 f4V4OH2hgGb5f1/CBbgc6GiQN29Zhfcth6nTkDhOr6Xnj8TgBVw241sMPHULRUbU2vd/
 jTWcVMa+AZEbtzVRtgIZb38aw+kCYizXfnAjVybuSeD9Re5QL7IHEmU34+zXGfTww7Rr
 EGjEvHBHnZZcW42trYsg0olyuYJNBV7mZvPQ9XR51xdvgPRoIrXBe4Nbv6xnARSCslPG
 PeserS1i1yitlpvA1Tg5WzO7wkK2HsbFsyGdztIQFfXLYPeda/IwYRMGczP0BXVxyAXz
 Qz3g==
X-Gm-Message-State: AFq9FYLrOVKty1+Co5h0KYylOYLqoZL7SaXeSnuVSoNGJCzsCED78aIG
 47uDpTB5Nj3EFXeNpoklEC/UmxtB30DR93WPESsdN5JaFmSrAteRwSd8Qjr8mIPnfnAz5XRR9J3
 xTlxfZTvW7uyB5XswvJcFr+SiY5+2Yn98G1zEygee7xjxHSdrG1Go/qAcbK6EOqEgRw==
X-Gm-Gg: AYBFou2BpkOmg9BA3+m1Of+0bSIMNTs2t3qQRQFXYoTc09gBbKXtsC9C72em4iMdu0B
 k5CxFlQjDvKHnYh2V5qMk6CrLfJ48E3+ylZ59o1YgeXieJSbOnSZ7nUMhrGXzxA+qK4WdX5R+Z1
 bPgOZIJ4FjX7cOnigGHwlr1G/wdvdS+BFD0MzhIGzVt3wz6HIyZb45CdaT1F1s0ArMZJ+Cof5eq
 u1uMaHM1Gkm9RbVx3pA1cc4J5QWVjFvrkMnb7EZfH3amTdz09WMSFXsvTk7MVrSRCFOaeWVTrfd
 UhzOrBXgvcWek1PEs83gV2b4e8WLJpJoE9ieAfeJ2h6kZnyvmco62mxBDrlbdnBnpV8xMCXsfhh
 pvvOs9wTpcvKi8TnwKqWDC0/bAZMcfOD8gZdzbVtpfFPw3Zo1f+BmDW5T3UY3W1s=
X-Received: by 2002:a17:90a:c2ce:b0:3ab:1b19:78f0 with SMTP id
 98e67ed59e1d1-3adead4dcf3mr2216419a91.41.1792859599105; 
 Sat, 24 Oct 2026 09:33:19 -0700 (PDT)
X-Received: by 2002:a17:90a:c2ce:b0:3ab:1b19:78f0 with SMTP id
 98e67ed59e1d1-3adead4dcf3mr2216401a91.41.1792859598644; 
 Sat, 24 Oct 2026 09:33:18 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 09/11] target/or1k: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 16:32:47 +0000
Message-ID: <20261024163249.77855-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NO4Coyf97t71sc-s0gfZW9CLMLJNDrcn
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adcddd0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=s0g2yuqVZqAqKHCRF2MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: NO4Coyf97t71sc-s0gfZW9CLMLJNDrcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXwtbw9nFxig17
 Es72m7qg+qNCn306MJCSCVrqY+MOcAmoE3FYHPuJdH5kPM/JDu8AAvXh7wtDrrZr4t06IDUVDvL
 BRvchQVrCDNjrXKQU/cAZEvtJs+7qD51z0wNpKXLb5Lh9ozPwx3ay0lPEoQrzr4fuvobdVtF8QJ
 yBKtDoR78r9Zh+5YXayHZeDr+MxBSGbOfIMQA4LgFQmeQ0wK63jfGuzbaGf5gAjHZTZr4XXG/32
 n/hlNveq3rRSZMj0lLNSbGs3/FWW3TiUMbw+DHUtcDDT1JhntEerAfY8G+Xjj2jNMbZ5lqC66wZ
 p8jIhd1O5F29uszkT9Scl5Hw3Q54OXZSMElp2VZOMhNPleKx4189PPRAi0kAfvORgJpovEH/38N
 XVEbbR8s3QLfUuQF/77OpaWuHKJiGQjyd61FNgsaMZPXJ9DX9ltl4OuE+K4gyxbIXmzEnFO8pgJ
 rfTS+cda7v/uYE5xBzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX421OywsQB0+D
 ZPZDCvXp1yq9CMDo0RpAx1I7IQ9gsYtoNgPijJBXbUFHk8n3Mr7KMVKaLZlDxo0YtLUTrzNpr5j
 z61b1JpUQPsy9RzL4BDYtrsmZSCnNH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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


