Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFEAC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg2S-0005et-15; Tue, 02 Jul 2024 12:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOg2P-0005eQ-QA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:07:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOg2O-00079D-4E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:07:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9b364faddso27002455ad.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936442; x=1720541242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYsFmV7hGOpxcKgFklKsON8FSqJ4rZSt39jfDg5UOCo=;
 b=LZ62YYUttWoD2j41Qwc9q9Vrz3YBXGZ5fRdPXVR3psh5+zUwSUmnOGzTBKr5n1VXrr
 1XN/lJw7YpexBPPX3j3/NF80KeAuBWQpAVEMUbJBKqz90EC7TOM/dK0I4AdLIV1/wMl1
 EotDy275rvWxX77OtQSzOc4nCL5vlzSCrU1zystYSp5x8/GFXt38SkmUPi5TEvjqKFLS
 hiNaM9XNUxat6kaT/1Uwfi+Sl8IYWlUXL6hCkO8ps0Fw14Ns1flYCRK7iqifD24C+1M8
 vmVfnthtqlNVUBTPGa4yFOwSJVHU3D+K8Kc5Tk8eXI+uTY7Etlf5GWYsZGovnxB0lc/G
 Uj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936442; x=1720541242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYsFmV7hGOpxcKgFklKsON8FSqJ4rZSt39jfDg5UOCo=;
 b=PsSgwTqu5yp0Jq5pr+DPQvFVn49x7r2ZsswIkaZ8ab4DLnMXdTvtUxevRR/78ernA4
 OCM2lMacfHUxbvhdcpKOLrJN7vd/nTmYRQhw2HIv9Z3Nj98X1fNK444lsXB3Au5eHbsF
 QP8PIx6Bp0CbzUPbdsvn5qfk9X4J2f9P3oE7RY55E//gtwOFVyW86d6qxoM37kNiBkgs
 E6e7sM9mZ5c3YV+ZlzDL7GTDY4nIE/nIg9xFOoZlwwSdGUf378Qx+EoY0g7kH1CKgchV
 WtCnk0N+ZBQ+AH2/jDOBq/BIl8ShZg6aepeQ1str7iR2YgzXjVJNuIXBCyFwb4lwPc8H
 Oe8g==
X-Gm-Message-State: AOJu0YzrhOV38I8p3lMt3aB5AdLouiDVmAB9q8JnnxwMJTwi9rLpGMtF
 3ug7VSvnAGXn78Bon5ARlTf9cgPnSjDuXW5tZszs9fUajgcrJaHLXtsZynUGK0s=
X-Google-Smtp-Source: AGHT+IFu0/nToU+Q48glIk8h8hI41RTBdCHCvasZ2F8YPuHxuNvyClDTMMA/hlZODiuAQD61Bb7fsA==
X-Received: by 2002:a17:902:eccf:b0:1fa:3537:58a5 with SMTP id
 d9443c01a7336-1fadbc73dfemr59035405ad.18.1719936442020; 
 Tue, 02 Jul 2024 09:07:22 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1568efdsm86127315ad.193.2024.07.02.09.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:07:21 -0700 (PDT)
Message-ID: <5b251e76-a22f-4bb7-98fe-b5becb56a1b4@linaro.org>
Date: Tue, 2 Jul 2024 09:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
 <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
 <fu1lr.ewime9aej60m@linaro.org>
 <2626cef5-3ece-4b01-94e8-1d293bd4425b@linaro.org>
 <fzxke.kvm3u8zw4532@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fzxke.kvm3u8zw4532@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/2/24 05:25, Manos Pitsidianakis wrote:
> On Mon, 01 Jul 2024 21:54, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> The ctor is not run, but, interesting point, there is the same problem
>> on Linux :)
>>
>> Can you please confirm with a clean build this work on your machine with
>> this v3, and report exact configure and run commands you use?
> 
> On a clean checkout, I did exactly the following:
> 
> ```
> mkdir ./build && cd ./build
> ../configure --enable-system --enable-debug \
>   --target-list=aarch64-softmmu --enable-with-rust
> ninja qemu-system-aarch64
> ```
> 

Debug flag was the difference.
After looking with Manos, we identified an issue with release builds 
(unused symbols gets dropped, including device ctor), that will be 
solved in v4.

> which selected the default cc/gcc on debian,
> gcc (Debian 12.2.0-14) 12.2.0
> 
> and ran QEMU with like this:
> 
> ```
> ./qemu-system-aarch64 -M virt \
>    -machine virtualization=true -machine virt,gic-version=3 \
>    -cpu max,pauth-impdef=on -smp 2 -m 4096 \
>    [.. drive and img arguments ..] \
>    -nographic
> ```
> 
> 
>>
>> Thanks,
>> Pierrick
>>
>> On 6/29/24 01:06, Manos Pitsidianakis wrote:
>>> On Fri, 28 Jun 2024 22:12, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>>> I've been able to build rust device on windows, with a few tweaks
>>>> needed.
>>>>
>>>> - specificy the target for libclang (used by bindgen), which targets
>>>> MSVC by default (so different set of headers)
>>>> - additional headers (libclang searches its own header with a relative
>>>> path instead of absolute)
>>>> - additional windows libs that must be linked in final executable
>>>>
>>>> However, even tough I can build the executable, I get this error:
>>>> $ ./build/qemu-system-aarch64 -M virt
>>>> C:\w\qemu\build\qemu-system-aarch64.exe: unknown type 'x-pl011-rust'
>>>>
>>>> Any idea of what could be missing here?
>>>
>>> Sounds like either the rust lib is not linked to the final binary (which
>>> you can confirm if you look at the included symbols and don't see
>>> anything with rust origin) or the constructor decorated with
>>> #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU"] is not
>>> linked properly (you can add a puts() and see if it's invoked or add a
>>> breakpoint in gdb)

