Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C0AD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJ4-0001so-6c; Fri, 08 Nov 2024 13:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIy-0001oj-Qm
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIx-0001vh-85
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtlWVHUs02V1J7NuepxEhAY1b+bPSGqGN7MAC+hr2Y4=;
 b=BemJddRb2NV/4RkOk3PJSrX4eDWa+WS8N9K4RRtwLFMMSW4TcW03qQq1XPmYIXGoH4GfO0
 SAnq/VX4aaIciZx09M21CIaMHkutYTKmkSScCfe0KGOGIElrvJ7B7pEHqf7r8Xq1tX4lxB
 ztRMa87ppfbUXnDL6zorb1Zoc/vCM60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Lu1_ClCbPJyiNsdfw2aoRw-1; Fri, 08 Nov 2024 13:01:53 -0500
X-MC-Unique: Lu1_ClCbPJyiNsdfw2aoRw-1
X-Mimecast-MFC-AGG-ID: Lu1_ClCbPJyiNsdfw2aoRw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431673032e6so15596495e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088911; x=1731693711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtlWVHUs02V1J7NuepxEhAY1b+bPSGqGN7MAC+hr2Y4=;
 b=JxYcMTZ4L4Uio6O3IG/KwnP4/Rmtd1iVWuJqJON0OfKzjXrOVGpy0mMWUEMpn103Qm
 +Yxit4eKalM2PfokBAwAtIURxvme4RdnB2Yem5aQhhtJjLuU+f1E8pWXV2Kg2ccFvo2z
 lcmI/uZFvdVRXjkqgK1LD7gnwgcVe0U/2pNYq6VWHhOHTYlYUmThceBHDeObt+Qu4qs9
 e1EkkH42Jb9UNZuAiqc1xtXuf2Y/+EXdwgPWMesm6SQUtIp+9R27Kd0QXZRgzIC6Mw2v
 /oxUWKpQlJmra1/LRc2mHuRC9TMHBsXeJ3xcnYFeffEESKQtKys6jombHcLQNy3TYsCw
 Yi6Q==
X-Gm-Message-State: AOJu0YwbNEzx4NSt77QHKfUYXL7pNn6KyANH2rHV7oOxmhl2huAqQMQB
 gP7tQA3H1PlxMikXrF2RRZWaM9rbfMqZsfJVGgX1GT2HC7xhijUqcWBXLXPjUOlcbG5KUaTs8LL
 vok3BSENZ6YalHOTgYBNoqW77TTIaSEHgD2b5k4UpMoIARuT/z8NlsxP8Vh8vcz1K9YBn8DnVl8
 1Q+0Lt3r0JH4mlmD7dIhTpW1KZdK88rWSKaCh7D2g=
X-Received: by 2002:a5d:5f93:0:b0:37c:ddab:a626 with SMTP id
 ffacd0b85a97d-381f18270b9mr3455486f8f.7.1731088911224; 
 Fri, 08 Nov 2024 10:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXpELzcUPuq1aHn/ar1IEsvO024hFlT6xiueWWzvOMBU+egxqHhCsJJmsob2IeLdpsLN+guQ==
X-Received: by 2002:a5d:5f93:0:b0:37c:ddab:a626 with SMTP id
 ffacd0b85a97d-381f18270b9mr3455431f8f.7.1731088910636; 
 Fri, 08 Nov 2024 10:01:50 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2a3bsm113584455e9.11.2024.11.08.10.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 03/11] rust: build: restrict --cfg generation to only
 required symbols
Date: Fri,  8 Nov 2024 19:01:31 +0100
Message-ID: <20241108180139.117112-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
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
index f84f85b88c6..bb2ed2844dc 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,7 +5,7 @@ if rustc.version().version_compare('>=1.77.0')
 endif
 
 _qemu_api_cfg += run_command(rustc_args,
-  '--config-headers', config_host_h,
+  '--config-headers', config_host_h, files('Cargo.toml'),
   capture: true, check: true).stdout().strip().split()
 
 _qemu_api_rs = static_library(
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


