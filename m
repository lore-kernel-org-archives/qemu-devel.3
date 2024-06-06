Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8EI-0007wj-Lk; Thu, 06 Jun 2024 04:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8ED-0007va-4P
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8EA-0007w9-Ik
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717661525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5zvmcvef8pRBAw9VrXIyPOYRYeCWBajLWVRPej6rGM=;
 b=ilayfvd0oBpPPIJ/Iu3z2EXUEghORPvT7wm8nwZZ5vxmcBRa0VQRZPXbuM0/73KHXYoWbC
 8rLgVL8PuxPMrqSMXrp2+209qJU5bj9/UT+OWVKospAdJcocchNRVd+yxn/B4ibbbOi9S7
 s902pJi/k9PCrrCxS0K7tQQKgRnp0OI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-23eKkELWPfq9D60w-1Tm3A-1; Thu, 06 Jun 2024 04:12:03 -0400
X-MC-Unique: 23eKkELWPfq9D60w-1Tm3A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ea95d34474so4202291fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717661522; x=1718266322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5zvmcvef8pRBAw9VrXIyPOYRYeCWBajLWVRPej6rGM=;
 b=hKP2jOw0qiwAiJRmDFcaFD0x16ahTlC7L/fCdRVfImniZWjL7zU6ElEfoo7e9bpZ+U
 ZmqTfYsQK2nS9iYlAn7PS84mjSNZVIXUvVI3pBcJ89QK/P5r/NpGKBS+RhqO3KwU2NRC
 de385k92ArCkhyQPTsb3BUnGfen0lqwiNKMwGyij3viStZVHEzsZNWTXuQ3p22vtgoTU
 priNr28/AdmDqz/KDcXEvA2vNTSRUYo2nwohVGhkemI8apor3sCqRb36itDj2BgJJYhy
 YxxUyvwk0fwGfejPVbcrZUHuPv2Aa3mfLDhp3xzI2hYutaxVGWexpDMYC6hGbwWd7RnP
 2r4g==
X-Gm-Message-State: AOJu0YxPHmthKZRcHGbN4DkCq3d2xXk5Fh+ypRnSlNU00sNomxK03EXR
 a0RnorKNIqL8nEkl84gTjUAFnP8N+LXxkb8NAYIBEDf5zOm2hVtKdI4hKsfvvoqkPruSJK5+XF+
 sR519VmZHMsW2bkROeZYLR+nVgqYsX3qYjmaoXYusMKEAvyn9QeMW2QGRqroXah65aOwCKykEqn
 iHWI4FP6q2u4rMzjyBVYquOTD0MPL+eSlR96qo
X-Received: by 2002:a05:651c:620:b0:2de:7cc5:7a27 with SMTP id
 38308e7fff4ca-2eac798be90mr25030831fa.5.1717661521889; 
 Thu, 06 Jun 2024 01:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmakkqgc7o764yUdGvsO9f3ax402vAZueWz/bmREsNKJbkPCbylbUK3I5CHM0pqM0W89MNaQ==
X-Received: by 2002:a05:651c:620:b0:2de:7cc5:7a27 with SMTP id
 38308e7fff4ca-2eac798be90mr25030531fa.5.1717661521143; 
 Thu, 06 Jun 2024 01:12:01 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae2366a4sm655925a12.92.2024.06.06.01.12.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:12:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] python: mkvenv: remove ensure command
Date: Thu,  6 Jun 2024 10:11:53 +0200
Message-ID: <20240606081153.2457559-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606081153.2457559-1-pbonzini@redhat.com>
References: <20240606081153.2457559-1-pbonzini@redhat.com>
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


