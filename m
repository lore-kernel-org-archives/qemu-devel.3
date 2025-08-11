Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CCFCA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulXyG-0000tK-4X; Mon, 11 Aug 2025 15:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ulXyE-0000ss-NT
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:14:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ulXy7-0007vN-Dh
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:14:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 803B514146C;
 Mon, 11 Aug 2025 22:13:18 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3ED1025DE61;
 Mon, 11 Aug 2025 22:13:51 +0300 (MSK)
Message-ID: <433cc9ad-4a61-4a34-b655-8da287695827@tls.msk.ru>
Date: Mon, 11 Aug 2025 22:13:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkvenv: Support pip 25.2
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Sv. Lockal" <lockalsash@gmail.com>
References: <20250811190159.237321-1-jsnow@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20250811190159.237321-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On 11.08.2025 22:01, John Snow wrote:
> From: "Sv. Lockal" <lockalsash@gmail.com>
> 
> Fix compilation with pip-25.2 due to missing distlib.version
> 
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/3062
> 
> Signed-off-by: Sv. Lockal <lockalsash@gmail.com>
> [Edits: Type "safety" whackamole --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/scripts/mkvenv.py | 64 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 60 insertions(+), 4 deletions(-)

I think with this in place, there's no need to do any fallbacks here, --
replace distlib.version.LegacyMatcher with 
packaging.requirements.Requirement
directly in the code, and import it from pip directly without any "try"
and fallbacks.

Oldest pip we support (21.3 iirc) has "packaging" available.  There's
just no need for all this hackery/complexity.

When I first saw the patch I though it's the way to go.  But now when
I thought about it, I think it's better to just throw away all this
complexity.

It's sort of risky because we didn't verify how it works on all
supported systems, but it "should" be the same :)

/mjt

> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index 8ac5b0b2a05..f102527c4de 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -84,6 +84,7 @@
>       Sequence,
>       Tuple,
>       Union,
> +    cast,
>   )
>   import venv
>   
> @@ -94,17 +95,39 @@
>   HAVE_DISTLIB = True
>   try:
>       import distlib.scripts
> -    import distlib.version
>   except ImportError:
>       try:
>           # Reach into pip's cookie jar.  pylint and flake8 don't understand
>           # that these imports will be used via distlib.xxx.
>           from pip._vendor import distlib
>           import pip._vendor.distlib.scripts  # noqa, pylint: disable=unused-import
> -        import pip._vendor.distlib.version  # noqa, pylint: disable=unused-import
>       except ImportError:
>           HAVE_DISTLIB = False
>   
> +# pip 25.2 does not vendor distlib.version, but it uses vendored
> +# packaging.version
> +HAVE_DISTLIB_VERSION = True
> +try:
> +    import distlib.version  # pylint: disable=ungrouped-imports
> +except ImportError:
> +    try:
> +        # pylint: disable=unused-import,ungrouped-imports
> +        import pip._vendor.distlib.version  # noqa
> +    except ImportError:
> +        HAVE_DISTLIB_VERSION = False
> +
> +HAVE_PACKAGING_VERSION = True
> +try:
> +    # Do not bother importing non-vendored packaging, because it is not
> +    # in stdlib.
> +    from pip._vendor import packaging
> +    # pylint: disable=unused-import
> +    import pip._vendor.packaging.requirements  # noqa
> +    import pip._vendor.packaging.version  # noqa
> +except ImportError:
> +    HAVE_PACKAGING_VERSION = False
> +
> +
>   # Try to load tomllib, with a fallback to tomli.
>   # HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
>   # outside the venv or before a potential call to ensurepip in checkpip().
> @@ -133,6 +156,39 @@ class Ouch(RuntimeError):
>       """An Exception class we can't confuse with a builtin."""
>   
>   
> +class Matcher:
> +    """Compatibility appliance for version/requirement string parsing."""
> +    def __init__(self, name_and_constraint: str):
> +        """Create a matcher from a requirement-like string."""
> +        if HAVE_DISTLIB_VERSION:
> +            self._m = distlib.version.LegacyMatcher(name_and_constraint)
> +        elif HAVE_PACKAGING_VERSION:
> +            self._m = packaging.requirements.Requirement(name_and_constraint)
> +        else:
> +            raise Ouch("found neither distlib.version nor packaging.version")
> +        self.name = self._m.name
> +
> +    def match(self, version_str: str) -> bool:
> +        """Return True if `version` satisfies the stored constraint."""
> +        if HAVE_DISTLIB_VERSION:
> +            return cast(
> +                bool,
> +                self._m.match(distlib.version.LegacyVersion(version_str))
> +            )
> +
> +        assert HAVE_PACKAGING_VERSION
> +        return cast(
> +            bool,
> +            self._m.specifier.contains(
> +                packaging.version.Version(version_str), prereleases=True
> +            )
> +        )
> +
> +    def __repr__(self) -> str:
> +        """Stable debug representation delegated to the backend."""
> +        return repr(self._m)
> +
> +
>   class QemuEnvBuilder(venv.EnvBuilder):
>       """
>       An extension of venv.EnvBuilder for building QEMU's configure-time venv.
> @@ -669,7 +725,7 @@ def _do_ensure(
>       canary = None
>       for name, info in group.items():
>           constraint = _make_version_constraint(info, False)
> -        matcher = distlib.version.LegacyMatcher(name + constraint)
> +        matcher = Matcher(name + constraint)
>           print(f"mkvenv: checking for {matcher}", file=sys.stderr)
>   
>           dist: Optional[Distribution] = None
> @@ -683,7 +739,7 @@ def _do_ensure(
>               # Always pass installed package to pip, so that they can be
>               # updated if the requested version changes
>               or not _is_system_package(dist)
> -            or not matcher.match(distlib.version.LegacyVersion(dist.version))
> +            or not matcher.match(dist.version)
>           ):
>               absent.append(name + _make_version_constraint(info, True))
>               if len(absent) == 1:


