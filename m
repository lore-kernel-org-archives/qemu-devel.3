Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE02CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFc-0003HR-VE; Sun, 05 Oct 2025 15:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFN-0002OT-Qq
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFA-0006a7-Ub
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PrhgJgfyKAMoMVpOpkddsOkrdYd1EBxIW2i7TwGfmI=;
 b=ZIiDeCzQwlLIyneOgm1bB4aaTZT+CJHUmwOvC9b1utYoJXkuONDAjF9gS42dMewwNiJ0N9
 AWO2uDIDsXIy0QxIqZGvg+ahu4rdQe5UQlo7aBmh08stV7mDb+zV8fuZmGI0AQfnrTybJ8
 wtTu5f/diuX0mEsCqCnZ4PZ5pDEpl4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-_FK2ETdZN8qVoIO6mnxGmw-1; Sun, 05 Oct 2025 15:17:54 -0400
X-MC-Unique: _FK2ETdZN8qVoIO6mnxGmw-1
X-Mimecast-MFC-AGG-ID: _FK2ETdZN8qVoIO6mnxGmw_1759691873
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso22007825e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691872; x=1760296672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PrhgJgfyKAMoMVpOpkddsOkrdYd1EBxIW2i7TwGfmI=;
 b=o8rd1GN7Ue6isFfWRoUzZFKGtS1ARMgFBPhwSv/PF1pRSxGlcKaZR0G2E2xWzCCpnP
 Qttwy2iKl+s+CkErvhY/KIBKZugLCfxE7xUKc+8WD5sKA4ig4xppCXfEb5DJXMlZnQS7
 ah5jhZ7+QpPYW+gumS6GNGp4QJJL7JZhZpIT4vdwKQV7Nc3w36apG2WKfEazj6laaM96
 Tfdr5KVwgKcGbLdYlXcFITMTos49XNRrWbB8LI7YtcyJw7Us64iwDTddiYDfwViE70jk
 a9G01V13TZZIxqW0rNB/pN0yxujaOaSvS9+QOATCO8Sbo0h/iMPJwvK9nGN8DU5O7FDS
 Rbuw==
X-Gm-Message-State: AOJu0YyBKTbUbBFUfQgujNg1PC6kFqaszOLbVn4d0D3bebrOyunwLnxW
 NB+I6BF2fDhjshbl7+C5Y1mmGvmcD38/zK8RYk0yyML7YTWjrXJlgMHW8WMt0e4d+nm8goECYlF
 QUdTB7uFX43D0hiQ/+isJLdRRV3BgHGrSeouZ8hCizZI2fOgYLRozPklXHjDy+YwK0erULsd3Bc
 8zyrvHH8zV8gExkpp48/1u4aYLXGuAJTuWdw==
X-Gm-Gg: ASbGncscunrFYiu+8EP4hb0KdziM+jTU93NJut8havkuZGxk7bF3xwddciek/rmXZ7M
 W14T+AakWfWkDPr9Et7YuqOSJz5npu9MaN0cJRHUDmh9An2/6K847v+vd07L4sxtyYajNAFBgBK
 J10ktHDPOYkoTQY9Yucp3KDVCJhHc5etX6Zo49T/UVVb0eSMxmfk8lBrFEgAnHx5eZj+tXe7geo
 buKzDMwLbEsMADOgRrmvHx678MTbYe2bC3lRzpPASA8R6mDnlLfg//w5J4/8AmKU+dw34V+WRnS
 oyEKyTxETTN0NBBivxOJYW9ohrBT10wZpl21n3U=
X-Received: by 2002:a05:600c:37cd:b0:46e:23d3:6413 with SMTP id
 5b1f17b1804b1-46e710b23cfmr67730565e9.0.1759691872260; 
 Sun, 05 Oct 2025 12:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqEbPnwAdt5mPeiOyYDSdCtDK1mFh+oYhWuPgIJumCYpLg8tW5pa7kMyZkWTn6L4dyd0sHuw==
X-Received: by 2002:a05:600c:37cd:b0:46e:23d3:6413 with SMTP id
 5b1f17b1804b1-46e710b23cfmr67730375e9.0.1759691871667; 
 Sun, 05 Oct 2025 12:17:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5f3015sm130169035e9.1.2025.10.05.12.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:51 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Qing Wang <qinwang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 48/75] pcie_sriov: make pcie_sriov_pf_exit() safe on
 non-SR-IOV devices
Message-ID: <bab681f752048c3bc22d561b1d314c7ec16419c9.1759691708.git.mst@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 3f9cfaa92c96 ("virtio-pci: Implement SR-IOV PF") added an
unconditional call from virtio_pci_exit() to pcie_sriov_pf_exit().

pcie_sriov_pf_exit() reads from the SR-IOV Capability in Configuration
Space:

  uint8_t *cfg = dev->config + dev->exp.sriov_cap;
  ...
  unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This results in undefined behavior when dev->exp.sriov_cap is 0 because
this is not an SR-IOV device. For example, unparent_vfs() segfaults when
total_vfs happens to be non-zero.

Fix this by returning early from pcie_sriov_pf_exit() when
dev->exp.sriov_cap is 0 because this is not an SR-IOV device.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://issues.redhat.com/browse/RHEL-116443
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250924155153.579495-1-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 29474d749a..c4f88f0975 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -195,7 +195,9 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    if (dev->exp.sriov_cap == 0) {
+        return;
+    }
 
     if (dev->exp.sriov_pf.vf_user_created) {
         uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
@@ -211,6 +213,8 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
             pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
         }
     } else {
+        uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
         unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
     }
 }
-- 
MST


