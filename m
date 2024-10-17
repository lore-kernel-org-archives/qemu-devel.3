Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C901D3C533
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 22:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Z43-0001RC-8Q; Thu, 17 Oct 2024 18:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t1Z40-0001NL-QD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 18:33:48 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t1Z3y-0001ud-45
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 18:33:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea79711fd4so1055252a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729204425; x=1729809225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Czuq5TZLUM6h/fTZNMGw9xt2q/K9IRxXHkX5gz7HDEA=;
 b=MMPoMFKz8PuipWasOqNmzyXEmWk7UKs/3OtXgmZGMfzZTHqN7CxHVNndgBifxUMRnB
 Vd0BJ2qOrYcajS0BnJoftQEx2pkqVwIuhNqvtRYZQLpauMVqpoFa9xG6loXrIuzmNZbc
 EPL/8kk//p7kZVRhvAJK5PTyR9To0WzKvNhxP60s78AjgTWIc6PM81zzfwiYljZD7OEm
 fGa8Ev1i0U9OzBWHE43UQOH+QD0DD/O3MNb+1G657WuNrCnfPI9jYPxRPtOhuA2kPW8I
 wIzdlBap8GbM/bbEXGOCZ/oIycTWWGxg7GIKO3cz4apwjRyLSX4QL894O5GiOfEq1JHV
 Y1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729204425; x=1729809225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Czuq5TZLUM6h/fTZNMGw9xt2q/K9IRxXHkX5gz7HDEA=;
 b=ZspxSblK/COROyKzPtwSbT7eqAH24y0zbdUKmwN5BG8Evs4L0jV1IZtjAScqd8qvbq
 uIR//3Yovo6VNQTDiy7ZqmCyZrLxdLaQHd3jtp4qNTc5E1IvwokWr7Imw2wEsmnWvp2P
 D5h4EZATb4ZFKi/uDBKBo3RF/0uaLnJu5lplfuZRWeMXjJg5c6YDsARAPcKpONgjJkjO
 YeGuZF2hUq89NRPyug3IyFwS9mC7ugTUP35peaqZimYJRL5WO6Aq0jTD3V7UNZW7JYEt
 qEl1nUtGA5oOaeo5eZ7+ppphsjEpREq1DMNfapyrH3CjTzheTFXSKjmck+SOoBLZNmvH
 9uUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwqGti221BsqSqDm0QVFURJjBThdDkPdf2iofekgAxBVXL8aX+wR8OmA1gRLluS5xroqO2nwXJLI2j@nongnu.org
X-Gm-Message-State: AOJu0YyBIpMHmSypIpGBjdePUmzstP8aa/ANP86sGnzUjNyW6S3rhGf1
 ZHje7c4qQvPLPLvwSO1nHKlh7HrbmulxlcIJxcqiLzjfVzFRIkO1sF0CrXt9rUU=
X-Google-Smtp-Source: AGHT+IGaf6ZBGyRUBI33IIIAt/eeiwxdUlH2Q1yChewHDfCw1COc1vWuF9rH9PebTTq9FcbbgXpG/A==
X-Received: by 2002:a05:6a21:58d:b0:1d9:29fe:1de0 with SMTP id
 adf61e73a8af0-1d92c5ae136mr447469637.50.1729204424685; 
 Thu, 17 Oct 2024 15:33:44 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eacc25249esm118600a12.55.2024.10.17.15.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 15:33:44 -0700 (PDT)
Message-ID: <64d36e10-aee5-4752-b075-2bfcf9e74bf1@linaro.org>
Date: Thu, 17 Oct 2024 19:33:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/omap_mmc: Don't use sd_cmd_type_t
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Guenter Roeck <linux@roeck-us.net>
References: <20241017162755.710698-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241017162755.710698-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 17/10/24 13:27, Peter Maydell wrote:
> In commit 1ab08790bb75e4 we did some refactoring of the SD card
> implementation, which included a rearrangement of the sd_cmd_type_t
> enum values.  Unfortunately we didn't notice that this enum is not
> used solely inside the SD card model itself, but is also used by the
> OMAP MMC controller device.  In the OMAP MMC controller, it is used
> to implement the handling of the Type field of the MMC_CMD register,
> so changing the enum values so that they no longer lined up with the
> bit definitions for that register field broke the controller model.
> The effect is that Linux fails to boot from an SD card on the "sx1"
> machine.
> 
> Give omap-mmc its own enum which we can document as needing to match
> the encoding used in this device's register, so it isn't sharing
> sd_cmd_type_t with the SD card model any more.  We can then move
> sd_cmd_type_t's definition out of sd.h and into sd.c, which is the
> only place that uses it.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1ab08790bb75 ("hw/sd/sdcard: Store command type in SDProto")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/sd/sd.h |  8 --------
>   hw/sd/omap_mmc.c   | 22 ++++++++++++++++------
>   hw/sd/sd.c         |  8 ++++++++
>   3 files changed, 24 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

