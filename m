Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD00C982F2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgovy-0007FP-Pj; Fri, 16 Jan 2026 13:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgovp-0007DZ-CL
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:52:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgovn-0007nA-GQ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:52:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so14649665ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768589541; x=1769194341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TQ9sYXJpVM0m5cRMZC5iT5ums+TipzIV62ulhv96AWc=;
 b=mu1Pm3d82d+EREZbTRB1A5YQ3TCMZE8Wp4jlvNbntKh9rpu6QHxsNfdihEwLpJ6Ff9
 OjM0p2VvCtLr8GyOS3BZHBlfISmdx4fCRrtzwuJCG/gBGsAjf/BS/cU6HHKUT9EjZMnf
 alGLrm0YYnHpPcwgNogxwx93iU0iM+JVRPa+jiq4O8BexIXwY35UEkdeL+q+9edl6eRB
 HdeY7Fck6lel1d0zG3O5LvjVi2S1CjXRnKfmbH9WhyCCsPtMQTPehGYJibzEv5WtI9ik
 ruLZ5iddZGjZT7NOfbGBj+jswhshmAgFIJoVPqQ1tTRoSNwL7oMJSeUlhugho+97Mgky
 NIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768589541; x=1769194341;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQ9sYXJpVM0m5cRMZC5iT5ums+TipzIV62ulhv96AWc=;
 b=THNsBNVTiNbLpV/iDyMtcUI9H3eDgVXK2s+SBRp1bhwkgaUnWmLbb9FBX3B0cuEInc
 d8UB1kvCtoVCSzwNtwkZuCJher9dZ0FnbMRqVTX/0VL3UnceOtHV9rOnD8aWR9B8Uq/i
 1o2tH9JW9AmTRlw5gDW2YobEl48S3I2BhTZDM9EHCRDwXM/aDfQCuAQ5yCwxYh6ZAZcz
 jMM7rZt/2oetL1jCoucnsBPSPBf4N3dL0XZU16pTBPBIn0pWO7R8e4kGbQJUM/3vvfsA
 pqjAI9ICibEWqv9LjY60yo0YoHPeqZp7LXQ3rSD8P2we4dawKmvnMkT5RsBgocJWlUjg
 zKUw==
X-Gm-Message-State: AOJu0YxKGFP7TfxuhqSdNLOJ1ZBfeTCBa57qsrTE4qfumSBWDLQkEO2g
 FsF4MgcT0jA2dTh0e4UwGvWqRsx5QzfLriqBLDVOcwadhuDajbMsUTiigqQSzi/Ihu4=
X-Gm-Gg: AY/fxX596KnBt6BiHvA5AJ228NQfedhruT/eLU3BpX2G27NmzJWxRDawu+eI08xBDd2
 oCIpcpzHHvUWJBsSHHy13kfMVk2oYoX0ggP0FIahLe2/QHTNaR4BU3WSNOx0n97/mKqyjT0FhVS
 B3stwCNcyVaD1OSeFqvTVkK9uHFatdmqPnUJXLLAx3sw4VJxp6HXX8AgBPfZJPwdlU8SChRAkvE
 eBXmniB4JDl8JXcuP48kMN8ssUsOmc7nJYrknylaOBuqpFOD4WGXtGHvXlKC8HjaXu/+D7EmR4T
 BGBHYWYyHHArNK1gr+uiCsDS7EUOcQIOfj7dwDX9Zpc5L70uEHT9ns8YY0/TzYRN6U+76zFCYNU
 bbl+tym6CDGU0Y/Po1nWi1xMmazMDd0JwO4UKw2vyh+Xpi1ieY7FBwa/iVSQz7bhiNMHSbdbWLr
 c1l4HGh7LhDy49lOW7H4czKvZiW54vKVUNHUIvPWAxKPQp8xmOO1knnisv
X-Received: by 2002:a17:903:1105:b0:2a1:3ee7:cc7a with SMTP id
 d9443c01a7336-2a7188896ddmr37414595ad.17.1768589541051; 
 Fri, 16 Jan 2026 10:52:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eee39sm27162045ad.45.2026.01.16.10.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:52:20 -0800 (PST)
Message-ID: <2fec97c2-a48b-4b12-b591-f4b876709f47@linaro.org>
Date: Fri, 16 Jan 2026 10:52:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] plugins: enable C++ plugins
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <aWownlTDHCx10w9I@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <aWownlTDHCx10w9I@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/16/26 4:35 AM, Daniel P. Berrangé wrote:
> On Fri, Jan 02, 2026 at 01:47:13PM -0800, Pierrick Bouvier wrote:
>> Writing plugins in C can be sometimes tedious, especially when using Glib to
>> keep track of execution state. We can directly use the same C API but write our
>> plugin in C++, benefiting from its great standard library offering strings,
>> smart pointers, data structures and synchronization mechanisms.
>>
>> It's common for downstream QEMU forks to provide C++ for plugins, like this:
>> - https://github.com/panda-re/panda/tree/dev/panda/plugins
>> - https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin
>>
>> Hopefully this will help more people to use upstream QEMU, and as a benefit, get
>> their contribution back and help to develop plugins ecosystem upstream directly.
>>
>> This series first cleans up build system for plugins, factorizing details
>> between contrib/plugins and tests/tcg/plugins folders.
>> Then, we perform codebase cleanups to fix conflicts between existing headers
>> and C++ headers.
>> After that, we can update the C++ standard used by QEMU, to benefit fully
>> from latest updates of the language.
>> Finally, we define an empty C++ plugin, making sure we can keep track of
>> possible regression in qemu-plugin header.
>>
>> Note: This series is *not* a trojan horse to bring C++ in QEMU
>> codebase, nor to define an alternative C++ API for plugins. It's just enabling
>> more users to get the most out of existing C plugin API.
> 
> That's somewhat misleading, because as the diffstat below shows,
> this is indeed bringing new C++ source files into QEMU:
> 
>     contrib/plugins/cpp.cpp                     | 119 ++++++++++++++++++++
> 
> and the description above talks about bringing more C++ plugins in
> from external forks, and the meson.build files are modified to
> deal with C++.
>

I personally would not mind having other C++ plugins, as it would invite 
people who contribute to downstream forks to contribute to upstream QEMU 
instead, which may include new useful API also!
Those files will be conditioned by the presence of a C++ compiler, so 
there is no impact for the people who don't want to deal with it, nor 
build it.

It does not open any door to introduce C++ anywhere else.

> We've had a handful of C++ files historically we've worked to
> reduce, with the eventual goal of not using a C++ toolchain for
> any part of QEMU build. Given that IMHO qemu.git should not be
> adding new C++ sources files, even if in the plugins dir.
>

The series does not force having a C++ compiler installed, the plugin 
compilation is entirely optional, so no change for existing users or CI 
images.
With that, we still need to have at least one C++ file in to test if it 
works. In case there is nothing checked in, there will be regression.
We are luckily catching things in CI because clang++ is there in some 
images, so it will trigger an error as expected if something is introduced.

Most of the QEMU downstream forks have C++ plugins, because it's just 
way more convenient.

> Since the qemu-plugin.h file should be entirely self-contained,
> do we actually need to be bundling all the plugins into qemu.git ?
> 
> Should we in fact have a sepate gitlab.com/qemu/qemu-plugins repository
> where we keep plugins ?
>

2 years ago, contrib/plugins were simply sitting in their directory 
without being built. As a result, they were broken when I tried to 
compile them. So we added them as part of a normal build, and it solved 
our problems.

Pushing things in another repository is exactly the opposite of that 
direction.

It's not because you personally don't like or use a feature that it 
should be in its own repository. Please kindly consider that other 
people have different needs or opinions than you.

> Since the qemu-plugin.h file is defining a somewhat stable API, plugins
> in that separate repo ought to be able to build against multiple QEMU
> releases, and could thus benefit from not being bundled together and
> don't need to be on the same release cycle.
>

API is versioned but not officially stable. We may have breaking 
changes, like renaming/removal of existing functions.

> The main qemu.git CI jobs could trigger testing of a separate
> qemu-plugins.git repo, so we still validate no regressions.
>

I'm not sure what is the point of breaking down things to tie them in 
CI. What will happen when there is a breaking change? You now have two 
broken repositories instead of a single one to fix.

> With regards,
> Daniel

