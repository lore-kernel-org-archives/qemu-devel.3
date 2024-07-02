Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6302C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEJ-0006PW-9v; Tue, 02 Jul 2024 10:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEC-0005mw-5A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE7-0000UB-W5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=actUboiQ+IrTgCsdz18KhXUIoDAvYkrEhXUsAIxh/Nc=;
 b=azpd1l0JiInCl3Jsp3ANWXbjT8oZgO2rkVrkOugnZ/IqaiVRTKVjCfnN9rqxwh13BiJYHL
 PljPiJgiuzobSyFwdhYGQ42U37s1G18D7B8HGAHzJCnNjR4JBjcvxU1XWRleQg9y/AsQ+y
 knMgCqOTSmQYObiaQzSUhn9KCiGPEjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-YsTsPej4Nvy9YM0AuGNC-A-1; Tue, 02 Jul 2024 10:11:20 -0400
X-MC-Unique: YsTsPej4Nvy9YM0AuGNC-A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso16894895e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929479; x=1720534279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=actUboiQ+IrTgCsdz18KhXUIoDAvYkrEhXUsAIxh/Nc=;
 b=HbYTlvOkvz6FxSFDxdr4S+2r7wwX2NNMuWgKfYy2Q1oZOGkLvrb2rOQa8udkd+WywU
 kMG0GUJKem+FUpVfpouDVBQZy/hNUdsKsF2sBt49Q2msAnaE5llE2snmnHUnwR3bZ9qZ
 t/7QVS1iGFqhfBNP60a4999pVMzN5UcfL0qTW6BRE+DxgdfbihMW78+p+IgNJVAu50ah
 7Lt/yKQJd7NktuLfdDrfi5Y2RM2bPgjiY18zraiQytYgNSVY9jPb0VW3p1OsaSYhlA3F
 tJjDYkIbWLOZyv9a/6MPGrF7c+ioksKncgtUrPAlBrpLO4gcAG74383id1UQ9ImlFJv7
 zVgg==
X-Gm-Message-State: AOJu0YyNIA6NhgriCcK4NFIbyqHf8Zx593D3vbp9/kjzCBxlT3PC4pxt
 YNb/9rp/aSnelD3cslsr4jJUg1wzSU/77adYm1mPQL8EudbsLCQtn1M6bKCe2JtHO6IBZsFlrGS
 mUy2e9ITwPKDQOI9LktS/fllMuHkSD4A/v+DhPUALSzngGr/FEUaZxvYPFjnyKJJAnqQQxBXc/r
 Zu0ZMIa45J0aMMqzkek5aZ0h87C2rQEg==
X-Received: by 2002:a05:6000:2cc:b0:366:eb45:6d55 with SMTP id
 ffacd0b85a97d-367757215a5mr7036351f8f.49.1719929479414; 
 Tue, 02 Jul 2024 07:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuoZUZAxFLi6xOWmUDcw8ZAvIjY+5z3b4et2gwHpUkVjDAM9ED8sWHRmDpZMBQ2aClDMBVjA==
X-Received: by 2002:a05:6000:2cc:b0:366:eb45:6d55 with SMTP id
 ffacd0b85a97d-367757215a5mr7036294f8f.49.1719929478487; 
 Tue, 02 Jul 2024 07:11:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b12sm13315259f8f.44.2024.07.02.07.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:17 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 83/91] hw/ppc/spapr_pci: Do not create DT for disabled PCI
 device
Message-ID: <be7c4eca969b0c1a17a4426c9ef2fbdb3b731d2f.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-2-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c35..f63182a03c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;
-- 
MST


