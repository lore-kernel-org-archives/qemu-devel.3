Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F7C35FE2
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0s-0004Hs-I3; Sat, 14 Sep 2024 21:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0o-0003xl-Oq
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:15 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0l-0005e1-GW
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:12 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7db233cef22so1546151a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363510; x=1726968310;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4hKy6WeHKTopFFsCzB6TpUBLh4s+GMB0sadGqV/W3WI=;
 b=ZzS83AF2shJRW8YQIuSmQWzgKzs7IivQKMnNGbIZqetfE0z0hjS0kFhSLLhx1Sz8dX
 k2ubC/5xvFVZgo2AulPzUWEJiGtKP69HPiaShUpbf5+3M6AZDdCArlCijfXhf9p2PD6+
 GQ4AmoIlxzbseCplMwyCQL4Vr2txK12Pfl4SQSgKO7ajBidihkiwynHbcEeRvQug4nqE
 VQZeEovCOIFjag/5AJd38pICr3eWkvGoOWpSXepYxyXSGLQ1CtxXhqKZQcR/EbxX/KXd
 y/lYMjNC7Hu0hooWyAGQj30elqujkocpCvewmfMITc5eItDXTf5oT4tDTMTWxniCSNLm
 AsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363510; x=1726968310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hKy6WeHKTopFFsCzB6TpUBLh4s+GMB0sadGqV/W3WI=;
 b=iuo22EtbubUrL9y8zis76eYIhzO7CG21drl3dcJigsISNLVO+9T4NMnvp/Aqcgn3D4
 pxbcwMrh1VJs9+l2abiVLvDQHWUME6WmBlrSUhvV5VOvNArhuanMm1eh+AuaeWGpc3Zl
 o/wuXxTaK43PFdf1rv7YGJjX8KukT6sTPc7IfZShBN0DHL1a8efDqA0k6EUt8/a7S5zA
 H+K8oA0v6tyOiPZvBQlw3sQueVs/cxQukUfn1ZL9SwpOTze0rECNhZD2JT6vSv48Mgu3
 dF1H/Y2m8sPJ+YtBdOCQ3x4MU+rSwY+17VuizVGzhTG3OLdoVmyRjKpEj4bkYmeU5T/o
 ebpg==
X-Gm-Message-State: AOJu0YwMXzeFljg7/POoPbBjCk7dXF5UtEpGvFzloAWeaSDAOdnGOPJa
 Eg3v8Dp2UB6BectTPRKp+0ANMSUbt1eKCWbc6kHeeoBu8RAUyVLaZh9Lc2s9qdZgBLS0Ml4rRVB
 SxRc=
X-Google-Smtp-Source: AGHT+IHvjDZm5dOITED6jlH+QLrINXDdVtfofu/VErlAJom+yvrzk3xn+e8c/63yvqQAHdGHpOFS1g==
X-Received: by 2002:a05:6a20:c996:b0:1c6:a680:ef3d with SMTP id
 adf61e73a8af0-1d112db5de9mr11528046637.28.1726363509887; 
 Sat, 14 Sep 2024 18:25:09 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71944a980b4sm1528308b3a.34.2024.09.14.18.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:25:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:50 +0900
Subject: [PATCH RFC v3 09/11] virtio-net: Offload hashing without vhost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-9-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
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
 hw/net/virtio-net.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index be6759d1c0f4..72493b652bf5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1695,7 +1695,11 @@ static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
 {
     size_t hdr_len = n->guest_hdr_len;
 
-    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
+    memcpy(hdr, buf,
+           n->rss_data.populate_hash &&
+           n->rss_data.enabled && !n->rss_data.enabled_software_rss ?
+           sizeof(struct virtio_net_hdr_v1_hash) :
+           sizeof(struct virtio_net_hdr));
 
     *buf_offset = n->host_hdr_len;
     work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
@@ -3072,11 +3076,13 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!get_vhost_net(nc->peer)) {
-        if (!use_own_hash) {
-            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
-            virtio_net_load_ebpf(n);
+        if (!use_peer_hash) {
+            if (!use_own_hash) {
+                virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+                virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+            } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+                virtio_net_load_ebpf(n);
+            }
         }
 
         return features;

-- 
2.46.0


