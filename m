Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8B4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHqO-0003Ce-Hn; Thu, 02 Jul 2026 09:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqI-0002vs-71
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqG-0008Hv-6B
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0aM5416486
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0BdpKklJEsZFSAAVVOjqk88FpFD79mj7L+LnUNk4zJI=; b=DVQTSfmHzQhhNPx0
 AsyZjlMPFU2joGU4GgGcoHtw7lEJSrNqnlUH8n9yIkgovRpg8gYJOL3V/XksEQ79
 oCB6+zL9U9rumaEHRH5cDoeryo/BVYnfLcnGuZFgtLu19PTWUNvFqW28BdFuu9xO
 2E/O3AkPWylEemfISOzOtFrwH/IXiaAu+PXMZYuMUsgyE6rZY3kvhc/SVWCdiGGQ
 mMV7RgeT5igr+WR16NP9Ecj9clF/VVg2QwN9GQVfjrUTSF+Ss8UrxET852ZtXTug
 lYwnh0QGZHdU2VvrRBxIOne2R6mqjCal1Mnhn6R0wKYgyaEXxcj6HzvAyj5TN1cD
 Iw1pDg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9411y6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:34 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7389d239cccso638787137.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000354; x=1783605154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BdpKklJEsZFSAAVVOjqk88FpFD79mj7L+LnUNk4zJI=;
 b=JDlZSise1dbmUd1MegKMLKN1zXoOvUueo3GxGH6i1FT+iERoLRbFpZoEIv8JvjXPCe
 RAPahEiupXYtUmzA+f+fhYnSGeI9OV9yxHLhDbnMoGHfjS33srr/phS2FyxwyKmQj8GE
 6M5TQnzFfYW5Tw9SzEcmhM6U9sUqE4VEfBgk3sIUbDSQt/ZdlRjhLW1CG7lrEF+jYAkE
 4HvVzH/7xQGbxnQO3ZzT3NuoxEiHLwVmpQy/GwzuWWqwgolmJZcCpHJXtneHMZqt+vii
 hCQoUzQj4SLRf1Gbrg+VtpzrSbk15ubzQauB21e5fzGEK2NkOz4kOwcTInPngXmymqop
 Qlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000354; x=1783605154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0BdpKklJEsZFSAAVVOjqk88FpFD79mj7L+LnUNk4zJI=;
 b=SH2a16OwcGhe08uKtKe/fzb+hPai+otKaeIDGszx6CyATJUQ/hrsJIkUO0mOicZzQZ
 xzfZ8I+yA3nT0RVIZj4eUa3XK79HsGFyb4Wc5XhE9fVUQc9zKkRsdq8vfB0wA6OMMbP5
 nkzmIgPP8so23woocmfOshmIgH9i6vic8M5/IEVyP4P0NVVY6UR++kbjd3XkbV6B8yR2
 FAQnFpf97i+ojM/99prJCOBd8v/GA9qVeyESnAZLYxwHIgQrmB2yk+EDjBr5yl015S3A
 /v2phXibBdoxzu7MzZuYsUS/KFIVKWQpBR7r84GyoSIl0O4mFxVNPdYDcJVeiKrRC1/s
 OSKA==
X-Gm-Message-State: AOJu0YxehemgYR+zvtue5n0UUDAhDYZgqmi9OIo52yNd9H+sUHQ3jnJA
 zgDjvIYPm6M2NwoXDWEnow15p4QBL3Dxsu/W7OW8J+E7oz74WDIlEssqlrtl/axaRqwWr18zGzw
 g60e+LiH9ZKdk4pBAZ9bMSUmoha9gvzABHeb/VurwCcsm/Y9wTuhhgqvxmXII6TsoEg==
X-Gm-Gg: AfdE7cn7NVkBzASDEsqrTOKZA6na/b+DjMoR9jdfJMiCY0TPtWQSOCqDd5700rELyY3
 D9OMPZhSeMK6cw96atZopn62niLrMlFWANcI+zOBfpbpI6UwKLTiP4C2CdGDUhwCoNFsJboUOYn
 zhZqr5b3gRaQ7C0Axce/lK66HiWFI8Gu4wSVHqOUVpaI+j9qyWaxynE62fJQ6ggM6KKKkPGdvcm
 +u3riIuT3b87GMltOb2EdyWSXHwjmi5jl81JRdCWPh37yAVTq6LZFF1GWT6ORBa4ArrPSko3zlM
 smFFptYD3uJWMjU58pZoF8QmxLUgdjT5oBiQX48JosaFZd1xXbD0DgD4cJyWzSx6lX+VkEOtRoT
 xGEQNiulPyorMhsWXQX/HukzT5kMfiFo9sSwOImi8vzSGmg==
X-Received: by 2002:a05:6102:e0b:b0:737:ba2e:8a29 with SMTP id
 ada2fe7eead31-73dc05b5f94mr2027998137.27.1783000353855; 
 Thu, 02 Jul 2026 06:52:33 -0700 (PDT)
X-Received: by 2002:a05:6102:e0b:b0:737:ba2e:8a29 with SMTP id
 ada2fe7eead31-73dc05b5f94mr2027973137.27.1783000353129; 
 Thu, 02 Jul 2026 06:52:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 23/24] target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb()
 to riscv_imsic
Date: Thu,  2 Jul 2026 10:51:25 -0300
Message-ID: <20260702135128.1188021-24-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXwv7OqapPAuDU
 G6jME4YwEufGtb0vnJkLwEKtzbyjAlrGlNxrO7DX2oQxF/k/2xREn1gGhJ9rkSLbtbTsiZP2eAH
 deyhmfOm9jMvO6td3am5cD3qLj6Y4NPmMhOKujUyCY0njm0CkXxrGom4LZ2gdh6I1WLrad848U/
 R1hPspmw5kztmyxz7zL8khjpuMdrTbik0shUQUUN6Hr94Mx29cLmRDOsAyialHtA9gr8s5Q1WDJ
 p8mhlKsGmNnoREMBDs/fz+ImL4YSpoc8rWa7J7lJBUwhGDtTbsj+NNlE+qYeWeIuApW19CoGgrZ
 ZOBv+zHaT1SrCkBN1fRMad39jd7yG9cYMbtKkGUXCoSzFf5LUAAxFNW3YrMNXguL7lrLFfe/7Va
 wvaNihYNDqEYi4gWavwy32lFyv6/ZSUOVJo9TJDLI8RBzWjpIYRKgjaECOUWBIftxlauvv+mxcV
 dIbUjcE2SKxDI0k7nhg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a466d22 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tRk87D2_djSq5c8C55gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: hqlG5DVFNdnX421jtBN_3oMZnJkk5aL3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX5y4cvK0tRTMH
 1HeH6Lzy1PmG4o63wtxnWEdcX2cIDKsYJk14aba4ilh67NZsSVLswLpKWcsz0tTJkR07X4Gmwzb
 7vBP+LVM+j0HT3VHQulPVca19HCC1yo=
X-Proofpoint-GUID: hqlG5DVFNdnX421jtBN_3oMZnJkk5aL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


