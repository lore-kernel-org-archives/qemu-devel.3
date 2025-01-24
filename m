Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7795C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFG-0006I9-2I; Fri, 24 Jan 2025 04:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFD-0006FN-UL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGF9-0003di-Kt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0AomW1l4KHfrFLmCQFbvJtiWPWMXEyRVqhKBkK9J0U=;
 b=IC6vZHsZgq8UniK/2/M3+MP1h+l0edorGAK8j+Y7tNxh+X1PvHQzLO68+3CMPUTzFd1gOH
 sOz9BWTYGq2NwZjq/mCOJzLcKlKBmdE/KghlYyFXjYP3Yq3/IV5LCWmKUeRedbqCGmArpv
 BmmOJWTsMiaFNfxUbj3abs+scbqD0is=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-Hkik6ykTPre9I7ak76WZxw-1; Fri, 24 Jan 2025 04:44:47 -0500
X-MC-Unique: Hkik6ykTPre9I7ak76WZxw-1
X-Mimecast-MFC-AGG-ID: Hkik6ykTPre9I7ak76WZxw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso13410885e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711886; x=1738316686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0AomW1l4KHfrFLmCQFbvJtiWPWMXEyRVqhKBkK9J0U=;
 b=hgH437P3+3WIYzNLM834iAE1FxDASLbNemZ7hlFiiVVwjQqa3QhsG5/WZBWE7919Bs
 N8sZHZ98tjuQ1nQaqfG/EqT4SJPQTg+W5CuJHlP78YgBWKZNdPHIjkuBDp2SgMIz/C2C
 I6MShFc/cm6WW3fIlfyfYoknoCO0Rd6L3FxSbzVm9+Xv7fUpd9q34+VN2WKs9JvUgCZh
 j8b2jegX9LXqRB/NoEtaglvefWRlE3XTD5m31EiFlif8jxtZOTq4h3+ucea+5Bl2NojI
 xFhHlm61ynjP592QzQfgng6YhHW7ew42fI3CEODFyUUbKS1o7AmXYLOLstge4df9u0vb
 JcMA==
X-Gm-Message-State: AOJu0Yy7tQXhN9zUB/hWrum2o32Hcd1Bq11JVMXrosn14vPZGUt08ZxI
 we9INf3vF4ozHFW0RS6BoYMiGZsrRmnfDcDzQdhPcCm5a6kPzZwcSMupDPX/AkeATGOTT2dTJcv
 Pr9E+8D1MtHBmZ1aB95PwTh8ji+E9OfwdeoKQ8Vjt5ym2CWtxpHPZggbPG/ZEt64rKUSgvreS3c
 mS5DUQ6JX4JUGZeO0yX3lQCl+3jvlCPXeVvCJX67Q=
X-Gm-Gg: ASbGncvk4WXAU6w1EdiR9hSYrYvSE9KDTUt9VoyPeAa61JqbB1tgLLfM/udtnkC1FT/
 /bwGMtWhrSmS5FBaqiENdmG7p0MccKNPRu1982ga4NR7dJHCEQ2V68oVGUoKo7+T+D6ij4SZLpE
 ze+vNP2Gha9O42tmYkJBb8PwIVYMcJT58uC0lq8WE9RkbcwWxjzULW9dIP3Tvux8kiml7/Zf+ol
 k7JfsbvbVKC1tznN9UcoqM0BZnUsgzLpP2ts1oDc8g0KC5iicAVa4BNKOE2EFOJH2PO+hDhpw==
X-Received: by 2002:a05:600c:468d:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-4389143b715mr263482075e9.22.1737711885877; 
 Fri, 24 Jan 2025 01:44:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtYpfq86TqlsdTvONYYwiPM3ymHhxrk7p9ONPBPHO0lVsBIluOqPlON2PzaF5o6EBTQRaYLg==
X-Received: by 2002:a05:600c:468d:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-4389143b715mr263481875e9.22.1737711885464; 
 Fri, 24 Jan 2025 01:44:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54bfb0sm19669085e9.32.2025.01.24.01.44.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/48] rust: pl011: fix repr(C) for PL011Class
Date: Fri, 24 Jan 2025 10:43:55 +0100
Message-ID: <20250124094442.13207-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 994c2fc0593..65a1234b9ff 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -123,6 +123,7 @@ pub struct PL011State {
 
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
+#[repr(C)]
 pub struct PL011Class {
     parent_class: <SysBusDevice as ObjectType>::Class,
     /// The byte string that identifies the device.
-- 
2.48.1


