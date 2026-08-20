Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D56C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CR-00051m-GR; Thu, 20 Aug 2026 08:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CP-0004za-79
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:49 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CJ-0001b1-ME
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:48 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a386a34603so2667260a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230122; x=1787834922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yQjk8/J3I7o9BNKQFxb6fZSHJDkrfokHftBqfxIlUGM=;
 b=Lziw5GuuolzQaoiC4m6LUeRHqd3N8C5Gb9w6uRxKQnJ0UWeYVblR5RWZSPD80x3lZb
 FWfAh7dg7D3tEvLCZHF1kh7wyr/dw3vN+XQbIk5+xY+qlTrDi8FkqgGcWSr+Az8C3mWb
 grFFu/ydfoi8lLTml30xoqW0jFYzkIKhfjue7W2Ol9nmcqs+Y9w8yKPZ4zdYVpJ5lMEN
 IH5h4sS3G8r2Jy5RFdxeqoGs1YMTo6oq1JAQ0r6Cc2BJc5uNNYZEc97SbaQxLae5FE/U
 TwKhbt8cw+8dYH75ZD9CR5cQfPTqxxGjDXq8g1QhM4fVRCr617X43sf89McB31t4jx2+
 CcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230122; x=1787834922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yQjk8/J3I7o9BNKQFxb6fZSHJDkrfokHftBqfxIlUGM=;
 b=Dh05OYO519KA1BOpuciiIvMj0Yhuli0wghGDD/L/rM5j1LMvQg2YSFXUd6d0riIT4/
 APHDEDPTFjgqZ3RrIftFA+BDHwkVtkiW3yNE7Dxd9lQ3xacew77cYcNEz1NLaLjuvmju
 LutB4yNvDQCYZXVRjmvYcyRDV6OIDmn6xZ6F8uKfHKxzAi7zujdfIcwAlhUc0cWBVHgn
 fECQfsWoC5HlkS8+j/Rx8lv9nfylzpNtxCXHhDMFEqx4BAU88gwMdCoVzhTYxdUTXam0
 PTuIPAy/qCI64pJg5csyKF6iWm64gLxvWjHmCELCSBX2JGu2fD8mRk7ILWnkOqNa6/ES
 ZtUA==
X-Gm-Message-State: AFuF++lZDZYwAhv79iv+L0mWE/9PDIXWqpgdoqKG92wJAYmIIZytgRa/
 jgg4T8LrxT7pRXVJYyPRdNX3sNZFuTSRiwtuPMgBtOqMoxYEhMmr1deeW1GPu07h
X-Gm-Gg: AR+sD11581dE3UCrx43tdRGsvDJhTdiQune+DkIcb0ESxcGCIGYffiH53Tz15FqRV8n
 q8TBI0a1uxTVUL7zZdsxk5/0vR1kFAx5z6DdAzj34/I8DRQ6evprlJWUDJSm41g2/HOtACaKlwH
 HAvbtutkuK0NysK4o1S+mwlphSIZtjCj7ylseG6eZlvrao2oHMl3YOhPgWrqoZuyQcVcPh1wnQl
 KXVB5vcrTRX+Ile3uBZTPa3SInqsU+/4sv3VGaFzEzVuEgtHn/eP7Wy0F94KuX6LfIvEACEPeZA
 CBRZP2k6enR9qu2VsKodIIkI+00IIjUCMwJ4drcztrK16TBByqApnHtGPdXKfYvLQWwAPdGipfe
 FF3qk5T3PFDlwFW/EngH/0LJ4ii6cnj2/shBUxK5Z4o0bQVIJxJTARL3XVydb7pQGP9jDM6+RUH
 ebLsGv9nRVlA1oqYv9A9sP/aU6tLVPd/ZEjTv9wRyhLpjSVO296k5AswiTVHt2TAzYqy6d7Jbme
 aKiinROujc=
X-Received: by 2002:a05:6402:208a:b0:6a0:a46b:ad3c with SMTP id
 4fb4d7f45d1cf-6a4112442cemr3766726a12.1.1787230121358; 
 Thu, 20 Aug 2026 05:48:41 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:40 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 10/14] hw/misc: add TI DMSC (TI-SCI system controller)
 model
Date: Thu, 20 Aug 2026 14:48:10 +0200
Message-ID: <20260820124824.618671-11-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x529.google.com
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

On real K3 silicon the device management and security controller runs the
TI system firmware (SYSFW) and answers TI-SCI requests from all other
cores. Rather than executing the vendor firmware blob, model the DMSC as a
TI-SCI endpoint on top of the secure proxy.

Implemented message classes:

 - version and firmware capability queries
 - device state, device reset and clock management (set/get state,
   get/set frequency, query frequency, clock parents)
 - processor boot control: request/release, set config, set control,
   boot vector capture, wait_proc_boot_status and handover, which is what
   actually starts the A53 and M4F cores
 - firewall configuration and SA2UL/secure-revision queries needed by
   TF-A and OP-TEE
 - system reset

Unknown messages are NAKed and traced, which keeps guests that probe for
optional features working.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/misc/Kconfig           |    3 +
 hw/misc/meson.build       |    1 +
 hw/misc/ti-dmsc.c         | 1725 +++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events      |   32 +
 include/hw/misc/ti-dmsc.h |  661 ++++++++++++++
 5 files changed, 2422 insertions(+)
 create mode 100644 hw/misc/ti-dmsc.c
 create mode 100644 include/hw/misc/ti-dmsc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bea8e9341f..ebdbda1962 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -143,6 +143,9 @@ config MPS2_SCC
     bool
     select LED
 
+config TI_DMSC
+    bool
+
 config TI_RAT
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a8a40ea2a7..124d55502d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -123,6 +123,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_RCC', if_true: files('stm32l4x5_rcc.c'))
 system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
 system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
 
+system_ss.add(when: 'CONFIG_TI_DMSC', if_true: files('ti-dmsc.c'))
 system_ss.add(when: 'CONFIG_TI_RAT', if_true: files('ti-rat.c'))
 system_ss.add(when: 'CONFIG_TI_K3_CTRLMMR', if_true: files('ti-k3-ctrlmmr.c'))
 system_ss.add(when: 'CONFIG_TI_K3_GTC', if_true: files('ti-k3-gtc.c'))
diff --git a/hw/misc/ti-dmsc.c b/hw/misc/ti-dmsc.c
new file mode 100644
index 0000000000..3b5b32830e
--- /dev/null
+++ b/hw/misc/ti-dmsc.c
@@ -0,0 +1,1725 @@
+/*
+ * TI DMSC emulator (minimal TISCI service) as QOM device
+ *
+ * This is used together with a TI SEC_PROXY model. The SEC_PROXY stays the
+ * transport/queue/data-window part, this device handles SYSFW/TISCI logic.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev.h"
+#include "hw/core/resettable.h"
+#include "system/reset.h"
+#include "system/runstate.h"
+#include "target/arm/arm-powerctl.h"
+#include "qemu/main-loop.h"
+#include "hw/misc/ti-dmsc.h"
+#include "trace.h"
+
+/*
+ * Responses, which go through sec-proxy, have one word less payload than the
+ * slot size: word 0 is reserved by ti_sec_proxy_push_msg().
+ * TI_DMSC_MAX_WORDS is the TISCI request limit, not transport capacity.
+ */
+#define TI_DMSC_SEC_PROXY_PAYLOAD_MAX \
+    ((SEC_PROXY_MSG_MAX_WORDS - 1) * sizeof(uint32_t))
+
+static const char *ti_dmsc_proc_name_from_id(uint32_t proc_id)
+{
+    switch (proc_id) {
+    case SCICLIENT_PROCID_A53_CL0_C0:
+        return "A53_CL0_C0";
+    case SCICLIENT_PROCID_A53_CL0_C1:
+        return "A53_CL0_C1";
+
+    case SCICLIENT_PROCID_R5_CL0_C0:
+        return "R5_CL0_C0";
+    case SCICLIENT_PROCID_R5_CL0_C1:
+        return "R5_CL0_C1";
+    case SCICLIENT_PROCID_R5_CL1_C0:
+        return "R5_CL1_C0";
+    case SCICLIENT_PROCID_R5_CL1_C1:
+        return "R5_CL1_C1";
+
+    case SCICLIENT_PROCID_MCU_M4FSS0_C0:
+        return "MCU_M4FSS0_C0";
+
+    default:
+        return "UNKNOWN_PROC";
+    }
+}
+
+static const char *ti_dmsc_host_name_from_id(uint32_t host_id)
+{
+    switch (host_id) {
+    case TISCI_HOST_ID_DMSC:
+        return "DMSC";
+
+    case TISCI_HOST_ID_MAIN_0_R5_0:
+        return "MAIN_0_R5_0";
+    case TISCI_HOST_ID_MAIN_0_R5_1:
+        return "MAIN_0_R5_1";
+    case TISCI_HOST_ID_MAIN_0_R5_2:
+        return "MAIN_0_R5_2";
+    case TISCI_HOST_ID_MAIN_0_R5_3:
+        return "MAIN_0_R5_3";
+
+    case TISCI_HOST_ID_A53_0:
+        return "A53_0";
+    case TISCI_HOST_ID_A53_1:
+        return "A53_1";
+    case TISCI_HOST_ID_A53_2:
+        return "A53_2";
+    case TISCI_HOST_ID_A53_3:
+        return "A53_3";
+    case TISCI_HOST_ID_A53_4:
+        return "A53_4";
+
+    case TISCI_HOST_ID_M4_0:
+        return "M4_0";
+
+    case TISCI_HOST_ID_MAIN_1_R5_0:
+        return "MAIN_1_R5_0";
+    case TISCI_HOST_ID_MAIN_1_R5_1:
+        return "MAIN_1_R5_1";
+    case TISCI_HOST_ID_MAIN_1_R5_2:
+        return "MAIN_1_R5_2";
+    case TISCI_HOST_ID_MAIN_1_R5_3:
+        return "MAIN_1_R5_3";
+
+    case TISCI_HOST_ID_ICSSG_0:
+        return "ICSSG_0";
+    case TISCI_HOST_ID_ICSSG_1:
+        return "ICSSG_1";
+
+    default:
+        return "UNKNOWN_HOST";
+    }
+}
+
+static const char *ti_dmsc_device_state_to_str(uint8_t state)
+{
+    switch (state) {
+    case TISCI_MSG_VALUE_DEVICE_SW_STATE_AUTO_OFF:
+        return "AUTO";
+    case TISCI_MSG_VALUE_DEVICE_SW_STATE_RETENTION:
+        return "RETENTION";
+    case TISCI_MSG_VALUE_DEVICE_SW_STATE_ON:
+        return "ON";
+    default:
+        return "UNKNOWN_STATE";
+    }
+}
+
+static const char *ti_dmsc_device_name_from_id(uint32_t dev_id)
+{
+    switch (dev_id) {
+    case TISCI_DEV_ADC0:
+        return "ADC0";
+    case TISCI_DEV_CMP_EVENT_INTROUTER0:
+        return "CMP_EVENT_INTROUTER0";
+    case TISCI_DEV_DBGSUSPENDROUTER0:
+        return "DBGSUSPENDROUTER0";
+    case TISCI_DEV_MAIN_GPIOMUX_INTROUTER0:
+        return "MAIN_GPIOMUX_INTROUTER0";
+    case TISCI_DEV_MCU_MCU_GPIOMUX_INTROUTER0:
+        return "MCU_MCU_GPIOMUX_INTROUTER0";
+    case TISCI_DEV_TIMESYNC_EVENT_INTROUTER0:
+        return "TIMESYNC_EVENT_INTROUTER0";
+    case TISCI_DEV_MCU_M4FSS0:
+        return "MCU_M4FSS0";
+    case TISCI_DEV_MCU_M4FSS0_CBASS_0:
+        return "MCU_M4FSS0_CBASS_0";
+    case TISCI_DEV_MCU_M4FSS0_CORE0:
+        return "MCU_M4FSS0_CORE0";
+    case TISCI_DEV_CPSW0:
+        return "CPSW0";
+    case TISCI_DEV_CPT2_AGGR0:
+        return "CPT2_AGGR0";
+    case TISCI_DEV_STM0:
+        return "STM0";
+    case TISCI_DEV_DCC0:
+        return "DCC0";
+    case TISCI_DEV_DCC1:
+        return "DCC1";
+    case TISCI_DEV_DCC2:
+        return "DCC2";
+    case TISCI_DEV_DCC3:
+        return "DCC3";
+    case TISCI_DEV_DCC4:
+        return "DCC4";
+    case TISCI_DEV_DCC5:
+        return "DCC5";
+    case TISCI_DEV_DMSC0:
+        return "DMSC0";
+    case TISCI_DEV_MCU_DCC0:
+        return "MCU_DCC0";
+    case TISCI_DEV_DEBUGSS_WRAP0:
+        return "DEBUGSS_WRAP0";
+    case TISCI_DEV_DMASS0:
+        return "DMASS0";
+    case TISCI_DEV_DMASS0_BCDMA_0:
+        return "DMASS0_BCDMA_0";
+    case TISCI_DEV_DMASS0_CBASS_0:
+        return "DMASS0_CBASS_0";
+    case TISCI_DEV_DMASS0_INTAGGR_0:
+        return "DMASS0_INTAGGR_0";
+    case TISCI_DEV_DMASS0_IPCSS_0:
+        return "DMASS0_IPCSS_0";
+    case TISCI_DEV_DMASS0_PKTDMA_0:
+        return "DMASS0_PKTDMA_0";
+    case TISCI_DEV_DMASS0_RINGACC_0:
+        return "DMASS0_RINGACC_0";
+    case TISCI_DEV_MCU_TIMER0:
+        return "MCU_TIMER0";
+    case TISCI_DEV_TIMER0:
+        return "TIMER0";
+    case TISCI_DEV_TIMER1:
+        return "TIMER1";
+    case TISCI_DEV_TIMER2:
+        return "TIMER2";
+    case TISCI_DEV_TIMER3:
+        return "TIMER3";
+    case TISCI_DEV_TIMER4:
+        return "TIMER4";
+    case TISCI_DEV_TIMER5:
+        return "TIMER5";
+    case TISCI_DEV_TIMER6:
+        return "TIMER6";
+    case TISCI_DEV_TIMER7:
+        return "TIMER7";
+    case TISCI_DEV_TIMER8:
+        return "TIMER8";
+    case TISCI_DEV_TIMER9:
+        return "TIMER9";
+    case TISCI_DEV_TIMER10:
+        return "TIMER10";
+    case TISCI_DEV_TIMER11:
+        return "TIMER11";
+    case TISCI_DEV_MCU_TIMER1:
+        return "MCU_TIMER1";
+    case TISCI_DEV_MCU_TIMER2:
+        return "MCU_TIMER2";
+    case TISCI_DEV_MCU_TIMER3:
+        return "MCU_TIMER3";
+    case TISCI_DEV_ECAP0:
+        return "ECAP0";
+    case TISCI_DEV_ECAP1:
+        return "ECAP1";
+    case TISCI_DEV_ECAP2:
+        return "ECAP2";
+    case TISCI_DEV_ELM0:
+        return "ELM0";
+    case TISCI_DEV_EMIF_DATA_0_VD:
+        return "EMIF_DATA_0_VD";
+    case TISCI_DEV_MMCSD0:
+        return "MMCSD0";
+    case TISCI_DEV_MMCSD1:
+        return "MMCSD1";
+    case TISCI_DEV_EQEP0:
+        return "EQEP0";
+    case TISCI_DEV_EQEP1:
+        return "EQEP1";
+    case TISCI_DEV_GTC0:
+        return "GTC0";
+    case TISCI_DEV_EQEP2:
+        return "EQEP2";
+    case TISCI_DEV_ESM0:
+        return "ESM0";
+    case TISCI_DEV_MCU_ESM0:
+        return "MCU_ESM0";
+    case TISCI_DEV_FSIRX0:
+        return "FSIRX0";
+    case TISCI_DEV_FSIRX1:
+        return "FSIRX1";
+    case TISCI_DEV_FSIRX2:
+        return "FSIRX2";
+    case TISCI_DEV_FSIRX3:
+        return "FSIRX3";
+    case TISCI_DEV_FSIRX4:
+        return "FSIRX4";
+    case TISCI_DEV_FSIRX5:
+        return "FSIRX5";
+    case TISCI_DEV_FSITX0:
+        return "FSITX0";
+    case TISCI_DEV_FSITX1:
+        return "FSITX1";
+    case TISCI_DEV_FSS0:
+        return "FSS0";
+    case TISCI_DEV_FSS0_FSAS_0:
+        return "FSS0_FSAS_0";
+    case TISCI_DEV_FSS0_OSPI_0:
+        return "FSS0_OSPI_0";
+    case TISCI_DEV_GICSS0:
+        return "GICSS0";
+    case TISCI_DEV_GPIO0:
+        return "GPIO0";
+    case TISCI_DEV_GPIO1:
+        return "GPIO1";
+    case TISCI_DEV_MCU_GPIO0:
+        return "MCU_GPIO0";
+    case TISCI_DEV_GPMC0:
+        return "GPMC0";
+    case TISCI_DEV_PRU_ICSSG0:
+        return "PRU_ICSSG0";
+    case TISCI_DEV_PRU_ICSSG1:
+        return "PRU_ICSSG1";
+    case TISCI_DEV_LED0:
+        return "LED0";
+    case TISCI_DEV_CPTS0:
+        return "CPTS0";
+    case TISCI_DEV_DDPA0:
+        return "DDPA0";
+    case TISCI_DEV_EPWM0:
+        return "EPWM0";
+    case TISCI_DEV_EPWM1:
+        return "EPWM1";
+    case TISCI_DEV_EPWM2:
+        return "EPWM2";
+    case TISCI_DEV_EPWM3:
+        return "EPWM3";
+    case TISCI_DEV_EPWM4:
+        return "EPWM4";
+    case TISCI_DEV_EPWM5:
+        return "EPWM5";
+    case TISCI_DEV_EPWM6:
+        return "EPWM6";
+    case TISCI_DEV_EPWM7:
+        return "EPWM7";
+    case TISCI_DEV_EPWM8:
+        return "EPWM8";
+    case TISCI_DEV_VTM0:
+        return "VTM0";
+    case TISCI_DEV_MAILBOX0:
+        return "MAILBOX0";
+    case TISCI_DEV_MAIN2MCU_VD:
+        return "MAIN2MCU_VD";
+    case TISCI_DEV_MCAN0:
+        return "MCAN0";
+    case TISCI_DEV_MCAN1:
+        return "MCAN1";
+    case TISCI_DEV_MCU_MCRC64_0:
+        return "MCU_MCRC64_0";
+    case TISCI_DEV_MCU2MAIN_VD:
+        return "MCU2MAIN_VD";
+    case TISCI_DEV_I2C0:
+        return "I2C0";
+    case TISCI_DEV_I2C1:
+        return "I2C1";
+    case TISCI_DEV_I2C2:
+        return "I2C2";
+    case TISCI_DEV_I2C3:
+        return "I2C3";
+    case TISCI_DEV_MCU_I2C0:
+        return "MCU_I2C0";
+    case TISCI_DEV_MCU_I2C1:
+        return "MCU_I2C1";
+    case TISCI_DEV_PCIE0:
+        return "PCIE0";
+    case TISCI_DEV_R5FSS0:
+        return "R5FSS0";
+    case TISCI_DEV_R5FSS1:
+        return "R5FSS1";
+    case TISCI_DEV_R5FSS0_CORE0:
+        return "R5FSS0_CORE0";
+    case TISCI_DEV_R5FSS0_CORE1:
+        return "R5FSS0_CORE1";
+    case TISCI_DEV_R5FSS1_CORE0:
+        return "R5FSS1_CORE0";
+    case TISCI_DEV_R5FSS1_CORE1:
+        return "R5FSS1_CORE1";
+    case TISCI_DEV_RTI0:
+        return "RTI0";
+    case TISCI_DEV_RTI1:
+        return "RTI1";
+    case TISCI_DEV_RTI8:
+        return "RTI8";
+    case TISCI_DEV_RTI9:
+        return "RTI9";
+    case TISCI_DEV_RTI10:
+        return "RTI10";
+    case TISCI_DEV_RTI11:
+        return "RTI11";
+    case TISCI_DEV_MCU_RTI0:
+        return "MCU_RTI0";
+    case TISCI_DEV_SA2_UL0:
+        return "SA2_UL0";
+    case TISCI_DEV_COMPUTE_CLUSTER0:
+        return "COMPUTE_CLUSTER0";
+    case TISCI_DEV_A53SS0_CORE_0:
+        return "A53SS0_CORE_0";
+    case TISCI_DEV_A53SS0_CORE_1:
+        return "A53SS0_CORE_1";
+    case TISCI_DEV_A53SS0:
+        return "A53SS0";
+    case TISCI_DEV_DDR16SS0:
+        return "DDR16SS0";
+    case TISCI_DEV_PSC0:
+        return "PSC0";
+    case TISCI_DEV_MCU_PSC0:
+        return "MCU_PSC0";
+    case TISCI_DEV_MCSPI0:
+        return "MCSPI0";
+    case TISCI_DEV_MCSPI1:
+        return "MCSPI1";
+    case TISCI_DEV_MCSPI2:
+        return "MCSPI2";
+    case TISCI_DEV_MCSPI3:
+        return "MCSPI3";
+    case TISCI_DEV_MCSPI4:
+        return "MCSPI4";
+    case TISCI_DEV_UART0:
+        return "UART0";
+    case TISCI_DEV_MCU_MCSPI0:
+        return "MCU_MCSPI0";
+    case TISCI_DEV_MCU_MCSPI1:
+        return "MCU_MCSPI1";
+    case TISCI_DEV_MCU_UART0:
+        return "MCU_UART0";
+    case TISCI_DEV_SPINLOCK0:
+        return "SPINLOCK0";
+    case TISCI_DEV_TIMERMGR0:
+        return "TIMERMGR0";
+    case TISCI_DEV_UART1:
+        return "UART1";
+    case TISCI_DEV_UART2:
+        return "UART2";
+    case TISCI_DEV_UART3:
+        return "UART3";
+    case TISCI_DEV_UART4:
+        return "UART4";
+    case TISCI_DEV_UART5:
+        return "UART5";
+    case TISCI_DEV_BOARD0:
+        return "BOARD0";
+    case TISCI_DEV_UART6:
+        return "UART6";
+    case TISCI_DEV_MCU_UART1:
+        return "MCU_UART1";
+    case TISCI_DEV_USB0:
+        return "USB0";
+    case TISCI_DEV_SERDES_10G0:
+        return "SERDES_10G0";
+    case TISCI_DEV_PBIST0:
+        return "PBIST0";
+    case TISCI_DEV_PBIST1:
+        return "PBIST1";
+    case TISCI_DEV_PBIST2:
+        return "PBIST2";
+    case TISCI_DEV_PBIST3:
+        return "PBIST3";
+    case TISCI_DEV_COMPUTE_CLUSTER0_PBIST_0:
+        return "COMPUTE_CLUSTER0_PBIST_0";
+    default:
+        return "UNKNOWN";
+    }
+}
+
+static void ti_dmsc_init_device_states(TIDmscState *s)
+{
+    for (size_t i = 0; i < TISCI_DEV_ID_MAX; i++) {
+        s->dev_hw_state[i] = TISCI_MSG_VALUE_DEVICE_HW_STATE_ON;
+        s->dev_prog_state[i] = TISCI_MSG_VALUE_DEVICE_HW_STATE_ON;
+    }
+
+    s->dev_hw_state[TISCI_DEV_MCU_M4FSS0_CORE0] =
+        TISCI_MSG_VALUE_DEVICE_HW_STATE_OFF;
+    s->dev_prog_state[TISCI_DEV_MCU_M4FSS0_CORE0] =
+        TISCI_MSG_VALUE_DEVICE_HW_STATE_OFF;
+    s->m4_running = false;
+    memset(s->proc_bootvector, 0, sizeof(s->proc_bootvector));
+}
+
+static const char *ti_dmsc_message_name_from_id(uint16_t msg_id)
+{
+    switch (msg_id) {
+    case TISCI_MSG_GET_DEVICE:
+        return "GET_DEVICE";
+    case TISCI_MSG_SET_DEVICE:
+        return "SET_DEVICE";
+    case TISCI_MSG_SET_DEVICE_RESETS:
+        return "SET_DEVICE_RESETS";
+    case TISCI_MSG_DEVICE_DROP_POWERUP_REF:
+        return "DEVICE_DROP_POWERUP_REF";
+    case TISCI_MSG_PREPARE_SLEEP:
+        return "PREPARE_SLEEP";
+    case TISCI_MSG_ENTER_SLEEP:
+        return "ENTER_SLEEP";
+    case TISCI_MSG_VERSION:
+        return "VERSION";
+    case TISCI_MSG_BOOT_NOTIFICATION:
+        return "BOOT_NOTIFICATION";
+    case TISCI_MSG_BOARD_CONFIG:
+        return "BOARD_CONFIG";
+    case TISCI_MSG_BOARD_CONFIG_RM:
+        return "BOARD_CONFIG_RM";
+    case TISCI_MSG_BOARD_CONFIG_SECURITY:
+        return "BOARD_CONFIG_SECURITY";
+    case TISCI_MSG_BOARD_CONFIG_PM:
+        return "BOARD_CONFIG_PM";
+    case TISCI_MSG_ENABLE_WDT:
+        return "ENABLE_WDT";
+    case TISCI_MSG_WAKE_RESET:
+        return "WAKE_RESET";
+    case TISCI_MSG_WAKE_REASON:
+        return "WAKE_REASON";
+    case TISCI_MSG_GOODBYE:
+        return "GOODBYE";
+    case TISCI_MSG_SYS_RESET:
+        return "SYS_RESET";
+    case TISCI_MSG_QUERY_MSMC:
+        return "QUERY_MSMC";
+    case TISCI_MSG_GET_TRACE_CONFIG:
+        return "GET_TRACE_CONFIG";
+    case TISCI_MSG_QUERY_FW_CAPS:
+        return "QUERY_FW_CAPS";
+    case TISCI_MSG_SET_CLOCK:
+        return "SET_CLOCK";
+    case TISCI_MSG_GET_CLOCK:
+        return "GET_CLOCK";
+    case TISCI_MSG_SET_CLOCK_PARENT:
+        return "SET_CLOCK_PARENT";
+    case TISCI_MSG_GET_CLOCK_PARENT:
+        return "GET_CLOCK_PARENT";
+    case TISCI_MSG_GET_NUM_CLOCK_PARENTS:
+        return "GET_NUM_CLOCK_PARENTS";
+    case TISCI_MSG_SET_FREQ:
+        return "SET_FREQ";
+    case TISCI_MSG_QUERY_FREQ:
+        return "QUERY_FREQ";
+    case TISCI_MSG_GET_FREQ:
+        return "GET_FREQ";
+    case TISCI_MSG_PROC_REQUEST:
+        return "PROC_REQUEST";
+    case TISCI_MSG_PROC_RELEASE:
+        return "PROC_RELEASE";
+    case TISCI_MSG_PROC_HANDOVER:
+        return "PROC_HANDOVER";
+    case TISCI_MSG_SET_CONFIG:
+        return "SET_CONFIG";
+    case TISCI_MSG_SET_CTRL:
+        return "SET_CTRL";
+    case TISCI_MSG_GET_STATUS:
+        return "GET_STATUS";
+    case TISCI_MSG_WAIT_PROC_BOOT_STATUS:
+        return "WAIT_PROC_BOOT_STATUS";
+    case TISCI_MSG_FWL_SET:
+        return "FWL_SET";
+    case TISCI_MSG_FWL_GET:
+        return "FWL_GET";
+    case TISCI_MSG_FWL_CHANGE_OWNER:
+        return "FWL_CHANGE_OWNER";
+    case TISCI_MSG_SA2UL_GET_DKEK:
+        return "SA2UL_GET_DKEK";
+    case TISCI_MSG_READ_SWREV:
+        return "READ_SWREV";
+    case TISCI_MSG_READ_KEYCNT_KEYREV:
+        return "READ_KEYCNT_KEYREV";
+    default:
+        return "UNKNOWN";
+    }
+}
+
+/*
+ * The DMSC has no MMIO. Sec-proxy calls us, when a client commits the last
+ * word of a request data window.
+ */
+static void ti_dmsc_handle_one(TIDmscClient *client, uint16_t thread_id,
+                               const uint32_t *words, size_t nwords);
+
+/*
+ * Push a response to the client's TX thread. Secure hosts carry a 4-byte
+ * {u16 checksum; u16 reserved} prefix before TISciMsgHdr. The checksum word
+ * is present in the transport, but not validated by this model.
+ *
+ * TI_SCI_FLAG_REQ_GENERIC_NORESPONSE is handled here too. The handlers run
+ * still for side effects, but replies are suppressed unless AOP was set.
+ */
+static size_t ti_dmsc_client_respond(TIDmscClient *client, const void *msg,
+                                     size_t nbytes)
+{
+    TIDmscState *s = client->dmsc;
+    const uint32_t *words = msg;
+
+    if (!client->cur_req_wants_resp) {
+        return nbytes;
+    }
+
+    if (client->secure) {
+        uint32_t buf[TI_DMSC_MAX_WORDS + 1] = {0};
+
+        /*
+         * Control the sec-proxy payload limit, not only the local scratch
+         * buffer. The scratch buffer has the extra secure-prefix word.
+         */
+        if (nbytes + sizeof(uint32_t) > TI_DMSC_SEC_PROXY_PAYLOAD_MAX) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "ti-dmsc: secure response too large (%zu bytes), dropping\n",
+                nbytes);
+            return 0;
+        }
+
+        memcpy((uint8_t *)buf + sizeof(uint32_t), words, nbytes);
+        return ti_sec_proxy_push_msg(s->sec_proxy, client->tx_thread_id, buf,
+                                     nbytes + sizeof(uint32_t));
+    }
+
+    if (nbytes > TI_DMSC_SEC_PROXY_PAYLOAD_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: response too large (%zu bytes), dropping\n",
+                      nbytes);
+        return 0;
+    }
+
+    return ti_sec_proxy_push_msg(s->sec_proxy, client->tx_thread_id, words,
+                                 nbytes);
+}
+
+/*
+ * Queue TISCI_MSG_BOOT_NOTIFICATION for secure boot hosts. SYSFW sends this
+ * unsolicited message once it is ready on the host response thread.
+ *
+ * Re-arm it on every reset: sec-proxy reset leaves thread slots alone. Reset
+ * the outbound counter first, since pushes only increment it.
+ */
+static void ti_dmsc_send_boot_notification(TIDmscClient *client)
+{
+    TISciMsgHdr notif = {0};
+
+    notif.type = TISCI_MSG_BOOT_NOTIFICATION;
+    notif.host = TISCI_HOST_ID_DMSC;
+    notif.seq = 0;
+    notif.flags = 0;
+
+    ti_sec_proxy_reset_thread_count(client->dmsc->sec_proxy,
+                                    client->tx_thread_id);
+
+    /*
+     * This is unsolicited, so ignore no-response state of the previous
+     * request and force delivery.
+     */
+    client->cur_req_wants_resp = true;
+
+    if (!ti_dmsc_client_respond(client, &notif, sizeof(notif))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push BOOT_NOTIFICATION into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/* Bottom half: handle pending message outside of MMIO context */
+static void ti_dmsc_bh(void *opaque)
+{
+    TIDmscState *s = opaque;
+    uint32_t local_words[TI_DMSC_MAX_WORDS];
+
+    while (true) {
+        TIDmscClient *client = NULL;
+        size_t local_nwords = 0;
+        uint16_t tid = 0;
+
+        qemu_mutex_lock(&s->lock);
+        for (uint32_t i = 0; i < s->num_clients; i++) {
+            if (s->clients[i].pending) {
+                client = &s->clients[i];
+                break;
+            }
+        }
+        if (!client) {
+            qemu_mutex_unlock(&s->lock);
+            return;
+        }
+
+        tid = client->rx_thread_id;
+        local_nwords = client->pending_nwords;
+        if (local_nwords > TI_DMSC_MAX_WORDS) {
+            local_nwords = TI_DMSC_MAX_WORDS;
+        }
+        memcpy(local_words, client->pending_words,
+               local_nwords * sizeof(uint32_t));
+        client->pending = false;
+        client->pending_nwords = 0;
+        qemu_mutex_unlock(&s->lock);
+
+        ti_dmsc_handle_one(client, tid, local_words, local_nwords);
+    }
+}
+
+/*
+ * Sec-proxy calls this, when a client commits a message on our RX thread.
+ */
+static void ti_dmsc_sec_proxy_cb(void *opaque, uint16_t thread_id,
+                                 const uint32_t *words, size_t nwords)
+{
+    TIDmscClient *client = opaque;
+    TIDmscState *s = client->dmsc;
+
+    if (thread_id != client->rx_thread_id) {
+        return;
+    }
+
+    qemu_mutex_lock(&s->lock);
+    client->pending = true;
+
+    if (nwords > TI_DMSC_MAX_WORDS) {
+        nwords = TI_DMSC_MAX_WORDS;
+    }
+    memcpy(client->pending_words, words, nwords * sizeof(uint32_t));
+    client->pending_nwords = nwords;
+    qemu_mutex_unlock(&s->lock);
+
+    qemu_bh_schedule(s->bh);
+}
+
+/* Dispatch one committed TISCI message. */
+static void ti_dmsc_handle_one(TIDmscClient *client, uint16_t thread_id,
+                               const uint32_t *words, size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+
+    if (!s->sec_proxy) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: No sec-proxy linked, dropping message\n");
+        return;
+    }
+
+    size_t hdr_words = sizeof(TISciMsgHdr) / sizeof(uint32_t);
+    size_t min_words = hdr_words + (client->secure ? 1 : 0);
+
+    if (nwords < min_words) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Short message (words=%zu), dropping\n", nwords);
+        return;
+    }
+
+    if (client->secure) {
+        /*
+         * Secure R5 clients prepend a checksum/reserved word before
+         * TISciMsgHdr. Drop it before we cast payloads.
+         */
+        words += 1;
+        nwords -= 1;
+    }
+
+    TISciMsgHdr hdr = {0};
+    memcpy(&hdr, words, MIN(sizeof(hdr), nwords * sizeof(uint32_t)));
+
+    /*
+     * Remember AOP before dispatch. ti_dmsc_client_respond() uses it to
+     * suppress replies for requests with TI_SCI_FLAG_REQ_GENERIC_NORESPONSE.
+     */
+    client->cur_req_wants_resp = (hdr.flags & TISCI_MSG_FLAG_AOP) != 0;
+
+    if (hdr.type < ARRAY_SIZE(s->msg_handler) && s->msg_handler[hdr.type]) {
+        trace_dmsc_new_message_received(
+            hdr.type, ti_dmsc_message_name_from_id(hdr.type),
+            ti_dmsc_host_name_from_id(hdr.host), thread_id);
+        s->msg_handler[hdr.type](client, &hdr, thread_id, words, nwords);
+        return;
+    } else {
+        TISciMsgHdr resp = hdr;
+
+        trace_dmsc_unsupported_message(
+            ti_dmsc_message_name_from_id(hdr.type), hdr.type,
+            ti_dmsc_host_name_from_id(hdr.host), thread_id);
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "ti-dmsc: No handler for message type=0x%04x (%s), dropping\n",
+            hdr.type, ti_dmsc_message_name_from_id(hdr.type));
+
+        /*
+         * Header-only NAKs unblock callers, which wait for a response,
+         * instead of leaving them to time out.
+         */
+        resp.flags = 0;
+        if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ti-dmsc: Failed to push NAK response into sec-proxy "
+                          "thread=%u\n",
+                          client->tx_thread_id);
+        }
+    }
+}
+
+static void ti_dmsc_reset_hold(Object *obj, ResetType type)
+{
+    TIDmscState *s = TI_DMSC(obj);
+
+    qemu_mutex_lock(&s->lock);
+    ti_dmsc_init_device_states(s);
+    for (uint32_t i = 0; i < s->num_clients; i++) {
+        s->clients[i].pending = false;
+        s->clients[i].pending_nwords = 0;
+        memset(s->clients[i].pending_words, 0,
+               sizeof(s->clients[i].pending_words));
+    }
+    /*
+     * msg_handler contains realize-time function pointers, not guest state.
+     * Clearing it during reset disables all TISCI handlers after the first
+     * cold reset.
+     */
+    qemu_mutex_unlock(&s->lock);
+
+    /*
+     * Secure clients get a fresh boot notification after every reset.
+     */
+    for (uint32_t i = 0; i < s->num_clients; i++) {
+        if (s->clients[i].secure) {
+            ti_dmsc_send_boot_notification(&s->clients[i]);
+        }
+    }
+}
+
+static TISciMsgHdr ti_dmsc_set_resp_flags(TISciMsgHdr *req_hdr, int add_flags)
+{
+    TISciMsgHdr resp = *req_hdr;
+    resp.flags =
+        ((req_hdr->flags & TISCI_MSG_FLAG_AOP) ? TISCI_MSG_FLAG_ACK : 0) |
+        add_flags;
+    return resp;
+}
+
+static void ti_dmsc_handle_set_clock(TIDmscClient *client, TISciMsgHdr *hdr,
+                                     uint16_t thread_id, const uint32_t *words,
+                                     size_t nwords)
+{
+    struct TisciMsgSetClockReq *req = (struct TisciMsgSetClockReq *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_set_clock(ti_dmsc_message_name_from_id(hdr->type),
+                                ti_dmsc_host_name_from_id(hdr->host),
+                                ti_dmsc_device_name_from_id(req->device),
+                                req->clk);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_CLOCK response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * SET_CLOCK_PARENT stores no clock tree state. The model only returns the
+ * generic TISCI ACK/NAK header.
+ */
+static void ti_dmsc_handle_set_clock_parent(TIDmscClient *client,
+                                            TISciMsgHdr *hdr,
+                                            uint16_t thread_id,
+                                            const uint32_t *words,
+                                            size_t nwords)
+{
+    struct TisciMsgSetClockParentReq *req =
+        (struct TisciMsgSetClockParentReq *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_set_clock_parent(ti_dmsc_message_name_from_id(hdr->type),
+                                       ti_dmsc_host_name_from_id(hdr->host),
+                                       ti_dmsc_device_name_from_id(req->dev_id),
+                                       req->clk_id, req->parent_id);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_CLOCK_PARENT response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_set_freq(TIDmscClient *client, TISciMsgHdr *hdr,
+                                    uint16_t thread_id, const uint32_t *words,
+                                    size_t nwords)
+{
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_FREQ response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_query_freq(TIDmscClient *client, TISciMsgHdr *hdr,
+                                      uint16_t thread_id, const uint32_t *words,
+                                      size_t nwords)
+{
+    struct TisciMsgQueryFreqReq *req = (struct TisciMsgQueryFreqReq *)words;
+    struct TisciMsgQueryFreqResp resp = {0};
+
+    trace_dmsc_handle_query_freq(ti_dmsc_message_name_from_id(hdr->type),
+                                 ti_dmsc_host_name_from_id(hdr->host),
+                                 ti_dmsc_device_name_from_id(req->device),
+                                 req->clk, req->clk32, req->target_freq_hz);
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.freq_hz = req->target_freq_hz;
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push QUERY_FREQ response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_get_freq(TIDmscClient *client, TISciMsgHdr *hdr,
+                                    uint16_t thread_id, const uint32_t *words,
+                                    size_t nwords)
+{
+    struct TisciMsgGetFreqReq *req = (struct TisciMsgGetFreqReq *)words;
+    struct TisciMsgQueryFreqResp resp = {0};
+
+    trace_dmsc_handle_get_freq(ti_dmsc_message_name_from_id(hdr->type),
+                               ti_dmsc_host_name_from_id(hdr->host),
+                               ti_dmsc_device_name_from_id(req->device),
+                               req->clk);
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    /*
+     * Clock rates are not modelled per device. Return the fixed 200 MHz
+     * rate used by the AM64x board model for generic clocks.
+     */
+    resp.freq_hz = 200000000ULL;
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push GET_FREQ response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_get_clock_parents(TIDmscClient *client,
+                                             TISciMsgHdr *hdr,
+                                             uint16_t thread_id,
+                                             const uint32_t *words,
+                                             size_t nwords)
+{
+    struct TisciMsgGetNumClockParentsReq *req =
+        (struct TisciMsgGetNumClockParentsReq *)words;
+    struct TisciMsgGetNumClockParentsResp resp = {0};
+
+    trace_dmsc_handle_get_clock_parents(
+        ti_dmsc_message_name_from_id(hdr->type),
+        ti_dmsc_host_name_from_id(hdr->host),
+        ti_dmsc_device_name_from_id(req->device), req->clk, req->clk32);
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    /*
+     * Clock parent topology is not modelled. Report two possible parents,
+     * which is the minimum topology where SET_CLOCK_PARENT has a meaning.
+     */
+    resp.num_parents = 2;
+    resp.num_parentint32_t = UINT_MAX;
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push GET_CLOCK_PARENTS response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * Clock muxes are not modelled. Report parent 0 as actual parent for all
+ * clocks.
+ */
+static void ti_dmsc_handle_get_clock_parent(TIDmscClient *client,
+                                            TISciMsgHdr *hdr,
+                                            uint16_t thread_id,
+                                            const uint32_t *words,
+                                            size_t nwords)
+{
+    struct TisciMsgGetClockParentResp resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.parent = 0;
+    resp.parent32 = 0;
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push GET_CLOCK_PARENT response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_get_clock(TIDmscClient *client, TISciMsgHdr *hdr,
+                                     uint16_t thread_id, const uint32_t *words,
+                                     size_t nwords)
+{
+    struct TisciMsgGetClockReq *req = (struct TisciMsgGetClockReq *)words;
+    struct TisciMsgGetClockResp resp = {0};
+
+    trace_dmsc_handle_get_clock(ti_dmsc_message_name_from_id(hdr->type),
+                                ti_dmsc_host_name_from_id(hdr->host),
+                                ti_dmsc_device_name_from_id(req->device),
+                                req->clk, req->clk32);
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.current_state = resp.programmed_state =
+        TISCI_MSG_VALUE_DEVICE_HW_STATE_ON;
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push GET_CLOCK response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_stop_proc(TIDmscClient *client, TISciMsgHdr *hdr,
+                              uint16_t thread_id, const uint32_t *words,
+                              size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+    struct TiSciMsgReqProcRelease *req = (struct TiSciMsgReqProcRelease *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+    trace_dmsc_stop_proc(ti_dmsc_proc_name_from_id(req->processor_id),
+                         req->processor_id,
+                         ti_dmsc_host_name_from_id(hdr->host));
+
+    if (req->processor_id == SCICLIENT_PROCID_MCU_M4FSS0_C0) {
+        s->m4_running = false;
+    }
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push PROC_RELEASE response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_start_proc(TIDmscClient *client, TISciMsgHdr *hdr,
+                               uint16_t thread_id, const uint32_t *words,
+                               size_t nwords)
+{
+    struct TiSciMsgReqProcRequest *req = (struct TiSciMsgReqProcRequest *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_start_proc(ti_dmsc_proc_name_from_id(req->processor_id),
+                          req->processor_id,
+                          ti_dmsc_host_name_from_id(hdr->host));
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push PROC_REQUEST response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * SET_CTRL carries processor control flags, e.g. halt and reset-vector
+ * latch. Boot vectors are captured by SET_CONFIG and release happens via
+ * SET_DEVICE, so here is no processor-control state modeled.
+ */
+static void ti_dmsc_handle_proc_set_ctrl(TIDmscClient *client, TISciMsgHdr *hdr,
+                                         uint16_t thread_id,
+                                         const uint32_t *words, size_t nwords)
+{
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_CTRL response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * PROC_HANDOVER transfers a processor to another TISCI host. Ownership is
+ * not modeled; the request gets only the generic ACK/NAK header.
+ */
+static void ti_dmsc_handover_proc(TIDmscClient *client, TISciMsgHdr *hdr,
+                                  uint16_t thread_id, const uint32_t *words,
+                                  size_t nwords)
+{
+    struct TiSciMsgReqProcHandover *req =
+        (struct TiSciMsgReqProcHandover *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handover_proc(ti_dmsc_proc_name_from_id(req->processor_id),
+                             req->processor_id,
+                             ti_dmsc_host_name_from_id(req->host_id),
+                             ti_dmsc_host_name_from_id(hdr->host));
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push PROC_HANDOVER response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * SYS_RESET is a TISCI system-reset command and is normally sent without
+ * AOP. Request a QEMU system reset; an AOP caller gets the bare ACK first.
+ */
+static void ti_dmsc_handle_sys_reset(TIDmscClient *client, TISciMsgHdr *hdr,
+                                     uint16_t thread_id, const uint32_t *words,
+                                     size_t nwords)
+{
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_sys_reset(ti_dmsc_message_name_from_id(hdr->type),
+                                ti_dmsc_host_name_from_id(hdr->host));
+
+    ti_dmsc_client_respond(client, &resp, sizeof(resp));
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static void ti_dmsc_query_hw_caps(TIDmscClient *client, TISciMsgHdr *hdr,
+                                  uint16_t thread_id, const uint32_t *words,
+                                  size_t nwords)
+{
+    struct TiSciMsgQueryFwCapsResp resp = {0};
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.fw_caps = MSG_FLAG_CAPS_GENERIC;
+    trace_dmsc_get_fw_caps(ti_dmsc_message_name_from_id(hdr->type),
+                           ti_dmsc_host_name_from_id(hdr->host));
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push FW CAPABILITIES response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_get_version(TIDmscClient *client, TISciMsgHdr *hdr,
+                                uint16_t thread_id, const uint32_t *words,
+                                size_t nwords)
+{
+    struct TiSciMsgVersionResp resp = {0};
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.firmware_revision = 0x000a;
+    resp.abi_major = 4;
+    resp.abi_minor = 0;
+    snprintf(resp.firmware_description, sizeof(resp.firmware_description),
+             "QEMU_TI_DMSC (Wadims DMSC)");
+    trace_dmsc_get_version(ti_dmsc_message_name_from_id(hdr->type),
+                           ti_dmsc_host_name_from_id(hdr->host),
+                           resp.firmware_description);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push VERSION response into sec-proxy "
+                      "thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_get_device(TIDmscClient *client, TISciMsgHdr *hdr,
+                                      uint16_t thread_id, const uint32_t *words,
+                                      size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+    struct TisciMsgGetDeviceReq *req = (struct TisciMsgGetDeviceReq *)words;
+    struct TisciMsgGetDeviceResp resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    if (req->id < TISCI_DEV_ID_MAX) {
+        resp.current_state = s->dev_hw_state[req->id];
+        resp.programmed_state = s->dev_prog_state[req->id];
+    } else {
+        resp.current_state = resp.programmed_state =
+            TISCI_MSG_VALUE_DEVICE_HW_STATE_ON;
+    }
+
+    trace_dmsc_handle_get_device(ti_dmsc_message_name_from_id(hdr->type),
+                                 ti_dmsc_host_name_from_id(hdr->host),
+                                 ti_dmsc_device_name_from_id(req->id),
+                                 resp.programmed_state, resp.current_state);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push GET_DEVICE response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_get_status(TIDmscClient *client, TISciMsgHdr *hdr,
+                                      uint16_t thread_id, const uint32_t *words,
+                                      size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+    struct TisciMsgProcGetStatusReq *req =
+        (struct TisciMsgProcGetStatusReq *)words;
+    struct TisciMsgProcGetStatusResp resp = {0};
+
+    trace_dmsc_handle_get_status(ti_dmsc_message_name_from_id(hdr->type),
+                                 ti_dmsc_host_name_from_id(hdr->host),
+                                 ti_dmsc_proc_name_from_id(req->processor_id),
+                                 req->processor_id);
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.processor_id = req->processor_id;
+    resp.bootvector_lo = 0;
+    resp.bootvector_hi = 0;
+    resp.config_flags_1 = 0;
+    resp.control_flags_1 = 0;
+    resp.status_flags_1 = 0;
+
+    if (req->processor_id == SCICLIENT_PROCID_A53_CL0_C0 ||
+        req->processor_id == SCICLIENT_PROCID_A53_CL0_C1) {
+        uint64_t bv =
+            s->proc_bootvector[req->processor_id - SCICLIENT_PROCID_A53_CL0_C0];
+
+        resp.bootvector_lo = (uint32_t)bv;
+        resp.bootvector_hi = (uint32_t)(bv >> 32);
+    }
+
+    if (req->processor_id == SCICLIENT_PROCID_MCU_M4FSS0_C0) {
+        resp.status_flags_1 |= TISCI_MSG_VAL_PROC_BOOT_STATUS_FLAG_M4F_WFI;
+    }
+
+    trace_dmsc_get_status_resp(ti_dmsc_proc_name_from_id(req->processor_id),
+                               req->processor_id, resp.status_flags_1,
+                               s->m4_running);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push GET_STATUS response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * WAIT_PROC_BOOT_STATUS waits for processor WFE/WFI status bits. Per-core
+ * polling is not modeled; no-response requests complete without a reply.
+ */
+static void ti_dmsc_handle_wait_proc_boot_status(TIDmscClient *client,
+                                                 TISciMsgHdr *hdr,
+                                                 uint16_t thread_id,
+                                                 const uint32_t *words,
+                                                 size_t nwords)
+{
+    struct TisciMsgReqWaitProcBootStatus *req =
+        (struct TisciMsgReqWaitProcBootStatus *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_wait_proc_boot_status(
+        ti_dmsc_message_name_from_id(hdr->type),
+        ti_dmsc_host_name_from_id(hdr->host),
+        ti_dmsc_proc_name_from_id(req->processor_id), req->processor_id);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push WAIT_PROC_BOOT_STATUS response "
+                      "into sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_set_device_state(TIDmscClient *client,
+                                            TISciMsgHdr *hdr,
+                                            uint16_t thread_id,
+                                            const uint32_t *words,
+                                            size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+    struct TisciMsgSetDeviceReq *req = (struct TisciMsgSetDeviceReq *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_set_device_state(ti_dmsc_message_name_from_id(hdr->type),
+                                       ti_dmsc_host_name_from_id(hdr->host),
+                                       ti_dmsc_device_name_from_id(req->id),
+                                       ti_dmsc_device_state_to_str(req->state));
+
+    if (req->id < TISCI_DEV_ID_MAX) {
+        s->dev_hw_state[req->id] = s->dev_prog_state[req->id] = req->state;
+    }
+
+    if (req->id == TISCI_DEV_MCU_M4FSS0_CORE0 &&
+        req->state != TISCI_MSG_VALUE_DEVICE_SW_STATE_ON) {
+        s->m4_running = false;
+    }
+
+    /*
+     * SET_DEVICE ON releases an A53 core at the vector captured by
+     * SET_CONFIG. Start the vCPU in EL3/AArch64; ALREADY_ON is harmless on
+     * repeated handoffs.
+     */
+    if (req->id == TISCI_DEV_A53SS0_CORE_0 ||
+        req->id == TISCI_DEV_A53SS0_CORE_1) {
+        int core = req->id - TISCI_DEV_A53SS0_CORE_0;
+        uint64_t cpuid = s->a53_cpu_id_base + core;
+
+        if (req->state == TISCI_MSG_VALUE_DEVICE_SW_STATE_ON) {
+            uint64_t entry = s->proc_bootvector[core];
+
+            trace_dmsc_a53_start(core, entry);
+            arm_set_cpu_on(cpuid, entry, 0, /* target_el */ 3,
+                           /* target_aa64 */ true);
+        } else if (req->state == TISCI_MSG_VALUE_DEVICE_SW_STATE_AUTO_OFF) {
+            trace_dmsc_a53_stop(core);
+            arm_set_cpu_off(cpuid);
+        }
+    }
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_DEVICE response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_set_device_resets(TIDmscClient *client,
+                                             TISciMsgHdr *hdr,
+                                             uint16_t thread_id,
+                                             const uint32_t *words,
+                                             size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+    struct TisciMsgSetDeviceResetsReq *req =
+        (struct TisciMsgSetDeviceResetsReq *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_set_device_resets(ti_dmsc_message_name_from_id(hdr->type),
+                                        ti_dmsc_host_name_from_id(hdr->host),
+                                        ti_dmsc_device_name_from_id(req->id),
+                                        req->resets);
+
+    if (req->id == TISCI_DEV_MCU_M4FSS0_CORE0) {
+        s->m4_running = !(req->resets);
+        if (req->resets == 1) {
+            arm_set_cpu_off(s->m4_cpu_id);
+        } else {
+            arm_set_cpu_on_and_reset(s->m4_cpu_id);
+        }
+    }
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_DEVICE_RESETS response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * BOARD_CONFIG messages carry SYSFW board-configuration blobs. This model
+ * accepts them, but does not consume or store the blobs.
+ */
+static void ti_dmsc_handle_board_config(TIDmscClient *client, TISciMsgHdr *hdr,
+                                        uint16_t thread_id,
+                                        const uint32_t *words, size_t nwords)
+{
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push BOARD_CONFIG response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * SET_CONFIG carries the A53 boot vector used later by SET_DEVICE. The
+ * packed TISCI request puts bootvector_low at byte offset 9, so read it
+ * with byte loads, not with a struct cast.
+ */
+static void ti_dmsc_handle_proc_set_config(TIDmscClient *client,
+                                           TISciMsgHdr *hdr, uint16_t thread_id,
+                                           const uint32_t *words, size_t nwords)
+{
+    TIDmscState *s = client->dmsc;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_proc_set_config(ti_dmsc_message_name_from_id(hdr->type),
+                                      ti_dmsc_host_name_from_id(hdr->host));
+
+    if (nwords * sizeof(uint32_t) >= sizeof(TISciMsgHdr) + 9) {
+        /* Packed payload right after the 8-byte header. */
+        const uint8_t *p = (const uint8_t *)words + sizeof(TISciMsgHdr);
+        uint8_t proc_id = p[0];
+        uint64_t bv = (uint64_t)(uint32_t)ldl_le_p(p + 1) |
+                      ((uint64_t)(uint32_t)ldl_le_p(p + 5) << 32);
+
+        if (proc_id == SCICLIENT_PROCID_A53_CL0_C0 ||
+            proc_id == SCICLIENT_PROCID_A53_CL0_C1) {
+            s->proc_bootvector[proc_id - SCICLIENT_PROCID_A53_CL0_C0] = bv;
+            trace_dmsc_a53_bootvector(proc_id, bv);
+        }
+    }
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SET_CONFIG response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * FWL_SET programs a firewall region. Firewall state is not modelled, so the
+ * request is accepted and only a generic ACK/NAK is returned.
+ */
+static void ti_dmsc_handle_fwl_set(TIDmscClient *client, TISciMsgHdr *hdr,
+                                   uint16_t thread_id, const uint32_t *words,
+                                   size_t nwords)
+{
+    struct TisciMsgReqFwlSetFirewallRegion *req =
+        (struct TisciMsgReqFwlSetFirewallRegion *)words;
+    TISciMsgHdr resp = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_fwl_set(ti_dmsc_message_name_from_id(hdr->type),
+                              ti_dmsc_host_name_from_id(hdr->host), req->fwl_id,
+                              req->region);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push FWL_SET response into sec-proxy "
+                      "thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * FWL_GET returns one firewall region descriptor. The model echoes fwl_id
+ * and region, and leaves control/permission fields zeroed.
+ */
+static void ti_dmsc_handle_fwl_get(TIDmscClient *client, TISciMsgHdr *hdr,
+                                   uint16_t thread_id, const uint32_t *words,
+                                   size_t nwords)
+{
+    struct TisciMsgReqFwlGetFirewallRegion *req =
+        (struct TisciMsgReqFwlGetFirewallRegion *)words;
+    struct TisciMsgRespFwlGetFirewallRegion resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.fwl_id = req->fwl_id;
+    resp.region = req->region;
+
+    trace_dmsc_handle_fwl_get(ti_dmsc_message_name_from_id(hdr->type),
+                              ti_dmsc_host_name_from_id(hdr->host), req->fwl_id,
+                              req->region);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push FWL_GET response into sec-proxy "
+                      "thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * FWL_CHANGE_OWNER changes the owner of a firewall region. Ownership is not
+ * tracked; echo the IDs and owner index back.
+ */
+static void ti_dmsc_handle_fwl_change_owner(TIDmscClient *client,
+                                            TISciMsgHdr *hdr,
+                                            uint16_t thread_id,
+                                            const uint32_t *words,
+                                            size_t nwords)
+{
+    struct TisciMsgReqFwlChangeOwnerInfo *req =
+        (struct TisciMsgReqFwlChangeOwnerInfo *)words;
+    struct TisciMsgRespFwlChangeOwnerInfo resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+    resp.fwl_id = req->fwl_id;
+    resp.region = req->region;
+    resp.owner_index = req->owner_index;
+
+    trace_dmsc_handle_fwl_change_owner(ti_dmsc_message_name_from_id(hdr->type),
+                                       ti_dmsc_host_name_from_id(hdr->host),
+                                       req->fwl_id, req->region,
+                                       req->owner_index);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push FWL_CHANGE_OWNER response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * SA2UL_GET_DKEK returns derived key data from SA2UL. No key ladder is
+ * modelled; the response contains zero bytes and is no secret material.
+ */
+static void ti_dmsc_handle_sa2ul_get_dkek(TIDmscClient *client,
+                                          TISciMsgHdr *hdr, uint16_t thread_id,
+                                          const uint32_t *words, size_t nwords)
+{
+    struct TisciMsgReqSa2ulGetDkek *req =
+        (struct TisciMsgReqSa2ulGetDkek *)words;
+    struct TisciMsgRespSa2ulGetDkek resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_sa2ul_get_dkek(ti_dmsc_message_name_from_id(hdr->type),
+                                     ti_dmsc_host_name_from_id(hdr->host),
+                                     req->sa2ul_instance);
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push SA2UL_GET_DKEK response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+/*
+ * READ_SWREV and READ_KEYCNT_KEYREV are security status queries. The status
+ * words are not modelled and read back as zero.
+ */
+static void ti_dmsc_handle_read_swrev(TIDmscClient *client, TISciMsgHdr *hdr,
+                                      uint16_t thread_id, const uint32_t *words,
+                                      size_t nwords)
+{
+    struct TisciMsgRespReadSwrev resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_read_swrev(ti_dmsc_message_name_from_id(hdr->type),
+                                 ti_dmsc_host_name_from_id(hdr->host));
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push READ_SWREV response into "
+                      "sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_handle_read_keycnt_keyrev(TIDmscClient *client,
+                                              TISciMsgHdr *hdr,
+                                              uint16_t thread_id,
+                                              const uint32_t *words,
+                                              size_t nwords)
+{
+    struct TisciMsgRespReadKeycntKeyrev resp = {0};
+
+    resp.hdr = ti_dmsc_set_resp_flags(hdr, 0);
+
+    trace_dmsc_handle_read_keycnt_keyrev(
+        ti_dmsc_message_name_from_id(hdr->type),
+        ti_dmsc_host_name_from_id(hdr->host));
+
+    if (!ti_dmsc_client_respond(client, &resp, sizeof(resp))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: Failed to push READ_KEYCNT_KEYREV response "
+                      "into sec-proxy thread=%u\n",
+                      client->tx_thread_id);
+    }
+}
+
+static void ti_dmsc_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    TIDmscState *s = TI_DMSC(dev);
+
+    if (!s->sec_proxy) {
+        error_setg(errp, "ti-dmsc: 'sec-proxy' link not set");
+        return;
+    }
+
+    s->msg_words = ti_sec_proxy_get_msg_words(s->sec_proxy);
+    if (s->msg_words == 0) {
+        /* Fallback if sec-proxy does not provide it yet. */
+        s->msg_words = TI_DMSC_MAX_WORDS;
+    }
+
+    if (s->msg_words > TI_DMSC_MAX_WORDS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ti-dmsc: msg_words=%u too large, clamping to %u\n",
+                      s->msg_words, TI_DMSC_MAX_WORDS);
+        s->msg_words = TI_DMSC_MAX_WORDS;
+    }
+
+    if (s->num_rx_threads || s->num_tx_threads) {
+        if (s->num_rx_threads != s->num_tx_threads) {
+            error_setg(
+                errp,
+                "ti-dmsc: rx-threads and tx-threads must have the same length");
+            return;
+        }
+        if (s->num_rx_threads == 0) {
+            error_setg(errp, "ti-dmsc: rx-threads list is empty");
+            return;
+        }
+        s->num_clients = s->num_rx_threads;
+        s->clients = g_new0(TIDmscClient, s->num_clients);
+        for (uint32_t i = 0; i < s->num_clients; i++) {
+            s->clients[i].dmsc = s;
+            s->clients[i].rx_thread_id = s->rx_thread_ids[i];
+            s->clients[i].tx_thread_id = s->tx_thread_ids[i];
+        }
+    } else {
+        s->num_clients = 1;
+        s->clients = g_new0(TIDmscClient, s->num_clients);
+        s->clients[0].dmsc = s;
+        s->clients[0].rx_thread_id = s->rx_thread_id;
+        s->clients[0].tx_thread_id = s->tx_thread_id;
+    }
+
+    for (uint32_t i = 0; i < s->num_clients; i++) {
+        for (uint32_t j = 0; j < s->num_secure_rx_threads; j++) {
+            if (s->clients[i].rx_thread_id == s->secure_rx_threads[j]) {
+                s->clients[i].secure = true;
+                break;
+            }
+        }
+    }
+
+    s->msg_handler[TISCI_MSG_PROC_RELEASE] = ti_dmsc_stop_proc;
+    s->msg_handler[TISCI_MSG_PROC_REQUEST] = ti_dmsc_start_proc;
+    s->msg_handler[TISCI_MSG_PROC_HANDOVER] = ti_dmsc_handover_proc;
+    s->msg_handler[TISCI_MSG_SET_CTRL] = ti_dmsc_handle_proc_set_ctrl;
+    s->msg_handler[TISCI_MSG_SYS_RESET] = ti_dmsc_handle_sys_reset;
+    s->msg_handler[TISCI_MSG_QUERY_FW_CAPS] = ti_dmsc_query_hw_caps;
+    s->msg_handler[TISCI_MSG_VERSION] = ti_dmsc_get_version;
+    s->msg_handler[TISCI_MSG_GET_DEVICE] = ti_dmsc_handle_get_device;
+    s->msg_handler[TISCI_MSG_SET_DEVICE] = ti_dmsc_handle_set_device_state;
+    s->msg_handler[TISCI_MSG_GET_STATUS] = ti_dmsc_handle_get_status;
+    s->msg_handler[TISCI_MSG_WAIT_PROC_BOOT_STATUS] =
+        ti_dmsc_handle_wait_proc_boot_status;
+    s->msg_handler[TISCI_MSG_SET_DEVICE_RESETS] =
+        ti_dmsc_handle_set_device_resets;
+    s->msg_handler[TISCI_MSG_GET_CLOCK] = ti_dmsc_handle_get_clock;
+    s->msg_handler[TISCI_MSG_SET_CLOCK] = ti_dmsc_handle_set_clock;
+    s->msg_handler[TISCI_MSG_GET_CLOCK_PARENT] =
+        ti_dmsc_handle_get_clock_parent;
+    s->msg_handler[TISCI_MSG_GET_NUM_CLOCK_PARENTS] =
+        ti_dmsc_handle_get_clock_parents;
+    s->msg_handler[TISCI_MSG_SET_CLOCK_PARENT] =
+        ti_dmsc_handle_set_clock_parent;
+    s->msg_handler[TISCI_MSG_QUERY_FREQ] = ti_dmsc_handle_query_freq;
+    s->msg_handler[TISCI_MSG_GET_FREQ] = ti_dmsc_handle_get_freq;
+    s->msg_handler[TISCI_MSG_SET_FREQ] = ti_dmsc_handle_set_freq;
+    s->msg_handler[TISCI_MSG_SET_CONFIG] = ti_dmsc_handle_proc_set_config;
+    s->msg_handler[TISCI_MSG_BOARD_CONFIG] = ti_dmsc_handle_board_config;
+    s->msg_handler[TISCI_MSG_BOARD_CONFIG_RM] = ti_dmsc_handle_board_config;
+    s->msg_handler[TISCI_MSG_BOARD_CONFIG_SECURITY] =
+        ti_dmsc_handle_board_config;
+    s->msg_handler[TISCI_MSG_BOARD_CONFIG_PM] = ti_dmsc_handle_board_config;
+    s->msg_handler[TISCI_MSG_FWL_SET] = ti_dmsc_handle_fwl_set;
+    s->msg_handler[TISCI_MSG_FWL_GET] = ti_dmsc_handle_fwl_get;
+    s->msg_handler[TISCI_MSG_FWL_CHANGE_OWNER] =
+        ti_dmsc_handle_fwl_change_owner;
+    s->msg_handler[TISCI_MSG_SA2UL_GET_DKEK] = ti_dmsc_handle_sa2ul_get_dkek;
+    s->msg_handler[TISCI_MSG_READ_SWREV] = ti_dmsc_handle_read_swrev;
+    s->msg_handler[TISCI_MSG_READ_KEYCNT_KEYREV] =
+        ti_dmsc_handle_read_keycnt_keyrev;
+
+    for (uint32_t i = 0; i < s->num_clients; i++) {
+        ti_sec_proxy_register_msg_cb(s->sec_proxy, s->clients[i].rx_thread_id,
+                                     ti_dmsc_sec_proxy_cb, &s->clients[i]);
+    }
+
+    ti_dmsc_init_device_states(s);
+
+    /*
+     * ti-dmsc is a pure QOM child with no bus/MMIO reset path. Register it
+     * with the global reset container, so cold boot and system_reset both
+     * requeue the DMSC boot notification.
+     */
+    qemu_register_resettable(OBJECT(dev));
+}
+
+static void ti_dmsc_init(Object *obj)
+{
+    TIDmscState *s = TI_DMSC(obj);
+
+    qemu_mutex_init(&s->lock);
+    s->bh = qemu_bh_new(ti_dmsc_bh, s);
+    s->num_rx_threads = 0;
+    s->rx_thread_ids = NULL;
+    s->num_tx_threads = 0;
+    s->tx_thread_ids = NULL;
+    s->num_secure_rx_threads = 0;
+    s->secure_rx_threads = NULL;
+    s->num_clients = 0;
+    s->clients = NULL;
+
+    /*
+     * Legacy single-client defaults; machines pass normally thread arrays.
+     */
+    /* Legacy M4 response thread default: 16. */
+
+    s->msg_words = TI_DMSC_MAX_WORDS;
+    object_property_add_link(
+        obj, "sec-proxy", TYPE_TI_SEC_PROXY, (Object **)&s->sec_proxy,
+        qdev_prop_allow_set_link_before_realize, OBJ_PROP_LINK_STRONG);
+}
+
+static void ti_dmsc_finalize(Object *obj)
+{
+    TIDmscState *s = TI_DMSC(obj);
+
+    if (s->bh) {
+        qemu_bh_delete(s->bh);
+        s->bh = NULL;
+    }
+    g_free(s->clients);
+    s->clients = NULL;
+    s->num_clients = 0;
+    g_free(s->rx_thread_ids);
+    s->rx_thread_ids = NULL;
+    s->num_rx_threads = 0;
+    g_free(s->tx_thread_ids);
+    s->tx_thread_ids = NULL;
+    s->num_tx_threads = 0;
+    g_free(s->secure_rx_threads);
+    s->secure_rx_threads = NULL;
+    s->num_secure_rx_threads = 0;
+    qemu_mutex_destroy(&s->lock);
+}
+
+static const Property ti_dmsc_props[] = {
+    DEFINE_PROP_UINT16("rx-thread", TIDmscState, rx_thread_id, 17),
+    DEFINE_PROP_UINT16("tx-thread", TIDmscState, tx_thread_id, 16),
+    DEFINE_PROP_ARRAY("rx-threads", TIDmscState, num_rx_threads, rx_thread_ids,
+                      qdev_prop_uint16, uint16_t),
+    DEFINE_PROP_ARRAY("tx-threads", TIDmscState, num_tx_threads, tx_thread_ids,
+                      qdev_prop_uint16, uint16_t),
+    DEFINE_PROP_ARRAY("secure-rx-threads", TIDmscState, num_secure_rx_threads,
+                      secure_rx_threads, qdev_prop_uint16, uint16_t),
+    DEFINE_PROP_UINT64("m4-cpu-id", TIDmscState, m4_cpu_id, 0),
+    DEFINE_PROP_UINT64("a53-cpu-id-base", TIDmscState, a53_cpu_id_base, 0),
+};
+
+static void ti_dmsc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = ti_dmsc_realize;
+    rc->phases.hold = ti_dmsc_reset_hold;
+    device_class_set_props(dc, ti_dmsc_props);
+}
+
+static const TypeInfo ti_dmsc_info = {
+    .name = TYPE_TI_DMSC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(TIDmscState),
+    .instance_init = ti_dmsc_init,
+    .instance_finalize = ti_dmsc_finalize,
+    .class_init = ti_dmsc_class_init,
+};
+
+static void ti_dmsc_types(void)
+{
+    type_register_static(&ti_dmsc_info);
+}
+
+type_init(ti_dmsc_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index dfa2d04117..d6fac538b4 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -456,6 +456,38 @@ iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actu
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
 
+# ti-dmsc.c
+dmsc_handle_set_clock(const char *type, const char *host_name, const char *device_name, int clk) "%s received from host %s, device %s, clk: %i"
+dmsc_handle_get_device(const char *type, const char *host_name, const char *device_name, uint8_t prog_state, uint8_t current_state) "%s received from host %s, device %s, response: prog_state: %i, current_state: %i"
+dmsc_handle_get_clock(const char *type, const char *host_name, const char *device_name, uint8_t clk, uint32_t clk32) "%s received from host %s, device %s, clk %u, clk32 %u"
+dmsc_handle_get_clock_parents(const char *type, const char *host_name, const char *device_name, uint8_t clk, uint32_t clk32) "%s received from host %s, device %s, clk %u, clk32 %u"
+dmsc_handle_set_clock_parent(const char *type, const char *host_name, const char *device_name, uint8_t clk_id, uint8_t parent_id) "%s received from host %s, device %s, clk_id %u, parent_id %u"
+dmsc_handle_query_freq(const char *type, const char *host_name, const char *device_name, uint8_t clk, uint32_t clk32, uint64_t target_freq) "%s received from host %s, device %s, clk %u, clk32 %u, target_frequency %"PRIu64
+dmsc_handle_get_freq(const char *type, const char *host_name, const char *device_name, uint8_t clk) "%s received from host %s, device %s, clk %u"
+dmsc_handle_proc_set_config(const char *type, const char *host_name) "%s received from host %s"
+dmsc_handle_set_device_state(const char *type, const char *host_name, const char *device_name, const char *state) "%s received from host %s, device %s, state %s"
+dmsc_handle_set_device_resets(const char *type, const char *host_name, const char *device_name, uint32_t resets) "%s received from host %s, device %s, resets 0x%08x"
+dmsc_handle_get_status(const char *type, const char *host_name, const char *proc_name, uint8_t proc_id) "%s received from host %s, proc %s (%u)"
+dmsc_handle_wait_proc_boot_status(const char *type, const char *host_name, const char *proc_name, uint8_t proc_id) "%s received from host %s, proc %s (%u)"
+dmsc_get_status_resp(const char *proc_name, uint8_t proc_id, uint32_t status_flags, int m4_running) "GET_STATUS response for %s (%u): status_flags=0x%08x, m4_running=%d"
+dmsc_unsupported_message(const char *msg, int type, const char *host, int thread_id) "No handler for message type=%s (%i) from host %s ... (thread id: %i) dropping"
+dmsc_new_message_received(int type, const char *msg, const char *host, int thread_id) "Handling message type=0x%04x (%s) from host=%s, thread=%u"
+dmsc_get_version(const char* msg, const char *host, const char *description) "Get Version received %s from host %s. Description returned %s"
+dmsc_get_fw_caps(const char* msg, const char *host) "Get FW Caps Request received %s from host %s"
+dmsc_start_proc(const char* proc_name, int proc_id, const char *host) "Requested to start Processor %s (%i) from host %s"
+dmsc_stop_proc(const char* proc_name, int proc_id, const char *host) "Requested to stop Processor %s (%i) from host %s"
+dmsc_handover_proc(const char* proc_name, int proc_id, const char *new_host, const char *host) "Requested to hand over Processor %s (%i) to host %s, from host %s"
+dmsc_a53_bootvector(uint8_t proc_id, uint64_t bootvector) "Captured boot vector for A53 proc %u: 0x%" PRIx64
+dmsc_a53_start(int core, uint64_t entry) "Cold-starting A53 core %d at entry 0x%" PRIx64 " (EL3/AArch64)"
+dmsc_a53_stop(int core) "Powering off A53 core %d"
+dmsc_handle_sys_reset(const char *type, const char *host_name) "%s received from host %s, requesting machine reset"
+dmsc_handle_fwl_set(const char *type, const char *host_name, uint16_t fwl_id, uint16_t region) "%s received from host %s, fwl_id %u, region %u"
+dmsc_handle_fwl_get(const char *type, const char *host_name, uint16_t fwl_id, uint16_t region) "%s received from host %s, fwl_id %u, region %u"
+dmsc_handle_fwl_change_owner(const char *type, const char *host_name, uint16_t fwl_id, uint16_t region, uint8_t owner_index) "%s received from host %s, fwl_id %u, region %u, owner_index %u"
+dmsc_handle_sa2ul_get_dkek(const char *type, const char *host_name, uint8_t sa2ul_instance) "%s received from host %s, sa2ul_instance %u (returning zeroed DKEK)"
+dmsc_handle_read_swrev(const char *type, const char *host_name) "%s received from host %s (returning swrev=0)"
+dmsc_handle_read_keycnt_keyrev(const char *type, const char *host_name) "%s received from host %s (returning keycnt=keyrev=0)"
+
 # ti-rat.c
 rat_enable_region(int idx, uint64_t size, uint64_t source, uint64_t dest) "Enabling RAT Region %u: size 0x%"PRIx64" map 0x%"PRIx64" -> 0x%"PRIx64
 rat_disable_region(int idx) "Disabling RAT Region %u"
diff --git a/include/hw/misc/ti-dmsc.h b/include/hw/misc/ti-dmsc.h
new file mode 100644
index 0000000000..f918890180
--- /dev/null
+++ b/include/hw/misc/ti-dmsc.h
@@ -0,0 +1,661 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * TI DMSC emulator device (minimal TISCI service)
+ *
+ * This device links to a TI SEC_PROXY instance and provides the minimal
+ * DMSC/TISCI request/response handler.
+ */
+
+#ifndef HW_MISC_TI_DMSC_H
+#define HW_MISC_TI_DMSC_H
+
+#include "qemu/compiler.h"
+#include "hw/core/qdev.h"
+#include "hw/misc/ti-sec-proxy.h"
+
+#define TISCI_MSG_VALUE_DEVICE_SW_STATE_AUTO_OFF 0
+
+/** Used by TISCI_MSG_SET_DEVICE to disable device but keep in retention. */
+#define TISCI_MSG_VALUE_DEVICE_SW_STATE_RETENTION 1
+
+/** Used by TISCI_MSG_SET_DEVICE to turn device on for usage. */
+#define TISCI_MSG_VALUE_DEVICE_SW_STATE_ON 2
+
+/* Device is off in TISCI_MSG_GET_DEVICE response. */
+#define TISCI_MSG_VALUE_DEVICE_HW_STATE_OFF 0
+
+/* Device is on in TISCI_MSG_GET_DEVICE response. */
+#define TISCI_MSG_VALUE_DEVICE_HW_STATE_ON 1
+
+/*
+ * Device is changing state. The state may remain until dependent hardware,
+ * e.g. pending IRQ handshakes, allows to complete the transition.
+ */
+#define TISCI_MSG_VALUE_DEVICE_HW_STATE_TRANS 2
+
+/** DMSC(Secure): Device Management and Security Control */
+#define TISCI_HOST_ID_DMSC (0U)
+/** MAIN_0_R5_0(Secure): Cortex R5_0 context 0 on Main island(BOOT) */
+#define TISCI_HOST_ID_MAIN_0_R5_0 (35U)
+/** MAIN_0_R5_1(Non Secure): Cortex R5_0 context 1 on Main island */
+#define TISCI_HOST_ID_MAIN_0_R5_1 (36U)
+/** MAIN_0_R5_2(Secure): Cortex R5_0 context 2 on Main island */
+#define TISCI_HOST_ID_MAIN_0_R5_2 (37U)
+/** MAIN_0_R5_3(Non Secure): Cortex R5_0 context 3 on Main island */
+#define TISCI_HOST_ID_MAIN_0_R5_3 (38U)
+/** A53_0(Secure): Cortex a53 context 0 on Main island */
+#define TISCI_HOST_ID_A53_0 (10U)
+/** A53_1(Secure): Cortex A53 context 1 on Main island */
+#define TISCI_HOST_ID_A53_1 (11U)
+/** A53_2(Non Secure): Cortex A53 context 2 on Main island */
+#define TISCI_HOST_ID_A53_2 (12U)
+/** A53_3(Non Secure): Cortex A53 context 3 on Main island */
+#define TISCI_HOST_ID_A53_3 (13U)
+/** M4_0(Non Secure): M4 */
+#define TISCI_HOST_ID_M4_0 (30U)
+/** MAIN_1_R5_0(Secure): Cortex R5_1 context 0 on Main island */
+#define TISCI_HOST_ID_MAIN_1_R5_0 (40U)
+/** MAIN_1_R5_1(Non Secure): Cortex R5_1 context 1 on Main island */
+#define TISCI_HOST_ID_MAIN_1_R5_1 (41U)
+/** MAIN_1_R5_2(Secure): Cortex R5_1 context 2 on Main island */
+#define TISCI_HOST_ID_MAIN_1_R5_2 (42U)
+/** MAIN_1_R5_3(Non Secure): Cortex R5_1 context 3 on Main island */
+#define TISCI_HOST_ID_MAIN_1_R5_3 (43U)
+/** A53_4(Non Secure): Cortex A53 context 1 on Main island */
+#define TISCI_HOST_ID_A53_4 (14U)
+/** ICSSG_0(Non Secure): ICSSG context 0 on Main island */
+#define TISCI_HOST_ID_ICSSG_0 (50U)
+/** ICSSG_1(Non Secure): ICSSG context 1 on Main island */
+#define TISCI_HOST_ID_ICSSG_1 (51U)
+
+/* Catch-all host for board-config resource assignments. */
+#define TISCI_HOST_ID_ALL (128U)
+
+/** Number of unique hosts on the SoC */
+#define TISCI_HOST_ID_CNT (17U)
+
+#define TISCI_DEV_ADC0 0U
+#define TISCI_DEV_CMP_EVENT_INTROUTER0 1U
+#define TISCI_DEV_DBGSUSPENDROUTER0 2U
+#define TISCI_DEV_MAIN_GPIOMUX_INTROUTER0 3U
+#define TISCI_DEV_MCU_MCU_GPIOMUX_INTROUTER0 5U
+#define TISCI_DEV_TIMESYNC_EVENT_INTROUTER0 6U
+#define TISCI_DEV_MCU_M4FSS0 7U
+#define TISCI_DEV_MCU_M4FSS0_CBASS_0 8U
+#define TISCI_DEV_MCU_M4FSS0_CORE0 9U
+#define TISCI_DEV_CPSW0 13U
+#define TISCI_DEV_CPT2_AGGR0 14U
+#define TISCI_DEV_STM0 15U
+#define TISCI_DEV_DCC0 16U
+#define TISCI_DEV_DCC1 17U
+#define TISCI_DEV_DCC2 18U
+#define TISCI_DEV_DCC3 19U
+#define TISCI_DEV_DCC4 20U
+#define TISCI_DEV_DCC5 21U
+#define TISCI_DEV_DMSC0 22U
+#define TISCI_DEV_MCU_DCC0 23U
+#define TISCI_DEV_DEBUGSS_WRAP0 24U
+#define TISCI_DEV_DMASS0 25U
+#define TISCI_DEV_DMASS0_BCDMA_0 26U
+#define TISCI_DEV_DMASS0_CBASS_0 27U
+#define TISCI_DEV_DMASS0_INTAGGR_0 28U
+#define TISCI_DEV_DMASS0_IPCSS_0 29U
+#define TISCI_DEV_DMASS0_PKTDMA_0 30U
+#define TISCI_DEV_DMASS0_RINGACC_0 33U
+#define TISCI_DEV_MCU_TIMER0 35U
+#define TISCI_DEV_TIMER0 36U
+#define TISCI_DEV_TIMER1 37U
+#define TISCI_DEV_TIMER2 38U
+#define TISCI_DEV_TIMER3 39U
+#define TISCI_DEV_TIMER4 40U
+#define TISCI_DEV_TIMER5 41U
+#define TISCI_DEV_TIMER6 42U
+#define TISCI_DEV_TIMER7 43U
+#define TISCI_DEV_TIMER8 44U
+#define TISCI_DEV_TIMER9 45U
+#define TISCI_DEV_TIMER10 46U
+#define TISCI_DEV_TIMER11 47U
+#define TISCI_DEV_MCU_TIMER1 48U
+#define TISCI_DEV_MCU_TIMER2 49U
+#define TISCI_DEV_MCU_TIMER3 50U
+#define TISCI_DEV_ECAP0 51U
+#define TISCI_DEV_ECAP1 52U
+#define TISCI_DEV_ECAP2 53U
+#define TISCI_DEV_ELM0 54U
+#define TISCI_DEV_EMIF_DATA_0_VD 55U
+#define TISCI_DEV_MMCSD0 57U
+#define TISCI_DEV_MMCSD1 58U
+#define TISCI_DEV_EQEP0 59U
+#define TISCI_DEV_EQEP1 60U
+#define TISCI_DEV_GTC0 61U
+#define TISCI_DEV_EQEP2 62U
+#define TISCI_DEV_ESM0 63U
+#define TISCI_DEV_MCU_ESM0 64U
+#define TISCI_DEV_FSIRX0 65U
+#define TISCI_DEV_FSIRX1 66U
+#define TISCI_DEV_FSIRX2 67U
+#define TISCI_DEV_FSIRX3 68U
+#define TISCI_DEV_FSIRX4 69U
+#define TISCI_DEV_FSIRX5 70U
+#define TISCI_DEV_FSITX0 71U
+#define TISCI_DEV_FSITX1 72U
+#define TISCI_DEV_FSS0 73U
+#define TISCI_DEV_FSS0_FSAS_0 74U
+#define TISCI_DEV_FSS0_OSPI_0 75U
+#define TISCI_DEV_GICSS0 76U
+#define TISCI_DEV_GPIO0 77U
+#define TISCI_DEV_GPIO1 78U
+#define TISCI_DEV_MCU_GPIO0 79U
+#define TISCI_DEV_GPMC0 80U
+#define TISCI_DEV_PRU_ICSSG0 81U
+#define TISCI_DEV_PRU_ICSSG1 82U
+#define TISCI_DEV_LED0 83U
+#define TISCI_DEV_CPTS0 84U
+#define TISCI_DEV_DDPA0 85U
+#define TISCI_DEV_EPWM0 86U
+#define TISCI_DEV_EPWM1 87U
+#define TISCI_DEV_EPWM2 88U
+#define TISCI_DEV_EPWM3 89U
+#define TISCI_DEV_EPWM4 90U
+#define TISCI_DEV_EPWM5 91U
+#define TISCI_DEV_EPWM6 92U
+#define TISCI_DEV_EPWM7 93U
+#define TISCI_DEV_EPWM8 94U
+#define TISCI_DEV_VTM0 95U
+#define TISCI_DEV_MAILBOX0 96U
+#define TISCI_DEV_MAIN2MCU_VD 97U
+#define TISCI_DEV_MCAN0 98U
+#define TISCI_DEV_MCAN1 99U
+#define TISCI_DEV_MCU_MCRC64_0 100U
+#define TISCI_DEV_MCU2MAIN_VD 101U
+#define TISCI_DEV_I2C0 102U
+#define TISCI_DEV_I2C1 103U
+#define TISCI_DEV_I2C2 104U
+#define TISCI_DEV_I2C3 105U
+#define TISCI_DEV_MCU_I2C0 106U
+#define TISCI_DEV_MCU_I2C1 107U
+#define TISCI_DEV_PCIE0 114U
+#define TISCI_DEV_R5FSS0 119U
+#define TISCI_DEV_R5FSS1 120U
+#define TISCI_DEV_R5FSS0_CORE0 121U
+#define TISCI_DEV_R5FSS0_CORE1 122U
+#define TISCI_DEV_R5FSS1_CORE0 123U
+#define TISCI_DEV_R5FSS1_CORE1 124U
+#define TISCI_DEV_RTI0 125U
+#define TISCI_DEV_RTI1 126U
+#define TISCI_DEV_RTI8 127U
+#define TISCI_DEV_RTI9 128U
+#define TISCI_DEV_RTI10 130U
+#define TISCI_DEV_RTI11 131U
+#define TISCI_DEV_MCU_RTI0 132U
+#define TISCI_DEV_SA2_UL0 133U
+#define TISCI_DEV_COMPUTE_CLUSTER0 134U
+#define TISCI_DEV_A53SS0_CORE_0 135U
+#define TISCI_DEV_A53SS0_CORE_1 136U
+#define TISCI_DEV_A53SS0 137U
+#define TISCI_DEV_DDR16SS0 138U
+#define TISCI_DEV_PSC0 139U
+#define TISCI_DEV_MCU_PSC0 140U
+#define TISCI_DEV_MCSPI0 141U
+#define TISCI_DEV_MCSPI1 142U
+#define TISCI_DEV_MCSPI2 143U
+#define TISCI_DEV_MCSPI3 144U
+#define TISCI_DEV_MCSPI4 145U
+#define TISCI_DEV_UART0 146U
+#define TISCI_DEV_MCU_MCSPI0 147U
+#define TISCI_DEV_MCU_MCSPI1 148U
+#define TISCI_DEV_MCU_UART0 149U
+#define TISCI_DEV_SPINLOCK0 150U
+#define TISCI_DEV_TIMERMGR0 151U
+#define TISCI_DEV_UART1 152U
+#define TISCI_DEV_UART2 153U
+#define TISCI_DEV_UART3 154U
+#define TISCI_DEV_UART4 155U
+#define TISCI_DEV_UART5 156U
+#define TISCI_DEV_BOARD0 157U
+#define TISCI_DEV_UART6 158U
+#define TISCI_DEV_MCU_UART1 160U
+#define TISCI_DEV_USB0 161U
+#define TISCI_DEV_SERDES_10G0 162U
+#define TISCI_DEV_PBIST0 163U
+#define TISCI_DEV_PBIST1 164U
+#define TISCI_DEV_PBIST2 165U
+#define TISCI_DEV_PBIST3 166U
+#define TISCI_DEV_COMPUTE_CLUSTER0_PBIST_0 167U
+#define TISCI_DEV_ID_MAX 168U
+
+#define TISCI_MSG_FLAG_RESERVED0 BIT(0)
+/*
+ * ACK-on-processed: request a response after handling, ACK on success and
+ * NAK otherwise.
+ */
+#define TISCI_MSG_FLAG_AOP BIT(1)
+
+/** Indicate that this message is marked secure */
+#define TISCI_MSG_FLAG_SEC BIT(2)
+
+/* Response success flag; missing one means NAK. */
+#define TISCI_MSG_FLAG_ACK BIT(1)
+
+/* TISCI Message IDs */
+#define TISCI_MSG_VERSION (0x0002U)
+#define TISCI_MSG_BOOT_NOTIFICATION (0x000AU)
+#define TISCI_MSG_BOARD_CONFIG (0x000BU)
+#define TISCI_MSG_BOARD_CONFIG_RM (0x000CU)
+#define TISCI_MSG_BOARD_CONFIG_SECURITY (0x000DU)
+#define TISCI_MSG_BOARD_CONFIG_PM (0x000EU)
+
+#define TISCI_MSG_ENABLE_WDT (0x0000U)
+#define TISCI_MSG_WAKE_RESET (0x0001U)
+#define TISCI_MSG_WAKE_REASON (0x0003U)
+#define TISCI_MSG_GOODBYE (0x0004U)
+#define TISCI_MSG_SYS_RESET (0x0005U)
+
+#define TISCI_MSG_QUERY_MSMC (0x0020U)
+#define TISCI_MSG_GET_TRACE_CONFIG (0x0021U)
+#define TISCI_MSG_QUERY_FW_CAPS (0x0022U)
+
+#define TISCI_MSG_SET_CLOCK (0x0100U)
+#define TISCI_MSG_GET_CLOCK (0x0101U)
+#define TISCI_MSG_SET_CLOCK_PARENT (0x0102U)
+#define TISCI_MSG_GET_CLOCK_PARENT (0x0103U)
+#define TISCI_MSG_GET_NUM_CLOCK_PARENTS (0x0104U)
+#define TISCI_MSG_SET_FREQ (0x010cU)
+#define TISCI_MSG_QUERY_FREQ (0x010dU)
+#define TISCI_MSG_GET_FREQ (0x010eU)
+
+#define TISCI_MSG_SET_DEVICE (0x0200U)
+#define TISCI_MSG_GET_DEVICE (0x0201U)
+
+#define TISCI_MSG_SET_DEVICE_RESETS (0x0202U)
+#define TISCI_MSG_DEVICE_DROP_POWERUP_REF (0x0203U)
+
+#define TISCI_MSG_PREPARE_SLEEP (0x0300U)
+#define TISCI_MSG_ENTER_SLEEP (0x0301U)
+
+#define TISCI_MSG_PROC_REQUEST (0xc000U)
+#define TISCI_MSG_PROC_RELEASE (0xc001U)
+#define TISCI_MSG_PROC_HANDOVER (0xc005U)
+#define TISCI_MSG_SET_CONFIG (0xc100U)
+#define TISCI_MSG_SET_CTRL (0xc101U)
+#define TISCI_MSG_GET_STATUS (0xc400U)
+#define TISCI_MSG_WAIT_PROC_BOOT_STATUS (0xc401U)
+
+/*
+ * Security message IDs for K3 SA2UL, OTP and secure-boot TI-SCI services.
+ * Layouts match the U-Boot/Zephyr TI-SCI protocol headers.
+ */
+#define TISCI_MSG_FWL_SET (0x9000U)
+#define TISCI_MSG_FWL_GET (0x9001U)
+#define TISCI_MSG_FWL_CHANGE_OWNER (0x9002U)
+#define TISCI_MSG_SA2UL_GET_DKEK (0x9029U)
+#define TISCI_MSG_READ_SWREV (0x9033U)
+#define TISCI_MSG_READ_KEYCNT_KEYREV (0x9034U)
+
+#define TISCI_MSG_MAX_ID (0xc500U)
+
+/** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 9 Processor 0) */
+#define SCICLIENT_PROCID_A53_CL0_C0 (0x20U)
+/** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 9 Processor 1) */
+#define SCICLIENT_PROCID_A53_CL0_C1 (0x21U)
+/** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 0 Processor 0) */
+#define SCICLIENT_PROCID_R5_CL0_C0 (0x01U)
+/** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 0 Processor 1) */
+#define SCICLIENT_PROCID_R5_CL0_C1 (0x02U)
+/** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 1 Processor 0) */
+#define SCICLIENT_PROCID_R5_CL1_C0 (0x06U)
+/** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 1 Processor 1) */
+#define SCICLIENT_PROCID_R5_CL1_C1 (0x07U)
+/*** AM64_MAIN_SEC_MMR_MAIN_0: (Cluster 16 Processor 0) */
+#define SCICLIENT_PROCID_MCU_M4FSS0_C0 (0x18U)
+
+#define TYPE_TI_DMSC "ti-dmsc"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TIDmscState, TI_DMSC)
+
+/* Default: 64 bytes -> 16 words */
+#define TI_DMSC_MAX_WORDS 16
+
+/*
+ * Minimal TISCI wire structs. Keep them packed and model only fields this
+ * device actually consumes or returns.
+ */
+typedef struct TISciMsgHdr {
+    uint16_t type;
+    uint8_t host;
+    uint8_t seq;
+    uint32_t flags;
+} QEMU_PACKED TISciMsgHdr;
+
+struct TiSciMsgReqProcRequest {
+    TISciMsgHdr hdr;
+    uint8_t processor_id;
+} QEMU_PACKED;
+
+struct TiSciMsgReqProcRelease {
+    TISciMsgHdr hdr;
+    uint8_t processor_id;
+} QEMU_PACKED;
+
+/*
+ * TISCI_MSG_PROC_HANDOVER request. Response is only TISciMsgHdr ACK/NAK.
+ */
+struct TiSciMsgReqProcHandover {
+    TISciMsgHdr hdr;
+    uint8_t processor_id;
+    uint8_t host_id;
+} QEMU_PACKED;
+
+#define TISCI_MSG_VAL_PROC_BOOT_STATUS_FLAG_M4F_WFI (0x00000002U)
+
+struct TisciMsgProcGetStatusReq {
+    TISciMsgHdr hdr;
+    uint8_t processor_id;
+} QEMU_PACKED;
+
+struct TisciMsgProcGetStatusResp {
+    TISciMsgHdr hdr;
+    uint8_t processor_id;
+    uint32_t bootvector_lo;
+    uint32_t bootvector_hi;
+    uint32_t config_flags_1;
+    uint32_t control_flags_1;
+    uint32_t status_flags_1;
+} QEMU_PACKED;
+
+/*
+ * WAIT_PROC_BOOT_STATUS request. Only processor_id is consumed by the no-op
+ * handler, so the trailing wait/status fields are left out.
+ */
+struct TisciMsgReqWaitProcBootStatus {
+    TISciMsgHdr hdr;
+    uint8_t processor_id;
+} QEMU_PACKED;
+
+/*
+ * SET_DEVICE matches the TISCI ABI layout: the reserved u32 before state is
+ * on the wire and keeps the state byte aligned to SYSFW.
+ */
+struct TisciMsgSetDeviceReq {
+    TISciMsgHdr hdr;
+    uint32_t id;
+    uint32_t reserved;
+    uint8_t state;
+} QEMU_PACKED;
+
+struct TisciMsgSetDeviceResetsReq {
+    TISciMsgHdr hdr;
+    uint32_t id;
+    uint32_t resets;
+} QEMU_PACKED;
+
+struct TiSciMsgQueryFwCapsResp {
+    TISciMsgHdr hdr;
+#define MSG_FLAG_CAPS_GENERIC BIT(0)
+#define MSG_FLAG_CAPS_LPM_DEEP_SLEEP BIT(1)
+#define MSG_FLAG_CAPS_LPM_MCU_ONLY BIT(2)
+#define MSG_FLAG_CAPS_LPM_STANDBY BIT(3)
+#define MSG_FLAG_CAPS_LPM_PARTIAL_IO BIT(4)
+#define MSG_FLAG_CAPS_LPM_DM_MANAGED BIT(5)
+    uint64_t fw_caps;
+} QEMU_PACKED;
+
+struct TiSciMsgVersionResp {
+    TISciMsgHdr hdr;
+    char firmware_description[32];
+    uint16_t firmware_revision;
+    uint8_t abi_major;
+    uint8_t abi_minor;
+} QEMU_PACKED;
+
+struct TisciMsgSetFreqReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint64_t min_freq_hz;
+    uint64_t target_freq_hz;
+    uint64_t max_freq_hz;
+    uint8_t clk;
+    uint32_t clk32;
+} QEMU_PACKED;
+
+struct TisciMsgQueryFreqReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint64_t min_freq_hz;
+    uint64_t target_freq_hz;
+    uint64_t max_freq_hz;
+    uint8_t clk;
+    uint32_t clk32;
+} QEMU_PACKED;
+
+struct TisciMsgQueryFreqResp {
+    TISciMsgHdr hdr;
+    uint64_t freq_hz;
+} QEMU_PACKED;
+
+/*
+ * GET_FREQ has only device/clock in the request. The response is hdr plus
+ * freq_hz, same payload as QUERY_FREQ.
+ */
+struct TisciMsgGetFreqReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint8_t clk;
+} QEMU_PACKED;
+
+struct TisciMsgSetClockReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint8_t clk;
+    uint8_t state;
+    uint32_t clk32;
+} QEMU_PACKED;
+
+struct TisciMsgGetNumClockParentsReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint8_t clk;
+    uint32_t clk32;
+} QEMU_PACKED;
+
+struct TisciMsgGetNumClockParentsResp {
+    TISciMsgHdr hdr;
+    uint8_t num_parents;
+    uint32_t num_parentint32_t;
+} QEMU_PACKED;
+
+struct TisciMsgGetClockParentReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint8_t clk;
+    uint32_t clk32;
+} QEMU_PACKED;
+
+struct TisciMsgGetClockParentResp {
+    TISciMsgHdr hdr;
+    uint8_t parent;
+    uint32_t parent32;
+} QEMU_PACKED;
+
+/*
+ * TISCI_MSG_SET_CLOCK_PARENT request. Response is bare TISciMsgHdr ACK/NAK.
+ */
+struct TisciMsgSetClockParentReq {
+    TISciMsgHdr hdr;
+    uint32_t dev_id;
+    uint8_t clk_id;
+    uint8_t parent_id;
+} QEMU_PACKED;
+
+struct TisciMsgGetClockReq {
+    TISciMsgHdr hdr;
+    uint32_t device;
+    uint8_t clk;
+    uint32_t clk32;
+} QEMU_PACKED;
+
+struct TisciMsgGetClockResp {
+    TISciMsgHdr hdr;
+    uint8_t programmed_state;
+    uint8_t current_state;
+} QEMU_PACKED;
+
+struct TisciMsgGetDeviceReq {
+    TISciMsgHdr hdr;
+    uint32_t id;
+} QEMU_PACKED;
+
+struct TisciMsgGetDeviceResp {
+    TISciMsgHdr hdr;
+    uint32_t context_loss_count;
+    uint32_t resets;
+    uint8_t programmed_state;
+    uint8_t current_state;
+} QEMU_PACKED;
+
+/*
+ * Security message layouts for K3 SA2UL, OTP and secure-boot services. They
+ * match the U-Boot and Zephyr TI-SCI protocol headers.
+ */
+#define FWL_MAX_PRIVID_SLOTS 3U
+
+struct TisciMsgReqFwlSetFirewallRegion {
+    TISciMsgHdr hdr;
+    uint16_t fwl_id;
+    uint16_t region;
+    uint32_t n_permission_regs;
+    uint32_t control;
+    uint32_t permissions[FWL_MAX_PRIVID_SLOTS];
+    uint64_t start_address;
+    uint64_t end_address;
+} QEMU_PACKED;
+
+/* TISCI_MSG_FWL_SET response is bare generic ACK/NACK (TISciMsgHdr). */
+
+struct TisciMsgReqFwlGetFirewallRegion {
+    TISciMsgHdr hdr;
+    uint16_t fwl_id;
+    uint16_t region;
+    uint32_t n_permission_regs;
+} QEMU_PACKED;
+
+struct TisciMsgRespFwlGetFirewallRegion {
+    TISciMsgHdr hdr;
+    uint16_t fwl_id;
+    uint16_t region;
+    uint32_t n_permission_regs;
+    uint32_t control;
+    uint32_t permissions[FWL_MAX_PRIVID_SLOTS];
+    uint64_t start_address;
+    uint64_t end_address;
+} QEMU_PACKED;
+
+struct TisciMsgReqFwlChangeOwnerInfo {
+    TISciMsgHdr hdr;
+    uint16_t fwl_id;
+    uint16_t region;
+    uint8_t owner_index;
+} QEMU_PACKED;
+
+struct TisciMsgRespFwlChangeOwnerInfo {
+    TISciMsgHdr hdr;
+    uint16_t fwl_id;
+    uint16_t region;
+    uint8_t owner_index;
+    uint8_t owner_privid;
+    uint16_t owner_permission_bits;
+} QEMU_PACKED;
+
+#define SA2UL_DKEK_KEY_LEN 32
+#define KDF_LABEL_AND_CONTEXT_LEN_MAX 41
+
+struct TisciMsgReqSa2ulGetDkek {
+    TISciMsgHdr hdr;
+    uint8_t sa2ul_instance;
+    uint8_t kdf_label_len;
+    uint8_t kdf_context_len;
+    uint8_t kdf_label_and_context[KDF_LABEL_AND_CONTEXT_LEN_MAX];
+} QEMU_PACKED;
+
+struct TisciMsgRespSa2ulGetDkek {
+    TISciMsgHdr hdr;
+    uint8_t dkek[SA2UL_DKEK_KEY_LEN];
+} QEMU_PACKED;
+
+struct TisciMsgRespReadSwrev {
+    TISciMsgHdr hdr;
+    uint32_t swrev;
+} QEMU_PACKED;
+
+struct TisciMsgRespReadKeycntKeyrev {
+    TISciMsgHdr hdr;
+    uint32_t keycnt;
+    uint32_t keyrev;
+} QEMU_PACKED;
+
+typedef struct TIDmscClient TIDmscClient;
+
+typedef void (*TiDmscMsgHandler)(TIDmscClient *client, TISciMsgHdr *hdr,
+                                 uint16_t thread_id, const uint32_t *words,
+                                 size_t nwords);
+
+struct TIDmscClient {
+    TIDmscState *dmsc;
+    uint16_t rx_thread_id;
+    uint16_t tx_thread_id;
+    bool pending;
+    /*
+     * Secure R5 clients add a 4-byte checksum/reserved word before the
+     * normal TISciMsgHdr on requests and responses.
+     */
+    bool secure;
+    uint32_t pending_words[TI_DMSC_MAX_WORDS];
+    size_t pending_nwords;
+
+    /*
+     * Set from the actual request's AOP bit before dispatch. The bottom
+     * half handles one message at a time, so no extra locking is needed.
+     */
+    bool cur_req_wants_resp;
+};
+
+struct TIDmscState {
+    DeviceState parent_obj;
+
+    /* QOM link to SEC_PROXY */
+    TISecProxyState *sec_proxy;
+
+    /* Config */
+    uint16_t rx_thread_id; /* e.g. M4_0_WRITE_THREAD */
+    uint16_t tx_thread_id; /* e.g. M4_0_READ_RESPONSE_THREAD */
+    uint32_t num_rx_threads;
+    uint16_t *rx_thread_ids;
+    uint32_t num_tx_threads;
+    uint16_t *tx_thread_ids;
+    /* rx threads of clients, which use secure R5 transport framing */
+    uint32_t num_secure_rx_threads;
+    uint16_t *secure_rx_threads;
+    uint64_t m4_cpu_id;       /* QEMU CPU index used for MCU M4 */
+    uint64_t a53_cpu_id_base; /* MP affinity of A53 core 0 (core 1 = +1) */
+
+    uint32_t msg_words; /* usually 16 */
+
+    /* Optional async handling */
+    QEMUBH *bh;
+    QemuMutex lock;
+
+    TiDmscMsgHandler msg_handler[TISCI_MSG_MAX_ID];
+    uint32_t num_clients;
+    TIDmscClient *clients;
+
+    uint8_t dev_hw_state[TISCI_DEV_ID_MAX];
+    uint8_t dev_prog_state[TISCI_DEV_ID_MAX];
+    bool m4_running;
+    /* A53 boot vectors captured from TISCI_MSG_SET_CONFIG. */
+    uint64_t proc_bootvector[2];
+};
+
+#endif /* HW_MISC_TI_DMSC_H */
-- 
2.43.0


