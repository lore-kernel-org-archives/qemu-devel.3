Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F571061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EhC-0004hA-N1; Mon, 30 Mar 2026 11:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7EhA-0004gT-Sh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:38:28 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7Eh8-0006Oo-Kv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:38:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82a646c96bdso3752721b3a.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774885105; x=1775489905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gpxabWmEMaK2M+zPDPE44PqFVUiw2En+VUqwLw1gCoU=;
 b=XTk+9RwhXFpCgoGr0TEHDVSHU0QoRUjg5VbXKjs9hnBAhNmXvCUpAtpVV4jjYwdweG
 IWl/NBt7De5TH/d0839tKahON/TExJXXeJhppMfJ2H191REnja/dHAMXIWadeJD+eQXb
 lZbmSmpgQYKF5CqEkcbbE7JTGeRoY47PlIKeNdKfWVwbu5UTmhnDyChfENoKwZdN3ta0
 PGhhzMMAl2Z63dfj8ZgsilzGmBxlU04ybW9eb8LAhimGqjmWFnCappTHgL1DRg8Zykpk
 HPV4tWWnUDKml7XeCJWEqYCa12H/sUFY0nTU4afFsMCXHHn8DHP8xVSF8yryUFMelQw1
 QTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774885105; x=1775489905;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gpxabWmEMaK2M+zPDPE44PqFVUiw2En+VUqwLw1gCoU=;
 b=RzPjdaSy/pIJtjt3q3TOH2moitZ12jVYzBBeMLiALk3+93oF+KNaodIzCvhV+RUumx
 cDCIC9MjUjONnE3fwAYv8Pbjns72Msc+ffaFWMg9S62lvwmkyoQnh0beAZf+jgxGA/dO
 JvW/8X+QyBPHRb8V5WwtlEDNp6dVUsJqyGcBRC3eZKva7X4TskVi4eXO7Y8nvSNMdRCD
 SK+658KBOD0M8yD7+HgSV8f77DilrhiYy9QLtajr3gkVVKeFdHKIf43l2nlvL/UarNG3
 lC5uhmBI9mzKpmvDcAWe5BdEbGloDgxrFSSGDZPyHENsJLSMufdh0G8xvRVOKINj9nI2
 L+1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPggmdJuiWWc1yyTXCpi9ZhUlOV9L3IcLCr4iWYlEgusHqA0IddzM5I65p/4tYTQgsn/ex8lan+fdL@nongnu.org
X-Gm-Message-State: AOJu0YxumrT/oD7iNX9n49Urh3uCpK4Ee0iwqbdDgurJKygZr1giMKIi
 85O2LNAJuHsEVeUs5AJ9eNfT/2uJJdjA9UjRAFH8VGtDLKaDO6bp94638vbJ5PJQwBk=
X-Gm-Gg: ATEYQzzffqzGttQlXFMhxNm9Ja4zvJSxRp5/ep9USLcoOjLy53HVtFLoRuQy3bagMPz
 R+X5omXoV+RIRXoJTaYvIFADUm0kerJREqegnUMN9cjpM8gh1Ok4eHpMqkfew5UT34JYTRIspjL
 wPMVVsrMETNCJUbm3x7CkyCukMbfaOMzHyL1kYyoF549csgksC4gxDRbVCPVtcg+J2tO8yxBipj
 bF8bKDiaNU9VOx5QFPwNH7FXst/Tx+gQ0k167BzPIKfzBW/8tstLoDnuEXvZH/DAHgfaMOjY2YE
 twRYr9xVoHh3QT25zQlWccZpP6WC1bapMpmbFnqg3Rqi1luUNlmodpATiotGXiZg/vVyroklAq4
 765lp/5/vuge5j1iQ/LGr6oDMTZ8/pRpUkCuzJD95VCP8STgFVXauYnh4yX/Gnav6TcmKNTzgQn
 +jeraRhBHnJ5L7kUqvbHL8pVV+wdIRB0+GdU1Ual2gy2xOia935tpbg7cnQDn1sWWEdBfY
X-Received: by 2002:a05:6a00:299a:b0:82c:28e8:a009 with SMTP id
 d2e1a72fcca58-82c9601c031mr12735185b3a.51.1774885104397; 
 Mon, 30 Mar 2026 08:38:24 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca85eeea8sm7603543b3a.41.2026.03.30.08.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 08:38:23 -0700 (PDT)
Message-ID: <c94c2f42-812d-48fc-a971-fe5bb7379a06@linaro.org>
Date: Mon, 30 Mar 2026 08:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-6-pierrick.bouvier@linaro.org>
 <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
 <1c34141c-7b26-4e15-885e-27c15382ac07@linaro.org>
 <8e71cd16-7938-487e-91b9-2863f1eef15f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <8e71cd16-7938-487e-91b9-2863f1eef15f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/29/26 8:46 PM, Richard Henderson wrote:
> On 3/30/26 12:34, Pierrick Bouvier wrote:
>>>> -arm_common_system_ss.add(files(
>>>> +arm_common_system_ss.add(
>>>> +  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
>>>> +  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
>>>
>>> How are you not removing the other decodetree invocations at the top of the file?
>>>
>>
>> They are still needed for user binaries.
>> As explained in commit message, we don't have control in which folder those .c.inc are
>> produced, so we have to duplicate them to make them visible for system_common code. Since
>> they are not proper compilation units but templated C, we don't really have a choice here.
>>
>> The only alternative, if you prefer it, is to remove them from gen_a32 array, and add them
>> to arm_user_ss. In all cases, duplication is still needed.
> 
> Maybe I'm wrong about how meson works, but does invoking .process() twice result in two
> executions of decodetree, two different file objects, possibly with identical names?
> 
> If you want to share these, do we need one invocation, storing the file object in a local
> variable?  Akin to
> 
> vfp_d = decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp')
> 
> gen_a32 = [
>     ...
>     vfp_d,
>     ...
> ]
> 
> arm_common_system_ss.add(
>     vfp_d,
>     ...
> )
> 
> 
> r~

Yes, your idea works. It will still result in duplicated .c.inc though.

We can't have a single invocation of the generator, since the result 
will be private to a specific binary/library.

You can see it by inspecting build.ninja directly:

$ grep 'decodetree.py.*decode-vfp.c.inc' build/build.ninja
... -o libsystem_arm.a.p/decode-vfp.c.inc
... -o libqemu-aarch64-linux-user.a.p/decode-vfp.c.inc
...

As you see, the output folder is releated to the final library (or 
executable) that will include it, and not to where we are in terms in 
source folder.
build/libsystem_arm.a.p is only included for common-system-arm code 
while libqemu-aarch64-linux-user.a.p is only visible for arm-user code.

Pierrick

