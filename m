Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE05FCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6kW-0005OH-Tb; Sun, 10 May 2026 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6kT-0005Mh-Ke
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:11:21 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6kR-0002DU-2p
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:11:21 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so1711921fac.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778429477; x=1779034277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0FhTv1Y5ycV9yz8aXwxrslcy+gQnyWqXXb0tv0Mhys=;
 b=XZMekbgZFlT3iwshRWFROAwekt7f4QLACX6jpzQADu1mqjaGtVhb0OqdO4gcAl0rR3
 ZWTcLm53pqLNlmSShmsajKo/pNKuj8/X/ANXdY8ETmT382sA3WN6l88dFQd6IQbIn0NC
 Sw3URPdDTZ9LSwoI1eSbWj/cbf/x7T7zHH9GWsUJCRYvbXr9DTx5cMBO7dN0aN4b5AO8
 BACxNjeDVz6g8NJzqH3/moySjubpjb4RDv1cexlrXBi+h+8ivfqnfDy+dhJcvK1s8WWh
 WSpA9K5AmRwMH2ksvu4VNnvsT0PjS7xsHWgcgtQxZQev9Bx2xE3T4cLyBROQp5yuEMCW
 6qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429477; x=1779034277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0FhTv1Y5ycV9yz8aXwxrslcy+gQnyWqXXb0tv0Mhys=;
 b=NinMskG2JqN+oCg3zPWbUK60hJoaZTgoJQJ/hWKLMWmD4iIYz43rV99xYUJxORizU+
 kyjoUtM8zKjscGHvpzTJX7C1ub2ibLp0z5lKRcmz8oCfoNrEUn+lEbbo4uiacCghuP5z
 z4m8VSjLKR9PAfq4ilKaLehV6tYRBgY83V2ke6cxBxjkymnHagAmwmG9dqSGTyZWzUAZ
 5HHr22TSLsxX7r12GA/tgAmk4eBvQRl4GaBxdH4MIpJiuBBFMkq1lxPibivBgyiB3jIG
 OJb4ww72SbtNcePL/LbmP0loPxyoo9ASkK21ua23YkeV21BFjGeT8hH0uf71jj9qMcB4
 hWyQ==
X-Gm-Message-State: AOJu0Yy0sRDATp3Suijd6f896hrRP36UQtJXEXbyLoCWjP9XzzcRtlhF
 5KuPTF+TrcORShYbMf1dLPlHz5Q8Xb8q79iEtAibPj72a+jpazBrTqhQG6i7FD4++cBZK7gAdxm
 LQWag
X-Gm-Gg: Acq92OEYV5COQ6m8rP1s4dmusp4XDG40u63bQIivEv2W9TUfsjiNU2oe3ELkF5fwIzF
 irxkkFAGESykvljnzvawyEl9rVb7ePtuEBZBwhO0tCeyz+KD8x0ZOVmff6rC9ed7LyWl/tDz+Jr
 wIpVzwps0GuiDseoR5uEfSVjRMCq0PY35d6u0aKtv2vcKSCNdOEMEvFseE69soyXjDx9oX+U4wz
 tmPNzjTQD6ZnRx3mp47ZdhsafKJYztG+AVcOJ5cE3tOtPihq3IdPF6sdSi6ayPzAvPp2Ok2SCUX
 lK1IrOKF1kvZfb8+robsLH/GCtRCp7svcsbwZ9xzvKewq+GMDTUHs3HybVRs1qdtWIWAkz69hNb
 /UuHcQsCh8WIrqkZiN337sI5HtXY7kX5VOD8HfH0GP4TDnMW3HoySIPk45YP/xih4iQm6JG5C53
 3UvvJfvoOK/To6AKBNVsRcURigPRCYbbX2emGg8Adk7bpv6nGrPD9Y/j/iJQwYKz8H/80BFRf8U
 9jl+s7Fig==
X-Received: by 2002:a05:6820:f08:b0:696:77e2:a78 with SMTP id
 006d021491bc7-69998cc228bmr11846458eaf.23.1778429477575; 
 Sun, 10 May 2026 09:11:17 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25e0e79asm4416670eaf.14.2026.05.10.09.11.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:11:17 -0700 (PDT)
Message-ID: <bda0434c-131d-4705-b866-f2eb6b2c9ae8@linaro.org>
Date: Sun, 10 May 2026 11:11:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/32] target/mips: add Octeon LWUX instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-10-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-10-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
> LWUX performs an indexed unsigned word load from base + index and
> zero-extends the result into rd.
> 
> Add the decode entry and route it through the common indexed-load
> translator with MO_UL.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split LWUX out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

