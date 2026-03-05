Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB9AEEF319
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 08:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy47Y-00006E-SM; Thu, 05 Mar 2026 03:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vy47W-000061-7q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:31:46 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vy47S-0003Ep-B9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:31:45 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso4162493b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 00:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772699501; x=1773304301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NCo5MBS0euktFnC5J/YDXnyR2OVNBgMHzvP5I1GAcnc=;
 b=fIVMDpTvtd7+LTNbHe5xaedYLc4gX/FquH8Ufced7bHdOaoG4zKd9RRuF5Du2thr3D
 u6J6rR4zOfY5mmVZWLDbo99q715xxtVpPTFh5Vjf25XBOwvYH0GRicQtb89e/QYAZyvI
 cvjzweLQ1jq5mTLrpySz107nm9LADF38kAjdPIuHAWHNkGLIwUDgCh1gZ3e/vvLIurNB
 1642SJQEw4FLNqlinoWg3KhtikbVns9h3Bz3lkYpUmSAKZWXzgpAF3Wuq5DTjGXuhr6W
 8EQ3I0HFlcMGrdN74oH1AEiJpuFzxQFmhp8uFT26TBZzSUvTrT4f1MytyTyHEH4WmD65
 Dh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772699501; x=1773304301;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NCo5MBS0euktFnC5J/YDXnyR2OVNBgMHzvP5I1GAcnc=;
 b=OhxkpMCrgUqJLPDmCS+saMfT98GNAQYDVRa3q2xaijaxR3vuDa55PBJ84234BBLtCD
 8SXKpEszq0YPDdfR0oveMNbkgC38PrvnQyqLxpJ5rVcPHQYLGzhMKy/LBQFc3bENk/n+
 Ie47f45WXyBC2C50/cJeKNzTP2pva0kAcYATyR0NajFNyOp8WhPGeBSmjmRoPUZ+BvPe
 qIGrFMOiiLTsD+E3lNiGGL5DFrSN7kw3g+mfKd/yxoMrP3wd70VFyuEf+3uIwSy20nkK
 aRO5M/0yApwd2L5tuzInocBviCYyZDLAzPMUmuDLW7FQWzWZGUGK815g422WyIkUz+ly
 MCUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfjzzO3y1hpQkOjMtcfrjJ0xQzuUbBjE6W09AfyUojJs/1Z11yUrOMoYM2v7jdvy+dNRNY4eAecaQq@nongnu.org
X-Gm-Message-State: AOJu0YwVbelNuiMpiADzMeris19xyxKxPUa886/o7SJslH7a+TVRC1I9
 DBt0sPcqxap+FyEjiO86jsGFCuN9Mbdrx8ptIFDYpmF9cjcx7D86BTiDiraaC3tDvo/8acsWwKG
 wPTN8
X-Gm-Gg: ATEYQzz17XndwScyiqmMSgnfbcCXFmzxaIhULkNyDg52ndnw/pAdqzPOw0eKcOnJLso
 CEOFMOmLPim3pS95RXzlkbiCdBMSqwI/qNWqWZZLKL6ZEzGrWB+UvcGGGKJ4Drt2j6vl2nI/a6O
 MS/eCDLl3aRyYlr/frCjSoDgC/hNjwjCs0zd/S618hDPgQ210gi7bi8f7W3e2rLoI0lH99knmBM
 7a9brGtnd+vciV6vxRBItoHK99WTfUu8/WLmXXvFnKrzVv428Bt4C0KKa8R0QT1y+8Zw1JV/05D
 x8aKuIlLpm52D3eJBvXTGibJvsCXxjdD4QumV84kCEVSoz2cd76M5Mq6Q+yjVUxUIQqZIKvE+RR
 jaUTYtrR1yJMzs8zVFPXFjuyI3lMa6aW0h0TTRZBW1WVy2OH7Rob12jloW5nuLgcv706ztYwA6Y
 Wf8JjOMIxXWG+pOsqNymJJBz4ywQOde+utIsSPBTILkPN/VkM6Tb+ahlANv/G8rMgrFkmg
X-Received: by 2002:a17:90b:3d92:b0:359:8957:7285 with SMTP id
 98e67ed59e1d1-359b1ba0e86mr1163317a91.3.1772699500550; 
 Thu, 05 Mar 2026 00:31:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359aa2930bbsm1551388a91.6.2026.03.05.00.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 00:31:40 -0800 (PST)
Message-ID: <3cced6bb-94e5-4f2d-b4ff-d7ab78c8d689@linaro.org>
Date: Thu, 5 Mar 2026 00:31:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cpp: Add -fcoroutines
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260304-cpp-v1-1-7d87b975fc1e@rsg.ci.i.u-tokyo.ac.jp>
 <7904b95a-c48d-41e0-80ae-63759e5a24ab@linaro.org>
 <0f5dbe02-f50a-4c7c-9d48-24aac06b3a2f@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
In-Reply-To: <0f5dbe02-f50a-4c7c-9d48-24aac06b3a2f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 3/4/26 9:27 PM, Akihiko Odaki wrote:
> On 2026/03/05 3:03, Pierrick Bouvier wrote:
>> On 3/3/26 11:59 PM, Akihiko Odaki wrote:
>>> GCC 15.2.1 requires it:
>>>
>>> [67/6111] Compiling C++ object contrib/plugins/libcpp.so.p/cpp.cpp.o
>>> FAILED: contrib/plugins/libcpp.so.p/cpp.cpp.o
>>> c++ -Icontrib/plugins/libcpp.so.p -Icontrib/plugins -I../contrib/
>>> plugins -I../include/plugins -I/usr/include/glib-2.0 -I/usr/lib64/
>>> glib-2.0/include -I/usr/include/sysprof-6 -fdiagnostics-color=auto -
>>> D_GLIBCXX_ASSERTIONS=1 -Wall -Winvalid-pch -Werror -O2 -g -
>>> D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-
>>> aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-
>>> used-regs=used-gpr -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -
>>> D__STDC_FORMAT_MACROS -fsanitize=address -fstack-protector-strong -
>>> fsanitize=undefined -Wempty-body -Wendif-labels -Wexpansion-to-defined
>>> -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-
>>> fallthrough=2 -Winit-self -Wmissing-format-attribute -Wredundant-decls
>>> -Wshadow=local -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-
>>> missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /
>>> home/me/q/var/qemu/linux-headers -isystem linux-headers -iquote . -
>>> iquote /home/me/q/var/qemu -iquote /home/me/q/var/qemu/!
>>>    include -iquote /home/me/q/var/qemu/host/include/aarch64 -iquote /
>>> home/me/q/var/qemu/host/include/generic -iquote /home/me/q/var/qemu/
>>> tcg/aarch64 -pthread -fPIC -MD -MQ contrib/plugins/libcpp.so.p/
>>> cpp.cpp.o -MF contrib/plugins/libcpp.so.p/cpp.cpp.o.d -o contrib/
>>> plugins/libcpp.so.p/cpp.cpp.o -c ../contrib/plugins/cpp.cpp
>>> In file included from ../contrib/plugins/cpp.cpp:91:
>>> /usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine>
>>> header requires -fcoroutines"
>>>      43 | # error "the <coroutine> header requires -fcoroutines"
>>>         |   ^~~~~
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>    contrib/plugins/meson.build | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>>> index 099319e7a173..caa0fca17245 100644
>>> --- a/contrib/plugins/meson.build
>>> +++ b/contrib/plugins/meson.build
>>> @@ -26,8 +26,14 @@ endif
>>>    t = []
>>>    if get_option('plugins')
>>>      foreach i : contrib_plugins
>>> +    if i == 'cpp.cpp' and cxx.has_argument('-fcoroutines')
>>> +      cpp_args = ['-fcoroutines']
>>> +    else
>>> +      cpp_args = []
>>> +    endif
>>> +
>>>        t += shared_module(fs.stem(i), files(i),
>>> -                       dependencies: plugins_deps)
>>> +                       cpp_args: cpp_args, dependencies: plugins_deps)
>>>      endforeach
>>>    endif
>>>    if t.length() > 0
>>>
>>> ---
>>> base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
>>> change-id: 20260304-cpp-ddc219374e4f
>>>
>>> Best regards,
>>> -- 
>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>
>> Hi Akihiko,
>>
>> it seems like you ran into this issue:
>> https://lore.kernel.org/qemu-devel/875x8ft5vq.fsf@redhat.com/
>>
>> You can just clean your build folder and restart from scratch.
>> See the thread above, it's a limitation of meson (by design) not
>> updating language standard.
>>
>> The best fix on our side would be to add -std=... directly in c/cxx
>> flags instead of relying on default options.
> 
> I withdraw this patch. Passing -fcoroutines is not a right approach when
> the default option configures the project to use a newer C++ standard.
> 
> I hope Meson and QEMU figure out a solution that improves the user
> experience.
> 
> Thank you for point out the thread.
>

Sorry for the bad experience on your side, and I hope too meson will end 
up fixing this, even though the open issues are not very encouraging.

> Regards,
> Akihiko Odaki

