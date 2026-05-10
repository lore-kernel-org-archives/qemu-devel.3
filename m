Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0900FCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6rd-0000b0-Lt; Sun, 10 May 2026 12:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6rb-0000ah-0n
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:18:43 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6rW-0004VK-6X
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:18:39 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-48270f099d5so241554b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778429916; x=1779034716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3d0h7SiHKgaegJHYh9DyHcj5wh74yOP+cUl9vOuCqRQ=;
 b=sh+exqAlz0j/0rNvRk5EVoxi838Eb1FzsrNW/QfrTAzh5x7UUwwzGlWYtbS/4kAOFq
 bYn928hVphACD00rm4mdoxzlLfh2EwJBoUaZVcNMwbF4M0Hk9MoniTC85S70510BLZ5d
 NLWoNUvAgFijkxuInb42rAKzRXawmX1AkOwKNENZcfYka8qmKIdQcxHRxjh4Ok1KIyfc
 DNvoYcenODA2fEdW2dmZAnaXGA+YvQiEs4Y3Q4dfeBEyI8+h1CRqWKHPLmzRLZUC70LO
 oH2i4JRVminBukn+N/8IYMHfQTNEBZpDd1gVKJc4LP9w0YWtTLwO622j1e386VXUU9H9
 16tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429916; x=1779034716;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3d0h7SiHKgaegJHYh9DyHcj5wh74yOP+cUl9vOuCqRQ=;
 b=IyW8NmIfVmh+wkf2nZ2VvZwaoIFzkiWEW0ABlvRnJzS1FBLigj/MuN7YwHy3me/u0V
 nT4ozbQLbM9hFKIur8q8PwBJMgC3E0hsva2hkpfnldYyII+7yvOIrLQBnMinEeki5NfQ
 TTwmgnw8CXXrf/sSSF/gKD2KaeW5DUKHsejIwtmr056KUabxiocek0fIA4PBKVE+GFqJ
 wjS4GSbUYs/9Hg109TsiQ0E0+/txxYLVYtDJlc772MO1eajDhkD9xugJnyZxsAfl/AWS
 27CC7l4bVLh4nZc8yc10ZK/tECoG4G99LX0uw9QOuWQn6yESBBHJdF1yfJbpfoFCgHPv
 /UrQ==
X-Gm-Message-State: AOJu0Yzs24jGpxPlPuXnPfBQHAzI3LY45dPJReQZllWehSEH9c3PLFHv
 Cc0tSLwaptzKaW1AdQ5cmfayxwTDcXUQdfCd/Th9gXFAoYyBgGK3/lH8Z8b3P6KEBCVS2gkW/Q/
 MPyfM
X-Gm-Gg: Acq92OE49Vi0ppkdfAwOAgJ3ndujO1WpgxLxoIUuwOYfiHBUxrKEQ+W/behTKQv55JV
 xmwmD4wMqYBOcybmhbaRuzO/eoDIGQGtb0OQl/WNCh01XWi9avUtvbXeK9NL1jAIEOhRRphD65L
 n/oWwLw3Fv4iIWm8aAyQiefNdJk6rypdw41UNyC9p852EWCX1++zFjsieetM1rHGQbXgzp8AP2B
 DqxcIX2Gd/bGGnMlDndnc21PVwsz9xM8GK+JySRhjK0fRIgr1ka0Xwb8jGFtFImAi2jAFsu7Fv+
 wRHg0ToBfyQyFcA1+Ywb6u8KMVUoam3QCe279EWvEuTretM1i8n+4UldJtE3aNL6n2yiF415yFU
 2S4VfYWBxilM+0xVP1sj3yHQzSagmQ8BQlp3F5qg7jmkNchFN4WyarS9/9n1MtqaUT0JXFzcELm
 cTToZo7afXn+6HjBqDT4+NwZgYLJSUYIIwCLZdvlP5XXTqbt/2uwWu0wgCEEpwGHlP60CReX9fv
 05wdrX2xg==
X-Received: by 2002:a05:6808:178d:b0:467:49c0:5f6d with SMTP id
 5614622812f47-4804247a9d2mr11050394b6e.23.1778429916395; 
 Sun, 10 May 2026 09:18:36 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76986f87sm18664018b6e.13.2026.05.10.09.18.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:18:35 -0700 (PDT)
Message-ID: <ad009186-2006-4a5f-8521-08677ddbc900@linaro.org>
Date: Sun, 10 May 2026 11:18:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/32] target/mips: add Octeon ZCB instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-13-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-13-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 5/9/26 21:13, James Hilliard wrote:
> ZCB zeros the 128-byte cache block containing the base address.
> 
> Model the user-mode-visible effect by aligning the address down to a
> 128-byte line and storing sixteen zero doublewords to guest memory.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split ZCB out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  3 +++
>   target/mips/tcg/octeon_translate.c | 24 ++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

I don't see documentation for ZCB{T}, but it all looks plausible.

r~

