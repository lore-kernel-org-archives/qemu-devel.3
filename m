Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F49C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7VV-0005vP-23; Thu, 06 Mar 2025 04:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq7VS-0005uj-5F
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:27:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq7VN-0000q0-3B
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:27:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bcc04d4fcso2346715e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 01:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741253217; x=1741858017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0l6ASPZ+A+bjtY+nXTAeRhBMi6RMwcUpq9n4X/ZPyaI=;
 b=Qxp51nYWadf0KuxJdj/ZTj1iIYv/O5GgwiujIPqSTod+xpSmryHCg/HF9nrWrxYtJN
 a/8uvqPoQlmYyA3pGG2r+LM6hiGREbMGBe6suMSrG4Hyh1sXzItDx7E7d5Kxh+xuBF5p
 Z0lJIONIxh1i3ypuWnwaFUPcSYjRZmG6BsfnmUiA3q/aKNqMzeU2x6uzqqGM8DVvEwfZ
 iV/L6x8dpnaRe7CR7FL1navwI1DcELBVgH9tnhlWNKtKGHEiiyzUFvHChdpMMlR9tz8n
 hq8oSxJjxJfMk97T/YlZc6LDtmAoCZ4I+A3UC0mpFogCu6AyQRyrRguZVFmEZdkf+in4
 Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741253217; x=1741858017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0l6ASPZ+A+bjtY+nXTAeRhBMi6RMwcUpq9n4X/ZPyaI=;
 b=eiYY0rEENErvkVgPMw4BaYVVLGuNAtiaeZSCL1IMfV9dZ2w8vFU5aUFP5V+IlJPOMx
 IAvTeWhL3jfwABWL/KSUvqFiLmvfcK0dmb0Kf29Y7WJSrrKIeqyPkK36gEcSLOqzq8PW
 EXYdMPJ/jf5nKovGZuot8vvaZuqtLognbQHIQoVx1k25brwmJhTokEl/VkXz5KXqNrtt
 zvGw7sywRar9lGUTId+fdpZHaPXRjMSPCvgKPY9FGnQdje4MaEnNM4WxJ82LPb/zwwAA
 jm0RXvnpsrNKw/2nrV/pPV0HEkbll9batsSYC8SolfzDAjepDJzTqW9f0tIiefci66S8
 jM5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqTD5d/bMgJESghZM4LRwVGZ4BDy6teNKdK33x18IHn48HBlRMLBSDhKmN7chK0X2Xg0+w9Vmmv7om@nongnu.org
X-Gm-Message-State: AOJu0YxPUg9FiD2CDOvwBdvNUwRH8jQJNmmV+PvhBnUw6irEY3nzo3bj
 M7tZYGhHB5O9Wpcx1f+KIIHiQmZkk7ugNJokkluR1C4E4PtEjh2yE6c8SxF+mhc=
X-Gm-Gg: ASbGncv3DsQdhwkpMNhqNdByuSI+HJa079lDPKCU9tNp2BxCUf3aWhQMPecTgmikarj
 cXVuuU9Ah2Oy9eOmtEZiyJXF0lpfbrZUFvTrCsb3BJYK6ztL8ktnjJVLoMPEoA2tWgUuVfnFWK2
 kUgm8HRyh09JT/7l/zsSfgHCoVsBh4Jh8H25oZa4yFGOHNCdW+9h0EuVzKByRrMpetrn++cfkiY
 qQnNoAH3ZOo8ucOyt4k1q1skNc7ZTVs7NbNBbqyiQdp7kNbce1SP071ayfuohN/ERKVUZGNcu2r
 oe8qiiaIziojDIcbOzgTT82R9Car/mrkc4sMNBxwgiN79TgNyD18wixOx8x+vfZEgBwyjuFIhKd
 nWH3piuTvRVrr
X-Google-Smtp-Source: AGHT+IF6s1lVr+OB09Y5mYXJF2AysWUZzz7Q7BXAtdTjv1VB8DYwVAgc3jYGcsde93DBnaV8/kL+yQ==
X-Received: by 2002:a05:600c:470f:b0:43b:ccfe:eee5 with SMTP id
 5b1f17b1804b1-43bd29c02b4mr47779775e9.17.1741253216897; 
 Thu, 06 Mar 2025 01:26:56 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d81csm1450266f8f.58.2025.03.06.01.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 01:26:56 -0800 (PST)
Message-ID: <21a34cac-855b-4628-a154-e708ea85df59@linaro.org>
Date: Thu, 6 Mar 2025 10:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
To: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
 <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/3/25 08:26, Thomas Huth wrote:
> On 05/03/2025 17.59, Pierrick Bouvier wrote:
>> On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
>>> Introduce an API to get information specific to a binary
>>> from the binary name (argv[0]).
>>>
>>> Initialize it from qemu_init() on system emulation.
>>>
>>
>> What we want here is more a include/qemu/target_info.h, which will 
>> allow to query the name of it, and helper for every architecture:
>>
>> target_is_aarch64()
>> target_is_ppc64()
>> ...
>>
>> Eventually, we can add combined getters like:
>> target_is_64bit()
>> ...
>>
>> Naming "legacy" something that will be present in the long term is not 
>> the best move I think.
> 
> FWIW, I agree, this should rather be target_is_64bit() or something 
> similar, like target_words_bigendian() ?

This API is to allow refactoring code for heterogeneous emulation,
without changing user-facing behavior of current qemu-system binaries,
which I now consider as 'legacy'.

Once all current restrictions removed, the new qemu-system-heterogeneous
binary is expected to run any combination of targets.

qemu-system-$target will be a call to qemu-system-heterogeneous with
a restricted subset, possibly in the form of:

  $ qemu-system-heterogeneous --target aarch64-softmmu

    ^ equivalent of today's qemu-system-aarch64

If you don't like 'qemu_legacy_binary_' prefix, I can use
'qemu_single_binary_' instead.


target_is_64bit() is misleading, for example in:

  $ qemu-system-aarch64 -M zynqmp

we create 64-bit and 32-bit ARM cores.

