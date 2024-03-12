Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4EC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdV-0006GM-8k; Tue, 12 Mar 2024 18:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAca-0002wp-1Q
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcU-0004eV-Im
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Q3ZMhxuiBKQgwWVuadLMzxaLaVsdjhfX4rDv2UGsEo=;
 b=Rt8tTZ6k2tXTHHFO1N39I2xLVWGCx2JCYVhMNLalH1HoWvmNj3/q60BJchiJhacE3R4oFt
 xNyOIU5JNOLNAsGri6ItnqJAJhDnUw/Ksw0vk3uiQMitIt7mnm8jevGfV7h3JTmfvwb/Gy
 KIfCjWdsxH4HgWgORl14AYNAZTY//9s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-BJLYu9CHOcOKtr9LNGA8zg-1; Tue, 12 Mar 2024 18:29:12 -0400
X-MC-Unique: BJLYu9CHOcOKtr9LNGA8zg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45acc7f191so403167666b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282551; x=1710887351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q3ZMhxuiBKQgwWVuadLMzxaLaVsdjhfX4rDv2UGsEo=;
 b=gTZq3IPy7K1X+LD0Lti+eUyYBhVN+Zkl3hjLzHRTWblmF+2Ymslr6l15NPPtwXM+OH
 pj8cRiA0ePdmHIT+yaA2dOmLaMCEd9vv7UiGl6KxLaHxHBw+OxaH3/6L54iA6i+gaYoY
 uaGGyOxRUAJ3K/p0Eq/3c1M6Tfh4ha9d9oPaAHI2DyFrqwm0iO3jWj2xPQ9sSHN7FMVI
 BeB8Iu0AzGNUlHzMEqAy04bn7qy8oDudYA9rIG6BhQEU0xu/QnDer0LtOImGGY6F1L6/
 VMuIlN24bZ4xEifqrZZuEXSFtemEMFC3FeDzO6HfLpwTuVhIj2ZXvc9fPgU2hmkFCUvq
 Hz8A==
X-Gm-Message-State: AOJu0YyxZymH5oyYnfQt3YAVNyOO7jXldaasYmuh0c0Y+e6dD4/FjL0a
 /PYoETNXJKONtYttLAmo4LlDl+moAUJW4n0DnntEMAAALLJ4QtVfWIkfWGrdZfz2YEa1RrA6sNS
 jDFIEMW4m4CsaWqrVmA4WI0bqTboIBD/NQYgBclmf5EyuatrG1X/mMDIpp30Rlwnhhp8Qpc9YyJ
 /9MovYzu4l8mT2NxhMTg7I4jQnFbHh/9j0
X-Received: by 2002:a17:907:8749:b0:a46:2b07:5334 with SMTP id
 qo9-20020a170907874900b00a462b075334mr4717116ejc.48.1710282551071; 
 Tue, 12 Mar 2024 15:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ07Jy5RT2nxEDcvs+D9Txc5FhbTkeaabAnwIDZRnVrBlgpFrUvVI6LAQOJjHu1D1i5W47bA==
X-Received: by 2002:a17:907:8749:b0:a46:2b07:5334 with SMTP id
 qo9-20020a170907874900b00a462b075334mr4717103ejc.48.1710282550623; 
 Tue, 12 Mar 2024 15:29:10 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 gh16-20020a170906e09000b00a45380dfd09sm4218155ejb.105.2024.03.12.15.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:29:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:29:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 67/68] hw/cxl: Fix missing reserved data in CXL Device DVSEC
Message-ID: <bfc2f7a6caa6843e50019ee2511ad11cd5582711.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The r3.1 specification introduced a new 2 byte field, but
to maintain DWORD alignment, a additional 2 reserved bytes
were added. Forgot those in updating the structure definition
but did include them in the size define leading to a buffer
overrun.

Also use the define so that we don't duplicate the value.

Fixes: Coverity ID 1534095 buffer overrun
Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240308143831.6256-1-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_pci.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 265db6c407..d0855ed78b 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -92,8 +92,9 @@ typedef struct CXLDVSECDevice {
     uint32_t range2_base_hi;
     uint32_t range2_base_lo;
     uint16_t cap3;
+    uint16_t resv;
 } QEMU_PACKED CXLDVSECDevice;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x3A);
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != PCIE_CXL_DEVICE_DVSEC_LENGTH);
 
 /*
  * CXL r3.1 Section 8.1.5: CXL Extensions DVSEC for Ports
-- 
MST


