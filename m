Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4581090255
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3GTY-000330-VQ; Thu, 19 Mar 2026 12:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3GTX-000327-Dz
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 12:43:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3GTV-0003R2-OH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 12:43:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35b98def50bso675905a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773938636; x=1774543436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2ujEm+aBkGXplseJRQTMt9u5pLAPsE+VT0XOE17Oyo0=;
 b=t1I4uUTNqlvS3nhopASrgiyNALe96N5Wsjmbsj3Jao6zQP70TDFpZ5Oi7+7txCPmRG
 8vshu1g/CcQ7q08ftcZjTadEZbsWEs1kKl8VHKQH621rCswexuWydSRAn5ZjQPM+ptr9
 LokWpWKH7ndgEzqb6ys4OIsqaQpQjVNE73rUXh484rRRFY+nRoWMjX4z4NLypuOfMpXD
 mEpSlpyz7eQokUAHOry1tUbTFmyhIxlSMO32qjcGZesXITQsI+5O1YLNd9RBZkuYTpox
 L5PFAN3gHhncRYlfOx3ahwKjslujKSbAuAv9WFAZ9blfmKoA/T+8psKnEeMe/BKQ5r59
 pbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938636; x=1774543436;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ujEm+aBkGXplseJRQTMt9u5pLAPsE+VT0XOE17Oyo0=;
 b=Nl7E9cE2qMKRpVH7ujUvatXcY9lvILnhZzaMB7N3+yBRumaHa9Mvxb70CetsE3cF+k
 TT46UUYuL6USOicOUCJr5InySo7s/mLRJ8v6evIt/+DaOrwy6L7X1NYVzbXN3l70FvlG
 0Hu6zOju0o+3k3uiekZ3o5yVHlhJ4PST3XEmsYA4aNNNV4YVtObMF162+KjqCzHs5wQG
 xGXboe8esivZdBFSYdkgn+qtbQcNGHvs1wiaiYkZL4y+rGyWN7qfe1l+pGSRzNPOtsGP
 uUFutVpbBLST9EKIEUlknzTjvwKoZc7U7wxkGCuY0eVNjy4jCsqm7c41+fXmG4skr25k
 RYMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9FzluhBZRsFwcmkkuWxjLGBoIoLd3m6bh6AA5goMDh6S3WdUBhpaak806hwtqpocSPozU9HLOX8Gj@nongnu.org
X-Gm-Message-State: AOJu0YzXB6U3q+fx/HFzM8gaqryTeX6WIaHczmcbHN9/AU7JoKwFsU/B
 VRy+uU0f9vLLAZfEqdWnjSZeK3+pGzZ2HWr3u+Q+duPQEouc9URXDbKkkp3oovQawjV98KROO22
 emxStRpk=
X-Gm-Gg: ATEYQzyDWo40a6t5nv6ZzMbBPzngBB0kSfs/+Mengs2Y6Ji0mL1OUYpcSVfzgtTFPBV
 j0qP8kXIk/6qiFmTSmm00D31SWAMEqvYiiMGbPcNXO6M23S6Tfwzy3WMzINBHQB0YpndtQKNDId
 idwOU7J6+3FeK8/uFWCgVmuVBkyuXjQ3wdAMqjt/SEnKR7nrM7PYzuNlJLWSszbsBXkQQghB2cd
 l9okiav8eDLIGgEHWShk9I5wSKJ13k2+edYMGlDgfJHhfRY2v4u7XnkaxEhL8k4o/jMxXadni/C
 WbO/T+StPPw3TvPWtcmgk9uon3X/CHv/nJLsN9SZS7alxSIwqQu9yicQLCAykigqQzwnf1Z5jeU
 yPFbw4u8x80w7DDr1lIBlQqM9DbLqS21vL7GRQt11/DjfZ3U69h8lvqImpTVsy+7IpiLlVkFjxH
 p8Z/B/qFdbFupMu7q3Y02m2ZFJnB/T+jgT9vmrzO6giuZpfikAjp1xdm/8wGI9pnMFOXVF0y1YK
 0zrt4I=
X-Received: by 2002:a17:90b:2d8e:b0:35b:a656:a61a with SMTP id
 98e67ed59e1d1-35bb9f3eeccmr6836748a91.25.1773938635611; 
 Thu, 19 Mar 2026 09:43:55 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc6026a5asm3935681a91.8.2026.03.19.09.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 09:43:54 -0700 (PDT)
Message-ID: <cf1c21aa-ba15-41d0-9ae8-8c43d5af9794@linaro.org>
Date: Thu, 19 Mar 2026 09:43:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] hw/vfio: single-binary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <517be5bb-d6c8-4220-b585-3adbe4826056@linaro.org>
 <5718eb21-ab32-49e1-82ce-beabb33983ea@linaro.org>
 <f09a4fba-96c2-43f1-92de-412a1db18ac3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <f09a4fba-96c2-43f1-92de-412a1db18ac3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/19/26 12:39 AM, Philippe Mathieu-Daudé wrote:
> On 18/3/26 18:48, Pierrick Bouvier wrote:
>> On 3/17/26 10:57 PM, Philippe Mathieu-Daudé wrote:
>>> On 17/3/26 20:42, Pierrick Bouvier wrote:
>>>
>>>> Pierrick Bouvier (8):
>>>>      hw/vfio/listener.c: remove CONFIG_KVM
>>>>      hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>>>>      hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>>>>      hw/vfio: eradicate CONFIG_IOMMU from sources
>>>>      hw/vfio/pci.c: eradicate CONFIG_KVM
>>>>      hw/vfio/ap.c: use full path for target specific header
>>>>      hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>>>>        hw/vfio/kvm-spapr.c
>>>>      hw/vfio: all vfio files can now be common files
>>>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>
>> For some reason, b4 trailers does not apply this. I added it manually on
>> latest patch of series.
> 
> Sorry for the inconvenience.
> 
> Maybe I should have prefixed with "Series:"?
> 
> Also there is the '-t' option:
> 
>     -t, --apply-cover-trailers
>        Apply trailers sent to the cover letter to all patches
>

Unfortunately, this is available only with b4 shazam, and not b4 
trailers that I use.

>> Regards,
>> Pierrick
> 

