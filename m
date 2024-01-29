Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA08C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUDV-0007sF-Au; Mon, 29 Jan 2024 11:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUDT-0007rA-LB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:35 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUUDQ-0002eL-GH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:10:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33af6129f3cso149269f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706544630; x=1707149430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8ts9LydiTk8L1/WhwNtnM7rJn30kmj1TlpmRZR/snA=;
 b=Lz3w/OEtnlfdtZVK/nQOQ0ycOm+q7IBMvzc/Ihl/ixM47CyDSEMPQ1sAGFC1TaO8pG
 ghGIE4Ad/3lxc26byuFFt8ob1zKYE+40Ie2IPSF6BV53/+LFVlZ3EkfbkGqGCESWxQEG
 LZ8lFbP8GTTlYWgzKKEdiuMk7Rz/9DGOE20C07OnkRMMYoBn40Jxs+HD8kSlIFPMqbwA
 1kjnyUoj44a8r3viwzSV7eQbbVQ0XexxdszUguis5fgrjMsZZpl5CGAug8MWgaH35d/u
 PBdMnjcEoR9MASK+HVa40nWdzsy/VY3Edmx27zSek8z4tY6heR2BjyaJijpLb+cOCsZO
 K6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706544630; x=1707149430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8ts9LydiTk8L1/WhwNtnM7rJn30kmj1TlpmRZR/snA=;
 b=clths0T66urTncao8pn+raKp4bgL2JIaC3B+9Nj/Q1szz600NImN10sHIBZlIy7PgW
 4NywB0nndW4NsNIn7rZxMlxqRTYaL9ik+qv8X8eL5ZuJJk5Vf6LmkVfGJHdmKYDMBr5W
 D+HXkrkUkeJ8sH2gZwKMuSdndFVdLJAjRyRIYS3ZqnsI2j1nY37ACFQhd1EIBUaV+G8M
 Spwx3Wv9kwP/i87LIgnzmaXSfOzvrTRlUKEkfUhM/wHPK+bItEby+ZsSpq7qWJE1G71M
 sA6hi4HbOiozITUfHveSYW64U+UJd5ZxCkhxEe8ZywPzYZC+6ulCNV/t8MWbUDkB3YLo
 YOKw==
X-Gm-Message-State: AOJu0Yy1lg95zE4QKvRSr/35kFGt2aqQhR8s6b/fkOz6AtFq8zioV9YA
 jhiJlwuckuQJHqR0rNRfA3ewbC5yd+6brdzNsbgS5UqlgdudYcoRD5ujm7AL7OSVuuRxjA+jaD6
 MxZM=
X-Google-Smtp-Source: AGHT+IGGV4Zm4671PjUjI3AJyiVZTsWWQyu8wt1CUfZyBnvmPhvhHHwbklSJKmThDd16ZmR8xqdFuA==
X-Received: by 2002:a05:6000:890:b0:336:9e8a:6fde with SMTP id
 cs16-20020a056000089000b003369e8a6fdemr4741514wrb.22.1706544630130; 
 Mon, 29 Jan 2024 08:10:30 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 co6-20020a0560000a0600b0033af4df8e1esm1219957wrb.47.2024.01.29.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:10:29 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 1/6] hw/arm/strongarm.c: convert DPRINTF to trace events
 and guest errors
Date: Mon, 29 Jan 2024 18:09:36 +0200
Message-Id: <39db71dd87bf2007cf7812f3d91dde53887f1f2f.1706544115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. DPRINTFs that report guest errors are logged with
LOG_GUEST_ERROR.#

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/strongarm.c  | 82 ++++++++++++++++++++++++++++-----------------
 hw/arm/trace-events |  3 ++
 2 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 7fd99a0f14..823b4931b0 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -46,8 +46,7 @@
 #include "qemu/log.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
-
-//#define DEBUG
+#include "trace.h"
 
 /*
  TODO
@@ -66,12 +65,6 @@
  - Enhance UART with modem signals
  */
 
-#ifdef DEBUG
-# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
-#else
-# define DPRINTF(format, ...) do { } while (0)
-#endif
-
 static struct {
     hwaddr io_base;
     int irq;
@@ -151,8 +144,9 @@ static uint64_t strongarm_pic_mem_read(void *opaque, hwaddr offset,
     case ICPR:
         return s->pending;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad register offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
         return 0;
     }
 }
@@ -173,8 +167,9 @@ static void strongarm_pic_mem_write(void *opaque, hwaddr offset,
         s->int_idle = (value & 1) ? 0 : ~0;
         break;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                     "%s: Bad register offset 0x"HWADDR_FMT_plx"\n",
+                     __func__, offset);
         break;
     }
     strongarm_pic_update(s);
@@ -333,7 +328,9 @@ static uint64_t strongarm_rtc_read(void *opaque, hwaddr addr,
                 ((qemu_clock_get_ms(rtc_clock) - s->last_hz) << 15) /
                 (1000 * ((s->rttr & 0xffff) + 1));
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad rtc register read 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -375,7 +372,9 @@ static void strongarm_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad rtc register write 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
     }
 }
 
@@ -556,12 +555,12 @@ static uint64_t strongarm_gpio_read(void *opaque, hwaddr offset,
 
     case GPSR:        /* GPIO Pin-Output Set registers */
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "strongarm GPIO: read from write only register GPSR\n");
+                      "%s: read from write only register GPSR\n", __func__);
         return 0;
 
     case GPCR:        /* GPIO Pin-Output Clear registers */
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "strongarm GPIO: read from write only register GPCR\n");
+                      "%s: read from write only register GPCR\n", __func__);
         return 0;
 
     case GRER:        /* GPIO Rising-Edge Detect Enable registers */
@@ -581,7 +580,9 @@ static uint64_t strongarm_gpio_read(void *opaque, hwaddr offset,
         return s->status;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad gpio read offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -626,7 +627,9 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
     }
 }
 
@@ -782,7 +785,9 @@ static uint64_t strongarm_ppc_read(void *opaque, hwaddr offset,
         return s->ppfr | ~0x7f001;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ppc read offset 0x"HWADDR_FMT_plx "\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -817,7 +822,9 @@ static void strongarm_ppc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ppc write offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
     }
 }
 
@@ -1029,8 +1036,13 @@ static void strongarm_uart_update_parameters(StrongARMUARTState *s)
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
-    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n", s->chr->label,
-            speed, parity, data_bits, stop_bits);
+    trace_strongarm_uart_update_parameters((s->chr.chr ?
+                                           s->chr.chr->label : "NULL") ?:
+                                           "NULL",
+                                           speed,
+                                           parity,
+                                           data_bits,
+                                           stop_bits);
 }
 
 static void strongarm_uart_rx_to(void *opaque)
@@ -1164,7 +1176,9 @@ static uint64_t strongarm_uart_read(void *opaque, hwaddr addr,
         return s->utsr1;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad uart register read 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -1221,7 +1235,9 @@ static void strongarm_uart_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad uart register write 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1434,7 +1450,7 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
             return 0xffffffff;
         }
         if (s->rx_level < 1) {
-            printf("%s: SSP Rx Underrun\n", __func__);
+            trace_strongarm_ssp_read_underrun();
             return 0xffffffff;
         }
         s->rx_level--;
@@ -1443,7 +1459,9 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
         strongarm_ssp_fifo_update(s);
         return retval;
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ssp register read 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1458,8 +1476,8 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR0:
         s->sscr[0] = value & 0xffbf;
         if ((s->sscr[0] & SSCR0_SSE) && SSCR0_DSS(value) < 4) {
-            printf("%s: Wrong data size: %i bits\n", __func__,
-                   (int)SSCR0_DSS(value));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Wrong data size: %i bits\n",
+                          __func__, (int)SSCR0_DSS(value));
         }
         if (!(value & SSCR0_SSE)) {
             s->sssr = 0;
@@ -1471,7 +1489,9 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR1:
         s->sscr[1] = value & 0x2f;
         if (value & SSCR1_LBM) {
-            printf("%s: Attempt to use SSP LBM mode\n", __func__);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Attempt to use SSP LBM mode\n",
+                          __func__);
         }
         strongarm_ssp_fifo_update(s);
         break;
@@ -1509,7 +1529,9 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ssp register write 0x"HWADDR_FMT_plx"\n",
+                      __func__,  addr);
         break;
     }
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cdc1ea06a8..7c56943215 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,3 +55,6 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# strongarm.c
+strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
+strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
γαῖα πυρί μιχθήτω


