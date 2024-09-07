Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C3E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smmo7-0002OV-Uc; Sat, 07 Sep 2024 00:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smmo6-0002K8-Su
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:12:18 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smmo5-0001aN-BV
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:12:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3d87dd4c3so1215674a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725682336; x=1726287136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1rd35nP80P8OV6CwJyy/DbEGPiv8k4bpO1n/8T8PyM=;
 b=kZDTLbvHX4eUr21mrMzMK036lp16fuz+CzRVochbTlTnfwD5pKwnDAcQu1W4WRIv8c
 WCz+G4b9Q1TJLSd1oZS3XTWgsCrAuU1C8hpHyi/zmVLmIwEAUMGIAQKUn+GxsO/YsJim
 ocFkUjMPAGCF0x/zIJIkfzVne4ZoJg76A2e4+26fwmZLQU/0SIPMVAAGHh+a4pHrNlw8
 UTvGce3+Bhyl4OHJzQHfU6FUGpN++/MOWbJKy7CZ34K3KDw+mTK/flrzS/75Ce+5oZSh
 DkkAQ7bR8ZYRqMXkdbCpprFfZXY2j+maPOixR51UvUWTbSFuUX+gy1ePZC8hgahqmWiM
 Mgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725682336; x=1726287136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1rd35nP80P8OV6CwJyy/DbEGPiv8k4bpO1n/8T8PyM=;
 b=gn+jFr2mf07y3pwuNVmFd52W+vs29RXJcvtWqzsAX3GYBuUHf+zdVp5SsnoeX/+2aI
 /FbfU+3kzDkuD6t6BMiPVdCJmkNicE1jgYGcJFDlFyEwdJ0zAPLmhAUlFX9BuEch0udF
 CjZNHMN6PWvTTEwkogcGIdD2TF28xDL9LPLnltUiCDuOMtPHW4DahaxXysLk2XkEj3CY
 GKWYuRhUzw0W5HMczP/6FrcmUhKgK4PmeukGzcLXK8hOI+/XNYypk0uedhlcqpj+hCyI
 ViCPkp0XMRHKjXCxtsZROSItn16fiUkjGDK7TQQNbt+i5bwdeYqM6FIRtSm1oTjHeo5a
 saWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMOUZ6kU979gcaoDp6Ds3PAA0/mdRtYkstQGRDMPn/oIQNqZsfn1jxbnB3+9ZosSfv+KVUfu1DZQMt@nongnu.org
X-Gm-Message-State: AOJu0YwpGsQa6tBXrIR5iqIWeN7SQLyg5PNtZWa0zBDTrSt3ASGDJvHF
 BB732muHtg6MRIrbwoe65bU+4aZDjneqoq1kes8aTVZT6CDMVZxsWRC3PzZJK14=
X-Google-Smtp-Source: AGHT+IHhx4xo1nqyQBNPsxYmxNXpU4Wq+/YN30GrvNhtD0hbY6E6FUPzY2yVD04+/zszUfzD+JdmZw==
X-Received: by 2002:a05:6402:4402:b0:5c2:6e61:fa87 with SMTP id
 4fb4d7f45d1cf-5c3dc7b7ed2mr4225748a12.23.1725682335620; 
 Fri, 06 Sep 2024 21:12:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41ce2sm205766a12.19.2024.09.06.21.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:12:15 -0700 (PDT)
Message-ID: <bb42c045-e8be-4a84-8937-df01098868ed@linaro.org>
Date: Sat, 7 Sep 2024 06:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] hw/sensor/tmp105: Lower 4 bit of limit registers
 are always 0
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240906154911.86803-1-philmd@linaro.org>
 <20240906154911.86803-6-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906154911.86803-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 6/9/24 17:49, Philippe Mathieu-Daudé wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Per datasheet, "HIGH AND LOW LIMIT REGISTERS", the lower 4 bit
> of the limit registers are unused and always report 0.
> The lower 4 bit should not be used for temperature comparisons,
> so mask the unused bits before storing the limits.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sensor/tmp105.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index f5101af919..9d7b911f59 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -171,7 +171,7 @@ static void tmp105_write(TMP105State *s)
>       case TMP105_REG_T_HIGH:
>           if (s->len >= 3) {
>               s->limit[s->pointer & 1] = (int16_t)
> -                    ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
> +                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
>           }
>           tmp105_alarm_update(s, false);
>           break;


