Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23AAC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZh-0005sU-G0; Wed, 05 Aug 2026 11:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZY-0005pG-LD
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:25 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZV-0007e3-LQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:23 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4896ae35be9so384449b6e.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943817; x=1786548617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=crxdewcVbBrgQDKeQex5eE0LffBCS8D/h99Th7FYPOw=;
 b=G6sEcaL9UDLqzEE4UFCbN6zGzNA+pHJy8V2ZgHMo8xx4PF1Cor3paxw3r+SCuxQDzl
 DVG/VdmDR+bQZ75wjTyPZpRP5cpl4fvHelgiucCoU9sTbUFURNfAHIYRGzefqJevZedf
 KiqQdj7b0HGXgBI0gCEbG1JVmB93ex8ETx3uz1S4n+/418bun4tEEd0PzQduH6MQfQ/A
 JEaWZTJAeU5Hx535Ztl4h97pQ1j6Q0Mz8ZMQ4ESGRpRpi7jjgaNTtfnAMIsOQMVGRAJx
 hUoSJ6Kx1Gy25932pl2+ukZhspsvpaX3m+FdMhzEBRWUojgtWbi1MPcjsFXpAkVgzr+n
 nOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943817; x=1786548617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=crxdewcVbBrgQDKeQex5eE0LffBCS8D/h99Th7FYPOw=;
 b=Own8aiw/jOA/JRPEvm8/BkVtwIlUB1oB6NPe8j+uiaPUcGwO18cgwt6PiO0lxANqCM
 EYzOi3+a3pUpWUoiI0Kjr98/vPlIVPy0aRbgPGlVDRbbgS3WeTgS4Z+RnDRptzy0Rpkv
 RV3oEHe4TYiGAam1pZvW6JRzb5WqVAMGVq0jMrGUm1ty/dzGQy+REzzlqbaJs+F27d/g
 qoNDHzAGXyFVoCsjuspCbmrFwZW01RznysLL5RUCBBAD//Ua+bdCwhCeD04r17UPgLZ1
 9dznokaXwUea4+SOsElP3RXNg7pokcm+LS5amsL9F3QGgu+mjb7OM4pe2lPepDV2M7Yg
 QEeA==
X-Gm-Message-State: AOJu0YyJqP7amAmrI3cN71UKgz+7tRSyjqnjgY+lsOqDR1mszBwcAzVx
 FmuKuCILZxJvqY3t+slALWMGAq25NmI/W5zzJ5KgmropJbNZnPHk+2tyudN9958q
X-Gm-Gg: AR+sD11xQBcWYmMqFwTGArtdS7IuWf90xeYwPhkXk7FnJZc0dWSGLrmkS/WYvBdoOFn
 zvf/XBAW0mdF41+0s8Ss+Rtgq+wUkJWlpuYrjZwCbcWyB62Nkqizf+SItcm49F05PcQrWOyTeIZ
 Ow4wr8wl+7fBno9u0R5FQQwi9YZFf1ea/5niFbJg1lI9MAF4XLXgpQsde64+RomEu7PtwqdUQpG
 MNv3m2UdHXhDhiMCzYk5GDzbtA9Z8SjjaXA+yWZxQE5fRAKIn4xEKmzM8F0chK1nk/s+K+JZYWo
 N7l06Hp72G7hJyJ7/LoaIyv/eoQSejxQr2o3YyIfkEwVlvPvqGIAN+EMB/keYQretTO7+c3PWJ0
 VaiPsGzndwDYH9SK91r5nnChGPmTS7suzuQTKL/5sb6INzThqGE4hP4IG0h6Y7YwNLrEd1Iwath
 Ha+Ve3yCaf34/oKfAifNQla3U+qjrSS0LodC1dgCH99OSZ5BiApnq8QGfU4iplT6DS/UNaVFs=
X-Received: by 2002:a05:6808:14d3:b0:4a4:c608:5088 with SMTP id
 5614622812f47-4afae187e21mr4185710b6e.13.1785943816658; 
 Wed, 05 Aug 2026 08:30:16 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:16 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 7/9] hw/misc/iotkit-sysinfo.c: add SSE-310 support
Date: Wed,  5 Aug 2026 10:30:03 -0500
Message-ID: <20260805153005.9989-8-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x234.google.com
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

Add SSE-310 PIDR and CIDR registers. Add sys_config2 register and
always report 0 on read as we do not implement the NPU.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
v1 -> v2
	Hard code sys_config2 to return 0 as we don't implement NPU0
---
 hw/misc/iotkit-sysinfo.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 19f089e6ee..f3d07f3247 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -31,6 +31,7 @@
 REG32(SYS_VERSION, 0x0)
 REG32(SYS_CONFIG, 0x4)
 REG32(SYS_CONFIG1, 0x8)
+REG32(SYS_CONFIG2, 0xc)
 REG32(IIDR, 0xfc8)
 REG32(PID4, 0xfd0)
 REG32(PID5, 0xfd4)
@@ -58,6 +59,12 @@ static const int sysinfo_sse300_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sysinfo_sse310_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x58, 0xb8, 0x2b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -68,13 +75,22 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_SYS_VERSION:
         r = s->sys_version;
         break;
-
     case A_SYS_CONFIG:
         r = s->sys_config;
         break;
     case A_SYS_CONFIG1:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
+            return 0;
+            break;
+        default:
+            goto bad_read;
+        }
+        break;
+    case A_SYS_CONFIG2:
+        switch (s->sse_version) {
+        case ARMSSE_SSE310:
             return 0;
             break;
         default:
@@ -84,6 +100,7 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_IIDR:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             return s->iidr;
             break;
         default:
@@ -95,6 +112,9 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sysinfo_sse300_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sysinfo_sse310_id[(offset - A_PID4) / 4];
+            break;
         default:
             r = sysinfo_id[(offset - A_PID4) / 4];
             break;
-- 
2.53.0


