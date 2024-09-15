Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C40C35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0c-0003V6-FM; Sat, 14 Sep 2024 21:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0b-0003Uc-Fq
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0Z-0005S2-Lv
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71957eb256bso2669b3a.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363498; x=1726968298;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dK8XIOkSnoAkPsKpGzE+al7dIfHDqxqDGT85NXXN1Ng=;
 b=g2kK5LesrCyuUXTzDpK7qfwWUcVhvwGcrrqoMpdbVJjjVcP8/snwWTys1OaOc9gf6q
 8Uvo9TtOOzxbT/1A5Ie4nahjJ1Z2mf6G6OABh5QhbSSVdYEGmQbZ6MMyqcmkFuaMMoA/
 Tx4wFo884lqwrskc7asWkTf3f0ck78M7oVRwTOl0d2QPrFgMqeKPnfvwkTLMYMWBDqQs
 d5uMBpq8bZskkzJCiodPtBRsDdKU2/FZp3ywllIv8w2kuZG+SvhDkOph3QjpZppn3oDK
 UxvXoS+5zUCX9cNZP7de9PeUqe98x8dANsmWKzHMGRDElhnqxUuX1JIdtnf8szV6OKNr
 TICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363498; x=1726968298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dK8XIOkSnoAkPsKpGzE+al7dIfHDqxqDGT85NXXN1Ng=;
 b=WGU7FZ2ujzG78gyY813tVk0py/AnoyqU3SGAEaiBcj89ILXThwH9My2t/pZlFfKIOs
 yf+oOWsLPhrkbiSo17eaJRyXpcdfhtvXTOMc2Mdni503bs1fmMu7nze9hIxnNTdjIa7e
 a3xWy4CsjFXAXFujoCYm5qHutNfUDY/nxkjLmFOYZpZVUNfe0zt4+DC6AC0o+wuMrA4B
 LCYlgqer8EwHaC1csC4ZtS+7sszT2WcH/LDABDj0gZpifdx/teIPPaUiDwQc1lo6uzMq
 SnQKV5CxT9eQB+kQCpXZXVrr0ZlKJfgFg1Ow4wA4/m0DlLMGO+m2stmJFGfSj2qG6I4n
 HQsQ==
X-Gm-Message-State: AOJu0YwacdH07V+LIs4cwAicGhVOKe/EhyLk4nWtzM3YBURmlucyo6SC
 T2W79SPgoPlqFa8L6U4RcR+IRh/UUHPOyOD+8/Ubtg7WrgurJ2/SUQO3KPQZBvA6EooBI+h4wv1
 bMyc=
X-Google-Smtp-Source: AGHT+IECBexP99y+sVtYiXXYcQ2os/C/GHU3kNDRZP1sXn7oj7EzclWdZ+aqVe8FHJnU8m5tpPWmkA==
X-Received: by 2002:a05:6a21:6e41:b0:1cf:6c64:ee6c with SMTP id
 adf61e73a8af0-1d112e8c232mr10836797637.33.1726363498139; 
 Sat, 14 Sep 2024 18:24:58 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7db499942besm1742098a12.63.2024.09.14.18.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:47 +0900
Subject: [PATCH RFC v3 06/11] virtio-net: Add hash type options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-6-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

By default, virtio-net limits the hash types that will be advertised to
the guest so that all hash types are covered by the offloading
capability the client provides. This change allows to override this
behavior and to advertise hash types that require user-space hash
calculation by specifying "on" for the corresponding properties.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |  1 +
 hw/net/virtio-net.c            | 45 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 202016ec74fc..cc6da6ad6a1b 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -148,6 +148,7 @@ typedef struct VirtioNetRssData {
     uint32_t runtime_hash_types;
     uint32_t supported_hash_types;
     uint32_t peer_hash_types;
+    OnOffAutoBit specified_hash_types;
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
     uint16_t *indirections_table;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3da15a60eaa5..38ccd706f956 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3808,9 +3808,14 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     if (qemu_get_vnet_hash_supported_types(qemu_get_queue(n->nic)->peer,
                                            &n->rss_data.peer_hash_types)) {
         n->rss_data.peer_hash_available = true;
-        n->rss_data.supported_hash_types = n->rss_data.peer_hash_types;
+        n->rss_data.supported_hash_types =
+            n->rss_data.specified_hash_types.on_bits |
+            (n->rss_data.specified_hash_types.auto_bits &
+             n->rss_data.peer_hash_types);
     } else {
-        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+        n->rss_data.supported_hash_types =
+            n->rss_data.specified_hash_types.on_bits |
+            n->rss_data.specified_hash_types.auto_bits;
     }
 }
 
@@ -4035,6 +4040,42 @@ static Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-ipv4", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_IPv4 - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-tcp4", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_TCPv4 - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-udp4", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_UDPv4 - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-ipv6", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_IPv6 - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-tcp6", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_TCPv6 - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-udp6", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_UDPv6 - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-ipv6ex", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_IPv6_EX - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-tcp6ex", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_TCPv6_EX - 1,
+                                ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO_BIT("hash-udp6ex", VirtIONet,
+                                rss_data.specified_hash_types,
+                                VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
+                                ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
 };
 

-- 
2.46.0


