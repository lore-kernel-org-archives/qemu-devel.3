Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE6EFC618A
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 20:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc8Oy-0006eq-Bq; Sat, 03 Jan 2026 15:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vc8Ox-0006ee-1C
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 15:39:07 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vc8Ov-00082f-71
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 15:39:06 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34c3cb504efso14681749a91.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767472743; x=1768077543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lcLy0QVB9X5U+3xZHqE5lwh0JlcGjbR2eR574+j4m8E=;
 b=jxBjl+GKifI5Cr6S6GcBXoKuAVwFBDjZrvXXBYfMaGGD2axc0lg/J77b3Hq3STsBxQ
 d3gTpSUgftA+pnH8I5nFOIkKIa+200K6vrisKsjx1d124UAHeRZI8+4zHnqtngXvGkVd
 P2aQzl6tBJpcx+Ry8X5lJsTJRJ+mBSKmnkks1pL/gzwBqw+NMMrXhigae/7Rv8rbLPpw
 l+parkLWYCHDG/8uB3UQMQ+aDZzhZ6bMRRWEj7gyVrRf1DymToRNnUafNReLO/kRiFPX
 vFlPiLd38Q4c8jYQuMqBCR5mEGvsS7xvR6LeXi4wHhIfB2CZTCaPUx/ItSsADHohDKv2
 kwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767472743; x=1768077543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcLy0QVB9X5U+3xZHqE5lwh0JlcGjbR2eR574+j4m8E=;
 b=wr7tUROies3VgNWeV5C1WTXaRIZyRQA0UDb9ilddyMtSJlqWhycyJb61/fbcj3UBTS
 6HqY5pY1DtqCeRYJX8mt25LAjhW7djv9CVfFxrwsks4SNww4S1r1N3G2+r5GwdsLPgKU
 9ca3PEDBi5+JIGjTAcldBBAGdn1ABME0pCltkBW7jxbhkzu4tVEk7PHf3qxAwVKYEGxM
 SkzHITtc7YKMIq5SE72bPPEmK1T7e1bl45CldtmAcYwwbxt6cSWxQmZYYOZPyYZJB+vh
 qSfjVxPBLVkUd7IRWpbRRW0B0YL7xtX0Fa9SWpf+HM50iEB7rE4vORbWx9RqjU0cuN9T
 h6Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPls6Vm6N+yXJ/+XQbLrcQ7vItXHAIckaiRWuq+3Sebo3icm5Ayeb3sZaMfoMpdbtcn1LmI69+XXvJ@nongnu.org
X-Gm-Message-State: AOJu0Yx4hR2//y+xNGZiP+rU/Hz1JcoB4uu42IU4Z2LYm5J6X5O6vdg9
 WJ6aTgNDPSmdFvkDN2838GEVPLeFxXjaxQ80SLNIY8a8/KNcc6ZBlhMv0iUL1fkLa9U=
X-Gm-Gg: AY/fxX4ivP6zfvPvgb7D8EcbYwtQlaqh1jgOVa1j8JfuDyisqJm6yPuIrnkwc2zY+Km
 4FdQKxwJz4qcuVOlkGzReKJN0PTn9dQL8BGx2Qrx6lfUnnuMavPNpVu9NSGgw42TaFSwx61XJkH
 X9jEbEGNMpoj7mlBuYbRjuIXsFL9ScV0ueFPcRpjZUxiFUoRn/8FYUoA1Qe85Cx+5aJ/JIMev2h
 DV67GzPvmSpz0B2tmnXvuaHYGxAGGabaQeIx3PZIr96OSKLmbJPgMm+cANZad4OmWfsIsTHWjSm
 wAo4LXGIGWyxqXGwysonfxte0zEjswOMm7y7Lblg/bN+9Tqmhbp95oMEHCaQdljISsR1p7Hvl6U
 wZUzKqq+53enpojOVCE5QzOwsbLwFCuQiUbDTn5FRdM8niWGxng2UQKzs1mZs3mkmwyvRLMiMee
 QazyD+a2o3+O5t6P2POFkK6+Coi4BPLna9qHGEsRcUXMOt00NIzHiDYXJaHwEilCjaPlc=
X-Google-Smtp-Source: AGHT+IE8moFWrEPbiyo4QjNXNkUmzvoQvAxeFfEBKif9bEkSXOs7VycSzTprKpSEDrqXJB88DiYhBQ==
X-Received: by 2002:a17:90b:2e8e:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-34e921b0623mr38379336a91.18.1767472743125; 
 Sat, 03 Jan 2026 12:39:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476fb86dsm2424852a91.8.2026.01.03.12.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jan 2026 12:39:02 -0800 (PST)
Message-ID: <c17de286-f432-426b-b181-06cd7a8edc55@linaro.org>
Date: Sat, 3 Jan 2026 12:39:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] meson: fix supported compiler arguments in other
 languages than C
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2EBerrang_=C3=A9?=
 <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-8-pierrick.bouvier@linaro.org>
 <t8ahil.2ih2pjydhjsas@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t8ahil.2ih2pjydhjsas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 1/3/26 4:54 AM, Manos Pitsidianakis wrote:
> On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> qemu_common_flags are only checked for c compiler, even though they
>> are applied to c++ and objc. This is a problem when C compiler is gcc,
>> and C++ compiler is clang, creating a possible mismatch.
>>
>> One concrete example is option -fzero-call-used-regs=used-gpr with
>> ubuntu2204 container, which is supported by gcc, but not by clang, thus
>> leading to a failure when compiling a C++ TCG plugin.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> meson.build | 17 +++++++++--------
>> 1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index a8fd8e88225..256cc0cdb21 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -709,10 +709,7 @@ if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }'
>>      hardening_flags += '-fzero-call-used-regs=used-gpr'
>> endif
>>
>> -qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>> -
>> -add_global_arguments(qemu_common_flags, native: false, language: all_languages)
>> -add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
>> +qemu_common_flags += hardening_flags
>>
>> # Collect warning flags we want to set, sorted alphabetically
>> warn_flags = [
>> @@ -771,15 +768,19 @@ if 'cpp' in all_languages
>>    qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
>> endif
>>
>> -add_project_arguments(qemu_cflags, native: false, language: 'c')
>> -add_project_arguments(cc.get_supported_arguments(warn_flags), native: false, language: 'c')
>> +add_project_arguments(cc.get_supported_arguments(qemu_common_flags + qemu_cflags + warn_flags),
>> +                      native: false, language: 'c')
>> +add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
>> +
>> if 'cpp' in all_languages
>> -  add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
>> +  add_project_arguments(cxx.get_supported_arguments(qemu_common_flags + qemu_cxxflags),
>> +                        native: false, language: 'cpp')
> 
> This is a subtle behavior change (qemu_cxxflags wasn't filtered through
> cxx.get_supported_arguments previously). Do we care about this?
>

Sames goes for qemu_c_flags that we now filter also and we applied 
directly before. The goal is to have the same code layout in meson.build 
between the three languages for code clarity.
My argument for this and qemu_cxxflags is that it should be equivalent, 
and if it's not, it should have been raised previously with an 
unsupported argument warning at compile time anyway.

By curiousity, looking at meson source, has_argument is implemented by 
compiling a file with the given flag, which is equivalent to what we do 
manually. It has different implementations per language: grep 
has_multi_arguments.

Thanks,
Pierrick

