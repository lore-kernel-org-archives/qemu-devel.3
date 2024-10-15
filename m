Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1ACD216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hR9-00025S-Oc; Tue, 15 Oct 2024 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR5-00024D-Ga
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR4-0001EU-3g
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59Gpr3pRmXw/Bed6+2Hl7KYTM3heYGiGwIXaAgGlVZY=;
 b=KftV6OFMSenHuX1HGkThk0KlsKuiBnJnfLc5TvQUcde7LK7P0uJG+IqLbwmLvMThIK8k1x
 +KK2E+Ui2iVUVGWEjwBqrJgj2jl3W+kpLjyk21Xd1f/dLx5sRshKvHtN3upB9AetDlSejG
 +KNTk091dT1Ru7spT6NQ8SgO4JQ10q0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-jQv9aF-oOumVOSp3n7n-gA-1; Tue, 15 Oct 2024 09:17:59 -0400
X-MC-Unique: jQv9aF-oOumVOSp3n7n-gA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4311407ae76so28011395e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998277; x=1729603077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59Gpr3pRmXw/Bed6+2Hl7KYTM3heYGiGwIXaAgGlVZY=;
 b=mIJQMPb9yxR02rJ1Lmp9Ws2HlojedBE+oSWN6RsjdGfs7GQbwms7ceHSY9+pkXToYF
 9D+qpBvXPhzU3fyMzEIr4Fr0QTnedpuznNusghYPJlTc2EtPLyei65SYxYYLmymJoViV
 POZz7Kn1c82zntLeSQ7xUz0vPUkBlGJsC5bVRxUrh1HsSNaaM6hvykc5/sNJJWsH3ZDS
 BQgR7gOeZfqIoKsw5Pft95EwN2RNCV2ILdGwlgSQ2nVcK1bAt7AF0JgTfXWGatwGnXxv
 7qTXnle0tqj4K/jwQ6+J6AsECOELikVW5GP+5mse5MaBSZwV/Wv0YafN23lGOfcxohqI
 33Hw==
X-Gm-Message-State: AOJu0Yx4rrsroXfLWYhCodPGyXwxASN50zf6K2J35A83L2bZFXx7qakp
 JN0BeqiZ23T7phIfz/0CPDgLR/GUNl65xNNb8fvAqV0+614x5BdiSXW2fsiRkxvfhQ5uOsM6uoZ
 bmnyzX1kJWrPIky/5sHIQiUYgNRl5Zy4cq6jyVkeFYoGx6lZVTviOV2/MRTxE2/QfK2686O9DcH
 bHHXGbDHaO2rlucALo1f41yP/47oo82LLMTRx6iLU=
X-Received: by 2002:a05:600c:4514:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-4314a362525mr4815335e9.28.1728998277615; 
 Tue, 15 Oct 2024 06:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs5g1AvsA+4+WeKzUhVAypQfc5xYgEBTUPN48ZEbBfTAU/1Hk5Japv5k6VQRJ5kJ/q276/WQ==
X-Received: by 2002:a05:600c:4514:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-4314a362525mr4814995e9.28.1728998277047; 
 Tue, 15 Oct 2024 06:17:57 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314209688dsm15198585e9.14.2024.10.15.06.17.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] rust: do not use OnceLock for properties
Date: Tue, 15 Oct 2024 15:17:24 +0200
Message-ID: <20241015131735.518771-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Properties are initialized lazily but always accessed within the big QEMU l=
ock.

There is no need to have a OnceLock around them, and also OnceCell/OnceLock
were only stabilized in 1.70.0; so remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index b6b68cf9ce2..87892b50c63 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,8 +2,6 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use std::sync::OnceLock;
-
 use crate::bindings::Property;
=20
 #[macro_export]
@@ -73,12 +71,15 @@ macro_rules! define_property {
 }
=20
 #[repr(C)]
-pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn(=
) -> [Property; N]);
+pub struct Properties<const N: usize>(pub Option<[Property; N]>, pub fn() =
-> [Property; N]);
=20
 impl<const N: usize> Properties<N> {
     pub fn as_mut_ptr(&mut self) -> *mut Property {
-        _ =3D self.0.get_or_init(self.1);
-        self.0.get_mut().unwrap().as_mut_ptr()
+        match self.0 {
+            None =3D> { self.0 =3D Some(self.1()); },
+            Some(_) =3D> {},
+        }
+        self.0.as_mut().unwrap().as_mut_ptr()
     }
 }
=20
@@ -104,7 +105,7 @@ const fn _calc_prop_len() -> usize {
         }
=20
         #[no_mangle]
-        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> =
=3D $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_pr=
operties);
+        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> =
=3D $crate::device_class::Properties(None, _make_properties);
     };
 }
=20
--=20
2.46.2


