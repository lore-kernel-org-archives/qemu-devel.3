Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA5EFED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAv-0004Da-MS; Fri, 24 Apr 2026 15:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAt-00043z-MV
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAr-0001c1-Ni
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso76950615e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058808; x=1777663608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0t8jt0AymVNgUQqeTGOsFxkTgdR8czHS8Zoa+60ANvE=;
 b=wNAONgYPYCZA/Z7GsQ/mGL9mDDwoItlceBvTrM29UhSdO3iwH12bt6XFRBpnk9+1RT
 Q9PaL3TALlZfzDWKVmtCb1V8bp1/a9sKV0EX7uGAGNKqhxoQRIYM/SoVL3hmfwQWVfjN
 X+sGVTk80+mqWVjoZL7dj8xn0jviGQnW5K079PptC435c+4GBXiH87oTOFNh5cbl79LH
 1o/felc1PRW4QnLPiyQ7IgO1QEduiE/cOqZQypcr2TebXhr1pqLaB/5TuhttQAU6Pqsz
 o4pacPKOppwHKinX+cGVlO5nHa5eaCSi85AaOynujckJTdnF/R5IRm7NnvRWCprKmNgw
 TYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058808; x=1777663608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0t8jt0AymVNgUQqeTGOsFxkTgdR8czHS8Zoa+60ANvE=;
 b=eivZNdjuATe5iXqjGGHDJ/fP5M7OZDq/Z54CPcXbX9ASdoRVseQelXMUiwXiuC/1+n
 Mh7ExsAOyNXme7kuOsnkEnfAislwu+ttaHSD0PdPSJLkXE03DIwgIihq948M6PCasPPi
 UofCu8VtKfTmPLDwbr9AaXqWJSeGH0KbHJFWvAYMCwN0doFA0PUl19sf5TYnmXAhoTjJ
 NmSP1uqpUdrJD+A/x+Z+KbV+IeoZ5u5SNdn7bOpXOFy8EtmuLknvYR7sO/oMWhN6LM7a
 OXBy5ZMoB2vXI7hoJdi4d3b1QAMxkinVed0rr63hK8z1J3eg2EkcqbCBA/VMbJKECTMe
 CqFg==
X-Gm-Message-State: AOJu0Yx52UbvbnhGhhvKhSYTGzT3vIoozIARet9H5ni4et2wMQbGhuyx
 FRsDOsMR5HWwV9+2FUgRRPYGjNB3FwSAvqPrR8LEIwlEBWRJbCkXDs51HHSkheLaHE67JHrMNxa
 WGdRBFKg=
X-Gm-Gg: AeBDievRSn+Z3+uyA6NVX3h47ed/YUlClEh3tnApSqlaKlpk/pNCHQJCaVqhz22qeIC
 HPReFyH7+fpbDdWFNHx1Q1v9Jz0ftHR0U3PqInI4n5g9dReNQ8i0ZxSKDxJe2QFq59eKvU4Ah1P
 uaNo+GM2l0WOQVAZjx+zpoSz/XIqbC9eHR0Q0UzNhEEZOI49is8M7Ibc7o8DJrIjiwL2eEz11yG
 1sonc+gchoXgDKob8/vOeMl10SU3L+hffjAapEefz3VSk/qqbT5JgwOrbM0p5gJt/fuQ9urzxlU
 et+ZQPFa1k2VpmsQAYOYMgMUELQPGw/LtdNCnZ76/7nTnAE0BwRAe3YjNYW+A7vBKKD87fpDDCl
 jMj432UZANVGcr3mpPg5kzU14UZtRI75dSyyS0e1r3VdHRoxloJjDFBZyQANgxiZgchLQXRS4YI
 owjfokYREKe7VXPHg2LCeYldyx0kghfQt77h5LFBt6XD82rcLJ++c0uApSXVjB1NmB5bsCcFNqA
 8mKi8TyxvY=
X-Received: by 2002:a05:600c:4652:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48900a4e944mr235315145e9.14.1777058807557; 
 Fri, 24 Apr 2026 12:26:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891b46cffasm429035555e9.13.2026.04.24.12.26.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 53/62] hw/usb/hcd-ehci.c: Replace fprintf(stderr,
 ...) with qemu_log_mask(LOG_GUEST_ERROR)
Date: Fri, 24 Apr 2026 21:25:41 +0200
Message-ID: <20260424192543.22614-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Replace direct fprintf(stderr, ...) calls with qemu_log_mask()
using LOG_GUEST_ERROR in the EHCI controller implementation.

Direct writes to stderr are discouraged in QEMU as they bypass
the logging framework and cannot be filtered or controlled at
runtime. Using qemu_log_mask() ensures that guest-visible errors
are properly categorized and can be managed via QEMU logging
options.

All affected messages correspond to guest-triggerable error
conditions, so LOG_GUEST_ERROR is used consistently.

This change improves integration with QEMU's logging infrastructure
and aligns with upstream coding guidelines.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260424080508.53992-6-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 7e0b767eb9e..8acaedeaa90 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -36,6 +36,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/runstate.h"
+#include "qemu/log.h"
 
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
@@ -425,7 +426,7 @@ static int ehci_get_pid(EHCIqtd *qtd)
     case 2:
         return USB_TOKEN_SETUP;
     default:
-        fprintf(stderr, "bad token\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "bad token\n");
         return 0;
     }
 }
@@ -532,7 +533,7 @@ static void ehci_free_packet(EHCIPacket *p)
     }
     if (p->async == EHCI_ASYNC_FINISHED &&
             p->packet.status == USB_RET_SUCCESS) {
-        fprintf(stderr,
+        qemu_log_mask(LOG_GUEST_ERROR,
                 "EHCI: Dropping completed packet from halted %s ep %02X\n",
                 (p->pid == USB_TOKEN_IN) ? "in" : "out",
                 get_field(p->queue->qh.epchar, QH_EPCHAR_EP));
@@ -1042,8 +1043,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
 
         /* not supporting dynamic frame list size at the moment */
         if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {
-            fprintf(stderr, "attempt to set frame list size -- value %d\n",
-                    (int)val & USBCMD_FLS);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "attempt to set frame list size -- value %" PRId64
+                          "\n", val & USBCMD_FLS);
             val &= ~USBCMD_FLS;
         }
 
@@ -1101,7 +1103,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
 
     case PERIODICLISTBASE:
         if (ehci_periodic_enabled(s)) {
-            fprintf(stderr,
+            qemu_log_mask(LOG_GUEST_ERROR,
               "ehci: PERIODIC list base register set while periodic schedule\n"
               "      is enabled and HC is enabled\n");
         }
@@ -1109,7 +1111,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
 
     case ASYNCLISTADDR:
         if (ehci_async_enabled(s)) {
-            fprintf(stderr,
+            qemu_log_mask(LOG_GUEST_ERROR,
               "ehci: ASYNC list address register set while async schedule\n"
               "      is enabled and HC is enabled\n");
         }
@@ -1200,7 +1202,7 @@ static int ehci_init_transfer(EHCIPacket *p)
 
     while (bytes > 0) {
         if (cpage > 4) {
-            fprintf(stderr, "cpage out of range (%u)\n", cpage);
+            qemu_log_mask(LOG_GUEST_ERROR, "cpage out of range (%u)\n", cpage);
             qemu_sglist_destroy(&p->sgl);
             return -1;
         }
@@ -1306,7 +1308,8 @@ static void ehci_execute_complete(EHCIQueue *q)
         break;
     default:
         /* should not be triggerable */
-        fprintf(stderr, "USB invalid response %d\n", p->packet.status);
+        qemu_log_mask(LOG_GUEST_ERROR, "USB invalid response %d\n",
+                      p->packet.status);
         g_assert_not_reached();
     }
 
@@ -1354,7 +1357,7 @@ static int ehci_execute(EHCIPacket *p, const char *action)
            p->async == EHCI_ASYNC_INITIALIZED);
 
     if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {
-        fprintf(stderr, "Attempting to execute inactive qtd\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to execute inactive qtd\n");
         return -1;
     }
 
@@ -1395,7 +1398,8 @@ static int ehci_execute(EHCIPacket *p, const char *action)
             p->packet.actual_length);
 
     if (p->packet.actual_length > BUFF_SIZE) {
-        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ret from usb_handle_packet > BUFF_SIZE\n");
         return -1;
     }
 
@@ -1479,8 +1483,9 @@ static int ehci_process_itd(EHCIState *ehci,
             case USB_RET_SUCCESS:
                 break;
             default:
-                fprintf(stderr, "Unexpected iso usb result: %d\n",
-                        ehci->ipacket.status);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Unexpected iso usb result: %d\n",
+                              ehci->ipacket.status);
                 /* Fall through */
             case USB_RET_IOERROR:
             case USB_RET_NODEV:
@@ -1584,7 +1589,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
 
     /* section 4.8, only QH in async schedule */
     if (async && (NLPTR_TYPE_GET(entry) != NLPTR_TYPE_QH)) {
-        fprintf(stderr, "non queue head request in async schedule\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "non queue head request in async schedule\n");
         return -1;
     }
 
@@ -1606,8 +1612,10 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
 
     default:
         /* TODO: handle FSTN type */
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "
-                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entry));
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FETCHENTRY: entry at 0x%x is of type %u "
+                      "which is not supported yet\n",
+                      entry, NLPTR_TYPE_GET(entry));
         return -1;
     }
 
@@ -2118,13 +2126,13 @@ static void ehci_advance_state(EHCIState *ehci, int async)
             break;
 
         default:
-            fprintf(stderr, "Bad state!\n");
             g_assert_not_reached();
         }
 
         if (again < 0 || itd_count > 16) {
             /* TODO: notify guest (raise HSE irq?) */
-            fprintf(stderr, "processing error - resetting ehci HC\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "processing error - resetting ehci HC\n");
             ehci_reset(ehci);
             again = 0;
         }
@@ -2181,8 +2189,6 @@ static void ehci_advance_async_state(EHCIState *ehci)
 
     default:
         /* this should only be due to a developer mistake */
-        fprintf(stderr, "ehci: Bad asynchronous state %d. "
-                "Resetting to active\n", ehci->astate);
         g_assert_not_reached();
     }
 }
@@ -2231,8 +2237,6 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
 
     default:
         /* this should only be due to a developer mistake */
-        fprintf(stderr, "ehci: Bad periodic state %d. "
-                "Resetting to active\n", ehci->pstate);
         g_assert_not_reached();
     }
 }
-- 
2.53.0


