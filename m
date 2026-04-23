Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68167FDEE42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyrV-0003mZ-VZ; Thu, 23 Apr 2026 14:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFyrQ-0003lw-Ex
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:33:13 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFyrN-0001bS-Ol
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776969171; x=1777573971; i=deller@gmx.de;
 bh=5qhqxDte9ARmB4VqgxX6anMdoxTdrP+258rETcJWFHE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OjZTZrQ7PBrYp2uUpkFdDFN38WydBGwktJhT7/2T2EQT+Zxq6TCip94FQA6/h0E7
 AxICZjZ+v4zwT1yATLOYdJ4BlV2p51CLZpiIvIV5mcq51WUL5xHQTngSLhlk9dEYn
 x40/LKB8mafuThF/JFSIPctIcCSZi0rrDfnRE3zoiLF/qUgm+6TVdXOmdFwefKFT0
 6gA3AATLEyeV+otXSzcuIWjEJAYAcxeV0UURiU74q4pI83vEIdf+5FRE3B4prPkrA
 s/5UXwKxnrrVdX8Qthf0F5un0tJ1/QuMT7xTDpg9zUDUFdfH6R9J/UnlBKm7K5Z9g
 pW4pY4GUG86aCV/OLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1w0oPq1Kjh-00YblX; Thu, 23
 Apr 2026 20:32:51 +0200
Message-ID: <81a244cd-2ba6-43ae-8071-90df3c52a1b5@gmx.de>
Date: Thu, 23 Apr 2026 20:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 pierrick.bouvier@posteo.net,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 gaosong <gaosong@loongson.cn>
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
 <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
 <ff06a5b1-f36f-ccc9-3d8d-90f3fed1320c@loongson.cn>
 <CAFsMJvDO8CPt1xAYMBc9JWEE6FPsvNZjwAtWEAsQjVoMneTUNw@mail.gmail.com>
 <23e33b6a-acca-4e01-aa3e-d702aa45ea4c@gmx.de>
 <CAFEAcA_SdysnnbwVt0SLLA3=sjzNxKwxUgE7Eue3XPea8od4wA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA_SdysnnbwVt0SLLA3=sjzNxKwxUgE7Eue3XPea8od4wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:74kTKRZo+xebsIom+pJ6X2HsFCNhgI/7OEjO1r9H2RN6rV0RfWZ
 ocUkRAPQGGzcsz5lfhVMoNRab0BoBdzjZyxwC2KANsItrRvlXUvvXLnQj0H7ONZ9RQBokFs
 Dv381wEkLDKZWJ1mTcu6dMEEOEcP8IidBYEXRxLbmP37Xs/WEwjhH56eFD5GsZHIxjCNZiu
 BM/uQhWmAtlehnZYdxvsA==
UI-OutboundReport: notjunk:1;M01:P0:ZbtNIvL+eds=;zBcXTHWTAgMDu/EIHm0ZJUhHz8z
 uuc80j/MHO3/WPyTdWkcreyHV20yLQiiZr1GkDZez1/KoyMl6/DLXG3c1Pf3RyAoR0OiZod2G
 7VZz2BUOr+KE9DfrtSDoOG8X37fHPnH8Q5QMtJ9uQ9P9NBFbhAtw5uUQRI+goD23WlBPurC4C
 SBvtSACSe5iHIKYqd/4s0dcLpHkpw+hgupm9YETe8nNNjNa17vbnUYDWyT3W9DYDGF056o2xT
 ZL4L8m8lzd8EOWnWpp8MNBEW9xe/j01N+ddpPbV80CI5m+dzLZAk0MJkj+/5ky4WgmH/P5UrH
 hW1HyUGcgMS4RlXRyzINcV/vE33vxw/p5ixLjPKPREq2GgntOXwa1hJKU4G9gqHZuPaLhB9lX
 lyOm4AVW5GX6dadjA3fJBOKVspGrF2VmxAeRfNVhCCGZdhhX5FWXeivlMmIzDApaBQfvvtOh0
 FY2USVQ0nKP4WYiKllU98yUCgw4PgaMOKW5Po7QV+sINm8h2bV4e5WFMJ9GieiGtS4hNQzPa3
 t720Autgvag1j50jnj8mQ0pOJqrKVb1IE7Rbg5th0oxQQT4yrBmvRLicMCiggKB1RhWO2/zFp
 aySEaTRmaeMB5Qe0gQLQjDue9KgJ9knknGXbb5YdXvIUd/M8YGE9muWPqUCbs/F7oXDFweaaZ
 OR8FHMnghLirLZOFopHZpppIy8GoHjnHuzerqxtRgIykSvCW9jN4SLn2VxoFwV+iAyKTdjs0C
 UiR9ayhrIvJ/YXOLHqoVbRJbhfAqRrlI/umCKZw7qVH9cezLgox7jo2ELvdhkQ0HCj86ZLnQg
 XKLKXA/L0n58fCpY2pUq52XJnRZyStPBjaNHHVVVU+JqaiktwY/RaLDCFkxFu6A50DMj73Pja
 fPkK2V/uzwYhqyO8jQbp42p+KPAMMO1DOSNF01jHkVvYZcGzSYImdlOyWUYuBZ2uTAGFBtVGB
 CYWhRoG6miOF8aoFdl7apj+UtKXTkucWWgycLJT2sPgdy8O2DU3x6L3p/yoQwNuL9dMqIqKry
 eqrOBq2bo/SFRPrwRhWO4J9UnMS4mFG+Qbmg5Gc1Oy1yQQt7VHHoz2RiNLAp2M7QzN0z31dRd
 4Nl/ejV0/zF/HlpH1aC17bPGYsv6D80Ius+ijZFU3k5JcrQKMkqboF5xVErbWocfObXNNEIiW
 AJsKItOEY+uPACQLf8PpdSUoMv/TUbvc08eekCiK5T7q6BpsEgd8YFcKi7O6Fk+fu8Xvg3Cdg
 TW7imEyW8eMnRgLBpDP2un/PdckRQuj+ViauiMphlGVcjhzvJWWKLZ1yNiVjew1gwHFvXA0T9
 wfoGKN6wnS9euUmvnsgpB82NLtabVbABIbimF/C0LYhdP22gzhTe4VY08ps8+QGP2fHKqNDFt
 ySOxlYNZ+X6UyKIcGpebv8DAv5d9HMtYFfEusGLkyh6XESuvh1K/Qn6tw14dvFCwR6XK5d5QO
 XCgVMJUd1Rx8/Gb3KqzMnaPEMBWyvtkXSx2RICEa9bif6wFGgMN2OY+vvfMFzgJaaq1ZvXSwp
 fEwlqg34FHXlRHMfO1+RzCIsKzh1BxGfR8tnJYEUPi7IIH5IMbI6lU9QvVJRoEtHliAyThHbK
 PYiXSvNQ8A6NvCQSOzFs1DT/WEeB4WUHbVd/SZ7f71W2xF/yfkyfZglFOFn8xvkjIYaswk6ee
 yHybUXVNs7+vU+p057MuNoVu9ktpyrzprC15tcFLcrCO5+wW73RzVXDWzOoGED1X+gRNtlmxk
 G4r6UgfadcH/a8Vn7E6xFSvknJ+pkhft4TRPN4+A7EtOe/HyfWupMtpeq0whZKvEW+5VEtWnp
 Eq6nfYR/FDYASlPsqN4LT1qxv+WVMK61dpz3Yun29PY4xMkAhY77AOJrBCMZD+Tuuzwf74f2l
 Q+sruIpSHIzrw+9kaZL2jUjG1Mvxyx5V427Qkj5fOHpOaUUNo12btbv++VS6R3tdx7b0O7Ds3
 XOrjFb9TQXIX/2gm4mIVTEt9wfUHVVvDXAr1z/b0bMaGaAbw8Oz2UEtcDbfH4+aK4H/b63Gcj
 yTUPM3UA6a5lVcNwP6FBwL/OGQzgoYo1gzhq6lSqKeAGeI1YzBO32ZLxNDUOerA20tC6W5Wk6
 /X0oEucKOGV2Noo9hwZQnz6LZwLbv4/xUY6qcbwZcXdc7tSY2P1qETqW37nhCoNoeXqOYVCoY
 kH0a1moCZjEt/3y4eGesPzxxWxR6swQXiWQXuqVp0j1+zkmKitJU/i0dLBw3E3lDFwaqKLTFx
 No7pC5oQ5ALjokZvtltWu53GHbVa8dnQdRQTPJB5LT61/i/BxPJ/GVb6+K3fKV+KjpO6tg/FQ
 OkpaUvEHjlNYXKRCFoUfN2ftWTzwlhlxLSGQJwGeuPs/DeQxw87SJ2m9x8HP/j2HXu0Nvqn/V
 BdOTAcedA+DCMUiNdH/Jsx3tfiI2n4G1y/PvlYg2EG1qdaJzzyfhG1MRtJrnGHLUUq6s2AJHY
 t1YJVfcP19RWwfex5xTxw5zZakl5iqcW9hoERlovKdZUu04R7J6XvT8m51uUb1B8pa+Rf0Mh5
 ACMgQ/tKdSVst+I8xU9RtONHm9HK7CCVh7l+mUffChvBxKDak4GY+WlFZoA8DHZXdvmEGqlMr
 NbLI4GW2+cokhqkaurjaA81Car7n6Z6eBon5lbJs2JctW5fZTb8sMDYg9BNbbEI6ig2XTg+Oz
 oUe1mFFT/zpJmekgoJrxOqIlyX1SevKXLbzPDHP+BC1ClXmdMUCQON32OVrQbmEzL7ckwPb8c
 jp0NrjCTeM7dhK5cvitt4/8UKNntYrfWxaStAtxbTACxu/20Fne6X+2MhrvJ8vWvrCGv+sLmN
 VKdufH2S06X6639hEVYBDJJ92E5kqq0uQtANSop4rDHz83uXqBaoJ41K1wq5VquC430k1scCO
 TL+ddYYh7ljFyubQivALE0+gtkTerDvGNlUuEX5W3jdb8Z4VSKGmbKLStt1V1ChqJx8sBwX+Z
 fsHDTa2JPAlZST0l+jetSuXyuFR+erltWCST3bmBo1ClGcTJn/+YRMJr1wbw9wL9hWGXZL/Dp
 Nwwa0qViNuyIzWiP87aUgCQxD9jIXPzeVwZecN7gc5kVvkE7qtNHISfCNhNeW+LUJnZLTcho/
 H5sImtGoM3zpY+PloOSVqjvP3KtXXrK7maQ/PIETc7svH78wPuiZgP0NCqsb31LE7W5rSpflS
 8tQgfboXr6KxfRREDj8UK0XmAWPiMFtlIswhpVHMt0Dfp3BICbWB/UFV0olZcbebu80d0sMyZ
 NFZNt+u7RBkCugWo/eFjOsgbr1xmZZ9HiIZINW1WBwCqA8YI05jQ8YxGCE8INqhVJXzxL5Hj1
 goTqcYvyLfdnJk0u7vkqa18YdGLL/r147b50N8ZMEmHnkufZU0FEEUQ9GGH5yp205dCdW8VEr
 YNhrXtVhkG6iMQ5R6lwMgf3kJ1ARoA11w8rR4Jid8353i3lBakmtOMN3DeV8UD+enWESYvKOn
 zXR4phtgsXaQYwmTLZJ0p15KBfw0umrNpMP4RHFpCtnebuddhZlwBQAHP9+UFJJIy2HU3Wp+z
 6kaoodFxif3VldHErgjr6qjsoB6Mt1Cz5gV5wSnmgitzj6bVc9C+06HS3+R9UE43xg7vid+VU
 oVSoJ23cLTUTJE1L2/ONHlJVQ6l1ydpofofrK9Nxu30MWxG5BqCKdLVek4GBCvlXrWyQWFMgR
 bcOZm6ffdtiuj9ZwcupXhLAZbjpfXpwS+76J27ZXMqGry0KCR3uDQNlBA78+uOCkZCxuMKNIy
 fa3NEALjPMNqiL0sicQ9481aG0nfOyRgARlqP9tar/VAOmI1WQIQy/RO79MOD+Kz/OdOZTOzD
 jL74S/RZgLOy5CNT6KC3bHystCKRU7XLEGJSYNYYJ2GyiUlA9NLMT4FuoT4lp5r1zgrr0L5JP
 UYhvjTewHcgZPCx9au//0KosR1dRLTVwxHgRceqqvrjOLS5YnixmbFerJ6AhymS2TBL4QycjK
 6XjVzKV3YZh+ffxuPEdgSuNGixLEJ2pOdsIl+y5fmRAZ8IvteNZL1/BTiLoV5kGBkFrM4lUYy
 94d65cyNgUixlgFwW4di91TZNVxzwHqehbvIRXUiPq/8WBh3By41e7RSRlgcxbmitoaPEkJ3N
 D+4D055PNf5K2Oyin2VXdQkwsvq8oaBMCms67KyDj4CyUy5aUBFfw/XRFmPWNSr6w/KwgXSAm
 MTtZXFYKVNdZtDu1RyJ1aGfEJx8LpLyHMYe8e65TRUHLovy6JF6HPQMHqSjIte0ltpmfCEzTm
 K3z90Xqd6poxdT5357R6xSN8D/Hqor7F3Yot4msUnDo71A2xNJYAk5PigRiet0968+RjI2UIj
 fpmLCmGftHaq90PSfOUUU/85xB7fGAh6JHxhL7XQ0mcXNmEhrP//X9Ft/1p8R3wxSuuvzJF/F
 bTOYo2mzIitcYe7OmwRuj6bix7IF7PfqEkpqO5ai/N6bHxjp7e9xtO65xPnJLYMqOzWZqQdrF
 AykcxGA6GLLi+REzdL0xz8c38QM4paEfD1wtgSm128UPwWCMb5xO6v4mzZp1n8w5YxJWnhatc
 CgTbMGRzYizIBSjbXSsO6lgz6Rgqi2O55hO2s5A0o2CGgZacnRwcRQe/gzOZdarUowLV71aMi
 XEBTYabhaMWpfPbUxWoBZ+LtUsGTThxKxE2n5G8PGYZ9IpfKeyZ0F7U0+Fhaw0z630+Vnhm+g
 UGx2dlS5nuMpsq3QnQPFOoXtKyJJTDlmATzruR/LH8p1UF3Zk4LJLmmgyLCwyuTrBcSxse3LY
 4tOfsX/cEj0q5qtBXu5J9r8lfeiG35i2njSaM9nlXF8W4AbYlgq7nL3knNNqnT1x95BamSPCK
 v7JUrmRYgE27OjaSF5exm0AAW9Vf9JyZAzDcrCAmO3x0RBEi9S7FVuqyh5nP0XUhS1S5LI+OZ
 nnlkJearGjVm5l+kJ2FcVFtvLW3qQ55LYkiGRKUQOrKaX8UpIEBlndnakZGugR/vQ7t7+hvsw
 WzdWXPP/LcPQN5PILzb+ffn9yD3E2aJNOYz+UrwLT3WjD7Y8DKpAXZIqwPtVYVsj1T6IM8V0y
 Ycatr/gT+dCP0/yfdmFvV/01jgE3HbWCB1JVHeT0ZY4R4g42oIZTDtdUx7xHwYWcYaUmJXXZE
 U63YFwGqMzLtu8KFl9uwz6YMvH5pxysAoreDSlyb6Q6Z0Tb5XeKE/k8rf8dBYIZXeWVnr14Hu
 UVnWXiieRpEZmbntOdiA1G7BNj75wBTvqATcyszRHMAdPoNwwQ7Al+IWvHYZmX18UHgoFQX6t
 zjz36O5OUMpzO3VBmj1CVGkuUA/epCl7ysi3ry5C4SiYjKRw8UJMmMMIS4qQEJzRxoiqqg42F
 UvzxfV6VtX3X2uhuot3+rFpQaPBcPtJqQRCgs12531l+9MJWuv7gOhgEzZIRY4EMLwCDWvLLp
 ryiZ82m642l/3QSI4SsoRZgKfYtp37QIXFDc0DqQ+U9Qdnm8SVdPY2RXozn6MOMZQ57M7pKez
 e2XGIVRL0P5P2TNFBmZvWokwLylBueWYcsLBuMmPPFmqqDzC9ERcdW9fuWoKlKG6vHW0QILFJ
 /KKt1A==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/26 18:09, Peter Maydell wrote:
> On Thu, 23 Apr 2026 at 16:36, Helge Deller <deller@gmx.de> wrote:
>>
>> On 4/16/26 21:14, Gyorgy Tamasi wrote:
>>> Hi Peter,
>>>
>>> Your analysis cleared some things related to this older changeset:
>>> https://github.com/qemu/qemu/commit/c52e405968341b1d10c618f23bdbb841e3=
9f9255
>>>
>>> Before this syscall-NR 79 & 80 (newfstatat & fstat) was not enumerated
>>> in the old/deleted (non-generated)
>>> linux-user/loongarch64/syscall_nr.h=E2=80=8E...but these appeared agai=
n in the
>>> newly created linux-user/loongarch64/syscall.tbl=E2=80=8E.
>>>
>>> I can recall that I was getting "Unknown syscall" messages for 79 &
>>> 80, when I tried to run qemu-user 8.x.x even with the simplest ABI 1.0
>>> executable, because even the shared-lib loading phase failed on these
>>> missing syscalls 79 & 80 (used by the old glibc env of that ABI 1.0
>>> exe). So in the case of that older qemu-user 8.x.x it was obvious that
>>> it is not compatible with ABI 1.0.
>>
>> I've applied this patch to the linux-user for-next git tree at:
>> https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dhe=
ads
>>
>> I've added the comments from Peter to the commit message.
>> Peter suggested to adjust the commit message.
>> Gyorgy: If you want to resend the patch with a rephrased commit message=
, I'm happy to take it.
>=20
> That's more conversational than we usually are for commit messages. Here=
's
> my suggestion:
>=20
> =3D=3D=3Dbegin=3D=3D=3D
> linux-user: Don't define target_stat64 struct for loongarch64
>=20
> The kernel defines 'struct stat64' only if
> __BITS_PER_LONG !=3D 64 || defined(__ARCH_WANT_STAT64).
> loongarch64 doesn't set __ARCH_WANT_STAT64, and it isn't 32-bit,
> so it won't get this struct.
>=20
> QEMU incorrectly does define a target_stat64 struct. However this
> isn't causing any guest-visible problems, because defining the
> target_stat64 struct and TARGET_HAS_STRUCT_STAT64 affects these
> syscalls:
>   TARGET_NR_stat64
>   TARGET_NR_lstat64
>   TARGET_NR_fstat64
>   TARGET_NR_fstatat64
>   TARGET_NR_newfstatat
>=20
> For loongarch64 the only one of those we provide is newfstatat,
> and that is actually a separate QEMU bug, because the kernel does
> not provide that syscall for this architecture. No real guest
> code will be using a syscall that doesn't exist in the ABI.
>=20
> (Some of these syscalls are present in the loongarch64 "ABI1.0",
> but that ABI was never accepted in the upstream kernel, and
> QEMU does not model that ABI, only the "ABI2.0".)
>=20
> Stop defining TARGET_HAS_STRUCT_STAT64 anyway, for consistency
> with the kernel and to avoid confusion.
> =3D=3D=3Dendit=3D=3D=3D

Thanks Peter !

I've changed the commit message accordingly.
Should I add an Acked-by or Reviewed-by from you?

Helge


