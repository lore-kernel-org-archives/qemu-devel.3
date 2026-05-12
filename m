Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB3BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkhu-0003rn-PN; Tue, 12 May 2026 06:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkht-0003rJ-Ad
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:51:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkhr-0000YC-V5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:51:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso37814765e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778583078; x=1779187878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPbG27XBlYc6lQH65/69OCmIYvEee6QUFCLVhoOLQVQ=;
 b=Avuoa0WR2prtr2MVaRP5A8kNgUH+ERFNFbgjQ8XweG+EQZf6IOZO9/q8ufFlMooCSe
 6oZX+mktJPy5UoUjG2GrZWcvrye033reRHb8/iH6Z6dCG2NNaTpX+OxsnkSfFc1DkQq+
 JB/fOAHtb45lGzA8+78G5upj4wHoyhLxKpSW1CYmGfnrl0+PsLH5d/qrhkrBzTlFyytv
 gaBald585tQJK1/O+5q7P70OBrTPrdo9szgL4ZkJKBXT/3c9Vh6gwV9OjR9Q4u0wkmQQ
 qMgXS1ZkuYZDQNPLuKxr4ckc8M+lcFrm0I2inFe8dmqeHVivC4PfkT4uSAfqPwkc8heq
 PZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778583078; x=1779187878;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPbG27XBlYc6lQH65/69OCmIYvEee6QUFCLVhoOLQVQ=;
 b=qcr89fqBZlBc8Tn3HdJPu6HMkUjOM+QJ8Xd+xSlHpuagjQdNcdIr0Z0W4z0aITJbDL
 vhUvmcXWzKWQOChNX01112EDhyVwCxfLGYUfQT1+Nw9n+g1H3O4ObLtdpLU79cLx0m5s
 CFmlV6Pi1ycHmoKhZaA3w+JagP9behUscuuyQhhcTqeT0Rjpia0a4XZN4GJT0kyphta+
 Ib6OaqqdyM2orV80OWJfe0VglV0KjN7SgI2cj+NuTXe5Zj8UThWaNoqTmmzWA848zvPF
 OABiSN40pXtfo237qBMSzl7GsNxjp0HKkGs310sRn9cnKnPdbgdMjj+2PMFRz7aCh1c4
 M36g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oqPTksp9iEJ3PcFJvfYMzw7TeX6E3n0S55BGt6RtSbIg5CF9PLOhA+ZVm7GwmQ8r/0hadWIJhV0c5@nongnu.org
X-Gm-Message-State: AOJu0YyhGn5iC0oRhkT9yZ1IrtIR4+7uujbonUSUhh643lIQYTw9zp4h
 Ci+QQwQLXyqxQMBmpf5W7oAla1PfjoPZ90kJE2T2lTiV4midwyzFYxEYHRwLBGKd0Go=
X-Gm-Gg: Acq92OHve/P3/ihMoTqJNz62oZ+S0lFxUG3uaNzqIWc52V9+CZwTpVwBbeRZH/M5l5I
 mv0Of3e0aw+gRhxx4hh+XGSWsAdkq/fZiI+E140RqolsnClV0VRWp8azu9rCViR7MBPTWodhzzq
 SMvxRvePy53amqJ0y5deiyTFXe+RQAnecxvviK85ldQcPAeBceYKwRzZbzwWeDIXVQJBc1rdq5/
 8OK+dsrXg/08woJSVfFdl/ZW0LH1dq2mx8G7pxYoaXSyvBhMjqoipEczbBLft1j2IK9VfMWlFqZ
 tuSk6EnYhhGfDiVOIzKAR7dbwqUcJjg4JHiTdhEez/zSNBdLhZTaq6yQh+6mKZeEXYrb93qxpmF
 sdY7vOZn/mbqt6l6jHvA8Q1SKpIE/9Prw73n6GdaqMqp7VL01PuPe6NvZOEbZ+AFMpmFT8KeGT5
 6kS71DfsBZE02H7lrUjipJ5pNgtcaZOv31yhMS1CQQmvgUnDtiSeTAVEyBqg0tS1hCqw==
X-Received: by 2002:a05:600c:a30d:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-48e6748a72fmr191586555e9.1.1778583078128; 
 Tue, 12 May 2026 03:51:18 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e90536e18sm37357905e9.5.2026.05.12.03.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:51:17 -0700 (PDT)
Message-ID: <ea9a6a72-5ffa-46a1-b200-0c7c26944019@linaro.org>
Date: Tue, 12 May 2026 12:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/arm: GICv5 cpuif: Don't set HPPIV bit in
 GICv5PendingIrq::intid
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
 <20260512093856.3197700-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512093856.3197700-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/5/26 11:38, Peter Maydell wrote:
> In gic_hppi() we return the current highest priority pending
> interrupt in a GICv5PendingIrq struct.  We try to set up the intid
> field of that struct to be the form that is used by the ICC_HPPIR
> register, which has a "valid" bit in bit 33.  Unfortunately the
> GICv5PendingIrq defines the intid field as a uint32_t, so Coverity
> points out that the bit doesn't actually fit.  Move the handling of
> the valid bit to the callsite, and make this function report "no
> pending interrupt" with GICv5PendingIrq::prio == PRIO_IDLE,
> consistently with how we use this struct in other places.
> 
> CID: 1659594
> Fixes: 9edad4ff3 ("target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/intc/arm_gicv5_types.h |  2 ++
>   target/arm/tcg/gicv5-cpuif.c      | 18 ++++++++++--------
>   2 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

