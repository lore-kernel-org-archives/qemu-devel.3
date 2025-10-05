Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EE9CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFj-00043W-Dv; Sun, 05 Oct 2025 15:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFN-0002OX-Se
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFB-0006aM-LN
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BsiJ9Y13upyZ0kSNDp9aMBJN8UvV+sDrJuDdQ0y5Q0M=;
 b=UkayjyA7GT/+6KHLIrqMx8NHqTIEEk3Cmku93wT3/MqwvEqQMFNf9LEFZ6nOUJY/LLSL9B
 mw5qLQmFaQHJd5bpNdvtQnpaKiiPC4mLL9bBN0ueGuDAXFLiMnQRgUF10nGXkkGZQcXrWy
 5EiDJqbmYoI8xjqWGD6cSVkOBBy8PEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-A4K6x0YhPbCdOKgSdd7-4A-1; Sun, 05 Oct 2025 15:17:57 -0400
X-MC-Unique: A4K6x0YhPbCdOKgSdd7-4A-1
X-Mimecast-MFC-AGG-ID: A4K6x0YhPbCdOKgSdd7-4A_1759691876
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-41066f050a4so1555366f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691876; x=1760296676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsiJ9Y13upyZ0kSNDp9aMBJN8UvV+sDrJuDdQ0y5Q0M=;
 b=romOGwCG8HPObLoO/R2vwFxAMtvAG7NuqyB+wfc5GY96vrR2R6a6g2gUQ6CjYMG+0f
 y5sGF/xWdka/+T4ZnbxSDvUpMm4yETBBRQMWyLLDSyNcvgsyldn09X2vP+aFMfn1pJPz
 CsCt/6o2CyZyW3zWQ4ooJRaWGvFftNqlpJJ26m9kcUyOabbfqsYbVswOioZp+O3oZMHa
 oz3XIQfsjVlIhyR6AoV9j2Gxaf2vSMuhFiBZ9rZg1LObYlHezUhj1YH9teJeNmw5oRvo
 59NiBSiSLFK24dKNhbpfMfml9GLiPyuwzfnXj8rFEQUTtv2suKMh8V7xY+S48lf37af8
 f/YA==
X-Gm-Message-State: AOJu0YxTtu5+0f0dS9kpnxIJaIcXlu9DFDJGmCc1/TIYWMqHHtkfeB79
 8wiqYI2I9SHoqzkyhs1Q728yFjhUx17HO57bHgj0AzXMU7/kTZC+xyFyOp2/flcVFN1Lq7+kWIQ
 OMiz+1++RGGIBxbZFD45p+wnUaEiJMXvsBgFp8RI6CdIdziPwOTv9YPksK+tLpfz+HQRfQOucBN
 gdCAeNHemDtYLsFxvwig83Qg0kRRLhN8JWDQ==
X-Gm-Gg: ASbGncvaOe6uYyFnuaNRjxAtXQT2rC0oNv7z9TPDBJ7g9lgCOU4AazeDQhpeM8j6tUP
 l6lA2Xjch/BDYE3JzPtMpYBejJ3pvUKzDNLDaMIzBFRwaz5B6BFpcpDmkJhTb2mzUf+4hKCTV7L
 pMjet6BJBIvSywEOzNkVdlkqqEQzFCekP7rxcx8I9u/BIUgcphjkasudCMSDkXyhA75bBgEwRZB
 2i6XaGCzIe60mn68mJrY3E79b5XvC8SVba5QqnssJI9IBAcEU78OBMgRRCPwHrJFVEjjaIbgCx6
 +z+dtZNY63y+GmbGaFA00GTWoT86oHp7KCsEfU4=
X-Received: by 2002:a5d:64e8:0:b0:3e2:da00:44af with SMTP id
 ffacd0b85a97d-42567176bd3mr6732613f8f.36.1759691876213; 
 Sun, 05 Oct 2025 12:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ5rjni9bo30IHHcLhTA82S275kGX4b/FUvcD9MP6/vucT6O956k7TyKlugPcWM1NKXuR/6A==
X-Received: by 2002:a5d:64e8:0:b0:3e2:da00:44af with SMTP id
 ffacd0b85a97d-42567176bd3mr6732596f8f.36.1759691875588; 
 Sun, 05 Oct 2025 12:17:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm17787138f8f.50.2025.10.05.12.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:55 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 50/75] memory: Adjust event ranges to fit within notifier
 boundaries
Message-ID: <2e4d32f0af7eaf87f556fb1fe802874c1b0a0799.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
valid and required operation by vIOMMU implementations. However, such
invalidations currently trigger an assertion unless they originate from
device IOTLB invalidations.

Although in recent Linux guests this case is not exercised by the VTD
implementation due to various optimizations, the assertion will be hit
by upcoming AMD vIOMMU changes to support DMA address translation. More
specifically, when running a Linux guest with VFIO passthrough device,
and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
Remove redundant domain flush from attach_device()").

Remove the assertion altogether and adjust the range to ensure it does
not cross notifier boundaries.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20201116165506.31315-6-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-2-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 system/memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index cf8cad6961..5c6ccc5c57 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2044,13 +2044,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
         return;
     }
 
-    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
-        /* Crop (iova, addr_mask) to range */
-        tmp.iova = MAX(tmp.iova, notifier->start);
-        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
-    } else {
-        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
-    }
+    /* Crop (iova, addr_mask) to range */
+    tmp.iova = MAX(tmp.iova, notifier->start);
+    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
 
     if (event->type & notifier->notifier_flags) {
         notifier->notify(notifier, &tmp);
-- 
MST


