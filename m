Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80092C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkG-0004lF-T6; Sun, 21 Jul 2024 20:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkE-0004d0-Rb
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkD-0005mH-5i
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kj1I/08pd2fWVIr2fyGlScWsVaYM95BuB4yW1kFmRKk=;
 b=jFKpmV7/xLs0nS81xkHgE75VGKbA5G4t0inEehdfkNJu6DklDXg0PuPx/5vlVLsscdcLda
 ntKtfymoWER9R0RK5+n277oHkOslKFEW1V9yvF4soj3hwzLnL8JH7tYgCh1DIAEJF/06pg
 GD9DUCSukTsIiJIbMNUv5uYy5Cp3EFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-jJopziRlODWWH4sjWJToTQ-1; Sun, 21 Jul 2024 20:17:33 -0400
X-MC-Unique: jJopziRlODWWH4sjWJToTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso27669245e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607452; x=1722212252;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kj1I/08pd2fWVIr2fyGlScWsVaYM95BuB4yW1kFmRKk=;
 b=kcIpAu1684WwDDJFe494jz9jTD9CrsOZF/GAeGlnBvpr8J2+d0FVqmDEUhQzg5dd7T
 hMgw3pziHqnKOKh+5uVfKqxgg7jcQ2N3jzw8hxw9ouBuLSQmJFHevzn6kPq/zlAR4BAC
 mZm1et1xOEfu1R8t8dpH6kBQhWQgbOH3ZLBHYfLHfNfyLOE53mntw0vvhWbh850hV5+e
 YYDn1ycmJBRY3sIVL3lq0SR1+L6WuQZZ8R1I8JhOM78tQ4Se1AUhxxR1hrwTu9FYhWww
 TLIEZvVEwx+yOGCjWWsNnKq5/qz9R10v+tYejKAaS69Lf5cY44yWlSyJ+8R2J/FLggNo
 Yi+Q==
X-Gm-Message-State: AOJu0YxTsGuIQplPnUYC4q4P+u26y4SehCbmWrMYSf8KgCbCWufYAS6W
 4IGV3CvKBIDrjMNovm+y7xn5Fw82BzUsOpYs1llsvvmhzC1PYE3H99rvZvtp5UVpjbhQApnSZJo
 KOQrfW/PYMiIFzBMLIHg2ykahpjzgC5ROdiMMxdGvX9nR23LAl4Nx8KxWa8s3ylE9Txln9D1QJP
 lPvZA0tu2wEraf/YgQ7EWOAyAD6M5n8Q==
X-Received: by 2002:a05:600c:4506:b0:426:6157:7ad3 with SMTP id
 5b1f17b1804b1-427dc524d30mr31190695e9.19.1721607451917; 
 Sun, 21 Jul 2024 17:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0/AfmVnPXaQvyme9KTq90TTEdPEvgb+Hp/7nQjdJ0PUxbp5XBMyeNiHGulFfEikaiYC0hmA==
X-Received: by 2002:a05:600c:4506:b0:426:6157:7ad3 with SMTP id
 5b1f17b1804b1-427dc524d30mr31190495e9.19.1721607451380; 
 Sun, 21 Jul 2024 17:17:31 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69019a5sm105703575e9.18.2024.07.21.17.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:30 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Minwoo Im <minwoo.im@samsung.com>, Yi Liu <yi.l.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 19/63] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Message-ID: <3a23554f91c01cf75705a36a5eed3ebef6636d41.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

These 2 macros are for high 64-bit of the FRCD registers.
Declarations have to be moved accordingly.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240709142557.317271-3-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index cbc4030031..faea23e8d6 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -264,10 +264,10 @@
 #define VTD_FRCD_FR(val)        (((val) & 0xffULL) << 32)
 #define VTD_FRCD_SID_MASK       0xffffULL
 #define VTD_FRCD_SID(val)       ((val) & VTD_FRCD_SID_MASK)
-/* For the low 64-bit of 128-bit */
-#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
 #define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
+/* For the low 64-bit of 128-bit */
+#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
 
 /* DMA Remapping Fault Conditions */
-- 
MST


