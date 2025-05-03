Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D8C3ABAD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mf-00089y-A0; Sat, 03 May 2025 03:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7me-00089i-Bo
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mb-0006hb-MP
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZlNu/zAQqkffDlM4a5lM4vT7ViwyhlINcDJMaSxm6M=;
 b=h9OP5Yz3JastVLlSZHQ/g7hn80atR9c7CEwZJNq0SrTOMogcwAUi6oB73oRx/5QEnLerf/
 CK29FC/ConBkjcag1NBWjTHJXMRKEyHqh9MD1RCfTuLtdMBjlQV5raVs6mtbAhnqyXY2gV
 e0KdV860uiCiZWsDEcEMZJQvrBoGee0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-xptz291VMb2Vehq6Haq8HQ-1; Sat, 03 May 2025 03:59:34 -0400
X-MC-Unique: xptz291VMb2Vehq6Haq8HQ-1
X-Mimecast-MFC-AGG-ID: xptz291VMb2Vehq6Haq8HQ_1746259173
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so14312445e9.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259172; x=1746863972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZlNu/zAQqkffDlM4a5lM4vT7ViwyhlINcDJMaSxm6M=;
 b=bVobOPLB4iSRe1nfNGy2Ja9g8H+zc38be/DABR4VaYvM1OBtFXyNcRYo3SO0btxVzm
 KrkW/nZ3az9pcIEaUuVAh73Z/oP8fNXCPM4FhOTvmWNYb1Lrq+WplrNFyIVl12GtyoC1
 lvKJg5t/SUJ6RVnVWRvgLuyM7EvF4ht4ZuTlhENekPGdffWdttm9JHfVc7L8ImbvrlXO
 WYH6xun6/CPX5PqxsjlrB19IuhDKxyoKYRbThNWHylQBHjbxkKEXLDVE+4J4fj/mwXAn
 YWIeC8pDAkB4zENxCIpPNessTNgEcb0F7WhSw1+jzrAey78GxOwpuWlDwdMSI+dL4SB3
 JN9A==
X-Gm-Message-State: AOJu0YzCq+d9/rnALZZ4/uxoF6G5sGcmDZt/yTART1iwOmYLZAcyBk6F
 re+rPUFP4UhPSSyK07xnpdaNEgF/8t4yue1CdDOewsz0qcPGVGerHVJLUucREQW7pFxKE4AGqOT
 WvPDrPJQeuNG+CP78QgnDCHeuJm2vyDbmqkOPp6YTtacW93eK17zk1N74XD91FTGPeaViqvkx/9
 F0rYz5/po+O7G18LNAYq+8QKf5587CTw3dIb4x
X-Gm-Gg: ASbGncvYgpD81EnneKrLXPbEVf9LrbsoS8/Zn139yhxWixpNEWZkD9uffmEO4Sn7gMK
 IhZJkS4vLig9tVdFHdfYybM6gLJsmBqSwbvFYpdadZ3bW/+JbOwN+NDaQqlu04JdIZKgOXOpQ+x
 Ml1zs9K3Z3vBdo74XImnBUhfrUjk0NbF1BfxPMYXPkuJWQT8UMwyFfE53LNuyRLmwhwD2RQYaZI
 hF0YAKypm76Khy4/+odwHJhoSxQMrAZYwreBmH8gi0Jdg3qCDEZ/sqECZl6h0+VjTZfS4c37E0K
 fY3z1bPRP+yciWc=
X-Received: by 2002:a05:600c:384d:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-441c1cc4764mr15391225e9.2.1746259172626; 
 Sat, 03 May 2025 00:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwWks9opavqtYWXhFblp/rTbQowm4793vY0brDm+L4ISDmkBso/lKPgKXW0IMUb2RpoK6Tqg==
X-Received: by 2002:a05:600c:384d:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-441c1cc4764mr15390985e9.2.1746259172234; 
 Sat, 03 May 2025 00:59:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315c8sm66561785e9.35.2025.05.03.00.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Zabka <git@zabka.it>
Subject: [PULL 12/13] rust: centralize config in workspace root
Date: Sat,  3 May 2025 09:58:57 +0200
Message-ID: <20250503075858.277375-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Stefan Zabka <git@zabka.it>

This commit bundles common config option in the workspace
root and applies them through <config>.workspace = true

Signed-off-by: Stefan Zabka <git@zabka.it>
Link: https://lore.kernel.org/r/20250502212748.124953-1-git@zabka.it
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml                 |  7 +++++++
 rust/hw/char/pl011/Cargo.toml   | 11 ++++++-----
 rust/hw/timer/hpet/Cargo.toml   |  9 ++++++---
 rust/qemu-api-macros/Cargo.toml | 11 ++++++-----
 rust/qemu-api/Cargo.toml        | 15 +++++++--------
 5 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index ab1185a8143..5ace47c69be 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -7,6 +7,13 @@ members = [
     "hw/timer/hpet",
 ]
 
+[workspace.package]
+edition = "2021"
+homepage = "https://www.qemu.org"
+license = "GPL-2.0-or-later"
+repository = "https://gitlab.com/qemu-project/qemu/"
+rust-version = "1.63.0"
+
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index f2296cad58b..a1f431ab4a3 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -1,15 +1,16 @@
 [package]
 name = "pl011"
 version = "0.1.0"
-edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
 description = "pl011 device model for QEMU"
 resolver = "2"
 publish = false
-keywords = []
-categories = []
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 147f216e725..6f075027843 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -1,11 +1,14 @@
 [package]
 name = "hpet"
 version = "0.1.0"
-edition = "2021"
 authors = ["Zhao Liu <zhao1.liu@intel.com>"]
-license = "GPL-2.0-or-later"
 description = "IA-PC High Precision Event Timer emulation in Rust"
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 89dee1cfb39..0cd40c8e168 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -1,15 +1,16 @@
 [package]
 name = "qemu_api_macros"
 version = "0.1.0"
-edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
 description = "Rust bindings for QEMU - Utility macros"
 resolver = "2"
 publish = false
-keywords = []
-categories = []
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [lib]
 proc-macro = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 57747bc9341..ca1b04269fd 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -1,18 +1,17 @@
 [package]
 name = "qemu_api"
 version = "0.1.0"
-edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
-readme = "README.md"
-homepage = "https://www.qemu.org"
 description = "Rust bindings for QEMU"
-repository = "https://gitlab.com/qemu-project/qemu/"
+readme = "README.md"
 resolver = "2"
 publish = false
-keywords = []
-categories = []
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-- 
2.49.0


