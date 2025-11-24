Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8674CCFD31F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVpU-0001VB-CD; Mon, 24 Nov 2025 07:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnT-0004Zf-1E
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:36:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnO-0007Jc-Nv
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:35:57 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b32a5494dso2238397f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763987741; x=1764592541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJpIBNaZOFuhnrwWjkztkAq8tKp5jAAxKtIuMTnAr+k=;
 b=jrvsbgQTxsLfGRnDrTkyJyYBFaily9jiymSB/7G/igrkyubWrdeOKpWBggS2hYmNm2
 vV4y0JruNpc08Z/IxAHKxmpEO/mGRJFxz49rV/7xEBmeuGwYjirLnCFJWwcczQRzvc1n
 lXJdhxEw5FaLev+PM/ZjBKlE2jA1ZHJEsjPypmL6NzDu2Rzlpa/VS/kA3l1CHBBcUaCS
 owK+12H8JZsee7mh0DqIDtaXpmBR6xCf4qNMe5R3yJ6nefx4DjaAe4EQXgolvKjpByXt
 0lvSTEM4/jaen7qpYKJrs83NSaPAZ9AvDIQTPb+j9G/ylC1oexKuGab3E/O+nfXdZtnl
 uyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987741; x=1764592541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UJpIBNaZOFuhnrwWjkztkAq8tKp5jAAxKtIuMTnAr+k=;
 b=cMFoP8IfC5nY93fVxA8SAwk/6jUa9mON92QawxrsmFdmJSKnePY4c7Upnh+BGB0B7Y
 taOTrB6MwVe0ypP+LqIzkkEU5tHUVTgfv5w49zR1DhV8pBMIo5CB1mwpi83eyjjcEJZu
 XCp2CC49VMQ08PYmgiNTsPRCY5Pwj1XkXjqUcRDOTN6qeJoJU+7Eqj9uKV8OLkAkGNOF
 5/YBMLNTsGqmQOLTeTUhzvvna94uo1PwGj/Ya9NEYYElq0QMN2RDfuMX8mVpf8mzm2J8
 lbd9FfRaDRgfSQnTQfrDgexwQ8MfTJzvSaXqVOtmhW08hkvF/x00DVKuhaj1QX/SQQmZ
 z3Jw==
X-Gm-Message-State: AOJu0YyCSZsESC4unOfgSrdDgzpa6l7kJwumSWVqOtLTk7aTilUMhp0Q
 NZy1LblM0t+E5lJR5TUkwIt/gYvAhYQfTZTjzD2b/ncrKryJRKUiTVtF2xizpfK6
X-Gm-Gg: ASbGncuPZaYTOb3xrQEcl/5GbGkIzQc6GMAm/9Qo0aVUHgdBP4z5vx+iFfZFACNfI+e
 oKRO/L7a5zdwgA2YJdyQ6AhuMZ5zXjq4HivL6YC2yjiWRR39WGCx7Rk82H4UcUm7QKAfp2R7v6U
 7/oHFvzfoDOU+egqT0VWfF9ssLGVc/9F452yUnr4mmKIH7H68vuV72TEys3/R49l0wYrZesZcQr
 lvhWLORmvkvu9R+es8BIGjFRZSNS4hcJ5ltZ4eEoKaXhlc2clLfGCDaotICGMVSn8daBJLnmW/j
 10eWFiBcWwdhX5O8Rw0w5dGICEHMQX9sItV0nGnHaak6LC3vUrWyg77yhAXvbc1UMB152LcCOb3
 yfHUfAP1jLo1ThyhDEMYhmN+pK4JjVAt0fWkshRZPa6323yMjyQb9IRl4BbQTK9lVwyHw86Iw8X
 ophb+UqLvbgnRBIVvdZGCXhTWhgI0zzpIOTD/xPYB2DGHO1MY2ZpzGXfm0rTW1afQ0iQ==
X-Google-Smtp-Source: AGHT+IHTDRqhAMbKnspIob5GZBMfGzZsXUAPCH2NX/ECmyvAmnkW7Wqwniz8JZ93/vPNfhiHDx75gg==
X-Received: by 2002:a05:6000:2601:b0:42b:3da6:6d32 with SMTP id
 ffacd0b85a97d-42cc1cf3bedmr10859489f8f.23.1763987740731; 
 Mon, 24 Nov 2025 04:35:40 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm29398449f8f.38.2025.11.24.04.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 04:35:39 -0800 (PST)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton <paulburton@kernel.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 4/4] Add support for zboot images compressed with zstd
Date: Mon, 24 Nov 2025 13:35:21 +0100
Message-ID: <20251124123521.1058183-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
References: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 hw/core/loader.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index d74e33ceb6..8924767e7d 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -68,6 +68,11 @@
 
 #include <zlib.h>
 
+#ifdef CONFIG_ZSTD
+#include <zstd.h>
+#include <zstd_errors.h>
+#endif
+
 static int roms_loaded;
 
 /* return the size or -1 if error */
@@ -901,14 +906,6 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
         return 0;
     }
 
-    if (strcmp(header->compression_type, "gzip") != 0) {
-        fprintf(stderr,
-                "unable to handle EFI zboot image with \"%.*s\" compression\n",
-                (int)sizeof(header->compression_type) - 1,
-                header->compression_type);
-        return -1;
-    }
-
     ploff = ldl_le_p(&header->payload_offset);
     plsize = ldl_le_p(&header->payload_size);
 
@@ -918,7 +915,22 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
     }
 
     data = g_malloc(max_bytes);
-    bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
+
+    if (strcmp(header->compression_type, "gzip") == 0) {
+        bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
+#ifdef CONFIG_ZSTD
+    } else if (strcmp(header->compression_type, "zstd") == 0) {
+        size_t ret = ZSTD_decompress(data, max_bytes, *buffer + ploff, plsize);
+        bytes = ZSTD_isError(ret) ? -1 : (ssize_t) ret;
+#endif
+    } else {
+        fprintf(stderr,
+                "unable to handle EFI zboot image with \"%.*s\" compression\n",
+                (int)sizeof(header->compression_type) - 1,
+                header->compression_type);
+        return -1;
+    }
+
     if (bytes < 0) {
         fprintf(stderr, "failed to decompress EFI zboot image\n");
         return -1;
-- 
2.51.1


