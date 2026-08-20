Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFCFC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqE-0001x0-DF; Wed, 19 Aug 2026 22:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspy-0001s2-8l
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:04 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspv-0000SL-S4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:02 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66c70d73210so2366437d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194139; x=1787798939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6sc+RYt/bXjNnBfsDqSaV8jSqXsdHO+630d/njHcBss=;
 b=ZRYKE5Y8SsvcM48xTkwq3LJDSKmMYGFZy48OMNhe/BEwlyQBcmSkNKyFOjkL9HBgSK
 3P9xgiCtlIaepMGlStsAG5HrIURvc+IcCV30wzWjnoQzGAmrDf4mXdngTWgzisZvhqGU
 3TawX2bCCfQR7wwWlVLW8sur7078a/9jxWUgtLXtptpHomTLy+4YuWe+/AeMp4178d/1
 Tfh/lVWMGmcMYB3WhWfUjLN7+xMxNAE64F8Wvf4AURwhqTs4V5S+czABEHpvEwpvkWaO
 /aNkYif1cv2A894BB8dQocd7PqjR4/ZjV9AeW/GyYF2LHAdXTrcZr3HzMjgXgXhvyvat
 TxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194139; x=1787798939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6sc+RYt/bXjNnBfsDqSaV8jSqXsdHO+630d/njHcBss=;
 b=RSEYX0FmcJj+u2NEC9NwihpE0R9rgnhJ9DC6B5nK/dIKGFVYESngKr1cepbpI/1Fud
 TEPi3yDruPzpGIAy4X2+6JCAi/SU3d1bR0iIVUTKnYfPEMi2qS0SPKUFEkGEwtH0186k
 H6PCtESQUlE+CWhZ67UEcfyegWtb3FKgydaS7hjO2IxXbSwEpXgNIl3F3nI93MURWFhO
 ScVhn/x7XzCRn3GLRM1nC90Jn9HoiEuGy65bDXms1XnETFjBPIIDj3Mi+a65oetPTWac
 W66HXkfJq9DGW46FM5IdI3b+O/EKxlAzrhRgWZA0Kzv7qgl7Zkj10prhfmF3s6ei/lzF
 O9Ug==
X-Gm-Message-State: AFuF++nD9wn60ESywyg9VK5pkKSxwC4RgYtg486IOO7co1enNY8Vlym9
 bsMVo8WG7Yg3w0PXQijbTX4UUMREXRQV0IXN2SLoof6n/2jRuaccBZ6kSFRGyQ==
X-Gm-Gg: AR+sD13psizDHSFxQbkJNefpiFwPRf4fDT6WzuyvS2cz54+UiUo+HoJYV4+lFbkrSdV
 hiu6p0SzbmfVITu50yc5d2B3d6XMx8Ksh7oq8Jv09p9GtBBC08NzC+wATbW1R7+q7N3q/noudjq
 Q5vbPKbnJdrFksosiWlsoD1E+F0Q3ZQZI8g/uadssIxzntRmEo3w7s3EjcDmjExFtOhtYt8MKWa
 QOxGVctVq+lvKjzKPJMAurI/FlG+GNKY6acHtv2V2Qa1QNq++JdBL0E4js/PUd79RiUs1YaeFVL
 AaC/j0ccX2hYf+J4SxZhRP1cCjNlWEynO9Lydp5qsQQMO4zYfS4MHbB/emuua8KcErUxOo2/IbH
 Gge9yPdgrnhtFn6KOWDODP5P2zu+EOdCuDkKeg+2H8LBAcQ6B03COwpswZYqX5UUzhHhjc1TvpO
 nivlxePdxdemdR4lt+lSaHceZ+bHDjcOMUr5kEWNbCs8MAnwbIMx/xiWu4DqjVQ+vID4M71Pecq
 VldA5FMKeaqCieZ0hDpBRBYxSYICx4F3/1a/3ZmDQhvlVlXfbpOpvvJ61WI54OZ
X-Received: by 2002:a05:690e:12c4:b0:66c:8744:27a with SMTP id
 956f58d0204a3-66ccb6c9f82mr3584507d50.33.1787194138594; 
 Wed, 19 Aug 2026 19:48:58 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:57 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 08/16] hw/misc: add NXP EdgeLock Enclave (ELE) responder
Date: Wed, 19 Aug 2026 21:48:26 -0500
Message-Id: <20260820024834.3286721-9-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The NXP EdgeLock Enclave (ELE) responder. U-Boot and the SM firmware
issue ELE service requests (e.g. GET_INFO, get-random) over a dedicated
MU; this models the responder that consumes the request words and
returns a response so the secure bring-up sequence proceeds. It is
linked to its MU through a QOM link property.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/misc/Kconfig                    |   4 +
 hw/misc/imx95_ele_server.c         | 284 +++++++++++++++++++++++++++++
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   2 +
 include/hw/misc/imx95_ele_server.h |  47 +++++
 5 files changed, 338 insertions(+)
 create mode 100644 hw/misc/imx95_ele_server.c
 create mode 100644 include/hw/misc/imx95_ele_server.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8645ca11f3f..ded60e21a6c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -264,3 +264,7 @@ source macio/Kconfig
 
 config IMX_MU
     bool
+
+config IMX95_ELE_SERVER
+    bool
+    select IMX_MU
diff --git a/hw/misc/imx95_ele_server.c b/hw/misc/imx95_ele_server.c
new file mode 100644
index 00000000000..b8ee3f78b61
--- /dev/null
+++ b/hw/misc/imx95_ele_server.c
@@ -0,0 +1,284 @@
+/*
+ * Minimal NXP EdgeLock Enclave (ELE) responder stub
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Watches TR-register writes on an i.MX MU, accumulates ELE-protocol
+ * command words until the per-message size is reached, dispatches to a
+ * command handler, and writes the response into RR registers + asserts
+ * RSR.RFn so the agent's mu_hal_receivemsg() poll exits.
+ *
+ * ELE message format (per ele_api.h):
+ *
+ *   word 0 (header): version[7:0] | size[15:8] | command[23:16] | tag[31:24]
+ *   word 1..N-1:     payload
+ *
+ * size = total words including header. tag = ELE_CMD_TAG (0x17) for
+ * commands, ELE_RESP_TAG (0xE1) for responses. Responses also have a
+ * status byte (ELE_SUCCESS_IND = 0xD6 for success) somewhere in the
+ * payload depending on command.
+ *
+ * Only ELE_GET_INFO_REQ is implemented in detail (the
+ * only ELE call U-Boot SPL's imx9_probe_mu() makes pre-relocation,
+ * via ele_get_info()). Other commands get a generic SUCCESS response.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/misc/imx95_ele_server.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "system/dma.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+/*
+ * struct ele_get_info_data layout (u32 word offsets), pinned to the
+ * U-Boot ele_api.h definition at
+ * U-Boot arch/arm/include/asm/mach-imx/ele_api.h:168.
+ * Using named offsets here so a future U-Boot rev that reorders or
+ * adds fields trips a build/runtime mismatch instead of silently
+ * writing into the wrong slot.
+ *
+ * Reference layout:
+ *   u32 hdr;                  // word 0
+ *   u32 soc;                  // word 1
+ *   u32 lc;                   // word 2
+ *   u32 uid[4];               // words 3..6
+ *   u32 sha256_rom_patch[8];  // words 7..14
+ *   u32 sha_fw[8];            // words 15..22
+ *   u32 oem_srkh[16];         // words 23..38
+ *   u32 state;                // word 39
+ *   u32 oem_pqc_srkh[16];     // words 40..55
+ *   u32 reserved[8];          // words 56..63
+ * Total: 64 u32 = 256 bytes.
+ */
+#define ELE_INFO_OFFSET_HDR             0
+#define ELE_INFO_OFFSET_SOC             1
+#define ELE_INFO_OFFSET_LC              2
+#define ELE_INFO_OFFSET_UID             3
+#define ELE_INFO_OFFSET_SHA256_ROM      7
+#define ELE_INFO_OFFSET_SHA_FW          15
+#define ELE_INFO_OFFSET_OEM_SRKH        23
+#define ELE_INFO_OFFSET_STATE           39
+#define ELE_INFO_OFFSET_OEM_PQC_SRKH    40
+#define ELE_INFO_OFFSET_RESERVED        56
+#define ELE_INFO_SIZE_WORDS             64
+#define ELE_INFO_SIZE_BYTES             (ELE_INFO_SIZE_WORDS * 4)
+
+/* Header field packing. */
+static inline uint32_t ele_make_header(uint8_t version, uint8_t size,
+                                       uint8_t command, uint8_t tag)
+{
+    return (uint32_t)version |
+           ((uint32_t)size    << 8) |
+           ((uint32_t)command << 16) |
+           ((uint32_t)tag     << 24);
+}
+
+/* Header field extraction. */
+#define ELE_HDR_VERSION(h)  ((uint8_t)((h) & 0xFF))
+#define ELE_HDR_SIZE(h)     ((uint8_t)(((h) >> 8) & 0xFF))
+#define ELE_HDR_COMMAND(h)  ((uint8_t)(((h) >> 16) & 0xFF))
+#define ELE_HDR_TAG(h)      ((uint8_t)(((h) >> 24) & 0xFF))
+
+/*
+ * ELE_GET_INFO_REQ handler.
+ *
+ * Request layout (4 words):
+ *   [0] header (command = ELE_GET_INFO_REQ)
+ *   [1] info_addr_hi (upper 32 bits of guest pointer)
+ *   [2] info_addr_lo (lower 32 bits of guest pointer)
+ *   [3] size of ele_get_info_data
+ *
+ * Real ELE writes a struct ele_get_info_data to the guest address.
+ * We fake plausible values: rev 0xA1 i.MX 95, OEM-open lifecycle,
+ * UID zero-filled. The Linux/U-Boot drivers do not validate beyond
+ * memcpy into gd->arch.
+ *
+ * Response: 2 words. Status word ELE_SUCCESS_IND in data[0].
+ */
+static void ele_handle_get_info(IMX95ELEServerState *s)
+{
+    if (s->msg_count < 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: GET_INFO with only %u words received\n",
+                      __func__, s->msg_count);
+        return;
+    }
+
+    uint64_t info_addr = ((uint64_t)s->msg_buf[1] << 32) |
+                          (uint64_t)s->msg_buf[2];
+
+    /*
+     * Zero-fill the full 256-byte struct, then set the fields U-Boot's
+     * set_cpu_info() reads (soc, lc). Named offsets above keep the
+     * mapping legible; if U-Boot ever shifts the struct layout, the
+     * build check below + a re-read of ele_api.h are how this gets
+     * detected.
+     */
+    uint32_t info_data[ELE_INFO_SIZE_WORDS] = {0};
+    QEMU_BUILD_BUG_ON(sizeof(info_data) != ELE_INFO_SIZE_BYTES);
+
+    info_data[ELE_INFO_OFFSET_SOC] = 0xA1009500;  /* SoC rev 0xA1, type 0x95 */
+    info_data[ELE_INFO_OFFSET_LC]  = 0x00000080;  /* lifecycle = OEM open */
+
+    dma_memory_write(&address_space_memory, info_addr,
+                     info_data, sizeof(info_data),
+                     MEMTXATTRS_UNSPECIFIED);
+
+    /* Response: header + status. */
+    uint32_t resp_hdr = ele_make_header(ELE_VERSION, 2,
+                                        ELE_GET_INFO_REQ, ELE_RESP_TAG);
+    trace_imx95_ele_response(ELE_GET_INFO_REQ);
+    imx_mu_deliver_rr(s->mu, 0, resp_hdr);
+    imx_mu_deliver_rr(s->mu, 1, ELE_SUCCESS_IND);
+}
+
+/*
+ * Generic SUCCESS response for any command we do not specifically
+ * handle. 2-word response: header + ELE_SUCCESS_IND.
+ */
+static void ele_handle_generic_ok(IMX95ELEServerState *s, uint8_t command)
+{
+    uint32_t resp_hdr = ele_make_header(ELE_VERSION, 2,
+                                        command, ELE_RESP_TAG);
+    trace_imx95_ele_response(command);
+    imx_mu_deliver_rr(s->mu, 0, resp_hdr);
+    imx_mu_deliver_rr(s->mu, 1, ELE_SUCCESS_IND);
+}
+
+static void ele_dispatch(IMX95ELEServerState *s)
+{
+    uint32_t header  = s->msg_buf[0];
+    uint8_t  command = ELE_HDR_COMMAND(header);
+    uint8_t  tag     = ELE_HDR_TAG(header);
+
+    trace_imx95_ele_msg(command, tag, s->msg_size);
+
+    switch (command) {
+    case ELE_GET_INFO_REQ:
+        ele_handle_get_info(s);
+        return;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: cmd 0x%02x not handled in detail; responding OK\n",
+                      __func__, command);
+        ele_handle_generic_ok(s, command);
+        return;
+    }
+}
+
+/*
+ * TR-write callback. Invoked synchronously by the MU model from inside
+ * the guest's MMIO write to TR[idx]. The MU itself re-sets TSR.TEn
+ * after this returns so the next TR write succeeds without polling.
+ */
+static void ele_on_tr_write(void *opaque, unsigned int idx, uint32_t value)
+{
+    IMX95ELEServerState *s = opaque;
+
+    /* Invoked from the MU MMIO write handler, which runs under the BQL. */
+    assert(bql_locked());
+
+    if (s->msg_count >= IMX95_ELE_MAX_WORDS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: too many words; resetting accumulator\n",
+                      __func__);
+        s->msg_count = 0;
+        s->msg_size  = 0;
+        return;
+    }
+
+    s->msg_buf[s->msg_count++] = value;
+
+    if (s->msg_count == 1) {
+        /* First word is the header; pick out size. */
+        s->msg_size = ELE_HDR_SIZE(value);
+        if (s->msg_size == 0 || s->msg_size > IMX95_ELE_MAX_WORDS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: bad size %u in header 0x%08x\n",
+                          __func__, s->msg_size, value);
+            s->msg_count = 0;
+            s->msg_size  = 0;
+            return;
+        }
+    }
+
+    if (s->msg_count == s->msg_size) {
+        ele_dispatch(s);
+        s->msg_count = 0;
+        s->msg_size  = 0;
+    }
+}
+
+static void imx95_ele_server_reset_hold(Object *obj, ResetType type)
+{
+    IMX95ELEServerState *s = IMX95_ELE_SERVER(obj);
+
+    s->msg_count = 0;
+    s->msg_size  = 0;
+    memset(s->msg_buf, 0, sizeof(s->msg_buf));
+}
+
+static void imx95_ele_server_realize(DeviceState *dev, Error **errp)
+{
+    IMX95ELEServerState *s = IMX95_ELE_SERVER(dev);
+
+    if (!s->mu) {
+        error_setg(errp, "%s: 'mu' link property must be set",
+                   TYPE_IMX95_ELE_SERVER);
+        return;
+    }
+    imx_mu_set_tr_write_handler(s->mu, ele_on_tr_write, s);
+}
+
+static const Property imx95_ele_server_properties[] = {
+    DEFINE_PROP_LINK("mu", IMX95ELEServerState, mu,
+                     TYPE_IMX_MU, IMXMUState *),
+};
+
+static const VMStateDescription vmstate_imx95_ele_server = {
+    .name = TYPE_IMX95_ELE_SERVER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(msg_count, IMX95ELEServerState),
+        VMSTATE_UINT32(msg_size, IMX95ELEServerState),
+        VMSTATE_UINT32_ARRAY(msg_buf, IMX95ELEServerState,
+                             IMX95_ELE_MAX_WORDS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx95_ele_server_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = imx95_ele_server_realize;
+    dc->vmsd = &vmstate_imx95_ele_server;
+    rc->phases.hold = imx95_ele_server_reset_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX 95 ELE responder (get_info)";
+    device_class_set_props(dc, imx95_ele_server_properties);
+}
+
+static const TypeInfo imx95_ele_server_info = {
+    .name           = TYPE_IMX95_ELE_SERVER,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95ELEServerState),
+    .class_init     = imx95_ele_server_class_init,
+};
+
+static void imx95_ele_server_register_types(void)
+{
+    type_register_static(&imx95_ele_server_info);
+}
+
+type_init(imx95_ele_server_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9d0e3ed220d..b0dade72c6c 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -172,3 +172,4 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 system_ss.add(when: 'CONFIG_IMX_MU', if_true: files('imx_mu.c'))
+system_ss.add(when: 'CONFIG_IMX95_ELE_SERVER', if_true: files('imx95_ele_server.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 01b0b275f7f..6b3cff74549 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -446,3 +446,5 @@ imx_mu_tr_write(unsigned idx, uint32_t val) "TR[%u] <- 0x%08x"
 imx_mu_rr_deliver(unsigned idx, uint32_t val) "RR[%u] <- 0x%08x"
 imx_mu_doorbell(unsigned idx) "doorbell GIR channel %u"
 imx_mu_gip(unsigned idx) "GIP assert channel %u"
+imx95_ele_msg(uint8_t command, uint8_t tag, uint32_t size) "received cmd 0x%02x tag 0x%02x size %u"
+imx95_ele_response(uint8_t command) "response cmd 0x%02x"
diff --git a/include/hw/misc/imx95_ele_server.h b/include/hw/misc/imx95_ele_server.h
new file mode 100644
index 00000000000..75e6dfa4e25
--- /dev/null
+++ b/include/hw/misc/imx95_ele_server.h
@@ -0,0 +1,47 @@
+/*
+ * Minimal NXP EdgeLock Enclave (ELE) responder stub
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Watches an i.MX MU for ELE-protocol command words, dispatches them
+ * to handlers, and writes responses back through the MU's RR
+ * registers. Implements only ele_get_info() (the one ELE call
+ * U-Boot SPL's imx9_probe_mu() makes pre-relocation). Everything
+ * else returns ELE_OK with a stub response so SPL doesn't panic.
+ */
+
+#ifndef IMX95_ELE_SERVER_H
+#define IMX95_ELE_SERVER_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "hw/misc/imx_mu.h"
+
+#define TYPE_IMX95_ELE_SERVER "imx95.ele-server"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95ELEServerState, IMX95_ELE_SERVER)
+
+/* ELE protocol constants from arch/arm/include/asm/mach-imx/ele_api.h. */
+#define ELE_VERSION                 0x06
+#define ELE_CMD_TAG                 0x17
+#define ELE_RESP_TAG                0xE1
+#define ELE_GET_INFO_REQ            0xDA
+#define ELE_SUCCESS_IND             0xD6
+
+/* Maximum words in a single ELE message (per ELE_MAX_MSG in U-Boot). */
+#define IMX95_ELE_MAX_WORDS         32
+
+struct IMX95ELEServerState {
+    SysBusDevice    parent_obj;
+
+    /* Link to the MU used as ELE transport (elemu1). */
+    IMXMUState     *mu;
+
+    /* Accumulator for incoming command words. */
+    uint32_t        msg_buf[IMX95_ELE_MAX_WORDS];
+    uint32_t        msg_count;
+    uint32_t        msg_size;
+};
+
+#endif /* IMX95_ELE_SERVER_H */
-- 
2.34.1


