Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB2BCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVaU-0008O2-Hw; Mon, 24 Nov 2025 07:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVaQ-0007sr-H3
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:22:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVaP-000501-0E
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:22:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b32a5494dso2230192f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763986946; x=1764591746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3+/GijK5JEPOPt41Auc+/pV39fF1QckxWTOtscyJYM=;
 b=p7HL+bH8rYYhKjoZtcUtm6frDVhieHPMpC5RmO31ykx9xmY63FdIh9XTx7rVPVQMk1
 Ii0POdRG7MnvFNvx2UJfHZtUW6tBzB/PYF6tKap+Oagr4oxIM1hg/eZoJeclcUP9tZWR
 wexzvkQiNeNTiHxn4saiV6sdDE4Mnk4u0DPHc/GwhF51rtxVSoEzIKh6wpBqAO/HHiK+
 4rsovdxHwzoQTWjH+M3Ki5qup9HB9YVAzIlOgHF7nHnF0MFH/7Lj/MNPcr5T2C/Rp3E5
 QewbadDK+2YIc6mJzrxFoOIX6ic+l3IGbcqcsrpT6X7Tx4VtdB3SgwoE4PnHTRXAXOjn
 +HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763986946; x=1764591746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3+/GijK5JEPOPt41Auc+/pV39fF1QckxWTOtscyJYM=;
 b=HGsEbVxiHvfxStzbkFHwshy78++G1tu+VrSxUFcLP+MqeoInuCJ39iyyagcecECndO
 bKmVy0ZKDw2PrNH2FhmN3dY4oJ8Dvc9u9qly0Ci/IemWcr2OLKj5b2vQqLzl8mWknDfe
 j01XCBS8/N18aZHH+PMgMSiB5YZFFW3D2QnZyw9MmqGOeoI+gsQlatrFkLoHrPMozQgN
 o9BAHHnU9ejwxrykgDvy7xHpGSpZe0T5uF7uDnwySDTXEy9Tulwhq9zNOIIImzMSzMRe
 U3BzqI898ghnVsQeaq3701MScjFkDN470zrAJgkd+9+aBrpB2zAf1psJKuvYpKOlHn3U
 CE/Q==
X-Gm-Message-State: AOJu0YzNKkpUISISM3nb7qxBtdMIBaiPtRHhqq2Ujig8cBCHIyvvJdPW
 jOe3Qln1oHBMnRU56PZ5gZ1OQA3b1qW4bjKoVvcZAy96ddcX3ry98JhVniQ/E7RTp+FRghXmU7T
 064JGHsJToA==
X-Gm-Gg: ASbGncu5QEmQshQAFaoVJHnCJJtZmFOm7CXHGGabvcaz8xUgNcBDxYkw9HENi0+1yEv
 sm4Ifa00De1KJ9XeOrzpRX01LnTv2xS/m6QtzEZJT53f08N/8vHHigugj4El95j5E/W/xV9TTSM
 aidQf52AcXJyfq7XlLJS0w/1Sw0bNafp4oajPkZDceuqahRqd7YiYlZKkpXuV2LbL05NAx/whG8
 yhindbX/u3dnrHznWuFVPyz5sTWrx2TC/zL84I77MRR81hdIdkLkuMKjWghvXlItANXsbWYMsl2
 Z2AhSTsm7Q+mf6GZ6OVxuM3uRv6fwLYaRwYZMch9eFE6EUYzRi4yLDFU1CXXU/2/Z3FyKIzKiyQ
 B+j9SyCyv5BsRMG5WuhV4yzIV6moHdFcRq+8Nw0HfsShV7DQAchDJCSvuFIuiwaLKCpGg3z87Rw
 jYh7ce3MSE+UiWlwUa1xhGodzmwITu4ZmhF1Y+aNESn6iPqih6/FbS3bnV1nvi
X-Google-Smtp-Source: AGHT+IEe3/eQdFB6gxgR123nQ9KzDuQk2kOelRb7QHRBxMeX0GR+vMjXu4C9MqBkHZq07LewOGKnwg==
X-Received: by 2002:a05:6000:401f:b0:42b:3bfc:d5cd with SMTP id
 ffacd0b85a97d-42cc1cd94f3mr12976085f8f.1.1763986946570; 
 Mon, 24 Nov 2025 04:22:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm28026092f8f.34.2025.11.24.04.22.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 04:22:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC-PATCH-for-11.0] loader: Add support for U-Boot
 Zstandard-compressed image
Date: Mon, 24 Nov 2025 13:22:24 +0100
Message-ID: <20251124122224.80830-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

U-Boot is able to decompress Zstandard images since almost
6 years (u-boot commit 8509f22a).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
---
 hw/core/loader.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index e5904cdafa1..97fa8248ce7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -635,7 +635,7 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
     uboot_image_header_t *hdr = &h;
     uint8_t *data = NULL;
     int ret = -1;
-    int do_uncompress = 0;
+    bool do_uncompress = false;
 
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0)
@@ -685,7 +685,8 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
         case IH_COMP_NONE:
             break;
         case IH_COMP_GZIP:
-            do_uncompress = 1;
+        case IH_COMP_ZSTD:
+            do_uncompress = true;
             break;
         default:
             fprintf(stderr,
@@ -747,10 +748,23 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
         max_bytes = UBOOT_MAX_GUNZIP_BYTES;
         data = g_malloc(max_bytes);
 
-        bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
+        switch (hdr->ih_comp) {
+        case IH_COMP_GZIP:
+            bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
+            break;
+#ifdef CONFIG_ZSTD
+        case IH_COMP_ZSTD: {
+            size_t ret = ZSTD_decompress(data, max_bytes,
+                                         compressed_data, hdr->ih_size);
+            bytes = ZSTD_isError(ret) ? -1 : (ssize_t) ret;
+            } break;
+#endif
+        default:
+            g_assert_not_reached();
+        }
         g_free(compressed_data);
         if (bytes < 0) {
-            fprintf(stderr, "Unable to decompress gzipped image!\n");
+            fprintf(stderr, "Unable to decompress image!\n");
             goto out;
         }
         hdr->ih_size = bytes;
-- 
2.51.0


