Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37337C0219D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLav-0005pv-8L; Fri, 07 Feb 2025 05:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLas-0005od-RH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLaq-0007sJ-NX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kI2fmnmJgUGnjqtQ5jhxKS9I/PiFpAzsz1KC537irc=;
 b=akER6aGBvhLuWWiPzkB+XplEFm8++uzOcbW449I3wE4uGlaJF0EqQKkRXImFL6GCraA6XA
 M+s7BOXwWUohMbuID/THEJ91ssmWJQDc0mOXrU7a41xorCZ6fRM2BgvCi2ZjaOGnap81on
 m11gjlTtmK94oKfdc7dQ1VVRazDdx0Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-FOb8e71HOXm7dPfe6xN15Q-1; Fri, 07 Feb 2025 05:28:14 -0500
X-MC-Unique: FOb8e71HOXm7dPfe6xN15Q-1
X-Mimecast-MFC-AGG-ID: FOb8e71HOXm7dPfe6xN15Q
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aaf8396f65fso209760366b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924092; x=1739528892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kI2fmnmJgUGnjqtQ5jhxKS9I/PiFpAzsz1KC537irc=;
 b=smXs4XPScS1FM1RtUgDfzldCi6//xeTAOp2Dm3zHG8SCfTTxR++ZyGgJJ95SK/Lzp9
 Oi4jHvUrrJppXlndNFO6R/bPEdd46Jbg7vky+0ErYgJ+1zP3PPrOe+1cWFYZSXts+C5w
 6ZC+QDcL6F2Q1UL+F3IBY8Tybh42hOdxQF6Qc/na+rrtUGxGNqeFYU1Gu7yYfauhsWHR
 r0xOjMLyBP+gO5rQ/2RzvejZMsI/qsroPuIRKLV6N881m8am1KJi7AOVzCqKpkZ676hl
 JilnahxhNYL71LO9HV60VO3E4wOKD4CwG8iUpwyQrlNMFUWLuEUcaWQUaaY/3ucp8mrl
 co9Q==
X-Gm-Message-State: AOJu0YwOyLZgH9ApBHjCi3Y4BUoKUA9oq6IN1wJ3MUmC5KcyOJdC7eWL
 WiFL65PfWSb5FwZnUPIHr53NI7jQxtCNPOpl5HJhMRP7geK9k1ErJehGQJq4nm5o3VyXAWieHyE
 hbo+GYF7GdBA/b1mGzdhfDWCDIVckwlyUpNuA6WmnRlLcg+VKd/LPrBoClRLLn2yXAEi+41XLAK
 Gs7uaq+jQXEeqaR2dGrUYQ7W3zzU1NcKH6/TW4WV8=
X-Gm-Gg: ASbGnctdglqKOPRFxClnM6BFCgVi77nqaMk2RI2ZEHXyROg56WFCRiUnmg2O4qtDv4a
 yAK3p5f6adSP9n6rbb+gdclO/PVHW3eV2Ghs/UeCR1Rny8GEea8K2gH87vEicQ7M8/AwsjAuJpC
 QaTxc33u4SITBEyqzhYaRFSK2eVMM2S5ymphU2vMy/CqKxDwMIUQ7Z7BgKbiOIOrtTLo4Syj9wc
 hzLb1F4lr4i239S3RkqU0veGenraHFhz1Mm1I817u1QK5vpFdn9Xo1yP3GiHwZ+E4tyDXUXrlse
 DBR1lg==
X-Received: by 2002:a17:906:ada:b0:ab7:8d1e:137e with SMTP id
 a640c23a62f3a-ab78d1e1d46mr155628066b.23.1738924091982; 
 Fri, 07 Feb 2025 02:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfUeP33wZR3cDdn0jUOw79zoaMhKbBKZm6uzexE9wQhlGYNF8MpEeNJJH6PkKlQyrx+Mif6A==
X-Received: by 2002:a17:906:ada:b0:ab7:8d1e:137e with SMTP id
 a640c23a62f3a-ab78d1e1d46mr155626366b.23.1738924091551; 
 Fri, 07 Feb 2025 02:28:11 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f84417sm243996566b.53.2025.02.07.02.28.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] rust: include rust_version in Cargo.toml
Date: Fri,  7 Feb 2025 11:27:56 +0100
Message-ID: <20250207102802.2445596-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207102802.2445596-1-pbonzini@redhat.com>
References: <20250207102802.2445596-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Tell clippy the minimum supported Rust version for QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.toml          | 1 +
 rust/hw/char/pl011/src/device_class.rs | 1 -
 rust/qemu-api-macros/Cargo.toml        | 1 +
 rust/qemu-api/Cargo.toml               | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 2b4097864df..f2296cad58b 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -9,6 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 8a157a663fb..dbef93f6cb3 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -12,7 +12,6 @@
 
 use crate::device::{PL011Registers, PL011State};
 
-#[allow(clippy::missing_const_for_fn)]
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     unsafe { state.as_ref().migrate_clock }
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index b9b4baecddb..89dee1cfb39 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -9,6 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [lib]
 proc-macro = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 4aa22f31986..a51dd142852 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -12,6 +12,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
+rust-version = "1.63.0"
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-- 
2.48.1


