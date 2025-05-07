Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EDDC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 19:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCk0H-0000Zu-Mp; Wed, 07 May 2025 15:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCk0E-0000ZM-O3
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:00:22 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCk0C-0006Vr-PD
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:00:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso339693b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746644419; x=1747249219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIiH108aaDbmuY1ij8Sh/HhOFxsENZgyfoV8dy+RZA8=;
 b=GFCWf76vcdDNPmNDH+PXdE6WMjSjy5ozKSPQAq9m+NJhUwlgzQn9zz5Ijd7Y8gIIKG
 7o/dfwAGx3LD9quteVinnO3dPXmC/+C+ZwnO69drdPYcsY7t40pBxtS+ad3O50hKiNS5
 d1ovFQviqazN5WN8fedH3KxsWrmt8/X01mRsKwB9QQSaGfCt26Cvo6asJQ5XuMSfUxL3
 L6vzbbjRqmL5TMb02o9jiSNsvDuttwG/2lB5+kYDiV34zf28emLktcjGmSg3lH9GgEeC
 TYbX1772Yr/BRnbm1IQ/0MeUW1ORafDXGPFXcoIsch18FyDHrBlec2jBGOEnffKjDKnC
 Vb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746644419; x=1747249219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIiH108aaDbmuY1ij8Sh/HhOFxsENZgyfoV8dy+RZA8=;
 b=ihNtOT9qKhQdqP1UfY8Z5jSefiqX0meFqFclEOnDrIZSC5l173Tbpgqgiv3DnEgIBm
 grfEdaLqB6InUFytv3CTp/qBzQSFXRB5Lekz46hj3O9Cx3RANY4pMBosyvRN8GorWCxd
 SK4811YtqiU9m2ETKeZFrh2lGPpH5kHvEqfqLpq9IzkhfTgurBSP/Oc7yxwUQ3AKwaVa
 olIkM4fz6m7v/pa3OYJPXQDNlzZAe0jt3uvnoUhQpKDaXAz77z6mG4dXDvzLDKwkQICX
 oPJv0Flsc9ybyxCzmfxUPgZZYqd/MS7alTE0t/AzzJYyW7/YMB2rNYHCMX7zTD7ymLYb
 e3OQ==
X-Gm-Message-State: AOJu0YySVH5+oq1utEwAhZmuT0YB3NlXfQq3ZXKPHCFDeg9LRQxne2Xh
 xsGFOMGhLOzkyGqM4I2RoSXBUgBByNk9KXWJY5znmGoau9l/GtjWeZYB2SQmG1L0ii+uipp7l9C
 L53/irw==
X-Gm-Gg: ASbGncuWpuHJI3ekP2dklfNjA2+HI3AFVjQiVBtpVoQjgl5EF1yDZaQGXmWPUmk5oOn
 KCTFOLZwqHo6fGbBSRgiJFlSdtcRYYP+CREge509lAswhjFkQzd5SlT2Xuf/zLdGRtZI/ruB+Rm
 ltGRH07DnNpP7w7n63yF9y3MbqXbWIuLdzrc1Of7Ec1ry6WrHQj9Sh365bP9yC8+Gpt1W/J6NZG
 uTCn+VYgq7qX14pDVdyTXWoaDUCyWQPu95RZwAaYjneOHqoPjrL3UJ66nj0ZUgcd7PodfaNDps7
 IlrGxssb+rLguLcavAdNx6ORgpTN/FFkEhNaHAJpPLYJ0UvkNHdURw==
X-Google-Smtp-Source: AGHT+IGwVA7tUVXTHReMzPdT2+n3FZWfsv5SUJkPRDSj1jbuWTBsE+yRCkov2RzvTD0z6FQDx2znmg==
X-Received: by 2002:a05:6a20:158c:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-2148d3323d8mr6542005637.38.1746644418783; 
 Wed, 07 May 2025 12:00:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df43c8sm11647987b3a.84.2025.05.07.12.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 12:00:18 -0700 (PDT)
Message-ID: <184b0c6a-3d22-4c03-9cf6-595dda5bf3e2@linaro.org>
Date: Wed, 7 May 2025 12:00:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org, Victor Toso <victortoso@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org>
 <f2972cb4-4266-4835-9548-706983dc611f@linaro.org>
 <87msbokg7y.fsf@pond.sub.org> <aBtEz_yKswP-yECK@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBtEz_yKswP-yECK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/7/25 4:32 AM, Daniel P. Berrangé wrote:
> On Wed, May 07, 2025 at 09:55:13AM +0200, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>
>> [...]
>>
>>> I don't think we should think too much ahead for languages other than C,
>>> for one, two, and even three reasons :)
>>
>> I agree that thinking ahead too much is a bad habit.  So is thinking
>> ahead too little :)
>>
>>> - First, it's already broken because we rely on ifdef that won't be
>>> there in Rust or Go.
>>
>> I don't think it's broken.  QAPI 'if' translates straightforwardly to C
>> #if, but that doesn't mean it cannot be translated to conditional
>> compilation / metaprogramming in other languages.
>>
>> In fact, the value of 'if' used to be C constant expressions suitable
>> for use with #if, and we changed it to its current form specifically to
>> enable Rust work, in merge commit c83fcfaf8a5.  Marc-André's was trying
>> to develop Rust bindings back then, and if I remember correctly this
>> change was enough to let him implement 'if' with Rust.
> 
> The usefulness of the conditions to non-C languages may well
> vary depended on intended use case.
> 
> If I'm writing a mgmt app that can talk to QEMU, and I want
> to be able to talk to both x86 and s390 system emulators,
> I am unlikely to want the language bindings to omit features
> based on TARGET_xxx conditions. I won't want a separate API
> for each QEMU arch target, I'll want one API for all arches.
> 
> Expanding this further, if I'm writing a mgmt app to talk
> to QEMU 9.2.0, I am also unlikely to want the language
> bindings to omit features based on CONFIG_xxxx conditions,
> because I likely want to talk to a QEMU 9.2.0 built by any
> OS distro, each of which may have chosen a different set
> of --enable flags for configure, and thus having different
> CONFIG_xxx conditions.
> 
> TL;DR: in terms of code generation, the prime use case for
> conditionally generated code is for QEMU's own internal usage.
> For QMP bindings generated for 3rd party app usage, the use
> of conditions in generation feels like a niche requirment at
> best.
> 
> IMHO the code for any public facing API derived from QMP
> schema should be invariant for any given QEMU release.
> 

I respect both opinions: expose the same interface, or relax what we 
expose, and adapt the consumers.

A long term solution could be the latter, but we need to be able to 
remove target dependencies in QAPI without spending N months on this 
topic, so I favor the former, keeping things stable.

It will not prevent anyone to do further cleanups, nor make it more 
difficult anyway.

> With regards,
> Daniel

Regards,
Pierrick

