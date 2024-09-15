Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30334C35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0m-0003uD-NX; Sat, 14 Sep 2024 21:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0k-0003qa-6f
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0i-0005db-I7
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso2307062b3a.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363506; x=1726968306;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJ1Nyzv51Uzd6E3UyEnjX/5JQDEbF9GyTUtFU2+xlqI=;
 b=IiITu7hQSrNuyAjCnure1VsPjTGIxJ/4l02tiX2rdSiafuXxlo5QK2fyXHC+2d5Wp8
 bkRj6QYM7sRwf3UfzSgqSTwjP3TWzpdz3dx00T4VTs5BPywQ+H61xBRzkuqiH0riZKjX
 2/48R7QTNJgsUvjpjQFDAZFGUfCyFXEH3oyGjhBGQw8Pt1cyyym2YbzhP8wigmSzN24n
 FS9QjHbhfd8K4+Xc5a3YsdhICLeom66ZAX9Bqbx3pbX60YGpYIR8U0tavNcrA7Da3tr/
 /abduwmEhKrWCyhLyyBOI1NIy+JDkRusWWyjotxeDVx9m05YZLaKcC6kSlJploaWW6ng
 p3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363506; x=1726968306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJ1Nyzv51Uzd6E3UyEnjX/5JQDEbF9GyTUtFU2+xlqI=;
 b=SdtJkdpdnTwvc9Kf3EeMHtWEStubKkX5erP0pWaXnj27hmsEkPAsjoM3E8ETP09wad
 B+j/paoPh9Rp93qyBZYZn/BeYFDqG0gD+ucAu4/jeVUotUfyXr7ntcDK+ZoNdh0A7NFN
 4zC2R8ecGOolfSpmAacAp9uYg3fZ5yeqgTItrxDGUJslE+MXIrxPg0AeMqc3nZ7MW1uj
 8Tzu12rem2b6x5qoK/Q0sT83AKekKy67jGcY+IBXWQrcn9HF9RQY1mPjTbAEeb047zbt
 dPC4w2LfMubEnfibyaSrojnPDc4ZQxcfnfs4qkpzDebhpw9hAuF65WKF40bmgckFNB/W
 snXw==
X-Gm-Message-State: AOJu0YzgElJ9k3RGu+YhOwDyy6FsSk/u0/7Nv9w0oymgKVOYFhoBy+nv
 qLmVMCMJusIIs7mU0kEaWGKxJTTMN34dfeLnjMa1xwUkJ5s28cDU8OIAmB9i86CW1/CEV8zjijt
 zboQ=
X-Google-Smtp-Source: AGHT+IGhCVRmQ51V6FHDhjWg7uh3zggyCbHp1WXOtU6JkCd6149cHt1mevpJYXH6U9EFhkDy1w3tHw==
X-Received: by 2002:a05:6a00:2392:b0:705:a13b:e740 with SMTP id
 d2e1a72fcca58-719261eca97mr16746022b3a.19.1726363505995; 
 Sat, 14 Sep 2024 18:25:05 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71944a977c6sm1518857b3a.8.2024.09.14.18.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:25:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:49 +0900
Subject: [PATCH RFC v3 08/11] virtio-net: Use qemu_set_vnet_hash()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-8-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

This is necessary to offload hashing to tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 77 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38ccd706f956..be6759d1c0f4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1209,20 +1209,65 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
-    if (n->rss_data.peer_hash_available) {
-        return;
-    }
-
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
-        if (n->rss_data.populate_hash) {
-            virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
+        if (n->rss_data.peer_hash_available &&
+            (n->rss_data.peer_hash_types & n->rss_data.runtime_hash_types) ==
+            n->rss_data.runtime_hash_types) {
+            NetVnetHash hash = {
+                .flags = (n->rss_data.redirect ? NET_VNET_HASH_RSS : 0) |
+                         (n->rss_data.populate_hash ? NET_VNET_HASH_REPORT : 0),
+                .types = n->rss_data.runtime_hash_types
+            };
+
+            if (n->rss_data.redirect) {
+                size_t indirection_table_size =
+                    n->rss_data.indirections_len *
+                    sizeof(*n->rss_data.indirections_table);
+
+                size_t hash_size = sizeof(NetVnetHash) +
+                                   sizeof(NetVnetHashRss) +
+                                   indirection_table_size +
+                                   sizeof(n->rss_data.key);
+
+                g_autofree struct {
+                    NetVnetHash hdr;
+                    NetVnetHashRss rss;
+                    uint8_t footer[];
+                } *rss = g_malloc(hash_size);
+
+                rss->hdr = hash;
+                rss->rss.indirection_table_mask =
+                    n->rss_data.indirections_len - 1;
+                rss->rss.unclassified_queue = n->rss_data.default_queue;
+
+                memcpy(rss->footer, n->rss_data.indirections_table,
+                       indirection_table_size);
+
+                memcpy(rss->footer + indirection_table_size, n->rss_data.key,
+                       sizeof(n->rss_data.key));
+
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &rss->hdr);
             } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+            }
+
+            n->rss_data.enabled_software_rss = false;
+        } else {
+            if (n->rss_data.peer_hash_available) {
+                NetVnetHash hash = { .flags = 0 };
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+            }
+
+            n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+            if (n->rss_data.populate_hash) {
+                virtio_net_detach_epbf_rss(n);
+            } else if (!virtio_net_attach_epbf_rss(n)) {
+                if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+                    warn_report("Can't load eBPF RSS for vhost");
+                } else {
+                    warn_report("Can't load eBPF RSS - fallback to software RSS");
+                    n->rss_data.enabled_software_rss = true;
+                }
             }
         }
 
@@ -1230,7 +1275,13 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
-        virtio_net_detach_epbf_rss(n);
+        if (n->rss_data.peer_hash_available) {
+            NetVnetHash hash = { .flags = 0 };
+            qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+        } else {
+            virtio_net_detach_epbf_rss(n);
+        }
+
         trace_virtio_net_rss_disable();
     }
 }

-- 
2.46.0


