Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00683CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9z-0008Gw-EI; Tue, 23 Jun 2026 20:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9n-0007xe-MT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9l-0003NI-Bb
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwGuG695863
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ouV5MqYWAmtAndi1dcMkZCZv9z3hKC7UIjKZVhs6NcE=; b=ParsgdvWNuuaRbiZ
 NJBi9+e0qERwpJ7LgRdp63uHd7GNu+x6VwOrLXhs2uCU3l9KucfpMtU4fcSty2Li
 d0YlRyTyIyUj/VGDoKXey10vQZmG7t7hWWXccxzu/O6AGylCQh/BYObDnF4dfnzf
 LXDr3IvqlHHcyfLul8N1gOuWLl6Oy8hcfflakaR0P04p4vepZORmD1AIKAAChzzj
 3iyck8uuyOlRNVyjs1r7ayGAEyeYtZuY/vzVeYAYXHJkLSs++G79BGPGTp5U/GCh
 hBqc7R0G2Q0r1N9zka+2AxO0R28n20Lebz7cf3UmuR0XpagYwxCTWC75z8cDHFsu
 Rqc++Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00ev8qsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dbc0f048efso10798636d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259670; x=1782864470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouV5MqYWAmtAndi1dcMkZCZv9z3hKC7UIjKZVhs6NcE=;
 b=KEMq0P4/yiselAFysq/e0SDZ+vCVBdfh35SNAO0we4VwGg3h7Z4Y7xkv6a7vENdjYk
 7WkrdNaAI0WG1H5e9htanLmrUFunf1KSELzec/JnWCgO21H734d0lWrHLhdSwULfOqhU
 as8vBs+jUOZFmalu/vz/Y7zqJceZAu9TCOFm76P9zXBTF7UJAjJ5HghGE9Mk3lsxfTdR
 OS/SFC9uLgpv32/1hWeRdR+BxvYpBhp3eb0Py1uyl3D7hzUoKsfarLDCEgKVZkh9FUhr
 gRGBeqwH9xUjRHyAxF2tTYEBB5Bp4l+PxmOhACGM+co4emsJDcf//tkiQ2kS58hOgUps
 D/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259670; x=1782864470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ouV5MqYWAmtAndi1dcMkZCZv9z3hKC7UIjKZVhs6NcE=;
 b=GaY93p75V++X3zae/Oky3ZFi9B0XHTaWuECAiY5/+BWVpDihyNMfDnP9xIG40tBF/F
 ef/WAkUDzSRZBjRpD3g870Z0832hB9Qyo2gYnuKKOhafSVCcXuNdbAby3ALIdBVEUs4l
 IfDCZF2JcZlzg69YIFcZ7vHrKJ/9qtuNDGveDxeHdXiTWqYuVXKTyuVPsW4cd2LoPseO
 i17YRJW1lvidUftOBYIkPAP7cYhqbaaQ6CTcfdyq7ZfGoDRdJgbweFobt1f3ckErM8Ht
 6PlbshlPOYPG+6T2oqCu1gZRF8LIfnrvAf10ciu49zJY77ph3OsibPX4CNKDVXFyRnuF
 LQSA==
X-Gm-Message-State: AOJu0YyzCm0wlFHpWzUQamJW/UvxeM97pR/6ph9FAdUmAsMjofxtUtkW
 wMRokisHOGAzrilflwXj7cCkfSK2lf1PShEl4VJ2l7bKgj0f4cW+2Of/RfLGnhBin3zSS8YmNWc
 q6Lcta0KSFlTocK8ckbpdh09nNuDyvNitWx1e990d9KCRIbQdYoTDOP4uKPrSfpwLjA==
X-Gm-Gg: AfdE7cnasF4mLERRs4C+VVHiAMrUWIZmJWkhX89kWyGCfkHNtbn5HF/n182kv7Mzjtm
 z6oVlDZnWtkvADUIFVt6nqZnzpSgRX+q1MKN8l1Tr6vRxWwvH6seE3FECEXrKHOu13ypkS+0oLi
 dUVaUBreXgTWlZXLjqj7DAJenob3XRO23z5Y1v6eJIniGtCvU0lLr9+SBCcp5YBNnKQlUOu+gw0
 7wG00OzMlWJ7M6JRO+Jz7N8MBR+FUWhV9pVLLW+Xi9LwC7QDy2n9iK6usTCPXkhlHjIXQQX7nLJ
 YmbkjHfkrlXkASzjMvOHBcflIw3Vom/BFn+X2yktYAHu+czn8icr9b3AwqHZBWrOnhKDECqHeFq
 oy+eR1IObcFcDMBWS72ans19DvfKZoKdRVbK+ZBIWjEfzYQ==
X-Received: by 2002:a05:6214:130f:b0:8bd:de6d:c340 with SMTP id
 6a1803df08f44-8e52fda08fdmr26382776d6.26.1782259669956; 
 Tue, 23 Jun 2026 17:07:49 -0700 (PDT)
X-Received: by 2002:a05:6214:130f:b0:8bd:de6d:c340 with SMTP id
 6a1803df08f44-8e52fda08fdmr26382086d6.26.1782259669340; 
 Tue, 23 Jun 2026 17:07:49 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 23/24] target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb()
 to riscv_imsic
Date: Tue, 23 Jun 2026 21:06:30 -0300
Message-ID: <20260624000632.2149359-24-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX3Q2jMDiK0jpw
 +UdUfWLjKddECJD4PP5EvDA7Qebkz4sdNH9rxRnnPVsKw51grYkLkdj4Ya9TqxULPcx7Jqk7ttS
 fVmIb30CvYnF0znvZ5nHlTftcwlHVOw=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3b1fd7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tRk87D2_djSq5c8C55gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX5o+RLpkVw+sT
 vowpVH3JZDB1TtwGF5D7jq3My9wSb/DjwwaBfmsoEChaWz/FZjOE+gAxLcNmAg5Q1E/xlOqvj6+
 0NpVbAkEQ4+a6fNc+Bh+6ZJv3fS1eDJD/IE450lR4Rpxg64W0y088A+S99ajrVcXC9JL2J51G8P
 mm7IgEnguMoj3mbgoaOfttD8Yt4o+ccAo1FZ6fwg++Edo7LskSuIbC0OXWWfDBrOZSFYhtqmCln
 xJ79X8b4mTsabFlMivG18rrsh7vuLbLNU17gFcj5/tXKjSWHO/AqwSVkCpKnancembvwbVpcOlj
 AoZcf/XYqo0TuNLy8ZXVPK/vYvkKRSG+O3+vjP3Uv1sRMJZp7Ejq1Plz3A3W7Ysq7icq177yxSd
 hH/fGCzP5SKQ6kpDcIM3vPZXSQRZGg==
X-Proofpoint-ORIG-GUID: y72tnwqNiGPbQpBncVS3ieny31Qeyfm9
X-Proofpoint-GUID: y72tnwqNiGPbQpBncVS3ieny31Qeyfm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index 7a4d8abe07..c9dfa7daff 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -680,9 +680,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
-                                   aia_ireg_rmw_fn rmw_fn,
-                                   void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index a5d864cd24..e0306d5d95 100644
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


