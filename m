Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB063CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 08:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLGHR-0001Od-3G; Fri, 08 May 2026 04:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLGHH-0001MW-Ia
 for qemu-devel@nongnu.org; Fri, 08 May 2026 04:09:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLGHG-0002Ae-2u
 for qemu-devel@nongnu.org; Fri, 08 May 2026 04:09:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so19110085e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778227780; x=1778832580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1dV9Y/qSk9e1KFInLEL4RRVmF2JhLPqCaIOcrjlh/Mc=;
 b=QO3+j5EPpoKbP42ZEsDpohIv9xJXnf1qjAFw6az28zWcx64jnF5FrPu7AKyoZyhvPe
 N+Wr8qi/5cH2gjesFaOm0yoFnWHt8HLHlfv7qXbnvSw8Aazn1l5tr9d1ewb8x9K/L3Og
 mB/60erzV3bkCK6e4fQjbXru/u1n7UIPIMhr31zwAcynxjxqngp5ujGcGi/CAyUt9O9U
 vivL0gCnUCZwU0nc5BhB+3y6BMMhOuITS/Y1xD3Hl4CAJlnCZGqRI3DOPBjKVrNPRfko
 LP2aDnsgiVTtE/bMJS+0v30jhRpgBtJCsTXAe6gulTFzH3rv1dquu6ZWxQCTYeH/X/EE
 VW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778227780; x=1778832580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dV9Y/qSk9e1KFInLEL4RRVmF2JhLPqCaIOcrjlh/Mc=;
 b=iJoGr0HQZ1MXM39teOJDvnjRX1VKxrJ/exCxGEFQPuo+U2qsSbjugvTYMxdTdVckg7
 hgtyZSfaHcwVQ69JWFFBNO77m24nQODkh3H8J9Q7MlMOQ80aEGoEe5B4F8PSyZWYzOBJ
 PSExpXj5O5Mqs3dD/M/s8iqrcrBq0OzIYcDE+4tl6j7iv06HBA3a35CQ6YquHaM0W4Tr
 JBApvaY7wvwNu7TT5xT52dkHmu0jUl5QyEvW7gP5xuPIooXshZZ0Igg1vR/Wg3zW3zXX
 DIf9HKayW6OEXQ+hePDPQvTXr1p2GJTQCgNQkSLPslao5brojwflgCaTNudWiuOp8Dx/
 /Zdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2Bxy58glDmvw8FsRy2WQCejrmjtoOiih4fvIrZUExr5T/bUvQ33jZlrl8nlxmSjRsPav4R0pOpKbx@nongnu.org
X-Gm-Message-State: AOJu0Yxnsfz0YL/EMB5//qupYMJxJeLBSUHSB2CB7a8L5pjPmv1YZc2q
 gUmaJjPd588I20/a2zsP0WWP6VmSTWmY2HV33A9ZbtjLyk/Jpi/t8YmzTCsREek8IA4=
X-Gm-Gg: AeBDies1T+xLNLE965o2WSOe+Y1rAxzEaMxMu8NleIzcgkFwQsxpxq7JTdVea/9BWj6
 DnoDD6txa4uiZ0ZL+MS/iqmZHkizVBFADVM9j7fZQBsbpbMaLNmO4oEQVzQYyupx+hXYlf23jz8
 umSJQPWR+mV+soHmV5GhqElam8VJUaRxc39lkA8r4Yv0lyp9JDC2epfKOze0YLkCVe3lKfoaMhB
 to/ex/WJIZ2T6njRhStK5W/yRH3bSl8+fY7Upmrt7T2JvN34to4VUKBe7/RpB1PBdSXI7r6GERe
 fx4PFZtCShp7wMuF/7PO13lYmqCrHQWcHqkZWQiHd+/Zi6IdTKRsnTCeizErg8ZjcqHKOMkq2mj
 4gyu8owlTa5bettU/yd7qCJqku7QJEsuLO4k9RezFzu4YLSZUsbbwt93BwCKT9GNXEsdRSnY7X2
 l0I3TswFaYhmQucRPjcyiOTnd0pfl/IeKmokOX7tDjwvCtjp5MPnxqsgZylOGMu8Op3N6rap51Q
 pRc0hFP9QoN6Q==
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48e51f4652fmr187013875e9.29.1778227780445; 
 Fri, 08 May 2026 01:09:40 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68ed0f29sm35247795e9.2.2026.05.08.01.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 01:09:39 -0700 (PDT)
Message-ID: <62ae7f9a-bd76-4748-ad35-646959eb2b24@linaro.org>
Date: Fri, 8 May 2026 10:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tests/functional/test_kvm.py: Skip if virtualization
 not supported
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507194728.2034696-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/5/26 21:47, Peter Maydell wrote:
> The test_kvm test runs the virt board with virtualization=on,
> which will fail if run with an accelerator that doesn't
> support nested virtualization. Catch the VMLaunchFailure
> exception and skip the test if startup failed because
> the accelerator can't support virtualization.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_kvm.py | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

