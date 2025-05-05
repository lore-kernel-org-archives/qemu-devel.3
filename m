Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DEC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0Hg-00015v-Pa; Mon, 05 May 2025 14:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0He-000140-6e
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:11:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0Hb-0002zG-TK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:11:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so6277066b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746468674; x=1747073474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfztoF2VnhkyuJaePtA7NnBRNglZfaYZPRZdgFK8AKk=;
 b=RcEPCENj1bgi1eRGP103aeD1yrefaSbNN6AmE4OnmSNgfyry7JTqLVQOLx9Y0PH3p5
 OaRXHU9OmYDr2uUd6/RGyejrDT0IykCbfZLdVO4ztpC5O+67l83YmtzpXlS0nPo2ZuKT
 CeQnKr2kWZ+HFKMS28BL4WHlJNyoVFgjmJoeyE+dVvhp/1RiDl1IUYPRkX+rkl3ONRL+
 c547UubHhT9ZBUQT7TfbJVa2yySiwm/JTg9GY1kC12lHdkihjwHaPwVoqZKroR3PAfMt
 CEFFfXIAUYeW4wDuVsDg2WZMAfYJhzEg6Pp35sbpa3UPK3jlQV0SFvUFESEONu2+ByNW
 UFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746468674; x=1747073474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfztoF2VnhkyuJaePtA7NnBRNglZfaYZPRZdgFK8AKk=;
 b=aY0oJheBehkT/NeVQx5XqWAhEigpQmuIyjXo1X/SsOh1Ebv3FJ9cvI7fEDK/K5c1YY
 7x/1ny0mjeKzs6s5/1DxXmsWQXkQzLTUv29qqymr+ORQ/AgoVQdK4ilIi43FL694KQPu
 DXXwpxNZ4g68AA0CSPLVANAO1vrUXwJWVidI8tpi8myvmEpZA53RYXzmqbTxa1JIMxoN
 n2rEMqW8+Au3J1jv5F7ITvfz6IoRox4saBAN6w+QSgk3P3s55qtawjvGfBiYXGfNRTHx
 C7xMV5ROaYYs6/rqfQewctmqZwTOyYD1upIj474N616ftv2dC+Xjg3jSWOhsS/PmxM79
 a+VA==
X-Gm-Message-State: AOJu0YxKjHK3saruriiEpvLGfHY9P8GzhYVKUQScO+mB07XVfLrSP4Xn
 7SW2mYwdwcKLS+8g4qyZsSrYF8L9NaPmi5aEoMByN+fG2fTmDgHcoa4bVg+XkZA=
X-Gm-Gg: ASbGncuAqCAQpW9h7FrDevi1f0jBvGDuTVpHaqwTA8A6R1r7hAR/WZoBLd/U6o2Kw+v
 NMTlXCWq2dt17GAclXRumBopSRORp9g5BXbuupwRLYRcEyfQ8YaSbQsiX5l5NWMooXdkw781Bfs
 vc6aBiXqIEgR2Iix73JZoQoiMza4FmSDpltAJJPMg+m52nq5ifyKT5vuLkBzC7Su4q7/X5RiMZR
 lXT6h+xGl/px1FiN6ds9RrwwhmJlUHqMkqubLhnkiAs+24YTnRT0zf/5cyzqWZgk3K3H+pR4uKP
 iQEf0owUi9snOWV0i6AeMaL5bfxBCPtXdmRu3Q/Bg1vNkONbTcOvjQ==
X-Google-Smtp-Source: AGHT+IH0FkaCLqIg/UeYitjYpCumBAGVrtwjF9Sq8wX3I4CF/OqAF5BBdUaW6FS7SoZiHdF6wUtAxg==
X-Received: by 2002:a05:6a00:2985:b0:73e:235a:1fca with SMTP id
 d2e1a72fcca58-74091ac9646mr154988b3a.20.1746468674028; 
 Mon, 05 May 2025 11:11:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dc45c7sm7139520b3a.71.2025.05.05.11.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:11:13 -0700 (PDT)
Message-ID: <5bddac39-119b-45e1-80da-ed4a9789b937@linaro.org>
Date: Mon, 5 May 2025 11:11:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, wei.liu@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
 <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
 <674de496-b0fb-486b-b74e-f4f856e6d9bc@redhat.com>
 <120a2e48-ded8-400c-bfd5-83b47c8c17fd@linaro.org>
 <CABgObfaNoytDo5RZwoP3r14DHuVvjmscyH72QfvaWjfOn5E4Xw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfaNoytDo5RZwoP3r14DHuVvjmscyH72QfvaWjfOn5E4Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/5/25 5:59 AM, Paolo Bonzini wrote:
> On Mon, May 5, 2025 at 12:54 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>> I don't think target_long/target_ulong is a big blocker towards single-
>>> binary anyway.  The trick is to confine it to target/, making it
>>> essentially a #define.  That is, let target/* include one of two new
>>> headers target_long_32.h and target_long_64.h.  See lore.kernel.org/
>>> r/68b6c799-6407-43cc-aebc-a0ef6b8b64fa@redhat.com as well.
>>

In an ideal world, it should be eliminated completely.
The root problem is that it creates variation of symbols/types, which 
obviously can't be unified later when we mix targets together.
Of course, it's a paradigm shift, as QEMU traditionally was written with 
the "per target" approach in mind.

 From this perspective, the only place where it could eventually survive 
is within static functions or types private to a compilation unit, only 
if this compilation unit is private to a unique target architecture 
(TARGET_AARCH64 only for instance).

But in this case, it's much more easy to get rid of it and replace with 
it the real type directly. So I don't see any good reason to keep it 
anywhere.

Our solution here is to "widen" the concerned definitions, using vaddr 
or uint64_t for target_ulong (vaddr is possible only for addresses, 
because we removed 64 bits guests support on 32 bits hosts - I hope it 
won't bite us later).
For target_long, it's more tricky, as sign extension matters.

The problem is that it will necessarily break some stable interfaces, 
which were expecting a uint32_t before, but I think it's a necessary 
change to do at some point. But it can be done slowly and on a per 
target basis.

>> Yes, I have this tagged to understand and address. Maybe Pierrick
>> already understood the issue (similar mention from Richard? [1]) and
>> is addressing it, see [2].
> 
> Those are different.  TCGv_vaddr is able to store a *host* pointer,
> i.e.  a host uintptr_t.  But target_long/target_ulong are already
> completely absent from tcg/ (there are a couple appearances in
> include/tcg), so I'm proposing to remove them completely and leave
> them as just macros.
>

 From what I understood, the original meaning is that vaddr can contain 
a *guest* pointer, and not a *host* pointer. Since 64 bits targets have 
been disabled for 32 bits hosts, vaddr definition was changed to 
uintptr_t, where it was uint64_t before. [1]

[1] 
https://gitlab.com/qemu-project/qemu/-/commit/a70af12addd9060fdf8f3dbd42b42e3072c3914f

> Please give me a shout once the target-arm/ series lands, I can look
> into this further.
> 

The current series is mostly complete, and focused on low hanging 
fruits. The one remaining are a bit harder, and/or have external 
dependencies, but I didn't see anything impossible so far.

Luckily, we didn't have a lot of target_ulong in Arm related structs, so 
it's pretty easy to change. Some other architectures (especially the 
ones using them in cpu.h) will be harder.

> Paolo
> 


