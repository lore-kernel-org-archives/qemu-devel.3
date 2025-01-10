Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BACBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCXf-00029o-Mr; Fri, 10 Jan 2025 05:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXR-00028W-Tc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXQ-0000wM-9T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyJGJfV9DoJuEeQoh7mfVXEg1t8mQb3WAp/BwFtyxic=;
 b=QD4THjYIUyZBhKvyJqV68Q+troNQB3hv1LWITQdyEqwdw4x1cJ17CqcW0Cr7WNKkKQsAF0
 wiN5mpcRaq53nuxQ5ledaEJmSLQCSBpMkG4C03HhpH6cCKRCn7baWdkyoPBqrTomZJEP6H
 FDPCFWm8FF/pBNU0Wbwb8DIqgVO3fSE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-5k01-Q-7PzCAGL_Zd3v4Dg-1; Fri, 10 Jan 2025 05:46:42 -0500
X-MC-Unique: 5k01-Q-7PzCAGL_Zd3v4Dg-1
X-Mimecast-MFC-AGG-ID: 5k01-Q-7PzCAGL_Zd3v4Dg
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2167141e00eso34076475ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736506002; x=1737110802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyJGJfV9DoJuEeQoh7mfVXEg1t8mQb3WAp/BwFtyxic=;
 b=OC9Ux75653zO6psq68rcZeFHNERkemQjvmG8dlHbF9JAJL9RWp245avc3STr/4R7Rh
 GFIXWhCG/to1ok4GEuX9hPqvJwcC5EMxOOMAJIspcR06XoHQx+yqB25ZXDSm42RlmlbF
 jh91HtIog1nAemDIegWn1i1TgA8bm88Ag+NU0X3pwvTUtJcLLHanFTA5q/22l0dCMEAr
 fg993IOQjamy1bnT5JwyEbLv9afoK5eewS6vFENMrHbVZfruNrStKw4sGFrt3fglaEye
 g/l3VUiiqGkRC6zWyBommf+cPWnLDgCGfrgVaVR9tW/ojMQakZMj8378JSMergLXrHFk
 yAeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD+1AMts9wD7kvqqF2T9Q/qYuzugid+E+fHUo8zoBL0x9dsfof9NdZNpzATU8dwXl/E5N6lpg7FpHp@nongnu.org
X-Gm-Message-State: AOJu0YyBzKM0eRtV2HBcvpUOuyZvU/xRocDf/vzVM8FMpbqNfIH9x+Dn
 lFPWHWf95XUFXa2c840uSd97CzOoz9NuvYhWL8/aIbM/iHZ1ASqU05HJkWMoufM/OviKKYbkndO
 Z0iGq0c02WJ+n0NBFdG/L7UKuSvAn5TGEDULl/Cgrx5U6uZRIKOGy
X-Gm-Gg: ASbGncvQnkf1xpkVWApk4bhLySEDGm03qItztpRz4rProvqXhGqNM/tUUIDEQ5zur/d
 PI5fxyYbxxRYGR4LSPCiw95EiiOOZBewXWHx9xPagEZUCE+V4DGxoe2JA8bW3dMLR+MdscZTKL+
 p3SalMYqpIl/CuY/ebf6v51OsgfpHoW+Qg8kPzkvkaBI9bKn+Akwx1OivdVMHEzgNYOdKzPcUXJ
 Vr9NlGh1YCuZ8sznw9sldzXz3acoD6AlytK8dwQx6UvaYYGs/yfJ5P7yHaF5y1OGMAjzPmQ1y4x
 qMk=
X-Received: by 2002:a17:903:2806:b0:218:a43c:571e with SMTP id
 d9443c01a7336-21a83f69672mr126592675ad.28.1736506001725; 
 Fri, 10 Jan 2025 02:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFneGfhH27MvTMw6o6doQR+60+5nYtZLkyI89b9sqtyqiKbyG3P2Bg2YhbO7jjFSnNqq/hwWg==
X-Received: by 2002:a17:903:2806:b0:218:a43c:571e with SMTP id
 d9443c01a7336-21a83f69672mr126592475ad.28.1736506001401; 
 Fri, 10 Jan 2025 02:46:41 -0800 (PST)
Received: from localhost.localdomain ([115.96.31.209])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm11722255ad.2.2025.01.10.02.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 02:46:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 1/3] libqos/fw_cfg: refactor file directory iteraton to
 make it more reusable
Date: Fri, 10 Jan 2025 16:16:16 +0530
Message-ID: <20250110104619.267564-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110104619.267564-1-anisinha@redhat.com>
References: <20250110104619.267564-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

fw-cfg file directory iteration code can be used by other functions that may
want to implement fw-cfg file operations. Refactor it into a smaller helper
so that it can be reused.

No functional change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/libqos/fw_cfg.c | 62 ++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..b178d0b1b8 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -60,6 +60,38 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static bool
+find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
+                uint16_t *sel, uint32_t *size)
+{
+    g_autofree unsigned char *filesbuf = NULL;
+    uint32_t count;
+    size_t dsize;
+    FWCfgFile *pdir_entry;
+    uint32_t i;
+    bool found = false;
+
+    *size = 0;
+    *sel = 0;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc(dsize);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i = 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            *size = be32_to_cpu(pdir_entry->size);
+            *sel = be16_to_cpu(pdir_entry->select);
+            found = true;
+            break;
+        }
+    }
+
+    return found;
+}
+
 /*
  * The caller need check the return value. When the return value is
  * nonzero, it means that some bytes have been transferred.
@@ -75,32 +107,18 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                       void *data, size_t buflen)
 {
-    uint32_t count;
-    uint32_t i;
-    unsigned char *filesbuf = NULL;
-    size_t dsize;
-    FWCfgFile *pdir_entry;
     size_t filesize = 0;
+    uint32_t len;
+    uint16_t sel;
 
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
-    count = be32_to_cpu(count);
-    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
-    filesbuf = g_malloc(dsize);
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
-    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
-    for (i = 0; i < count; ++i, ++pdir_entry) {
-        if (!strcmp(pdir_entry->name, filename)) {
-            uint32_t len = be32_to_cpu(pdir_entry->size);
-            uint16_t sel = be16_to_cpu(pdir_entry->select);
-            filesize = len;
-            if (len > buflen) {
-                len = buflen;
-            }
-            qfw_cfg_get(fw_cfg, sel, data, len);
-            break;
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        filesize = len;
+        if (len > buflen) {
+            len = buflen;
         }
+        qfw_cfg_get(fw_cfg, sel, data, len);
     }
-    g_free(filesbuf);
+
     return filesize;
 }
 
-- 
2.45.2


