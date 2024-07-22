Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD5CC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkL-00052J-ML; Sun, 21 Jul 2024 20:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkJ-0004tj-0G
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkH-0005mk-8f
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5oJRr4r3YF/yxB2ziPoT4Qctv1Z09qYy5SwcSzq9dE=;
 b=Qp1khyoOFNNaH500RsTgANlv71/iLUavH2Q9CxCSP5TG8fZVBbXV8y9lPWeL+r2eCKwrDk
 STNQmEg+09NZuzhfNza3e7AH844SsvpvuMDDuUpBOIW2cfL8izXPhoX9x/Bs8dvkXokf7I
 hFHx8DhFsLjJt3i47xobbMfgUCy3qaU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-0GBAiiTaNf-TmBFS4uQZvQ-1; Sun, 21 Jul 2024 20:17:37 -0400
X-MC-Unique: 0GBAiiTaNf-TmBFS4uQZvQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725ec6e0aso25422355e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607456; x=1722212256;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5oJRr4r3YF/yxB2ziPoT4Qctv1Z09qYy5SwcSzq9dE=;
 b=kbMKPYcYGZVN7Uxc2msm06Rfe2bUBuf3Cj9T3ZaWan+Q0x+PAQ3b40EmT1PIKxySQT
 3QnKpQ5gOQWvJdqzdpV/r+wdL1/c4GnxlTlvcdVjshVe6kQPCMnHfiK9H8WUy7rQU5Fj
 64gQnAr3QJky9t0HPscaHi4x4fkyJYo5+FRtxckxTm0pWh30Fb2IkRBhJr6K7qJPOtxe
 9p3RIZCSUSs1/8do93jOWIDVbhE3DbmKDa5pWT1Fq40vciU+f90UhKXez4JZYfloXAfD
 SWr3wPTxZwXtUtU0JqRBRsQAyXUsQF9v5+ttvF0KTrzt3+PG7Fz7SVt8iTJZ9/mRbYCi
 9IZg==
X-Gm-Message-State: AOJu0YzjqI4BVFRtidi6dEKzHrN5cTG9rcH69IaiEObITBJTG4uXlT69
 E1xfZq04NQUzOgxAtuO1Y+i0Cvpv/zs/tCMwOktDc7udgmoPgUJmtYxqB+OTDWaZRUVL4pvfPvP
 otXSEjqrWUHPlc1y3dq+bwMFIEsbKnyi3vKGfzpaJZgbKXZrutjKyFSZ3D2Mw0vjZiYXJ4vWCij
 Or0bRdpozDkqd/QS6hgn1+11QvYx6P3A==
X-Received: by 2002:a05:600c:5129:b0:426:5e91:391e with SMTP id
 5b1f17b1804b1-427dc558d2dmr32695225e9.26.1721607456311; 
 Sun, 21 Jul 2024 17:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmriSrPMO2X+wYZOHqhPwzm4PwCxaGtLFiAnrJdioaOdaIuckIq37pRMFbSW3gojIom+Y4iQ==
X-Received: by 2002:a05:600c:5129:b0:426:5e91:391e with SMTP id
 5b1f17b1804b1-427dc558d2dmr32695065e9.26.1721607455829; 
 Sun, 21 Jul 2024 17:17:35 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a63c8dsm134270105e9.20.2024.07.21.17.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:35 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/63] intel_iommu: make type match
Message-ID: <bb3a23d5b0b43bed3c9a6ecf5a6871e2871be883.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

The 'level' field in vtd_iotlb_key is an unsigned integer.
We don't need to store level as an int in vtd_lookup_iotlb.

This is not an issue by itself, but using unsigned here seems cleaner.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240709142557.317271-5-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 37c21a0aec..be0cb39b5c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
 {
     struct vtd_iotlb_key key;
     VTDIOTLBEntry *entry;
-    int level;
+    unsigned level;
 
     for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
         key.gfn = vtd_get_iotlb_gfn(addr, level);
-- 
MST


