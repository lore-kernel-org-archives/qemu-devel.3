Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8CCD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84GZ-0003Hz-EY; Mon, 04 Nov 2024 16:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84GX-0003Hk-Hu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84GV-0005FZ-0P
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YX/D7B50whaD5dkmLdDqxAFvN13ZgCrMqMz4OxLbYGE=;
 b=Svqh8MSXJfXH6XrB02lF5NCJ7QK7L+ItsPa64bEbLiJNjgjVSBfG9Yq0oZRr8Wy+ewHX/D
 mgIeTrWgsj3hOso0xSdBv4Mom+LT8Kax3U9+wXl5wsJ3UU+9fTzsPuhYTeu2+akgh7i4Io
 Fuhr4Z1h4Hv/DYlGUr+pf46XWcr7U2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-jUoSB_MbMG6abDFILJwilg-1; Mon, 04 Nov 2024 16:05:33 -0500
X-MC-Unique: jUoSB_MbMG6abDFILJwilg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso27413185e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754329; x=1731359129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX/D7B50whaD5dkmLdDqxAFvN13ZgCrMqMz4OxLbYGE=;
 b=QXYRwmnRB72dmM/MV12wL5jwkccOYosyIkSBoWvsvTnQrJyYpMn7J7gO3je4Kmrlj0
 FSlMevu071XVo1qGXhM5gFEoiVsJ5tiyls3pspJSn2oXrMJhBMRJbWnE63cUWjT/DIin
 BBNxTpNR76O8ElMdQrlxO4RhyyY7lligltdZzE+PdRhPisFvjG+jFJHwKDZEeFl51sAb
 GKk7HdjD/vCDgy+WDH1cSXpt5FuS45T2HSOP+SUtG1CvffDp9YJtlnIv1pTEPr+PkplJ
 kxwJstL03u/Ir0mgCmMY84O+qMUn47S4oVlbYoHUcQ50Sm8iStKf9ySJYMcuS5TbLHOu
 +0zA==
X-Gm-Message-State: AOJu0YzhFrXp3d/myo7vNKgArvbdqTzL2CT5USdFomwtFAXLt/V/FvWs
 95OP9YtInKUtc9I//roybjkbqFv7T+3XN9o715/oQYCCnapvM+RJelMr3jv6sgF+Dgad+s3buLe
 zDpZjtYlmAYluE3Nl4/qiCQ7H1cunkpW7xZYcKMxQEIXodp5S7KOuEsTlZHhy4WE3DgvLEVuUV+
 lm1wF+Vt60daxiSR8GIkxkERs15xOrPA==
X-Received: by 2002:a05:600c:1c16:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-43282fd045cmr108612785e9.4.1730754329342; 
 Mon, 04 Nov 2024 13:05:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVy4H4cIYuDxC4yObC8bmA6ST6u2cVOuLmDa+7YZCS+pUfLWUQIbxbW6tOyqZto3q23IifpA==
X-Received: by 2002:a05:600c:1c16:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-43282fd045cmr108612495e9.4.1730754328849; 
 Mon, 04 Nov 2024 13:05:28 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf4fdsm163457735e9.17.2024.11.04.13.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:28 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 01/65] softmmu: Expand comments describing
 max_bounce_buffer_size
Message-ID: <c3ec57e495b032047ddfef2075792340c407532a.1730754238.git.mst@redhat.com>
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

From: Mattias Nissler <mnissler@rivosinc.com>

Clarify how the parameter gets configured and how it is used when
servicing DMA mapping requests targeting indirect memory regions.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Message-Id: <20240910213512.843130-1-mnissler@rivosinc.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h       | 9 ++++++++-
 include/hw/pci/pci_device.h | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e5e865d1a9..9458e2801d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1104,7 +1104,14 @@ struct AddressSpace {
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
-    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    /*
+     * Maximum DMA bounce buffer size used for indirect memory map requests.
+     * This limits the total size of bounce buffer allocations made for
+     * DMA requests to indirect memory regions within this AddressSpace. DMA
+     * requests that exceed the limit (e.g. due to overly large requested size
+     * or concurrent DMA requests having claimed too much buffer space) will be
+     * rejected and left to the caller to handle.
+     */
     size_t max_bounce_buffer_size;
     /* Total size of bounce buffers currently allocated, atomically accessed */
     size_t bounce_buffer_size;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 91df40f989..8eaf0d58bb 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -168,7 +168,11 @@ struct PCIDevice {
     char *failover_pair_id;
     uint32_t acpi_index;
 
-    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    /*
+     * Indirect DMA region bounce buffer size as configured for the device. This
+     * is a configuration parameter that is reflected into bus_master_as when
+     * realizing the device.
+     */
     uint32_t max_bounce_buffer_size;
 };
 
-- 
MST


