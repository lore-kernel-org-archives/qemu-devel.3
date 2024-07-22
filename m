Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAACCC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjk-0002dh-CK; Sun, 21 Jul 2024 20:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgji-0002Wc-IR
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjg-0005il-Ud
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdw2m0bn75zRr+MYU0d0hXAq7eMAE3t8pjHbmVXVlwk=;
 b=I7QFFMR6BizUyx6Q72rEbsvommJ7ovAv1Bp+BXlqVfiTQV9jnqnnGi1fTDqruF7HvD3672
 GnixfEnSSdDA6nseA6mrlpNoCRqAk0ky4Ac6F9bdc5WiEiFKRAqCRwfJ/FyFqefc0+R52t
 pMlNqyJWujICz6e1foMfc/3McuJq/1E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-CicUJZ8OMxeW78EOQ6s8Mg-1; Sun, 21 Jul 2024 20:17:01 -0400
X-MC-Unique: CicUJZ8OMxeW78EOQ6s8Mg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3687529b63fso2066646f8f.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607419; x=1722212219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdw2m0bn75zRr+MYU0d0hXAq7eMAE3t8pjHbmVXVlwk=;
 b=IJS8x0Y/cWbinQwpV0pJ3dYYMzZFXu4/O1xtWmLS+tBGpmGbF/sAOQuh3THmcCpWMm
 QCyHEletDcNFeJqcKiYl/aFDG8LGYsS4cxwuecGWQw2DrOATxPELP626RzK9WqbQSBJF
 h8a6yplfTc73IhiTnqhwMzq3l9I3hElN6pPa4KdsHpWB2Ad+gMyNZ7RxLwNhgYPyGDX9
 n53vdJTq6kJyQhfCFJQUmldV2Bt1I5SZkgETyMEFDSjyuz7LS8h0egcRDuHcDitWmFmD
 IKoS3yl2nZPzc9wFNonFKPQW1YflTrhzilD1GvhOhQONVq3qKFTjVuvSGLoVWy/wECNz
 In9A==
X-Gm-Message-State: AOJu0Yy7GcFLUTQFJLOsZ9/uMdD2QSxqY2gwAl+kKdXyDx6j3959jxKc
 3QesrLQ7MabmPkkCTwzF0oPWcovC2iMkkK9ybZ4x8Z+3JAtv2NKKbkkQcaTDDFzyvhbB2M3RTOD
 y16ZSHEybgG6cbe5CXSme90hHOjbAVNgIBEG0R5khw9/GBHvDL8c42XBZyMml8gppI3TwfgBRNY
 KN05UODbaiTcrBCOTHTge73k+g0qSHTg==
X-Received: by 2002:a5d:490e:0:b0:366:f041:935d with SMTP id
 ffacd0b85a97d-369bbc91e34mr2694911f8f.60.1721607419558; 
 Sun, 21 Jul 2024 17:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEdV4xbC9k1ETsh7gGyBAbNToEi3yyHBAODFbEZB/YQRsymI6klh7+Wzcn7/9PQh0uu4fyvw==
X-Received: by 2002:a5d:490e:0:b0:366:f041:935d with SMTP id
 ffacd0b85a97d-369bbc91e34mr2694898f8f.60.1721607419025; 
 Sun, 21 Jul 2024 17:16:59 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed551sm7004209f8f.113.2024.07.21.17.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:16:58 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:16:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 04/63] hw/cxl: Check for multiple mappings of memory backends.
Message-ID: <9de2049c95e1a94e27430e71a9d9ace07ec8eda6.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


