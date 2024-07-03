Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A25C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8o1-0004fJ-VC; Wed, 03 Jul 2024 18:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nz-0004Kb-Vg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ny-0007X7-7t
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6T5wYohIMyfJ7zfD4BymibarRz8jk6tb2fFAczZH0qE=;
 b=EwCL+JBFFQR3+TI7uBKW6tggUuG7VkEnVmP7HZSw06s3GIQk2aPwSoiw+xE+jfcS1M42C+
 nASF5P9wAIrjM4PHmKZGlZC8AhtUJv4sYOne/ERTY0HLaItt/VcZvqUO8iYozd5esIY90y
 NJ3xZTzct6HESb5NkbhwAX28koe1cbs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-tDgj2u9OOsOC2l5U9pe00g-1; Wed, 03 Jul 2024 18:50:24 -0400
X-MC-Unique: tDgj2u9OOsOC2l5U9pe00g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3678e549a1eso36889f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047022; x=1720651822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6T5wYohIMyfJ7zfD4BymibarRz8jk6tb2fFAczZH0qE=;
 b=YPk06O06lHsIfrGGs7/mFa/wBNQZJa/arMJVz2aUe3rvECxWpVATyhQpgFTRh2q38T
 FFmYYZpLEKkEv8LbXFwNPgdHvivWrz89iF+ZFU0JvrZ9i8haSwxYtbpTK+bzwM4W0f2m
 IG8kg5U1amtlnJU9legK9L4mdEWceUt4qIeMHy66rXOYEaCpbd39HiQDw5v9cZaGntae
 JerPtGhr4vG44wxIcoMe3DnIAVUQaqx+LRrZMvjlU+OLpsynPDaF6qOyVJlea/d7+jew
 kzKwScDy5b4kxesAHxFYVPA3EUGbV82SGq5x2udck6ZL7nspdtxhf96tppXxKiyzHZaj
 atTA==
X-Gm-Message-State: AOJu0Yz7tw3cv6RYHQuVsutOi7S5TmmBnu8VduMejiTA9I0a4DP1+wIB
 uzzbnMcy+JvaqmqLlGmKIyapsl/4tEXaKeJzOvvTFmRVaPSKI/eJHRIriiNBTDlv18J7JLbNVmI
 mZcczYND2Mcpkwf6YwaOO3nuYjPWTNdG0NpkFNSVXcLQA5CZ+2YqhthuiI+iBLRXMZsD9RUFv4V
 wFJ0hVF3Ydbq7XalwwO/qiKzsbf/l5rQ==
X-Received: by 2002:adf:fe03:0:b0:367:3404:1c06 with SMTP id
 ffacd0b85a97d-367947a6c35mr2645055f8f.20.1720047022205; 
 Wed, 03 Jul 2024 15:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8nRWl6r6HY/AR80oLiKIOloEJjI9UzbQZyAoSCZIK3/30EKBGMLJU9n0fkFgSpinRlNVoXw==
X-Received: by 2002:adf:fe03:0:b0:367:3404:1c06 with SMTP id
 ffacd0b85a97d-367947a6c35mr2645038f8f.20.1720047021600; 
 Wed, 03 Jul 2024 15:50:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367957d3451sm2319022f8f.101.2024.07.03.15.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:20 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 79/85] pcie_sriov: Do not manually unrealize
Message-ID: <c613ad25125bf3016aa8f81ce170f5ac91d2379f.1720046570.git.mst@redhat.com>
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-4-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d7..499becd527 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }
-- 
MST


