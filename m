Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B887EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBb-0007Jn-0e; Tue, 23 Jul 2024 06:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBG-0006oD-Cf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBD-0001ax-Uk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdw2m0bn75zRr+MYU0d0hXAq7eMAE3t8pjHbmVXVlwk=;
 b=QGgj0xe2DGn8fLx9iWON/KekDYKdvkpKVXBQfoyM5XfZ3fZRKc22WB/4NOEwDTFW+pFV2j
 ZuEXatD8nZlwkYSlYg/BMdIVSiet/wiU8SfeVPFptjPNJy3e3LkXt32zUoyEOGpuIw0/Zq
 OQWEV/4GcOVUsjdYq6EqNftpVlRGyKI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-CO8eQNS-MTeeNydjN4nA9Q-1; Tue, 23 Jul 2024 06:55:35 -0400
X-MC-Unique: CO8eQNS-MTeeNydjN4nA9Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5aa4fd656e0so105804a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732134; x=1722336934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdw2m0bn75zRr+MYU0d0hXAq7eMAE3t8pjHbmVXVlwk=;
 b=kiOAKLzOV5T5UPUVkjS0ZNEWRtrSo6H1/4hx6qLkIinnsfwuQs+CkBvoAY/g84MHi4
 X9/lTi7Rqo/4exskfDjLifYJXEdao5VdjvVH67Oh243IB0/l/6Lyxgj9pG7bDmQmsOEr
 jIw/vnOLM1ghjFU1/Z3LDGVMNS8xc8Oq73hfuOrdqEiQ9cNJ0a2JGwnDGh3El8u9Cgb0
 k5MPQMjPIzubkpbKa+/0OzFgEB3b+M2oPVNGkwoX1I6EnzACIri2JBN933XAN6Z9EaGy
 XIvwrD8Enlwpps4pDYkaWKozg2OCyVsN79hcPaQ0GiiYSMe0rWAq13zgpeL7EMHf60W1
 P4nw==
X-Gm-Message-State: AOJu0YwCorSf2s0x97y44o9GWuUJ63aI0HjwvQY2K0gA/+Ej994O9E1l
 s10GnWwqlBqjTaRtBpAZbZoLe6uVj0X0wlTcXvWbWIKFpMdGj32GHhKMdt3AYud5drJLqX2xKvD
 9s0PqZtdM0yr+dhkWOSvtTzoSmjl0XM3bI0PiYrgm8YgGmWnHHFreDkwg3JoNyTxaiw5lTBfjrl
 fqYdDhxL0GJvG9V8ELZw1Dn3Pg0JXYqQ==
X-Received: by 2002:a50:9547:0:b0:5a2:2b56:e08e with SMTP id
 4fb4d7f45d1cf-5a47ab1083cmr5315039a12.18.1721732133875; 
 Tue, 23 Jul 2024 03:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy2IYsDzghT6tDYN+/yi4O25vrabVfFyBuogGqJEfrU177uLbDmG+nKfG8u0imWjwgAfTniQ==
X-Received: by 2002:a50:9547:0:b0:5a2:2b56:e08e with SMTP id
 4fb4d7f45d1cf-5a47ab1083cmr5315008a12.18.1721732133289; 
 Tue, 23 Jul 2024 03:55:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30aaa2d48sm7347855a12.32.2024.07.23.03.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:32 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 04/61] hw/cxl: Check for multiple mappings of memory
 backends.
Message-ID: <9de2049c95e1a94e27430e71a9d9ace07ec8eda6.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Similar protection to that provided for -numa memdev=x
to make sure that memory used to back a type3 device is not also mapped
as normal RAM, or for multiple type3 devices.

This is an easy footgun to remove and seems multiple people have
run into it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705113956.941732-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 35ac59883a..e7fbbb4d51 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -737,6 +737,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "volatile memdev must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->hostvmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->hostvmem)));
+            return false;
+        }
         memory_region_set_nonvolatile(vmr, false);
         memory_region_set_enabled(vmr, true);
         host_memory_backend_set_mapped(ct3d->hostvmem, true);
@@ -760,6 +765,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "persistent memdev must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->hostpmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->hostpmem)));
+            return false;
+        }
         memory_region_set_nonvolatile(pmr, true);
         memory_region_set_enabled(pmr, true);
         host_memory_backend_set_mapped(ct3d->hostpmem, true);
@@ -790,6 +800,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             return false;
         }
 
+        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->dc.host_dc)));
+            return false;
+        }
         /*
          * Set DC regions as volatile for now, non-volatile support can
          * be added in the future if needed.
-- 
MST


