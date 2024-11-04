Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2442D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84HR-0004i7-Fl; Mon, 04 Nov 2024 16:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HQ-0004eP-Gd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HO-0005Jj-Gt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0uhS2hkjfzMF9odNW6FeM9PeY7E/hPIzXL+GkcXz8Q=;
 b=ahebj2IOzCIL4MeIYw2Gy+Kxw/H6+0ERFccW43r12DKmiCa98VrQiKUxW8lsDfxYkEvwQ2
 G1j9rGJ7cfXwHV7D/CSO+mBI8iU69qB3eMe0UYlgj7X/7oXAHPPH4z+ewLSA+ucgcz5XT9
 wYkdB8/0pZej93eail4CR6gawK6UquI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-EuztRBwvMY2UHozMTYlKWQ-1; Mon, 04 Nov 2024 16:06:28 -0500
X-MC-Unique: EuztRBwvMY2UHozMTYlKWQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so27531785e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754387; x=1731359187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0uhS2hkjfzMF9odNW6FeM9PeY7E/hPIzXL+GkcXz8Q=;
 b=daIYhpKnlVWk0cykYyYrAIQOduYHbuwi7w0jCV+dj2TaVpQGuk+B9zj18e6vaZYb84
 gIJAHoEQUmBmMFMBgFvvUNkiQ6WltOafnac2oul8J9Pgy+swl9ZSN9bmEUu1Zmz5NyQl
 OjExLe+26kyl8uCVEhTEgOinF/NGxlmWEU3Si5b9b4bzzqgZHWzWyMXr7blxt+/HGXGg
 OgyItPddnPyi+bF/iyDkZaguO/66n2IXFyWvURGvFuoy7fXWS95x1uSW8SWD4nyOgyEL
 VnX0m2uyvOFx7c2JREHFubyBUQMW6ebZkBUoVWrDXK9z2HasWPAZIU7es2zje+3ScOOg
 ekOg==
X-Gm-Message-State: AOJu0Yz+Tb/t7OiKTHMKd+S+LnCBqMyb1AZZdzXEVuRicIbBPmZAMimq
 CwIoz05WT8dmWGKWs2BWb1EyK/KonjMeLxDa1Fwzm6YYyv1RQihGJr1+MI8ofVELQHZrxJSFP8D
 L+nfTTnDy0qYgx4DvEJq+SfTfBFoczjSmRTfO27zF6AuVFIDF/QQewiLO85Zrfy+rc0pVwCNXkX
 q6RpGQju4F4mplpddQ/wBFNjeLAdmx3w==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id
 5b1f17b1804b1-431bb99053bmr214908565e9.17.1730754386672; 
 Mon, 04 Nov 2024 13:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVTtiklzyTJrDLccgRW3ibAwEn75Ctz2tX9K5IR6uLXhhLZt/aojafCisItrOEI+UXHKxqXA==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id
 5b1f17b1804b1-431bb99053bmr214908065e9.17.1730754385290; 
 Mon, 04 Nov 2024 13:06:25 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca704sm194483875e9.41.2024.11.04.13.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:24 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/65] hw/acpi: Make storage of node id uint32_t to reduce
 fragility
Message-ID: <cf2181aef23e7f145e8fe7b8395694d32b115ae5.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

>From review of generic port introduction.

The value is handled as a uint32_t so store it in that type.
The value cannot in reality exceed MAX_NODES which is currently
128 but if the types are matched there is no need to rely on that
restriction.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916174237.1843213-1-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h | 2 +-
 hw/acpi/aml-build.c         | 2 +-
 hw/acpi/pci.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 47a4692a7d..4fd5da49e7 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -486,7 +486,7 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-void build_srat_pci_generic_initiator(GArray *table_data, int node,
+void build_srat_pci_generic_initiator(GArray *table_data, uint32_t node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 7a06ffec5a..6a76626177 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1972,7 +1972,7 @@ static void build_append_srat_acpi_device_handle(GArray *table_data,
  * 5.2.16.6 Generic Initiator Affinity Structure
  *    With PCI Device Handle.
  */
-void build_srat_pci_generic_initiator(GArray *table_data, int node,
+void build_srat_pci_generic_initiator(GArray *table_data, uint32_t node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn)
 {
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index d7a0e91f01..a4835ce563 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -72,7 +72,7 @@ typedef struct AcpiGenericInitiator {
 
     /* public */
     char *pci_dev;
-    uint16_t node;
+    uint32_t node;
 } AcpiGenericInitiator;
 
 typedef struct AcpiGenericInitiatorClass {
-- 
MST


