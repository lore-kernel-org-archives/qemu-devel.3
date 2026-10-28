Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3988606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AQueC+uw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VcZ1XbER
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7GI-0000oN-Q8; Wed, 28 Oct 2026 13:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fn-0007OY-F7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fl-0003pn-TV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IlxWdq2RhFA6vALX72k1c10B6bNkliEqAxrDbV+1nu4=;
 b=AQueC+uwIr7Y+NhtytRPKZrubGukkW591B3QkiOcSKsEH5ltd4ZtK8AV/xigGxb9AO1JUq
 ODqiTTAn15NdQPgz5MS+KGUs1tdiLV05CAFwOXYYt2iR0EmcDRSsXk1B7VN8Hs+I+KXPwg
 3KbspePiOoHhSkIpjcevzLhCByeWGv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-kaRrjIksObe5JUveDHE2hA-1; Wed, 28 Oct 2026 13:15:55 -0400
X-MC-Unique: kaRrjIksObe5JUveDHE2hA-1
X-Mimecast-MFC-AGG-ID: kaRrjIksObe5JUveDHE2hA_1793207755
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a4654add56so10322935e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207754; x=1793812554; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IlxWdq2RhFA6vALX72k1c10B6bNkliEqAxrDbV+1nu4=;
 b=VcZ1XbERCrZeBX58xJhvHcaoI3WGIq+RCEiYE0ZGhh4zxlPHgUt5rJPMZbrpFyeFgj
 CZ+vH6HVNgbYEEyKu7eI6ZthX1t7TNdZCDKo6qOExJUaJoPcQuABoLJhfx7zlIeLgFCv
 knSBJTOqwpXfd2qMDH44HSufB9/G/aqCivODMb4RmTG1hDIHNakdhR+kRyq9UKNqQud0
 FBtPKx5a2nkIsg5VdbS8EWAglLQFG/fbYTlcNwAIBrVjh9PCEwIyGNvdB3TZPH0N/jYw
 OQ4Ag6FzM4SxryXfYoH1jDoWCTBhM1mEq1I6mfJAFiXOn42PloUSWxqLW6SNSDPPNdP+
 Ju0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207754; x=1793812554;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IlxWdq2RhFA6vALX72k1c10B6bNkliEqAxrDbV+1nu4=;
 b=J/YohhKXGSc+/cUBIJlT9L7ZUtS+12EF8cgGURjpPeWeorkm5GQLSIad9F8mcTz1MK
 uHQpp+Xtd9XFU/ezebDhatCkazNosOaheVmbGhfYWgLeoqr9ffPJMh41tyFqdkCATh+W
 A3uP2ICDqPGeEojfL4NGwJH8zctuo+dUL+uU0oexibimi2Uf0tlMLiBRLSP5STEprtCP
 sq7YLT+bLOfqovoH51GcIrq/Kxm3T0vgBwX/Yfhd4lsPRid23bwGWfPORwP5Grp5mOxW
 eKisaUcEJreiyArrEJhxW8fyhMan8FDCllMkntQ9h0MBd6A7d+4OF7AoMaaPrRabrGqH
 nX7A==
X-Gm-Message-State: AFq9FYICBjNhfthf88/Y/kDHN0JjhZfbvVkoX5mYuxvNHTraq6OSneSd
 /ukgi/jbsS9KJZeMN2GbqxyX0kt8nh4KhwxopspZYiOCVjCR7oIkQ7C/Hc9TdpaBy3iyGZSjvab
 eBPkDdEe2eSmgqhNOxp+jhVERYm8Co76cNvdZBQz1TlMi7PXdggHV5bKIPoukfWrkSIspGEALPL
 JoA6e5houLxNRsnrm8ppnDFLZ6oHmP4+87/w==
X-Gm-Gg: AYBFou3FwodyQQbTRn2tzeM+mSZiHUs2CUMR/sNlJY5avCcqKBj0gwNQsVqETm0vhOz
 rYWs6wpMvx+DWuzIntpa1HvYHNaUddbJMhbkzN1/rsn5r1PC4ngT/h/f/QmPf2ezxz8kGB5WTiG
 7tdM1aaBMFiNXNegCTtYPQwQL2eURRL4yTzbsJuQ4TQ66PMlSEXkaeNecBDgcvCiF677nDqRZvD
 jpx9B5okVuWLMnveHEqurNa0+Gnt4gWsfQpmStranQlkDfasdFZDwkRDIwr9En8cdswS71waXqk
 AUZHykA/pWNzuWxKUWTfkAXZb6ziUjAqfEd86SzoInHERM2l8ZFJbHIyu5+U9wALdF+yQ/Rvs+b
 gukP0V7KDvAG1P4InVjhxTZHC3q/5FjXnrkk2J2kc
X-Received: by 2002:a05:600c:a31c:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a9674e554emr50152655e9.30.1793207754250; 
 Wed, 28 Oct 2026 10:15:54 -0700 (PDT)
X-Received: by 2002:a05:600c:a31c:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a9674e554emr50151815e9.30.1793207753562; 
 Wed, 28 Oct 2026 10:15:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm5439615e9.14.2026.10.28.10.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:52 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Vrabel <david.vrabel@nutanix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 43/78] hw/pci-bridge: Default the generic PCIe root port as
 Gen6 capable
Message-ID: <f3cad4828e5145974a49b4a5420131320e2edf73.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Vrabel <david.vrabel@nutanix.com>

As part of making virtual PCIe topology having the same apparent
bandwidth as a the underlying hardware, make the generic PCIe root
port support maximum speed so by default it doesn't appear to be a
bottleneck.

This also makes the three generic PCIe ports (root, upstream, and
downstream) have the same link speed/width capabilities.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928152431.310363-4-david.vrabel@nutanix.com>
---
 hw/core/machine.c                  | 1 +
 hw/pci-bridge/gen_pcie_root_port.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d9ac4b419a..4da24f014a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { "pcie-root-port", "speed", "16" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d3ace7f0db..8cabeadac8 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -130,7 +130,7 @@ static const Property gen_rp_props[] = {
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
                      res_reserve.mem_pref_64, -1),
     DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,
-                                speed, PCIE_LINK_SPEED_16),
+                                speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
 };
-- 
MST


