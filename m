Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E1D12D59
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQm5X-0007eF-Rf; Wed, 03 Dec 2025 07:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQm5S-0007dc-Gr
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:36:04 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQm5R-0006c7-0Z
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:36:02 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so51470585e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 04:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764765357; x=1765370157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zh5iV/E10i9DbHpIxVQxYETjkHiOrRCUk0cvdQdfiEg=;
 b=bnXikbbrktynsK4jwrPO70VENWw0vlhvQI7XaEGV4/2XIDEDljRVqYQYalLm2ueEmn
 sPz0hxZi7ShMztQzQ72/Jr9wTX1zrjD2mM/4N6dyzDG9NYKVacn89vDtPi5/b0PdN5sa
 NWEE1OYi1kbV0MNP9KwSqkWKEsyiQZWiUqWt2kHvLGj2J41/Pb5lZNxBngGvVmPqkP+b
 vueKDFZ+xMvSSpS1WQmfp4GOH6sPBZ6hH3Uct/ZcN8J6vBYJOyzzwgI4XMEMTOJhPs/9
 OA7L4oLhS73dqUodW26kkuMYnpC+HTjA0bbton0o3Qs+lOPO98IpSxoAgxk8m7VFDpJC
 alXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764765357; x=1765370157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zh5iV/E10i9DbHpIxVQxYETjkHiOrRCUk0cvdQdfiEg=;
 b=PGAnVrsJbk5A7NqIh6rKOa2BjP9FmF7j+Hj/e2h221qFq3IhQnsQslHjhRUvHl91qp
 jVBwX8d0o8s7HImgfZIrqSMyCFTClQMryCa2R9Ykce186SJ/FfhwVU0FTSCvZ1Ljtw0i
 Ukd8DyxR3M4uVRNnEGTd04tXNer/lRW81FqmCDWrCCNNICcD2tgT9MBWSR0SPv+Dz6R5
 B5dU5ctKgw0YaPUpXXKCGsDRtB1iJTtX2e67QeYUbxZQgZKaQQlWZzQrIdjd4zspE3pU
 K2ATcadUhnn6p/trfOlkwJZ099CQ4qp1puWO2sElHhf4lTZE1ImZMpMf3MMl64rgcGvL
 GxhA==
X-Gm-Message-State: AOJu0YxAcpHXL47DlC9tcrILseA1QHXpR7cRvlIOnCwQpn4e/Poq3PlY
 YoOPsMJRHljhkHTyrAX/35nXciNRrl6TgAn2QUbgO9o/vrYVRsgeuhTFo4TvKIthKJXXyrCo4hV
 pufS9ddg=
X-Gm-Gg: ASbGncuXbTB0bjSmnVIckQ2X81NvianFCH+RewkQQ9UXgg1SPtZJpCqbcniaIoVl2xW
 +D/VtLBN0ydgBFlobosY9VrAzHTmVeCh9SIV6QwTDdmhhNXLHiwceTegYWpMPBzEpJVQbmLHgYI
 4OMMsXhokaCuYtb2Ac73s7xADaBann5CSrC+AuqPATJ6spWVTEpe/RolWPOLlIgsqXM3lzsmVCQ
 bzm88ma3hwScgidTMciiv6lFvm3lvbbJZxwDlRbeERSOlY5h7ADQvwPMKP68GXVsaRG0DsuZNPx
 mdxoahSKehcJMTBozkd7vAW4gfQd8zZ12SIqbY/I0iv7+THztfYJnJ+FDCp6dZxDe5gS7tX1+CL
 IZh24tWJb/YTYAzANatiZXVw0kdHlrvzo1xfH1DnIcGaXPP1DDUDaT1MRYfCcAZAhP0z4+wHJIY
 +j5w5RaKyzirtiCBBYuGdq8jtKppBvPg15sgK6o5c22t8nOhutuZ1wEg==
X-Google-Smtp-Source: AGHT+IGSLs78NnfLrEWQ0Wq6xQ7UE1BKZ8sxwC0n6htmfLdjV2jU0nyJSWJh+Kkhsm0VIqSY1ScvLw==
X-Received: by 2002:a05:600c:4504:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-4792aef0368mr18716865e9.9.1764765357095; 
 Wed, 03 Dec 2025 04:35:57 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a310sm41449359f8f.26.2025.12.03.04.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 04:35:56 -0800 (PST)
Message-ID: <6e38b976-6dbf-43eb-ba41-ab12ce3556fb@linaro.org>
Date: Wed, 3 Dec 2025 13:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] target/arm/hvf: Break loop if guest halted vCPU
 during hv_vcpu_run()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Christian Stussak <christian.stussak@imaginary.org>, qemu-arm@nongnu.org
References: <20251202175146.20331-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251202175146.20331-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/12/25 18:51, Philippe Mathieu-Daudé wrote:
> Since commit 93ac765076a we try to call hv_vcpu_run() many times
> in a row, but we missed the guest could have halted a vCPU; if so
> we need to return to outer loop.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3230
> Fixes: 93ac765076a ("target/arm/hvf: Keep calling hv_vcpu_run() in loop")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Per https://gitlab.com/qemu-project/qemu/-/issues/3228#note_2928617511,
this doesn't work; so self-NAck.

