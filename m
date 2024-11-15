Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43815D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzOE-0006z4-HK; Fri, 15 Nov 2024 11:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNK-0006Gz-Rx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNH-0002KJ-Jy
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttI9dVImUyRrjtz3o3qxzgGlyU5nv6rQoiRqrRQPUqI=;
 b=Tco+8VUjf0H7VPgH++n/1gOrQLHht+3brHcLmveeTKx1QD6nqPfCh7CcgakS5pkNqd4Cuk
 dNiFTuj7ozoEkzevDY+faEI6qw7jL1kR44KrzaWmrd8mj7b2e2f82PmIe09AQn0QZxeImz
 PDN5hlySd6kqXtgrNPuSN9zgB1J1mQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-tRQXkvEXPZer5Vwt0Lu6yA-1; Fri, 15 Nov 2024 11:40:45 -0500
X-MC-Unique: tRQXkvEXPZer5Vwt0Lu6yA-1
X-Mimecast-MFC-AGG-ID: tRQXkvEXPZer5Vwt0Lu6yA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so12849545e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688842; x=1732293642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttI9dVImUyRrjtz3o3qxzgGlyU5nv6rQoiRqrRQPUqI=;
 b=EWoC5mp0MPbL0QEHE/CAcDGmbc4jHTGik9yx+bnhca2dlg+hk0xlWGX5n11dNSRiPF
 P5jUWbm28lEKOMwe8P9qbJDlgNjcy1lSTz3e5ilMNW9r6I7AvmhVvYO9UbJGXkv2ESCD
 af9Gud+KOmAbDRY+1ssX4jST0lq4MJT+swcbtUWHwNh6QEkjH9wyKHYExPHSjkJlDtRE
 3/FWQ3HbvmWy3mjHres6Ec18EpW5gJpAMeBT8NEg+jd5WvWVj/NMvDlvv0GzLq1pk+LV
 U2j/QJROowdK4GhXOpiqgfcjwO3zi5ZHSOB22TGKMGzaPphFxq3z0YTsOTC+zICqZ19x
 e03Q==
X-Gm-Message-State: AOJu0Yzygsr9Q/db8WcX5pnQ2/qY2QBAan10QFGZd1Q+G3IuGO6q9CHq
 5v4IADwxdtEID/RDeTcZZw5GNtainRxrqINRBe1r+KfjhFJzPdb6CMa9tQup+mxQC6+oM5FncHt
 JexRf/bKy2zZPWWSRhHNWjyzjqAYEgeoG2bx1Il0wCOLTo/gGJswmz6Ya1g7WszUV/gwuQC1SLB
 MwRXHx6iH8KAxrKoNm0N0Rss7kfB+6OZ4oQPV1GrU=
X-Received: by 2002:a5d:6c69:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-382258f4d91mr3050996f8f.11.1731688842431; 
 Fri, 15 Nov 2024 08:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbjPKT/LMKZ/4JwGWK8XBEKmjP6sXHXYpuanOi9qYVQTOTzGhPffo+TjZ9fjygxVLjVnZeog==
X-Received: by 2002:a5d:6c69:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-382258f4d91mr3050970f8f.11.1731688841992; 
 Fri, 15 Nov 2024 08:40:41 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae161b5sm4892018f8f.74.2024.11.15.08.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:40:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 04/12] rust: build: restrict --cfg generation to only required
 symbols
Date: Fri, 15 Nov 2024 17:40:17 +0100
Message-ID: <20241115164025.1917618-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Parse the Cargo.toml file, looking for the unexpected_cfgs
configuration.  When generating --cfg options from the
config-host.h file, only use those that are included in the
configuration.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build  |  2 +-
 scripts/rust/rustc_args.py | 61 ++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 5df6b35bf88..2ff6d2ce3d0 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,5 +1,5 @@
 _qemu_api_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h,
+  '--config-headers', config_host_h, files('Cargo.toml'),
   capture: true, check: true).stdout().strip().split()
 
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index e4cc9720e16..942dd2b2bab 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -26,30 +26,51 @@
 
 import argparse
 import logging
+from pathlib import Path
+from typing import Any, Iterable, Mapping, Optional, Set
 
-from typing import List
+try:
+    import tomllib
+except ImportError:
+    import tomli as tomllib
 
 
-def generate_cfg_flags(header: str) -> List[str]:
+class CargoTOML:
+    tomldata: Mapping[Any, Any]
+    check_cfg: Set[str]
+
+    def __init__(self, path: str):
+        with open(path, 'rb') as f:
+            self.tomldata = tomllib.load(f)
+
+        self.check_cfg = set(self.find_check_cfg())
+
+    def find_check_cfg(self) -> Iterable[str]:
+        toml_lints = self.lints
+        rust_lints = toml_lints.get("rust", {})
+        cfg_lint = rust_lints.get("unexpected_cfgs", {})
+        return cfg_lint.get("check-cfg", [])
+
+    @property
+    def lints(self) -> Mapping[Any, Any]:
+        return self.get_table("lints")
+
+    def get_table(self, key: str) -> Mapping[Any, Any]:
+        table = self.tomldata.get(key, {})
+
+        return table
+
+
+def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
-    def cfg_name(name: str) -> str:
-        """Filter function for C #defines"""
-        if (
-            name.startswith("CONFIG_")
-            or name.startswith("TARGET_")
-            or name.startswith("HAVE_")
-        ):
-            return name
-        return ""
-
     with open(header, encoding="utf-8") as cfg:
         config = [l.split()[1:] for l in cfg if l.startswith("#define")]
 
     cfg_list = []
     for cfg in config:
-        name = cfg_name(cfg[0])
-        if not name:
+        name = cfg[0]
+        if f'cfg({name})' not in cargo_toml.check_cfg:
             continue
         if len(cfg) >= 2 and cfg[1] != "1":
             continue
@@ -59,7 +80,6 @@ def cfg_name(name: str) -> str:
 
 
 def main() -> None:
-    # pylint: disable=missing-function-docstring
     parser = argparse.ArgumentParser()
     parser.add_argument("-v", "--verbose", action="store_true")
     parser.add_argument(
@@ -71,12 +91,21 @@ def main() -> None:
         required=False,
         default=[],
     )
+    parser.add_argument(
+        metavar="TOML_FILE",
+        action="store",
+        dest="cargo_toml",
+        help="path to Cargo.toml file",
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
     logging.debug("args: %s", args)
+
+    cargo_toml = CargoTOML(args.cargo_toml)
+
     for header in args.config_headers:
-        for tok in generate_cfg_flags(header):
+        for tok in generate_cfg_flags(header, cargo_toml):
             print(tok)
 
 
-- 
2.47.0


