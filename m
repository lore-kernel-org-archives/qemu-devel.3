Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E00DD64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJ6-0001vI-DW; Fri, 08 Nov 2024 13:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ1-0001pD-QP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ0-0001vu-8x
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9F6HrT6yGM1H4hD8DpIdP6B53mjE1AzSwSbMGZrK5g=;
 b=G/39kxUE6mjjX+6ke0d76bJwqg2bepqJYwim5+LKhGuV9HLrtXLk2kt8jZPMQds63RjF+0
 dSL71h/vpl1LAhyuEKUHYP4b2BpIEREFUC7UE6BUzbXaYEaZvxtCy0Q5V1jU89abfHlW78
 prwVwDqSgs1AVpbhkY+VAjZoMMCrekQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-w3FSyBS0NNmqzDJBzOx9_w-1; Fri, 08 Nov 2024 13:01:56 -0500
X-MC-Unique: w3FSyBS0NNmqzDJBzOx9_w-1
X-Mimecast-MFC-AGG-ID: w3FSyBS0NNmqzDJBzOx9_w
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so1416147f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088915; x=1731693715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9F6HrT6yGM1H4hD8DpIdP6B53mjE1AzSwSbMGZrK5g=;
 b=aj47GmraBmUBVZGgW+W/HHEH+8BH8tRnvm8XI/htKANvssxmDRTqDyBlKHzZA/U3Ah
 0w2j+Jvy+VCl32vwn1y6r/EPAWknorAJP1xYHouR+yvIFM1wwvUJrHrj3zPApiI1iG36
 93OXKnCGyDaUjU6FYtLrxyLvBeWoRnkG44jnP5F4ZLIW9OZ0nQ1NyMbg7v191nHU0OeK
 GqnTRxkvdr4nV7uITEjY8Z3+K9Bt4YnEfBSGLCLOTduQ+W3jrLimgvH6g23V4ew/TKdK
 EEEMg0qMrJ3ryVewNjD3ElweY0j+zxtYo9O67mJ72va/qZa5kyQSKdpdnR6J45yRAogl
 kRsA==
X-Gm-Message-State: AOJu0YxRYHMxSGOoPAAOdsdMUOtViolq3ysLL2Fva/7/lyqNAieg+g4B
 NZhfzwCAn9ggqKw7skpKhGrwc/G6fNi7NcWH6k9OWItmEHsTujP6zpe/C3cyYoD0/jceLBXE8iM
 z73h8Z616DcWC90bzfQvnpqrLVDZo8iDHLnEPhSra7fo2nv22DIlN8TLk1jaEUzop0XZQJpPj6W
 zHpdZVulqP0g4QTga1k1QA6OBunkoMYamMXPovDdg=
X-Received: by 2002:a05:6000:a07:b0:37d:4610:dca with SMTP id
 ffacd0b85a97d-381f1c934bbmr2798154f8f.31.1731088914807; 
 Fri, 08 Nov 2024 10:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAr7KAt4sUs/liSregzTDi1Dju8hECZKju/oHpVQnPMmkx+E9pSaC3qy/KZf9/upC3EVJslA==
X-Received: by 2002:a05:6000:a07:b0:37d:4610:dca with SMTP id
 ffacd0b85a97d-381f1c934bbmr2798047f8f.31.1731088913489; 
 Fri, 08 Nov 2024 10:01:53 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed974d60sm5691697f8f.2.2024.11.08.10.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 04/11] rust: build: generate warning flags from Cargo.toml
Date: Fri,  8 Nov 2024 19:01:32 +0100
Message-ID: <20241108180139.117112-5-pbonzini@redhat.com>
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

Cargo.toml makes it possible to describe the desired lint level settings
in a nice format.  We can extend this to Meson-built crates, by teaching
rustc_args.py to fetch lint and --check-cfg arguments from Cargo.toml.

Start with qemu-api, since it already has a [lints.rust] table and
an invocation of rustc_args.py.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build  |  4 +-
 scripts/rust/rustc_args.py | 83 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index bb2ed2844dc..4ba5607d66b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -5,8 +5,8 @@ if rustc.version().version_compare('>=1.77.0')
 endif
 
 _qemu_api_cfg += run_command(rustc_args,
-  '--config-headers', config_host_h, files('Cargo.toml'),
-  capture: true, check: true).stdout().strip().split()
+  '--config-headers', config_host_h, '--features', '--lints', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
 
 _qemu_api_rs = static_library(
   'qemu_api',
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 942dd2b2bab..9b9778a1cac 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -25,9 +25,10 @@
 """
 
 import argparse
+from dataclasses import dataclass
 import logging
 from pathlib import Path
-from typing import Any, Iterable, Mapping, Optional, Set
+from typing import Any, Iterable, List, Mapping, Optional, Set
 
 try:
     import tomllib
@@ -61,6 +62,45 @@ def get_table(self, key: str) -> Mapping[Any, Any]:
         return table
 
 
+@dataclass
+class LintFlag:
+    flags: List[str]
+    priority: int
+
+
+def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
+    """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
+
+    toml_lints = cargo_toml.lints
+
+    lint_list = []
+    for k, v in toml_lints.items():
+        prefix = "" if k == "rust" else k + "::"
+        for lint, data in v.items():
+            level = data if isinstance(data, str) else data["level"]
+            priority = 0 if isinstance(data, str) else data.get("priority", 0)
+            if level == "deny":
+                flag = "-D"
+            elif level == "allow":
+                flag = "-A"
+            elif level == "warn":
+                flag = "-W"
+            elif level == "forbid":
+                flag = "-F"
+            else:
+                raise Exception(f"invalid level {level} for {prefix}{lint}")
+
+            # This may change if QEMU ever invokes clippy-driver or rustdoc by
+            # hand.  For now, check the syntax but do not add non-rustc lints to
+            # the command line.
+            if k == "rust":
+                lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
+
+    lint_list.sort(key=lambda x: x.priority)
+    for lint in lint_list:
+        yield from lint.flags
+
+
 def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
@@ -97,13 +137,54 @@ def main() -> None:
         dest="cargo_toml",
         help="path to Cargo.toml file",
     )
+    parser.add_argument(
+        "--features",
+        action="store_true",
+        dest="features",
+        help="generate --check-cfg arguments for features",
+        required=False,
+        default=None,
+    )
+    parser.add_argument(
+        "--lints",
+        action="store_true",
+        dest="lints",
+        help="generate arguments from [lints] table",
+        required=False,
+        default=None,
+    )
+    parser.add_argument(
+        "--rustc-version",
+        metavar="VERSION",
+        dest="rustc_version",
+        action="store",
+        help="version of rustc",
+        required=False,
+        default="1.0.0",
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
     logging.debug("args: %s", args)
 
+    rustc_version = tuple((int(x) for x in args.rustc_version.split('.')[0:2]))
     cargo_toml = CargoTOML(args.cargo_toml)
 
+    if args.lints:
+        for tok in generate_lint_flags(cargo_toml):
+            print(tok)
+
+    if rustc_version >= (1, 80):
+        if args.lints:
+            for cfg in sorted(cargo_toml.check_cfg):
+                print("--check-cfg")
+                print(cfg)
+        if args.features:
+            for feature in cargo_toml.get_table("features"):
+                if feature != "default":
+                    print("--check-cfg")
+                    print(f'cfg(feature,values("{feature}"))')
+
     for header in args.config_headers:
         for tok in generate_cfg_flags(header, cargo_toml):
             print(tok)
-- 
2.47.0


