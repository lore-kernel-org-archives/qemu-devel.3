Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D219FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 18:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEAWx-0000Y3-D3; Wed, 29 Oct 2025 14:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEAWr-0000Rt-W6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:04:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEAWi-0007e7-Oi
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:04:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso131765f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761761036; x=1762365836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9VQ9NFqmoQaRAvyFbiiny8iwf9jUVf2eG2Hxhn7ltXM=;
 b=dwQJdFYFg3LvfnC+CFV1xLnrmtwNW4g5NQOJOr+PDeoh8YTRy+dyaRtE+rp54TwT30
 kMWpWnJC7+g1XnWFCkhGT84iOGZB1wv+95rL7DYFSAm04f1kREPp1vXhiLx1EomYeaA/
 qXdLffpFGShYig8yBEnX3+xpUfZ3UeaPqH17Bj1ePBMnxaXIcmSw6dBnCo41mfEIENDw
 uHcmAo7M9+excf6bfQU2nZl8CIpWGh8RoVhJi9Cc8VJl1+ojAj8PckesEh/C9D1DUoAe
 +WvnopHmBj+jhBsRnX4mcZrzZo9YQwQy5uVEdVqljlLBTbudEBlM9nkfiDCNpyJ5Tliq
 4NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761036; x=1762365836;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VQ9NFqmoQaRAvyFbiiny8iwf9jUVf2eG2Hxhn7ltXM=;
 b=SuQ0FdcVoh3tIzv/YE9VX4onnxn9u6Fv1MOmQoWELBKQNAVELo6kvraInTvav7Im2r
 Ia4Moi7i9xecq5MOi/M4qH/WoJZJALYtg6GKP16yj0bN063NorsAMlf3ZxRFrM3HvL5o
 Y8+xH+Agt/c4+KgnjwObG/++Kv4zL+Vf3VB2SbUakvN0aZHv3qHDnpVgpP3Ma6WUx1gv
 HYldRtXUnLZrNdFPycKCqnI2C4iGXyjcoU3eIG0+3lk0pZddt6NscwzxOh8aEIPROP/k
 uPurhyfomS21US5b3fMKUNtcxTzFK4JExq3SrmYqvsqDlnRx5wDwB44Y6n5OU+7jTIGp
 vPDQ==
X-Gm-Message-State: AOJu0YzyFr07tiexS4xTcbEC3f8/v5hkJjuU36mIJXTn43bbsgCHtCoP
 x5p70UPX74YR+z7bidsdSC2SPj22RTXQ30Jrf2zHpQrdfuIMUJw10g0yIqOhFq131Qv4+W8GTns
 c9crLClE=
X-Gm-Gg: ASbGncsH5AbJXgFc+ILMk+jucpIZF98tGBfOjQcioVKzRL8QNM9GFBTJ2xCIm9W2uO/
 591YXDxg5zMGNvn7v0uKxA4s6guCXEkiVud0CGSQ5ojKGPsb6l1r2QzQSjor6JzEGdWuLOz31Fp
 gm3M3xLSSUz9aStGdewmniv076JqtP/dgrddKghjupadabxcEXOsvxi79Nn2G5SW1jmc+EbvSoO
 0B5KUwRhyjUKgYGpGs5WF8TRVkM5rFrb0o6+Y65WL45DNrIWrx6kr2fFUwhmjjcdc7Y9L3HaEeq
 uMuRCY9R/6X92yFT2VnsrEBC7VgTAaDIN0Xq7/KNj0ZAU+vBryBBvyEH1XZ8CeMd6OBaPmWWMq5
 KnJ0ueFzQputi9sVKf+wssaqMoifJEf5TT6bNGpdJvGto+9qsklFbn59W5zKfhpwj88JoQCsv/Y
 lI+aSQLdBnGhVyOuEcjOM63R3+mJm0wOSc10nUpK0HLz0=
X-Google-Smtp-Source: AGHT+IFOOC35tgEDpGgsXmuWu7r0djoujt+Yy6qRLjDUgazWUa9T871lHEfonAwAiAmla/XzbRZFLg==
X-Received: by 2002:a05:6000:238a:b0:427:9a9:462b with SMTP id
 ffacd0b85a97d-429aef78fb8mr3142266f8f.18.1761761035767; 
 Wed, 29 Oct 2025 11:03:55 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7a94sm32890124f8f.5.2025.10.29.11.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 11:03:54 -0700 (PDT)
Message-ID: <1fb8a69d-de0b-4afd-9e61-083d7b3d7abf@linaro.org>
Date: Wed, 29 Oct 2025 19:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/xen: Build only once
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251022140114.72372-1-philmd@linaro.org>
 <64b66fb0-f297-494a-8e79-b38c02c070b1@linaro.org>
In-Reply-To: <64b66fb0-f297-494a-8e79-b38c02c070b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 27/10/25 20:17, Philippe Mathieu-Daudé wrote:
> On 22/10/25 16:01, Philippe Mathieu-Daudé wrote:
>> Replace target-specific code to allow building
>> hw/xen/ files once.
>>
>> Philippe Mathieu-Daudé (3):
>>    hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in req_size_bits()
>>    hw/xen: Replace target_ulong by agnostic target_long_bits()
>>    hw/xen: Build only once
> 
> ping?

Series queued, thanks!

