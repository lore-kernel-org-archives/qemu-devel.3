Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB5CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFF-0001b9-4U; Sun, 05 Oct 2025 15:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEm-0000A7-Aq
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEk-0006XL-KB
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xzqumJdA2IU6uk2BKX0kvnJAwm1EzQzyigsDYU/IG3o=;
 b=XZMiWj0VK3hCkgYjbG8RLAfM4qM4KBOXb1Qd5TZJe9UD8b6R1H4IV1mEVv5jGJBGpJLsW5
 0PBB0UVLq2U8TDFePiQFJCWqH3b9Q+JIW1UqQspMXklPKNI0vzZnogl/0+EmUcp5PX7rqJ
 yq17hmcOUDklD3DeqgO99H0mDRrgbuc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-GN335gjcPEmM9CGuR0iy9w-1; Sun, 05 Oct 2025 15:17:36 -0400
X-MC-Unique: GN335gjcPEmM9CGuR0iy9w-1
X-Mimecast-MFC-AGG-ID: GN335gjcPEmM9CGuR0iy9w_1759691855
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so2979852f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691855; x=1760296655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzqumJdA2IU6uk2BKX0kvnJAwm1EzQzyigsDYU/IG3o=;
 b=rsoc9A5ENKHjQ472Cb9dlwEsp5NIDKCg2VYdN2rXkgM8F53PiT/G2KoLbBg0uQOgWs
 TKkDRCuTRVBz3aYkcIbalAcJJSsRq3Wf+/ckd/kRhJ2h7ufvSOC7Svb+fPJLKrR8m/++
 7yg0mJOzx0p3rQXnRNc7Y5Wp5WWQo+iiO7r8nlsdJIjkKqgsjnIbQ0lw254vpz+e8/2U
 GSJNhLcSwh7wbZWhOx0BQPaDXaZIPyx4TodaqDFBa3lj7cgviaUGBpmv+N9oTdTW8Amf
 aLr1SPuqdEb6GmHop/9Phoa/q0sEECIi78L4SXbDq3rBnUzbqKx6vQ9XI/dFMprzfANH
 ZKEw==
X-Gm-Message-State: AOJu0YzfAyb6F5mRoVcEUbEaKsXYkiGj+6g6KRfFU4mxH0bNaBP0MeLe
 3mvJUKk3ja8uJu+R5ED8v0JEoeixgyYd4TDRY1goz9M1AazbYS60O/yKfh08kmIkt+GA0ajsrRr
 tmC6tObSdMYtkY1AmgxpScf6bU4mlgC+bMLDFSfheVeQpkf22xy8c+V9o14uzK+tTrlshXXgnCQ
 4cU3WPOWTriyNCsfjkUL/Pm8y+6QBv6XoXWA==
X-Gm-Gg: ASbGncsi47snKkYpQrb9s5mkowkoaTflmWqq0BGo7+2cMs6NjOuJrLI/8n238CNfcn6
 oYmC2n6yNB6Z/YSBXedbbQBUz/sB/Vo21666fri/hmBNHEkIcRv6DGR2zKtIN3enPHjrIn9alyb
 +YAJL7KpfOtrKjoHWf7zKWLP1oTkSBs8EbbOlJdnQfmBU4Uy9pMrwraXn5LbJQWrcoYhETZnlel
 G07xe/0ew8MvQebxtKNm2aqQP0hDsUlmmgHQAdvePIKWzANPr5aOA4fJlShrBbnKUFrqLtW0CUy
 6L/nS5SsW2PbakGkTFkkfE4Qo/ZxViOJBgZDnJM=
X-Received: by 2002:a05:6000:2910:b0:414:c2e8:a739 with SMTP id
 ffacd0b85a97d-42566c5ef4amr6878664f8f.31.1759691854673; 
 Sun, 05 Oct 2025 12:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2uJeMWvF0P1wIRjdZRjb/My+GlBVAX1lKarrmf6fA8mj9QvBRLbnj37q8WTEsu2KuBJz1Fw==
X-Received: by 2002:a05:6000:2910:b0:414:c2e8:a739 with SMTP id
 ffacd0b85a97d-42566c5ef4amr6878644f8f.31.1759691854167; 
 Sun, 05 Oct 2025 12:17:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9724sm17277219f8f.28.2025.10.05.12.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:33 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 40/75] intel_iommu: Declare registers for PRI
Message-ID: <b84e1e0730f3063fc453ce2d0a77136f101467a2.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901111630.1018573-5-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4e7ad3a290..d952ec1428 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3386,6 +3386,27 @@ static void vtd_handle_iectl_write(IntelIOMMUState *s)
     }
 }
 
+static void vtd_handle_prs_write(IntelIOMMUState *s)
+{
+    uint32_t prs = vtd_get_long_raw(s, DMAR_PRS_REG);
+    if (!(prs & VTD_PR_STATUS_PPR) && !(prs & VTD_PR_STATUS_PRO)) {
+        vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
+    }
+}
+
+static void vtd_handle_pectl_write(IntelIOMMUState *s)
+{
+    uint32_t pectl = vtd_get_long_raw(s, DMAR_PECTL_REG);
+    if ((pectl & VTD_PR_PECTL_IP) && !(pectl & VTD_PR_PECTL_IM)) {
+        /*
+         * If IP field was 1 when software clears the IM field,
+         * the  interrupt is generated along with clearing the IP field.
+         */
+        vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
+        vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
+    }
+}
+
 static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
     IntelIOMMUState *s = opaque;
@@ -3428,6 +3449,11 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         val = s->iq >> 32;
         break;
 
+    case DMAR_PEUADDR_REG:
+        assert(size == 4);
+        val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
+        break;
+
     default:
         if (size == 4) {
             val = vtd_get_long(s, addr);
@@ -3491,6 +3517,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         vtd_handle_iotlb_write(s);
         break;
 
+    case DMAR_PEUADDR_REG:
+        assert(size == 4);
+        vtd_set_long(s, addr, val);
+        break;
+
     /* Invalidate Address Register, 64-bit */
     case DMAR_IVA_REG:
         if (size == 4) {
@@ -3671,6 +3702,18 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         vtd_set_long(s, addr, val);
         break;
 
+    case DMAR_PRS_REG:
+        assert(size == 4);
+        vtd_set_long(s, addr, val);
+        vtd_handle_prs_write(s);
+        break;
+
+    case DMAR_PECTL_REG:
+        assert(size == 4);
+        vtd_set_long(s, addr, val);
+        vtd_handle_pectl_write(s);
+        break;
+
     default:
         if (size == 4) {
             vtd_set_long(s, addr, val);
@@ -4722,6 +4765,18 @@ static void vtd_init(IntelIOMMUState *s)
      * Interrupt remapping registers.
      */
     vtd_define_quad(s, DMAR_IRTA_REG, 0, 0xfffffffffffff80fULL, 0);
+
+    /* Page request registers */
+    if (s->ecap & VTD_ECAP_PRS) {
+        vtd_define_quad(s, DMAR_PQH_REG, 0, 0x7ffe0ULL, 0);
+        vtd_define_quad(s, DMAR_PQT_REG, 0, 0x7ffe0ULL, 0);
+        vtd_define_quad(s, DMAR_PQA_REG, 0, 0xfffffffffffff007ULL, 0);
+        vtd_define_long(s, DMAR_PRS_REG, 0, 0, 0x3UL);
+        vtd_define_long(s, DMAR_PECTL_REG, 0, 0x80000000UL, 0);
+        vtd_define_long(s, DMAR_PEDATA_REG, 0, 0xffffUL, 0);
+        vtd_define_long(s, DMAR_PEADDR_REG, 0, 0xfffffffcUL, 0);
+        vtd_define_long(s, DMAR_PEUADDR_REG, 0, 0xffffffffUL, 0);
+    }
 }
 
 /* Should not reset address_spaces when reset because devices will still use
-- 
MST


