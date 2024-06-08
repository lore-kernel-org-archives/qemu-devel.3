Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D6EC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYb-00045y-Gd; Sat, 08 Jun 2024 04:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYZ-0003lg-8C
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYX-0000Lx-Jk
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5zvmcvef8pRBAw9VrXIyPOYRYeCWBajLWVRPej6rGM=;
 b=BN+pnwR0r19L8eGpEaKIoPcaU/rnSmd2qnfmuvo6OoIc8AdUo9Yk9/CaB0RSk2V/xCqSpb
 nIJKjVq97hr3oq7sC4v+P70Se3yqUjAFvEtaOyX8UfBPL/et9FyyW+wAtWhgv04oGjt8vq
 7HzzFsqc0u2e6ZeLC3dOEDrxl+8U6g8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-hBgYYYArMRmvGTM9iO8Zew-1; Sat, 08 Jun 2024 04:36:07 -0400
X-MC-Unique: hBgYYYArMRmvGTM9iO8Zew-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6efbb08949so31694666b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835765; x=1718440565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5zvmcvef8pRBAw9VrXIyPOYRYeCWBajLWVRPej6rGM=;
 b=XX9d7JA+Jw7dEaxCmhTdBDZE3SFfl2bHs9FY0mL68VHcWmCne3W23CUnU6GJkw600w
 IpzVAdbjsjuYg0Ln7RDRW1ddub7Zp/uYRQTA1mxZOMep2/IAZ1YEk7u0pFF16jxSuzCG
 NhHZhbvl96F+OFBhBQWM5fXLgRHxOj0JY83MUw8LhPxx36E443ypdoa0QvuEjXEXpK9f
 Yep2LX6WYX/L/y/ZJSAIdA+PKyGCAhh5DXtoYbEq/yma57/LvnVounrm39HyQp8zFad8
 5lV4kt68gKI9hO8MC9IfSpc2WGzXYgUYXS/H9jKsbJPUXbkEVG2tbGzmzVJE2wA9t21P
 uRrA==
X-Gm-Message-State: AOJu0YzE+XkS/nuwFKfZaOdvx0HR4MB1XIJbIic9Tlie9leyPF0iNHHe
 g+HuxNgxxPo0xaDkZxWHeEAXJXWKWGyWmWFwsm+U52NPtT6q3nnhfZN80wEEnfG7PG1ehCkV4qj
 MuJPAjeC7Y7yy9cDEdirgOVRoZ51a+jNhOcxNDOXOzv7fY4QTTsnf3F8+KGWcoHYNb3XkXgrPDl
 C0WSxo9gWfycjW4hKN4BaHUPsn2oc/hOq1P736
X-Received: by 2002:a17:906:f34d:b0:a5c:fd35:df3d with SMTP id
 a640c23a62f3a-a6cdad22eeamr242822066b.61.1717835764977; 
 Sat, 08 Jun 2024 01:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbgjO+GPOWl9QQ3i7UzQ46v6qqUnJTOta7AuUgfmTz99JpHFujPLyY8tuz7kHwW9XJwYIcDw==
X-Received: by 2002:a17:906:f34d:b0:a5c:fd35:df3d with SMTP id
 a640c23a62f3a-a6cdad22eeamr242821366b.61.1717835764483; 
 Sat, 08 Jun 2024 01:36:04 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e7fesm357927266b.183.2024.06.08.01.36.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:36:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/42] python: mkvenv: remove ensure command
Date: Sat,  8 Jun 2024 10:34:15 +0200
Message-ID: <20240608083415.2769160-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This was used to bootstrap the venv with a TOML parser, after which
ensuregroup is used.  Now that we expect it to be present as a system
package (either tomli or, for Python 3.11, tomllib), it is not needed
anymore.

Note that this means that, when implemented, the hypothetical "isolated"
mode that does not use any system packages will only work with Python
3.11+.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 105 ---------------------------------------
 1 file changed, 105 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index d0b9c215ca2..f2526af0a04 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -13,7 +13,6 @@
     create    create a venv
     post_init
               post-venv initialization
-    ensure    Ensure that the specified package is installed.
     ensuregroup
               Ensure that the specified package group is installed.
 
@@ -36,18 +35,6 @@
 
 --------------------------------------------------
 
-usage: mkvenv ensure [-h] [--online] [--dir DIR] dep_spec...
-
-positional arguments:
-  dep_spec    PEP 508 Dependency specification, e.g. 'meson>=0.61.5'
-
-options:
-  -h, --help  show this help message and exit
-  --online    Install packages from PyPI, if necessary.
-  --dir DIR   Path to vendored packages where we may install from.
-
---------------------------------------------------
-
 usage: mkvenv ensuregroup [-h] [--online] [--dir DIR] file group...
 
 positional arguments:
@@ -726,57 +713,6 @@ def _do_ensure(
     return None
 
 
-def ensure(
-    dep_specs: Sequence[str],
-    online: bool = False,
-    wheels_dir: Optional[Union[str, Path]] = None,
-    prog: Optional[str] = None,
-) -> None:
-    """
-    Use pip to ensure we have the package specified by @dep_specs.
-
-    If the package is already installed, do nothing. If online and
-    wheels_dir are both provided, prefer packages found in wheels_dir
-    first before connecting to PyPI.
-
-    :param dep_specs:
-        PEP 508 dependency specifications. e.g. ['meson>=0.61.5'].
-    :param online: If True, fall back to PyPI.
-    :param wheels_dir: If specified, search this path for packages.
-    :param prog:
-        If specified, use this program name for error diagnostics that will
-        be presented to the user. e.g., 'sphinx-build' can be used as a
-        bellwether for the presence of 'sphinx'.
-    """
-
-    if not HAVE_DISTLIB:
-        raise Ouch("a usable distlib could not be found, please install it")
-
-    # Convert the depspecs to a dictionary, as if they came
-    # from a section in a pythondeps.toml file
-    group: Dict[str, Dict[str, str]] = {}
-    for spec in dep_specs:
-        name = distlib.version.LegacyMatcher(spec).name
-        group[name] = {}
-
-        spec = spec.strip()
-        pos = len(name)
-        ver = spec[pos:].strip()
-        if ver:
-            group[name]["accepted"] = ver
-
-        if prog:
-            group[name]["canary"] = prog
-            prog = None
-
-    result = _do_ensure(group, online, wheels_dir)
-    if result:
-        # Well, that's not good.
-        if result[1]:
-            raise Ouch(result[0])
-        raise SystemExit(f"\n{result[0]}\n\n")
-
-
 def _parse_groups(file: str) -> Dict[str, Dict[str, Any]]:
     if not HAVE_TOMLLIB:
         if sys.version_info < (3, 11):
@@ -888,39 +824,6 @@ def _add_ensuregroup_subcommand(subparsers: Any) -> None:
     )
 
 
-def _add_ensure_subcommand(subparsers: Any) -> None:
-    subparser = subparsers.add_parser(
-        "ensure", help="Ensure that the specified package is installed."
-    )
-    subparser.add_argument(
-        "--online",
-        action="store_true",
-        help="Install packages from PyPI, if necessary.",
-    )
-    subparser.add_argument(
-        "--dir",
-        type=str,
-        action="store",
-        help="Path to vendored packages where we may install from.",
-    )
-    subparser.add_argument(
-        "--diagnose",
-        type=str,
-        action="store",
-        help=(
-            "Name of a shell utility to use for "
-            "diagnostics if this command fails."
-        ),
-    )
-    subparser.add_argument(
-        "dep_specs",
-        type=str,
-        action="store",
-        help="PEP 508 Dependency specification, e.g. 'meson>=0.61.5'",
-        nargs="+",
-    )
-
-
 def main() -> int:
     """CLI interface to make_qemu_venv. See module docstring."""
     if os.environ.get("DEBUG") or os.environ.get("GITLAB_CI"):
@@ -944,7 +847,6 @@ def main() -> int:
 
     _add_create_subcommand(subparsers)
     _add_post_init_subcommand(subparsers)
-    _add_ensure_subcommand(subparsers)
     _add_ensuregroup_subcommand(subparsers)
 
     args = parser.parse_args()
@@ -957,13 +859,6 @@ def main() -> int:
             )
         if args.command == "post_init":
             post_venv_setup()
-        if args.command == "ensure":
-            ensure(
-                dep_specs=args.dep_specs,
-                online=args.online,
-                wheels_dir=args.dir,
-                prog=args.diagnose,
-            )
         if args.command == "ensuregroup":
             ensure_group(
                 file=args.file,
-- 
2.45.1


