Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F737C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4c-00077d-Vm; Fri, 21 Feb 2025 07:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4Z-00072Z-LM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4X-00078m-OB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=htXrZRjJWy6jAGF8iFopXWg4nq3jbP1OW/HmNp/8W4o=;
 b=hZuCYZH6nCCNaIg3TRmGiJiuM34kNZUe6BUXK4z8ufcLRRuMOZOme9X/OeO9w7ywvvseJK
 mMbiKUJrlauJsj4X14c0ckgOXi2EfU1oO/ttigafnSZSCft9yt6M89xrORxpn03h5o/KbD
 BY9/1yO/n+gDOB3ULD62raRuFli6Oww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-fEUT-AKfO3O5EDtbCDQ_Ng-1; Fri, 21 Feb 2025 07:23:59 -0500
X-MC-Unique: fEUT-AKfO3O5EDtbCDQ_Ng-1
X-Mimecast-MFC-AGG-ID: fEUT-AKfO3O5EDtbCDQ_Ng_1740140638
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2c0aa6d6so1468820f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140637; x=1740745437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htXrZRjJWy6jAGF8iFopXWg4nq3jbP1OW/HmNp/8W4o=;
 b=JC/BwKszLyT03LEw6G4ZtRSERsJ3mCLKVnSkZvKud4vZQS47PMgBYrurpEx5Dd/mto
 bP/tIpD8LBKdZFOJte44374vSmmU6FV0G5IYaUF9NluytqIIVpSb5uSM5wjETaBtx12N
 uk9MWJ68IJKobQGEUeymnVRiPHq5sNk9C/3V9Kh92hRRpILPCD3Iq10Ao+XTUXWiDUII
 somNWKKh30opd20vBA5IiyJpEryOuh7dT6e9dvG94u3Y9GiU41Brqitt5K/MDTFJuby0
 Mdzm6bPmNFiM321FPRpCkH9UhkbRwP8u6eQLAV2YzRU9CxT7iPU0yceVrXEdL343G+Y3
 qDZA==
X-Gm-Message-State: AOJu0YxWhDk2mVqkNcvvc1zWo1/iX2BYK8StxQ4aCSLw3hKH7h0MF/Ko
 Lz0AEsHUAohJSRknGLW0FsAj4tfequa28fRapGch2Kq1gsDMXWM35n9UZXzNYGcRKLqKIaTeLUJ
 jXC6KV2gV34/fEYkJGPqdBmuPJ3BcbQvrU2A2pNi6gV/TGJrJ/2nzhx2hM7YCbt1isynb7G+wFD
 UB/DvRsYiAFzzayeeeHRHDc8ilVVP8sg==
X-Gm-Gg: ASbGncvfM4y9RZvx/15FE42bD/7klPSoEbA09Tg8HkD7pJZqep8vRTzM8bgpzIKJ722
 h/W89lNxvje+L8g9+X8BDnO/sfc21e5N22lXxy73weHdaa3lzjTRZ7NY34lwCTAuxL6l2UQ5PN/
 o6/LnAOHwl7VF0SLhofLSAvaJUpkRRLj/cm2OIQBFxHgQuWJ3sGeJwYdYF8qbVNPGtYpQqajPQU
 yqA9iI+zz+ozVA/P3H3IFeMGLe3OqB6lKi0CCSQN+kndJJAvOsaFugeSgY9+s0cxp5q07i4oToc
 3zPHBw==
X-Received: by 2002:a05:6000:18a9:b0:38d:e3fd:1a1c with SMTP id
 ffacd0b85a97d-38f6f515202mr2711229f8f.23.1740140637437; 
 Fri, 21 Feb 2025 04:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk3MwthKuYt50N4X+gNJoPR6Bsnka87p4Sfpx0EuJrucprl8bLCQE5TlFazLFd1IIkjbKcrA==
X-Received: by 2002:a05:6000:18a9:b0:38d:e3fd:1a1c with SMTP id
 ffacd0b85a97d-38f6f515202mr2711197f8f.23.1740140636971; 
 Fri, 21 Feb 2025 04:23:56 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fe5esm23510599f8f.99.2025.02.21.04.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:56 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 24/41] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Message-ID: <9ac2c42f43a536f53b3d4cad8a601ccb8640cbd8.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

Since the kernel does not check the interleave capability, a
3-way, 6-way, 12-way or 16-way region can be create normally.

Applications can access the memory of 16-way region normally because
qemu can convert hpa to dpa correctly for the power of 2 interleave
ways, after kernel implementing the check, this kind of region will
not be created any more.

For non power of 2 interleave ways, applications could not access the
memory normally and may occur some unexpected behaviors, such as
segmentation fault.

So implements this feature is needed.

Link: https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com/
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250203161908.145406-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c |  9 +++++++--
 hw/mem/cxl_type3.c           | 15 +++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index cd116c0401..473895948b 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    if (type == CXL2_TYPE3_DEVICE) {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 1);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 1);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    }
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      UIO_DECODER_COUNT, 0);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d8b45f9bd1..6fffa21ead 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1100,10 +1100,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
             continue;
         }
 
-        *dpa = dpa_base +
-            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
-              >> iw));
+        if (iw < 8) {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+                  >> iw));
+        } else {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
+                   >> (ig + iw)) / 3) << (ig + 8)));
+        }
 
         return true;
     }
-- 
MST


