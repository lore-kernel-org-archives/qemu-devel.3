Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3DDD1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Gk-0003JG-E0; Mon, 04 Nov 2024 16:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ge-0003Id-Hz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gc-0005GF-RJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrnd791JRA6XcZViFP6mkczIjt0e94BMU9whFcnTluw=;
 b=i1LXnMJQ4nBsrYozTj4TAq+O06zEto9hKCfkXbQWpBDd+fECODPu7ObwLLECPOvwtfZS1D
 ubc0+TXv9E6rhx9toG6b/uQoq1DPt7pcOQkedXO0zhWCE9bi9yC0uR495lik5tU1hFJaAR
 Yclnz+HOhdEJVZXmUn019b1Ta9wJo2s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-xGcA2h58Pc2JPMRbJUE-ig-1; Mon, 04 Nov 2024 16:05:39 -0500
X-MC-Unique: xGcA2h58Pc2JPMRbJUE-ig-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb58d1da8eso26881221fa.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754338; x=1731359138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrnd791JRA6XcZViFP6mkczIjt0e94BMU9whFcnTluw=;
 b=Hdj1GaRuyx8qd0cogKXupB493KoTQq84h+pSkpbyWnon1Vifchs3m8g08ox/6XsbfH
 k7WTpOM4lHLRha2QZUSCkHgUNkL5tWBzslRGkJM7e+eVcyXUzw2scJIXzUFbloUL73et
 AGDQrXFQueHQ622HtslGeZmCUOfChCE7D5+WlPFp9Lt2nL4zoGplG/Er2XImDWvSwWSH
 3lD/s8rHWHKHehcb6bbzcw5qp+UojVPF9+RJv3h6yh/+AgUPn8kRCJMG21a26baMzeFk
 K/ND0HSWkJxCk/yv4TPz60NnQCBvE7OpsoZaHCfyXL4d774fCE16G8AOqCL77y9i6v2s
 0YCA==
X-Gm-Message-State: AOJu0YyA++95McoDBvjqSk2FW6UuZr4rlIOXllJ09Obee+Qp7bx4f7Pf
 TBl4s1G5mm/Vy0xqQYtPv0Q0P94Tv5jDLgvx0rwKsHYg/1rUAazLRHHeKIcPapUgyDWk84MmCmv
 gT+YDi2dBzu5UXyeTryy4n83APfKwuhMATFJnWE01MTSisfCZxSVZVQWgc2x5htKiwSCqfJIncb
 R59biWtVXaoilY+6K2wpkKdJY1w1NKeA==
X-Received: by 2002:a05:651c:b0c:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2fedb7d8b1emr67827191fa.32.1730754337774; 
 Mon, 04 Nov 2024 13:05:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKUQYppskSaRTWKFEEQxSZrAxZ4GfeeO93QZ21ECIU7AiPIqa55Ic7PKiyWSjD3D+aAnowHQ==
X-Received: by 2002:a05:651c:b0c:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2fedb7d8b1emr67826911fa.32.1730754337210; 
 Mon, 04 Nov 2024 13:05:37 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e9145sm193285595e9.1.2024.11.04.13.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:35 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 03/65] hw/acpi: Fix ordering of BDF in Generic Initiator PCI
 Device Handle.
Message-ID: <16c687d84574a1139a6475c33e3b9191f7932ac0.1730754238.git.mst@redhat.com>
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

The ordering in ACPI specification [1] has bus number in the lowest byte.
As ACPI tables are little endian this is the reverse of the ordering
used by PCI_BUILD_BDF().  As a minimal fix split the QEMU BDF up
into bus and devfn and write them as single bytes in the correct
order.

[1] ACPI Spec 6.3, Table 5.80

Fixes: 0a5b5acdf2d8 ("hw/acpi: Implement the SRAT GI affinity structure")
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/acpi_generic_initiator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 17b9a052f5..3d2b567999 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -92,7 +92,8 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
 
     /* Device Handle - PCI */
     build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, handle->bdf, 2);
+    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
+    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
     for (index = 0; index < 12; index++) {
         build_append_int_noprefix(table_data, 0, 1);
     }
-- 
MST


