Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3FDD26284
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGh3-0000hK-Bw; Tue, 20 Jan 2026 13:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGgB-0007SP-CU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:15 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGg8-0006g1-R3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:14 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso3193281f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934530; x=1769539330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zqrLqq609CQUjCSSvXVi6semWi0zMFDysWxfDqV7aAs=;
 b=g19OgJpocvMqwwOMK9MheMYi6iBgXp/UY1+dmW3fy4xlHeNwl51ti4yqZuRbNMzzFB
 yWQHmem8rtGBTMCRbs3F5f6iadwTctG/l7zydT8rnB2I15xmj3F2ZIzJLrYEpc6smrH0
 HyO7y0BnMsX7IXVIYxtLIYqDEyVzSlD0hFHy1ouV9tSP6ooBGW169cVpX6z104pImjFW
 6lDV5TJ/81CH+Rb2kP/qCt/IvlACqLaCsZiSI1b/zEKLGbuGL8GIyAM6sBBF8+h22Vl9
 cdZl18FaCi+5l0reQg78U12TY/6VprF6GOHXoE8dusfngdGNy//aVhFLsSSCi9b1gN1d
 sEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934530; x=1769539330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zqrLqq609CQUjCSSvXVi6semWi0zMFDysWxfDqV7aAs=;
 b=cuRQgNzVF/W/fRlP1xw18JtDpaHTevDiE1urUKB6S6qpF5PAJ3s+tQKu1sRcPooO6p
 om7zC3RnBY897maoGZu4Ma3H8fqfPpsdstQPieom0Num10/hfZq+agZjupJybtWBcPbV
 AU5+V6Hm+TFL81rRldg2tqDXcW/V8XDSuSGKpmkx0N5k5rk3/EceF4nH7W+EYUEQan3K
 RSROB6ALl/weANa1wM9rB8d88NWI8JmjdEkZ+nBgCxr96bCarhIBPRpttbThnT70KPlN
 ijCtol274Xq7x2gdIAVxHk5hA+S9WO+N942ad6sb8EZdnpvR4rkLsHWCHjllmNQacF+Q
 eCug==
X-Gm-Message-State: AOJu0YwHO8jROQJxnzuMpIQTGPFjCFaMbdj1Uryh/vHnKBxiqUjzoGKa
 F107vrqHW3D7OurZXFocxcnfgygN8LyQCHdcM0ygABYf2tmhOpQwBr7RwSuxlYOj/xSpKDGiv5q
 avt48hRE=
X-Gm-Gg: AZuq6aKQkSuy5F5dFIA9kFzhdgMD/fcaGRH0dlzDlOJPz6o7Suurc0Gd+DtdjHQzgp/
 j+Nip0nsnN40f9vP9BNKDpMxI4DrTXzAFuMCy3To+EEpOn8rK/mDFOE/GaMDdt3kWf3Gh7JwF1r
 hdGSHp7iZcXOaoWXEVVZ9mS4UjIJaYCcqj8vJmBxartKxtuCORhkl8d/ejhdKK/yvKj+VYhwa6n
 2QtPGtSl8mGYVdIyH02TvsesAaFvlJA0iue2ClfpqqoGpsdKxlzBbjP87GXe+Xq37rMDI8uUK3H
 jCBHCjdqz13E+ltMDnAR45xVm+95Jqnz0q/6IELKsPXU/H3K8XQdc8HiHpnAS60xOY5nK6Gid7U
 pYS9KP1dRbXpyaCUn8jELCMPyLHoZkdZMLZyTzsgK5QggG9ehxrKE9X4n5et4p69Zb4E+O1morL
 Bxue4tWHMnr7NfxOlyY5wb80ZhAljeJh2kFOeePbA797xpwtEldfHgeHf7WIZhYbw/z5UwhWk=
X-Received: by 2002:a05:6000:2505:b0:432:5b81:49c with SMTP id
 ffacd0b85a97d-43569bd463bmr17900265f8f.55.1768934529487; 
 Tue, 20 Jan 2026 10:42:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435996540cesm56559f8f.43.2026.01.20.10.42.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:42:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/29] hw/uefi: add pcap support
Date: Tue, 20 Jan 2026 19:39:00 +0100
Message-ID: <20260120183902.73845-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

From: Gerd Hoffmann <kraxel@redhat.com>

Add pcapfile property to uevi-vars-* devices, allowing to write out a
capture of the communication traffic between uefi firmware and qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260114110406.3500357-3-kraxel@redhat.com>
[PMD: Wrap long line to avoid checkpatch.pl warning]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/uefi/var-service.h | 10 ++++
 hw/uefi/var-service-core.c    |  7 +++
 hw/uefi/var-service-pcap.c    | 95 +++++++++++++++++++++++++++++++++++
 hw/uefi/var-service-sysbus.c  |  1 +
 hw/uefi/meson.build           |  1 +
 5 files changed, 114 insertions(+)
 create mode 100644 hw/uefi/var-service-pcap.c

diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
index 91fb4a20918..7d84025cd58 100644
--- a/include/hw/uefi/var-service.h
+++ b/include/hw/uefi/var-service.h
@@ -77,6 +77,10 @@ struct uefi_vars_state {
     bool                              force_secure_boot;
     bool                              disable_custom_mode;
     bool                              use_pio;
+
+    /* request + reply capture */
+    char                              *pcapfile;
+    FILE                              *pcapfp;
 };
 
 struct uefi_vars_cert {
@@ -189,4 +193,10 @@ uefi_var_policy *uefi_vars_add_policy(uefi_vars_state *uv,
                                       variable_policy_entry *pe);
 uint32_t uefi_vars_mm_check_policy_proto(uefi_vars_state *uv);
 
+/* vars-service-pcap.c */
+void uefi_vars_pcap_init(uefi_vars_state *uv, Error **errp);
+void uefi_vars_pcap_reset(uefi_vars_state *uv);
+void uefi_vars_pcap_request(uefi_vars_state *uv, void *buffer, size_t size);
+void uefi_vars_pcap_reply(uefi_vars_state *uv, void *buffer, size_t size);
+
 #endif /* QEMU_UEFI_VAR_SERVICE_H */
diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 6ab8df091aa..ce0628fa524 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -101,6 +101,8 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
     }
     memset(uv->buffer + size, 0, uv->buf_size - size);
 
+    uefi_vars_pcap_request(uv, uv->buffer, size);
+
     /* dispatch */
     if (qemu_uuid_is_equal(&mhdr->guid, &EfiSmmVariableProtocolGuid)) {
         retval = uefi_vars_mm_vars_proto(uv);
@@ -127,6 +129,8 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
         retval = UEFI_VARS_STS_ERR_NOT_SUPPORTED;
     }
 
+    uefi_vars_pcap_reply(uv, uv->buffer, sizeof(*mhdr) + mhdr->length);
+
     /* write buffer */
     if (dma_mode) {
         dma_memory_write(&address_space_memory, dma,
@@ -163,6 +167,8 @@ void uefi_vars_hard_reset(uefi_vars_state *uv)
     uefi_vars_clear_volatile(uv);
     uefi_vars_policies_clear(uv);
     uefi_vars_auth_init(uv);
+
+    uefi_vars_pcap_reset(uv);
 }
 
 static uint32_t uefi_vars_cmd(uefi_vars_state *uv, uint32_t cmd)
@@ -319,4 +325,5 @@ void uefi_vars_realize(uefi_vars_state *uv, Error **errp)
 {
     uefi_vars_json_init(uv, errp);
     uefi_vars_json_load(uv, errp);
+    uefi_vars_pcap_init(uv, errp);
 }
diff --git a/hw/uefi/var-service-pcap.c b/hw/uefi/var-service-pcap.c
new file mode 100644
index 00000000000..a09ee1d4c05
--- /dev/null
+++ b/hw/uefi/var-service-pcap.c
@@ -0,0 +1,95 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/pcap.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+#define LINKTYPE_EDK2_MM  302
+
+#define SNAPLEN   (64 * 1024)
+#define TYPE_RESET       0x01
+#define TYPE_REQUEST     0x02
+#define TYPE_REPLY       0x03
+
+static void uefi_vars_pcap_header(FILE *fp)
+{
+    static const struct pcap_hdr header = {
+        .magic_number  = PCAP_MAGIC,
+        .version_major = PCAP_MAJOR,
+        .version_minor = PCAP_MINOR,
+        .snaplen       = SNAPLEN,
+        .network       = LINKTYPE_EDK2_MM,
+    };
+
+    fwrite(&header, sizeof(header), 1, fp);
+    fflush(fp);
+}
+
+static void uefi_vars_pcap_packet(FILE *fp, uint32_t type,
+                                  void *buffer, size_t size)
+{
+    struct pcaprec_hdr header;
+    struct timeval tv;
+    uint32_t orig_len = size + sizeof(type);
+    uint32_t incl_len = MIN(orig_len, SNAPLEN);
+
+    gettimeofday(&tv, NULL);
+    header.ts_sec   = tv.tv_sec;
+    header.ts_usec  = tv.tv_usec;
+    header.incl_len = incl_len;
+    header.orig_len = orig_len;
+
+    fwrite(&header, sizeof(header), 1, fp);
+    fwrite(&type, sizeof(type), 1, fp);
+    if (buffer) {
+        fwrite(buffer, incl_len - sizeof(type), 1, fp);
+    }
+    fflush(fp);
+}
+
+void uefi_vars_pcap_init(uefi_vars_state *uv, Error **errp)
+{
+    int fd;
+
+    if (!uv->pcapfile) {
+        return;
+    }
+
+    fd = qemu_create(uv->pcapfile,
+                     O_WRONLY | O_TRUNC | O_BINARY,
+                     0666, errp);
+    if (fd < 0) {
+        return;
+    }
+
+    uv->pcapfp = fdopen(fd, "wb");
+    uefi_vars_pcap_header(uv->pcapfp);
+}
+
+void uefi_vars_pcap_reset(uefi_vars_state *uv)
+{
+    if (!uv->pcapfp) {
+        return;
+    }
+    uefi_vars_pcap_packet(uv->pcapfp, TYPE_RESET, NULL, 0);
+}
+
+void uefi_vars_pcap_request(uefi_vars_state *uv, void *buffer, size_t size)
+{
+    if (!uv->pcapfp) {
+        return;
+    }
+    uefi_vars_pcap_packet(uv->pcapfp, TYPE_REQUEST, buffer, size);
+}
+
+void uefi_vars_pcap_reply(uefi_vars_state *uv, void *buffer, size_t size)
+{
+    if (!uv->pcapfp) {
+        return;
+    }
+    uefi_vars_pcap_packet(uv->pcapfp, TYPE_REPLY, buffer, size);
+}
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 75b07905184..97a96cae6a2 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -33,6 +33,7 @@ static const Property uefi_vars_sysbus_properties[] = {
     DEFINE_PROP_SIZE("size", uefi_vars_sysbus_state, state.max_storage,
                      256 * 1024),
     DEFINE_PROP_STRING("jsonfile", uefi_vars_sysbus_state, state.jsonfile),
+    DEFINE_PROP_STRING("pcapfile", uefi_vars_sysbus_state, state.pcapfile),
     DEFINE_PROP_BOOL("force-secure-boot", uefi_vars_sysbus_state,
                      state.force_secure_boot, false),
     DEFINE_PROP_BOOL("disable-custom-mode", uefi_vars_sysbus_state,
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index c8f38dfae24..3eae4755331 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -3,6 +3,7 @@ system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
 uefi_vars_ss = ss.source_set()
 if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
   uefi_vars_ss.add(files('var-service-core.c',
+                         'var-service-pcap.c',
                          'var-service-json.c',
                          'var-service-vars.c',
                          'var-service-auth.c',
-- 
2.52.0


