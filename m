Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DAAFC590A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvWnh-0001s2-Nf; Thu, 26 Feb 2026 03:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvWne-0001rB-2h
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvWnc-0003aT-1K
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772094762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ScNatbbxLlviMXV2mpo/a6exgeF6QVYHBMi47xQJ5Oo=;
 b=ZdUmrZdR1vYEEq9jGzJ54yua9U08b4N+erkdhqFBAkDAdvlVXQGEyjrnCFIBvKfMBkINKT
 Q2sGRFBm9i0KrS/aWcS04twHMAYaqVRbUIUodtjwvugLWEuLz0v8R3woYeT3yXgM7LrmjI
 zJxaq82T0Hgqa0ofJGf6Fn2CXR//4SA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-DrcdURvoNc-AOXpcAhvUAg-1; Thu,
 26 Feb 2026 03:32:38 -0500
X-MC-Unique: DrcdURvoNc-AOXpcAhvUAg-1
X-Mimecast-MFC-AGG-ID: DrcdURvoNc-AOXpcAhvUAg_1772094757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83A1C1956088; Thu, 26 Feb 2026 08:32:37 +0000 (UTC)
Received: from [10.45.225.23] (unknown [10.45.225.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF09219560B5; Thu, 26 Feb 2026 08:32:34 +0000 (UTC)
Message-ID: <e1f90992-2336-45b3-bd90-ea7a242ce16f@redhat.com>
Date: Thu, 26 Feb 2026 09:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] python: replace avocado tests with pytest
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260225210415.972192-1-jsnow@redhat.com>
 <20260225210415.972192-3-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260225210415.972192-3-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
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

On 25/02/2026 22.04, John Snow wrote:
> Following suit with the rest of this repository, drop avocado and
> replace it with the Python standard "pytest" package.
> 
> In this case, we do not truly need pytest as all we are using it for is
> running other python processes formerly launched by shell scripts, but
> this matches how the standalone python-qemu-qmp package does things,
> which keeps things simple on my end.
> 
> (pytest version chosen based off of Debian 11's package version as queried by
> repology; under the assumption that this is the likely the oldest
> version we currently leverage in testing.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/Makefile          |  4 +-
>   python/setup.cfg         |  1 +
>   python/tests/linters.py  | 89 ++++++++++++++++++++++++++++++++++++++++
>   python/tests/minreqs.txt |  1 +
>   4 files changed, 93 insertions(+), 2 deletions(-)
>   create mode 100644 python/tests/linters.py
> 
> diff --git a/python/Makefile b/python/Makefile
> index b6c9cd1bce2..42994d39618 100644
> --- a/python/Makefile
> +++ b/python/Makefile
> @@ -105,7 +105,7 @@ develop:
>   
>   .PHONY: check
>   check:
> -	@avocado --config avocado.cfg run tests/
> +	@pytest -v tests/*.py
>   
>   .PHONY: check-tox
>   check-tox:
> @@ -113,7 +113,7 @@ check-tox:
>   
>   .PHONY: check-coverage
>   check-coverage:
> -	@coverage run -m avocado --config avocado.cfg run tests/*.py
> +	@coverage run -m pytest -v tests/*.py
>   	@coverage combine
>   	@coverage html
>   	@coverage report
> diff --git a/python/setup.cfg b/python/setup.cfg
> index c46a95f8d41..03344526730 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -43,6 +43,7 @@ devel =
>       mypy >= 1.4.0
>       pylint >= 2.17.3
>       pylint != 3.2.4; python_version<"3.9"
> +    pytest >= 6.0.2
>       tox >= 3.18.0
>       sphinx >= 3.4.3
>   
> diff --git a/python/tests/linters.py b/python/tests/linters.py
> new file mode 100644
> index 00000000000..28556c09910
> --- /dev/null
> +++ b/python/tests/linters.py
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import subprocess
> +import sys
> +
> +
> +def pyrun(*args):
> +    subprocess.run((sys.executable, *args), check=True)
> +
> +
> +class TestLinters:
> +
> +    def test_flake8_pkg(self):
> +        pyrun("-m", "flake8", "qemu/")
> +
> +    def test_flake8_scripts(self):
> +        pyrun("-m", "flake8", "scripts/")
> +
> +    def test_flake8_qapi(self):
> +        pyrun("-m", "flake8",
> +              "../scripts/qapi/",
> +              "../docs/sphinx/qapidoc.py",
> +              "../docs/sphinx/qapi_domain.py")
> +
> +    def test_isort_pkg(self):
> +        pyrun("-m", "isort", "-c", "qemu/")
> +
> +    def test_isort_scripts(self):
> +        pyrun("-m", "isort", "-c", "scripts/")
> +
> +    def test_isort_qapi(self):
> +        pyrun("-m", "isort", "--sp", ".", "-c", "../scripts/qapi/")
> +
> +    def test_isort_qapi_sphinx(self):
> +        # Force isort to recognize 'compat' as a local module and not
> +        # third-party
> +        pyrun("-m", "isort", "--sp", ".", "-c", "-p", "compat",
> +              "../docs/sphinx/qapi_domain.py",
> +              "../docs/sphinx/qapidoc.py")
> +
> +    def test_mypy_pkg(self):
> +        pyrun("-m", "mypy", "-p", "qemu")
> +
> +    def test_mypy_scripts(self):
> +        pyrun("-m", "mypy", "scripts/")
> +
> +    def test_mypy_qapi(self):
> +        pyrun("-m", "mypy", "../scripts/qapi")
> +
> +    def test_mypy_iotests(self):
> +        cwd = os.getcwd()
> +        try:
> +            os.chdir("../tests/qemu-iotests/")
> +            pyrun("-m", "linters", "--mypy")
> +        finally:
> +            os.chdir(cwd)

Not my area of expertise, but as far as I know, the iotest linters are 
already run during "make check-block", see tests/qemu-iotests/297 ... so 
aren't we checking those iotests now twice? ... so maybe best leave the 
iotests out of this script?


> +    # Setuptools v60 introduced the SETUPTOOLS_USE_DISTUTILS=stdlib
> +    # workaround; stdlib distutils was fully removed in Python
> +    # 3.12+. Once we are on >=3.12+ exclusively, this workaround can be
> +    # dropped safely. Until then, it is needed for some versions on
> +    # Fedora/Debian distributions which relied upon distro-patched
> +    # setuptools present in CPython, but not within setuptools itself.
> +
> +    def test_pylint_pkg(self):
> +        os.environ['SETUPTOOLS_USE_DISTUTILS'] = 'stdlib'
> +        pyrun("-m", "pylint", "qemu/")
> +
> +    def test_pylint_scripts(self):
> +        os.environ['SETUPTOOLS_USE_DISTUTILS'] = 'stdlib'
> +        pyrun("-m", "pylint", "qemu/")

That should be "scripts/" instead of "qemu/", shouldn't it?

> +    def test_pylint_qapi(self):
> +        os.environ['SETUPTOOLS_USE_DISTUTILS'] = 'stdlib'
> +        pyrun("-m", "pylint",
> +              "--rcfile=../scripts/qapi/pylintrc",
> +              "../scripts/qapi/",
> +              "../docs/sphinx/qapidoc.py",
> +              "../docs/sphinx/qapi_domain.py")
> +
> +    def test_pylint_iotests(self):
> +        os.environ['SETUPTOOLS_USE_DISTUTILS'] = 'stdlib'
> +        cwd = os.getcwd()
> +        try:
> +            os.chdir("../tests/qemu-iotests/")
> +            pyrun("-m", "linters", "--pylint")
> +        finally:
> +            os.chdir(cwd)

Same question here about the iotests as above.

  Thomas


