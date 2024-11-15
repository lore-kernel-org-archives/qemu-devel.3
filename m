Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF966D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzOG-0007EE-NK; Fri, 15 Nov 2024 11:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNQ-0006IX-Sv
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNO-0002L4-Sq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkYYZlCmzff3dR5RmcXgSbe21mI5H667ZMFVY4crkxI=;
 b=fvCNor6Eea/mOPe115GSYiicog4vgYKBsG/DAJ5fBMHIXPBy+SWzQ8P1RQhbhgN8OBvT6i
 rv6axhjnb8Ie1x13UW9D/FB1ZhdleDZLGJn9IM9XX173AVg/j9ogy24JKLt7EyXNKHcaQs
 jx/dCTpI4L02AI1RTryb9TO1qRvAcVU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-ApDuHmALPSGnD11lKH7Fyg-1; Fri, 15 Nov 2024 11:40:51 -0500
X-MC-Unique: ApDuHmALPSGnD11lKH7Fyg-1
X-Mimecast-MFC-AGG-ID: ApDuHmALPSGnD11lKH7Fyg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38218576e86so1104947f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688846; x=1732293646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkYYZlCmzff3dR5RmcXgSbe21mI5H667ZMFVY4crkxI=;
 b=VtMcPAQ+Wf3OYiuu2uzMjxCMEhxOiAQ116JA5XYf1K6YELHUSet83UhNMhQ2s/5GuA
 cCktfyZCoT2zwVZqKk8rz20cDr4nkNH38cqvr/o9onfTw6jsKElvs40GSAhVc2PPmTM2
 CEpS0N7o3P2C0aWKZlpTSjN7aW8TRAH19gQjbiy632+Tyv+9i/khNwTZMZZWQ1SJ7d2F
 OP9Tu0od/H31cqVkIDEBpI7lGXq+XELGIihj1xMjPd73u+Vpmv/P/x9aPpzJnG+538nr
 9F0xnykhV/HB/WdELFt87ZpycpZ44MklhdFDjkYSToUtiYm3GcLB1zkrJi+zHUo//WRl
 ttxw==
X-Gm-Message-State: AOJu0Yz7vuJ2HSts/GX+4QuSuCIRGeTLLAj+zk4DyI+RJ1eDDn0xTaQL
 ZQpw+wUgx1w36w+JRp8QDoVS2mBcB2FVl+ryvoGQR72+yJtmpRfFASi137jsPsHRGXa2ubxiB1C
 a0Y3mTPi0MAqqqLM/ROsPxMXd0NFLD4g7nGqLy3VBqcXpdmVwb/+vtz1T2HwdbjjKsIPWDG1zY/
 5cyXy64xqjyFikPnJ7dA3XNk0t/s7xNi1JYzXxczc=
X-Received: by 2002:a5d:59a2:0:b0:37d:47ef:17d0 with SMTP id
 ffacd0b85a97d-38224f861c6mr3489514f8f.13.1731688846609; 
 Fri, 15 Nov 2024 08:40:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWJyVNk4KS0t+9VWpoN0zr6vN/lTUh+y464BFJtsL/8dWi4V2mO1PcZFai8U/PcM0V3yvhYA==
X-Received: by 2002:a5d:59a2:0:b0:37d:47ef:17d0 with SMTP id
 ffacd0b85a97d-38224f861c6mr3489482f8f.13.1731688846161; 
 Fri, 15 Nov 2024 08:40:46 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adadba4sm4761340f8f.24.2024.11.15.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:40:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 05/12] rust: build: generate lint flags from Cargo.toml
Date: Fri, 15 Nov 2024 17:40:18 +0100
Message-ID: <20241115164025.1917618-5-pbonzini@redhat.com>
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

Cargo.toml makes it possible to describe the desired lint level settings
in a nice format.  We can extend this to Meson-built crates, by teaching
rustc_args.py to fetch lint and --check-cfg arguments from Cargo.toml.
--check-cfg arguments come from the unexpected_cfgs lint as well as crate
features

Start with qemu-api, since it already has a [lints.rust] table and
an invocation of rustc_args.py.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  3 +-
 rust/qemu-api/meson.build  |  4 +-
 scripts/rust/rustc_args.py | 83 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index b51add16d2f..231fccf3928 100644
--- a/meson.build
+++ b/meson.build
@@ -120,7 +120,8 @@ if have_rust
 endif
 
 if have_rust
-  rustc_args = find_program('scripts/rust/rustc_args.py')
+  rustc_args = [find_program('scripts/rust/rustc_args.py'),
+    '--rustc-version', rustc.version()]
   rustfmt = find_program('rustfmt', required: false)
 
   # Prohibit code that is forbidden in Rust 2024
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 2ff6d2ce3d0..1ed79672cc9 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,6 +1,6 @@
 _qemu_api_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h, files('Cargo.toml'),
-  capture: true, check: true).stdout().strip().split()
+  '--config-headers', config_host_h, '--features', '--lints', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
 
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
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


