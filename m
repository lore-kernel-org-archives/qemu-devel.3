Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE30D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlW14-0005NH-IH; Thu, 29 Jan 2026 12:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlW13-0005N1-EJ
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:41:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlW11-0001BH-Cj
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:41:13 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so8587425ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708470; x=1770313270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ac3rQ4u8YjcxsdLYoBbZm9vCJsEqwXvMKL5x4uxfm70=;
 b=tEjdBo7lRUuEESQrgJc5VVMcgv4KSkM98eFQZ29jn6E87fzgGUQcXinXmNnRnqcb2d
 MJU0krdzRDSFZKODJmGdkD6Df5aWuJNhw2IFrA0nbuEY8W24iS7WUK7zUb2aFc/Oz7Pu
 nSeeJuYos6Ff2RXPFllAL+xEgfp9rCtiY6qqU7Z8Dpbq28P5A0klesjk1bv96FNHfLOO
 WcJmIwJvFG4Jv9FDtSwsBVlrLTZ4UJ2VORnydUA+h+JM3GTqHe3MO3+WM9/MxZ3kbaaf
 PuQG2i67Jfav9B67wE8CFvPpZK1p1QC4xm8yh6v7YabGZoADnazwzdJe31u1kdtHXeTw
 JvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708470; x=1770313270;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ac3rQ4u8YjcxsdLYoBbZm9vCJsEqwXvMKL5x4uxfm70=;
 b=h9cuQjsxeSKpjgWZ4WF2BNu2/jIzrY5KO2vRO97qx/poei+wUweVm91VHLK/7PgChj
 XyspuoerQsNhxsWyhFhbmUuYkoEEkc/aMOxvr3cqNttc40LJUssJLcO1y6G3mOSSoc+f
 6O35RgRPoavviqM4ZxMpTI5WN6iEO5WBMIjEJLaPzWUPNvurLlE5PBdv9cfUzrdJEfl4
 Aajfmn/f8utBVl3/VcGu4Dmxdx4G9krmsBt1hG28JM0K+ze04SWH+Ug4VZITvCd+ui6E
 Pr+AxZ0lred6rZiP3AUzCoo4gg/uTPvMiNaRqvhCS+JcMQS+ySsdRUZNbkCydp7KfBXH
 OasA==
X-Gm-Message-State: AOJu0YzA3REqG8V5YPg2vPLtOmEQBPhSN9F1WXPOX/9o5WgaDUBtOPkD
 1bQ4KcmfONrFmCoZpLCEJl/YB8BjxjRrEon85lD5FAW+sW7zs99CLvCgt0zUveREbjpo3LymQmk
 gKr6p
X-Gm-Gg: AZuq6aJyCmrZyrZOQWaCALAGfcJpsMaMiM8vit2xA/CGj5FRwLdluA6CcemF4NmzCxx
 D2IUMyPDryErjKmBZov92K6JXS4N3Mnr5m1ua9Sp3vNp+LDQadOoSTxuZExyHGnldShBoQC4YE0
 GA07YzuokO6p6ogzHrEBdmMcIdMBAgA6UM4KNn7K691ZG9FVnE8B0IVpRMYo5FCnQD6txP32qoZ
 fFPmhclrTzxXhikijChCECce1GugMwZ8bIc3eqa2CACFvnGW0TSoqxOU6YKzKd8mHOm1IDhfV9W
 BIY26Bf8Gcghh0uwVth+tZnB0gzZfI7TD8PjyCCx0SVM8jvDg/qXVP8nqzjoTeIKfWj9E9lAuKl
 xAVPwtB54t4ue7O0xndQRSjILDnNIWvRO4cac3pya9mV6kM/Qcxeg+iTfid6TL37J9nNWzxe61q
 fdQv+ZmdV45jC1pzeLw/nDEFL2dOQgQFiWjeS4OY5og5T8nQaFe8bDHzND
X-Received: by 2002:a17:902:e841:b0:2a7:9592:210a with SMTP id
 d9443c01a7336-2a870dcba87mr90985365ad.33.1769708469678; 
 Thu, 29 Jan 2026 09:41:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b417394sm54543695ad.42.2026.01.29.09.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 09:41:09 -0800 (PST)
Message-ID: <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
Date: Thu, 29 Jan 2026 09:41:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
To: qemu-devel@nongnu.org
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
> The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:
> 
>    Merge tag 'pr-build_fix-20260128' of https://gitlab.com/pbo-linaro/qemu into staging (2026-01-29 13:29:33 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260129
> 
> for you to fetch changes up to bed25f00d306bbbcc85d068b6469fc00aeecbd11:
> 
>    plugins: reduce source conflicts in plugins list (2026-01-29 09:34:14 -0800)
> 
> ----------------------------------------------------------------
> Changes:
> - contrib/plugins/hotblocks: Minor bug fixes and add limit argument (Alex Bradbury <asb@igalia.com>)
> - linux-user: introduce syscall-filter plugin API (Ziyang Zhang <functioner@sjtu.edu.cn>)
> - plugins: return bool from register r/w API (Florian Hofhammer <florian.hofhammer@fhofhammer.de>)
> - plugins: enable C++ plugins (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
> - plugins: reduce source conflicts in plugins list (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
> 
> ----------------------------------------------------------------
> Alex Bradbury (5):
>        contrib/plugins/hotblocks: Correctly free sorted counts list
>        contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
>        contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
>        docs/about/emulation: Add documentation for hotblocks plugin arguments
>        contrib/plugins/hotblocks: Allow limit to be set as a command line argument
> 
> Florian Hofhammer (1):
>        plugins: return bool from register r/w API
> 
> Pierrick Bouvier (13):
>        linux-user: move user/syscall-trace.h to linux-user/syscall.c
>        plugins: move win32_linker.c file to plugins directory
>        plugins: factorize plugin dependencies and library details
>        plugins: use complete filename for defining plugins sources
>        plugins: define plugin API symbols as extern "C" when compiling in C++
>        tests/tcg/plugins/mem.c: remove dependency on qemu headers
>        plugins: move qemu-plugin.h to include/plugins/
>        meson: fix supported compiler arguments in other languages than C
>        meson: enable cpp (optionally) for plugins
>        qga/vss-win32: fix clang warning with C++20
>        meson: update C++ standard to C++23
>        contrib/plugins: add empty cpp plugin
>        plugins: reduce source conflicts in plugins list
> 
> Ziyang Zhang (2):
>        linux-user: add plugin API to filter syscalls
>        tcg tests: add a test to verify the syscall filter plugin API
> 
>   docs/about/emulation.rst                         |  12 +++
>   docs/devel/tcg-plugins.rst                       |   4 +-
>   meson.build                                      |  26 ++---
>   include/{qemu => plugins}/qemu-plugin.h          |  62 +++++++++---
>   include/qemu/plugin-event.h                      |   1 +
>   include/qemu/plugin.h                            |  35 +++++--
>   include/user/syscall-trace.h                     |  43 --------
>   bsd-user/freebsd/os-syscall.c                    |   1 -
>   contrib/plugins/execlog.c                        |  14 +--
>   contrib/plugins/hotblocks.c                      |  20 ++--
>   contrib/plugins/uftrace.c                        |   8 +-
>   linux-user/syscall.c                             |  44 ++++++++-
>   plugins/api.c                                    |  36 ++++---
>   plugins/core.c                                   |  39 +++++++-
>   {contrib/plugins => plugins}/win32_linker.c      |   0
>   tests/tcg/multiarch/test-plugin-syscall-filter.c |  39 ++++++++
>   tests/tcg/plugins/insn.c                         |   4 +-
>   tests/tcg/plugins/mem.c                          |  59 +++++------
>   tests/tcg/plugins/syscall.c                      |  19 ++++
>   contrib/plugins/cpp.cpp                          | 119 +++++++++++++++++++++++
>   contrib/plugins/meson.build                      |  38 +++++---
>   plugins/meson.build                              |  17 +++-
>   qga/vss-win32/requester.cpp                      |   6 +-
>   tests/tcg/multiarch/Makefile.target              |   7 +-
>   tests/tcg/plugins/meson.build                    |  27 ++---
>   25 files changed, 497 insertions(+), 183 deletions(-)
>   rename include/{qemu => plugins}/qemu-plugin.h (95%)
>   delete mode 100644 include/user/syscall-trace.h
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)
>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
>   create mode 100644 contrib/plugins/cpp.cpp

v2
--

- Delete syscall-trace header and move functions to linux-user/syscall.c

Note: There is a regression upstream with native windows builds where:

$ ./configure
Looking in links: file://C:/GitLab-Runner/builds/qemu/python/wheels
WARNING: Location 'file://C:/GitLab-Runner/builds/qemu/python/wheels' is
ignored: it is neither a file nor a directory.
ERROR: Could not find a version that satisfies the requirement
meson==1.10.0 (from versions: none)

This is not related to this series, and seems like an MSYS bug. It can 
be avoiding by *not* updating core packages (pacman -Syu). Hopefully 
will be solved upstream before updating becomes mandatory.

This series has been tested on Windows with changes described above and 
it works as expected.

Regards,
Pierrick

