Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A131C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhvLe-0005KN-5f; Wed, 06 Mar 2024 12:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhvLb-0005J6-4w
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:46:32 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhvLZ-00059d-GV
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:46:30 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so6134491a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709747185; x=1710351985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jdiF6Khfm7DJ+HdpPSeSbbB+fRUiK0n45qrYXEUM/ek=;
 b=o2eVpn7tl3i8cDMjgiSr/Jwfr10XwtxaT39HJnI32HN/Ab2cB6NCchsaweTfRl0roU
 C9KFFH1FL2PmYMi4mR3XSHQpN6M4n3BeO4WF8GAPywCb7AlYWgFXbNQM5AOIYELJqRrf
 SNfEC74QY8YBm/gjq8AgYrCbrRnW2xgBpyHmuV9VUdQKKvwOnI0bMhfbbq9WwMiWonTY
 H3ZjthDXWlN0azkwEtkYsEG/aB2zPOUBczoe+NN3Ckg7bLW66deoHepyPzBxddw56CfS
 yn1fdFzyzrc1nYVTVKWGKP0jLIemOTCj7VxnJwByYyrpCUK8RIm16O+Q5pG4uBIk5z58
 i44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709747185; x=1710351985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdiF6Khfm7DJ+HdpPSeSbbB+fRUiK0n45qrYXEUM/ek=;
 b=GzLsJP2Q8VuCoS5CeLcTZ0fG4yPwhpc2ZUJsNAg3OFbWf/rkSwwYtRFdNM3cV7dRy5
 O8sl7+j9gKM4kHQM3uCwO+JP4SsA+DspXMhGBzwuZxiD2ISoN/cnNYgZsHNuZaCR96oW
 XIV74xs/56nkIcFxQFT3jdORuUGnrOc4EgWsWK3oXl+cNAmZ/u1fV4bA6z70qGMDLgi6
 NQXEseWRnsucZIPg7OwNuhNeRcLwB/AYLp4zMj7HrVJq2oqU09U4vUb4LuJ0a66tn+2E
 cAVp9WZHT9Vpx6KrcCmxFXyPHdhxQqnQSgSUjgmMOM8jYx3meW1i7xvFDXuB+kqVxRCe
 ixDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzmsQPtFXrYRoSTzjiHPuk9FLs1nCesxNP1445Y05pHD08hOXk0l8rDosTv32u7ANB77P4cl97seDVVg9SmCRSNqcU9R4=
X-Gm-Message-State: AOJu0Yz9FmyfciEHJNt4RYnSCAYZNVstv+UibFZewKhAc2LecejhB8Z4
 asTtXYII0bQlxjzl2zFONjNREYIGISPBf8TKhhfLb4CVAB5oRUoPGOmDxtoqzVrKz3t8wAP6vBf
 9
X-Google-Smtp-Source: AGHT+IFLKe0GzWXyvuF6n8XM0t6gT/acxDlevWmsarbbb/ifLpQ3yn73mGiTEBHzW/LannU7yez+iA==
X-Received: by 2002:a17:90a:c506:b0:29a:3c13:70ba with SMTP id
 k6-20020a17090ac50600b0029a3c1370bamr12166137pjt.25.1709747185558; 
 Wed, 06 Mar 2024 09:46:25 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 6-20020a17090a0cc600b0029a4089fbf0sm12986573pjt.16.2024.03.06.09.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 09:46:25 -0800 (PST)
Message-ID: <360dcf15-6325-484b-90ec-7cc5262c8ec1@linaro.org>
Date: Wed, 6 Mar 2024 07:46:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
To: maobibo <maobibo@loongson.cn>, lixianglai <lixianglai@loongson.cn>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 zhaotianrui@loongson.cn, Huacai Chen <chenhuacai@kernel.org>
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
 <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
 <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
 <dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org>
 <5325b63b-2a51-8448-bf70-c0659497db61@loongson.cn>
 <fa6b408c-43fd-4011-b704-ac7ae256fcbf@linaro.org>
 <051240a2-4c9d-94f9-32f0-daa399b48a8e@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <051240a2-4c9d-94f9-32f0-daa399b48a8e@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/5/24 21:38, maobibo wrote:
> Sorry, manual is updated already and we do not notice that still.
> 
> https://www.loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf
> 
> It is Chinese web link, English manual is not updated. Here is English translation by 
> manual with instruction  "lddir rd, rj, level"
> 
> If the bit[14:13] of the register rj is not equal to 0 and its bit[6] is 1, the value of 
> the register rj is a marked as HugePage page entries. In this case, the value from 
> register rj is written directly to register rd.
> 
> If the bit[14:13] of the register rj is equal to 0 and its bit[6] is 1, the value of the 
> register rj is an Hugepage table entry. In this case, replace the bit[14:13] of the 
> register RJ value with level[1:0], the val is written to the register rd.
> 
> If the bit[6] bit of register rj is 0, the value of the universal register rj is the page 
> table entry, it is  physical address base page table. In this case, if the LDDIR command 
> is executed, the address will be refilled according to the TLB currently processed. 
> Retrieve the base address of the next-level page table and write it to the common register 
> rd.
> 
> We will remove temporary lddir_ps, and record page size with bit[14:13] in next version.

Excellent, thank you for that translation.


r~

