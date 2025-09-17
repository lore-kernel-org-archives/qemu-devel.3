Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D2DCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrD1-0003dv-9p; Wed, 17 Sep 2025 08:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrCz-0003d3-8O
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrCu-0000YY-7V
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758111857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haxZoqz/zkzVD7l+IyhbLI7e9qR5iMmXcYkvaKooFmU=;
 b=D7ZRNp2HUJRQ+dJXkBj3h7Pbl2gd9VSPHKK8K9yfeEYYZDFK2LiWJ9ugWh2X9WLxoNCFHv
 g8qdVLidPdOF/Yjiv52NY7JybIjsqTO99ePuzSVcOfBQTAqXjPFEfgDkquHmCJ7ixRyEPY
 b7IDxSX0lMyQAJzNSZj6YjSZmrn08MY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-CWRyjdEeOzyxhwlkiuJmkQ-1; Wed, 17 Sep 2025 08:24:16 -0400
X-MC-Unique: CWRyjdEeOzyxhwlkiuJmkQ-1
X-Mimecast-MFC-AGG-ID: CWRyjdEeOzyxhwlkiuJmkQ_1758111855
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-25d7c72e163so106240045ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758111855; x=1758716655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=haxZoqz/zkzVD7l+IyhbLI7e9qR5iMmXcYkvaKooFmU=;
 b=ldY5MS5VXTPFb7QXhNk05HQzm1U9a+NgmhxWGqoB5edDK3YhrGvCAVkDtVMZFCGeY6
 zWKVo+IgvdnKCq/BQLkSvZkqTXT6LHl0sxZNy/IuLlHomQYHCVFdTdLhbUPZBAivJ6We
 ClCDpcSp4PsiBxwqYpAb+3F08XqLtj3DZMXfKdPmvETik3yV++n1j0GcT34OEZz8qluc
 gYQ9oJBzLlSPV1iZg+4KyUMdbQPcY/JF02J2zSO75uqhAg8W6lfoouM3B6PsNWxEwI8+
 Yi0neRWUo2hyb+txH66Iaf29ycUa0/+4sb/zFXUv+yCI4Blj2L1mM6sdKo/GSz1a1mLb
 9R2Q==
X-Gm-Message-State: AOJu0YwPWsR88++sIWdzuxgYpq9m/OTl+YivoCJ8M7OY5IPDvEijGD28
 uWQgVCHzeGIdm+XuSJk0Dy2Vz18z7xOmKCiTT0T6Khhb6MDEbc51GP3Qto+E/Ck1/cPkxFKeX3J
 cS5PkCEP/Iu59akYdgYFI6FoFe9pnk6OvaVO7yFyp2OoJfu8XY1XVHLxI33KQtCrNetAFd18Z5h
 wGxsIaAr2Rd5+xqmK6Ie8/JcJFAsXwEUE=
X-Gm-Gg: ASbGncuJSBHAPiaTBrs2kMLrNCXQ5dKZpezktkwSDfXCy1Q1bL9+WRk551bv1i8kfm0
 wo6oJic6asr4XBTwKUSUt4sylXnshbnmMIA9qRGaYiBjhozN/RQYbI1zQUhEwJZi0gOmfYAfuS4
 N38i3YYuhDRDiQWghnWbi/
X-Received: by 2002:a17:903:11cc:b0:246:2b29:71c7 with SMTP id
 d9443c01a7336-26812476bb9mr21856395ad.25.1758111855355; 
 Wed, 17 Sep 2025 05:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyyEYdxVM5xLFlF+w1B0N+adq3AHNgLz0+BCgBCkXbuvIzfMYnhAOKMOOjJV7DuPMdXE/NPPppJ0/20L89XC0=
X-Received: by 2002:a17:903:11cc:b0:246:2b29:71c7 with SMTP id
 d9443c01a7336-26812476bb9mr21856135ad.25.1758111854922; Wed, 17 Sep 2025
 05:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757676218.git.pabeni@redhat.com>
 <8a041a8fac5b5ea175d3daebfd395c1916332695.1757676218.git.pabeni@redhat.com>
 <z6ntpzp6ykey5hh65ia3kaka5j7anhxolcizgtq7lqbrokeb2h@r66hv2dtxjsv>
In-Reply-To: <z6ntpzp6ykey5hh65ia3kaka5j7anhxolcizgtq7lqbrokeb2h@r66hv2dtxjsv>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 17 Sep 2025 14:24:03 +0200
X-Gm-Features: AS18NWBw7770yYmaU1BRyk9GPi2rm7kpeS_FCBgH0XGoz7Jl3TZ1w5rLuPdm2SQ
Message-ID: <CAGxU2F6aLxtLvk9G1knJxiK+OXd8zfjoMAcZYxPduk-GSzT=Zw@mail.gmail.com>
Subject: Re: [PATCH v6 04/14] virtio: introduce extended features type
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 17 Sept 2025 at 14:12, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Sep 12, 2025 at 03:06:55PM +0200, Paolo Abeni wrote:
> >The virtio specifications allows for up to 128 bits for the
> >device features. Soon we are going to use some of the 'extended'
> >bits features (bit 64 and above) for the virtio net driver.
> >
> >Represent the virtio features bitmask with a fixes size array, and

s/fixes/fixed

But again, my A-b remains, we can fix only if there will be a v7.

Stefano

> >introduce a few helpers to help manipulate them.
> >
> >Most drivers will keep using only 64 bits features space: use union
> >to allow them access the lower part of the extended space without any
> >per driver change.
> >
> >Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >Acked-by: Jason Wang <jasowang@redhat.com>
> >Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >---
> >v5 -> v6:
> >  - removed trailing EoL
> >
> >v4 -> v5:
> >  - DEFINE_PROP_FEATURE -> VIRTIO_DEFINE_PROP_FEATURE
> >
> >v3 -> v4:
> >  - VIRTIO_FEATURES_DWORDS -> VIRTIO_FEATURES_NU64S
> >  - VIRTIO_FEATURES_WORDS -> VIRTIO_FEATURES_NU32S
> >  - VIRTIO_DWORD ->  VIRTIO_FEATURES_U64
> >  - VIRTIO_BIT -> VIRTIO_FEATURES_BIT
> >  - virtio_features_use_extended -> virtio_features_use_ex
> >  - move DEFINE_PROP_FEATURE definition here
> >
> >v2 -> v3:
> >  - fix preprocessor guard name
> >  - use BIT_ULL
> >  - add missing parentheses
> >  - use memcmp()
> >  - _is_empty() -> _empty()
> >  - _andnot() returns a bool, true if dst has any non zero bits
> >  - _array -> _ex
> >
> >v1 -> v2:
> >  - use a fixed size array for features instead of uint128
> >  - use union with u64 to reduce the needed code churn
> >---
> > include/hw/virtio/virtio-features.h | 126 ++++++++++++++++++++++++++++
> > include/hw/virtio/virtio.h          |   7 +-
> > 2 files changed, 130 insertions(+), 3 deletions(-)
> > create mode 100644 include/hw/virtio/virtio-features.h
>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
>
> >
> >diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
> >new file mode 100644
> >index 0000000000..e29b7fe48f
> >--- /dev/null
> >+++ b/include/hw/virtio/virtio-features.h
> >@@ -0,0 +1,126 @@
> >+/*
> >+ * Virtio features helpers
> >+ *
> >+ * Copyright 2025 Red Hat, Inc.
> >+ *
> >+ * SPDX-License-Identifier: GPL-2.0-or-later
> >+ */
> >+
> >+#ifndef QEMU_VIRTIO_FEATURES_H
> >+#define QEMU_VIRTIO_FEATURES_H
> >+
> >+#include "qemu/bitops.h"
> >+
> >+#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
> >+#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
> >+
> >+#define VIRTIO_FEATURES_MAX        128
> >+#define VIRTIO_FEATURES_BIT(b)     BIT_ULL((b) % 64)
> >+#define VIRTIO_FEATURES_U64(b)     ((b) / 64)
> >+#define VIRTIO_FEATURES_NU32S      (VIRTIO_FEATURES_MAX / 32)
> >+#define VIRTIO_FEATURES_NU64S      (VIRTIO_FEATURES_MAX / 64)
> >+
> >+#define VIRTIO_DECLARE_FEATURES(name)                        \
> >+    union {                                                  \
> >+        uint64_t name;                                       \
> >+        uint64_t name##_ex[VIRTIO_FEATURES_NU64S];           \
> >+    }
> >+
> >+#define VIRTIO_DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
> >+    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_FEATURES_U64(_bit)],    \
> >+                      (_bit) % 64, _defval)
> >+
> >+static inline void virtio_features_clear(uint64_t *features)
> >+{
> >+    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_NU64S);
> >+}
> >+
> >+static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
> >+{
> >+    virtio_features_clear(features);
> >+    features[0] = from;
> >+}
> >+
> >+static inline bool virtio_has_feature_ex(const uint64_t *features,
> >+                                         unsigned int fbit)
> >+{
> >+    assert(fbit < VIRTIO_FEATURES_MAX);
> >+    return features[VIRTIO_FEATURES_U64(fbit)] & VIRTIO_FEATURES_BIT(fbit);
> >+}
> >+
> >+static inline void virtio_add_feature_ex(uint64_t *features,
> >+                                         unsigned int fbit)
> >+{
> >+    assert(fbit < VIRTIO_FEATURES_MAX);
> >+    features[VIRTIO_FEATURES_U64(fbit)] |= VIRTIO_FEATURES_BIT(fbit);
> >+}
> >+
> >+static inline void virtio_clear_feature_ex(uint64_t *features,
> >+                                           unsigned int fbit)
> >+{
> >+    assert(fbit < VIRTIO_FEATURES_MAX);
> >+    features[VIRTIO_FEATURES_U64(fbit)] &= ~VIRTIO_FEATURES_BIT(fbit);
> >+}
> >+
> >+static inline bool virtio_features_equal(const uint64_t *f1,
> >+                                         const uint64_t *f2)
> >+{
> >+    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_NU64S);
> >+}
> >+
> >+static inline bool virtio_features_use_ex(const uint64_t *features)
> >+{
> >+    int i;
> >+
> >+    for (i = 1; i < VIRTIO_FEATURES_NU64S; ++i) {
> >+        if (features[i]) {
> >+            return true;
> >+        }
> >+    }
> >+    return false;
> >+}
> >+
> >+static inline bool virtio_features_empty(const uint64_t *features)
> >+{
> >+    return !virtio_features_use_ex(features) && !features[0];
> >+}
> >+
> >+static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
> >+{
> >+    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_NU64S);
> >+}
> >+
> >+static inline bool virtio_features_andnot(uint64_t *to, const uint64_t *f1,
> >+                                           const uint64_t *f2)
> >+{
> >+    uint64_t diff = 0;
> >+    int i;
> >+
> >+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
> >+        to[i] = f1[i] & ~f2[i];
> >+        diff |= to[i];
> >+    }
> >+    return diff;
> >+}
> >+
> >+static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
> >+                                       const uint64_t *f2)
> >+{
> >+    int i;
> >+
> >+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
> >+        to[i] = f1[i] & f2[i];
> >+    }
> >+}
> >+
> >+static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
> >+                                       const uint64_t *f2)
> >+{
> >+    int i;
> >+
> >+    for (i = 0; i < VIRTIO_FEATURES_NU64S; i++) {
> >+        to[i] = f1[i] | f2[i];
> >+    }
> >+}
> >+
> >+#endif
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index c594764f23..39e4059a66 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -16,6 +16,7 @@
> >
> > #include "system/memory.h"
> > #include "hw/qdev-core.h"
> >+#include "hw/virtio/virtio-features.h"
> > #include "net/net.h"
> > #include "migration/vmstate.h"
> > #include "qemu/event_notifier.h"
> >@@ -121,9 +122,9 @@ struct VirtIODevice
> >      * backend (e.g. vhost) and could potentially be a subset of the
> >      * total feature set offered by QEMU.
> >      */
> >-    uint64_t host_features;
> >-    uint64_t guest_features;
> >-    uint64_t backend_features;
> >+    VIRTIO_DECLARE_FEATURES(host_features);
> >+    VIRTIO_DECLARE_FEATURES(guest_features);
> >+    VIRTIO_DECLARE_FEATURES(backend_features);
> >
> >     size_t config_len;
> >     void *config;
> >--
> >2.51.0
> >


