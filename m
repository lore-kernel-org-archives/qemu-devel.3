Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C02DC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrl0-0003Ys-Me; Mon, 05 May 2025 05:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrkq-0003Vx-MC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrkm-0005jJ-LW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kN1TGoVTaoRIcNAwQlBZk66AaqMf/VcTftHIBmCIyig=;
 b=AAdi2mb0ns4gC/VBzQ06Im2vxbye7kY9vs5+F6WUjxnTgAjO41h3RDsceru9vTcgPonpkS
 7BdmLdwtPR2V1DvDTpktyUuG0g36VNIyCFbD2V3wq5NXKRNsE/VnZ48mWeRqrOYQ7eb9vK
 n23By//c/S6HlT9cnQLl+h6H3KnUcJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6IFsoXO7MDOYzayrxMxBgg-1; Mon, 05 May 2025 05:04:46 -0400
X-MC-Unique: 6IFsoXO7MDOYzayrxMxBgg-1
X-Mimecast-MFC-AGG-ID: 6IFsoXO7MDOYzayrxMxBgg_1746435885
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso19982955e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435885; x=1747040685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kN1TGoVTaoRIcNAwQlBZk66AaqMf/VcTftHIBmCIyig=;
 b=jbaGQ7CHaw4uFtOkuuKiWDKkBhnnflxsVn16zvKMNDhId7iCEGJ35/tExmjQvBs4/Q
 YC7CQxrO3TJfJv1H1cwxVv5jPhIp3RZqbfdh6NUzF+6vHiR1u3uz+vnbyJTQOxWegBOF
 DV3VqGOv8qIfXrwxhrKdcJw0OtOJeQW0efPNxCwdbQwBmNUpPhilIW7Be9UvxB8yh0y7
 LKml4BNxA3rRQVknC98SmTOerrYTmgT0xB27HZgcCV/tyiEo2HZIQ4BRshhGrHUI6amm
 ieFW//tWyj6AKLGSP8fcWz+l/F7w8IbxgA5LhEX4IoJbDrinCcUfAbeYTN9opljt1XuL
 a78w==
X-Gm-Message-State: AOJu0YxNA9jV+ljw0WL37qaMakjHlup/fhr+KnJI+ENqilRajS7TDPwt
 fCpSQo8awEbuzOEsTPb4V2vJ/PxFtAFDggoKaQgZdB/uA0fHIRXcCx3+JYjkTavc4yq4txc0Mmf
 iJA23WppqKvgGbdHeIIewcgkSidO/4Ai29Jb9loMv/ZFwQSwpUtXOZhVaexVJftVE7EjR262JKz
 X4I2gc1M0eYfw3xMfbRcxiLyfmn+W8sDK20Tfi
X-Gm-Gg: ASbGncs/wK4GE9SVfSbFcXBv6aLtSWuXhRiI9dzfxc4exJMW9w552ufdNgSNyP1PCIY
 3BUHZNDrj/6lw/V3tjl4XKaS7zUovlosoHt9yeMyhSnjftWsJuvrg/RvHYEIOPdXBrIQSN0GIYu
 wHnZINdcw7ZTEf/e2iaLc/wrEVm9+unw959n4QszyJeOJQkb1XZGr+R0ksHIXAi8LpszMS24zxo
 uLIMTKmMmTIUxPwDH71IXpaXsMpPYN9C+LhbtiS0VjwHWbBJttOZrAug/nVSwfxLIYSZTY47OCm
 S5Tn+WWMd6vLz88=
X-Received: by 2002:a05:600c:8288:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-441c48dbf43mr51099225e9.19.1746435884765; 
 Mon, 05 May 2025 02:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl38gFWyU13dgPDDOfB4VMq78dJaWZuKUcTbTyCJHJ8bVfnfjoJE3CXXKsmQwiye5TRTKrBw==
X-Received: by 2002:a05:600c:8288:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-441c48dbf43mr51098815e9.19.1746435884217; 
 Mon, 05 May 2025 02:04:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8992b4csm129623495e9.0.2025.05.05.02.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:04:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 02/11] meson, cargo: require Rust 1.77.0
Date: Mon,  5 May 2025 11:04:27 +0200
Message-ID: <20250505090438.24992-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build      | 6 +++---
 rust/Cargo.toml  | 2 +-
 rust/clippy.toml | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 8ae70dbe45a..e77da3f9b75 100644
--- a/meson.build
+++ b/meson.build
@@ -94,12 +94,12 @@ have_rust = have_rust and add_languages('rust', native: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc = meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.63.0')
+  if rustc.version().version_compare('<1.77.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.63.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.77.0')
     else
       warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
-      message('Please upgrade to at least 1.63.0 to use Rust.')
+      message('Please upgrade to at least 1.77.0 to use Rust.')
       have_rust = false
     endif
   endif
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5ace47c69be..eda7980b31a 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -12,7 +12,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
-rust-version = "1.63.0"
+rust-version = "1.77.0"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
diff --git a/rust/clippy.toml b/rust/clippy.toml
index 5d190f91dec..933e46a2ffb 100644
--- a/rust/clippy.toml
+++ b/rust/clippy.toml
@@ -1,2 +1,2 @@
 doc-valid-idents = ["PrimeCell", ".."]
-msrv = "1.63.0"
+msrv = "1.77.0"
-- 
2.49.0


