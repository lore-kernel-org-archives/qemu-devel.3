Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B44DC48BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDw-0002Cy-AR; Wed, 14 Feb 2024 06:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDu-00023J-VP
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDt-0006tE-3f
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vU/FdZML6DqnPVTmQt+IGMJCQ6FBN1LoDWvbCySz6NY=;
 b=Y6ioUhoKeQnylojVzZPfAru+lgoRH691ojeDwhtLNKTAxjpduUjgSHxE83z8kfT5TY4o6I
 gQFrDrEjxWZTERCVJM5cP9DtQuQZrtb/3Tt/DCKIrckcmT3xFsoWXff/r/OqpdHw8tT75e
 eTKx8ak9mhvVmPsv5tIsY186MwpZlK0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-A4d6Ix4JOVGZpYwsRkUo9g-1; Wed, 14 Feb 2024 06:14:39 -0500
X-MC-Unique: A4d6Ix4JOVGZpYwsRkUo9g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3d4881bcf5so30795166b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909277; x=1708514077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU/FdZML6DqnPVTmQt+IGMJCQ6FBN1LoDWvbCySz6NY=;
 b=GHiUl/3rE2bswuMgZ64/3T8TFvx+MGXXr+YSB+vnpLTqE4R5voFtDihphBhk+d274H
 YgTpSaX6qF+ysyuPzPWsu9P5XZmr6IYq4/ZkaIbqJsOYvE0wINeyfo+nZ9yZStV4+h1D
 oFwSxmih0hDJSY75elGzrLWSHnuodJGfKKNldKuo9B2R49FKzdd7lG7eVCpmzmkOTu1v
 FGbBAgOxR0WppCUHX94wUFzjlubY9+3VYB01DJ9WYiSN+OvWcn/3Ynnvrh+8GSR1K2C7
 aMGsH33X4c5GiY6t7Wxtdib8zxKc0luy8hED/80LZpDprDMt68BoPMzOlnFR4n5+ICA9
 v2Wg==
X-Gm-Message-State: AOJu0YwXAu+dB/k+qEVRaDp3qhbfDsEP8GLhXeOU8t1QFOKzQoSXaJqe
 DHOop3eQAQsSY2hO55Wwmb8sPhH7T5W6yRU6Y5DIzFdkqG1dk0xm3MHlv5z98+imLTFESUPT/sZ
 NjZ7GS4EMgLKHrFGWXjo0gd4YSXb9T7m8h1zXC3R4eaWgwWgUQSqNLbu6+yCWkZ12kdWA50vKCo
 RCBSflbi/v+eU0EKAQbxzs6TeSbbth2Q==
X-Received: by 2002:a17:906:f10a:b0:a38:1e54:91d7 with SMTP id
 gv10-20020a170906f10a00b00a381e5491d7mr1526239ejb.56.1707909277451; 
 Wed, 14 Feb 2024 03:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFtPhGzWEUddikie8HWtYEMTgNxvRUm4eZsC0Q1VLwVE43uufPxpTdoyZ2gbOKOj+b70EMOw==
X-Received: by 2002:a17:906:f10a:b0:a38:1e54:91d7 with SMTP id
 gv10-20020a170906f10a00b00a381e5491d7mr1526218ejb.56.1707909277058; 
 Wed, 14 Feb 2024 03:14:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXXjXx0XyAXLEFe0Zh5fb9GSpChGhIPxYmW7UY6Ed6F4WS4tidh5vIt2zvTYnmQ1dp/b4XZCHNTxUyZX+U5pvUHlrVXa1xxDpbPYaVPpvxS8KgG38Mi11xoaT5UIGqTtt8Nz1V+g7CdRMDAiFjK7eUcIWvONbkRV3wG8K+BABKodryxNoehyDyjyI5bvEbv
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ss3-20020a170907c00300b00a3d11908bbcsm1320430ejc.203.2024.02.14.03.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:36 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/60] exec/ioport: Resolve redundant .base attribute in
 struct MemoryRegionPortio
Message-ID: <4edee342f81397e8938ba7a80d1908c5103b66c8.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

portio_list_add_1() creates a MemoryRegionPortioList instance which holds a
MemoryRegion `mr` and an array of MemoryRegionPortio elements named `ports`.
Each element in the array gets assigned the same value for its .base attribute.
The same value also ends up as the .addr attribute of `mr` due to the
memory_region_add_subregion() call. This means that all .base attributes are
the same as `mr.addr`.

The only usages of MemoryRegionPortio::base were in portio_read() and
portio_write(). Both functions get above MemoryRegionPortioList as their
opaque parameter. In both cases find_portio() can only return one of the
MemoryRegionPortio elements of the `ports` array. Due to above observation any
element will have the same .base value equal to `mr.addr` which is also
accessible.

Hence, `mrpio->mr.addr` is equivalent to `mrp->base` and
MemoryRegionPortio::base is redundant and can be removed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240114123911.4877-5-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/ioport.h |  1 -
 system/ioport.c       | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index e34f668998..95f1dc30d0 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -35,7 +35,6 @@ typedef struct MemoryRegionPortio {
     unsigned size;
     uint32_t (*read)(void *opaque, uint32_t address);
     void (*write)(void *opaque, uint32_t address, uint32_t data);
-    uint32_t base; /* private field */
 } MemoryRegionPortio;
 
 #define PORTIO_END_OF_LIST() { }
diff --git a/system/ioport.c b/system/ioport.c
index 1824aa808c..a59e58b716 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -181,13 +181,13 @@ static uint64_t portio_read(void *opaque, hwaddr addr, unsigned size)
 
     data = ((uint64_t)1 << (size * 8)) - 1;
     if (mrp) {
-        data = mrp->read(mrpio->portio_opaque, mrp->base + addr);
+        data = mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr);
     } else if (size == 2) {
         mrp = find_portio(mrpio, addr, 1, false);
         if (mrp) {
-            data = mrp->read(mrpio->portio_opaque, mrp->base + addr);
+            data = mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr);
             if (addr + 1 < mrp->offset + mrp->len) {
-                data |= mrp->read(mrpio->portio_opaque, mrp->base + addr + 1) << 8;
+                data |= mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr + 1) << 8;
             } else {
                 data |= 0xff00;
             }
@@ -203,13 +203,13 @@ static void portio_write(void *opaque, hwaddr addr, uint64_t data,
     const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, true);
 
     if (mrp) {
-        mrp->write(mrpio->portio_opaque, mrp->base + addr, data);
+        mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr, data);
     } else if (size == 2) {
         mrp = find_portio(mrpio, addr, 1, true);
         if (mrp) {
-            mrp->write(mrpio->portio_opaque, mrp->base + addr, data & 0xff);
+            mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr, data & 0xff);
             if (addr + 1 < mrp->offset + mrp->len) {
-                mrp->write(mrpio->portio_opaque, mrp->base + addr + 1, data >> 8);
+                mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr + 1, data >> 8);
             }
         }
     }
@@ -244,7 +244,6 @@ static void portio_list_add_1(PortioList *piolist,
     /* Adjust the offsets to all be zero-based for the region.  */
     for (i = 0; i < count; ++i) {
         mrpio->ports[i].offset -= off_low;
-        mrpio->ports[i].base = start + off_low;
     }
 
     /*
-- 
MST


