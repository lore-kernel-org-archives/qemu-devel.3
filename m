Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA458C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7f7-0002Jc-BJ; Mon, 17 Aug 2026 20:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f4-0002Hz-PV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:38 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f2-0004HR-HU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:38 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4a46a53abc9so2277748b6e.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012795; x=1787617595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=la5zs7DXw7P/i63uM6e2gZzkJDnjmoPrSc5EZ9gkqNE=;
 b=r1bzw1/Kp2vUiz0etbBClsh98FZo7bQVcPobqGVLJDvrrOiU5al2OdmhvGQw4BDazP
 z0wS0baz8hhXLECcVndXA/v+kEmx8Ub/U0mfM0n9wwUs7J/foM335/rF3A8u/NzXnxPN
 ML4Q4DRFZcJ3nd9GDuliZkBdYslfSf4FcCDdH2XR5P+vWunnqO9u4nRFErrq3Rm7vNZl
 wFq5KOX+92oOPd5NULR/EAJZO9n6WfUdjSKepH9OOisZ0ZT6D++uxxSHq7rzvJYr/FLW
 XzTP//UPlyygeMRkKAUf0vLvQi01BgEztCcAqsLh47fujNhhv79Lo02ODGGNmhfTJ1Nr
 VXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012795; x=1787617595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=la5zs7DXw7P/i63uM6e2gZzkJDnjmoPrSc5EZ9gkqNE=;
 b=Ae1l/vj5CNqOSLMP/iVKsAXepR/0fjqJPdWFxQwMkbJif0s/5dMpkCPskhEqOhYY/h
 zAbF0Tu+NrULHrHzbRgEIHDNyqulQcKL/SsuuDmK9UVGKkJWJHKFH8A2y+J4pPSmHWHV
 o7I7ivKw5ezErWZccJd6vdLOZMVDyGVQg0hDSNkz1X92Z5WJE9ugtH8HdPe7G9wQL2m6
 HydCndJ9MF2XOQqIbm9FXuN6P4kj4hmWzAJMLc7Y9J8HGmHFLNTlXG/QvrHNVK9qXFWj
 nGc6OVDrgKCif9U+hoougIRHfnCgOKg1MytrIwyL0Sr8zTWOojtaSLLaotje4l0TBcRU
 Pixw==
X-Gm-Message-State: AOJu0YxLC8haXZxR73ttBhCJSonztOVoOki86YyRzG8Pls+TCa/Wl5Bo
 jJqZwhdQvJg5ChY/5g1U6gVMwx4sQw1NxmKL57Id+vc4ci2k7Dgu/KytgKGbtH7i
X-Gm-Gg: AR+sD13WsxDYMcNpXZ9Pi0vICRpGwQa4XDmF8I47r0ZHif9CmeiXjiqCs/M2m16mUrH
 K1m89g5EdIPIXsWuHBm5UlzESh9uNvU3Jb1DQuKDMB7ZuxBCeDg9PCXOpyzRUEEpwmlyTmNW1xX
 8heRDuzAw4sW/WlviwRP/2ftwPIf6pXXLKkr1HYXVsHlo5VCZCx6JJhafMPrwldfulUFQXnFpjn
 Y4Cb9mX5DqfZUSl7KwVslMUnsQ0s6gix3wdHxM7d8P7UUbZ+E/8/fuZhFdBca+ZTNtYPsrTIJF0
 CTUSxMax+ytMgr55XBIdRBKMcb1HughvxNkZHCi+LoXXBXpzZtUbYVqNaQi4naoKoAEP6eaSEZO
 cIp85wBPZOzLML44tyxG1/dp1135EhM5FmbMBrqTsNyFMDAWofTHx7ElWIvYcWuIFIUKFuCLYOE
 Jo8wwAymYrCMfiW68al4PzK0wHi6KsTyT0+LJNrdDR6z7PFLc10AhupZ5d99CgZILeMEh+VLnxT
 kmvrxZIuUA=
X-Received: by 2002:a05:6808:c3ec:b0:4aa:cad:cb4c with SMTP id
 5614622812f47-4b240f875b2mr24789286b6e.1.1787012795412; 
 Mon, 17 Aug 2026 17:26:35 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:34 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>, Owen Giles <owen.giles@hpe.com>,
 Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 3/9] hw/misc/iotkit-sysctl.c: add SSE-310 support
Date: Mon, 17 Aug 2026 19:26:23 -0500
Message-ID: <20260818002629.172827-4-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add SSE-310 case statements for reads and writes.
Add new SSE-310 PIDR and CLIDR values.
Add new SSE-310 PPUINTSTAT register as RAZ with LOG_UMIMP on reads and
RO on writes.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-Id: <20260805153005.9989-4-simonxhy0404@gmail.com>
---
v2 -> v3
    Remove ppuintstat field from IoTKitSysCtl state struct as the
    register is RO and have it return "r = 0" on reads. This way we can
    avoid adding an unnecessary vmstate subsection for ppuintstat.
---
 hw/misc/iotkit-sysctl.c | 88 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index dff89c677f..df38e0ba15 100644
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
+            r = 0;
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
@@ -769,7 +840,8 @@ static bool sse300_needed(void *opaque)
 {
     IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
 
-    return s->sse_version == ARMSSE_SSE300;
+    return s->sse_version == ARMSSE_SSE300 ||
+           s->sse_version == ARMSSE_SSE310;
 }
 
 static const VMStateDescription iotkit_sysctl_sse300_vmstate = {
-- 
2.53.0


