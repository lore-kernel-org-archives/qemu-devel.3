Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9265C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rL-0002Rm-Da; Wed, 15 Jan 2025 13:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qZ-0007p6-MP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qQ-0006yB-6Z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nNCQTJMj4OnBLKxpitjAPWJHtAleMdi6j3FINftfiXk=;
 b=fxlwx77/0EZzMIszSx8Dkwltp/zyD8BADeXZ3D1Uy5ewIYglQeO169QRVWU4kKbF8pnAxY
 73X8KJTPlI+7e3ON8TerVg3x89aA4d3kGJY6Lpiolmtb4cRBYdK9F/z58eeyvDGdDftz89
 yLlj/+gBp7qsaBkPliHfPQdlEgVHnxU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-dcoULRrsOc69CWWAByR-Xw-1; Wed, 15 Jan 2025 13:10:15 -0500
X-MC-Unique: dcoULRrsOc69CWWAByR-Xw-1
X-Mimecast-MFC-AGG-ID: dcoULRrsOc69CWWAByR-Xw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso37156285e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964612; x=1737569412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNCQTJMj4OnBLKxpitjAPWJHtAleMdi6j3FINftfiXk=;
 b=JLRNU5v4PVKsI/d/WZQiNBxJGP70fEGE1jkLjAn7KAUWh0wpu8NMlj0klvHOPEhZzt
 JpBohTT0axFtn5+BL7vCZjfVe/9cQG2eS0LjeXt8LFFOW61/pg4Q3esPSmQnLx9+xAFI
 kmU7QsABXvKdno7EKeUs5YLV1SrOqKn7mJ3vsErRRwE1nbNIAIjNf17A65opEKUv6ksn
 CZLlo1+kJC0ovUS1vSqDMqYp9QE1udtwNQx0LEApsxOZC3BElcriTiQZnwTWg54Smmfs
 +u/RqpZQq8dq8isgI8hIpOiOUko7o3ArT5GnUm58RFWLfcTschAUzg1wVXJAtuQgN/bN
 8EoQ==
X-Gm-Message-State: AOJu0YwVZxeeXJWmZnjD+3XjWYB5+nYqspRdxczptu35+h+u+vaE8GXZ
 RsYi7Q5XCegO1RBlJ5OpziBnNCuIbIw7mzzVTlB8wS3liQ9ihQPJeYcAYOPQq/+4/ka2jLxTGLN
 zwMnoYxEHFe0RZQPyaQgwhXTNSiC1c1TPxgGCXy7AzEUVTemfrElgzT30p4DpBaE1OEd/BXSG3f
 W8X6YZSJTTZyRENi3bkCyhsQhePH8GXA==
X-Gm-Gg: ASbGncvPg+kghvMxlNcSPybHnE3MiCLMyRbg5Sm4QZ72ZrtsOQY6tZ9EiRJ5qrP0jcY
 gSEo74uzTYR1V52B1Bnu7Ww6l9ffVmDDHylgg/Bqt6Uvds7F7mMWoOkqecN9xTveIDPMQNTZC5s
 sMvs1o9dwMtE25w50LobHEsg5Q4DUIuWbzhHv1V6XrUSE6osfO+MCfrsLcTbBmj1RAyfyfW4ih6
 EQW9Su0mpoytUifW+qSXJ5BvDNAJFdPtKKn5I8kaFoYPC0W/PSR
X-Received: by 2002:a05:600c:5848:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-436f3f695dfmr167973665e9.8.1736964612487; 
 Wed, 15 Jan 2025 10:10:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV46TI7HwfO5eWkYLJBkPwa/M9YdVixF6Y5Bp6YecEEoS2GtwDpfNkYNNnXrH6neGe9zA2VQ==
X-Received: by 2002:a05:600c:5848:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-436f3f695dfmr167973375e9.8.1736964612070; 
 Wed, 15 Jan 2025 10:10:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7540ae7sm31006215e9.33.2025.01.15.10.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:11 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 32/48] acpi/ghes: Remove a duplicated out of bounds check
Message-ID: <4ffedca347c458db17c464f9329222403fe54f22.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

acpi_ghes_record_errors() has an assert() at the beginning
to ensure that source_id will be lower than
ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <df33b004d85b7b9aa388fb2ac530dcdea94b7edc.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 29cd7e4d81..5f67322bf0 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -404,9 +404,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
         return -1;
     }
 
-    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-        start_addr += source_id * sizeof(uint64_t);
-    }
+    start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
                              sizeof(error_block_addr));
-- 
MST


