Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BADC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZcw-00085Z-0s; Wed, 24 Jan 2024 04:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZcu-00085Q-KE
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:32:56 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZcs-00048w-Vs
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:32:56 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a2c179aa5c4so558015766b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706088772; x=1706693572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OEqT8fZfYXXtCgzoOdcaTWNEvnpzrNNdx7XE+WgWajc=;
 b=I3J7aXaxNY4UMFh0aeiTaUuTgGejzIytkHqKRBzWzAa3pQxTGgWxith27oDCD2g8AS
 EJ2i6UIDfWM8wcd4Du+2EGzPaT8VeXlZj4+vIf/FFd6LC3IAxnqW7IyOMnAgCvQV3nBb
 Ah9Yu84YM6srV8jEXbHiTLKLjahcLu4o8iQQb/EBqw3IRnOAUyTaXjAfrjOeIucVI02c
 AVUt8iBF+pqf8TW0uITqrRRqOFQ0GWv0aeBbH9g08c1H3NXjvqysIIAPCGMNY3tiPkLH
 Mz65nVUO175pgpx3GOh/u8OD4aIghJ1I+BadQtivMQbIn0VcdRQdzv3muS5uKfgswnWx
 9a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706088772; x=1706693572;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OEqT8fZfYXXtCgzoOdcaTWNEvnpzrNNdx7XE+WgWajc=;
 b=xAZbL2dyzmh66P4CluOpHyIQTnKH6bzyfXxXc9Hiefjo53r03CWGcx1a1YFhhvM8BD
 2J9XVJDXc8wQhAtt2s/HDKCGqSMyldx7Bpwo/Oa8IBV6Eo9aYAP9FqItGX5s8OVaVynG
 ax4+8pgb3gstZptezzVcBgG+trAsm9d/uO0dZ8nbrP5bxdzMRIE7vr/OGZrepxkYIUJw
 w29R69l/k7EXkg/5bS2FFXmj+UPWhjNh8Jx++B7xkxuf/JdIhFjubbWGLoJbHvlw0iBm
 NkWkPdjX04PY2WcB9a5Mg29rC3Zf5SxPfdVrPUHP6z9fNIIjKPxC71kmDbbV7ue5JFA9
 yjfw==
X-Gm-Message-State: AOJu0Yx3Ppcob1XeMVx5rM3GTnn1f6/JCETLetiVMDoJfXqKr8NskPMP
 /1I0NKWyr/i2gUffrVjuPEERuOXpEy/q9zH89HMWzg/vQ4S+uejI/1oeijgsQLguXBmwLx5Tf41
 Zh+c=
X-Google-Smtp-Source: AGHT+IH9tgqxt0BWfErSgJsJEo9kZs3nc2OP4kI5vkyz25W5SGp/SJMuKUEwQluCcVueA6QdM8nwrg==
X-Received: by 2002:a17:907:2d88:b0:a2f:7c68:e043 with SMTP id
 gt8-20020a1709072d8800b00a2f7c68e043mr805102ejc.6.1706088772260; 
 Wed, 24 Jan 2024 01:32:52 -0800 (PST)
Received: from meli.delivery (adsl-90.37.6.163.tellas.gr. [37.6.163.90])
 by smtp.gmail.com with ESMTPSA id
 vq7-20020a170907a4c700b00a2cf537042asm13522660ejc.192.2024.01.24.01.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 01:32:51 -0800 (PST)
Date: Wed, 24 Jan 2024 11:25:40 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 5/6] hw/vfio/common: Use RCU_READ macros
User-Agent: meli 0.8.5-rc.3
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-6-philmd@linaro.org>
In-Reply-To: <20240124074201.8239-6-philmd@linaro.org>
Message-ID: <7reip.7d0x82au0t9p@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 24 Jan 2024 09:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Replace the manual rcu_read_(un)lock calls by the
>*RCU_READ_LOCK_GUARD macros (See commit ef46ae67ba
>"docs/style: call out the use of GUARD macros").
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/vfio/common.c | 34 ++++++++++++++++------------------
> 1 file changed, 16 insertions(+), 18 deletions(-)
>
>diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>index 4aa86f563c..09878a3603 100644
>--- a/hw/vfio/common.c
>+++ b/hw/vfio/common.c
>@@ -308,13 +308,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>         return;
>     }
> 
>-    rcu_read_lock();
>+    RCU_READ_LOCK_GUARD();
> 
>     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>         bool read_only;
> 
>         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>-            goto out;
>+            return;

Since this is the only early return, we could alternatively do:

-         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
+         if (vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {

remove the goto/return, and wrap the rest of the codeflow in this if's 
brackets. And then we could use WITH_RCU_READ_LOCK_GUARD instead. That'd 
increase the code indentation however.


>         }
>         /*
>          * vaddr is only valid until rcu_read_unlock(). But after
>@@ -343,8 +343,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>             vfio_set_migration_error(ret);
>         }
>     }
>-out:
>-    rcu_read_unlock();
> }
> 
> static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>@@ -1223,23 +1221,23 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>     if (iotlb->target_as != &address_space_memory) {
>         error_report("Wrong target AS \"%s\", only system memory is allowed",
>                      iotlb->target_as->name ? iotlb->target_as->name : "none");
>-        goto out;
>-    }
>-
>-    rcu_read_lock();
>-    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>-        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>-                                    translated_addr);
>-        if (ret) {
>-            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>-                         "0x%"HWADDR_PRIx") = %d (%s)",
>-                         bcontainer, iova, iotlb->addr_mask + 1, ret,
>-                         strerror(-ret));
>+    } else {
>+        WITH_RCU_READ_LOCK_GUARD() {
>+            if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>+                ret = vfio_get_dirty_bitmap(bcontainer, iova,
>+                                            iotlb->addr_mask + 1,
>+                                            translated_addr);
>+                if (ret) {
>+                    error_report("vfio_iommu_map_dirty_notify(%p,"
>+                                 " 0x%"HWADDR_PRIx
>+                                 ", 0x%"HWADDR_PRIx") = %d (%s)",
>+                                 bcontainer, iova, iotlb->addr_mask + 1, ret,
>+                                 strerror(-ret));
>+                }
>+            }
>         }
>     }
>-    rcu_read_unlock();
> 
>-out:
>     if (ret) {
>         vfio_set_migration_error(ret);
>     }
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

