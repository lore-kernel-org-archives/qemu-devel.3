Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3341C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thS6M-0003k0-VQ; Mon, 10 Feb 2025 06:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thS6F-0003ip-42
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:37:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thS6C-0006Ub-1l
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:37:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so9403345e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 03:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739187430; x=1739792230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RN/vf2D5uoh3+AiogtIrutrregsm07h+kKt7qZIMtqM=;
 b=up68mx+vw2TilP1XdBbKC9MVNe1uQkwBSun/qH5BrcC8t1YvL211pe2hzaW+QtzxB2
 DVxSz1wRF4a1emycRQcaOaDD8drgxmbkcq58mFEEqkpgmy1mBRk7I/M0kn0XtnErtmYk
 P5Leet7jPDA46DQZYyMyB8BmLV8xE6uy2hn0R9lBvSURSZsZcgXyGhYywpOtNJwsbCH6
 hnPCH8fscLcurXC+WzhIKttrWQh6jEJnHm+xnL0khIX6qtIgYKRlCtrUR1UODArJCOgW
 3e1gUJwsuRQHyJqPaVwWEDueb3yaSOdO5/KREBLVH1sDPKPOpZ7aOuWFsanoKlp4rSbt
 6qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739187430; x=1739792230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RN/vf2D5uoh3+AiogtIrutrregsm07h+kKt7qZIMtqM=;
 b=JjlLyMV5tF+fxrlDvgqWpdT8yQla2K5GlFcjHkz7Kni9IbKrEXFIaT04biaZ2GpZzS
 dby8KAG/nX/iwrz4k6mw1IEFVuaU1sCNRtTjmPhSTqOyo7oGHqvldTk+CpHg9V6Udher
 eJ5gXlPA7dEEEa4fu6XGcgp06CDt2hShgmaBHGSKCLWM1Db1avDUKed4pRZnaIlPy05w
 sEBzBSPIn9haMAviv/lr/TMSu+ML8HX3/lNVs+RIizI1GncN1cWTTRjeZ6oJCPur9d/I
 0VViZbj0a9OFJ2pb3knSjcotRPCzbZeAZUu4rFHqOihOQSnyu9bfTOQqr7NdPaB7xicK
 I9ZA==
X-Gm-Message-State: AOJu0YzRCoMeuLoobGE8RL5RhiOgRcKd9X+uaymmTDXpvBj841/wtbdK
 mxS6zlYCbyxkhqolsd7cs+l3VeD0yoEba/Y2swMBdIVpFqRiM58ziPKVVfqGxBQ=
X-Gm-Gg: ASbGncug9Cy3xYngGkFRm+SZtTBpgZJQHZcfwKiw3pHV3WzYqPHzhV6VorTKxvh2utB
 U1BJF5VdInITFHwiVGaYXUFOF83GOP3pZ46DKvovRzC49wbXKPXJy7Olw5RJu6e6M2pONh7xNSb
 zjayfUM7W8DW18zxgXb/47dJ8GseajRRaVUua2z4yKuT4KHg8JZS2qJOtxyptzISp/waIxdT5+y
 cSTghqxPDCW/HZZvfBGogheSDe5eicMr0QyJ87v67dXe1Ryo95U8tok+LyFfekGhsXPZt46PoX5
 gJCwPtn2wgTp74qunYC1Q0auDSFvYpCkIZZ93jpxvCCsCHUdZ9bfLXPVmyXr3kg4
X-Google-Smtp-Source: AGHT+IEIVHMsbfiXPWmdSlKnEQhUoLcXCaMnD0GG5CmRiglhfE5Vq1gdWhLuRPGskC3iQt1au0MeFg==
X-Received: by 2002:a05:600c:1912:b0:439:45e2:897f with SMTP id
 5b1f17b1804b1-43945e28bdemr27093255e9.11.1739187429834; 
 Mon, 10 Feb 2025 03:37:09 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4480sm178211865e9.27.2025.02.10.03.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 03:37:09 -0800 (PST)
Message-ID: <15242afe-5b94-4816-9d01-a24cdfc556de@linaro.org>
Date: Mon, 10 Feb 2025 12:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/mips/boston: Support dumpdtb monitor commands
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-5-peter.maydell@linaro.org>
 <fd7e874a-9cb1-4b41-ad89-d9c34d9def5f@linaro.org>
 <CAFEAcA-NQs+AuLK7Gu_AFfLQLgsxZHEy=H+LiwSJKimx0P1cXQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-NQs+AuLK7Gu_AFfLQLgsxZHEy=H+LiwSJKimx0P1cXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/2/25 12:09, Peter Maydell wrote:
> On Mon, 10 Feb 2025 at 10:56, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 6/2/25 16:12, Peter Maydell wrote:
>>> -int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque);
>>> +/**
>>> + * load_fit: load a FIT format image
>>> + * @ldr: structure defining board specific properties and hooks
>>> + * @filename: image to load
>>> + * @pfdt: pointer to update with address of FDT blob
>>
>> It is not clear this field is optional or mandatory.
>>
>> Looking at other docstrings, optional is not always precised,
>> and code often consider optional if not precised. Mandatory is
>> mentioned explicitly.
> 
> I did go back and forth while I was writing this on whether to
> make it optional or not (and the versions where it is optional,
> I had a note in the documentation about that). But there is exactly
> one caller of this function, and that callsite wants to pass a
> non-NULL pointer, so I ended up deciding that it was pointless
> to make the argument optional and include the code to handle
> "pfdt is NULL".
> 
> If you get it wrong you'll find out very quickly because your
> code will segfault :-)
> 
> Generally we (should) say arguments are optional when they're
> optional; in those cases we also should document what the behaviour
> when they're omitted is. So I think "mandatory" is the default.
> In this function, ldr and filename also are mandatory. If
> we mark every mandatory argument as "mandatory" then we will
> end up with a lot of boilerplate markup for most arguments,
> I think.

OK, fine as is then!

> 
>> Could you update the documentation? Otherwise consider adding
>> a non-NULL check.
>>
>> Either ways:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> thanks
> -- PMM


