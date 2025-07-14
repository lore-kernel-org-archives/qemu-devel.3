Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C988DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSH0-0005p2-CQ; Mon, 14 Jul 2025 19:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGR-0003bM-Ia
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGP-0005Sg-Qa
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z8hIx0RDGxkniPPBkXaUbDNCr7JWC8oeDsf7Ie3RFps=;
 b=bzAPWp9WeDqMXbJ7gc5uIIj3t5IKtJUh+l05G5jpAvWIvdDIvrLBwVwVY8WSUFQMERo3QT
 ZjMY079J0XHHw0DJr32ntbE+/FOBP5tXosvCRx8mVuHy48Fn6U41Lu+LD7OYfMeapJSntv
 R2mJP8MKpihSVdvnFgBuT8GOaizLrog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Hmjf3DcRMYuGahDib6pDFg-1; Mon, 14 Jul 2025 19:07:06 -0400
X-MC-Unique: Hmjf3DcRMYuGahDib6pDFg-1
X-Mimecast-MFC-AGG-ID: Hmjf3DcRMYuGahDib6pDFg_1752534424
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so3029832f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534424; x=1753139224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8hIx0RDGxkniPPBkXaUbDNCr7JWC8oeDsf7Ie3RFps=;
 b=pyrcmPXFRJrd4tmj5HX5BgxADwFTBqsqf67wmy6bzRwOxJc0scLCBXeiX8SQvasCKZ
 O/Pvjdrtp8ZV8nzYxxh9eGJfxwBl48fJMuBrTstj8fxL2QJ5/UweVlBPwXXz6qA20AQi
 SUQT5GLIuKoOCQbKCcSoBml0rAdy2JFeYkJQDz2D1e0V2WaUVaviiAEwNplotSLOrdh2
 akZ2c8ZepKRx73TPlV9gq9tjK4z2gs7rp9FLg3tytP0k8SY/8P1M6d0VjgFaJp/u8fXg
 /7/v0F9TANwZeCXYVxnuNbpwqaat0njPJQQr5RA/1RfFj71PA/DghBzZyWiFGOn74zMP
 dPnA==
X-Gm-Message-State: AOJu0YyP4sjw96kWA0lDb+VpRyjX35lJT/F95dZrtpOAmS8phcVrhm33
 cYIIyF1khHJsnZgx2XwQHVyLpx9+J5UekijWJoRGsMovE5q+tOCm/H65SL+3nj1TljPnYMsDlrq
 75Nk8GrG99NM9BSJzIx5Lya2FcqSagXwY2TJCV1a+e7hYkfrcJADCdhmVwiooemL8gvX96sWlGS
 NEwIBG57Js3zuPGLH4WDyl31RjWRVdEzs+wQ==
X-Gm-Gg: ASbGncsem006YrXV9ogQWCGuSQIhP5YRT3LJPPfA9I2npf0hCC1CjSVQLKrpaywYVPK
 jX8YXd+NSkday8etPw9lJU2i0pEH7nAoXi5VbDHdQbhjbaAGtONqVXytQwSkh1DbmHmJPxuuRP2
 ccubt6CouRb8RZC+gXt/5knPIjzuwOve3nweOKh2DASY2T83vRNFzbeYrK0u7VaZntKW2l+7E6y
 JChxulmIES+bWjxilLmbXeiHee2ywXY48boV8zJ9zkqgp2XXTdHHAuCrpWHf1Wx1KICPsAJw9GZ
 LK7JTYeURAQbzR9NZCJdNKzUZDn6We5R
X-Received: by 2002:a05:6000:24c5:b0:3a5:8977:e0fd with SMTP id
 ffacd0b85a97d-3b6094fff45mr735174f8f.0.1752534423877; 
 Mon, 14 Jul 2025 16:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbTTtbW8VxZav53wFHIZg1jOGypDHXMySbBVZy3wdA1KCom30tsCnwgsuhczC7Eq6ImgDxAQ==
X-Received: by 2002:a05:6000:24c5:b0:3a5:8977:e0fd with SMTP id
 ffacd0b85a97d-3b6094fff45mr735147f8f.0.1752534423307; 
 Mon, 14 Jul 2025 16:07:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45627898725sm1691545e9.1.2025.07.14.16.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 19/97] amd_iommu: Update bitmasks representing DTE reserved
 fields
Message-ID: <ff3dcb3bf652912466dcc1cd10d3267f185c212e.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The DTE validation method verifies that all bits in reserved DTE fields are
unset. Update them according to the latest definition available in AMD I/O
Virtualization Technology (IOMMU) Specification - Section 2.2.2.1 Device
Table Entry Format. Remove the magic numbers and use a macro helper to
generate bitmasks covering the specified ranges for better legibility.

Note that some reserved fields specify that events are generated when they
contain non-zero bits, or checks are skipped under certain configurations.
This change only updates the reserved masks, checks for special conditions
are not yet implemented.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-4-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 9 ++++++---
 hw/i386/amd_iommu.c | 7 ++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 3b1d2e9da5..aacb29b617 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -25,6 +25,8 @@
 #include "hw/i386/x86-iommu.h"
 #include "qom/object.h"
 
+#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
+
 /* Capability registers */
 #define AMDVI_CAPAB_BAR_LOW           0x04
 #define AMDVI_CAPAB_BAR_HIGH          0x08
@@ -162,9 +164,10 @@
 #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf counters       */
 
 /* reserved DTE bits */
-#define AMDVI_DTE_LOWER_QUAD_RESERVED  0x80300000000000fc
-#define AMDVI_DTE_MIDDLE_QUAD_RESERVED 0x0000000000000100
-#define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
+#define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | GENMASK64(63, 63))
+#define AMDVI_DTE_QUAD1_RESERVED        0
+#define AMDVI_DTE_QUAD2_RESERVED        GENMASK64(53, 52)
+#define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
 
 /* AMDVI paging mode */
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c27efa504d..6e78047919 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -848,9 +848,10 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
 static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
                                uint64_t *dte)
 {
-    if ((dte[0] & AMDVI_DTE_LOWER_QUAD_RESERVED)
-        || (dte[1] & AMDVI_DTE_MIDDLE_QUAD_RESERVED)
-        || (dte[2] & AMDVI_DTE_UPPER_QUAD_RESERVED) || dte[3]) {
+    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
+        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
+        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
+        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
         amdvi_log_illegaldevtab_error(s, devid,
                                       s->devtab +
                                       devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
-- 
MST


