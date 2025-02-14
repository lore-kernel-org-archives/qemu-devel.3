Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF243C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwDR-0005xI-Sg; Fri, 14 Feb 2025 08:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiwDB-0005ug-Cq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiwD8-0001dR-9Q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739541509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jtNzr8uYuWTsnD/A8rhDCCpOJ/XgomM+/PA3Y3Q8jKo=;
 b=V8by4t06LGqW94sQArG298kLGkAmCwsSutk9c9nVp7VIe194RUTXMuoChTiMuPvcIeExxy
 w7a1Zg6uTFnBHZxAIcOQ80hNiXsPNT2TMySLiER4dfTeOx3KZ9Gbomg+WJQgB/qWEC2qx+
 ksabgT02QTnS9bcfQy7ZsqTWQicH6m8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-DrEpiT8VPQ6WS7Jq2nLQfw-1; Fri, 14 Feb 2025 08:58:26 -0500
X-MC-Unique: DrEpiT8VPQ6WS7Jq2nLQfw-1
X-Mimecast-MFC-AGG-ID: DrEpiT8VPQ6WS7Jq2nLQfw_1739541506
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abafbdf4399so22513266b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 05:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541505; x=1740146305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtNzr8uYuWTsnD/A8rhDCCpOJ/XgomM+/PA3Y3Q8jKo=;
 b=g/Ab/u0ZiEr/o22/3Q/VfDXu0V5M9AOPD1j5lv2k6LpP17Bz34YbjH4AZOzd45cyyz
 lAngCr59baF9Wt0FCwAXtw4x5ITAlqfDVCyYtg8YT+1vMyWUAzjD5o+DksSS3+Dd+YjR
 XkYdEsmIWQs7t62Cd+473N9e7aWmySH1D3qhyK2FGRfbKwG/X2PGm5YgGW6F7Vn05/hK
 m/lukeNuh9zV/S9Uzzr4rKoEiyCsFIKBpTrDFxfC3C46FCG/T6/eW0ntaVM6QPGTSXYa
 nNG0/n2Nn13mhmPxJfRTcq/GC3US4YhZ+h9LQ6k+aPyqm0pw8/XHhVxwLeG9cwESHkqc
 s90g==
X-Gm-Message-State: AOJu0YwGtgDRwpLDBluTT79FYyHXypxoCAAcMr0ymytO6AZq8R6f0tAk
 vtg/TTgCJug90gTkHCoiE+8J9m2jD+1llSryupDKk3uZBJO1PmrqOVZThVWeVfMuWxAoeeLfQbd
 Xrm+RdwhnQT76jNIGdN+nrkWUsF6hMn1qNwznbJa7a4n7cagKCVd/HP6VrAVke/yATfpU28FhY/
 xomgtha7v6GzhktP87hZ63qTZ4JTMGE3MIh/QFeRA=
X-Gm-Gg: ASbGnctWYq+dVC8jhMSdsNFN0M++ATo/7SRYpMoKEgNEDaaMwtS7AJ1fnI1OzlWmez1
 ACWgrwGnRiAYMAFU0oZN2tHV5mOjZL0knlnZR001vJFeL9z7XN/TMflxPWS2mdBwMC3fK3aaXIa
 sIRukrk78zFjBa+gCazxI3FUyJgdnvqZ5JxpFDroy0FS9zls/bK642JmrEPMeGCQGVTBJyjLpCR
 yny1AnhIo9rYRX3m4RB67eof0CYxAcum9h5k1a4ygfRAakdCaLMF3At/vmN4cDycTL/+BAwKa/K
 ELZtcM9o+Hb2
X-Received: by 2002:a17:906:7151:b0:abb:5b02:9e7 with SMTP id
 a640c23a62f3a-abb5b020aa8mr2969766b.12.1739541504893; 
 Fri, 14 Feb 2025 05:58:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnd4L+j5QGaGaudDq+u5OiHlAq07wQAxYnMKf3Q+05rOF+4KgPrZDiR0QtGxX9p2WukgnYuQ==
X-Received: by 2002:a17:906:7151:b0:abb:5b02:9e7 with SMTP id
 a640c23a62f3a-abb5b020aa8mr2966866b.12.1739541504471; 
 Fri, 14 Feb 2025 05:58:24 -0800 (PST)
Received: from [192.168.126.123] ([151.49.218.237])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532580c5sm350436966b.56.2025.02.14.05.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 05:58:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: tests: do not import bindings::*
Date: Fri, 14 Feb 2025 14:58:22 +0100
Message-ID: <20250214135822.4076174-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Similar to the devices, spell the exact set of C functions that are
called directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/tests.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 92dbfb8a0c8..03569e4a44c 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,13 +8,14 @@
 };
 
 use qemu_api::{
-    bindings::*,
+    bindings::{module_call_init, module_init_type, object_new, object_unref, qdev_prop_bool},
     c_str,
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceClass, DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, ParentField},
+    sysbus::SysBusDevice,
     vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
-- 
2.48.1


