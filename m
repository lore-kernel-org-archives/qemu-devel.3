Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B10606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljWCKYkh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgD-0001Rf-D5; Fri, 30 Oct 2026 07:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg2-0001O0-Se
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:43 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg0-0002mf-RR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso278118f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359299; x=1793964099; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wATYT6BvjZcVXWDHqPLOg+g6BseY/5lYU9MCydp+P3g=;
 b=ljWCKYkhXyFwN7A9knIjItNdZC/0Ob1JSJaVxC/V71qcfDvkS1cfe3G/7pxFnLtEtb
 RHeS8MIUljdF7cnxwdmuzcWKSO5qBMHcmJCgWok0sagMDGNSykjPOz1kebyzv7vKnjfR
 IjbLmfpW+iQaQH+URhR56N46z3+LRPKNd9dYeiEAjFpnZJYP0OuWRUFTwgTtZdHeAY5C
 mPyaMhyMwvr2+gpyXBzKVP0H8fx3UTJPhP3dsRk8eDnTlTTexkGfs/+lIjZ8hDxPmI7U
 F9fqUJwyU65Fc4T5QSFY5xo1P8/Rq4TvWuNcCnPOtsVLtijN+rr/Ti6D/vAM+375UlvM
 4BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359299; x=1793964099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wATYT6BvjZcVXWDHqPLOg+g6BseY/5lYU9MCydp+P3g=;
 b=eMyebkEHnD8Dlz03tKpTyLK/AzaRwM+k0xb9CnASgDBCvEWxY/9vHP07eDvrIyE67w
 XrRsQNSOmRbB7bo80bqE7Yg5Fkwp7nZUnSEUZtdRPzJ+T77u5P8C/bF6D4JxxawEKR/m
 ZpLBfbtBjdjTEkjICdYzoQN//D1gZZB38tg1E0tAihR+CwjPSHHwj++awwXDfOE57A8x
 fW4+OGurzKXM9aHW1KgsUbsA1u3R9d9RqHyGJiSuPtvc7LFiticPg+iZHIZlye1dChLb
 TpNxL25cSvlzVrnc26XPDwQX6lb5GDhZoY3SJTSQ9IhzN9HERvC9HQ2gF5r3xXOwn0iT
 oXwA==
X-Gm-Message-State: AFq9FYJvZWMywse9HDjCQyY1ILVN1uXlcEcKtH40000bAUZq1AgyoyAV
 iLcDkce5AIWekfJ7CUv04VigyDlzjNxPzW15w5CN2YcHpj8zds6zx5O9
X-Gm-Gg: AYBFou2vfZrI9n/Tq0rCCy2WKBOZlQUX5XpU0jSt3pc0RB2JSQKw9cKBwqGoZyTnAKJ
 i4gTXOCeJyl2t37Bke0CpD9bk8bFRPBJyCUDnBXSkPQ1+e6H36m3RKnq/bmeOYYPuz7Fztvjoib
 PXF3h2PPuvWtTet3VSjYic0dOR7H0VmKBml+daNgoNoYRQ1ZWpXjxy0AMDbdd95huh2nJXIgKP3
 eZEXO0DoM9IW4AZViZC56f50PMVc40aKeTl8yezJNpOLs7uPAic7QYsKAz51otlqXWWXWu/XCVY
 74OtS+uqs01FokDgyMObjKPuvWCrqzwA9reS68C5RgRjRhRV5lHL1vL4ohF5f63Vc7xLe2agjzr
 K2b+06Xg54f9dqE23gLtmqVHnXxwjuO1WiDAa8AZYLmuFNtgJYFChrPy3WRxlb5dWCEVESIf2yF
 wd+Hb2XPjH5aN/F9D6z7C8tvPQG+XjIyDijA2RVWBzZYkIQzZXHKYeg4ExQ2deYPICoZ1Ub8zvH
 610GotgpGLV9zdYII4QAAKYKc+A/XT/pJirIUIkPryYMKW4ZWpVYstcsfxiuxegmDTfZIphxLuA
 PK20pCPZa2i9O57XUy0uopFZhuDi5c3QIe3Df2dgijCXj2kv3lnJR7FtSXwe+eoQ8Hxj+FPj4tn
 7S15JuGgbc+PXugdcXijy33UB4lNlvX+uRc2nSRsdaDONtAKtBOsXlqz6LFWYP/CLk48/9bMFrq
 IpxhTAn7o=
X-Received: by 2002:a05:6000:d8c:b0:48e:1c72:abc with SMTP id
 ffacd0b85a97d-48e6e5066a2mr3651079f8f.35.1793359298840; 
 Fri, 30 Oct 2026 04:21:38 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:38 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:21:00 +0100
Subject: [PATCH v2 7/9] vhost-user: enable frontends on any POSIX system
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-7-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vhost-user protocol is not really Linux-specific so let's enable
vhost-user frontends for any POSIX system.

vhost_net.c uses VHOST_FILE_UNBIND, which is defined in a Linux specific
header. The kernel's VHOST_NET_SET_BACKEND documentation asks to pass
fd -1 to unbind, so replace the macro with -1 and drop the include,
nothing else in the file needs it. Long-term a constant could be
introduced and used for it.

Co-authored-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
Changes in v2:
- Replaced VHOST_FILE_UNBIND with -1 and dropped the include
---
 hw/block/Kconfig   | 2 +-
 hw/net/vhost_net.c | 3 +--
 meson.build        | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 737dbcdb3e..7edcd7a8f6 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -28,7 +28,7 @@ config VHOST_USER_BLK
     bool
     # Only PCI devices are provided for now
     default y if VIRTIO_PCI
-    depends on VIRTIO && VHOST_USER && LINUX
+    depends on VIRTIO && VHOST_USER
 
 config SWIM
     bool
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6e05c995f1..d0f1014ce1 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -33,7 +33,6 @@
 #include "standard-headers/linux/virtio_ring.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-bus.h"
-#include "linux-headers/linux/vhost.h"
 
 void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
@@ -681,7 +680,7 @@ err_start:
     error_report("Error when restarting the queue.");
 
     if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
-        file.fd = VHOST_FILE_UNBIND;
+        file.fd = -1;
         file.index = idx;
         int ret = vhost_net_set_backend(&net->dev, &file);
         assert(ret >= 0);
diff --git a/meson.build b/meson.build
index b67a97ab45..eb296346a8 100644
--- a/meson.build
+++ b/meson.build
@@ -221,7 +221,6 @@ have_tpm = get_option('tpm') \
 
 # vhost
 have_vhost_user = get_option('vhost_user') \
-  .disable_auto_if(host_os != 'linux') \
   .require(host_os != 'windows',
            error_message: 'vhost-user is not available on Windows').allowed()
 have_vhost_vdpa = get_option('vhost_vdpa') \

-- 
2.55.0


