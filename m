Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823DFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZu-0004qG-Nm; Tue, 12 Mar 2024 18:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZp-0004du-W1
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZo-0004Gu-H2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XmqbP21rV19SZz1LR6bA4tErtgG1bGr8AxCV75JHetc=;
 b=N0grytndk31Assrr48YZCeqEWzuRi/9g23+ZgMHOiKeOSL6Sh7BY2D2OGhqCFXht1T/vTb
 9C6N/EhLy0FPTUhTnEGDzvDzhSKhFu717F8BK5szmNn8qnTXapzUbew31LUpUdMmFku+bB
 oMAVjmmZmcvTTK2qGKKUPUWMMTEE5/8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-mS-GkQNRPt65rWoIucf84A-1; Tue, 12 Mar 2024 18:26:26 -0400
X-MC-Unique: mS-GkQNRPt65rWoIucf84A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513b2e92c19so2692370e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282384; x=1710887184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmqbP21rV19SZz1LR6bA4tErtgG1bGr8AxCV75JHetc=;
 b=CgRPyZ06i1MV/cEQCM50mHfB/39mASaD2gM6z6V63Azvo9FSCrmZWTC0UP7Aw65I0A
 Nzk7i9V6/hH/713NJmn92H8aWxuSHCPNTprGvGe2C6EUJAgZtzrq/VjlGRgSpYsZtycQ
 tNGX96DMIOXJXzkRquYdZvAZC4RCWz2xkmbFxHsekOb7yHRubdGo2tkj1JYYqwIT0et0
 gkWVkuZW5toB1XOjAdXmCSQSgMfRnctB/gnuO2bWFBhqwFUUUYL2LmdyTWBSiB7H8H7X
 PDc6F58pU2MyM/QIL4eILs0IXjuUlE8CpA7g09fkb8ZZY1f3Ns26ToGvolTUwhAr7jtA
 9s1g==
X-Gm-Message-State: AOJu0YzxSueFYhSu2OaMfpob0hV3+FZ5C9OZKqfTbmO8Y4w1LNwEqvsi
 qEhsWsDJzj2egHkyOEPubPG3ozsohcSRcGDLA+vJRK7lv81j0gy1WECdCKYGieD46Vf9u/+6wi3
 jtLU5pUvioxj9th3DTEGQA27b4DvSARQpiFJU+QD0353I/HT2EV7Ouvp03rXjdtbiNwhMCH+fvA
 roZTwPbtjtfG3vIVA3L78DuWAOr1V3yK1O
X-Received: by 2002:a05:6512:2823:b0:512:fe1f:da5b with SMTP id
 cf35-20020a056512282300b00512fe1fda5bmr9869949lfb.57.1710282384286; 
 Tue, 12 Mar 2024 15:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0S1YuEcGHQTwe253y4qd7XvAkqG2xegD1ZDjzDjqqcaIu/l3HrjLNS2Xe/lcfAEnDCoW55A==
X-Received: by 2002:a05:6512:2823:b0:512:fe1f:da5b with SMTP id
 cf35-20020a056512282300b00512fe1fda5bmr9869932lfb.57.1710282383779; 
 Tue, 12 Mar 2024 15:26:23 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 lk16-20020a170906cb1000b00a45bda3cbb8sm4225545ejb.134.2024.03.12.15.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:23 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 17/68] libvhost-user: No need to check for NULL when unmapping
Message-ID: <4f865c3b15a71dbeae999a10256742751410394e.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

We never add a memory region if mmap() failed. Therefore, no need to check
for NULL.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-7-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index f43b5096d0..225283f764 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -247,11 +247,8 @@ vu_remove_all_mem_regs(VuDev *dev)
 
     for (i = 0; i < dev->nregions; i++) {
         VuDevRegion *r = &dev->regions[i];
-        void *ma = (void *)(uintptr_t)r->mmap_addr;
 
-        if (ma) {
-            munmap(ma, r->size + r->mmap_offset);
-        }
+        munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
     }
     dev->nregions = 0;
 }
@@ -888,11 +885,8 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     for (i = 0; i < dev->nregions; i++) {
         if (reg_equal(&dev->regions[i], msg_region)) {
             VuDevRegion *r = &dev->regions[i];
-            void *ma = (void *) (uintptr_t) r->mmap_addr;
 
-            if (ma) {
-                munmap(ma, r->size + r->mmap_offset);
-            }
+            munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
 
             /*
              * Shift all affected entries by 1 to close the hole at index i and
-- 
MST


