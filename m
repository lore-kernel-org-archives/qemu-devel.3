Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4359D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBh2c-0004ON-Du; Thu, 14 Nov 2024 16:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBh2G-0003W3-Ar
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:05:53 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBh2E-0000dk-TW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:05:52 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20caccadbeeso12132885ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618349; x=1732223149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gyEVYNj/2Nmtb8VUhYWVl3Md5+nHzvLU7b8McZcTY/k=;
 b=pItZUJhetWEO9oEf3aDFh0KtIgV3Q+enTZJNuGZKv13JZXEN3NNu167SREwHtHhUqk
 a7oUZ0FjXg0+zdl7M275t+aErE3Jor+/mjj2Jn7d91vWzLkTKO3f4GDmCOqaulhPGKFh
 7Zn9E+IBWkRHjg2aYsDbufLrvO9jv248ov/TpJ5n9Ho9GJNsY3ny3WgRYbpUscT11WjM
 MVpjIFb5xvTLJmjwnmQ0+SWEE2JCk5zKkaNtXpDj3XGDOc9tAmJHefULeKkjS9VaN0pY
 IYjGtYZx2i2Ht3co4bkXw2jz5YGPtOmmXAGdhev6m+bL0ZEG7rICjKOw2oMPTz9pcq0c
 o/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618349; x=1732223149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gyEVYNj/2Nmtb8VUhYWVl3Md5+nHzvLU7b8McZcTY/k=;
 b=RNxUBRw+XRCtlbbgqeirPeVYNSTM52LCZ2t4qashzXLPPJz32eEWh32SjWmxdQzWqQ
 HKFgzn2uJ/yZKPW4E0PaRbPGLZ8a/k5UOvQu/sV7Mko9JxXi4Grt6NEfPNT3dGGSV1eH
 aOmjwAcgu4bQ6RcIIFzsraWBZy2rgaNmuUsuXFpEMESkKlJ46J+AIZLKSy8+xNCbDvYr
 XbmKNrwphhLSvIuZ030+YcJWLooNtHDB7uvLZP3M8ho4CcBDjO6vhNugkw3NU2hdKivi
 rXkTuo0TPi9y0DXD7JXR5osBJH+nH+Xbm4af/5tpbs13gWK1u7DF+qvxwC2MFx+JGAzB
 SmHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPudye0Y8PLPQEmo3nQLii68P4wnTnjF+R1epeUDvhry2xB0Tamlkd+JiHjGvVjbOogentwQH/Q5Pz@nongnu.org
X-Gm-Message-State: AOJu0YxG1Ty0/tZcu0ydYL78Tcxk8i8tHILpnHFndfF5fx4hsFY3T6gK
 d4KHPgnaYTgs44CopXPdbhDVsz0h/a8urgXwjSQU1yIzXKSVAmlMp71o2wF2sFE=
X-Google-Smtp-Source: AGHT+IHCSAnfiDgyUkPZSXJC89SYh0fNjsE+ZqrC1d18UPrEPXkkbO0Zn7acW2ru/Mbt3Osgv8AdYw==
X-Received: by 2002:a17:902:cec6:b0:20c:5e86:9b53 with SMTP id
 d9443c01a7336-211d0d5ec21mr3480405ad.3.1731618348801; 
 Thu, 14 Nov 2024 13:05:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724770ee925sm76786b3a.5.2024.11.14.13.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 13:05:48 -0800 (PST)
Message-ID: <970a751f-bae2-46b1-86d3-3bc97132f21e@linaro.org>
Date: Thu, 14 Nov 2024 13:05:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 v2 00/54] accel/tcg: Convert victim tlb to
 IntervalTree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <eaa2ecf4-74ce-49e1-846e-8f0c9c16d1af@linaro.org>
 <fea58b9b-9fad-4729-9f29-2f05d636d004@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fea58b9b-9fad-4729-9f29-2f05d636d004@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 11/14/24 12:58, Richard Henderson wrote:
> On 11/14/24 11:56, Pierrick Bouvier wrote:
>> I tested this change by booting a debian x86_64 image, it works as expected.
>>
>> I noticed that this change does not come for free (64s before, 82s after - 1.3x). Is that
>> acceptable?
> Well, no.  But I didn't notice any change during boot tests.  I used hyperfine over 'make
> check-functional'.
> 
> I would only expect benefits to be seen during longer lived vm's, since a boot test
> doesn't run applications long enough to see tlb entries accumulate.  I have not attempted
> to create a reproducible test for that so far.
> 
> 

I didn't use check-functional neither.
I used a vanilla debian bookworm install, with a modified /etc/rc.local 
calling poweroff, and ran 3 times with/without change with turbo 
disabled on my cpu.

> r~

