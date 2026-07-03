Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CFFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiJ5-0003yY-IB; Fri, 03 Jul 2026 14:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiI8-0001zy-GI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiI6-0002QE-RJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiHSS494256
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0BdpKklJEsZFSAAVVOjqk88FpFD79mj7L+LnUNk4zJI=; b=XaCoTdUnrYqJPJNq
 PYkIVq/22gWxtUWmOHI+W/XM5oU/t0clOH5pSWuqN2ZS3w3dUj+1ebcHSr3XVUDM
 gpkcQwuL3hXB8B9YhJKxcH4IdzjanrEn+XOA0t3bOBaOqL+gfmPrBQCI6Ur4zExb
 X4HbMIBSl7TDKtQbA52rr8QK5Jt1uFlsDur83nmmiRs7NyQZFIJdhvBK0S5B5ear
 t0pKtM5XE/vdg4H9YE9hBIT1Bu1WcKoU4lH1CFqRmikNWq4Af1tCvyvqei3ugiQY
 L/JEDseAEz9K7QnOeviupbO3a0oF1vz5jHW6tSBSRg9tEKHMDmqFwehF4C/DTzdR
 d5TAPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyta4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso17044511cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783102014; x=1783706814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BdpKklJEsZFSAAVVOjqk88FpFD79mj7L+LnUNk4zJI=;
 b=dQxP6RDhmo0mZGMgfRcUY3dTNuaSz9BiliP813ubBaNMDsTuZ1YfWdEYonV18Y4LKC
 YIEs0NhJpPEFDYRKGDtjWXn7ThwcuzemFCj6+8YZrLY/me3HOCDmY/q95jrIwdKO0BwY
 WqWWLgtOcbjEfxVrDvHw8dlWDwHEcvAYswBumNgRmuGKgWKldZkv8DishZCL0gSlLiJR
 HzjZtxec2uiPDF7rFXxd/cqnvqo91sJrMss9M7JNjcuwjVlVsBhtmUPuPxyGfGEHKT8v
 S5gxGSp9gKj5TWadgwBxI1ZIdhr7nqQVbb/s3G3QXVCetB/HjLxliBFWmIbuVfG/UdHC
 QqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783102014; x=1783706814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0BdpKklJEsZFSAAVVOjqk88FpFD79mj7L+LnUNk4zJI=;
 b=n6lmdMD94PInpXINtBlIQF9curPk512wLwVzK+Xo3jIq60Jrbjm1YeINa/J5Kn2fnv
 +gx8+w5QBzj4x7PLuT/DvDz3K06riTCHRNsOpcrLqbQYIowrSyGSt8N1yXXgYxkxPL9p
 x75UWJcaYNZnSPKm1KxsQlEgZcBqlUGCPecu1TknM2sfMUhVCBLy/ReEwMsvxBIE5qf8
 U03zbslebeFDHkUOyWASSW2Lq7E0mDUFalBoT/IZpFjNHpn/1BUSAABWo+Fc2wj37Pg+
 3Ok86PqtCpLlD8+Pmdt/JtsgO3kMTL0xRmbkltz7v5vSyZge+ZY9UF/FxJX2YYP3ZWSh
 114g==
X-Gm-Message-State: AOJu0YyyWFFXKPqQl0YX4UxK6YP4+TfyO9N+IBHhlCZFVsoRhJ4IlqZh
 VaVoCkO+6kRj5pz88NiesvUcidDeH9sgVZrpdWSJ4wcwRPsKodcdxrWRfFsNqOfNEEK+itVLCHX
 42X8kqkeNUbTrQW2K64njsuQlyzJEG0Unrev1YnO72OgEEdGrY+OaQDxM9GE60y/tYg==
X-Gm-Gg: AfdE7clEu0bzSwkniOdTHjJxT5rxXYSQ3UAL8din5AsOCyv8wgF99JL1hh4BaNIJcQB
 AucS4zXhIRhnpDv+MsJVgzFoBr93mCgPySYm05bi6PXPKcgPZTliDsLrcF60peh0f0bN2bEVtUO
 yDKT6N6TFqotAgo2y68NQ3BhvehJp1qBBMX6nYm30nsOXMlIycRmz73NnecNZ/V2U0+3qUlYOI2
 99II2ozJ4QNzdOyt3/UJifGCkrSAduwXxSFFmK05baT/EFbqzGIIRw0maEkLv5wue5yMxKN7erN
 ag3+IfFg0GFhDoaH6SweG4DtgM1QyL4gwrXWfXgDm+ojo5DDb8is5+2bygZpsO9LpFoL/taHvLB
 En3s8Fa2KFC//VJ+yfT3ebhedXS1r5hsk4jd0pXktaPFCeg==
X-Received: by 2002:ac8:5906:0:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-51c4c1f1d3cmr9043631cf.13.1783102014385; 
 Fri, 03 Jul 2026 11:06:54 -0700 (PDT)
X-Received: by 2002:ac8:5906:0:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-51c4c1f1d3cmr9043081cf.13.1783102013959; 
 Fri, 03 Jul 2026 11:06:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 23/24] target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb()
 to riscv_imsic
Date: Fri,  3 Jul 2026 15:05:35 -0300
Message-ID: <20260703180538.3346781-24-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXyr0rRKwfDJIP
 +vE1LqaOXHT0MttC6zvKL9+ElY3ruKmZOoyImpYLJKg7YifP85v6BQKSqkF0czgTChfKaGJgtVN
 3MQ9zNin2qfnyFduzeoiTC7F6yylcPkU+qTRFCaqQdDKO6Oc6F585yTcm8yIVO8QnPECTT8F+VU
 Xwxo05mhk2I/Yc0AmwFQO8M/2R9JPklH5CM/TM073/P924CazyE6pQyA8+3x3jtVYDgait3nnhr
 phBKqyUlcCmoSul2KSFM5FTVZ+iXhClzvqakrSyI0709mHI/tqp3lwDjniyd4Q3GdhXSRGkFABH
 saTRp9+zbB+BJK76mVI6mgxRGNz5gVggPXZiBf7P70Pel4qyk+Su58r9TcYwsL3TGzEHG9/DaZg
 KzTO1vHU1KkrM2Kg909sT2okQL57+Y3PQl6GHncpVkQlduWpKdAdQ0JNgcHWSP/7BLlFw/4uO21
 bMVSnTO84P3ZEbCkWUw==
X-Proofpoint-GUID: MwAd79CuUAUc2cgo2UzhPA1MRl5oU5hh
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47fa3f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tRk87D2_djSq5c8C55gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: MwAd79CuUAUc2cgo2UzhPA1MRl5oU5hh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXwpl3Kt2ruQIv
 PxJiSHAa9+Y2Pm7+AZmA0aTEWqF179/zdETdF7u/fvx3EimPC0dQiJJbffejwhZzRLTFmpogwet
 m37sVPUqPofeElh6eLFMKpmNNM3wzzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
index 71a96a20ef..07d9222652 100644
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


