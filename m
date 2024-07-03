Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FEBC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8oG-0006c9-1M; Wed, 03 Jul 2024 18:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8oE-0006RN-Pk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8oA-0007ZL-66
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFIfkLYWXfsdkRs/ADDmSifhmh+YyxsrJ8fplItaj14=;
 b=a+dgtwMExna07Q+Yk2RQP6C11GLDuepbkYIlLcJz2Y4Gfm8FqE3XpxNrHDMAjSrPcNUe8B
 OX7fvQSE/+EhkLI42eSWayywO+/eiFf3pBtMogLWNIRE6L9QhBidKPDXDI/PU569FIZ9rF
 rKIPYtyRj4B1ZBbrNDeVIJmLnhRltxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-wPaCuijON3SRSusQH0g80g-1; Wed, 03 Jul 2024 18:50:36 -0400
X-MC-Unique: wPaCuijON3SRSusQH0g80g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421179fd82bso13485e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047034; x=1720651834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFIfkLYWXfsdkRs/ADDmSifhmh+YyxsrJ8fplItaj14=;
 b=lKbFhRVbdBreI13OX91GxflR+GrvmsuwRDacpGIeARfe8YgeaiBbgn/J7BirSFO4+n
 SJqlrgwroXncBQwWlGBih4B2SYoyQbjNaXZ3bez8w4sUR0WP/S47A4NKCam6y4QZ+MX6
 XKKv7C/aOPoDL0JBD5MG+NO1D08QgnOb5svcxhONkyOcMhxo/26IsBrhe29N+HUMtkBz
 YrjUW/t7+h/DefXtLyGQdjMtyhMQe4aUpoZTeYt3XRddH6Xno5kosE8ni/lsiD60FliW
 4hSG/FdY6nceM86er0DX1vsqkmQO77tFptvjZXEc7v8T/lRssUzEIU+0RZC5xggcVgTf
 pOag==
X-Gm-Message-State: AOJu0YyX3RD0HwRpyayk17gDeJaiqlNQm3HL5kKhphcYDD3/29E94VQH
 zkhzT1sjdChhn+ylluHCfbCviB1k9pHIXnUoryuQSi+hwZ47qInMbsF6Otw97M6F6V7tQ6T6vn/
 17/8A67xAFsholfDUuOHy8G7El5Z/vjijFR70pgygbD+hA+Rj/Vx3irjKHNOvTHuS+xrcdSV34e
 wmMF/xxKWINyq2gKx+gmjzaLQr2rymMA==
X-Received: by 2002:a05:600c:4b95:b0:424:8ae8:d9fe with SMTP id
 5b1f17b1804b1-4264a3d9714mr366415e9.6.1720047034720; 
 Wed, 03 Jul 2024 15:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN5JPfXc4OuhVvccE5GcBK3xl0DMhGcdDpFU/R0Nlctq5mW8jzjvAbxFdcynxz4GMitiowJw==
X-Received: by 2002:a05:600c:4b95:b0:424:8ae8:d9fe with SMTP id
 5b1f17b1804b1-4264a3d9714mr366315e9.6.1720047034135; 
 Wed, 03 Jul 2024 15:50:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd784sm16993260f8f.7.2024.07.03.15.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:33 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 82/85] pcie_sriov: Release VFs failed to realize
Message-ID: <1a9bf009012e590cb166a4a9bae4bc18fb084d76.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-7-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea..9bd7f8acc3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,6 +99,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }
-- 
MST


