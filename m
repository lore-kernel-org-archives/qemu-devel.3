Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D014C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIeT-0001Na-N7; Thu, 20 Jun 2024 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKIeR-0001N2-Pt
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:20:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKIeP-0004iB-Nz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:20:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4230366ad7bso11496315e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718893232; x=1719498032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVya9DJzD9bylNtCQPe8SLuSJyriwTot/7zJT0BCCqw=;
 b=ylOuzOM08MmY+DL6gPdsOjmGdG3ELZx6p09KyHLRGSPG7Cc2313d9BotD+KMfhfVfz
 N85Cd2NWy99GoQW5Xe08gled1YTFZToMWw+w4wHuWK91RrD9iUYvUWIQQKYuspnmBwew
 DXReC4TZz8SOdF+Vh/hmbN/3E3i2fIYZPnBM5TEv5WXSw9l2BHOmE6rIklnFPg/8YW1w
 mavSxFB2ASWPJsejX//dn6r0nRT50NzQZGAeH3s75qNjOsgP2KO6p6iQkLJsk0yjWfuN
 vynBXM/0/JVBtD+gN2g8xyZ4xFnpnc9veUy+1RWj7aJ4Q98ac9zyp+2zqivupbv8EmJm
 pJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718893232; x=1719498032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVya9DJzD9bylNtCQPe8SLuSJyriwTot/7zJT0BCCqw=;
 b=jibfzqw/WzJKVInGaAeoxBdzcWY+vrsFI577y0PIIlh6O1tiLGZQtXT15vuXs/n62z
 sLOgN0ZXT4YBfWHs2yrzknGkTtlXYwiFaYPe6HqiA/80y4DZ8zQqWNbMZ5K8p4eSRSTw
 uJoSvfTRp1yS3K8nIXiw0lTXMLImhrg3Be1T3lAUl9F7rMoJYyOJI4i5DHPm1xM+TmXp
 gqreO4pbwALO29BrpfXNmXSGt4ysNFaaInHEOdCMKXhNNB59w3pWJfHvHuZNalxmBhrn
 xEk5NRyUHIS2/Dz3ZKxrLsgdx9QUT2lgWWoMi+3K65xhyQjhZ4JS2GrvqdMT7HasZksZ
 iaZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEHYfuLDs58S8uI9ywa9c6CMckBNQNsA2U9EM7xXwUaNn7XD1s02Sjn6JCrEJP+psqKXbsjAJDk5hp6UdiAiT6jkpgwuc=
X-Gm-Message-State: AOJu0YxAMrSVNBmD3V3QK6K59JsXMLkqTGo3TprSAEBUwhYgOmaUAaW4
 TT3SOxK/kNM1mdS8wtmoeZWEyQwqOVYJXBz648Vc6F8MtbfFqxqhOPRUcU8y6ww=
X-Google-Smtp-Source: AGHT+IHvClICaEuWpyEVswbnlv7IVc2ONawWuxzeM8RqIH2i8zjDcCOoNvvSkWNj+e75wu63aX7GhQ==
X-Received: by 2002:a5d:444f:0:b0:35f:1ed7:f1fd with SMTP id
 ffacd0b85a97d-363175b8fb7mr4542885f8f.19.1718893232055; 
 Thu, 20 Jun 2024 07:20:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-364774423d5sm2453703f8f.70.2024.06.20.07.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 07:20:30 -0700 (PDT)
Message-ID: <6a817f44-27fe-432a-8118-bbcec790535f@linaro.org>
Date: Thu, 20 Jun 2024 16:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/gpio/aspeed: Add reg_table_count to AspeedGPIOClass
To: Zheyu Ma <zheyuma97@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240620140239.375338-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620140239.375338-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/6/24 16:02, Zheyu Ma wrote:
> ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
> function. This issue occurred when reading beyond the bounds of the
> reg_table.
> 
> To enhance the safety and maintainability of the Aspeed GPIO code, this commit
> introduces a reg_table_count member to the AspeedGPIOClass structure. This
> change ensures that the size of the GPIO register table is explicitly tracked
> and initialized, reducing the risk of errors if new register tables are
> introduced in the future.
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=qtest, -m 512M -machine ast1030-evb -qtest stdio
> readq 0x7e780272
> EOF
> 
> ASAN log indicating the issue:
> ==2602930==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
> READ of size 2 at 0x55a5da29e128 thread T0
>      #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
>      #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:11
>      #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
>      #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:1426:16
>      #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459:9
>      #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:2836:18
>      #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
>      #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v4:
> - Change the variable name to 'reg_table_count'
> - Change the 'reg_table_count' type to unsigned

Thanks,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Changes in v3:
> - Add the reproducer
> ---
>   hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
>   include/hw/gpio/aspeed_gpio.h |  1 +
>   2 files changed, 18 insertions(+)


