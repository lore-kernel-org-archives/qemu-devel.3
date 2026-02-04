Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13B7EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniCJ-0004YX-7Y; Wed, 04 Feb 2026 14:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBZ-0003G1-Ed
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBR-0008GN-Hi
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFcxXry7cWSnSdoZKjAQluEgDqzJ6zOGhiXLEuhnG6I=;
 b=HCInf9VTq9H9RQco/SrNEMCnb4nZEWJNGx6Y+X3cbvdZ4at2Q8puiymFprMKH8rkISWy0J
 j3KjjclKSvxVovFFY8iyoQqeR3iQc6GP/Abm0mrDlLDfqg2l65Zma2pxkbQY7+2A+g/R+j
 DT05+Q71q8xTEbbHhqrpbsu/9EcTfOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-31lAhKLKM3KZx94gLUhyWw-1; Wed, 04 Feb 2026 14:04:47 -0500
X-MC-Unique: 31lAhKLKM3KZx94gLUhyWw-1
X-Mimecast-MFC-AGG-ID: 31lAhKLKM3KZx94gLUhyWw_1770231886
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435ab907109so103722f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231886; x=1770836686; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iFcxXry7cWSnSdoZKjAQluEgDqzJ6zOGhiXLEuhnG6I=;
 b=GUWzN5n6tB+B34KuSumClpEWz9vRJVthczUioPYmdrB0Cmg7s9n0bMMevIEhqn4k2q
 QfHRTOCFGjSNRI0DlhUIRnohZdSyYNxJnr2fKF5vo5dL0qLP0tbOkGeLJOTzszbV5SD5
 r7ZCns0qXJJ0Z1hqeo9pIVzy2MXDpelX8x0uTNIO4PT7EsNPoKjuv1EvEz9SCHE/6KlK
 ELEG5DpTEVHd9ZzIb+IxGjXoGwnRPxKyvEG1vEOMuuvZtX6VtqchZNcXHJxhIrzn7nFp
 aUUotTI5Xi2oCwV/LxfN080anPlKdd6xOCkehzlSseTpuZHL8NGUQt3kCjh0DSKlzZpl
 i/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231886; x=1770836686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFcxXry7cWSnSdoZKjAQluEgDqzJ6zOGhiXLEuhnG6I=;
 b=Kbz11uR+FLOvY84GF08IJOupF8Gdtli60B3vDSoIPG1fxmEyWBLSTFO1bCsYam2M4h
 oR0f6uSAn3GMnaSGs6KPMuz2KKCuhZ9qCUb0MBbSmO94Fqm9HPVfZzudmzUuevRE3HIy
 /oGFX59pGthg3BsUloG/xsccAfbIzr+zr/qbkHcT/1CpautJr+fmtBR4lvDZnCDXRDX9
 o5XRfNjKr6TCsatVPpcNrUhW1Jw9WXH7uv7OzSdlK/iaVtDgnSDPSq2swR6Ex9Mmx3iP
 3aED3AD+TM0NO6Rb1+hyOjvex02FEBjbrYDYMV2OL9qfKCZGoxynbgLlwzcsNwlrFNzB
 tGxw==
X-Gm-Message-State: AOJu0YwwyQii24pmHN6EWD6w7171/uiCHk7OBCgOZH4PEbg4hCuN8lQa
 7dqIbxk5Ouj4b0e6wsiUykysx685Ej4CxnBOZWECBeweL09+HEHc4sxwh/ihysYhrVXzEPDT5eI
 7v4jHCw27wFvWRgsceB49WGzp6JDMncXM57YQt/+7v7fEzNoplCqDSdUIK+6VEeWnyJ0eBcRbsJ
 E6i4Ujkuvf0SfcdDXzeyMaGnR+R3arREwWyw==
X-Gm-Gg: AZuq6aL/MnKM0vNvER8zG4fOY2wBTebXElSzqj/X/tDuHd5sk6j8tgKBgiPVohorXhZ
 0swM5iCErSaexFcjyxeSop0J5/0OZARY4FviVyvSn0bFftbuo4ebWD/R7yV3E1VnIP6DBkmG9+J
 dXHimPWtFpf18JnORGIlQer2gO++k1Yqzlhb5MyNBGGRqnCijHCviaunAEn4vHsCu22gsp5pb2V
 wESsqjlVWXhgLnfPHOQ1l7aUQQNvs/ZOVyJb+gpVycRnJ73gBx30F7S1OnVjzRuSKxakdWtudIa
 CkoYwm4ZoNNkj/H926WhCqLbqidTU5oPFsWWdtr43rz6qe6OX0ZnGmxNeknD2jP1lLC4tRT+kxf
 n4IBH8D2xpfFDd0foxbss3DH8SqSzI33yoQ==
X-Received: by 2002:a05:6000:26c2:b0:42f:b0ab:7b48 with SMTP id
 ffacd0b85a97d-43617e300d3mr5073346f8f.1.1770231885692; 
 Wed, 04 Feb 2026 11:04:45 -0800 (PST)
X-Received: by 2002:a05:6000:26c2:b0:42f:b0ab:7b48 with SMTP id
 ffacd0b85a97d-43617e300d3mr5073291f8f.1.1770231885070; 
 Wed, 04 Feb 2026 11:04:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25d47sm7494986f8f.5.2026.02.04.11.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:44 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 50/51] hw/cxl: Check for overflow on santize media as both
 base and offset 64bit.
Message-ID: <6227c8b4932df515143fae61db5b384aaaf0a5bf.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

The both the size and base of a media sanitize operation are both provided
by the VM, an overflow is possible which may result in checks on valid
range passing when they should not.  Close that by checking for overflow
on the addition.

Fixes: 40ab4ed10775 ("hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros commands CXL r3.2(8.2.10.9.5.3)")
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260102154731.474859-2-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a64b8ba535..d8f62a13a8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2411,7 +2411,7 @@ static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
 static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
                              size_t length)
 {
-    uint64_t vmr_size, pmr_size, dc_size;
+    uint64_t vmr_size, pmr_size, dc_size, dpa_end;
 
     if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
         (length % CXL_CACHE_LINE_SIZE)  ||
@@ -2423,7 +2423,12 @@ static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
     pmr_size = get_pmr_size(ct3d, NULL);
     dc_size = get_dc_size(ct3d, NULL);
 
-    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
+    /* sanitize 64 bit values coming from guest */
+    if (uadd64_overflow(dpa_addr, length, &dpa_end)) {
+        return -EINVAL;
+    }
+
+    if (dpa_end > vmr_size + pmr_size + dc_size) {
         return -EINVAL;
     }
 
-- 
MST


