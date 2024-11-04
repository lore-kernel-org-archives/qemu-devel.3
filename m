Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D14D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Gp-0003N6-Lc; Mon, 04 Nov 2024 16:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gl-0003Ln-K4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gk-0005Gg-6u
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1W8qMTzmc/wmoX2fFpOYJHtHzp6CM0hX7vN3XVw4RY=;
 b=TBJU2hEVWI0aZpSJ10KLHN4GuQWuGjQpC52uVwJmUBpyM/X2gOLRC257ENjEQK3nKawXD8
 2pX0RZldLxQjhjS+b8+hy2mjdTtqMtnSDrdJ8JDcqexod8/Q+5mmcZluIXgyX9PzrUv1f8
 cuqdEir0DJz0lZQPIIqKl/ye72TXwvM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-KZDCv5jtPUGkWF8uWlGUKA-1; Mon, 04 Nov 2024 16:05:47 -0500
X-MC-Unique: KZDCv5jtPUGkWF8uWlGUKA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c947d9afc9so3584620a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754346; x=1731359146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1W8qMTzmc/wmoX2fFpOYJHtHzp6CM0hX7vN3XVw4RY=;
 b=UrnSRgGkY9BKorz5vl7TuZd+dSUXQ5ulcrOVDhoArf0kGWMHv5A+dzCqUI+mHsUrz2
 pYQGnJKVGnytmHNTR55Cq0IEaR1fDi8apHtaUXe5Iqpo4BmyRLeyF/XozIgZ0tNVy0XB
 QqexBxakNZKTrTsoYLh1tDuLLAMtxvRJQIuwi8VKgbAzrQlExG+6TJhRszLJQOXiNXag
 K9w8mDvuGdDQs38e1ty3Cq3EIAhWfUcf1ntXJbKGyaysFFjcnTU6/dVlPVTq9S/1wdWI
 NfZQKOzCXUUd0OR78/Hrp61KgBASy6+uBDJ5pwQnN9hCYqven03gvrrZqTgdFt8iWgAE
 Cr4w==
X-Gm-Message-State: AOJu0YzIFkK/T8DYlTXSxC//JrlZbzuOxZh1jAxjwH9g8boYGyugtJhv
 DbHlaEGawrKayPeKf8VEFSYqcqo9Y0ILhfHeLBOofYbdVd6PVYJb7e5KCwHchUyWzS7O/scl4OQ
 ecuMrgIsCocgwir6JeSIkKAx6FJnjnaw8CodDw2ANSooWmyahCBX0hx1RjK+iCAgqVrX7j822kM
 3BEHevGq5LVcjO/+Thnig+oFrB/HYr3A==
X-Received: by 2002:a05:6402:34d1:b0:5c9:6ae4:332e with SMTP id
 4fb4d7f45d1cf-5cea967a284mr14175965a12.8.1730754344190; 
 Mon, 04 Nov 2024 13:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEimZNn07o87EOuLe5muomRglOfncRjDqVqInm7Zg0iTEpVIJLheUmlDyDhrLLR0D5buExIzA==
X-Received: by 2002:a05:6402:34d1:b0:5c9:6ae4:332e with SMTP id
 4fb4d7f45d1cf-5cea967a284mr14175903a12.8.1730754342188; 
 Mon, 04 Nov 2024 13:05:42 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6b0fac0sm293771a12.79.2024.11.04.13.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:41 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ankit Agrawal <ankita@nvidia.com>, Igor Mammedov <imammedo@redhat.com>,
 "Huang, Ying" <ying.huang@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: [PULL 04/65] hw/acpi/GI: Fix trivial parameter alignment issue.
Message-ID: <dc55a90e295e05b6246b0b152a854612467e417f.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Before making additional modification, tidy up this misleading indentation.

Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/acpi_generic_initiator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 3d2b567999..4a02c19468 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -133,7 +133,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 
     dev_handle.segment = 0;
     dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                               pci_dev->devfn);
+                                   pci_dev->devfn);
 
     build_srat_generic_pci_initiator_affinity(table_data,
                                               gi->node, &dev_handle);
-- 
MST


