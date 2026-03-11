Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D081A106286D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HwD-0002GQ-GD; Wed, 11 Mar 2026 07:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Hw2-0002CR-GB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:41:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Hvy-0007NM-PD
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:41:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so3792025f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773229260; x=1773834060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wvX29Vy+lLgdmAcr0PHqm1/oXxBMvoJrMR4HsjlwwGM=;
 b=qwioiDa70ACVXMM6IV4hsbYrRePHf2H4kYZVxVrU0dIo3tFLJ4bJY/h98mU982D7n/
 oxs+mvxLh986Zx8mq+X/3UoEuQm89HObrIAVTX+QSL8Ndi8xeF0cs0mp9Z0CqjHx6u4O
 SGexkVSbuVn8Puc3BvFBXuo8cCWEksSsm5aqXlznwZuxN7yp2nAd7KhQiedaeRazJCMX
 Z5Lbb0OZN9ABx2TPJz1gKKGlXb/UfCNPDpOvCBmCU5cRn8SpajQ+xe4U4T74ZlfebOTn
 Fq/JEEB9BiRn31eQePkeqxiwE6VgnwOf+/evAiIInHevHL957Vv2BpSGxZ8xR9WWAaMo
 4sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773229260; x=1773834060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvX29Vy+lLgdmAcr0PHqm1/oXxBMvoJrMR4HsjlwwGM=;
 b=bVgdcEf6E8i7RAkJ0FC5WRpzi6kDKOeaAZpz4Khc771/rIPDJI09AKzRc3/W8JA8e4
 5hX9nDWVNm7rgQ8DIzmAI7M/CrRyMPxHO1RgkUY2uPaSrXG0EpC5Tu9271+LKYbonkal
 lxCIurT6qfZARCjoPqzaM4cM++awB5zOnOq7e7rotl59qtL+iI5AtwADmYPYqw8bWO1N
 qBcg5tBVJiy9Ffr3OQo1gMSIwgLjktdjEdgfjLcmoVEgD4fYYaMojUa4YCbQqDewyrzK
 +GZw0kPtzvSCFEh1ONX1+Iqiff1pHqEpGOS8mLJQMxruXBD6b2oqJRDwSZXjQ5dLTDg1
 EO3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKjq+Rd1J//56kIcRWnA872tULqSDxiae69Z+HbPy7AwV/HDCM6XkAcv1T7uJ9NBO2G2CRinAikaVM@nongnu.org
X-Gm-Message-State: AOJu0YwuMPEQxJXcfAGlXnnuFzjGYkWYJmtUoJsRtVkKktF2rD8jrBq3
 CJcYvUqWGt+PWAWgd52KNtIlfQzAs1h/QvCxPJ5Y4OTHnJHJeVqEp8/7PuQ9YwUud6jIjUOfPmF
 3Wpc2ldg=
X-Gm-Gg: ATEYQzwkBpZ3fyQKAYbMt8gmn7OliGKEUd4aTNMr3X1SjmYEbOJEw5kIpPolkfPgo8r
 8IjELXToZCNf6tbxAdzLRENO99m9q4Pns1MkCVc9kfLpjZweGvHAk5lE9VoCOyZbr9cS7cJId7c
 ld1QSP+PrW86TiIRjgDfdzJOA9rYp6uLevHYeOWtA9CgBLbqRQbpSoJpYU6ZP0KxsQa/8XT4fVZ
 XkyXyMrOdEZ3IklPOn69P5XnCeJ1gcDvGH1Xq8DB9CownsIzGO4wnhHgLz4IGsp0xG9rrJHWwy7
 g6n+9wH0E5HZA7aQ7PaYBMG/JZNGM5/RFC5GIXczmSCGhP9a+XYQURpphKHvrMxW4fiQ24nsJBV
 ziix+CQAU7EUbG84ylBE8olA6yT7KMEV1wbaVuQ1THAzLp+kAGWgUqDMWf60up5FkOOlPHZewSt
 BVgnkl+P0RY+fHFo+kMnmwqadTzCDHNc3tyhQwP9+e9eCsVUJCJQyUb531++aIpKaXx0aK9P406
 gux
X-Received: by 2002:a05:6000:2f86:b0:439:abfb:6d34 with SMTP id
 ffacd0b85a97d-439f84359d8mr3989802f8f.50.1773229260477; 
 Wed, 11 Mar 2026 04:41:00 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f818ff0fsm6624753f8f.4.2026.03.11.04.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 04:40:59 -0700 (PDT)
Message-ID: <69022858-e838-4d43-bb0d-0ee7835561ba@linaro.org>
Date: Wed, 11 Mar 2026 12:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] target/i386/mshv: fix cpuid propagation bug
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-3-magnuskulke@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311113505.1177878-3-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/3/26 12:34, Magnus Kulke wrote:
> The list argument was missing a pointer and hence e.g. -cpu qemu64 and
> -cpu EPYC would produce the same of cpuid leaves.
> 

Fixes: 4fa04dd1621 ("target/i386: Register CPUID entries with MSHV")

> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   target/i386/mshv/mshv-cpu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

