Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630E7C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPWU-0004cI-Ce; Fri, 07 Feb 2025 09:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgPWS-0004a8-8x
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:40:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgPWQ-0004Yf-Ik
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kBAuUoUPVP2WG2hJX+48568E2xfoRBu7145/uvULUPA=;
 b=W2laYpevCyRJVWxH3vNAYtxMx7/1XWLdVtHvIceFCgU6auKTl8A78xUul+nPJSDZ110GAe
 q6tuhE743andgSZf0gpapQzv1cqdFRDTbGQV3HTJ8pjcQfApIZiad6s5X0yYQVh5YSO6YC
 lU17XhbRc3aRoNirqpk0TGA4HGSfAw8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-KtU45vk8P4KpS7JqN1nCuA-1; Fri, 07 Feb 2025 09:39:56 -0500
X-MC-Unique: KtU45vk8P4KpS7JqN1nCuA-1
X-Mimecast-MFC-AGG-ID: KtU45vk8P4KpS7JqN1nCuA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7912ce928so50648366b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 06:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939194; x=1739543994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kBAuUoUPVP2WG2hJX+48568E2xfoRBu7145/uvULUPA=;
 b=hIVDPasMMAVJsHXAAKL8XNcijiqNf5NGMfshQzkXAwPmmpLoM2yIpB0PxSkfb2Ha47
 PiD+tuSKB96UwEd3ZyWYTOLUf+EaAnt/gVcaDlGKPQgTkQ45IpYaQ1N6HF3HysXuLBPt
 +bV4BN6yoDSIX0Hu6EfIIwUZgXBH0zQJf1dQtGdkqmn/CYro2MG0g01cgHWHyQVgcKy+
 v6QlnPak9WxGxZDFOueH63h5udgtEOFEGrh875xguQX36U9GUX/1uRxDMWgj7rVcXGbT
 6Tvd5XNxrovJ29iBak62UnSoQLEeG3Kpz/2OHVi9ukWltGu3hJwCm4jQD0C4ZnEIIfzs
 XX8Q==
X-Gm-Message-State: AOJu0Yw+pozfWwvXqcvbnUznz6IJavKRlK1ITUAYh+DYyh10mqrrSPk1
 K0V0bkqHBROqYCoR0nRdOA89Ffg9toZdtc7M0eXgpZ/Hm0EE0YwznII9F2jZoZbazufLmHahezF
 7aTzMgVYkb/82afDclgNR5Nw2Y8T5h2kHKSuCTUDbhPUqXh6ytx83BK15PqrtH4GnevXfgozSH5
 WxIoFh78v0ksJJRF5KOetoaDSen2frvpPQS+pxNoQ=
X-Gm-Gg: ASbGnctKgPF6sWnUS76ji19cFu0r1s9sygD1YOC4RRkSoU3AIU5J6D/cn10+LRVrrH9
 pzn6/s2UAVICDL3VCOUtJ2EyKfsD1lcxKnKUcfPINY8vwKiEdmpBkRrFYNbVty60ZDVZS3PbPAR
 meuSM45XZ2hULS/SA9tiR3nxgfkg4y6CmBLtvajll9sjofS4GJ5fvZSsCpuc6l8XEjbek5sJhJy
 bWISeziwx7RwBdqSbYem5bVvFpkViIoHBzLq20fu2S7hS83CTA6V2/kqC823yvf70pNHUByGOhY
 AwhgAg==
X-Received: by 2002:a17:907:2989:b0:ab7:844b:fcf2 with SMTP id
 a640c23a62f3a-ab7844c0063mr306980666b.6.1738939194095; 
 Fri, 07 Feb 2025 06:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhSCcd3SvV7BrIzTgJaA/OSa0qP3qY8f3hr52KRwrUh+Jh+dw81kUC35ZBcBxblwZQr7lLBA==
X-Received: by 2002:a17:907:2989:b0:ab7:844b:fcf2 with SMTP id
 a640c23a62f3a-ab7844c0063mr306978566b.6.1738939193746; 
 Fri, 07 Feb 2025 06:39:53 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab78e82cc0csm98185666b.12.2025.02.07.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 06:39:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH] rust: pl011: use default set of lints
Date: Fri,  7 Feb 2025 15:39:51 +0100
Message-ID: <20250207143952.2486587-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Being the first crate added to QEMU, pl011 has a rather restrictive
Clippy setup.  This can be sometimes a bit too heavy on its suggestions,
for example

error: this could be a `const fn`
   --> hw/char/pl011/src/device.rs:382:5
    |
382 | /     fn set_read_trigger(&mut self) {
383 | |         self.read_trigger = 1;
384 | |     }
    | |_____^

Just use the standard set that is present in rust/Cargo.toml, with
just a small adjustment to allow upper case acronyms which are used
for register names.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/lib.rs | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 88452dc888c..1bf46c65af2 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,16 +12,7 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
-#![deny(
-    clippy::correctness,
-    clippy::suspicious,
-    clippy::complexity,
-    clippy::perf,
-    clippy::nursery,
-    clippy::style
-)]
 #![allow(clippy::upper_case_acronyms)]
-#![allow(clippy::result_unit_err)]
 
 use qemu_api::c_str;
 
-- 
2.48.1


