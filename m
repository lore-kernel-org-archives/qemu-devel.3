Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D13DC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFI-0005Qd-Ez; Wed, 14 Feb 2024 06:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEq-0004pw-W8
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEp-0007Gw-Br
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qucpWaRpKGw+aISNv+x3UhQU62lbgVkDGnj9pzduH7o=;
 b=VuQnS6sfOVjP60FhF884l0uUkf//vU2EOL1to927x25QuqTv7RpQn068DUx8yCZEyi4GGI
 NoDAhcFuwlgDjuJMfGEZpT5HBR3P85rR//v7RnYgO2/NpwVaFh76sxfT51RSOXh7c0/lUE
 j3LzKMdygO2JVkvnIwjss+V0qCqPVNI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-3IMhYaHgMQWPeKH9WrdUpw-1; Wed, 14 Feb 2024 06:15:37 -0500
X-MC-Unique: 3IMhYaHgMQWPeKH9WrdUpw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-560127ce17fso2751782a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909336; x=1708514136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qucpWaRpKGw+aISNv+x3UhQU62lbgVkDGnj9pzduH7o=;
 b=lhfqsjfD4CHb3wuasx2K6UhiaT6jB3uzgLZkuyA+mOm0WVDP2K0xVQHf4nXmeIpG7j
 t66TgfRmOqexPmRt2kLR4JOTdi9EEf1zvlY4UzAGyzdIqKcwyQGDUDFXQkhFp4N05o5Y
 yrn1Rze68Kntnxh8vCZHp+3UgtvSfU7hIZXTnmzHKyLXRSznY1PO+5oH7WZ3LxurlwiQ
 xmZ9UxCVMrOe7Z+YWWYjuUWUQvH4+Z6Je2DNOCaoqfZuVecImyIt6v4mxZL0+iR18ZQM
 e00wZAWYT1qjyMGrR0UIEzFBb/eYqTsmNqgljxzLbq1KfE3upXh0Q1MQ2eW8HBqxvF8h
 HVoA==
X-Gm-Message-State: AOJu0Yxs7VeiENWFafhyrUEaEMngrSoGbwcUyXcy8uxnhHj3E/9Knwuf
 6EyYhUiK1jxXALPlhwdpWTiYzSYQNnhM5z0uX2um5JhK5y5oJK0pQbv0SKXFOjG2yi3fyl3w5iQ
 cUDAFFV5PlCg7iTnysDnSypeHBfwlQ+1NPsfulSiJhEYuEWEugnILaysJLoLY0DogjEMJ/Kh9Cw
 s4e+DbXjVWA1JkvjP2oVZUhMZ77ztq9g==
X-Received: by 2002:aa7:d8d7:0:b0:55f:6a35:b541 with SMTP id
 k23-20020aa7d8d7000000b0055f6a35b541mr1960135eds.14.1707909335786; 
 Wed, 14 Feb 2024 03:15:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR26JdICMobyiH7k7PziaOg3yh9jHZQxoX7Fr+dnGQDLn6sgk9oREmpK3gdBrNLJ94LJhbvg==
X-Received: by 2002:aa7:d8d7:0:b0:55f:6a35:b541 with SMTP id
 k23-20020aa7d8d7000000b0055f6a35b541mr1960118eds.14.1707909335487; 
 Wed, 14 Feb 2024 03:15:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCEo9Okp/nS/XZGupRXP/lR0KSDFKGrKCzsQTzj57gSV9aKsMLT0oSLw+fKfTBIPA7SExD8Lue3MGjO0c/359dYWuk64Tn675ONuqEL2XYJY9hrIDs5WKTBeaYg8/8mOAwmx6xfR3CRnCtLinRTQ3cUa3P6l7y
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 g34-20020a056402322200b0056384b26771sm307550eda.91.2024.02.14.03.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:34 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 43/60] hw/cxl: Pass CXLComponentState to cache_mem_ops
Message-ID: <729d45a6af06753d3e330f589c248fe9687c5cd5.1707909001.git.mst@redhat.com>
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

From: Li Zhijian <lizhijian@fujitsu.com>

cache_mem_ops.{read,write}() interprets opaque as
CXLComponentState(cxl_cstate) instead of ComponentRegisters(cregs).

Fortunately, cregs is the first member of cxl_cstate, so their values are
the same.

Fixes: 9e58f52d3f8 ("hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)")
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-8-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 29d477492b..9dfde6c0b3 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -199,7 +199,7 @@ void cxl_component_register_block_init(Object *obj,
     /* io registers controls link which we don't care about in QEMU */
     memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
                           CXL2_COMPONENT_IO_REGION_SIZE);
-    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
+    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
 
     memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);
-- 
MST


