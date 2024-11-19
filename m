Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B390D591A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRT9-0005K2-MA; Tue, 19 Nov 2024 11:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDRT7-0005Jj-MG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:52:49 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDRT5-0005Uf-3h
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:52:48 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7f8cc29aaf2so833905a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732035165; x=1732639965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXdNvFtyTDNpD60Tzhit+smLCSixf4jDFkhigWgSGRY=;
 b=RU24KaC3E5sEt84Ll3f81s1xZV3T5OkQNd16MRQWA8Gbjyak2FV0O1N2DqJBs6bbl/
 F0uM95bv8nj68p9VQBWeTUIfXGNiT9jWSp08RG+hTbmM6yx0JXB2yicXqBNwsBsAX24I
 jA/Z2LMw0C/aYF4gRNHAd2OuZWGjZk08H/550RyV0z/OXtCSYaDc5CRzi+gMvd3EHCzF
 +jhH3aoeT/9CPIEvcPg6jQkXXaDGFWC/WQfJUHGj2AkFyPMB52PajStqbYXzGdpBTcj6
 /aM3AIhnG6dElv2XqeCVrLHGibJgSoq01NrgsuX63j08XSqp/S9M06CCtanQ48pXqWPV
 u+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732035165; x=1732639965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXdNvFtyTDNpD60Tzhit+smLCSixf4jDFkhigWgSGRY=;
 b=J+/t2xwHxNTovneYfyvvN6VG9dG6yit5VwecWq4Dz6CarhBw6ODrtxjlWlqtVrh9vy
 MxB5qhrXmE0GAmQ6ojILHnbcF7OyClBZ+Mli7RiHTKHk2IZa8m9v1T+LedpNLf9V8jcO
 eZOmLg9u2rv1F147LkGUxKbcVHbxoDr9SIFFRbOTtc0DWN+VUNNw7yeFJuS01uDeytMc
 T0aU1qNkosiPd7pxDFdzYcI3peBitJNigQBQtl0jC3q6mUPD30NnSuHIgBMRZtGVDXd4
 giGKEWJM0pJfhbxTdwaSi0PowJjdScmQ6YV+nf4mSygmtnyUR+M/SdNR8BtLoCj98LSG
 MraQ==
X-Gm-Message-State: AOJu0YwaWV5mgf4UaTjaCHLvLI7i9BmWydRVGCH325qRsYizWM87di+/
 xZiel7DREuLOkiPkaxnn+OP9nhkrJCnz7e4prxMH7LO3sA48b3wPBIeb7jrOVgTmCs/5tORgO/N
 Tw4g=
X-Google-Smtp-Source: AGHT+IF/qu1J9VAHWBnjWeMVGyjxlNf7Kfl3lAh+tqmkfLOgfebgjKKumBF7+DMAzqZsAyTQRPzFhQ==
X-Received: by 2002:a05:6a20:258f:b0:1d9:2408:aa4c with SMTP id
 adf61e73a8af0-1dc90b5679bmr21680244637.23.1732035164890; 
 Tue, 19 Nov 2024 08:52:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771c08f6sm8601067b3a.127.2024.11.19.08.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 08:52:44 -0800 (PST)
Message-ID: <33af12d7-9269-4c21-96d4-aa76becd0f09@linaro.org>
Date: Tue, 19 Nov 2024 08:52:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Status of some Arm features
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
 <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 11/19/24 02:09, Peter Maydell wrote:
> On Mon, 18 Nov 2024 at 23:33, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> I'm currently reviewing the QEMU Arm documentation, and I have a
>> question about the status of following features:
>>
>> 8.0:
>> - FEAT_DoubleLock, Double Lock
> 
> This is actually an "anti-feature" :-)  It is optional from v8.0
> and it must not be implemented from v9.0. We implement the handling
> of it based on the DOUBLELOCK fields in ID_AA64DFR0 and DBGDEVID
> (so it does the right thing on older named CPU types) and don't
> advertise it in "max".
>

Despite this singularity on versions implementation, should we list that 
in our documentation?

>> 8.2:
>> - FEAT_ASMv8p2, Armv8.2 changes to the A64 ISA (bfc and rev64 instructions)
> 
> This isn't a feature for CPU implementations; it's a feature for
> assemblers and disassemblers, which have to recognize BFC and
> REV64 mnemonics as being ways to write special-case flavours
> of the BFM and REV instructions.
> 

Reading the feature description [1] or the A-profile manual:
FEAT_ASMv8p2 introduces the BFC instruction to the A64 instruction set 
as an alias of BFM. It also requires that the BFC instruction and the 
A64 pseudo-instruction REV64 are implemented by assemblers.

I understand it's both introducing the BFC instructions *and also* 
ensure that BFC and REV64 are implemented by assemblers.
Is my interpretation wrong?

[1] 
https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/The-Armv8-2-architecture-extension

It seems to be the only feature (through all versions >= 8.0) that 
describes something this way, so I'm a bit puzzled about.

>> 8.4:
>> - FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)
> 
> This is optional, and we don't implement it yet. (There's an
> open ticket for it in Linaro JIRA at
> https://linaro.atlassian.net/browse/QEMU-309 )
> 

Ok. For my personal knowledge, does the implementation in 
hw/timer/sse-counter.c is related to it?

> thanks
> -- PMM

Thanks,
Pierrick

