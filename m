Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED2CCDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkOi-0001az-2Y; Mon, 22 Jun 2026 15:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOM-0001QI-UU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOJ-0001vl-VX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFX1uP1370016
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iMdm/ny/73N
 EbE0ZipOIUchBEo+OzplpsDTdm9KL8GM=; b=bjex5AV3KwVF5F0U+HZ7/KtrgkZ
 GfItF2PDgFOwYZl5Txo+GKoBHjPb98lky16kNPyFI4To8PTFoUT7M1NVEZsrLas+
 2FNuyr9iThCzUXwJZGZDD5P6PwBv1TtWehSoMXtDCU7yYwKDulZSElXENwmf1rHT
 55+jAXiOcd2kYng7HXujFvt1fKz2Lbgu42UDqUsVCHQSa/FPd3ISplQt9017D+KY
 dy7QwwBLmL10hNAz8v/NDh0FvRuqWCbwcQ4nqC9XLMjEyW4VRAB4XTYJL+cx3qMr
 Qw5yXPwKnUs3Mx1dVpzCtT3zeGCzznBXvQRtkH4/ohOpoIFqWm6axKwVQzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1u2cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157f1be083so821182285a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156776; x=1782761576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMdm/ny/73NEbE0ZipOIUchBEo+OzplpsDTdm9KL8GM=;
 b=OAgNfck/Dqu5uG4IS99yWXZb6sQXXxgV9uXJM4WcoRmH34MeUuxzVE2JOMgKQBU+JF
 l+7NCRSKHnqD3fYmns/YDRxRRQ1w10yN2ebLIRQtHWK1rmbmNXT0Bew+7gwTRJDoyy9k
 6G72pQvx+MGHI5Aeb//eEusOsKszyUsSuDWHINf2Zb+uJ1iH9o0cb1uIQo19nQMdiQw7
 7DjOwI+1HNAk/ourydQmVRCTBDMejEQOvi66WC6uCHVwSrAA+WGGDtC57U1F08LpLdZm
 GOJUySPMHEfL+5RxndAXRdH35qQEo+3QGHbrqRLUh3UvRHG6efj77E7wzaRH4YzoWKYt
 8+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156776; x=1782761576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iMdm/ny/73NEbE0ZipOIUchBEo+OzplpsDTdm9KL8GM=;
 b=S+/PnPKXbdLWTTyWoafVF73Tn4ASYsnq3y0/XUGLghZufQ1XAVQUA5aCKnJs0Olgxh
 z9RW1qwoZnX/9MciK8ZPodLtXC502g1+R6tGY27D0Aal8wmbhhhplrEmImPohUto47UM
 udtbTXhv5YoK3Jt+YpM2XN7S/+mkRr+ysePRGGu/vvEqbG8D6xNukLZXO28027Hn4TH0
 I0hulw2Hed8e30DAktQSLiqUEN+8e3VmxCRYg4pClbvRKxLFdvmhibVsovQTM/vbzioR
 9mc9sr1HUnDJ7cs5zLmn5GxnYQdsXkVxnyusdlYqjnCjWZDthZmkv31Pp8S5OzQgtiJb
 sefQ==
X-Gm-Message-State: AOJu0Ywk1exe1lRO6vaAIbLGpAvKWSImltkfi1s2cw9i0WaLgErcujro
 L8RP0aKoiNVythqgm4Tj8c/mBYK5hjc0vYR8+9zsTk2ZDMShSBD8p4w05Pidiby8vPIvX8815P0
 KWWHd5OwRoXo0IvDpzfbMykhsrS3DGSyH3xnoPkx2FIYf485rvFM5Tym5ON2Dv97OIg==
X-Gm-Gg: AfdE7cn7TTPH8AJEt3s1K79/Epfjj7dP+v+15DW39M/6WwCA/EPEcC89ibxMvUKeYOy
 gt0Vbdk+OI0XAxC0cX4MJqSlTETprGro98lnUepO8sm2RtZB+jlRRfxkfzww1hiLK4xUWCgK1v3
 r8QQXlafC+MsdLUtXAyQHqGW9H+vwOfLd1T8qGaYK0Wq54zhfsm+fr//giPXFeJZZN5R20DRtrb
 //rqqMNlO/CwcWa9xhBpBaL7IoDAaiFkoP3L2zgvAgnCJVwgYYg/UmOxn3ikhkwXLmxAaRYl0pA
 HwWZw4r68hSEZEBd1nwYCTCMjGp4M627De64X40FkxgC6XNDLXgkyWGCx9WYZWCOBYxQsg7VhmB
 Eqqabv9O026b2W6ps7A4bp08yUqq6/f+YU7UeRSTo8YJ8VQ==
X-Received: by 2002:a05:620a:370f:b0:914:b9a2:f29d with SMTP id
 af79cd13be357-921d29fa263mr1584856385a.37.1782156776352; 
 Mon, 22 Jun 2026 12:32:56 -0700 (PDT)
X-Received: by 2002:a05:620a:370f:b0:914:b9a2:f29d with SMTP id
 af79cd13be357-921d29fa263mr1584849885a.37.1782156775894; 
 Mon, 22 Jun 2026 12:32:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:55 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 23/24] target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to
 riscv_imsic
Date: Mon, 22 Jun 2026 16:31:39 -0300
Message-ID: <20260622193141.1449724-24-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f4_Q_d9GuMMSfvylJPBtUdJF4_nIS5L-
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a398de8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=tRk87D2_djSq5c8C55gA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX/qUCknld80lu
 FF2HddgE8LC46l2+Em6vauVPbtvQJ3AK4vOhvm7WHcpm/bJRoRRlUNluuiQ7H2bVDWqjqxtRK+X
 FB8VzTf3JrnuF0m2ylI11l7LTH92bMo=
X-Proofpoint-ORIG-GUID: f4_Q_d9GuMMSfvylJPBtUdJF4_nIS5L-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX2DhmHmFMn894
 3HhKzjEzhXsJtQT1hOxMuVFMPSsl4WMj5IddenRBQWIKDPOwZqFva6mw2WkfvsaWY+qn1n7Vetb
 GymIl3vCqmzIz5Ov3YvnZkxyOTeIWmoZDLhMW+4Ho7c/TLHYsqOQnpmc4PGe2dMKa6EFWMOYR1S
 NZACBgM0UHrkaQh9WqDxUCUXVI1fErSICHQ39nSTspcAklyVwb/szEf6WgXrdd2OjbBzo6tXdiY
 FxAlD2qGEtSaFuK0FeJl+Z3lBIfs7ZOAD1CsqWdh2xRdiF+kHRMbyL28chTJWnpun6el7pR29Do
 ny3QES8pTDSHj2UrcPDxkJdUJc8FeiGPocvECtVtr7uxps+qo/4kdwgFGdqoikF9FynLXaj02TB
 ho2Ew4BOAlGgCG9IsVlv3tPo5rH/Pw+IvFRSKHLar2UzywDNLNnc0Bdz/65TIAjAMI3h/h4ldJc
 MXSda40xamq9TAVSnOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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

riscv_imsic.c is the only caller.  Having it sitting in the TCG only
cpu_helper.c gets in the way of --disable-tcg for no good reason.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/intc/riscv_imsic.c         | 11 +++++++++++
 target/riscv/cpu.h            |  3 ---
 target/riscv/tcg/cpu_helper.c | 10 ----------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index ebb55191c7..d6b46cdca2 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -376,6 +376,17 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
     }
 }
 
+static void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env,
+                                          privilege_mode_t priv,
+                                          aia_ireg_rmw_fn rmw_fn,
+                                          void *rmw_fn_arg)
+{
+    if (priv <= PRV_M) {
+        env->aia_ireg_rmw_cb[priv] = rmw_fn;
+        env->aia_ireg_rmw_cb_arg[priv] = rmw_fn_arg;
+    }
+}
+
 static void riscv_imsic_realize(DeviceState *dev, Error **errp)
 {
     RISCVIMSICState *imsic = RISCV_IMSIC(dev);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 65d77842b2..e0836c986e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -677,9 +677,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
-                                   aia_ireg_rmw_fn rmw_fn,
-                                   void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 3a4e86f6d6..2ec1c3f079 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -590,16 +590,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
-                                   aia_ireg_rmw_fn rmw_fn,
-                                   void *rmw_fn_arg)
-{
-    if (priv <= PRV_M) {
-        env->aia_ireg_rmw_cb[priv] = rmw_fn;
-        env->aia_ireg_rmw_cb_arg[priv] = rmw_fn_arg;
-    }
-}
-
 static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
                              bool virt)
 {
-- 
2.43.0


