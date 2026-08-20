Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722C6C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CP-0004zZ-57; Thu, 20 Aug 2026 08:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CM-0004xA-0w
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:46 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CH-0001aK-Re
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:45 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso155239566b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230120; x=1787834920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hzX+dEd1qszbOG5kzSqRIrxHhRa8NHKy5vl7lbynnI4=;
 b=Vi/FY8WV/stPuXADAJ/q0ZGXpmobxEM60sjGWHK3JzHgotsxPqM08EEaaWr8EYpAln
 S713CGqBZ8z8B2Ybri2WZLn45cqTYHJEWBL5CSXJRyh41oqcwBJsutb0SffG6ED1V6c+
 rvJTjkoAxU/HnHFaLOmRZlAbgnlXQRn22Fiq76MF/cAHK+XXQhT+JId76rtBsjZKa84x
 n4fUTyp1BrtmGLulpFpJe/x/yEv++bz728s2fdD9iDitfrRDUulQOuoOuNiTeAY0uSN2
 l6ILQkv3ahJvYxHRbFGF40qG+9pKzDC4JEF1HnQQ7grauzlqD1njuZNnsWApR3cuooNg
 7BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230120; x=1787834920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hzX+dEd1qszbOG5kzSqRIrxHhRa8NHKy5vl7lbynnI4=;
 b=gUrPppb/ZGZIsB3jGY6uNUoePyHvIDhPcy9SWsnNJ1WxGrvyea5cDbTls2ZWxVYUNQ
 an4uyGQDtXf5Yok3TnPk4ZMZWxzdUoxk471ZBG6AJ533MRW4P6P78p1cV8mjJOhd615e
 diN8KWu973/JDyRwGZOnBe74GmgkmDgfmsBnumGCPXg5yMJEKtbrjYszgXu81yZlRhT0
 65Rx1u+pCapJ5ZE8wPBpKOrhTMKf+4EY3cPzCc7d50uxWGRWiw6uIWqXSb50ROwwv2C8
 nD+8GODFFdzWWN909S2U8V3Ha76bnt8q27bTU79+xpMVXwxqRchmsLGLlyvFZ6o/YF8N
 3sNQ==
X-Gm-Message-State: AOJu0YzcCs8Ppi4cyxbd+8CCJD6/dPOmIgZc+ADJROE+vcXsBfs21U0p
 SFC/S71Ahs1vHkQrlfblgD+UGf8DBZLJhLW90H/67GRMFJJc4sGzPLrsDLKiQCRj
X-Gm-Gg: AR+sD11jq5GPIVE8j2Mejv5r/ap+j7sWiip3wRpAyeQJAavW7hLc3qdMVFwze+eJQY5
 wFM3QbHIYoXtDS3hXn4jNcKGbvo04esWTVcVX7+bzOwxYL5didPcrogUzD0wbX56z/rk0Q1WUlv
 2VbHIP7PqC20we38X714T9S1FVIEZrDh0qiQQyehToBDYf2J/EQWs8K+xdBCi2QFEFM0+ypVPsd
 n0p/C2f1XSrGzjCSfziXH10+RVD+mLErq1B3C0WJQl2ZT50xqdCp1t6AUhbv3E7kPgl/Y4JZd0u
 JcCtZY/+PiCH6iG1h8suGGhABd2/3cGYz+Y09GNTEQtz+6Q14J/jtJ4vYCfkx27MO5ngA+++x2V
 UfI0+eFa1qJKFjUUvRg4Fmto1lXaUB8Y0JV56SfzJMZUY7dJTlg4E0Jh3LdILz3AU8Ig2ghCBlO
 pEiHEzk4a/oyK1H+Q8JiJG1+mP+XRxdknY9UTBIhTN7RTin5rEvIlnn5WnXn8Q3t+f1NEDoZFh8
 6UknsKmv4Q=
X-Received: by 2002:a17:907:a01:b0:c20:7cb0:f33c with SMTP id
 a640c23a62f3a-c244d86d229mr439477666b.16.1787230120211; 
 Thu, 20 Aug 2026 05:48:40 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:39 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 09/14] hw/misc: add TI K3 secure proxy model
Date: Thu, 20 Aug 2026 14:48:09 +0200
Message-ID: <20260820124824.618671-10-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x633.google.com
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

The secure proxy is the message transport between the K3 host cores and
the device management and security controller (DMSC). Model the per-thread
RT/SCFG register banks and the message buffers, and provide a callback
interface, which the DMSC model plugs into.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/misc/Kconfig                |   3 +
 hw/misc/meson.build            |   1 +
 hw/misc/ti-sec-proxy.c         | 446 +++++++++++++++++++++++++++++++++
 hw/misc/trace-events           |   8 +
 include/hw/misc/ti-sec-proxy.h | 108 ++++++++
 5 files changed, 566 insertions(+)
 create mode 100644 hw/misc/ti-sec-proxy.c
 create mode 100644 include/hw/misc/ti-sec-proxy.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e80fdc3214..bea8e9341f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -161,6 +161,9 @@ config TI_K3_SDHCI_PHY
 config TI_K3_TRNG
     bool
 
+config TI_SEC_PROXY
+    bool
+
 config TI_MAILBOX
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d190d8608a..a8a40ea2a7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -129,6 +129,7 @@ system_ss.add(when: 'CONFIG_TI_K3_GTC', if_true: files('ti-k3-gtc.c'))
 system_ss.add(when: 'CONFIG_TI_K3_DDRSS', if_true: files('ti-k3-ddrss.c'))
 system_ss.add(when: 'CONFIG_TI_K3_SDHCI_PHY', if_true: files('ti-k3-sdhci-phy.c'))
 system_ss.add(when: 'CONFIG_TI_K3_TRNG', if_true: files('ti-k3-trng.c'))
+system_ss.add(when: 'CONFIG_TI_SEC_PROXY', if_true: files('ti-sec-proxy.c'))
 system_ss.add(when: 'CONFIG_TI_MAILBOX', if_true: files('ti-mailbox.c'))
 system_ss.add(when: 'CONFIG_TZ_MPC', if_true: files('tz-mpc.c'))
 system_ss.add(when: 'CONFIG_TZ_MSC', if_true: files('tz-msc.c'))
diff --git a/hw/misc/ti-sec-proxy.c b/hw/misc/ti-sec-proxy.c
new file mode 100644
index 0000000000..524bd1353c
--- /dev/null
+++ b/hw/misc/ti-sec-proxy.c
@@ -0,0 +1,446 @@
+/*
+ * TI SEC PROXY SysBus device
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * TI K3 SoCs use it as mailbox transport to the DMSC/SYSFW endpoint.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "hw/misc/ti-sec-proxy.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/register.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "trace.h"
+
+#define SEC_PROXY_MAX_MSG (16)
+
+REG32(SEC_PROXY_0_thread_status, 0x0)
+FIELD(SEC_PROXY_0_thread_status, ERROR, 31, 1)
+FIELD(SEC_PROXY_0_thread_status, DIR, 30, 1)
+FIELD(SEC_PROXY_0_thread_status, MAX_CNT, 16, 8)
+FIELD(SEC_PROXY_0_thread_status, CUR_CNT, 0, 8)
+
+REG32(SEC_PROXY_0_thread_threshold, 0x4)
+FIELD(SEC_PROXY_0_thread_threshold, THR_CNT, 0, 8)
+
+REG32(SEC_PROXY_0_thread_private, 0x0)
+FIELD(SEC_PROXY_0_thread_private, SRC_THR, 0, 10)
+
+REG32(SEC_PROXY_0_thread_message, 0x4)
+
+REG32(SEC_PROXY_0_buffer_l, 0x0)
+REG32(SEC_PROXY_0_buffer_h, 0x4)
+FIELD(SEC_PROXY_0_buffer_h, BASE_H, 0, 16)
+
+REG32(SEC_PROXY_0_target_l, 0x8)
+REG32(SEC_PROXY_0_target_h, 0xc)
+FIELD(SEC_PROXY_0_target_h, TARGET_H, 0, 16)
+
+REG32(SEC_PROXY_0_orderid, 0x10)
+FIELD(SEC_PROXY_0_orderid, ORDERID, 0, 4)
+FIELD(SEC_PROXY_0_orderid, REPLACE, 4, 1)
+
+REG32(SEC_PROXY_0_thread_ctl, 0x0)
+FIELD(SEC_PROXY_0_thread_ctl, QUEUE, 0, 16)
+FIELD(SEC_PROXY_0_thread_ctl, MAX_CNT, 16, 8)
+FIELD(SEC_PROXY_0_thread_ctl, DIR, 31, 1)
+
+REG32(SEC_PROXY_0_thread_evt_map, 0x4)
+FIELD(SEC_PROXY_0_thread_evt_map, THR_EVT, 0, 16)
+FIELD(SEC_PROXY_0_thread_evt_map, ERR_EVT, 16, 16)
+
+REG32(SEC_PROXY_0_thread_dst, 0x8)
+FIELD(SEC_PROXY_0_thread_dst, THREAD, 0, 16)
+
+REG32(SEC_PROXY_0_pid, 0x0)
+FIELD(SEC_PROXY_0_pid, SCHEME, 30, 2)
+FIELD(SEC_PROXY_0_pid, BU, 28, 2)
+FIELD(SEC_PROXY_0_pid, FUNC, 16, 12)
+FIELD(SEC_PROXY_0_pid, RTL, 11, 5)
+FIELD(SEC_PROXY_0_pid, MAJOR, 8, 3)
+FIELD(SEC_PROXY_0_pid, CUSTOM, 6, 2)
+FIELD(SEC_PROXY_0_pid, MINOR, 0, 6)
+
+REG32(SEC_PROXY_0_config, 0x4)
+FIELD(SEC_PROXY_0_config, MSG_SIZE, 16, 16)
+FIELD(SEC_PROXY_0_config, THREADS, 0, 16)
+
+REG32(SEC_PROXY_0_glb_evt, 0x14)
+FIELD(SEC_PROXY_0_glb_evt, ERR_EVENT, 0, 16)
+
+static RegisterAccessInfo sec_proxy_mmrs_regs_info[] = {
+    {
+        .name = "SEC_PROXY_0_pid",
+        .addr = A_SEC_PROXY_0_pid,
+        .ro = 0xffffffff,
+        .reset = 1714843904,
+    },
+    {
+        .name = "SEC_PROXY_0_config",
+        .addr = A_SEC_PROXY_0_config,
+        .ro = 0xffffffff,
+        .reset = 4194380,
+    },
+    {
+        .name = "SEC_PROXY_0_glb_evt",
+        .addr = A_SEC_PROXY_0_glb_evt,
+        .rsvd = 0xffff0000,
+        .reset = 65535,
+    }
+};
+
+static void ti_sec_proxy_realize(DeviceState *dev_soc, Error **errp)
+{
+    ERRP_GUARD();
+    TISecProxyState *s = TI_SEC_PROXY(dev_soc);
+
+    for (int i = 0; i < SEC_PROXY_THREAD_ID_MAX; ++i) {
+        struct TISecProxyThreadInfo *ti = &s->thread_info[i];
+        ti->thread_id = i;
+        /* K3 secure proxy alternates inbound and outbound threads. */
+        ti->is_outbound = (i % 2) ? true : false;
+        ti->num_messages = ti->is_outbound ? SEC_PROXY_MSG_MAX_WORDS : 0;
+        memset(ti->current_message, 0, sizeof(ti->current_message));
+    }
+}
+
+/* --- Backend API exported to DMSC -------------------------------------- */
+void ti_sec_proxy_register_msg_cb(TISecProxyState *sp, uint16_t thread_id,
+                                  TISecProxyMsgCb cb, void *opaque)
+{
+    if (thread_id >= ARRAY_SIZE(sp->thread_info)) {
+        return;
+    }
+
+    sp->thread_info[thread_id].cb = cb;
+    sp->thread_info[thread_id].cb_opaque = opaque;
+}
+
+size_t ti_sec_proxy_push_msg(TISecProxyState *sp, uint16_t thread_id,
+                             const uint32_t *words, size_t nbytes)
+{
+    struct TISecProxyThreadInfo *ti;
+
+    if (thread_id >= ARRAY_SIZE(sp->thread_info)) {
+        return 0;
+    }
+
+    ti = &sp->thread_info[thread_id];
+    if (nbytes > sizeof(ti->current_message) - sizeof(uint32_t)) {
+        return 0;
+    }
+
+    memcpy(&ti->current_message[1], words, nbytes);
+    qemu_irq_raise(sp->irq_evt);
+
+    ti->num_messages++;
+    return ti->num_messages;
+}
+
+uint32_t ti_sec_proxy_get_msg_words(TISecProxyState *sp)
+{
+    return sp->msg_words;
+}
+
+void ti_sec_proxy_reset_thread_count(TISecProxyState *sp, uint16_t thread_id)
+{
+    if (thread_id >= ARRAY_SIZE(sp->thread_info)) {
+        return;
+    }
+
+    sp->thread_info[thread_id].num_messages = 0;
+}
+
+static const char *
+ti_sec_proxy_get_thread_channel_name(enum TISciThreadIds thread_id)
+{
+    const char *thread_names[] = {
+        "MAIN_0_R5_0_READ_RESPONSE_THREAD", "MAIN_0_R5_0_WRITE_THREAD",
+        "MAIN_0_R5_1_READ_RESPONSE_THREAD", "MAIN_0_R5_1_WRITE_THREAD",
+        "MAIN_0_R5_2_READ_RESPONSE_THREAD", "MAIN_0_R5_2_WRITE_THREAD",
+        "MAIN_0_R5_3_READ_RESPONSE_THREAD", "MAIN_0_R5_3_WRITE_THREAD",
+        "A53_0_READ_RESPONSE_THREAD",       "A53_0_WRITE_THREAD",
+        "A53_1_READ_RESPONSE_THREAD",       "A53_1_WRITE_THREAD",
+        "A53_2_READ_RESPONSE_THREAD",       "A53_2_WRITE_THREAD",
+        "A53_3_READ_RESPONSE_THREAD",       "A53_3_WRITE_THREAD",
+        "M4_0_READ_RESPONSE_THREAD",        "M4_0_WRITE_THREAD",
+        "MAIN_1_R5_0_READ_RESPONSE_THREAD", "MAIN_1_R5_0_WRITE_THREAD",
+        "MAIN_1_R5_1_READ_RESPONSE_THREAD", "MAIN_1_R5_1_WRITE_THREAD",
+        "MAIN_1_R5_2_READ_RESPONSE_THREAD", "MAIN_1_R5_2_WRITE_THREAD",
+        "MAIN_1_R5_3_READ_RESPONSE_THREAD", "MAIN_1_R5_3_WRITE_THREAD",
+        "A53_4_READ_RESPONSE_THREAD",       "A53_4_WRITE_THREAD",
+        "ICSSG_0_READ_RESPONSE_THREAD",     "ICSSG_0_WRITE_THREAD",
+        "ICSSG_1_READ_RESPONSE_THREAD",     "ICSSG_1_WRITE_THREAD"};
+
+    if (thread_id < ARRAY_SIZE(thread_names)) {
+        return thread_names[thread_id];
+    }
+    return "UNKNOWN_THREAD";
+}
+
+static void ti_sec_proxy_reset_hold(Object *obj, ResetType type)
+{
+    TISecProxyState *s = TI_SEC_PROXY(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static void ti_sec_proxy_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = ti_sec_proxy_realize;
+    rc->phases.hold = ti_sec_proxy_reset_hold;
+}
+
+static const MemoryRegionOps ti_sec_proxy_mmr_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t ti_sec_proxy_read_scfg(void *opaque, hwaddr addr, unsigned size)
+{
+    TISecProxyState *s = opaque;
+    if (addr <= 0x10) {
+        return 0;
+    }
+
+    hwaddr thread_rel_addr = addr - 0x10;
+    int thread_num = thread_rel_addr / 0x1000;
+    int reg = (thread_rel_addr % 0x1000) / 4;
+    struct TISecProxyThreadInfo *tinfo = &s->thread_info[thread_num];
+
+    trace_ti_sec_proxy_read_scfg(
+        ti_sec_proxy_get_thread_channel_name(thread_num), reg, addr);
+    return tinfo->is_outbound ? 0x0 : 0x80000000;
+}
+
+static void ti_sec_proxy_write_scfg(void *opaque, hwaddr addr, uint64_t value,
+                                    unsigned size)
+{
+    if (addr <= 0x10) {
+        return;
+    }
+
+    int thread_num = addr / 0x1000;
+    int reg = (addr % 0x1000) / 4;
+
+    trace_ti_sec_proxy_write_scfg(
+        ti_sec_proxy_get_thread_channel_name(thread_num), reg, addr, value);
+}
+
+static const MemoryRegionOps ti_sec_proxy_scfg_ops = {
+    .read = ti_sec_proxy_read_scfg,
+    .write = ti_sec_proxy_write_scfg,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t ti_sec_proxy_read_rt(void *opaque, hwaddr addr, unsigned size)
+{
+    TISecProxyState *s = opaque;
+    int thread_num = addr / 0x1000;
+    hwaddr off = addr % 0x1000;
+
+    int byte = off & 0x3;
+
+    struct TISecProxyThreadInfo *tinfo = &s->thread_info[thread_num];
+
+    uint32_t reg_val = (tinfo->num_messages) |
+                       (tinfo->is_outbound ? 0x0 : 0x40000000) |
+                       (tinfo->is_outbound ? (tinfo->num_messages << 16) : 0x0);
+
+    uint64_t ret;
+
+    if (size == 1) {
+        ret = (reg_val >> (8 * byte)) & 0xff;
+    } else if (size == 2) {
+        ret = (reg_val >> (8 * (byte & ~1))) & 0xffff;
+    } else if (size == 4) {
+        ret = reg_val;
+    } else {
+        ret = 0;
+    }
+    trace_ti_sec_proxy_read_rt(ti_sec_proxy_get_thread_channel_name(thread_num),
+                               ret, addr);
+    return ret;
+}
+
+static void ti_sec_proxy_write_rt(void *opaque, hwaddr addr, uint64_t value,
+                                  unsigned size)
+{
+}
+
+static const MemoryRegionOps ti_sec_proxy_rt_ops = {
+    .read = ti_sec_proxy_read_rt,
+    .write = ti_sec_proxy_write_rt,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t ti_sec_proxy_read_target(void *opaque, hwaddr addr,
+                                         unsigned size)
+{
+    TISecProxyState *s = opaque;
+    int thread_num = addr / 0x1000;
+    hwaddr off = addr % 0x1000;
+
+    int reg = off >> 2;    /* 32-bit register index */
+    int byte = off & 0x3;  /* byte offset within the 32-bit register */
+
+    struct TISecProxyThreadInfo *tinfo = &s->thread_info[thread_num];
+
+    /* First fetch the full little-endian 32-bit register. */
+    uint32_t reg_val = (uint32_t)tinfo->current_message[reg];
+    uint64_t ret = 0;
+
+    if (size == 1) {
+        ret = (reg_val >> (8 * byte)) & 0xffu;
+    } else if (size == 2) {
+        /*
+         * Odd halfword reads are rounded down. Guest drivers use aligned
+         * accesses, but this keeps byte-lane handling tolerant.
+         */
+        ret = (reg_val >> (8 * (byte & ~1))) & 0xffffu;
+    } else if (size == 4) {
+        ret = reg_val;
+    } else {
+        /* Shouldn't happen given .valid, but be defensive. */
+        ret = 0;
+    }
+
+    /* For inbound threads reset the message counter */
+    if (!tinfo->is_outbound && reg == SEC_PROXY_MAX_MSG - 1) {
+        trace_ti_sec_proxy_complete_read(
+            ti_sec_proxy_get_thread_channel_name(thread_num),
+            tinfo->num_messages);
+        tinfo->num_messages = 0;
+        qemu_irq_lower(s->irq_evt);
+    }
+    return ret;
+}
+
+static void ti_sec_proxy_write_target(void *opaque, hwaddr addr, uint64_t value,
+                                      unsigned size)
+{
+    TISecProxyState *s = opaque;
+    int thread_num = addr / 0x1000;
+    hwaddr off = addr % 0x1000;
+
+    int reg = off >> 2;    /* 32-bit register index */
+    int byte = off & 0x3;  /* byte offset within the 32-bit register */
+
+    struct TISecProxyThreadInfo *tinfo = &s->thread_info[thread_num];
+
+    if (reg >= 16) {
+        return;
+    }
+
+    uint32_t cur = (uint32_t)tinfo->current_message[reg];
+    uint32_t v32 = (uint32_t)value;
+
+    if (size == 1) {
+        uint32_t mask = 0xffu << (8 * byte);
+        cur = (cur & ~mask) | ((v32 & 0xffu) << (8 * byte));
+    } else if (size == 2) {
+        /* Round odd halfword writes down, same as in the read path. */
+        int hbyte = (byte & ~1);
+        uint32_t mask = 0xffffu << (8 * hbyte);
+        cur = (cur & ~mask) | ((v32 & 0xffffu) << (8 * hbyte));
+    } else if (size == 4) {
+        cur = v32;
+    } else {
+        return;
+    }
+
+    tinfo->current_message[reg] = cur;
+
+    /*
+     * The data-window commit point is the last register. Byte writes can
+     * hit it more than once while the last word is assembled.
+     */
+    if (reg == SEC_PROXY_MAX_MSG - 1) {
+        trace_ti_sec_proxy_complete_write(
+            ti_sec_proxy_get_thread_channel_name(thread_num),
+            tinfo->num_messages);
+
+        if (tinfo->cb) {
+            trace_ti_sec_proxy_announce_callback(
+                ti_sec_proxy_get_thread_channel_name(thread_num));
+            tinfo->cb(tinfo->cb_opaque, thread_num, &tinfo->current_message[1],
+                      SEC_PROXY_MAX_MSG);
+        }
+    }
+}
+
+static const MemoryRegionOps ti_sec_proxy_target_ops = {
+    .read = ti_sec_proxy_read_target,
+    .write = ti_sec_proxy_write_target,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void ti_sec_proxy_init(Object *obj)
+{
+    TISecProxyState *s = TI_SEC_PROXY(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    s->reg_array = register_init_block32(DEVICE(obj), sec_proxy_mmrs_regs_info,
+                                         ARRAY_SIZE(sec_proxy_mmrs_regs_info),
+                                         s->regs_info, s->regs,
+                                         &ti_sec_proxy_mmr_ops, true, 0x100);
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
+
+    memory_region_init_io(&s->iomem_scfg, OBJECT(s), &ti_sec_proxy_scfg_ops, s,
+                          "ti-sec-proxy-scfg", 0x80000);
+    sysbus_init_mmio(sbd, &s->iomem_scfg);
+
+    memory_region_init_io(&s->iomem_rt, OBJECT(s), &ti_sec_proxy_rt_ops, s,
+                          "ti-sec-proxy-rt", 0x80000);
+    sysbus_init_mmio(sbd, &s->iomem_rt);
+
+    memory_region_init_io(&s->iomem_target_data, OBJECT(s),
+                          &ti_sec_proxy_target_ops, s, "ti-sec-proxy-target",
+                          0x80000);
+    sysbus_init_mmio(sbd, &s->iomem_target_data);
+
+    sysbus_init_irq(sbd, &s->irq_evt);
+}
+
+static const TypeInfo ti_sec_proxy_info = {
+    .name = TYPE_TI_SEC_PROXY,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TISecProxyState),
+    .class_init = ti_sec_proxy_class_init,
+    .instance_init = ti_sec_proxy_init,
+};
+
+static void ti_sec_proxy_types(void)
+{
+    type_register_static(&ti_sec_proxy_info);
+}
+
+type_init(ti_sec_proxy_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ea7cde021e..dfa2d04117 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -461,6 +461,14 @@ rat_enable_region(int idx, uint64_t size, uint64_t source, uint64_t dest) "Enabl
 rat_disable_region(int idx) "Disabling RAT Region %u"
 rat_read_entry(int entry, int rel_offset, uint64_t offset) "Reading Entry %i at offset %i: offset: 0x%"PRIx64
 
+# ti-sec-proxy.c
+ti_sec_proxy_read_scfg(const char *name, int reg, uint64_t addr) "thread: %s, reg: %i. read from SCFG addr 0x%" PRIx64
+ti_sec_proxy_write_scfg(const char *name, int reg, uint64_t addr, uint64_t value) "thread: %s, reg: %i. write 0x%" PRIx64 "0x%" PRIx64
+ti_sec_proxy_complete_read(const char *name, int num) "thread: %s completed read message %i. Resetting number of messages"
+ti_sec_proxy_complete_write(const char *name, int num) "thread: %s completed write message %i. Resetting number of messages"
+ti_sec_proxy_announce_callback(const char *name) "invoce callback for thread: %s"
+ti_sec_proxy_read_rt(const char *name, int reg, uint64_t addr) "thread: %s, reg: 0x%x, read from RT addr 0x%" PRIx64
+
 # ti-k3-trng.c
 ti_k3_trng_read(uint64_t addr, uint32_t val) "offset 0x%" PRIx64 " -> 0x%08x"
 ti_k3_trng_write(uint64_t addr, uint64_t val) "offset 0x%" PRIx64 " <- 0x%" PRIx64
diff --git a/include/hw/misc/ti-sec-proxy.h b/include/hw/misc/ti-sec-proxy.h
new file mode 100644
index 0000000000..d028242eff
--- /dev/null
+++ b/include/hw/misc/ti-sec-proxy.h
@@ -0,0 +1,108 @@
+/*
+ * TI K3 secure proxy
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TI_SEC_PROXY_H
+#define TI_SEC_PROXY_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/register.h"
+#include "system/dma.h"
+#include "qom/object.h"
+
+#define TYPE_TI_SEC_PROXY "ti.sec-proxy"
+
+#define RMAX_TI_SEC_PROXY (3)
+
+OBJECT_DECLARE_SIMPLE_TYPE(TISecProxyState, TI_SEC_PROXY)
+
+typedef void (*TISecProxyMsgCb)(void *opaque,
+                               uint16_t thread_id,
+                               const uint32_t *words,
+                               size_t nwords);
+
+enum TISciThreadIds {
+    MAIN_0_R5_0_READ_RESPONSE_THREAD_ID = 0,
+    MAIN_0_R5_0_WRITE_THREAD_ID = 1,
+    MAIN_0_R5_1_READ_RESPONSE_THREAD_ID = 2,
+    MAIN_0_R5_1_WRITE_THREAD_ID = 3,
+    MAIN_0_R5_2_READ_RESPONSE_THREAD_ID = 4,
+    MAIN_0_R5_2_WRITE_THREAD_ID = 5,
+    MAIN_0_R5_3_READ_RESPONSE_THREAD_ID = 6,
+    MAIN_0_R5_3_WRITE_THREAD_ID = 7,
+    A53_0_READ_RESPONSE_THREAD_ID = 8,
+    A53_0_WRITE_THREAD_ID = 9,
+    A53_1_READ_RESPONSE_THREAD_ID = 10,
+    A53_1_WRITE_THREAD_ID = 11,
+    A53_2_READ_RESPONSE_THREAD_ID = 12,
+    A53_2_WRITE_THREAD_ID = 13,
+    A53_3_READ_RESPONSE_THREAD_ID = 14,
+    A53_3_WRITE_THREAD_ID = 15,
+    M4_0_READ_RESPONSE_THREAD_ID = 16,
+    M4_0_WRITE_THREAD_ID = 17,
+    MAIN_1_R5_0_READ_RESPONSE_THREAD_ID = 18,
+    MAIN_1_R5_0_WRITE_THREAD_ID = 19,
+    MAIN_1_R5_1_READ_RESPONSE_THREAD_ID = 20,
+    MAIN_1_R5_1_WRITE_THREAD_ID = 21,
+    MAIN_1_R5_2_READ_RESPONSE_THREAD_ID = 22,
+    MAIN_1_R5_2_WRITE_THREAD_ID = 23,
+    MAIN_1_R5_3_READ_RESPONSE_THREAD_ID = 24,
+    MAIN_1_R5_3_WRITE_THREAD_ID = 25,
+    A53_4_READ_RESPONSE_THREAD_ID = 26,
+    A53_4_WRITE_THREAD_ID = 27,
+    ICSSG_0_READ_RESPONSE_THREAD_ID = 28,
+    ICSSG_0_WRITE_THREAD_ID = 29,
+    ICSSG_1_READ_RESPONSE_THREAD_ID = 30,
+    ICSSG_1_WRITE_THREAD_ID = 31,
+    SEC_PROXY_THREAD_ID_MAX,
+};
+
+#define SEC_PROXY_MSG_MAX_WORDS (16)
+#define SEC_PROXY_MSG_FIFO_DEPTH (16)
+
+struct TISecProxyThreadInfo {
+    uint8_t thread_id;
+    uint8_t num_messages;
+    uint32_t current_message[SEC_PROXY_MSG_MAX_WORDS];
+    bool is_outbound;
+    /* Callback invoked on commit (outbound only) */
+    TISecProxyMsgCb cb;
+    void *cb_opaque;
+};
+
+struct TISecProxyState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem_scfg;
+    MemoryRegion iomem_rt;
+    MemoryRegion iomem_target_data;
+    RegisterInfoArray *reg_array;
+    qemu_irq irq_evt;
+    uint32_t regs[RMAX_TI_SEC_PROXY];
+    RegisterInfo regs_info[RMAX_TI_SEC_PROXY];
+    struct TISecProxyThreadInfo thread_info[SEC_PROXY_THREAD_ID_MAX];
+    uint32_t msg_words;
+};
+
+
+/* Backend API used by ti-dmsc, resp. other consumers */
+void ti_sec_proxy_register_msg_cb(TISecProxyState *sp,
+                                  uint16_t thread_id,
+                                  TISecProxyMsgCb cb,
+                                  void *opaque);
+
+size_t ti_sec_proxy_push_msg(TISecProxyState *sp, uint16_t thread_id,
+                             const uint32_t *words, size_t nbytes);
+
+uint32_t ti_sec_proxy_get_msg_words(TISecProxyState *sp);
+
+/*
+ * Clear an outbound thread counter before requeueing unsolicited messages.
+ * push_msg() only increments it; reads clear only inbound threads.
+ */
+void ti_sec_proxy_reset_thread_count(TISecProxyState *sp, uint16_t thread_id);
+#endif
-- 
2.43.0


