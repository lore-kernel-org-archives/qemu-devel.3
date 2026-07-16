Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7F0C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJo-0002jv-Gb; Thu, 16 Jul 2026 08:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJn-0002jA-AF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJl-00074u-PA
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiOis2518328
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EwwBYvHtwOV
 uP6r29PDkDTpXbGkGPBuCEacn7qqfsz0=; b=TNr7l98osvHvTOMGHPYcrilC6P4
 lB2+ANSpRyT92PUI4XlBzP0gyHcVaUdFPIgWOSB7AJm0Lk5ncFHodEl6weMr1Usq
 xY+nuOP5FJRz36S0M1rzi0hHMgCEGdaEtOEvtv6SxY3UB35COwutCtCvnzG/I2J2
 jDwsnhtfgNneabRQ4hPN09z9cOPFvxDuXG62Ebo7x8bE5siF8b8Y1EIy0kUu06hn
 6iYb/4QIz1ptnygavxn4t5NYg6OmXqmy4K8IzrWs0ny6KgLgcPFPOd2c8iktLbJw
 tr09QQ84ZjDleaYE1R4WYT+fX/aZmnOD3+yf8XAU0xTeH2kCb8XlMIwID3A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv0ss3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ef18406878so116635836d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205356; x=1784810156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwwBYvHtwOVuP6r29PDkDTpXbGkGPBuCEacn7qqfsz0=;
 b=XUv/M7hhni9YKMWRZrtbKWoiI4Tt0rjhfV89WhEonWA9N9b2rqxJAZfX99gy4u7V0W
 8LK9JGiVAIKQfAUmZroGNJX8/yt3WRJQDh2JynSiICthAnI1dvJXGuPMDeg3AZhiETwV
 xo0GELNc5Zjk7q1M9JeOs0lcCP4U0Qla3lr10dH+6wfrkSLrI02CG0qH3k9lOdR+SDJE
 btjAtbITBPucJn9wrsGJRhXRXQb9nC54DulPabLDOHZtzQt+NA9uDnOeJWUt12iGe2/c
 0LepcABhE+fPQvXa3fTTVxItijO3aoVNoxcS5h95SfbMS8FV3QaIptkjYIR/5tVxVVav
 QyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205356; x=1784810156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwwBYvHtwOVuP6r29PDkDTpXbGkGPBuCEacn7qqfsz0=;
 b=Z8xYaWVHybX4yvAz+LKxZLDk4Kix6icYhO+rwagfK9AHdKhrhcm4k4/kDHp1Ki6RA6
 /E90gFI96X8mBBzx4w24F6EOeDY97BfapxizGpqeYy+hzY2m+uD9MgBdfOtRw81DpIws
 nZeRQvv9i3T2LPWKqAaKP8bWxfZe9v1CwL5wqyYuD8U1Jr6pUo3MGwHjOKxhUHM26vZA
 9l0VqlHjRwey5sSXQ+Gqz7+PhJey8sSx+JBjv+DMF2atwSakqng4czZiaFWxMgRLFQgH
 PWZQQy+7FlszCEaTYMF0lBDLnrKwMsQHPifOz9yByqN8cpj7a9JpVRYkv5Uc5WWtB+Lq
 8PqA==
X-Gm-Message-State: AOJu0YwBeJKy0zHGtbooMzcKKW5BgSBgTyyYnWC1odvdgATvM+gRrUig
 8XptpFKQLCZqjyvB8rYAmSvnRzpMxq6gv2GABHalnr2rLVuB+uNZqPP5ASnXJ8/gimV9WegLBaj
 38lBiRpQy27fMawddG2NZZR2X31Qv3QYNT1z4a0spdvYfa/he4UI8B9ML+1xc9ehl2A==
X-Gm-Gg: AfdE7ck9m4i8cZoxEtyBNwP6Hl5I8VsCtzY4Elpl56IaBJPtLTRFv50SG1bgOoWbjuQ
 uf5wGuEN370r7LL8l/Yt3T+UVkx+KBbesHlcNAxeeZVGJPZXqIJMN0HArEem8xeKlhLGX+/8QRc
 yrOBA/LUudJRQRlGEkhnGyiJMnhQCGPbdtAF7QitVoZScOId+AI4tcMcBcGIcQVwLpMoAKvQiuD
 6DT/2n7CXA5ZIkbzDNBtk1EQ2z2tO52JN5/PJHksH1NmdEgoVph/IdMZqSseCLGUdXGjuE90yK3
 oC3H8fdoOFXGtYrj3gPn+FVk2r5G0WtDIbG20jPK0huDtwav+kNu6RqV7Y8IQbWS/G2Jjn++0H0
 +joLL6nI3wTfp5TbvFBHghv8T3JXr9YK4iD8=
X-Received: by 2002:a05:6214:310b:b0:8f2:d87e:29de with SMTP id
 6a1803df08f44-9074c7564d9mr135326796d6.27.1784205356060; 
 Thu, 16 Jul 2026 05:35:56 -0700 (PDT)
X-Received: by 2002:a05:6214:310b:b0:8f2:d87e:29de with SMTP id
 6a1803df08f44-9074c7564d9mr135326196d6.27.1784205355475; 
 Thu, 16 Jul 2026 05:35:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:35:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 05/17] target/riscv/debug: Update itrigger_enabled
 after changing privilege
Date: Thu, 16 Jul 2026 09:35:22 -0300
Message-ID: <20260716123535.3709148-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5VoXC6E0HflX
 0QcVj8ZrYGVswIzig3MLeeRCbE8bPGZTC+NAjwkG8puHnqcqc9IcmzYKXIrk+paUatQJGuOLJu5
 5zHEYX4sml+qA9FGKbhVG5SjR5Vy7hhrMToa9WquV97X1Oc1coD3ObtHWsujeoddRJ1NCPbdqsV
 LXbA4Zzrs6O9nofxxXgWwX6WIf9Gdnk3A+ysA/vZgahCsTy5n2UgQ3iYLsb8zIEXz4uv/ASo+ij
 cKep7KWAR3s8YhVErLz7rT0c+DTQiGfVmxH53FbhzFBADOUGzj5ZLP6tIH1WBlQ5SOoaHcOpmdc
 u9M1A+KtchUJiMMXT0tWpsIjndgCR4sK+KODBzbXLo2i5P+phQqNdO3qEXS4w7klOliNrp2cw2J
 we4836go7pRmL9GUV8XBsrgKBTy+YX9JNylyLdM0PgW59Ds7BmFZeSLBYefz4flcjSBHA+4vPRf
 0H3QuHYoMuUC75PSTwQ==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a58d02c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=iX2v3MgVREIc0uGqDXMA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: Y6l9vfCUyVU4OKz2A5oKG1-vI79tp0Xn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX4oa+vnjTMXBU
 PocC6RJ23mIx9LWNGs86wJbs3H2kykpLKvPMlI9pdCoMIb8Srboc8LVEVEGULInZu98f4dBIrSI
 JSaQMBABWEkAS5UD2rOX5DrLVBRLYXU=
X-Proofpoint-ORIG-GUID: Y6l9vfCUyVU4OKz2A5oKG1-vI79tp0Xn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
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

The !icount_enabled() path should update itrigger_enabled after changing
privilege, which can change whether or not an icount trigger is enabled.

Fixes: b2d7a7c7e4 ("target/riscv: Implement privilege mode filtering for cycle/instret")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/cpu_helper.c | 7 +++++++
 target/riscv/tcg/debug.c      | 7 +++++++
 target/riscv/tcg/debug.h      | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..6c18526c49 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -844,9 +844,12 @@ void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
 void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
                         bool virt_en)
 {
+    bool change = false;
+
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
+        change = true;
         if (icount_enabled()) {
             riscv_itrigger_update_priv(env);
         }
@@ -889,6 +892,10 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
             riscv_cpu_update_mip(env, 0, 0);
         }
     }
+
+    if (change) {
+        riscv_cpu_debug_change_priv(env);
+    }
 }
 
 /*
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c777694e5..a0222e178b 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1121,6 +1121,13 @@ void riscv_trigger_unrealize(CPURISCVState *env)
     g_free(env->itrigger_timer);
 }
 
+void riscv_cpu_debug_change_priv(CPURISCVState *env)
+{
+    if (!icount_enabled()) {
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+    }
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index a25d099b37..88d34ecac9 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -153,4 +153,7 @@ void riscv_trigger_reset_hold(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
+
+void riscv_cpu_debug_change_priv(CPURISCVState *env);
+
 #endif /* RISCV_DEBUG_H */
-- 
2.43.0


