Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA2DD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sW-0006FW-Ti; Mon, 04 Nov 2024 12:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sU-00065m-RZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sS-0000Or-Rs
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdHMmVfohK45Fr50VMfZShEdcQTZfzv07i8pTppE0kM=;
 b=GQY2Hw1ux5HE/piWQFJZoAbU4w9m1kmNPIPYjjj37uJnc3gVslSJD74XpI9+4YHmmCbymb
 bxUzK1AFlNmXeFS2zwC1ZQloUVPAGYGJ32ak6EKsf3AsqBeOoWvY5hWXot+iAEoTK4I3IG
 d91ZEtU7zmJ0it6iFkQpYdR4KLdW+uY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-tW6MRQIuM2Se0cMouWuQVQ-1; Mon, 04 Nov 2024 12:28:30 -0500
X-MC-Unique: tW6MRQIuM2Se0cMouWuQVQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso38309135e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741309; x=1731346109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdHMmVfohK45Fr50VMfZShEdcQTZfzv07i8pTppE0kM=;
 b=o3T98bYjx4iE9RF2PRVshqDx40O3tP7YVGfJien5yulvxT+7QXF3jNA6+HS4HqszKD
 SdJondPGLqDnTdYTZ4qaAVvXAcpsSZJ2B0adJ/0w8671xHgvHgHVNeqtMh2yv5uGJeMz
 gHa/+FS0x7XXT6womu6PTOoZZ1BPTAQv/JwSC69nV9gqXr1r6/xHbFBLWap3YVTCRiHT
 O+P94VSiEmmKJRHaW07V+qypzGYUDLHqsKAZeD/U8KkZiNOiyeJ4J/FQSUyg9uwx91ot
 IIyla+xkZkG2De2whbIvGkD1r7YmQPdAcE9QCPzzl4SFbkskHUCUYZ99+JIWp1BAtD9B
 aUdg==
X-Gm-Message-State: AOJu0YwBgNt12Ez//8bwf+p6aRsRB7p8393Q1OlOnuY2SnseNIgf3Z+b
 h/2Fgd2RvBydFNtYZPk4tFQO6WLv5CnHgo7C8Gw7u15uF8r/zMzD1A6kYFS4SBBI8U//0YzPQnz
 yycXmujoO8ockhCExYIHW74LHZ7tuDXTr+k9AMvhd3n3d2h5XTor+nv/vpmVmUJqGzakLUj2AGs
 m1gyqbnCKejpuyOCEBOYwRJ+3WjhGQMFCefUd3DNk=
X-Received: by 2002:a05:600c:4f03:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-43283242c79mr132381675e9.7.1730741308732; 
 Mon, 04 Nov 2024 09:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3U3PhA9oiqybUevLrWXLbkRca0oltLj3nmErSUOHX/BRWgfJUQgQYWGgKrFO6uWOOYEX+1Q==
X-Received: by 2002:a05:600c:4f03:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-43283242c79mr132381335e9.7.1730741308303; 
 Mon, 04 Nov 2024 09:28:28 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf225sm158612575e9.11.2024.11.04.09.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 30/40] rust: synchronize dependencies between subprojects and
 Cargo.lock
Date: Mon,  4 Nov 2024 18:27:09 +0100
Message-ID: <20241104172721.180255-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

The next commit will introduce a new build.rs dependency for rust/qemu-api,
version_check.  Before adding it, ensure that all dependencies are
synchronized between the Meson- and cargo-based build systems.

Note that it's not clear whether in the long term we'll use Cargo for
anything; it seems that the three main uses (clippy, rustfmt, rustdoc)
can all be invoked manually---either via glue code in QEMU, or by
extending Meson to gain the relevant functionality.  However, for
the time being we're stuck with Cargo so it should at least look at
the same code as the rest of the build system.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.lock   |  3 +++
 rust/qemu-api-macros/Cargo.lock |  8 +++---
 rust/qemu-api/Cargo.lock        | 47 +++++++++++++++++++++++++++++++++
 rust/qemu-api/Cargo.toml        |  1 +
 4 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
index b58cebb186e..9f43b33e8b8 100644
--- a/rust/hw/char/pl011/Cargo.lock
+++ b/rust/hw/char/pl011/Cargo.lock
@@ -91,6 +91,9 @@ dependencies = [
 [[package]]
 name = "qemu_api"
 version = "0.1.0"
+dependencies = [
+ "qemu_api_macros",
+]
 
 [[package]]
 name = "qemu_api_macros"
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
index fdc0fce116c..73c334e7ce9 100644
--- a/rust/qemu-api-macros/Cargo.lock
+++ b/rust/qemu-api-macros/Cargo.lock
@@ -4,9 +4,9 @@ version = 3
 
 [[package]]
 name = "proc-macro2"
-version = "1.0.86"
+version = "1.0.84"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
 dependencies = [
  "unicode-ident",
 ]
@@ -31,9 +31,9 @@ dependencies = [
 
 [[package]]
 name = "syn"
-version = "2.0.72"
+version = "2.0.66"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
 dependencies = [
  "proc-macro2",
  "quote",
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
index e9c51a243a8..e407911cdd1 100644
--- a/rust/qemu-api/Cargo.lock
+++ b/rust/qemu-api/Cargo.lock
@@ -2,6 +2,53 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "proc-macro2"
+version = "1.0.84"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+dependencies = [
+ "unicode-ident",
+]
+
 [[package]]
 name = "qemu_api"
 version = "0.1.0"
+dependencies = [
+ "qemu_api_macros",
+]
+
+[[package]]
+name = "qemu_api_macros"
+version = "0.1.0"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "syn"
+version = "2.0.66"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 3677def3fe2..db594c64083 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -14,6 +14,7 @@ keywords = []
 categories = []
 
 [dependencies]
+qemu_api_macros = { path = "../qemu-api-macros" }
 
 [features]
 default = []
-- 
2.47.0


