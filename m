Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC818D5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBsn-0006Rc-8a; Mon, 15 Dec 2025 11:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vVBsj-0006Qr-Qp
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:57:09 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vVBsh-0003J1-6L
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 11:57:09 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a087b2a9c0so26972365ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765817826; x=1766422626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlmep2q9td76PCYg8X7guf9whxirVcSaE6Y/wnkBSEQ=;
 b=kzf0/CoELV8BItlu1bz3rPoCtl0SeXlfpRUxRMeOmQPg+fURPMUBFXX9tLLNhv2PGC
 nuKIOWKVbg82rdLubrrcBhWU6dWfpR4zh00ePMDr/qyGSNthenEmDSMWPNVdnIKIiTOa
 ffTnu4ZYdvuCsJ3/rk/fNlKU6boVpLp233+W0mpXgffJLfS7R5IYsI2f0HwQVl5Rwa9K
 EexHDlxzx7gV4iOVrQvTofljEOROx2TdkwLqJrKyYYMgfIzWE5Cn/C7pzScUUeqt+gC7
 VvqFEJo3kQtsHjJxp5uf7YSHC4W81sJarFQFty9kT94EnuL4vGknBFS4eamJUZDzkqyO
 AGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765817826; x=1766422626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlmep2q9td76PCYg8X7guf9whxirVcSaE6Y/wnkBSEQ=;
 b=HGZyq5fRKw8vSLQBo+9pYyi/loo/YGkwV1ws3LNx4pRL6RW6nWRlo1zGzG8PgGLBhh
 F8tGGFVUSDJNh0hBYV/xbwBChi9LbCFyhsfpeTPSxI1SpyWeIInImA+MlR/XPmWd1DPE
 Vn9+HVUwpstW4wBaJxeTGm70ZNrgTalUaEh/XmtOxrmCoa46D501mfUgeySwToHX3SWa
 L7FXKofUA2zMiXk6zf4MJ+U432LLzOzm8u73lsVW4R+1NgW/Yssqg5H5QnxscLAvHQu9
 J18L4D5zoSDBIzIAzbi/p02ZfzkDpQRXQya3WSr8du81XNb+L2fqUz/F5Cj6/+65NNiW
 07NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6aMaCOMi5RbbNZnkoFtbbCvLFymyjMUADojZZi7WUe0pDDApXOAhHbbZIulRtJqXuOKyE//bB039f@nongnu.org
X-Gm-Message-State: AOJu0YzwqCq0bc3JfzbtwwR0uOXI7lR9hHBYTX5UasfRo8yJFZbBlRcE
 tvJKaVK9aDab7UOe+r+oYwFM2Rph6wqfssP9OJGNlRD5yEP/bFpwFdqW
X-Gm-Gg: AY/fxX5GnhEQtx6kkxm2w2pQWYB+BCE9iQcVD32v8e7teDEAkqRulEhQL7XAU90JeCF
 F2SPSneBJ2bQVqQNwVTFXPhcCYGRImjvvbVnRecwCDZ+WmfMUUtPU82d70C8kWP3+EzrTlUbfxa
 xsq/5vT5W0IZ9lCzmCbPghqFF/+ItdcT+Wf6eNZ0NrBBbJslpyVyovPwxdIaWI+mt7T3R2wTK/W
 4GO0uz6sY34V9nMlquLcj7pXxa9qIu5LExJOUUR6WMggDOok5+ug9VvVmLmPB4u8aA45Qjl678q
 SuXIoQZB0hig8i5n6DBd2Ar+wcnGjTUoQ05chaKXOcUFRtPeB5bEpjRfBD6zx/pY3yMvYgY4mT7
 hIqyDvtQ+gl+JYugc4F4CE5/L1oDletMXqPnd+vUNDxNMf4HdFTsh13p0oBud1eVDyWAqApehSJ
 6/CQ9KI7PaG5sbTlSYHUfWgeI=
X-Google-Smtp-Source: AGHT+IGdZGiLRz+7VL3S8w6zNgFO6AtSTUjnRhqiQnRGEMHXp12KZgBw+HxdZBPEvBUV1r9EAXjaFA==
X-Received: by 2002:a17:902:dac8:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-29f301af865mr105164445ad.35.1765817825751; 
 Mon, 15 Dec 2025 08:57:05 -0800 (PST)
Received: from localhost.localdomain ([116.86.160.247])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38c74sm140084775ad.31.2025.12.15.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 08:57:05 -0800 (PST)
From: phind.uet@gmail.com
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] qga/vss-win32: Fix ConvertStringToBSTR redefinition with
 newer MinGW
Date: Tue, 16 Dec 2025 00:45:11 +0800
Message-ID: <20251215164512.322786-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215164512.322786-1-phind.uet@gmail.com>
References: <20251215164512.322786-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x636.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
_com_util namespace via <comutil.h>. This causes a redefinition
error when building qemu-ga on Windows with these toolchains.

Add a meson check to detect whether ConvertStringToBSTR is already
available, and conditionally compile our fallback implementation
only when the system does not provide one.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 meson.build               | 12 ++++++++++++
 qga/vss-win32/install.cpp |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/meson.build b/meson.build
index c5710a6a47..60a980e610 100644
--- a/meson.build
+++ b/meson.build
@@ -3299,6 +3299,18 @@ endif
 # Detect host pointer size for the target configuration loop.
 host_long_bits = cc.sizeof('void *') * 8
 
+# Detect if ConvertStringToBSTR has been defined in _com_util namespace
+if host_os == 'windows'
+  has_convert_string_to_bstr = cxx.compiles('''
+    #include <comutil.h>
+    int main() {
+        BSTR b = _com_util::ConvertStringToBSTR("test");
+        return b ? 0 : 1;
+    }
+  ''')
+  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR', has_convert_string_to_bstr)
+endif
+
 ########################
 # Target configuration #
 ########################
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 7b25d9098b..5b7a8e9bc5 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
 
 
 /* Support function to convert ASCII string into BSTR (used in _bstr_t) */
+#ifndef CONFIG_CONVERT_STRING_TO_BSTR
 namespace _com_util
 {
     BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
@@ -566,6 +567,7 @@ namespace _com_util
         return bstr;
     }
 }
+#endif
 
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
-- 
2.43.0


