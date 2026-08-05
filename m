Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20899C56203
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZX-0005oC-Rj; Wed, 05 Aug 2026 11:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZR-0005n3-WE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:18 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZN-0007cp-N6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:15 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-495c49f8eccso753206b6e.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943812; x=1786548612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5wniPKlQoQZB3yHDOIaDg0QUeR+XLP5hn1xDhtt0jA=;
 b=BPYFNxeqA6p1iRAMX2RfvW7CCbRSWJ4ND7VvN4++CCZFGm+Kb8FUh7T4rn7HUisLhK
 1zD+MbQuDSL8DLCXejHNsaYfOLlFNhXH8QexJmhiO+zj3KG95LYciKLUfqDjUTSg0OqC
 6LFoeOxurCYqr2AwgohzX/NlDXd7ZoC2RfWrvLMFrmtdxoJEqbUi1pIVmiWp/DxM3s0X
 gxYYN+6iH/8mkUuz3PQgrd2/Dh3IBH32KBAV5QPwrZH/zH2BHZDymLigH1j6/7lq/kuM
 Fr+9ZdS2TszXLy3OG7uDWScz8gR2aWZm1Zi+bknnlZrVviPUdey/v12HJU5mv5aAoyPC
 wyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943812; x=1786548612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U5wniPKlQoQZB3yHDOIaDg0QUeR+XLP5hn1xDhtt0jA=;
 b=XnvnknXlEN4hK0KJqCY33ejtf6fDDg5aUIyQ89lWFr/diCuUAMDXPBRYU9h/r70H13
 YusAVF1XpCw6KRytY+u2sO5Fs6FtnGNZtlZwaZA7rm/eMjDJnH6yplmrjc6z+oSvSFt3
 Gq1Tra9IAVpDOS99itwEkLfZKPMYGl/uxzTvVHYRMp8OCruuml5JhB1HCVMPM7dMarw+
 LRcjWrbgVxoU20y3a1krcwg9yhfM5puGbswk4pwlrc300IPlKjNNGUBmL3wCdXeYDtXj
 XRDnMjG7x5I/fsppRvRIVIwqgX7+wVu/pDGli4ZI/DO+bZ+fXZARNYG/DiP7pZxwDCQB
 GrjA==
X-Gm-Message-State: AOJu0YxAMwy4p2n5gvR1xisZFlJeeFsmfMTGpq0tUUTEFDvDwDxb61Kb
 OGKbXBjdv6g1A2thdFiH29WI0DVKI0Gp7M7/xPf2UuESYuq7MSJ+sOWneFP37Hjj
X-Gm-Gg: AR+sD13TZe0ja7FWm1iXfr21fUAxk8k4ctAY5/QdDLdD4PHnjxb5fFXy1J7x79REV+J
 B/6MN9uIQWL56lCbv1X+JdA4Vc/HevlyAWCiEV21GXOD3CgA5RVIlVM9AXs5Fe7HGw7cACK8yOc
 GzFQ7HorNaZCpfxC/Ig1qXmn1oevXnUeEa3gfa2NfGRR3E6TZD0VM4e9Enl8pSyFS30kUr/l77T
 wkU0GapHre8mF8baifmvJFPAbOI6dRGEGzsfSjYEKkdbKyshoDFxgXI7b+mwyuZrF8OqbU45ryh
 694BKsHwmxs0HM7mKVMn8CizRM357xpzPHXswBhUVmjy08NHHxSVZLlHSYtCUAmtTuN2idndnsD
 d7w5c6M7mcLcneICdeNZf5+QVwJ2FevAXsXd/O85rOXAT9lL3WzW3Zs9nlhrexGG4u3Q8zzAsWA
 Zu9Sx8S5cj9uhj3fslOXPxGC353m4zBRcIFBv64ZmmRyClY314gCoWrocfqWAkbXzd/DKkFMXFg
 jTzt2dh7LAfWg==
X-Received: by 2002:a05:6808:6907:b0:479:ead7:2a5b with SMTP id
 5614622812f47-4afae0e3e59mr4066940b6e.16.1785943812197; 
 Wed, 05 Aug 2026 08:30:12 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:11 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 3/9] hw/misc/iotkit-sysctl.c: add SSE-310 support
Date: Wed,  5 Aug 2026 10:29:59 -0500
Message-ID: <20260805153005.9989-4-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add SSE-310 case statements for reads and writes.
Add new SSE-310 PIDR and CLIDR values.
Add new SSE-310 PPUINTSTAT register as RAZ with LOG_UMIMP on reads and
RO on writes.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
v1 -> v2
	Add PPUINTSTAT register
	Make sure comments don't separate case statements
---
 hw/misc/iotkit-sysctl.c         | 89 ++++++++++++++++++++++++++++++---
 include/hw/misc/iotkit-sysctl.h |  1 +
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index dff89c677f..bdf59b5f85 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -51,6 +51,7 @@ REG32(CPUWAIT, 0x118)
 REG32(NMI_ENABLE, 0x11c) /* BUSWAIT in IoTKit */
 REG32(WICCTRL, 0x120)
 REG32(EWCTRL, 0x124)
+REG32(PPUINTSTAT, 0x128)
 REG32(PWRCTRL, 0x1fc)
     FIELD(PWRCTRL, PPU_ACCESS_UNLOCK, 0, 1)
     FIELD(PWRCTRL, PPU_ACCESS_FILTER, 1, 1)
@@ -87,6 +88,12 @@ static const int sse200_sysctl_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sse310_sysctl_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x54, 0xb8, 0x4b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 /*
  * Set the initial secure vector table offset address for the core.
  * This will take effect when the CPU next resets.
@@ -118,6 +125,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->scsecctrl;
             break;
         default:
@@ -130,6 +138,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->fclk_div;
             break;
         default:
@@ -142,6 +151,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->sysclk_div;
             break;
         default:
@@ -154,6 +164,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->clock_force;
             break;
         default:
@@ -180,6 +191,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->initsvtor1;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -192,6 +204,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->cpuwait;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR2) */
             goto bad_offset;
         default:
@@ -208,6 +221,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->nmi_enable;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR3) */
             goto bad_offset;
         default:
@@ -221,7 +235,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->wicctrl;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is CPUWAIT */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is CPUWAIT */
             r = s->cpuwait;
             break;
         default:
@@ -236,19 +251,36 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->ewctrl;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is NMI_ENABLE */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is NMI_ENABLE */
             r = s->nmi_enable;
             break;
         default:
             g_assert_not_reached();
         }
         break;
+    case A_PPUINTSTAT:
+        switch (s->sse_version) {
+        case ARMSSE_IOTKIT:
+        case ARMSSE_SSE200:
+        case ARMSSE_SSE300:
+            goto bad_offset;
+        case ARMSSE_SSE310:
+            qemu_log_mask(LOG_UNIMP,
+                          "IoTKit SysCtl PPUINTSTAT unimplemented\n");
+            r = s->ppuintstat;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     case A_PWRCTRL:
         switch (s->sse_version) {
         case ARMSSE_IOTKIT:
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pwrctrl;
             break;
         default:
@@ -261,6 +293,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_sys_sense;
             break;
         default:
@@ -273,7 +306,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
-            r = s->pdcm_pd_cpu0_sense;
+        case ARMSSE_SSE310:
+            r = s->pdcm_pd_cpu0_sense;            
             break;
         default:
             g_assert_not_reached();
@@ -287,6 +321,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram0_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -300,6 +335,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram1_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -313,6 +349,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram2_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_vmr0_sense;
             break;
         default:
@@ -327,6 +364,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
             r = s->pdcm_pd_sram3_sense;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             r = s->pdcm_pd_vmr1_sense;
             break;
         default:
@@ -342,6 +380,9 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sse200_sysctl_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sse310_sysctl_id[(offset - A_PID4) / 4];
+            break;
         default:
             g_assert_not_reached();
         }
@@ -367,7 +408,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
 
 static void cpuwait_write(IoTKitSysCtl *s, uint32_t value)
 {
-    int num_cpus = (s->sse_version == ARMSSE_SSE300) ? 1 : 2;
+    int num_cpus = (s->sse_version == ARMSSE_SSE300 ||
+                    s->sse_version == ARMSSE_SSE310) ? 1 : 2;
     int i;
 
     for (i = 0; i < num_cpus; i++) {
@@ -418,7 +460,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
     case A_INITSVTOR0:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
-            /* SSE300 has a LOCK bit which prevents further writes when set */
+        case ARMSSE_SSE310:
+            /* SSE300 and SSE310 have a LOCK bit which prevents further writes */
             if (s->initsvtor0 & R_INITSVTOR0_LOCK_MASK) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "IoTKit INITSVTOR0 write when register locked\n");
@@ -443,6 +486,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             cpuwait_write(s, value);
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR2) */
             goto bad_offset;
         default:
@@ -457,7 +501,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->wicctrl = value;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is CPUWAIT */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is CPUWAIT */
             cpuwait_write(s, value);
             break;
         default:
@@ -485,6 +530,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SCSECCTRL unimplemented\n");
             s->scsecctrl = value;
             break;
@@ -498,6 +544,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl FCLK_DIV unimplemented\n");
             s->fclk_div = value;
             break;
@@ -511,6 +558,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SYSCLK_DIV unimplemented\n");
             s->sysclk_div = value;
             break;
@@ -524,6 +572,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CLOCK_FORCE unimplemented\n");
             s->clock_force = value;
             break;
@@ -540,6 +589,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             set_init_vtor(1, s->initsvtor1);
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -554,7 +604,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->ewctrl = value;
             break;
         case ARMSSE_SSE300:
-            /* In SSE300 this offset is NMI_ENABLE */
+        case ARMSSE_SSE310:
+            /* In SSE300 and SSE310 this offset is NMI_ENABLE */
             qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl NMI_ENABLE unimplemented\n");
             s->nmi_enable = value;
             break;
@@ -562,12 +613,25 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             g_assert_not_reached();
         }
         break;
+    case A_PPUINTSTAT:
+        switch (s->sse_version) {
+        case ARMSSE_IOTKIT:
+        case ARMSSE_SSE200:
+        case ARMSSE_SSE300:
+            goto bad_offset;
+        case ARMSSE_SSE310:
+            goto ro_offset;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     case A_PWRCTRL:
         switch (s->sse_version) {
         case ARMSSE_IOTKIT:
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             if (!(s->pwrctrl & R_PWRCTRL_PPU_ACCESS_UNLOCK_MASK)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "IoTKit PWRCTRL write when register locked\n");
@@ -585,6 +649,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             goto bad_offset;
         case ARMSSE_SSE200:
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_SYS_SENSE unimplemented\n");
             s->pdcm_pd_sys_sense = value;
@@ -599,6 +664,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
         case ARMSSE_SSE200:
             goto bad_offset;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_CPU0_SENSE unimplemented\n");
             s->pdcm_pd_cpu0_sense = value;
@@ -617,6 +683,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram0_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -632,6 +699,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram1_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             goto bad_offset;
         default:
             g_assert_not_reached();
@@ -647,6 +715,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram2_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_VMR0_SENSE unimplemented\n");
             s->pdcm_pd_vmr0_sense = value;
@@ -665,6 +734,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->pdcm_pd_sram3_sense = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             qemu_log_mask(LOG_UNIMP,
                           "IoTKit SysCtl PDCM_PD_VMR1_SENSE unimplemented\n");
             s->pdcm_pd_vmr1_sense = value;
@@ -683,6 +753,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             s->nmi_enable = value;
             break;
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             /* In SSE300 this is reserved (for INITSVTOR3) */
             goto bad_offset;
         default:
@@ -734,6 +805,7 @@ static void iotkit_sysctl_reset(DeviceState *dev)
     s->clock_force = 0;
     s->nmi_enable = 0;
     s->ewctrl = 0;
+    s->ppuintstat = 0;
     s->pwrctrl = 0x3;
     s->pdcm_pd_sys_sense = 0x7f;
     s->pdcm_pd_sram0_sense = 0;
@@ -769,7 +841,8 @@ static bool sse300_needed(void *opaque)
 {
     IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
 
-    return s->sse_version == ARMSSE_SSE300;
+    return s->sse_version == ARMSSE_SSE300 ||
+           s->sse_version == ARMSSE_SSE310;
 }
 
 static const VMStateDescription iotkit_sysctl_sse300_vmstate = {
diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
index ce72258a84..8e1cf0012d 100644
--- a/include/hw/misc/iotkit-sysctl.h
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -53,6 +53,7 @@ struct IoTKitSysCtl {
     uint32_t initsvtor1;
     uint32_t nmi_enable;
     uint32_t ewctrl;
+    uint32_t ppuintstat;
     uint32_t pwrctrl;
     uint32_t pdcm_pd_sys_sense;
     uint32_t pdcm_pd_sram0_sense;
-- 
2.53.0


