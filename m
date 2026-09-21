Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760BAC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8e9M-000264-E4; Mon, 21 Sep 2026 09:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x8e9F-00025d-QH
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x8e9D-0001tf-TQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/wg66tQIiUL7ZQFwo+bftyYh11zAbVGEA1q/jtWVEo=;
 b=F5nwWaXROslE3V62+UU2PbfVVPlxM/w1ZSoPy1CtwWjAF/IeC7Z6797ugiH12BPC9xSY5m
 eX2kiLThuEIFbR904jSodjD2BL/EyWbM/npkrS/k44QZe/3tnJ5N0zrrVdnPIW5NoLcHzp
 IzO3SMtYfIElKjADViOLaB3at2zR12M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-jdsJadDMOheJzMovcHfzvw-1; Mon, 21 Sep 2026 09:33:29 -0400
X-MC-Unique: jdsJadDMOheJzMovcHfzvw-1
X-Mimecast-MFC-AGG-ID: jdsJadDMOheJzMovcHfzvw_1789997608
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4957287363bso26975035e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789997608; x=1790602408; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0/wg66tQIiUL7ZQFwo+bftyYh11zAbVGEA1q/jtWVEo=;
 b=EHhpJdoDJzbX/IolWfv8A2KfdthLqOrldMM6YG36j/75kDRNWUinlwYY2vFcV+99Su
 7JT1pxuz3MuJkTT6ufM3CAVE3fo0dYIR17mVrlTzPVN0SrsAvdTn719a1XoBOgpcerss
 pZJEQRKt5NaLWSsmspsUxv0U083XGYLakVT6M2Jp9gIxKhuPTHoMsYbvVfUgwdlCe7sT
 ruu0jrmIiF7oil/i2xqNitA7h/tFAAagnrYl1yn00Bra62j8wjgR5DxdR7TG2HDiuGv4
 pYKzEe5FrOGboYo2aQF282HZV2AEKE0V8ZI6hAcrG5QJRcdM9onZe23k4VMnHsWr1tfq
 6BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997608; x=1790602408;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0/wg66tQIiUL7ZQFwo+bftyYh11zAbVGEA1q/jtWVEo=;
 b=T18k0jqd4PJIgRu/nfLx1QdS+ZSRns6fOaV7JQTzwteOQ4ZXae0hSHxRo5y+iLCSVU
 U2Z3x1/UXLe4/wmo3V1BB/Vv40vYsOW3v79Kvf03kuvxKkffeaF64D7B7OrdtSDndiN4
 nGtEaI5Xw5o+YBixjsz3E6PK1eUaWIInculdY1PUtJltQX4Yv8JrwJPcE2C1ZtqQVAIv
 I1XSkDKv6yj597+0OhDArmpk/TslHw/1Ha5oP/33+YEG1AZVPaCbyXol8rULxqQU4A3b
 vw6eJyrbct0hGen6+Af+6QozWO7oW6XXtPY+05VhAQjWR5tM+GWX/5dG6P3hlXUTOoTE
 kptw==
X-Gm-Message-State: AFuF++nklR+mka95VWzjJzAm9R7pAx9UAQdIOrjYkPLYS++3lQIFJY6h
 xa1WKdDidIRgBaPNpsDF3+ZwOSFtD+4gb/KPhSv9uR6MpH0sAzBa7MtZxfPVsOO0DNd9X3UoXPc
 y2LEEQAsMlBUOENI4IzLVhz8cky2mr2ubMKJdEf/0mg78EAR+v7jGqAzdZYZ/5wZBjWlZJnuL7E
 Moz4UCOb+CpR6qAP9Vs6JCmO9M4A5rqKYQ0B6J0Z1Rwl0=
X-Gm-Gg: AYBFou35xLvQmRJ+Thl2iOHduuc4eTg0rqOZ6GH8BTiGCSgrZb/8LZoKU51zZel9ilO
 WxteqM1aJUdTHi/5zjlX506O+1tv0X+Z9GAImczsjZ41zJ1gG5L6xSvFj7jKOXdOoChcjLJoUME
 my66OMBIWPeQQjw9xLpMK1YRbMWy71QwNDGoxaq3QhxWhkBpCy5VXQsLG0IYZwnV7dDEvbEpYH6
 LWpzfkWst0KPcXrek5/qddhVFT1TuLjvdvV1Jo4/cjzjTQWCh9vmabto9+k1WHtyo7bwBpJeBg8
 /xWn1YJrb/fCsKjNebQgb6te43hUpIYJioHSGC03US60yuzaIaGEP+V852KdyK7/8sekLRrMj4W
 V6ccam8eS3zdkuwf/DmdK6nqN8P7swC1P9D8=
X-Received: by 2002:a05:600c:3e0b:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49fc5687432mr143252695e9.13.1789997607960; 
 Mon, 21 Sep 2026 06:33:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0b:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49fc5687432mr143252335e9.13.1789997607499; 
 Mon, 21 Sep 2026 06:33:27 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd10273fsm233995695e9.7.2026.09.21.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:33:27 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:33:24 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix firmware boot path when nvme-ns has a
 bootindex
Message-ID: <arEx-OIUBT1g6rzj@leonardi-redhat>
References: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 19, 2026 at 10:04:42AM +0200, Luigi Leonardi wrote:
>The correct way to register an NVMe namespace in fw_boot_order is to use
>the NVMe controller as the device pointer with the namespace ID appended
>as a suffix, producing:
>
>  /pci@i0cf8/pci1b36,0010@4/namespace@1,0
>
>This is how the controller-level bootindex works.
>Explicit nvme-ns devices instead register the nvme-ns device itself,
>which is wrong: realize() reparents the namespace onto the NVMe subsystem
>bus, disconnecting it from the controller in the bus hierarchy.
>qdev_get_fw_dev_path() therefore produces a path without the controller's
>address:
>
>  /nvme-ns/namespace@1,0
>
>Fix by re-registering in realize(), once the controller and final nsid
>are known, using the controller as the device pointer with the namespace
>suffix. The old entry (registered against the nvme-ns device) must be
>removed first since add_boot_device_path() only removes entries matching
>the same device pointer, and leaving both would cause a
>duplicate-bootindex error.
>
>device_add_bootindex_property() cannot be called in realize() because
>QEMU parses command-line properties before realize() runs, so the
>bootindex property must exist by instance_init() time. The final nsid is
>not yet known then either as it's assigned in realize().
>
>The fix is restricted to non-shared namespaces: for shared namespaces
>there is no single controller to register the boot path against.
>
>Also add the symmetric unrealize() cleanup so that hot-unplugging a
>non-shared nvme-ns with a bootindex removes the fw_boot_order entry that
>was registered against the controller in realize().
>
>Reported-by: Gerd Hoffmann <kraxel@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> hw/nvme/ns.c | 21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>
>diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
>index 7f0f9ac766..83786b4401 100644
>--- a/hw/nvme/ns.c
>+++ b/hw/nvme/ns.c
>@@ -727,6 +727,10 @@ static void nvme_ns_unrealize(DeviceState *dev)
>     nvme_ns_shutdown(ns);
>     nvme_ns_cleanup(ns);
>
>+    if (!ns->params.shared && ns->bootindex >= 0) {
>+        del_boot_device_path(DEVICE(ns->ctrl), ns->bootindex_suffix);
>+    }
>+
>     /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[nsid]. */
>     if (subsys && nsid && subsys->namespaces[nsid] == ns) {
>         subsys->namespaces[nsid] = NULL;
>@@ -891,6 +895,19 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
>
>     if (!ns->params.shared) {
>         ns->ctrl = n;
>+
>+        /*
>+         * Register the boot device path using the NVMe controller
>+         * so the OFW path includes the controller's PCI address:
>+         *   /pci@i0cf8/pci1b36,0010@<slot>,0/namespace@<nsid>,0
>+         */
>+        if (ns->bootindex >= 0) {
>+            del_boot_device_path(dev, NULL);
>+            snprintf(ns->bootindex_suffix, sizeof(ns->bootindex_suffix),
>+                     "/namespace@%" PRIu32 ",0", nsid);
>+            add_boot_device_path(ns->bootindex, DEVICE(n),
>+                                 ns->bootindex_suffix);
>+        }
>     }
> }
>
>@@ -1117,10 +1134,8 @@ static void nvme_ns_instance_init(Object *obj)
> {
>     NvmeNamespace *ns = NVME_NS(obj);
>
>-    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params.nsid);
>-
>     device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
>-                                  ns->bootindex_suffix, DEVICE(obj));
>+                                  NULL, DEVICE(obj));
> }
>
> static const TypeInfo nvme_ns_info = {
>
>---
>base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
>change-id: 20260818-fix_nvme-d8cfaa3368c9
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>

Ping :)

I see this patch hasn't been queued/pulled yet.

Thanks,
Luigi


