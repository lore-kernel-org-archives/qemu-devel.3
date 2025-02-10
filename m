Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD815C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwk-0002QX-V2; Mon, 10 Feb 2025 05:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwj-0002Pi-2Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwh-0000NW-Gs
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1s7l6TURQyL8eCO9/e3NPz0hlAdj5Twhr0tY7ty5ok=;
 b=KSy6fc4MX8bYfnLo+MIhvXBI0gNs+xA8G19AbmrsRAyfQg642ihUUU4DMpFNEuVEcBZ88S
 ElXA2kLGQCH6W8r47EEjVSFMZVSFK4uqlJb+eIhCgOr5RqadgRr0OWKdcWwqgdst9SOmLr
 ZClWjSWN1n7kMNihOZ2XZbzeNS2uGls=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-37GHqKcwO-iTkHSEd01aNQ-1; Mon, 10 Feb 2025 05:23:17 -0500
X-MC-Unique: 37GHqKcwO-iTkHSEd01aNQ-1
X-Mimecast-MFC-AGG-ID: 37GHqKcwO-iTkHSEd01aNQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab7a7c8c70aso179698266b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182996; x=1739787796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H1s7l6TURQyL8eCO9/e3NPz0hlAdj5Twhr0tY7ty5ok=;
 b=Yi6vkbLBcGYqQKpTl+E0ZzhImampqmr+bf66KIlHaK9EQGoBGfktUyHKMnS4UY6wc2
 ODo5PnTkn1GxFTFl6SZppt5rUaWlSq2h8fVAGVGUmgE34eN8HzfjQdxkCjgHpdXk+JqK
 dZeo4uOXEu07vCcWwn9MyCltIkGu+d/ubY1luFXWPcjrS9zhxGSu2wEItacWDvJz7iq4
 E8Bj6T15IWO9dFCoNdFQUnPfY3pGQliA9NjaduK6btaCkRH2gTxnUU5vuQGDF3IjZkTH
 J2/IOotY8VYRLIUK3SPF/o7OcYS66UAM5aPF0zxjqVNpnq88o9DmHh98PRM+GuJ11PFc
 RiKg==
X-Gm-Message-State: AOJu0Yzp03bmKG0WHqaF7IsZQHIC5mz/Q3vc8l2lRhqCEV9+yNrYmcRU
 sMJL7T3C4vOUdimiPgjkHB6q6Z8IcQmdXJqriz9ySenaF2PLl9j8fszIdcv9w1Ypc77M/bUwrgx
 hhOsNzhkymbj2n6pQ4vsu0uwchNvJJI0rShBxam0QqKdqr2rehJrIr2w8yefyAk6p0Cgj7RXtaB
 650sQPMmUfog8FA+XqXL2Syzr8HHBQEendNPPbZU4=
X-Gm-Gg: ASbGnctLaOt85VgqdCFm7uzoXFgeN0gdyLoYoPMFu2+9xQ7fjvIbxXVAp2TdLBpFu4u
 uib0XJfkrCcBo+7fHAUNFGnlEIHwMSomXhyCrEdRo88bAC8JNWSPzglaNQXUGtCacHa16hApydo
 xvy6Lem+TVDl7qoVucNtGb32q3p7VghInHvuXXRWqwEXMc0Ye65VQZMagK/71Hf2eOCrHfGj7NE
 ZFt7EAoOttn7VLdsBJtnEaCAAZ/dKof8ho4vtt+lngtimNNmQYDr7oH3p2JhVLSL4OJp7Gsjrxj
 kO+1Pw==
X-Received: by 2002:a17:907:724e:b0:ab7:9648:17be with SMTP id
 a640c23a62f3a-ab796481894mr1046879566b.19.1739182995776; 
 Mon, 10 Feb 2025 02:23:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8IkewaN9mhFyqOkM4ANoRkpKHLlQsYyCryzjrwZgoPgEXFTOlNU6yoxnnNq+tcEo4VrR+Gg==
X-Received: by 2002:a17:907:724e:b0:ab7:9648:17be with SMTP id
 a640c23a62f3a-ab796481894mr1046876966b.19.1739182995184; 
 Mon, 10 Feb 2025 02:23:15 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab78ee9e208sm663264066b.50.2025.02.10.02.23.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] rust: restrict missing_const_for_fn to qemu_api crate
Date: Mon, 10 Feb 2025 11:22:54 +0100
Message-ID: <20250210102255.2555097-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

missing_const_for_fn is not necessarily useful or good.  For example in
a private API you can always add const later, and in a public API
it can be unnecessarily restrictive to annotate everything with const
(blocking further improvements to the API).

Nevertheless, QEMU turns it on because qemu_api uses const quite
aggressively and therefore it can be handy to have as much as possible
annotated with const.  Outside qemu_api though, not so much: devices
are self contained consumers and if there is nothing that could use
their functions in const contexts that were not anticipated.

Since missing_const_for_fn can be a bit noisy and trigger on trivial
functions that no one would ever call in const context, do not
turn it on everywhere and only keep it in qemu_api as a special case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml          | 1 -
 rust/qemu-api/src/lib.rs | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5b6b6ca4382..5b0cb559286 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -52,7 +52,6 @@ empty_structs_with_brackets = "deny"
 ignored_unit_patterns = "deny"
 implicit_clone = "deny"
 macro_use_imports = "deny"
-missing_const_for_fn = "deny"
 missing_safety_doc = "deny"
 multiple_crate_versions = "deny"
 mut_mut = "deny"
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 83c6a987c05..3cf9371cff0 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -3,6 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
+#![deny(clippy::missing_const_for_fn)]
 
 #[rustfmt::skip]
 pub mod bindings;
-- 
2.48.1


