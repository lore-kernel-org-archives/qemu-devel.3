Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F293C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeES-0007d0-Mu; Tue, 02 Jul 2024 10:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEN-0006pG-Eo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEL-0000kM-Dz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFIfkLYWXfsdkRs/ADDmSifhmh+YyxsrJ8fplItaj14=;
 b=Z38KRAQuQQPMCPzvi8rP9btZC5VljfTUepDSetgo7g1zXdsk8gFJ7oizNYYgZFZ0YhmvRJ
 Swr4KEpmBqOzbyl7qEF21jiNfGW1SgHIS2w8x8OCgHkHzrD82i7sknqmp3d+PoPtc8oTOS
 xSXlOINoRSh3ZR0LC+PxiIMW9PFp0cM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-mmDdIWY6ME6bo80ERQjblg-1; Tue, 02 Jul 2024 10:11:35 -0400
X-MC-Unique: mmDdIWY6ME6bo80ERQjblg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso19249435e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929494; x=1720534294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFIfkLYWXfsdkRs/ADDmSifhmh+YyxsrJ8fplItaj14=;
 b=WbaSI7y3XL9v//fVnYDXeXiv/jsrkH45v8A32j5EXFeNRAiLnj/GBGTM2xHgsL7oPg
 thrDFb1d/5ZdMBnFguRUQcQIT9EeTo2PmZbtycPrLP0dNA1rV/vKKV3qWBjCqB8YEzZV
 O3tvaAscxv9tHcWNpbSSUlMKhebQ87Zx/A5Nqt/EbMkWr7gx1tvXg1S2IglYx70PZgfS
 iwGb8fyNYzOyGszfUB11lAb41tL5CQLmTh2KiL7jpD7o0UJRHhKQ0teuBOzx46S992J+
 9XuDQkKoMHdPFMoFKv2kHZ9h+mit3VsTL6Bf17tUy9D9wJUJSjUbLSrI2rl+7CQXp6cM
 f75Q==
X-Gm-Message-State: AOJu0YzrfbJy4KWDRauG/PQEq5ZkwWnq1aCYg7Stkj+hRiUq+Lg2ZWk8
 0zQADgWyeWF8+gOaRDwSMAfh0mgUn9Ej53UX/ocNPUasj7xF3Rj1audxiobQkUSV+0gBEDaFVrG
 ccha7IZhWk2yE7A2KqaVicaDnAH5ZmFzMTRI6QYoXPb/9PuvUwy7yc22uR0SaC5LABeTIcMSo7P
 IwiDMtGJYKCEpBngJ5ooA5GSsw46RxQQ==
X-Received: by 2002:a5d:56c5:0:b0:360:81f8:698 with SMTP id
 ffacd0b85a97d-367757296demr5085099f8f.58.1719929494073; 
 Tue, 02 Jul 2024 07:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkigKak7HA1EhoF1ixzVyZ/5HuRrU8zK7z8MiVLW72Qh+BOcJh/KRn6KERZXUDa6vfCrLa2Q==
X-Received: by 2002:a5d:56c5:0:b0:360:81f8:698 with SMTP id
 ffacd0b85a97d-367757296demr5085078f8f.58.1719929493545; 
 Tue, 02 Jul 2024 07:11:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm13289261f8f.100.2024.07.02.07.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:33 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 88/91] pcie_sriov: Release VFs failed to realize
Message-ID: <c23d95ba5faa243a89b65b1bcde2372cd26bdad4.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


