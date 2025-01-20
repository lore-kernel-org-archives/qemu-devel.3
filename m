Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C322C02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 04:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZjZD-00049W-B7; Sun, 19 Jan 2025 23:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZB-00049I-JZ
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZA-0008WI-2K
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737347950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2dgrQDHc5fzCfLKC4fH5d2T13feJHoGpN7u1WbNm/k=;
 b=SVW0ifTiI7vxsQK6S+XYWqmMI9DijO4COlHSp59H+/x/t5N1hptyBOWdpiHIn0krAHxvJr
 8e4dktZM6nEVSSfnNePjXoypnqc6pVpjpH9/2jjuFtdBgZ5ltjtyv6EgenRtYaqYywZX7I
 PugvF1TVVf3gphki7OirpN0g8/bAsSs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-gvRfEmqxPXmKvsTj0pTB0Q-1; Sun, 19 Jan 2025 23:39:08 -0500
X-MC-Unique: gvRfEmqxPXmKvsTj0pTB0Q-1
X-Mimecast-MFC-AGG-ID: gvRfEmqxPXmKvsTj0pTB0Q
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2164fad3792so69720745ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 20:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737347946; x=1737952746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2dgrQDHc5fzCfLKC4fH5d2T13feJHoGpN7u1WbNm/k=;
 b=ebxC4IICtX5W4JafQW7uer9TAdqxatU3qSF+iyB5CSCf1enMbmDyZ7jQFCgKytrqD6
 yBZ7PmWx7UH3m0GF3mUTV8N0o9iuYE35wl40i58mC88g1nFX+jKZoH5gvgNOI8OOqRQw
 Geiz53c/6Ow4eq/bXKAx25Bb+DpqCUJllyt73r5G2XSxBiBiAXZw2ZBv/SzBVxe6m3+2
 dHyYDLexSEPs0maClASL84DJ25Zlvj0VpTxVvbkhXcte7sQcalT64HkCQzOJZNKlRUc4
 ucDHn8LlGR8yGokDu4lKkodVz37UcItJ4vpUZ6isT15SwIufnjU6z6Bd5Rqlru5YxAp5
 lVeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh+mw6V/UfD6N43qC4iMNchn9bGvjmhDQyf/rpU1/PPYyMjdNgOy+cNJEvMTU3ScqHX5jFgBPWrIMY@nongnu.org
X-Gm-Message-State: AOJu0Yyy0xlWESh6o5Wewg9wonLe6lRJ5ADDpkdE0hiC+brKHFNTzSsE
 xrwbSgbaHJhfnyVPGpFnQ4V5mKfx7bMv2u3mwvCRsC7QW2UsoHvSvopBmrW8FK2YTGo+i4hXjVO
 jAz+41dH63Aay497rDrO799IyRx5RUVKBBzYS7KlC2n03oZOUYI20YFtXGQS2
X-Gm-Gg: ASbGnctCQWFSRx/aCvlnAr0HuHNaiERNjBCG1XXJnSurEa+rAMUALomyLdEYegvgzUH
 r+oh4Liz8YOKOjeDKovv1MCosA6JfA5TUZRAsKCjso5/D7Q4syZuVWYp3JWMYLCtfJoQ5zYSpee
 JVZUaI5p6o7n87KX4u6nC7Y+bqCUMgyV/BZKCr3dECjbSRlB96+d+tq3RSXJ1ZNF3X5VziWP7kC
 b90cMaJn+JqJKmdq/Ww5F56LnEwAF9p3mTX1jS0g8GO64wkIcjICqJUWhlzeoU0uKZFl72cL3VD
 eRtMqbuPXgP76uPE
X-Received: by 2002:a17:902:d48a:b0:212:67a5:ab2d with SMTP id
 d9443c01a7336-21c35604a08mr216829865ad.44.1737347946403; 
 Sun, 19 Jan 2025 20:39:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF8hKqkaK4fzLdyAqIIhK/M0nMI8lZRN0nyjDSxsa3utTy2xxSwtYL2OfVj3do9u6fPivrtg==
X-Received: by 2002:a17:902:d48a:b0:212:67a5:ab2d with SMTP id
 d9443c01a7336-21c35604a08mr216829575ad.44.1737347946071; 
 Sun, 19 Jan 2025 20:39:06 -0800 (PST)
Received: from localhost.localdomain ([115.96.115.34])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-a9bcc3232a4sm5889604a12.30.2025.01.19.20.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 20:39:05 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v6 1/3] libqos/fw_cfg: refactor file directory iteraton to
 make it more reusable
Date: Mon, 20 Jan 2025 10:08:32 +0530
Message-ID: <20250120043847.954881-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250120043847.954881-1-anisinha@redhat.com>
References: <20250120043847.954881-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by:  Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqos/fw_cfg.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..22435873d9 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -60,6 +60,37 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static bool find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
+                            uint16_t *sel, uint32_t *size)
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
@@ -73,34 +104,20 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
  * populated, it has received only a starting slice of the fw_cfg file.
  */
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
-                      void *data, size_t buflen)
+                        void *data, size_t buflen)
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


