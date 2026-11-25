Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE922606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xa3lIrTE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWHk7-00010t-IJ; Wed, 25 Nov 2026 13:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWHk4-0000zM-5p
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 13:29:16 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWHk2-0008TY-3U
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 13:29:15 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8b6b22be970so2444182b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795631352; x=1796236152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hqueLtmRVgkJClIHnnUFhzB2rYtnsWudSLyAE53/aDs=;
 b=Xa3lIrTEPPQ08/rS4ndmovvZNyhbf8PJBU9IvW/3TmD7A5rmqpgYnq5BnPyhDYNyJ5
 5/acpe5/jNg1Tsxs86z4Bmyzaoc9Ry70wdERhDeEI1e9M2EuszE1KEjLqbXE79fo7vDD
 6dEpYKHIDkokc5kM2BIrGB+X8SAu5VPP5/UpAZ0OfokHX0WCV2dWo//iyDMQPYjYUCeQ
 caMI6Az7gNfkJqzB7OHsT2CgRJkdfGw2WjM5H67ixb6y8aJcsuYkWTqhTUOhAXnGezed
 VSIy//CNWFwA1CGyrkJV5nde1x/pmUHmgczuHbwsN2SXvFCCE1CIPQG4VKIQl3xRC3+X
 pnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795631352; x=1796236152;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hqueLtmRVgkJClIHnnUFhzB2rYtnsWudSLyAE53/aDs=;
 b=j6PQxOYHqjNFPcWczkJIxXI/j+LDQjQjk+l4g8QxuQMJ2s7+IncVctUPkApppJ9Yfb
 grMIfat2fh5BPq240XMN8M0F+h6VpwGQfrTcDpu/0yCoS5VQiwMf6qHfWjqJOf+XXaqZ
 rfSEHlhMKzWQzuw4RsLjQgowiPeX+73IujbIQHwVbu9vP2uG+tNE3DkVXcK4v96yNKu5
 41nVUfiaDTBY1gKMlfsjP3A8Aa9CdTyb2g09qTpWhLVdrknnfHrH0eTpCteeUMDMzF/8
 L0WByUpWabYWFb1X2ZMNdFdK2mIaBQRqAwtw4gFnBFSCwGh9KfZH8+9JgDRYVa86keya
 TRBw==
X-Forwarded-Encrypted: i=1;
 AL+hErGNfhV3ADUqpru2qmUgLHd0VUWtNf538eEPPmTFrKEA7Rt5tLsuSA7iWSU/g0E/j45TonYHMiHMEwUM@nongnu.org
X-Gm-Message-State: APuU4Z8SCap9y7ViOPc+fzlffD8KkHoICmmV9V7V/MnMO/zSqEfYDMGW
 YAFwn8A4HzNYrs9V3mMyd3nRYQkEroKPh0hvNeE/UthnKMp7AdLk8kwHwro16fWIYwI=
X-Gm-Gg: AZFdTZfADYdv6XvyQXFpgqDvAg8+VLo2LdGPqzBoMgJtv0MoX866hJ8eQqLdfHkQ0gE
 rU8eE1ykg774oTelxyz0nt+Ws0Ipr+vRiuLLf0lOr5DutnFQYSL0l2HpaBGU6tRXjHjjKZJP6Y2
 6bLS5vPayNvqtet+kbGoQB3Q4gx7UAl9AQBCiOwSsxeyaeTj9QhKSqop/lWZ+/8hDt40BACnIxK
 bveu1BOa1F44/wi4cY9HP4SmUcHsbGySaEX8SQxWpUb3gTRw0SEy93ZoGeMDX8YJkJlVweUblWG
 0FPNqQw6MvWmryVcYdtQG72EI1sRMewgtw5CdOwkvH9o7OMdu5/PCSQloZo6a9hgxP3lT9LGIrK
 CTxSZjdXruFB4Pm8hYv05in/SkH5b8btoI3hcKfdzvs3aniqq2LiqsNkZka0o3G2LqNK1rYmfIA
 hwsHamuLrT9liI2rY0WlCV7aHq2p9H1N1OE0+J27RpC18ROtaqaCJHiFrds6JBXtgU+2OQOqZ6O
 74J7A0gkSRMfUMLDpEIoKR9YX5Go/9y1mLuk1FevETjvh3a7UVg0xlJI8hj63E/CzinNgkkukn+
 OPB0IL4on6qqLLGNvyG1gDeSTDykcRhmqNxTxD1bUTxZpYa7J3OBByA7E4w3NxkB
X-Received: by 2002:a05:6a21:7907:b0:3f9:e322:ff2d with SMTP id
 adf61e73a8af0-4014cb3b376mr16030930637.21.1795631351894; 
 Wed, 25 Nov 2026 10:29:11 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cff4c1asm9292707a12.15.2026.11.25.10.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 10:29:11 -0800 (PST)
Message-ID: <aec208a9-3298-4c1f-836c-1db27d89cfed@linaro.org>
Date: Wed, 25 Nov 2026 10:29:04 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2? v2 3/3] system/memory: Invalidate TBs on ROM
 device mode switch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Elliot Berman <eberman@anduril.com>
References: <20261125093349.97805-1-philmd@oss.qualcomm.com>
 <20261125093349.97805-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125093349.97805-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 01:33, Philippe Mathieu-Daudé wrote:
> diff --git a/system/memory.c b/system/memory.c
> index 2e3ce773ce97..6db104cf1741 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2254,10 +2254,18 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
>       if (mr->romd_mode == romd_mode) {
>           return;
>       }
> +    if (!romd_mode) {
> +        /* Drop TBs while memory_region_flush_rom_device() can still run */
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +    }
>       memory_region_transaction_begin();
>       mr->romd_mode = romd_mode;
>       memory_region_update_pending |= mr->enabled;
>       memory_region_transaction_commit();
> +    if (romd_mode) {
> +        /* Drop TBs another vCPU built from the old contents */
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +    }
>   }
>   
>   void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,

I'm kinda with PeterX here, in that I feel like the assert is 
unnecessary and getting in the way.  But rather than remove the assert 
from memory_region_flush_rom_device, perhaps expose 
invalidate_and_set_dirty in memory-internal.h.

I also wonder why the other flash devices are directly using 
memory_region_flush_rom_device?  Is it because e.g.

>         /* NOR Flash only allows bits to be flipped from 1's to 0's on write */

means the device can never be "ram" and must always be i/o?


r~

