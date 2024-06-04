Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFF1C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVn-00046b-GC; Tue, 04 Jun 2024 15:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVl-0003t1-PQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVk-0000yM-1k
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYKkp6fHZoal2oiYNWaG4icBm491Zje1r86kUs5B3ls=;
 b=XfXwZ100Apolfa/+2FbEmJDAseq2wxX/d4QQLPhj/NycyKA9MNcGDHIZzqdCdSg0fVLGf+
 jIR77U38amHlXNSgVS56PYpzJONeQfmhNx6RrB7JKu97VQOegSs9xV3Fh3Py2o2xFe9Mbq
 xR4mG0XYBxoURJhXtGFNNOryFkPWSYg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-pV7sq-qvPgi-46Mjr1hTQA-1; Tue, 04 Jun 2024 15:07:53 -0400
X-MC-Unique: pV7sq-qvPgi-46Mjr1hTQA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42156093037so1611705e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528072; x=1718132872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYKkp6fHZoal2oiYNWaG4icBm491Zje1r86kUs5B3ls=;
 b=MVpXi/2o8KlFgpXkxOi4elKTEIPpsS2eyDL6b0rw2ST9SAlSsl7ythI3LekDy7plJj
 9c5fQ+g7v8tBAvFl9i8ulFcRqZWY8N3pSCcuSXKgM0EKHZkylDBG/PSSIad2ffWdVD5h
 e/ST9jerx2bxE6eKaD1MkBilg/bIRnLD3HvlQeQ51gYTL7MsjEnx/cZ1Fi9nLeDueuqH
 YCLqk/FwTt+sa5aOl1WWFmWQwSgkdx3RR3gml2SL0L/PkTB2/1jIS7Nf/G1ILg1K/g2k
 chq8nnIKuuYc1ouVGdG1PjYH2IjRT4i5JagkeXUhpM/IEAXUCe9PvI4afOljft/aYZig
 cYrg==
X-Gm-Message-State: AOJu0Yz+ePJVhTm7ZurVYe6bMJ94puVA/NKdVJ9nTx80gVE9iIdkQRhk
 2eOXSVX3He/12iqHeklTbLE0Q9kJ/cQ/A+kpjMXZ08jD8qLJS4+rlULMCT6aNk9MueNj0G3FutU
 HmJXDIHGthj4eghfNiYQYqaQaZNa0AxeB4nIazfc/0g1AaRUOUzjpd/c9AaaZ1Rz0UcELc3q0Jy
 9S775KJETvz2Qw7Kg8tNNXOurDaHCRDQ==
X-Received: by 2002:a05:600c:1da3:b0:419:f9ae:e50 with SMTP id
 5b1f17b1804b1-4215634dba3mr3428745e9.37.1717528072159; 
 Tue, 04 Jun 2024 12:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtmf1otv2cfBpSc0kN/2tPZPOjIDE3hj4mgg2t9VZw5P52wHDeIYV7CndRteKV44ug4AObAg==
X-Received: by 2002:a05:600c:1da3:b0:419:f9ae:e50 with SMTP id
 5b1f17b1804b1-4215634dba3mr3428565e9.37.1717528071749; 
 Tue, 04 Jun 2024 12:07:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ed8b574e3sm52528f8f.79.2024.06.04.12.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:51 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ankit Agrawal <ankita@nvidia.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: [PULL 31/46] hw/acpi/GI: Fix trivial parameter alignment issue.
Message-ID: <481a30a72769a5086a0596fb6ebe19d16d2bac77.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Before making additional modification, tidy up this misleading indentation.

Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240524100507.32106-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/acpi_generic_initiator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 17b9a052f5..18a939b0e5 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -132,7 +132,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 
     dev_handle.segment = 0;
     dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                               pci_dev->devfn);
+                                   pci_dev->devfn);
 
     build_srat_generic_pci_initiator_affinity(table_data,
                                               gi->node, &dev_handle);
-- 
MST


