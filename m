Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40E8C5478C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdt9Q-0007G8-9a; Sat, 24 Feb 2024 09:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9O-0007Ey-32
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:14 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9L-0000RU-3g
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:13 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso1197529a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708785309; x=1709390109;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEAUQXaewLQabLkDxXiHtiKTTgmZlvEOTUytk5PKit0=;
 b=K5IHtTthUgzKER8dFivGnbAIn3f1Aoz3iOxU2qbxk931PpnJvY6NFDeu0utZ+SsSqo
 TZAcSL83Ni9QsECqiMOUX1KXUql6hxWUMqv1rhTgMELS2cjg5W++pG7s8HO1X5rPGtwV
 5PaVhhFPc0VIm5TgtwfL6QylYLRAfe7IpvZNIjJAsYQ9iMR/eXJRLa71FALCAJupdR08
 yzP+gBTNoYQbniDjmmOrkvr8lQlaBx52Tgp1+EjZ0jQkDM/GR4SnANXiYZCk3QUlzLJ8
 6KCeLD+JOBt/0/uZW+Gze3UIBmJsYmQypNFURODJP5mw/vYKlMq/xcBWYhXwKJdU9dnc
 9dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708785309; x=1709390109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEAUQXaewLQabLkDxXiHtiKTTgmZlvEOTUytk5PKit0=;
 b=lLejDpZsoctp6g6y46cAA4fFUeawmF+ptrYDllvietSb52TZUXPUlJ2RFbOnNQSSge
 8uxeC1HCtO8KGE+01EEDnZrdJUG8LRE/7vmf5LYl7frWWFYmWXC1fZgPHd97gDV9Whr+
 3avGEVHgxqZoP/LoFky6L9RtoLoXwSSQ1UWTIGUfj91Vl2thsikxery63Ix2Udfl5W7L
 8lqcdL6GVoUJFdpHoMlAefQiygJpvSPXGktCRicHdn117o+0gbKyYPjmYmTwJHMPrzTH
 1YBd5kByB8RVGooAmBiyJzI1/GLmGzF1FgZVsk60+vY33YqPuCOVEGPYfTKYsp+v8qSm
 +GHw==
X-Gm-Message-State: AOJu0YxCx/vXzG1Xx1cMS5f1PxRd8PQBC5v72SFUo4dVH3KPtISyPoT2
 2QQwIRqjqIJhpVCLqhDA4jhMK48twc4DvWuF1bWFfUSKYktr6sF4jWl2i5NBBFaaOrzCQvZO4vr
 cr9wzMw==
X-Google-Smtp-Source: AGHT+IHM6DXVuDYtlRfaqVrzGZKkRUAM3ZwfJWDPaf3hVTuCzx8+m6RbyOzYc01uHkrZLT4YWjPLzQ==
X-Received: by 2002:a05:6a20:c78d:b0:1a0:a43b:cbe4 with SMTP id
 hk13-20020a056a20c78d00b001a0a43bcbe4mr4064250pzb.22.1708785308065; 
 Sat, 24 Feb 2024 06:35:08 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a632356000000b005dc49afed53sm1181887pgm.55.2024.02.24.06.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 06:35:07 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 yong.huang@smartx.com
Subject: [PATCH RFC 1/3] crypto: Introduce GM/T 0018-2012 cryptographic driver
Date: Sat, 24 Feb 2024 22:34:56 +0800
Message-Id: <cf63cff38e5346a3b36e7dd8874a1775ed965683.1708527979.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708527979.git.yong.huang@smartx.com>
References: <cover.1708527979.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

GM/T 0018-2012 is a cryptographic standard issued by the State
Cryptography Administration of China. For more information about
the standard, visit https://hbba.sacinfo.org.cn.

The objective of the standard is to develop a uniform application
interface standard for the service-based cryptography device under
the public key cryptographic infrastructure application framework,
and to call the cryptography device through this interface to
provide basic cryptographic services for the uppler layer. For
more information about contents of the standard, download the
specificaiton from:
"https://github.com/guanzhi/GM-Standards/blob/master/GMT密码行标/
GMT%200018-2012%20密码设备应用接口规范.pdf"

This patch implement the basic functions of GM/T 0018-2012
standard. Currently, for block encryption, it support SM4 cipher
algorithm only.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 MAINTAINERS         |   3 +-
 crypto/cipher-gmt.c | 263 ++++++++++++++++++++++++++++++++++++++++++++
 crypto/cipher.c     |   2 +
 crypto/cipherpriv.h |   6 +
 4 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 crypto/cipher-gmt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..822726e9da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3418,10 +3418,11 @@ F: migration/dirtyrate.c
 F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
 
-Detached LUKS header
+Detached LUKS header and GM/T 0018-2012 cryptography
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
 F: tests/qemu-iotests/tests/luks-detached-header
+F: crypto/cipher-gmt.c
 
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
diff --git a/crypto/cipher-gmt.c b/crypto/cipher-gmt.c
new file mode 100644
index 0000000000..40e32c114f
--- /dev/null
+++ b/crypto/cipher-gmt.c
@@ -0,0 +1,263 @@
+/*
+ * QEMU GM/T 0018-2012 cryptographic standard support
+ *
+ * Copyright (c) 2024 SmartX Inc
+ *
+ * Authors:
+ *    Hyman Huang <yong.huang@smartx.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include <gmt-0018-2012.h>
+
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "qapi/error.h"
+#include "crypto/cipher.h"
+#include "cipherpriv.h"
+
+#include "qemu/error-report.h"
+
+typedef struct QCryptoGMT QCryptoGMT;
+
+struct QCryptoGMT {
+    QCryptoCipher base;
+
+    SGD_HANDLE session;
+    SGD_HANDLE key;
+    SGD_UINT32 alg;
+    unsigned char iv[16];  /* not used for SM4 algo currently */
+};
+
+typedef struct QCryptoGMTDeviceInfo QCryptoGMTDeviceInfo;
+
+struct QCryptoGMTDeviceInfo {
+    SGD_HANDLE device;
+    struct DeviceInfo_st info;
+    bool opened;
+    gint ref_count;
+};
+/*
+ * It is advised to use numerous sessions with one open device
+ * as opposed to single sessions with several devices.
+ */
+static QCryptoGMTDeviceInfo gmt_device;
+/* Protect the gmt_device */
+static QemuMutex gmt_device_mutex;
+
+static const struct QCryptoCipherDriver qcrypto_cipher_gmt_driver;
+
+static void gmt_device_lock(void)
+{
+    qemu_mutex_lock(&gmt_device_mutex);
+}
+
+static void gmt_device_unlock(void)
+{
+    qemu_mutex_unlock(&gmt_device_mutex);
+}
+
+static void
+__attribute__((__constructor__)) gmt_device_mutex_init(void)
+{
+    qemu_mutex_init(&gmt_device_mutex);
+}
+
+static void
+gmt_device_ref(void)
+{
+    g_assert(gmt_device.device != NULL);
+    g_atomic_int_inc(&gmt_device.ref_count);
+}
+
+static void
+gmt_device_unref(void)
+{
+    g_assert(gmt_device.device != NULL);
+    if (g_atomic_int_dec_and_test(&gmt_device.ref_count)) {
+        SDF_CloseDevice(gmt_device.device);
+        gmt_device.opened = false;
+        gmt_device.device = NULL;
+        memset(&gmt_device.info, 0, sizeof(struct DeviceInfo_st));
+    }
+}
+
+static bool
+qcrypto_gmt_cipher_supports(QCryptoCipherAlgorithm alg,
+                            QCryptoCipherMode mode)
+{
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALG_SM4:
+        break;
+    default:
+        return false;
+    }
+
+    switch (mode) {
+    case QCRYPTO_CIPHER_MODE_ECB:
+        return true;
+    default:
+        return false;
+    }
+}
+
+QCryptoCipher *
+qcrypto_gmt_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                           QCryptoCipherMode mode,
+                           const uint8_t *key,
+                           size_t nkey,
+                           Error **errp)
+{
+    QCryptoGMT *gmt;
+    int rv;
+
+    if (!qcrypto_gmt_cipher_supports(alg, mode)) {
+        return NULL;
+    }
+
+    gmt = g_new0(QCryptoGMT, 1);
+    if (!gmt) {
+        return NULL;
+    }
+
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALG_SM4:
+        gmt->alg = SGD_SM4_ECB;
+        break;
+    default:
+        return NULL;
+    }
+
+    gmt_device_lock();
+    if (!gmt_device.opened) {
+        rv = SDF_OpenDevice(&gmt_device.device);
+        if (rv != SDR_OK) {
+            info_report("Could not open encryption card device, disabling");
+            goto abort;
+        }
+        gmt_device.opened = true;
+    }
+
+    /*
+     * multi-sessions correspond to an opened device handle
+     */
+    rv = SDF_OpenSession(gmt_device.device, &gmt->session);
+    if (rv != SDR_OK) {
+        error_setg(errp, "Open session failed");
+        goto abort;
+    }
+
+    gmt_device_ref();
+
+    if (!(gmt_device.info.SymAlgAbility)) {
+        rv = SDF_GetDeviceInfo(gmt->session, &gmt_device.info);
+        if (rv != SDR_OK) {
+            error_setg(errp, "Get device info failed");
+            goto abort;
+        }
+    }
+    gmt_device_unlock();
+
+    if (!(gmt_device.info.SymAlgAbility & SGD_SM4_ECB & SGD_SYMM_ALG_MASK)) {
+        /* encryption card do not support SM4 cipher algorithm */
+        info_report("SM4 cipher algorithm is not supported, disabling");
+        return NULL;
+    }
+
+    rv = SDF_ImportKey(gmt->session, (SGD_UCHAR *)key,
+                       (SGD_UINT32)nkey, &gmt->key);
+    if (rv != SDR_OK) {
+        error_setg(errp, "Import key failed");
+        return NULL;
+    }
+
+    gmt->base.alg = alg;
+    gmt->base.mode = mode;
+    gmt->base.driver = &qcrypto_cipher_gmt_driver;
+    return &gmt->base;
+
+abort:
+    gmt_device_unlock();
+    return NULL;
+}
+
+static int
+qcrypto_gmt_cipher_setiv(QCryptoCipher *cipher,
+                         const uint8_t *iv,
+                         size_t niv, Error **errp)
+{
+    error_setg(errp, "Setting IV is not supported");
+    return -1;
+}
+
+static int
+qcrypto_gmt_cipher_op(QCryptoGMT *gmt,
+                      const void *in, void *out,
+                      size_t len, bool do_encrypt,
+                      Error **errp)
+{
+    unsigned int rlen;
+    int rv;
+
+    if (do_encrypt) {
+        rv = SDF_Encrypt(gmt->session, gmt->key, gmt->alg, gmt->iv,
+                         (SGD_UCHAR *)in, len, out, &rlen);
+    } else {
+        rv = SDF_Decrypt(gmt->session, gmt->key, gmt->alg, gmt->iv,
+                         (SGD_UCHAR *)in, len, out, &rlen);
+    }
+
+    if (rv != SDR_OK) {
+        error_setg(errp, "Crypto operation failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+static void
+qcrypto_gmt_free(QCryptoGMT *gmt)
+{
+    g_assert(gmt != NULL);
+
+    SDF_DestroyKey(gmt->session, gmt->key);
+    SDF_CloseSession(gmt->session);
+
+    gmt_device_lock();
+    gmt_device_unref();
+    gmt_device_unlock();
+}
+
+static int
+qcrypto_gmt_cipher_encrypt(QCryptoCipher *cipher,
+                           const void *in, void *out,
+                           size_t len, Error **errp)
+{
+    QCryptoGMT *gmt = container_of(cipher, QCryptoGMT, base);
+    return qcrypto_gmt_cipher_op(gmt, in, out, len, true, errp);
+}
+
+static int
+qcrypto_gmt_cipher_decrypt(QCryptoCipher *cipher,
+                           const void *in, void *out,
+                           size_t len, Error **errp)
+{
+    QCryptoGMT *gmt = container_of(cipher, QCryptoGMT, base);
+    return qcrypto_gmt_cipher_op(gmt, in, out, len, false, errp);
+}
+
+static void qcrypto_gmt_comm_ctx_free(QCryptoCipher *cipher)
+{
+    QCryptoGMT *gmt = container_of(cipher, QCryptoGMT, base);
+    qcrypto_gmt_free(gmt);
+    g_free(gmt);
+}
+
+static const struct QCryptoCipherDriver qcrypto_cipher_gmt_driver = {
+    .cipher_encrypt = qcrypto_gmt_cipher_encrypt,
+    .cipher_decrypt = qcrypto_gmt_cipher_decrypt,
+    .cipher_setiv = qcrypto_gmt_cipher_setiv,
+    .cipher_free = qcrypto_gmt_comm_ctx_free,
+};
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 5f512768ea..785f231948 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -157,6 +157,8 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
 
 #ifdef CONFIG_AF_ALG
     cipher = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
+#elif defined CONFIG_GMT_0018_2012
+    cipher = qcrypto_gmt_cipher_ctx_new(alg, mode, key, nkey, NULL);
 #endif
 
     if (!cipher) {
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 396527857d..b8e542134c 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -46,7 +46,13 @@ qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode,
                              const uint8_t *key,
                              size_t nkey, Error **errp);
+#elif defined CONFIG_GMT_0018_2012
 
+extern QCryptoCipher *
+qcrypto_gmt_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                           QCryptoCipherMode mode,
+                           const uint8_t *key,
+                           size_t nkey, Error **errp);
 #endif
 
 #endif
-- 
2.39.3


