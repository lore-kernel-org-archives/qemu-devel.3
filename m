Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7F8C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAb8-0008Ol-2G; Tue, 12 Mar 2024 18:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAau-0007kB-PU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAat-0004PN-Ax
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRkgmEXK4kdbpAxqfwfMTxmqWS9DlUTeU9ylZaG1Bss=;
 b=CSlbMxBVqW3jVB0CcQBmfkett6nFIwqAY3tKNShOeJLvgkslgz5hFNVudBIrmggx9F60CN
 BgZ4lvpJDAGHIIHTKwo6ps/lSJJCcPMzLSoHXeHy0Di4pTLQ+r9CKnOgRZvYgoIbsTA1Z+
 2KK5biuorbuZD+Qp9NM9lWL8MxE4mDY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-sPXTNW1UOeGeQNxkkRWfZg-1; Tue, 12 Mar 2024 18:27:32 -0400
X-MC-Unique: sPXTNW1UOeGeQNxkkRWfZg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d45c84435eso10086721fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282450; x=1710887250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRkgmEXK4kdbpAxqfwfMTxmqWS9DlUTeU9ylZaG1Bss=;
 b=ZHLMXolocZOxhCkaRBoTH8eIbSN+6shXvuifKR7H6Th9BuPNqUpSOfKFM4NrzSOnpy
 jHZM8fJk+xFLEMCBVZWoGx1GNu2BQATitrJtl5l3pTFH7/a9fTtGLlhKxBvaUIWjCVt5
 YXqzu7DEYOWEs7R0jrQaB6UdZoey4T8IeZmkJULWrTqjmIkQSQI6b6AWuCYTElwhdRoA
 K/S/hwUkHF10jRsnb0hGK2lkiAbR0ZplBRFd+ZPoj7xbuEY84ZBqit5/dZY3UIxFBwg7
 KYP6ZyLe6cH3LSXkx73aYeJQeAE1JxfmUWrZU17GX3D3ZHzgvPgEOQN0fT7SWSJ7inlC
 6XWg==
X-Gm-Message-State: AOJu0YxwUmmlV8DknTXw42xpr+7pAHlnIDD6G+JNmaIrgBnvxAwKwFtJ
 90iiLqj/lT1ThZ0M9Jr7h+Mm+u8GVXXTJZte6eFQ6LxCxDwTV5D/wk5fioEVxcrGWGRBeopd1TG
 Sgeozjiv0wRwWH03zMu0Kaz6CC0/VI8Fdxg57g+OJRGBbTN5vQHOfYSpalEhyE2l/d10fMLwMhH
 6p/POS1587nBtv/6EpcYwIQ/NSOyycjPF/
X-Received: by 2002:a2e:869a:0:b0:2d2:c8c1:d844 with SMTP id
 l26-20020a2e869a000000b002d2c8c1d844mr7098965lji.13.1710282450085; 
 Tue, 12 Mar 2024 15:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2G7TQGxxQ82zzE1Eh/Xb1X/sflYU+64zTbr29Puoikel9mRMyBe4a3d24kRjCMZuwIyYVzw==
X-Received: by 2002:a2e:869a:0:b0:2d2:c8c1:d844 with SMTP id
 l26-20020a2e869a000000b002d2c8c1d844mr7098944lji.13.1710282449537; 
 Tue, 12 Mar 2024 15:27:29 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ho34-20020a1709070ea200b00a460d8222fbsm3641217ejc.215.2024.03.12.15.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 37/68] hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD() in
 cxl_usp_realize()
Message-ID: <4f5a3f49b934ff24227ebc95b3f9177f0147ff52.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in cxl_usp_realize(), @errp is dereferenced without ERRP_GUARD():

cxl_doe_cdat_init(cxl_cstate, errp);
if (*errp) {
    goto err_cap;
}

Here we check *errp, because cxl_doe_cdat_init() returns void. And since
cxl_usp_realize() - as a PCIDeviceClass.realize() method - doesn't get
the NULL @errp parameter, it hasn't triggered the bug that dereferencing
the NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
cxl_usp_realize().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240223085653.1255438-6-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci-bridge/cxl_upstream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 537f9affb8..783fa6adac 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -289,6 +289,7 @@ static void free_default_cdat_table(CDATSubHeader **cdat_table, int num,
 
 static void cxl_usp_realize(PCIDevice *d, Error **errp)
 {
+    ERRP_GUARD();
     PCIEPort *p = PCIE_PORT(d);
     CXLUpstreamPort *usp = CXL_USP(d);
     CXLComponentState *cxl_cstate = &usp->cxl_cstate;
-- 
MST


