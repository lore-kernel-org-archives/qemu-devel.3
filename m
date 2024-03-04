Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C200C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh853-0003Av-UA; Mon, 04 Mar 2024 08:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rh84u-00035F-AV; Mon, 04 Mar 2024 08:10:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rh84o-00030K-3F; Mon, 04 Mar 2024 08:09:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5FFDA52C77;
 Mon,  4 Mar 2024 16:10:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85B4B8F70E;
 Mon,  4 Mar 2024 16:09:51 +0300 (MSK)
Message-ID: <4a05a2cb-7ef8-452c-9ba1-6d672ed40b80@tls.msk.ru>
Date: Mon, 4 Mar 2024 16:09:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240304130403.129543-1-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240304130403.129543-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

04.03.2024 16:04, Thomas Huth пишет:
> The macOS jobs in our CI recently started failing, complaining that
> the distutils module is not available anymore. And indeed, according to
> https://peps.python.org/pep-0632/ it's been deprecated since a while
> and now likely got removed in recent Python versions.
> 
> Fortunately, we only use it for a version check via LooseVersion here
> which we don't really need anymore - according to Repology.org, these
> are the versions of sphinx-rtd-theme that are currently used by the
> various distros:
> 
>   centos_stream_8: 0.3.1
>   centos_stream_9: 0.5.1
>   fedora_38: 1.1.1
>   fedora_39: 1.2.2
>   freebsd: 1.0.0
>   haikuports_master: 1.2.1
>   openbsd: 1.2.2
>   opensuse_leap_15_5: 0.5.1
>   pkgsrc_current: 2.0.0
>   debian_11: 0.5.1
>   debian_12: 1.2.0
>   ubuntu_20_04: 0.4.3
>   ubuntu_22_04: 1.0.0
>   ubuntu_24_04: 2.0.0
> 
> So except for CentOS 8, all distros are using a newer version of
> sphinx-rtd-theme, and for CentOS 8 we don't support compiling with
> the Sphinx of the distro anymore anyway, since it's based on the
> Python 3.6 interpreter there. For compiling on CentOS 8, you have
> to use the alternative Python 3.8 interpreter which comes without
> Sphinx, so that needs the Sphinx installed via pip in the venv
> instead, and that is using a newer version, too, according to our
> pythondeps.toml file.
> 
> Thus we can simply drop the version check now to get rid of the
> distutils dependency here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks once again,

/mjt

> ---
>   v2: Updated the commit description (it's about sphinx-rtd-theme,
>       not the Sphinx program itself)
> 
>   docs/conf.py | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index e84a95e71c..1b2afa241c 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -29,7 +29,6 @@
>   import os
>   import sys
>   import sphinx
> -from distutils.version import LooseVersion
>   from sphinx.errors import ConfigError
>   
>   # The per-manual conf.py will set qemu_docdir for a single-manual build;
> @@ -165,11 +164,10 @@
>   # Theme options are theme-specific and customize the look and feel of a theme
>   # further.  For a list of options available for each theme, see the
>   # documentation.
> -if LooseVersion(sphinx_rtd_theme.__version__) >= LooseVersion("0.4.3"):
> -    html_theme_options = {
> -        "style_nav_header_background": "#802400",
> -        "navigation_with_keys": True,
> -    }
> +html_theme_options = {
> +    "style_nav_header_background": "#802400",
> +    "navigation_with_keys": True,
> +}
>   
>   html_logo = os.path.join(qemu_docdir, "../ui/icons/qemu_128x128.png")
>   


