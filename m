Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490FD2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGh0-0000J6-Cw; Tue, 20 Jan 2026 13:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGg5-0007K5-5F
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGg0-0006fS-Sf
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-480142406b3so31098305e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934523; x=1769539323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jd3E3cgQtLspUatXKsJv5d53ERg76xpdU3e+kzswFcU=;
 b=mn7Kr+3Ydqdwp+WYs7EtgIyIjd80R2rMJ45fkqvY6lzaT75+y5U9dC4i+JI1efF2Hr
 5OePBzi5NTpxXfzbStyxhDUTIl1V5LrfIdZVlSVIhWa9CI7VNTF5fXN9iyq9t9m+fhbr
 XcmLQROOjmrmqKhu1aRGDNBfuB/+7xGU0omyVyquqe77oP95ZKl+HbT7ju3K0z67LifV
 BM85d7EzbgmdEkMN831+/HBqgpHxGsdn5ZybWnWg3pIHDvjYVWhSAoVsKAEHVrZjTXUy
 qzA/uXyLr15Xs3z+8iryyyQy7Mg1afnpAmkefpy+QcfZ7xoWFxhnHP1C7adE5vg8l3Yd
 ACgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934523; x=1769539323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jd3E3cgQtLspUatXKsJv5d53ERg76xpdU3e+kzswFcU=;
 b=Q0GpJZGU9bIZhLbjIRGFTVRgQBlxaJVWkaYyWflt1EOYZSlp6VSyGTlSyz98eAM+tp
 NidtCL4Nwv8wmBHSlhO3eWm0ytblQJXxTgi9/4fbVMZ4FyHRxYkQvMMI6tAYUMKA4ovX
 dB8BhRigaSKvCZ5T0AYIbBvsvdM27spti2Uyjav496VzPBAoMvRRgXz+YWwdFVUzBolA
 gcrK/YGpARtAzBPfPII9au4CMHDf6Fria2JSSwfLEGSVLuu+vMED2CGwc1Vrm6qbl6+j
 2Zy5Ri9A4ae8xguQubm8Wi945BTSmOn/3BwS9VjF4bchF6MnZJO8mF55bUa4wMppt6ln
 sWXw==
X-Gm-Message-State: AOJu0YwofT5krF/5F88UbTZDD6qmsz1vHbxigkIO3PR4MuOmIAnjsas+
 LrY3LkwuasFqA9/2bAuepr0lKgBYOHmmu5/auUAtmsEfa94jkpycEp5gFe1tEjEpoaCb7hWA9Rf
 z4vs+LZg=
X-Gm-Gg: AY/fxX6FXC8w5OU/Q39qLj/ER2XEGFlDbDYvp5Acg5NeqmssmXrDKHJY8FJHlMbGOpr
 FMvH2EFPrnemByIMLVNCKMr6I3DtD+ktn32UggQttM9SJTmzJd29jwRDg9zJwYEmtXedQ1c2q4y
 4ieLvr+McWtFzdsaA3qrIkxv9ZnQEzjLpxVeTR2LoYb6ImVSRpVpztZgfIUm00qnEyn+tbr6LtI
 GQoZOI215xrLVP2qEQPmNFUimNaCRjOkQbrGI3FUrCG8kEheirij30aDzgflaxCCYG79gRNNbT8
 B2f+ECFeLEQ4gvmF8JZ9yr07hF/K6tZD4xY3+sAGN+ql2yciOsbtC5CXe/SxMHGMGLLQB0StWEX
 pO7mnXfBWLvhu0wdYBWHL1JkK/KyZRU1NTgA8utqqGL7UM5WcNAghfiKuCsbTrEJWueTof6LCtk
 2mSh7JmJ7BcKdyXsXJA1pyPrUWFk4TeAuo4sV5WMNgdDr1dOst/BgefaQ6I8dB
X-Received: by 2002:a05:600c:a305:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-4802521516emr147455075e9.24.1768934522907; 
 Tue, 20 Jan 2026 10:42:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595e0a705sm2697508f8f.14.2026.01.20.10.42.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:42:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/29] hw: move pcap structs to header file
Date: Tue, 20 Jan 2026 19:38:59 +0100
Message-ID: <20260120183902.73845-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Allow reusing them elsewhere in qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260114110406.3500357-2-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/pcap.h | 30 ++++++++++++++++++++++++++++++
 hw/usb/pcap.c       | 24 +-----------------------
 2 files changed, 31 insertions(+), 23 deletions(-)
 create mode 100644 include/qemu/pcap.h

diff --git a/include/qemu/pcap.h b/include/qemu/pcap.h
new file mode 100644
index 00000000000..05aba83c15b
--- /dev/null
+++ b/include/qemu/pcap.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_PCAP_H
+#define QEMU_PCAP_H
+
+#define PCAP_MAGIC                   0xa1b2c3d4
+#define PCAP_MAJOR                   2
+#define PCAP_MINOR                   4
+
+/* https://wiki.wireshark.org/Development/LibpcapFileFormat */
+
+struct pcap_hdr {
+    uint32_t magic_number;   /* magic number */
+    uint16_t version_major;  /* major version number */
+    uint16_t version_minor;  /* minor version number */
+    int32_t  thiszone;       /* GMT to local correction */
+    uint32_t sigfigs;        /* accuracy of timestamps */
+    uint32_t snaplen;        /* max length of captured packets, in octets */
+    uint32_t network;        /* data link type */
+};
+
+struct pcaprec_hdr {
+    uint32_t ts_sec;         /* timestamp seconds */
+    uint32_t ts_usec;        /* timestamp microseconds */
+    uint32_t incl_len;       /* number of octets of packet saved in file */
+    uint32_t orig_len;       /* actual length of packet */
+};
+
+#endif /* QEMU_PCAP_H */
diff --git a/hw/usb/pcap.c b/hw/usb/pcap.c
index bb74d046a59..1fe772d5066 100644
--- a/hw/usb/pcap.c
+++ b/hw/usb/pcap.c
@@ -8,31 +8,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/pcap.h"
 #include "hw/usb/usb.h"
 
-#define PCAP_MAGIC                   0xa1b2c3d4
-#define PCAP_MAJOR                   2
-#define PCAP_MINOR                   4
-
-/* https://wiki.wireshark.org/Development/LibpcapFileFormat */
-
-struct pcap_hdr {
-    uint32_t magic_number;   /* magic number */
-    uint16_t version_major;  /* major version number */
-    uint16_t version_minor;  /* minor version number */
-    int32_t  thiszone;       /* GMT to local correction */
-    uint32_t sigfigs;        /* accuracy of timestamps */
-    uint32_t snaplen;        /* max length of captured packets, in octets */
-    uint32_t network;        /* data link type */
-};
-
-struct pcaprec_hdr {
-    uint32_t ts_sec;         /* timestamp seconds */
-    uint32_t ts_usec;        /* timestamp microseconds */
-    uint32_t incl_len;       /* number of octets of packet saved in file */
-    uint32_t orig_len;       /* actual length of packet */
-};
-
 /* https://www.tcpdump.org/linktypes.html */
 /* linux: Documentation/usb/usbmon.rst */
 /* linux: drivers/usb/mon/mon_bin.c */
-- 
2.52.0


