Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2FAC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXR-0002PT-3V; Sun, 28 Apr 2024 03:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXO-0002PF-DV
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXJ-0005Py-Fk
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eddff25e4eso3014749b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287680; x=1714892480;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GBdjBXNThvQx0/pnNoSh1VAmZe6PeAFaRuMnO+Fqs0c=;
 b=wf4dn/lWkmDh2w7bKS+2Bt9Ei5MUz981f0Frz/e/oVjASclnT/zd00oyhJcBlDaYQf
 xq3zQ9lffoK94dkLggJ/aGnrNkZGlMtObVjC3aRrHjdsY89WlV6trk7b19Avh/LPk3cg
 3EleJr4xT8f+Isjz8z/Yhta8sZxPIZE8xDN7uKNWgXKWNNvLUBP+36gBu/aRfZzhnDsU
 6rqFUZT6TKP0nY7Ceng2Yq55muQeh6z2j95OoW3LEVjwVbP9NVVkcwZSfJ4c6XaTmJyN
 I4G1hYdEnt7MTneqV1TDHUBqKbH6Mh5TpPGEoJFmktgnGxm4Uk85pPuTBsmY/Qlb+Nr+
 QzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287680; x=1714892480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBdjBXNThvQx0/pnNoSh1VAmZe6PeAFaRuMnO+Fqs0c=;
 b=lCGLM+L+eI2XGZotw1+ZztPHwaSpq0qoOgrOwb7f5yJ8M8+ho7JVvso8gpj4wV9ELa
 tvCGufHhblQmomIAxg4T3xGUB+8cs/gZgBzUjhuscThjamVLHYK0f40k3j3KP8xL8wkF
 gUU25wLsxjPAHq7nIlGN54554N76Vdt3nfSQqnH0Z+hjL+VVhrfpZxwK2/ZW30INMPb/
 66c/MpPc+VCmQWuXasmuQZlNrRxXAAC/3EAc2VeBBY+zcpOhMfg9vsZl8B+p4wkioeDG
 be4ZPGoBWbsS+chknVR79fo6Asun6uVDd+U0rTN3nJ86dBP5EwY1NRvUmYVY4EF5dQpn
 gX9Q==
X-Gm-Message-State: AOJu0YxV6sqBguQYhi9dqgLUdObjhhEaJqxW7PjCExm1S7lElamGIxX/
 nbI/dMXOt+Jnow3bPbW51ZowPPs9iITKxWu8TwZbSWAv/tuPdCofCA+jpzESvsM=
X-Google-Smtp-Source: AGHT+IFiid1eJQqTTTXThMRVSQOxrsZQLwe3jZe7cBY7AsI3sklOiBas3T1sm5zGjMm/OBe3r4jOPQ==
X-Received: by 2002:a05:6a00:2e02:b0:6f0:f54a:4e7a with SMTP id
 fc2-20020a056a002e0200b006f0f54a4e7amr8111542pfb.2.1714287679957; 
 Sun, 28 Apr 2024 00:01:19 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 fh31-20020a056a00391f00b006f3ef025ed2sm1977513pfb.94.2024.04.28.00.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:50 +0900
Subject: [PATCH v10 07/18] virtio-net: Do not propagate ebpf-rss-fds errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-7-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
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

Propagating ebpf-rss-fds errors has several problems.

First, it makes device realization fail and disables the fallback to the
conventional eBPF loading.

Second, it leaks memory by making device realization fail without
freeing memory already allocated.

Third, the convention is to set an error when a function returns false,
but virtio_net_load_ebpf_fds() and virtio_net_load_ebpf() returns false
without setting an error, which is confusing.

Remove the propagation to fix these problems.

Fixes: 0524ea0510a3 ("ebpf: Added eBPF initialization by fds.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f6112c0ac97d..8ede38aadbbe 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1329,24 +1329,22 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
     int ret = true;
     int i = 0;
 
-    ERRP_GUARD();
-
     if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
-        error_setg(errp,
-                  "Expected %d file descriptors but got %d",
-                  EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+        warn_report("Expected %d file descriptors but got %d",
+                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
        return false;
    }
 
     for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
-        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
-        if (*errp) {
+        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
+                                  &error_warn);
+        if (fds[i] < 0) {
             ret = false;
             goto exit;
         }
@@ -1355,7 +1353,7 @@ static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
     ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
 
 exit:
-    if (!ret || *errp) {
+    if (!ret) {
         for (i = 0; i < n->nr_ebpf_rss_fds && fds[i] != -1; i++) {
             close(fds[i]);
         }
@@ -1364,13 +1362,12 @@ exit:
     return ret;
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
+static bool virtio_net_load_ebpf(VirtIONet *n)
 {
     bool ret = false;
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds
-                && virtio_net_load_ebpf_fds(n, errp))) {
+        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
             ret = ebpf_rss_load(&n->ebpf_rss);
         }
     }
@@ -3825,7 +3822,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n, errp);
+        virtio_net_load_ebpf(n);
     }
 }
 

-- 
2.44.0


