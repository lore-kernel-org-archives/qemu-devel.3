Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2C0C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJz-0002n5-EE; Thu, 16 Jul 2026 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJx-0002mf-OM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJw-00076v-66
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBj3hX2622143
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YUymcoiGygr
 awRPU79MPQT/fYxfZNvdtdM4e1c052sk=; b=bFkyTK3RHIqHaC/2OgcdluKC+6O
 aXVg+w5N992toTIrFT5oeqW7JKQW9G09WeIv8nYCPG8AgFJqsYom1Kn7tOUYJji3
 W3hXKc9+ACeHF9V1aR9sWG/TPlVVSsytAOdqGnceir1CajyIrWeLMJwvPn+0XVuj
 eNzXkklpZPEDh3dBVApYT0uuoR87EiMv34xD8RtEhcXLXoxXPiKxHwOKrqHKcZrk
 zQ0kE030Qza5JGLms6tCQVAxduqzQX4d95WauNAl7aFcILHITkejqBYwcH249cEJ
 ZeGOHWycbJ/slHFGKj4+clSflFGMTj9Mz++ngjlPj4FtB6JBEm2BvILHpag==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqktrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso83867046d6.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205366; x=1784810166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUymcoiGygrawRPU79MPQT/fYxfZNvdtdM4e1c052sk=;
 b=Q1Ay7JqczVeRDNOvOTyIgnTHwbiKKuP3VG3T0WVpp8az7/icTFI+bOayEO5GBTRWau
 6tjqCMOBNPDZ1k/yDzUFuIBPvl5Sqf5V+LR2jfW2QDHlu5SxqfAkOus1B2pHj4ApZXoU
 pX5h/RskZcPtvf3aoN7+0R29ujEgadWkBqRlVPUSlvnaZs1P3JUWT5koMial7yhb1R6Q
 dySrPu0XQzY8Cv3KtjZiHZFjORgEWstyrHjDr0MV/qGEtigC5y/+LPImFkPC53QTO9dM
 IeljhNeGUd3L0tTu7BgXG/9Wgkb5XjhSo0HxDYFor/rVcwhC49HPndk+lIYIWcLXSu/b
 uCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205366; x=1784810166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YUymcoiGygrawRPU79MPQT/fYxfZNvdtdM4e1c052sk=;
 b=GXQp2mnt3K36RIUd7O0zweTpZyrUlAo2bRBC42WUeMsD4XielCgUzGyIC4QlqxQLq3
 sz0KUrJrau+Zd9fgrwJ8oaHqM6ZaajTOFk/3HRNAZpd5a7kDp1ZrHjcDaCV0/0vwAnwT
 36NM2c2Vcm+lE9+Zk6HlU/uRdEPSJoMEWjdXJAi9lImqC37Y0hGy/2F6OdNd07hv5F6x
 uNH7cQTuksREpKOdte/b9ijGhGMEbLXL+IHO6siyzTuwBy+2nSGHzXvKO/dWl8VSi5+U
 xe+s3OKpcspl+m+Qks7bcpD2CbY3f/qf3AG1ViQdWO+636gDvTVCGYmz5+MVWevI7L9m
 6h4w==
X-Gm-Message-State: AOJu0YyxUtQ1wHO/1NBwXZYi++vz8TzIlmV2XrtS3poqXKl2TKXcq6VG
 QwxchX02K7DjjABz4P4LMPRgNJjEe4JvF7V90fNw0zk1zXT5+DYlJlAgW4rFSms1jStb/BvwtoY
 DnV5BP0QT0ojqB+BxnjePCKdDL5GgA+dY+6PtX23TSfYqWkchWIYenoWA/+9GdJHRWw==
X-Gm-Gg: AfdE7clM+UQNNLZJK90ilXiC+oZ4hF/upYVue/8KxG7/x7MpgVTdNtxA67rIXmJNfB2
 cOv9WQFSIugAT3nHNNZu3SK8GchE2I8SmWBQHTPixSTXqrIhBzyRxO6cGo8R3/wIUUGHRpe9mbp
 /bI2cZY4knWBFEbYwqkQwPydMPHIZ+3W/juHwyPtUiAD4i2KklRvpHoqnEqBMJLyXx5eyVJVqTD
 WIxiQluXS1Pf1FZHzzHWcgMzf6CRapqRvv1gvrm4vfsnqJ9TMGlbC8Mb3IKo2AhWMs26V/KrpQm
 n8XCskFNegqCuhkRE/W4xPrf/IRNXViJkQwToKoHjCAYvCudaf57C/1S/VTF7XjgMvwi5TGf+0S
 nkGJW8TSi7NMSCooiDz3ZG5iNhVm/j0/q3jk=
X-Received: by 2002:a05:6214:4598:b0:8ef:e857:c9d6 with SMTP id
 6a1803df08f44-9074c728839mr136151126d6.22.1784205366422; 
 Thu, 16 Jul 2026 05:36:06 -0700 (PDT)
X-Received: by 2002:a05:6214:4598:b0:8ef:e857:c9d6 with SMTP id
 6a1803df08f44-9074c728839mr136150346d6.22.1784205365796; 
 Thu, 16 Jul 2026 05:36:05 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:05 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 09/17] target/riscv/debug: Maintain itrigger_enabled
 in helper_itrigger_match()
Date: Thu, 16 Jul 2026 09:35:26 -0300
Message-ID: <20260716123535.3709148-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58d037 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=oNqV0Gv4MAO2-P9rc6IA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX2egt4Bh36uWd
 THJ+zDCqvLXV5NQZHPcr0dhQp5Yv8WDCFg8DEv5+br1NozqT94W5DJOWjs3AVSgeV2w2wLAdGko
 AauqVc8DqqnCg5GbYFU+YuwPmeIGVAk=
X-Proofpoint-ORIG-GUID: ZzY6YGbAYg_v_YbsgtB-60jvkFYtEWQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5k0SUSj+tw2W
 T9WQkKzX4IxB9NdKGmmVfHV2n7BCosjbmXUPoGwCGPL/Gm0evDj5HH6LCij8N+c2gQ/+rZRRd98
 IrxMKCKyvCSlGfCpMH0ZTZLp4fLsB4uTJJh4Fn27r9ZEt/uNuRzDxratofwDEj32nzdfyZQSQgE
 4xzBGz7mfSHWgo3MlRuh9AFLbMF/LIGYTM/EJzaynos7nS1WTCnmJWLqsMpMS2nMGsqeX+0tn0Q
 yu5LLybfRBy1tIHSS22kizyJLR0pPdndN5Jdn0egDHVQEYwXScG0uv24NO1a69BGe71z87SS7+e
 Y2E44Y2OJU59LVcYDa49IjwCOajCuNpqkEHtAJsRmSJGjWeIh49GFEms8Df5dNjy5E9joyHa/sY
 RIBnm13+BPOI79ZMoqU0f0vTh1yn4EvspH+vosk1WRaXjIFygEokG8+TTbYBNcCgVQTHke8TTv9
 F9n6kyWzPATLdLfq23Q==
X-Proofpoint-GUID: ZzY6YGbAYg_v_YbsgtB-60jvkFYtEWQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicholas Piggin <npiggin@gmail.com>

helper_itrigger_match() iterates over all triggers so it can maintain
itrigger_enabled rather than calling riscv_itrigger_enabled() which
becomes O(N^2) where N is the number of icount triggers.

Fixes: 2c9d747121 ("target/riscv: Add itrigger support when icount is not enabled")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 74f1739697..d98e737763 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -695,9 +695,18 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
     return false;
 }
 
+/*
+ * This is called by TCG when an instruction completes.
+ * TCG runs in single-step mode when itrigger_enabled = true, so
+ * it can call after each insn.
+ */
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
+    bool enabled = false;
+
+    g_assert(env->itrigger_enabled);
+
     for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
@@ -711,10 +720,12 @@ void helper_itrigger_match(CPURISCVState *env)
         }
         itrigger_set_count(env, i, count--);
         if (!count) {
-            env->itrigger_enabled = riscv_itrigger_enabled(env);
             do_trigger_action(env, i);
+        } else {
+            enabled = true;
         }
     }
+    env->itrigger_enabled = enabled;
 }
 
 static void riscv_itrigger_update_count(CPURISCVState *env)
-- 
2.43.0


