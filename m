Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71422CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDi-0007SU-Sy; Sun, 05 Oct 2025 15:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDU-0007Qc-IH
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDS-0006LN-QF
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/FVkGhjGelmiF0arfWEd4Yssbg2l6aFP6I25x3tKr8=;
 b=iC1i2DoyvxWyUNrT7Nj4AIN2EVguiPkOVKb/WqPalwBLAV06212g3P4PXuAbblm4agpYxG
 5MeCQTcN37T7BHE2szwzahZLd4KZ53YycC9XdTeuf3s91mzwK4S5ayyK2XgZevP9zzM9B4
 h+zYhBaURBs+VVBniUjW8rwlOYJRDd0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-XX0OwY0vPWekIltDAjH3Jw-1; Sun, 05 Oct 2025 15:16:14 -0400
X-MC-Unique: XX0OwY0vPWekIltDAjH3Jw-1
X-Mimecast-MFC-AGG-ID: XX0OwY0vPWekIltDAjH3Jw_1759691774
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso2576856f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691773; x=1760296573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/FVkGhjGelmiF0arfWEd4Yssbg2l6aFP6I25x3tKr8=;
 b=wB0SM1evlNoepAaqQRU/RaixBjYSTvcgMZDQSIJS5s+5fBHx1nk0LkgBYhF1xPG61T
 lL5OsIRhZalIm61hKS/nQ2lClgonZsmxcMs8HdCG1VSGfjS+zFEYo+26JF/gLt2DVAF1
 zGKEAZa3Mp8ro/lx2f6Go/hKh6+//Au2JNRcCGwDd+UKeE55oX9WzuJnnI8naivUOlFO
 OGwSNnoyJVn8dBLJ1itzBSMOyMGs/MNssWmweP3uQFvHLILvZE72lz1JwmIsbajTJQcP
 JuhKjlEVIEyU0oTc/ZE4XaISKESWoSFIvJatkM7LCGKpD6/67iBVOxV6JVotyqOncKiw
 uN5w==
X-Gm-Message-State: AOJu0YyGE8DGbxQC61mn8zN6ws06HrlbSQ9GUOlKP3H7nyA8/jsPEunq
 chd7iQ3x4ICDDvLuoIZLsN8X6GK2AaySE2eo6gMxUuKKoB7pZ6UeXtEV3FJeOkm2SpCZie5C7de
 iND45PYh36PIR2zauyRKm4bCpxwMndbV/tqSnWUmNQC41XfO79NFzNurYtaa9yVOGnDubbR5HaM
 zqYE3fn5+8IRPS3l6h6qxDJPgbaJdg9FfPQQ==
X-Gm-Gg: ASbGncsCo2phb22AGKH1Ft7XPQAc0uipmN1rhswtneCMhIGuYwKabhnUoUO/cWpV1bI
 sH8FVWJERmrYZ+00Gbi9jVU2mW/yq5xX9I+Rrq3tgNHX/BPJLMWqN1MWqpTOa0jvHNdAPgJjdCt
 uFhZMfGusSTD5aIkLEvrxV0jj2VjffzWTIt+iJMwSyf+INDwpo7LSfWimlAhaqLc541hXmqS1YP
 YjshB20F+W7O7ZfdFPXSZ7QS/fHT+vdTm+p/hFd37S8Rjb9xSh50Nv9o9O5n/JKPqqk8X6wJ5fa
 aa5s+4l3DiUO/41ZS2TSbuO13v+LzETco+d48hM=
X-Received: by 2002:a05:6000:220b:b0:3eb:5e99:cbb9 with SMTP id
 ffacd0b85a97d-4256713c1dfmr7107170f8f.10.1759691773192; 
 Sun, 05 Oct 2025 12:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECSt2L02YdM0xY1VPnS59Lxr2AYdSlggt+ipJCF6zhbGVdvCYZdKFb3KVdsL5hhGhnkhzqYQ==
X-Received: by 2002:a05:6000:220b:b0:3eb:5e99:cbb9 with SMTP id
 ffacd0b85a97d-4256713c1dfmr7107144f8f.10.1759691772546; 
 Sun, 05 Oct 2025 12:16:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c3esm17613547f8f.1.2025.10.05.12.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:12 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 04/75] virtio: introduce extended features type
Message-ID: <b15a61fdae976eb1ca8f2deee6a63dc3407d7ec6.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (bit 64 and above) for the virtio net driver.

Represent the virtio features bitmask with a fixed size array, and
introduce a few helpers to help manipulate them.

Most drivers will keep using only 64 bits features space: use union
to allow them access the lower part of the extended space without any
per driver change.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <6a9bbb5eb33830f20afbcb7e64d300af4126dd98.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-features.h | 126 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h          |   7 +-
 2 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
new file mode 100644
index 0000000000..e29b7fe48f
--- /dev/null
+++ b/include/hw/virtio/virtio-features.h
@@ -0,0 +1,126 @@
+/*
+ * Virtio features helpers
+ *
+ * Copyright 2025 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_FEATURES_H
+#define QEMU_VIRTIO_FEATURES_H
+
+#include "qemu/bitops.h"
+
+#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
+#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
+
+#define VIRTIO_FEATURES_MAX        128
+#define VIRTIO_FEATURES_BIT(b)     BIT_ULL((b) % 64)
+#define VIRTIO_FEATURES_U64(b)     ((b) / 64)
+#define VIRTIO_FEATURES_NU32S      (VIRTIO_FEATURES_MAX / 32)
+#define VIRTIO_FEATURES_NU64S      (VIRTIO_FEATURES_MAX / 64)
+
+#define VIRTIO_DECLARE_FEATURES(name)                        \
+    union {                                                  \
+        uint64_t name;                                       \
+        uint64_t name##_ex[VIRTIO_FEATURES_NU64S];           \
+    }
+
+#define VIRTIO_DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
+    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_FEATURES_U64(_bit)],    \
+                      (_bit) % 64, _defval)
+
+static inline void virtio_features_clear(uint64_t *features)
+{
+    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_NU64S);
+}
+
+static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
+{
+    virtio_features_clear(features);
+    features[0] = from;
+}
+
+static inline bool virtio_has_feature_ex(const uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    return features[VIRTIO_FEATURES_U64(fbit)] & VIRTIO_FEATURES_BIT(fbit);
+}
+
+static inline void virtio_add_feature_ex(uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_FEATURES_U64(fbit)] |= VIRTIO_FEATURES_BIT(fbit);
+}
+
+static inline void virtio_clear_feature_ex(uint64_t *features,
+                                           unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_FEATURES_U64(fbit)] &= ~VIRTIO_FEATURES_BIT(fbit);
+}
+
+static inline bool virtio_features_equal(const uint64_t *f1,
+                                         const uint64_t *f2)
+{
+    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_NU64S);
+}
+
+static inline bool virtio_features_use_ex(const uint64_t *features)
+{
+    int i;
+
+    for (i = 1; i < VIRTIO_FEATURES_NU64S; ++i) {
+        if (features[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool virtio_features_empty(const uint64_t *features)
+{
+    return !virtio_features_use_ex(features) && !features[0];
+}
+
+static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
+{
+    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_NU64S);
+}
+
+static inline bool virtio_features_andnot(uint64_t *to, const uint64_t *f1,
+                                           const uint64_t *f2)
+{
+    uint64_t diff = 0;
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
+        to[i] = f1[i] & ~f2[i];
+        diff |= to[i];
+    }
+    return diff;
+}
+
+static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
+        to[i] = f1[i] & f2[i];
+    }
+}
+
+static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
+        to[i] = f1[i] | f2[i];
+    }
+}
+
+#endif
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..39e4059a66 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -16,6 +16,7 @@
 
 #include "system/memory.h"
 #include "hw/qdev-core.h"
+#include "hw/virtio/virtio-features.h"
 #include "net/net.h"
 #include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
@@ -121,9 +122,9 @@ struct VirtIODevice
      * backend (e.g. vhost) and could potentially be a subset of the
      * total feature set offered by QEMU.
      */
-    uint64_t host_features;
-    uint64_t guest_features;
-    uint64_t backend_features;
+    VIRTIO_DECLARE_FEATURES(host_features);
+    VIRTIO_DECLARE_FEATURES(guest_features);
+    VIRTIO_DECLARE_FEATURES(backend_features);
 
     size_t config_len;
     void *config;
-- 
MST


