Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D92BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakCX-0007yo-Vu; Thu, 15 Feb 2024 17:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rakCX-0007yb-7C
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:27:29 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rakCU-00041H-Kk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:27:28 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso1132927a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708036045; x=1708640845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NW98hdEw/sMWsY0AmI/vKgALmUcYo83Mqgh3Pf6afYw=;
 b=Tr3wLGuIC9DtASyXLhX9/uqdsyNVZYv7nahbKk8UkuBjQ2pPlPEKNVIKKY6+N4C0OX
 jlxisHVhFzlPngosBMgresWBiLGdntpE+McTQCvvXN4Gx50/Y1+KmrW51cEeSoy5vQ7j
 KnBZUpQEl67daJ0CLeVsyupyFm10iE/dpvP3PVQhl/pMIg72OY6P+IuCAf8YyJVlE9oX
 Vm/bWe79PqMtFluf24s16LUoyRAJzlpBaKeSgGDB0kWo5A1arJqXb+1Tmo3e20y28nWX
 nFxwU1YywTFNlA9dpfW3sjAmhYosXwVwoPBCvougftam4zlcF2zgmwgWnYabdZRLhKCF
 h17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036045; x=1708640845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NW98hdEw/sMWsY0AmI/vKgALmUcYo83Mqgh3Pf6afYw=;
 b=RsadrkSgI0mvKpgkbSsToRKzFXe7fpDJbEtC9ch4EjYFvVFrgEF+9yYdngtE9i8iRZ
 KnyBQPxagsZOAAKUU2CsRbz2WPdoDTFOC6kHxIhst8SeqUibeR6krcHTVq07jFPG8tg0
 XVM7lAyt0h+OtQGdbbDjUK3tIFm7GKnPYIP4fqPuGMlDqkMrsHxH2NVxO5HaiOCtiVgt
 FhEiZiRNB+B9g0A55BO/9CPE6wgTcRnleX0+AJYOVzQe37zxRDITyavAYgJ7WgmdMRWv
 EZMJcTcJAsuptQf4OgjASdbRqVn+UpQ15/vmnv2JS7S6lHt9ZEYkIW62UFk+MNzEvP+f
 AL2Q==
X-Gm-Message-State: AOJu0Yw88nxkvsF9r3R+PtSeIvOVl5gxQQQc3Dwylti6SBxUaOu0rk+8
 WHSMKAUNXkJsA5B9GMfQY7un+4NrFXkGbk8RjWDkO4oAMjR/X0QmjDDd01Cpca8=
X-Google-Smtp-Source: AGHT+IEUFMZejuVXjNahOg+Z79CctXVmTu647N/wWH81vZSrjS3dIl+fUVV9/6I8xLoxiX7OBZTGpQ==
X-Received: by 2002:a05:6a20:ce93:b0:19e:b925:f190 with SMTP id
 if19-20020a056a20ce9300b0019eb925f190mr3120001pzb.19.1708036044749; 
 Thu, 15 Feb 2024 14:27:24 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d1-20020a056a0010c100b006e10f315ac7sm1827546pfu.80.2024.02.15.14.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 14:27:24 -0800 (PST)
Message-ID: <2d211317-873e-43c6-a246-bd8bf84f048b@linaro.org>
Date: Thu, 15 Feb 2024 12:27:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
 <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
 <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/15/24 11:36, Alexander Monakov wrote:
> 
> On Thu, 15 Feb 2024, Richard Henderson wrote:
> 
>> On 2/14/24 22:57, Alexander Monakov wrote:
>>>
>>> On Wed, 14 Feb 2024, Richard Henderson wrote:
>>>
>>>> v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
>>>>
>>>> Changes for v4:
>>>>     - Keep separate >= 256 entry point, but only keep constant length
>>>>       check inline.  This allows the indirect function call to be hidden
>>>>       and optimized away when the pointer is constant.
>>>
>>> Sorry, I don't understand this. Most of the improvement (at least in our
>>> testing) comes from inlining the byte checks, which often fail and eliminate
>>> call overhead entirely. Moving them out-of-line seems to lose most of the
>>> speedup the patchset was bringing, doesn't it? Is there some concern I am
>>> not seeing?
>>
>> What is your benchmarking method?
> 
> Converting a 4.4 GiB Windows 10 image to qcow2. It was mentioned in v1 and v2,
> are you saying they did not reach your inbox?
> https://lore.kernel.org/qemu-devel/20231013155856.21475-1-mmromanov@ispras.ru/
> https://lore.kernel.org/qemu-devel/20231027143704.7060-1-mmromanov@ispras.ru/

I'm saying that this is not a reproducible description of methodology.

With master, so with neither of our changes:

I tried converting an 80G win7 image that I happened to have lying about, I see 
buffer_zero_avx2 with only 3.03% perf overhead.  Then I tried truncating the image to 16G 
to see if having the entire image in ram would help -- not yet, still only 3.4% perf 
overhead.  Finally, I truncated the image to 4G and saw 2.9% overhead.

So... help be out here.  I would like to be able to see results that are at least vaguely 
similar.


r~

