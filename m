Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD0CC48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2FY-0003qq-OR; Mon, 05 Feb 2024 11:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FW-0003qO-2O
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:14 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FL-0000Vt-Nb
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:13 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a358ec50b7cso595256766b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707152101; x=1707756901;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rMmDjSiGyECuYPwrOF9gTLiEHicLAPkrFRPryZWGJ8=;
 b=f9yvxUpUHH9exiBfNhoPjr7CyGEY1vjb8Ya/7y+xThSq6VHojFDP2OaNPeORUDf4FL
 SjsVzPoZWGWGpRupzTPxWqvkwf8GEODucD5jFaDhNfqbyqo2qQyaOhNfNeJYjMWkUMJ+
 rFPYCdUzJHPsZGLkPfxGtN8D/kMBlXoRmpvuIK5+Z/boDekX5sWFCGF1Bobzm4YkUTDa
 yYSPNbZxONJOmGS4N6ft0G5uGCr3ZARcvHSw4ynswhTyQr8PUofjPC8R0SOtQWRARFfc
 C/cgbaswE0Wc/X55wg6uL+Zbl6h5rKYE9K6+Tgs5LzzNdhtBVx4zF+uaLqHOGgCCUbi4
 ODCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152101; x=1707756901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rMmDjSiGyECuYPwrOF9gTLiEHicLAPkrFRPryZWGJ8=;
 b=QtY9Bk3qddR9OVUKcnm47sWTc8Xm/w8j/dlwXYbT/j1QPx2FFBnNhysg54F56JqJ86
 IhXjmkBtHBdEEp/ljEAe/wuwtKTYwyxfqCnr3PXHrDUhel/rpy0kIkNHfPLGNSSSpcpn
 F9wtD+xRTbp8uqby5cd7LSxZfOVEzjHKUVZQcuBpZIrA/3vn37blaZyoRGJF3Ka86siL
 TrxA0gzNlUeiLTVORCJgqU8uM7yrMUrpcd7V/IMi/da2P35VS9Q82Mys94kb6cXxtpqh
 Lfi6+mBOWuFMv8tXNpiOF40RtMbo2nobEjps+AMfcTLeJiCpluhoBuDWNpj4fcCf0n6I
 /qEg==
X-Gm-Message-State: AOJu0YwoqSEEPtZfpwoFgbai17uovDYTXziHFHRF1u3cgoyBn4Di+bLG
 Q5YxiYIaJW44hzFKRX0b7xI1NlrJNaRNUCkmKAFrwHz1Halx2jOYaK8jTjrpcyQ=
X-Google-Smtp-Source: AGHT+IE/REQp1hrFldnVfmT/xvBHi4t1H6oDQk8kvGkx3R0AgU/6VLSWhTjMprxToysCmvLY/N+rVw==
X-Received: by 2002:a17:906:40d9:b0:a37:aeab:76d0 with SMTP id
 a25-20020a17090640d900b00a37aeab76d0mr271175ejk.3.1707152100973; 
 Mon, 05 Feb 2024 08:55:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX9Qw4RcvirVzLJEC4rradImiUcZ/Vk3bsm+auLg+fOchOBUIzybUbSj8zakaMtAlYF4/mODUVAiyX5VPEkA2a+NUaPZIdcdn+BAP8Is08DXAq4ZeggoFzu8JmYeQsq9Ro0hloW5sM4tKTzt9pG/o/4AXiehZjlrRgosM9ri3S7wV6djCdPTc55pmhLvdXjQ2+x5KvdNa0VPVuMKDGE3eRer/3Rmul9rhD9YFPidJ+TlPqYd8v8a3u2qbM=
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170906074e00b00a370a76d3a0sm20580ejb.123.2024.02.05.08.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 08:55:00 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v9 3/5] virtio-net: Added property to load eBPF RSS with fds.
Date: Mon,  5 Feb 2024 18:54:33 +0200
Message-ID: <20240205165437.1965981-4-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205165437.1965981-1-andrew@daynix.com>
References: <20240205165437.1965981-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::630;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

eBPF RSS program and maps may now be passed during initialization.
Initially was implemented for libvirt to launch qemu without permissions,
and initialized eBPF program through the helper.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/virtio-net.c            | 54 ++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5a79bc3a3a..d6dc5ff2ea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "monitor/qdev.h"
+#include "monitor/monitor.h"
 #include "hw/pci/pci_device.h"
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
@@ -1328,14 +1329,53 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
-    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend doesn't support steering ebpf */
-        return false;
+    int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
+    int ret = true;
+    int i = 0;
+
+    ERRP_GUARD();
+
+    if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
+        error_setg(errp,
+                  "Expected %d file descriptors but got %d",
+                  EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+       return false;
+   }
+
+    for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
+        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
+        if (*errp) {
+            ret = false;
+            goto exit;
+        }
+    }
+
+    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
+
+exit:
+    if (!ret || *errp) {
+        for (i = 0; i < n->nr_ebpf_rss_fds && fds[i] != -1; i++) {
+            close(fds[i]);
+        }
     }
 
-    return ebpf_rss_load(&n->ebpf_rss);
+    return ret;
+}
+
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
+{
+    bool ret = false;
+
+    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        if (!(n->ebpf_rss_fds
+                && virtio_net_load_ebpf_fds(n, errp))) {
+            ret = ebpf_rss_load(&n->ebpf_rss);
+        }
+    }
+
+    return ret;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3767,7 +3807,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+        virtio_net_load_ebpf(n, errp);
     }
 }
 
@@ -3929,6 +3969,8 @@ static Property virtio_net_properties[] = {
                     VIRTIO_NET_F_RSS, false),
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
+    DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
+                      ebpf_rss_fds, qdev_prop_string, char*),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 55977f01f0..566ec53e7e 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -225,6 +225,8 @@ struct VirtIONet {
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
     struct EBPFRSSContext ebpf_rss;
+    uint32_t nr_ebpf_rss_fds;
+    char **ebpf_rss_fds;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.43.0


