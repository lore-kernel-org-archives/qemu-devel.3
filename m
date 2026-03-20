Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C761098780
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZO7-0006q3-Rp; Fri, 20 Mar 2026 08:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ZO2-0006pS-JI
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:55:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ZNz-0003J3-Mf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:55:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b5bded412so1053534f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011323; x=1774616123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cjzLpWaX1RSzTF69D9WopUqnyrOvZsQaWGiSp8qfcRc=;
 b=MyCSeeCrQWHcwvOhseW+5UtgQ4OmJUwJQkaZl3pvPe39LH8tChbi0pcZsjAQqiIhrQ
 pxvts8gYF8bi9YD7B5qrfQzbyaOGRp3iGAQ5cLLSsdqjPL+GDvZTlYzzKfAWQNQumTny
 spKnFDcyVXtb5zwQZNyn/wHeUEvrxu2wDK+sNZrHl2iryzZujRCr2+cv5D8YTqWc5BGP
 NO8sz3UClSzf4NRQ4RtG5EPNnFx+H/0Fs9THqd6ANbYDBO65wNnbA1PhAEldonOyb0nW
 74nJr9aXYlPu/9+bbF5I603aLfE28od0Pk8uFJ2If5vKsqri/1eQFjpOECHDZosBCRrg
 5ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011323; x=1774616123;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjzLpWaX1RSzTF69D9WopUqnyrOvZsQaWGiSp8qfcRc=;
 b=b+s0NShcve+YhMAfXhMcLUoO0pyReNjCDkfummy1lUxfQuQkKBaQvphjatYx0WX6in
 UPun/k3OuajuJ2EdFYB6usfXzWK8j1B5S/W8UhtmbVc+WuesXOvmZuJLrx+uxOl3odB/
 SkPexxCysRrtced7NuBzx0RNCXPPH7LJQ3e8EMRjkUKUhdXc2/8waAb+6gOU8VgGps8Z
 pmtgzM8L6iEZNNlpO5HBXz0AmG55nHRpW1jq8UIpirBzHJjkCyBItEn87nrG2qwg4z64
 ZSNEcG28t/kcYLj8Y9rHIQusKhPN52PnNHTcCR0yUlWfnn+Tw7iT9ysFU6llDhoGRD7i
 et3w==
X-Gm-Message-State: AOJu0YxhiB4BlznNuG8qVp4HZnB5S8bc3jziTsoNNghUq9b3n4qT2PCL
 O/l4aXOPFOMbYy0Jh1jVVUPPXmb3Oo2qqsH0n9auV5musu/dbbs11wrZvc1uuSUc1tcPWMaIqGt
 lELOC/WU=
X-Gm-Gg: ATEYQzxrjcROwOYBpKJWWduqTKVWVUgx2OnQoon6RKiVlRvhh/vvIcZFrz/5czChzjb
 WQtdG0owcBLBzTnw0JObadCOEkkMfdwsKyAlUHy5Q0NIUqR8BBLkxTyjLgM8XNXKLpO2NiF2CzP
 gXNjiF+FY4Mmr3fxKYFUnD7MCxFg2WaWBiMVE/AJddMe5ckupA6RzBaHNtSHmL1eWp2rxg43RMy
 GhUl9ln8HQzhK7O0BWcJhY6CevQt8yvVhYiFH5cKIh8Yxk8X13G8mObnVGJsF4jTLF//4LWQe2/
 Be9NONciKUlx9LnndDYVD+f5XmADIKylB907vweR+w5ytkUS67wk+6aZPR6+FedpB/ygK3jJtyW
 Z5B9mIGh48sEiA+sj7fnQCpP35ptBzZYILGjXYCLcN1dC2WPyto0WOZkxdPB8XQlKDc1lwi7ML7
 9mRwOvEId7u6JoDXgDKtXQLpXxIdx4Vr8i42xkev5GVVH2SXGhCoNw4y5JMWQlRbpV+A==
X-Received: by 2002:a05:6000:290b:b0:439:c6d9:7fc with SMTP id
 ffacd0b85a97d-43b64264b1dmr5353488f8f.25.1774011323197; 
 Fri, 20 Mar 2026 05:55:23 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703343sm5699428f8f.19.2026.03.20.05.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 05:55:22 -0700 (PDT)
Message-ID: <fae7bc44-9b6d-4ec9-b375-845bff594d1a@linaro.org>
Date: Fri, 20 Mar 2026 13:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0?] configs/targets: Restrict the legacy
 ldst_phys() API on ARM / Aarch64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org
References: <20260319104414.66367-1-philmd@linaro.org>
 <CAFEAcA9kmZp-ExsV-8k7fZ1nsGOyvnPZQ9tD1hrCTihxy=uRpQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9kmZp-ExsV-8k7fZ1nsGOyvnPZQ9tD1hrCTihxy=uRpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 20/3/26 11:28, Peter Maydell wrote:
> On Thu, 19 Mar 2026 at 10:44, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Commit d751921cffd ("hw/arm/omap1: Remove omap_badwidth_*
>> implementations") removed the last use of the legacy ldst_phys()
>> API. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
>> hide the legacy API to the ARM / Aarch64 binaries, avoiding further
>> API uses to creep in.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   configs/targets/aarch64-softmmu.mak | 1 +
>>   configs/targets/arm-softmmu.mak     | 1 +
>>   2 files changed, 2 insertions(+)
> 
> We might as well take this now, it's pretty safe.

Thank you, appreciated!

> Applied to target-arm.next, thanks.
> 
> -- PMM


