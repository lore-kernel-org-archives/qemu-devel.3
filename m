Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2720DC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBtTC-0003Ur-71; Mon, 05 May 2025 06:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBtTB-0003US-8N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:54:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBtT8-00054M-LP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:54:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso4560971f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746442480; x=1747047280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fDTmDpr9wsfr2DsXcfcdgh+NFkCc2nPLFPfHLFy4oBw=;
 b=Ke2Uc2apS00Vii2BrcCD5brM/tRqNnNlrmE2tHun/547mDJZHLg6VomPTshes3d07W
 ClEj3TrzOezu9IJjSRwEUfbsv1W3RNOc5PEevK+SzoX/irnwccbPSA8viEG3UoU231zX
 Ntlc9ZiAmmoZf+LDbzVmriTyY5/EU5htEp1cyF1NpkkEAojwhghH9x8+rh0ykxSevbe5
 a3ozl7EcVDjctZhvhQES3gbR8sPHzPIgnVHIUzMB8xCzMoeKDZdD48CUE9HJ2DpOh4sV
 tWzGWUZt3rEvA9jvMH8MNECqEQdeztnJVpzilOyhQJ3b+3pnVqJhUSyONZRry2TwN3J/
 zfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746442480; x=1747047280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fDTmDpr9wsfr2DsXcfcdgh+NFkCc2nPLFPfHLFy4oBw=;
 b=kGapqRaZHP9+ZuqXLzBpoAC9Z3EwdVvEIoiYiCBFKPXPygCJNd7F8MIJ3Lj20u4lCG
 h0ByI0l1HAJZNGqOy3xK2mbFbcsw0TOpdhZxjowiACJwQa4c8qchmJ46K2P0SlIxQtXa
 LZj4hemEPJSFyemEo8Iv5e60Oejs65f5YukUezE8clCyWuc3p1iafm86ga22M4TB//xM
 Qa3qFFlP9IpJj2xTBoO5PAg0D1/609Lmk9Y0XOFNcixoW9E3RNB2FWz9xbyXbrMcwoSc
 AoTIbHrAkghveiTDKP7iDBEUC3coDaxIE9SbkdrRuj8AxoGSu5CTyXo8OaxXl2bH11EZ
 8Xpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgN6Vx85qw0sVWMaPR9RspVO6AuwQFi+bIGD1kDOPjcT6mGP6KfGiuggDzmeN7PQi32XZ3acEi5MfB@nongnu.org
X-Gm-Message-State: AOJu0Yy00FoJDqodOobE7pN/I0LfCuuQrgw4jKAosRRrIJu8bkU4Wvan
 fFQeVn1Hm68/iXHn7jsKxf3jtsgh8itaGDWX8/kDPAdqRUMz7M21HW+Tmg+EA3I=
X-Gm-Gg: ASbGncsD7yiV+Br+cd84gfOwXU20/TMDjPtV03h5v23gT8tEctPdWLkT/qAEbqZqjMV
 /AHbCXkw8HB1uVxUQKpAGvMIQVMonTv+I4msyKaQQ0sox1Ci1SyGsLMRlA1inIDzzGrx09+yjDf
 4M96X6atXvbvA9PQDHfsPoYN2vv03HFFkR92u32nk5WXb4nOGuuANTzmXyqMipUFalhwbQS+jQ5
 8RGMh8AehvMTe1KolaCBpYJxLM+I21XMJd69GvK+TOaeST2UuYWyZzKgtt5EOrnxoVefUmWN+R0
 /AKIFqC/K7ssRQ1uYv5GaCiwPTtpKEJ4OhjHSs3ctD+dOGtplC2d6PwfOlU4ZiiWDY1dxF+fZ34
 =
X-Google-Smtp-Source: AGHT+IH82oiwNjPbSIGWey94NW6Y6VCYMXKC+cbRmdaBcULkw3kMqHKtZQbV6RnBta06/3jeydqjdg==
X-Received: by 2002:a5d:5f84:0:b0:3a0:7aa3:cc74 with SMTP id
 ffacd0b85a97d-3a09cea68a5mr6090661f8f.6.1746442480365; 
 Mon, 05 May 2025 03:54:40 -0700 (PDT)
Received: from [10.194.152.213] (71.86.95.79.rev.sfr.net. [79.95.86.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3b57sm10252659f8f.36.2025.05.05.03.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:54:39 -0700 (PDT)
Message-ID: <120a2e48-ded8-400c-bfd5-83b47c8c17fd@linaro.org>
Date: Mon, 5 May 2025 12:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
 <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
 <674de496-b0fb-486b-b74e-f4f856e6d9bc@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <674de496-b0fb-486b-b74e-f4f856e6d9bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 5/5/25 12:00, Paolo Bonzini wrote:
> On 5/5/25 11:43, Philippe Mathieu-Daudé wrote:
>> Hi Paolo,
>>
>> On 2/5/25 23:48, Paolo Bonzini wrote:
>>> decode->op[N].ptr can contain either a host pointer (!) in CPUState
>>> or a guest virtual address.  Pass the whole struct to read_val_ext
>>> and write_val_ext, so that it can decide the contents based on the
>>> operand type.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   target/i386/emulate/x86_decode.h |   9 ++-
>>>   target/i386/emulate/x86_emu.h    |   8 +--
>>>   target/i386/emulate/x86_decode.c |  74 +++++++++----------
>>>   target/i386/emulate/x86_emu.c    | 119 ++++++++++++++++---------------
>>>   4 files changed, 109 insertions(+), 101 deletions(-)
>>>
>>> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/ 
>>> x86_decode.h
>>> index 87cc728598d..497cbdef9c7 100644
>>> --- a/target/i386/emulate/x86_decode.h
>>> +++ b/target/i386/emulate/x86_decode.h
>>> @@ -266,7 +266,10 @@ typedef struct x86_decode_op {
>>>       int reg;
>>>       target_ulong val;
>>> -    target_ulong ptr;
>>> +    union {
>>> +        target_ulong addr;
>>
>> Prefer 'vaddr' type for "guest virtual address".
> That would be a semantic change which I really want to avoid in this 
> series.
> 
> I don't think target_long/target_ulong is a big blocker towards single- 
> binary anyway.  The trick is to confine it to target/, making it 
> essentially a #define.  That is, let target/* include one of two new 
> headers target_long_32.h and target_long_64.h.  See lore.kernel.org/ 
> r/68b6c799-6407-43cc-aebc-a0ef6b8b64fa@redhat.com as well.

Yes, I have this tagged to understand and address. Maybe Pierrick
already understood the issue (similar mention from Richard? [1]) and
is addressing it, see [2].

[1] 
https://lore.kernel.org/qemu-devel/5b152664-a752-4be8-aa15-8c71c040b026@linaro.org/
[2] 
https://lore.kernel.org/qemu-devel/20250505015223.3895275-15-pierrick.bouvier@linaro.org/

> 
> For the same reason I think target_long_bits() is a step in the wrong 
> direction.


