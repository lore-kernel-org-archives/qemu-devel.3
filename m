Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC94D6ACD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIZW-0006w1-FK; Wed, 27 Nov 2024 08:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIZT-0006vO-Ct
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIZP-00084u-WB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mZYQc/0Beq9quMGIXTqw5aSICjDsmWEiV1q8R4CPFA=;
 b=FIxAq9OgEItPDA9C+znYRYVXNPGPY8VRnal19lMoGlaBXERzHbnIaOMVWmC0ZvsJ7uEfsx
 RDhxDle9gRnolDjoquayA8YduWAuRPXkLmV0jYGvTUE6rp5F20c7ZruIxIWwGJmaTrNkXR
 3F1bOy8NhOGDOsXGspU0PqoAqjryL/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-piJIlEVBMraM6AiKnoUdlw-1; Wed, 27 Nov 2024 08:57:54 -0500
X-MC-Unique: piJIlEVBMraM6AiKnoUdlw-1
X-Mimecast-MFC-AGG-ID: piJIlEVBMraM6AiKnoUdlw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3824395a677so3621017f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715872; x=1733320672;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7mZYQc/0Beq9quMGIXTqw5aSICjDsmWEiV1q8R4CPFA=;
 b=IrHOn5Z0R81K0U1jM2HXSINzqtAxIvnSkMOo8dXXZn5oUJMncXk39LskJxyNelrv8U
 PEVMhUCj+EelDpLLHCEzdxY5nY+CJqjPhDv2BmYcQmCC5WuUjWBI1c4meYRgu8v5E3uI
 0z9wde/TRlV3wXJvEvMW6Wv6DArekR3Bc/MpYTaBy/cg0qTy9hBaWjwMvH9a/6rqEj/V
 P6LZ1vA6iYgnTNZB1Zid7Y8K+gg0D8/6aOKqVhrzD5l2vZbvJYHjz3K4lNB3xohztG0U
 30m2UkjYANtvx+iDqLWQUCeVfZlTe3N/KgVenb1pGR0A5Bkryg2XlKq1rztocTAb7mas
 ec5w==
X-Gm-Message-State: AOJu0Yz4o78nfMF8umUi4Gr666lu18c5AIH851K3SR9JP/ZX5ZTdYkBh
 lG5qQj5K6FrYEA2G20S52kMSZFCO0SVxZbhJdUUije9NcTygLJpYCyKjPlEw+l/UZuTVCkRqi96
 sJ3bqpOwIax6GVxGRpnSLMEtZ9Pi68iIkJfgQoud6nYclavqGG+LcHioeGiHRj29l0sRaxVNoBP
 Mmmibl0bvSj68k9wJqMq2W/s52Tgw4fkWg
X-Gm-Gg: ASbGncuBC7mrvGFxEoSjvYAb9CPNTRWSLCs4Eqa0ZNEuIiHG01KPAgnvoGgf2ZaiDkt
 ZVh0JVghUng4wOHozdLuDl7NY9AsIBf9FkfNwkBtlEYl/TEBEwuMNbO/1VzdD7wWFHgQiO6o71/
 dRTdojv26e/I5iEY8Z0yDqBkbc1QHmPHQya5flliNJ3k7OLoQzMxOGRpx8SaGpugVi4pn/ZB7kq
 jzUGNtUYd+CciO0hpGcSBlW9igXpksyXRl3/5F1tXog
X-Received: by 2002:a05:6000:1545:b0:382:4804:27e4 with SMTP id
 ffacd0b85a97d-385c6ec0fa6mr2321483f8f.35.1732715872183; 
 Wed, 27 Nov 2024 05:57:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi3DXzRF9BpFMwyjTFSlr1FNlAAUH95J4n+5FAsT/XzxwAzNKKlX+y6JVEu6N85cEIwgNYsA==
X-Received: by 2002:a05:6000:1545:b0:382:4804:27e4 with SMTP id
 ffacd0b85a97d-385c6ec0fa6mr2321453f8f.35.1732715871787; 
 Wed, 27 Nov 2024 05:57:51 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad627bsm16397555f8f.12.2024.11.27.05.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:51 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 08/13] hw/acpi: Fix size of HID in
 build_append_srat_acpi_device_handle()
Message-ID: <13a4a6ba2bfd3cf9bd34a015929d93868d792de8.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The size should always be 8 so hard code that. By coincidience the
incorrect use of sizeof(char *) is 8 on 64 bit hosts, but was caught
by CI testing with i686 as the host.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Closes: https://lore.kernel.org/qemu-devel/20241104110025-mutt-send-email-mst@kernel.org/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241107123446.902801-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/aml-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6a76626177..72282b173e 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1960,7 +1960,7 @@ static void build_append_srat_acpi_device_handle(GArray *table_data,
 {
     assert(strlen(hid) == 8);
     /* Device Handle - ACPI */
-    for (int i = 0; i < sizeof(hid); i++) {
+    for (int i = 0; i < 8; i++) {
         build_append_int_noprefix(table_data, hid[i], 1);
     }
     build_append_int_noprefix(table_data, uid, 4);
-- 
MST


