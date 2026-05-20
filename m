Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E36BCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkVM-0000Fl-Ek; Wed, 20 May 2026 13:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkVJ-0000FF-Oc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:14:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkVH-00013h-Vi
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:14:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso2477569f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297281; x=1779902081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T/o3jUfNAg4UU+hbdQIUcxK3NzNlALFbhTUeVflbY1Q=;
 b=CjLaWvBuIbafn878XgCDdZHdbwf8jMvKLrCgj4kkGSSmbbCSK3kexV9iBADPMKAWCq
 XxRTO9lVqoboG7jcnAFm9fcJVUvpwmQec5VoeopIdQbjCEcr5rFg5aj5sWkN3adPl6yQ
 MB3EgjsN/uzey3hTAC356RcF4iKnpdAkTpyOee2psZV4G2lzuIfk0ahBxdRJvLcJ5bZv
 GtELkLA1IhWZoMZXAIwm1QI0U9gqb7NWQ7nKBQQ7asfL2FHPhe8fJkapiyoPwriQrd9I
 ahpdcHUHn85dQbkxXbVyNQrt1kn9F0tHt5srN00L0JAhQjoWpuesDbigQgd6K3GqQoMs
 B0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297281; x=1779902081;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T/o3jUfNAg4UU+hbdQIUcxK3NzNlALFbhTUeVflbY1Q=;
 b=SDha1AAtoBcQUU+Q5uF5TxUSDEV+S7jKZEmCrp9rIQ2N/npKX9+YFRrwSq+PRmMQjf
 dy5utBgTuYeFvK5yv98mNU0qPsVyzn4xRY+m50apNZ16V4/mlP3SdzXFWBtZqRrTTH9Z
 fxGMRKyfoGxv3TpZK3qNQ3fACK7aqOZ76leATzAxCfwW/zXsEyR5uWYshAdCSlYHjalp
 onpmWGEcly5jQu3FcxThk68LfprnDc9z6jVlPDDC/+c9z3spQZapSOxm4yB53O1E/fM6
 b1YtoBqvccNzC/iQlPqVwR5nfRoE1KtnZwF8AnwnMwLnMWlqvtNsempiyLfAjHxbQitI
 960Q==
X-Gm-Message-State: AOJu0YwMaeq9qRG+6m71ttAP+ndgH7OuNZbeuxzNZFu9mDdXcb3wZ5bQ
 kqTOPSTS1AS7vzSEzMrR8afJGgGyESBCLunHCNFW7LAWiH1h9BlCcNkbVf+1kM4Es+E=
X-Gm-Gg: Acq92OFf6ApKO9VBghjRW4LtuNsYPXalHDY4XG2xMgiLKIlmFiDi7ZcYD5C633DrmdU
 7la51LAEUM6dCnTzrbbmH/zw0JOWMwZfpuhL6VSPEZRU1gXRYWXg/GWDGCMKzF79Na42IDq2z67
 XZmd736kHnYCmZWw4VbI3dyOisUIqlusviDJPVB+/mQ4E8OQktUYoQ0RB3Xk1X1543+ibEEPXRq
 tqR7gc3ASGS55R4jveQ6H9Q0hU/glw932GaIY+h8e8Po8bdNhrLVOlEbTBWF0xu13CQTCJGAHG5
 v3d/J/5JRM+33KzxqHWi9eMyDz939ZjpU9nFm7ny2EwlUXb5FV9289hJvFb5cTAdeFtJyiuW4UL
 q3/IDsDwK0J85Y5mrg9mGn8sXIqlk5z7OcsoIikPIxHvZkXEwFs3JOwuXafRzRIa2Pj/WV/Uidz
 DkrExY2D08YzNNee2S7tLCJJCo9d4iI4dJSaOAPbSQu6rTMFQt1/u2chaEX2BwLWGCsA==
X-Received: by 2002:a05:6000:c3:b0:45e:739e:499 with SMTP id
 ffacd0b85a97d-45e739e04dfmr21518431f8f.13.1779297281426; 
 Wed, 20 May 2026 10:14:41 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm51081192f8f.26.2026.05.20.10.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:14:37 -0700 (PDT)
Message-ID: <2e3da33f-1f47-4d7b-92bd-886c827a0f2e@linaro.org>
Date: Wed, 20 May 2026 19:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 39/63] hw/display: Add i.MX6UL LCDIF device model
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Yucai Liu <1486344514@qq.com>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
 <20260427124738.966578-40-peter.maydell@linaro.org>
 <574480d1-49db-4ee9-981c-580d4c2db3b1@linaro.org>
 <CAFEAcA8SN=H+d1OzcRWBZ6kBnhFqVAY0_77Z+PsjdxwAnT4gEw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8SN=H+d1OzcRWBZ6kBnhFqVAY0_77Z+PsjdxwAnT4gEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 20/5/26 18:45, Peter Maydell wrote:
> On Wed, 20 May 2026 at 17:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Yucai,
>>
>> On 27/4/26 14:47, Peter Maydell wrote:
>>> +static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    dc->realize = imx6ul_lcdif_realize;
>>> +    dc->unrealize = imx6ul_lcdif_unrealize;
>>> +    dc->vmsd = &vmstate_imx6ul_lcdif;
>>> +    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);
>>
>> Please do not use the legacy API. See for example this commit
>> to convert to the newer API:
>> https://gitlab.com/qemu-project/qemu/-/commit/ce788d3740f
> 
> There's not really a problem with continuing to use the legacy
> reset API for this kind of "leaf class" device. It has identical
> semantics to just providing a 3-phase "hold" reset method, the
> compatibility-code is trivial and not a big maintenance burden,
> and we're unlikely to convert all 400+ existing users. (Unless
> somebody figures out a Coccinelle script for it, in which case
> it's just one more file being autoconverted. IIRC the hitch
> I ran into was that you need to determine whether the reset
> function is called by any other code -- those are probably
> not autoconvertible in the way "function only used as the
> argument to device_class_legacy_reset()" could be.)

Then I don't understand why we named it "legacy". Maybe rename
as device_class_set_leaf_reset()...

This is not about converting the 400 uses; I'd expect a legacy
API to not be re-introduced over and over.

What about gating this call via checkpatch.pl?

