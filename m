Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65944606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xyzxkak9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU635-0002gI-8J; Thu, 19 Nov 2026 12:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU631-0002fx-PB
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:35:47 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU630-0006c1-2g
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:35:47 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so8205a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795109743; x=1795714543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WSCFoWDi5YcWCqSGNxSODHykMjMIcgaD0oYjyztbjUY=;
 b=Xyzxkak9t3w0g2wMuN66c9k6dL9aMqZEV/Ol77/hGiSD8Aw4Y0RwptTNuQrVAkbhWJ
 vzrgoA18YUpHGtaI/NpEkUmxh8CLvDE4EO73yLwJobRSl0zi0bIhMTRxbNJKJvlU8+pi
 1WQZSsjZAbOW43VzGBgrjHjIbfOHnESJs06ICx2dB7WRVMeyk3rjLmWzUZdcvXs5VP7W
 61GtQ3rhbN3XPn1dY6mEFRTTnWgR/yulSh+mf6Bux7lc5jjasd2Lm+M4MVQ9+gIFjDI6
 AbiLdLflqvcLNV4O0tA2c5zmQUcU/ZgP2LW7KH13wTDCJtyu8XOI84PjIBs3ZAJoN7M9
 Z1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795109743; x=1795714543;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WSCFoWDi5YcWCqSGNxSODHykMjMIcgaD0oYjyztbjUY=;
 b=yvgfHFtmRBjW8Lw2mYNTke8WfBK0u41a3MpAh1V0LShTkNh2NL/5fTZOnQ8azlXLNU
 eKPKlcrSRDLJpIum6XMPIrmIflap0FcyALOEeTRb/ESPYR7kaj0Gnne8FdwJBpuTpOS3
 SUDS+Fv4OZ8cXhlFYwd/ixewxlshCFZr+T+wj06oSrEvIvNSLAmoLTT5i5eX1XlaUmXe
 rlQ8s3nUPFC7eoLi7GAgn50udQNW9LTKzs8CiY1oMLDaUR3WGppNdrPNsrKFSnKF13dm
 GDEUmcyvnEPmeitB+o3gbXj6tjEYKaLmuOnLiq1twL9auPi+5fywpq/cQgiser4niHZW
 LGHg==
X-Gm-Message-State: APuU4Z/miOCbT3EIt+52Rm2+JjfuHpglGEOzHI0LA1ZEznSma+peultu
 jrn72xNsN/eMQCsSqssTh/Jo7BSNLQ1t4TsPhePx9e2sXdByM6r7+wOUNOS3ZLUI26w=
X-Gm-Gg: AZFdTZdDmso4uLOwLSwX0HZgko5ryWBCd809sm77PT4mFTl0IGoZeGM9m/Egbolsvcs
 Vuo9mnU0M7FbJF6aVRAlTcU+X9OWslC3k4h+rLndlml6Dt5BznBOAvG98+1njxi/0tc9z/zqD8c
 5qvZ12CuPOqJmU88PSykyB3s0R/EAidg6oZrpr1yQC4BxF7dUpXRLimQaL0MJSlH2i4hWpx1qr/
 mQaF4zM9Ltgcxs3MCIV6vG4wgH9w2VX2UZUXJmsRQv1EtwIs+QkFazP+FPRTkNf9Wqg7ItK3huF
 +Ma90jLeAbm/qMgaA7IXZKvaOvOn/ZVCawK5fNEXGEYk216GLWncrwtdn8spKukppGm5ufiOIqY
 gUk04j4X8w6Acw6kzBIlXxMfIcY5lKkY+s1kI0YZjDvyMEAnMNN/UaCMoIZhbfwf6V8/dBKLHfx
 9bUCFLmj6LVOSL8JfG3Cr5p92jyzrZp7VfMmkbb7gkVi98x2rkKf28Mti2f50m6mQ8H7hzPTW3t
 2tE5ZwWbxRaao5XKMiF3u5KlqzLhaPu2f3xHAl7S4zcKE16cP5iNTX3OlxkxkjvUbLatfDvTLAE
 qnzsQIqhhd4BG7YVdP80gF0LAYH5O4RgT2Uwc7fLNu5GUuE3TSQVHzbesID4bt7IN5vsn6RfAbK
 bepjyojTphcqWiSPJ
X-Received: by 2002:a17:90b:2701:b0:3aa:fdad:7d6e with SMTP id
 98e67ed59e1d1-3b41c8d9224mr77475a91.10.1795109742711; 
 Thu, 19 Nov 2026 09:35:42 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ecbd0bsm3410958a91.15.2026.11.19.09.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 09:35:42 -0800 (PST)
Message-ID: <e9797996-ab93-466f-8404-0733e7dcf781@linaro.org>
Date: Thu, 19 Nov 2026 09:35:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/15] target/i386/tcg: reject VEX encodings of PBLENDVB,
 BLENDVPS and BLENDVPD
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20261117133750.322253-1-pbonzini@redhat.com>
 <20261117133750.322253-3-pbonzini@redhat.com>
 <CAFEAcA9YRZTkdjhOm9M6kW_E8HayQONUNEFWdVg=t7k6Ow273g@mail.gmail.com>
 <CAFEAcA-9Z5bXAedSmRBHOonR3rXjHhzTLtt3HNBws4OkiFCyYg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-9Z5bXAedSmRBHOonR3rXjHhzTLtt3HNBws4OkiFCyYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 04:30, Peter Maydell wrote:
> On Thu, 19 Nov 2026 at 12:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 17 Nov 2026 at 13:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> The opcodes 66 0F 38 10, 14 and 15 (PBLENDVB, BLENDVPS and BLENDVPD) have
>>> vex_class 4, which allows both the legacy and the VEX encoding, so
>>> VEX.66.0F38 10, 14 and 15 were decoded as the same instructions.  The VEX
>>> forms of these instructions are VPBLENDVB, VBLENDVPS and VBLENDVPD, which
>>> have four operands and are in map 0F 3A, so the VEX opcodes in map 0F 38
>>> should raise #UD.
>>>
>>> Keep vex_class 4, which provides the legacy SSE checks, and add a new
>>> vex_special that raises #UD if the VEX or EVEX prefix is present.  This
>>> is borderline disgusting, but an effective solution to x86's opcode sprawl
>>> will have to wait for a new AI policy...
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Hi; this test case fails "make check" if built with clang.
>>
>> Configure flags:
>>    '--cc=clang' '--cxx=clang++'
>> '--target-list=x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user'
>> '--enable-debug'
> 
> ...and in fact it breaks with gcc too:
> 
> /home/pm215/qemu/tests/tcg/../docker/docker.py --command podman run
> --run-as-current-user -- --security-opt label=disable --platform
> linux/amd64 -w /home/pm215/qemu/build/x86 -v
> /home/pm215/qemu/build/x86:/home/pm215/qemu/build/x86 -v
> /home/pm215/qemu:/home/pm215/qemu qemu/debian-i686-cross
> i686-linux-gnu-gcc ../../tests/tcg/i386/test-i386-blendv.c -o
> tests/tcg/i386-linux-user-test-i386-blendv.test -static -MMD -MF
> tests/tcg/i386-linux-user-test-i386-blendv.d -Wall -Werror -O0 -g
> -fno-strict-aliasing -fno-stack-protector
> ../../tests/tcg/i386/test-i386-blendv.c: In function ‘main’:
> ../../tests/tcg/i386/test-i386-blendv.c:20:22: error: the register
> ‘xmm1’ cannot be clobbered in ‘asm’ for the current target
>     20 | #define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, "
> #op ", 0xc9" \
>        |                      ^~~
> ../../tests/tcg/i386/test-i386-blendv.c:43:5: note: in expansion of
> macro ‘SSE_INSN’
>     43 |     SSE_INSN(0x10);
>        |     ^~~~~~~~
> ../../tests/tcg/i386/test-i386-blendv.c:20:22: error: the register
> ‘xmm1’ cannot be clobbered in ‘asm’ for the current target
>     20 | #define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, "
> #op ", 0xc9" \
>        |                      ^~~
> ../../tests/tcg/i386/test-i386-blendv.c:44:5: note: in expansion of
> macro ‘SSE_INSN’
>     44 |     SSE_INSN(0x14);
>        |     ^~~~~~~~
> ../../tests/tcg/i386/test-i386-blendv.c:20:22: error: the register
> ‘xmm1’ cannot be clobbered in ‘asm’ for the current target
>     20 | #define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, "
> #op ", 0xc9" \
>        |                      ^~~
> ../../tests/tcg/i386/test-i386-blendv.c:45:5: note: in expansion of
> macro ‘SSE_INSN’
>     45 |     SSE_INSN(0x15);
>        |     ^~~~~~~~
> 
> I'm not sure how this made it through CI, maybe it's a compiler
> version related thing?
Plus or minus version, I expect it's how the compiler is configured, 
whether sse is enabled by default for i686.  We just need to add -msse 
to cflags to ensure it.


r~

