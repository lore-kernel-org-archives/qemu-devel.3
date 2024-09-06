Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB431CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smXLY-0001RK-An; Fri, 06 Sep 2024 07:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smXL5-0000HS-3X
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 07:41:25 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smXL0-0004w9-Ub
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 07:41:17 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so25956901fa.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725622872; x=1726227672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gGKs7C9mcSQcGwX3xGGulcF7nGyBOSbrr4Eqg9oP/1A=;
 b=i5nOfVX2YBKfg7wCTa67OICEPC5rzVJK3R35Cqke3BPg4afCCJtOLloHGsrZpUJr0y
 CPFmmdPNDSfaQEB7/ari4EiOQ+xh+4gzQdalr4ZhJK/uqZn+F6VSfTsoCktg/uzEUrv5
 rlsiH4SzKiA3zgnqURmXaEIvxGpBv93zzFgUqJytGKuEFIaih3tBU5SlHSQsAmw0ovP1
 PXY+/OnqWdm9MrlXEGJ2OPa9T6pzgDGMbwAP4LosVvA0eHY5xExZp/+/e9XfVxo0W988
 V2QDZma5gjGDP647XLOysgsV70KukjtGwc5YZezTrRIe+hZ78S7UJQ1Pu9IAYPQ7SP0s
 FNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725622872; x=1726227672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gGKs7C9mcSQcGwX3xGGulcF7nGyBOSbrr4Eqg9oP/1A=;
 b=JpHbbj+tzxTl+2KTdIgZgkwezXL3JQ/JYRvIp9DLZ9/ymhBwoBZ/UMhAKWW0NZ0g5a
 DyDcl84lMKK1TAiFNfCf8llFJkb5BdiWFvsjPhcBhOTv56rY6OUK/yP3mH2AMoZhliVE
 Tni6+4UdXJtASd+u/D9L8sbIdrHxfUl10NXDdCOy7njvR0hIDnCWC9nncGM4egD3dc1I
 EUczt1dq49x7djvt5/DUPw62Rb0VKifomvzn/Jk8rzCRH3s8oJiaHhby4F5/RWkqF3gd
 sKRdvaLWUMmOs6KBwGN4jHdoUu4UXU/+TCkrDKKQo1Pf2Xu5SaCBp06wkDNBi3YIpZKX
 bV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmmw2m6AfnrR3NTAZc8QhjqD7vIthGpWOPmogdjBAq19zowQE/4LtjgulRzKTQFVtR8TrS8KLO79Sf@nongnu.org
X-Gm-Message-State: AOJu0YwpasLGz/oF8R2MD2JNFFLYGNlZ15TA3jz3Rx7Y/YBjk/V0rD4E
 ol7gO2NvTYnw+k8iuzD8C9AuLri2Osfu6jJCxO2/iTRcb/6O7N7Wvwy2OgwVeck=
X-Google-Smtp-Source: AGHT+IHgqzH0S6PmQluD4eRTlb1tvmnPc8Y5EaMd8d4Ee/8jic4xSN75lSiH2WBTLfCMIwiL9J7jDw==
X-Received: by 2002:a05:6512:1149:b0:533:324a:9df6 with SMTP id
 2adb3069b0e04-536587ba955mr1925043e87.29.1725622872199; 
 Fri, 06 Sep 2024 04:41:12 -0700 (PDT)
Received: from [192.168.55.118] ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a72490a33sm203899166b.192.2024.09.06.04.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 04:41:11 -0700 (PDT)
Message-ID: <e6093a09-078d-4412-85d6-8727477ddf40@linaro.org>
Date: Fri, 6 Sep 2024 13:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/sh4: Remove the deprecated SHIX machine
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Magnus Damm <magnus.damm@gmail.com>,
 qemu-block@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20240903153959.18392-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903153959.18392-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 3/9/24 17:39, Philippe Mathieu-Daudé wrote:
> Remove the deprecated SH4 SHIX machine, along
> with the TC58128 NAND EEPROM.
> 
> Philippe Mathieu-Daudé (3):
>    hw/sh4: Remove the deprecated SHIX machine
>    hw/block: Remove TC58128 NAND EEPROM
>    hw/sh4: Remove sh7750_register_io_device() helper

Series queued, thanks.

