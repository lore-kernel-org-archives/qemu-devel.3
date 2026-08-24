Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A1CC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPw6-0008FY-0O; Mon, 24 Aug 2026 04:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyPw4-0008FA-8l
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyPw0-0007M2-Re
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787559695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nqGTC8EoT9aD7kDV5qfopKChSlc60T5A1zWRH8+g+OE=;
 b=R1/8QKUM/9PSpDEzogLBDQRjIalOfDXr3BoPd84bTm0Y39b/VjGBJTXiTW1/zn6opXPyzv
 6N9raCh7jSN0AIld0/X0PYIvsbvfDG4xrFIkSmCAap+R7IOWX0NDu8ceDYFg08Lex2eAj/
 8DY6boVgm5LzUhnncu+HP5s6/yIyOAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-4eySFfa9OOCY0SJwN1MFHQ-1; Mon,
 24 Aug 2026 04:21:31 -0400
X-MC-Unique: 4eySFfa9OOCY0SJwN1MFHQ-1
X-Mimecast-MFC-AGG-ID: 4eySFfa9OOCY0SJwN1MFHQ_1787559690
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E0171964CC9; Mon, 24 Aug 2026 08:21:30 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F12518005AD; Mon, 24 Aug 2026 08:21:25 +0000 (UTC)
Message-ID: <74297ef5-2b0b-4041-b561-c8e74673adc4@redhat.com>
Date: Mon, 24 Aug 2026 10:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] python: upgrade to Python3.12+
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth
 <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-6-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260824052859.880475-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/24/26 07:28, John Snow wrote:
> With Python3.9 EOL and Python3.10 soon to be EOL (October 2026), and
> with ... no other supported build platform actually using Python 3.11,
> require the use of Python3.12 or later.
> 
> Additionally, as part of this upgrade, remove the use of tomllib from
> mkvenv as it is now standard in the Python stdlib: leaving this
> transitional code in causes a regression with mypy which becomes
> confused about the overloaded use of 'tomllib'.
> 
> Our current minimum requirements as determined by standard repository
> packages on supported distributions is as follows:
> 
> distro            EOS         python3  pip     setuptools  sphinx  wheel
> -------------------------------------------------------------------------
> centos_stream_9   2026-12-12  3.9.25   21.3.1  53.0.0      3.4.3   0.36.2
> centos_stream_9+  2026-12-12  3.12.13  23.2.1  68.2.2      ---     0.41.2
> freebsd           --          3.12.14  23.3.2  63.1.0      9.0.4   0.48.0
> ubuntu_24_04      2028-04-23  3.12.3   24.0    68.1.2      7.2.6   0.42.0
> centos_stream_10  2030-01-01  3.12.13  23.3.2  69.0.3      7.2.6   0.41.2
> alpine_3_21       2026-11-01  3.12.14  24.3.1  70.3.0      8.1.3   0.43.0
> debian_13         2028-08-09  3.13.5   25.1.1  78.1.1      8.1.3   0.46.1
> fedora_43         2026-12-09  3.14.7   25.1.1  78.1.1      8.2.3   0.45.1
> ubuntu_26_04      2031-05-29  3.14.4   25.1.1  78.1.1      8.2.3   0.46.3
> fedora_44         2027-06-02  3.14.7   26.0.1  80.10.2     8.2.3   0.45.1
> macports          --          3.14.7   26.0.1  80.10.2     9.1.0   0.48.0
> alpine_3_22       2027-05-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3
> alpine_3_23       2027-11-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3
> openbsd           --          3.14.6   26.2.1  80.9.0      9.1.0   0.48.0
> alpine_3_24       2028-06-01  3.14.7   26.1.2  82.0.1      9.1.0   0.47.0
> pkgsrc_current    --          3.13.15  26.2.1  84.0.0      9.1.0   0.48.0
> 
> CentOS stream 9 note: python3.12, python3.12-pip,
> python3.12-setuptools and python3.12-wheel are available as optional
> packages in the standard repository. Sphinx is not available, but can
> be side-loaded from PyPI using pip3.12.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   configure                | 11 ++++----
>   python/Makefile          | 10 +++----
>   python/scripts/mkvenv.py | 58 +++-------------------------------------
>   python/setup.cfg         | 17 +++++-------
>   python/tests/minreqs.txt | 41 +++++++++++++---------------
>   pythondeps.toml          |  9 +++----
>   6 files changed, 42 insertions(+), 104 deletions(-)
> 
> diff --git a/configure b/configure
> index 56158cd95f7..46cbcc085b3 100755
> --- a/configure
> +++ b/configure
> @@ -503,17 +503,16 @@ if test -n "$linux_arch" && ! test -d "$source_path/linux-headers/asm-$linux_arc
>   fi
>   
>   check_py_version() {
> -    # We require python >= 3.9.
> +    # We require python >= 3.12.
>       # NB: a True python conditional creates a non-zero return code (Failure)
> -    "$1" -c 'import sys; sys.exit(sys.version_info < (3,9))'
> +    "$1" -c 'import sys; sys.exit(sys.version_info < (3,12))'
>   }
>   
>   first_python=
>   if test -z "${PYTHON}"; then
>       # A bare 'python' is traditionally python 2.x, but some distros
>       # have it as python 3.x, so check in both places.
> -    for binary in python3 python python3.14 python3.13 python3.12 \
> -                          python3.11 python3.10 python3.9 ; do
> +    for binary in python3 python python3.14 python3.13 python3.12; do
>           if has "$binary"; then
>               python=$(command -v "$binary")
>               if check_py_version "$python"; then
> @@ -902,7 +901,7 @@ then
>       # If first_python is set, there was a binary somewhere even though
>       # it was not suitable.  Use it for the error message.
>       if test -n "$first_python"; then
> -        error_exit "Cannot use '$first_python', Python >= 3.9 is required." \
> +        error_exit "Cannot use '$first_python', Python >= 3.12 is required." \
>               "Use --python=/path/to/python to specify a supported Python."
>       else
>           error_exit "Python not found. Use --python=/path/to/python"
> @@ -910,7 +909,7 @@ then
>   fi
>   
>   if ! check_py_version "$python"; then
> -  error_exit "Cannot use '$python', Python >= 3.9 is required." \
> +  error_exit "Cannot use '$python', Python >= 3.12 is required." \
>                "Use --python=/path/to/python to specify a supported Python." \
>                "Maybe try:" \
>                "  CentOS: dnf install python3.12"
> diff --git a/python/Makefile b/python/Makefile
> index 42994d39618..7868a48a232 100644
> --- a/python/Makefile
> +++ b/python/Makefile
> @@ -9,14 +9,14 @@ help:
>   	@echo "make check-minreqs:"
>   	@echo "    Run tests in the minreqs virtual environment."
>   	@echo "    These tests use the oldest dependencies."
> -	@echo "    Requires: Python 3.9"
> -	@echo "    Hint (Fedora): 'sudo dnf install python3.9'"
> +	@echo "    Requires: Python 3.12"
> +	@echo "    Hint (Fedora): 'sudo dnf install python3.12'"
>   	@echo ""
>   	@echo "make check-tox:"
>   	@echo "    Run tests against multiple python versions."
>   	@echo "    These tests use the newest dependencies."
> -	@echo "    Requires: Python 3.9 - 3.11, and tox."
> -	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
> +	@echo "    Requires: Python 3.12 - 3.14, and tox."
> +	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.14'"
>   	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
>   	@echo "    arguments to tox".
>   	@echo ""
> @@ -59,7 +59,7 @@ PIP_INSTALL = pip install --disable-pip-version-check
>   min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
>   $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
>   	@echo "VENV $(QEMU_MINVENV_DIR)"
> -	@python3.9 -m venv $(QEMU_MINVENV_DIR)
> +	@python3.12 -m venv $(QEMU_MINVENV_DIR)
>   	@(								\
>   		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
>   		. $(QEMU_MINVENV_DIR)/bin/activate;			\
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index 8ed6a354505..d95eeee3d23 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -75,6 +75,7 @@
>   import subprocess
>   import sys
>   import sysconfig
> +import tomllib
>   from types import SimpleNamespace
>   from typing import (
>       Any,
> @@ -134,20 +135,6 @@
>   HAVE_PACKAGING_VERSION = _import_ok
>   
>   
> -# Try to load tomllib, with a fallback to tomli.
> -# HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
> -# outside the venv or before a potential call to ensurepip in checkpip().
> -_import_ok = True
> -try:
> -    import tomllib
> -except ImportError:
> -    try:
> -        import tomli as tomllib
> -    except ImportError:
> -        _import_ok = False
> -
> -HAVE_TOMLLIB = _import_ok
> -
>   # Do not add any mandatory dependencies from outside the stdlib:
>   # This script *must* be usable standalone!
>   
> @@ -261,36 +248,6 @@ def get_parent_libpath(self) -> Optional[str]:
>               return sysconfig.get_path("purelib")
>           return None
>   
> -    @staticmethod
> -    def compute_venv_libpath(context: SimpleNamespace) -> str:
> -        """
> -        Compatibility wrapper for context.lib_path for Python < 3.12
> -        """
> -        # Python 3.12+, not strictly necessary because it's documented
> -        # to be the same as 3.10 code below:
> -        if sys.version_info >= (3, 12):
> -            return context.lib_path
> -
> -        # Python 3.10+
> -        if "venv" in sysconfig.get_scheme_names():
> -            lib_path = sysconfig.get_path(
> -                "purelib", scheme="venv", vars={"base": context.env_dir}
> -            )
> -            assert lib_path is not None
> -            return lib_path
> -
> -        # For Python <= 3.9 we need to hardcode this. Fortunately the
> -        # code below was the same in Python 3.6-3.10, so there is only
> -        # one case.
> -        if sys.platform == "win32":
> -            return os.path.join(context.env_dir, "Lib", "site-packages")
> -        return os.path.join(
> -            context.env_dir,
> -            "lib",
> -            "python%d.%d" % sys.version_info[:2],
> -            "site-packages",
> -        )
> -
>       def ensure_directories(self, env_dir: DirType) -> SimpleNamespace:
>           logger.debug("ensure_directories(env_dir=%s)", env_dir)
>           self._context = super().ensure_directories(env_dir)
> @@ -313,7 +270,8 @@ def post_post_setup(self, context: SimpleNamespace) -> None:
>               assert parent_libpath is not None
>               logger.debug("parent_libpath: %s", parent_libpath)
>   
> -            our_libpath = self.compute_venv_libpath(context)
> +            assert isinstance(context.lib_path, str)
> +            our_libpath = context.lib_path
>               logger.debug("our_libpath: %s", our_libpath)
>   
>               pth_file = os.path.join(our_libpath, "nested.pth")
> @@ -810,19 +768,11 @@ def _do_ensure(
>   
>   
>   def _parse_groups(file: str) -> Dict[str, Dict[str, Any]]:
> -    if not HAVE_TOMLLIB:
> -        if sys.version_info < (3, 11):
> -            raise Ouch("found no usable tomli, please install it")
> -
> -        raise Ouch(
> -            "Python >=3.11 does not have tomllib... what have you done!?"
> -        )
> -
>       # Use loads() to support both tomli v1.2.x (Ubuntu 22.04,
>       # Debian bullseye-backports) and v2.0.x
>       with open(file, "r", encoding="ascii") as depfile:
>           contents = depfile.read()
> -        return tomllib.loads(contents)  # type: ignore
> +        return tomllib.loads(contents)

You can now use

       with open(file, "r", encoding="ascii") as depfile:
           return tomllib.load(depfile)

since the comment about loads() does not apply anymore.

Thanks,

Paolo


