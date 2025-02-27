Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440C9C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneox-00089M-E0; Thu, 27 Feb 2025 09:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemp-0004Cs-Gu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemn-00049g-Gm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQFYgL5OvkIroXqJVu4wnMdYvtwWSlXNwP+wGqmQy7o=;
 b=NJwwNULcwB0Na8mjMLTB3WkbZBh/Dlu7cN4Hh2XFVTGZEEv+WWnqERb38HMaL7UOQFuGAM
 4ZnLmog9BMP4e3mqS9ZoX1a6w0Utp37VGAq41Ok5houz+nsYRqbmn0LHK6EbLYo1J0TxQt
 fMeQBygc4oYBWVSfj46Jf9mrZDrHbU4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-orNEhhvCMN2vqZtSNWExAg-1; Thu, 27 Feb 2025 09:22:46 -0500
X-MC-Unique: orNEhhvCMN2vqZtSNWExAg-1
X-Mimecast-MFC-AGG-ID: orNEhhvCMN2vqZtSNWExAg_1740666165
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abbc0572fc9so133538566b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666165; x=1741270965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQFYgL5OvkIroXqJVu4wnMdYvtwWSlXNwP+wGqmQy7o=;
 b=jOU7cF8J849JsNx3QqxKlTAEEVFJmmCUTFsbL6MRLd/3NCEoZjFNP7yDCoTRjSxV7r
 i5GiWGeoBI/K1L7yKLkxoTlu4BTKseLq+iIgEetbHdMIUzJwg4HMQlDoGzivArwazxZz
 kVOGODX3NusKr3jlKrLcN79iydZ/r4p4R2aSNDtEaWl6qE4WQiBe341/IyNtq993CVVs
 UER5qR15cw8kIdT7LyghcWY31rRBp3eMonsVB11FzGSNdY6Ptpfei23Gy9c+YnsAt/dO
 BcpfsMONGY74E2bJyggcsWpkjhOftQec7NtjdB6fIE5vG9XKh/ggrPnaYzizzA20xAim
 dgzA==
X-Gm-Message-State: AOJu0YwjSM6HzyTQJOapM4wnNxNu1NUl/oC144RBH8CBQFrHnos016Ns
 SgxWMpfJtP8MPtAueOAl/5zVeaZ6Ply/uuMRRHI+EzYqoW8meyEhtUJYMxOPd4NHgyQAHfVbXTC
 i149Q1LLBE+aZjhpppEihbH2/kf/DPobrG2ertgNDX4K9TxvP12x7tTB4fI9t2JTlmKiDAELp/r
 U2FQkOgKXDAZUG/f1Li7StGC2jVNe7dMFn9LkyFR8=
X-Gm-Gg: ASbGncukY7bIjJE7G3jfAtg7MZ9dr0QAOZIMigS24ousINVTAmJz3ngmNR3nZ4LPnf9
 NJJFhCx71t1JoLcFHGLioszSkD85laHPHuH88JVvJR1f7jGnPbC/NST5SsPQ84EPf98zg+l75py
 9XyKBv8OBRyJv3pefXLL8wINPJWfMtmzD4dFKNsg7GXGESLC226a45PZ402O3RZdzehv0aUFyFg
 V+QuzPK7pTpB9Zw2UZapyWq0SgriktP/hoCgsOagdYFu65TzzKBjq7ccJMmSeR2uE6Xy88LHdDm
 0UgpGBEfdUfzGnAPM6nu
X-Received: by 2002:a17:906:b818:b0:abc:29e3:f453 with SMTP id
 a640c23a62f3a-abc29e3f7cdmr2333890866b.33.1740666164965; 
 Thu, 27 Feb 2025 06:22:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCow23dBkk3rFhCa7lI/9dK6hjQRPITll/EpbdyAGB2nPmQzKCR6XsdnnEYg4+TFph+esQ9g==
X-Received: by 2002:a17:906:b818:b0:abc:29e3:f453 with SMTP id
 a640c23a62f3a-abc29e3f7cdmr2333887966b.33.1740666164574; 
 Thu, 27 Feb 2025 06:22:44 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c74c714sm129332066b.124.2025.02.27.06.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 11/12] rust: chardev: wrap Chardev with Opaque<>
Date: Thu, 27 Feb 2025 15:22:18 +0100
Message-ID: <20250227142219.812270-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 3 ---
 rust/qemu-api/src/chardev.rs  | 8 ++++++--
 rust/qemu-api/src/qdev.rs     | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 26cc8de0cf2..c3f36108bd5 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -31,9 +31,6 @@ unsafe impl Sync for BusState {}
 unsafe impl Send for CharBackend {}
 unsafe impl Sync for CharBackend {}
 
-unsafe impl Send for Chardev {}
-unsafe impl Sync for Chardev {}
-
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 74cfb634e5f..a35b9217e90 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -6,9 +6,13 @@
 
 use std::ffi::CStr;
 
-use crate::{bindings, prelude::*};
+use crate::{bindings, cell::Opaque, prelude::*};
+
+/// A safe wrapper around [`bindings::Chardev`].
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct Chardev(Opaque<bindings::Chardev>);
 
-pub type Chardev = bindings::Chardev;
 pub type ChardevClass = bindings::ChardevClass;
 
 unsafe impl ObjectType for Chardev {
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1c4a67b5728..18b4a9ba687 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -334,6 +334,7 @@ fn init_clock_out(&self, name: &str) -> Owned<Clock> {
     fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
         assert!(bql_locked());
         let c_propname = CString::new(propname).unwrap();
+        let chr: &Chardev = chr;
         unsafe {
             bindings::qdev_prop_set_chr(
                 self.upcast().as_mut_ptr(),
-- 
2.48.1


