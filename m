Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14608CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO7U-0006wU-0v; Sat, 30 Aug 2025 12:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkxi-0008KB-5p
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:19:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkxd-0008NN-Bp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:19:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b6b5ccad6so8631585e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756419549; x=1757024349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DD2yeJRw1duFOASyifATur0MnbzF0Mr38+5nlHgRrSk=;
 b=iMS6dy4lJTW53PdqKc8hg0TZGymnvzExGb2dw38G60zc22sdoBE8GULbuEIjXSf+Vx
 4pnZqJ+i1HaNP33/qVwDyV99VpFkgsORnb1a/djJklne1dbsPg6x0MzSnkoL5e5AGAWT
 W9XmVSR9eCSgSdigzv4KUjrrc8ETAKE4iHWqO5ZK45SW6+Dc5i6XShA2t36JbUxJTSX1
 r+Yk/5SzROWjkur5g0FCLRFIfIqHeYsExirM9AsUFhODAQAhwcjyBggm8bSl/OjVdVZi
 hXSUkMlVf4dl7iLEoiKGDWYhUnRcADD2ABQ0mrHeEJGYHty/gr81vrlcwL+TPXKnrJeL
 5X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756419549; x=1757024349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DD2yeJRw1duFOASyifATur0MnbzF0Mr38+5nlHgRrSk=;
 b=T6fALo6S3UFyPXWPFtfR3gRUxc6lpIXFjdLNNJ0Pq2sScDJMRfJnWZjyhnu2C2JDDE
 j1v7EKndraR15CMAXA3FWaguWvYhnVxFUBUVh2oJHJkPGCIql1K3HCh7CvEAgE0HScm4
 /AlMmGuEuvdn4N8XZma0DiwcmPd54PC78elGpv4rDaJ6sI63e/iQ4QPxfdBPqtwRLinT
 f+jfYbdXcpaZLycdM0evLK5flU604YtB4wx7MIC7dE2cr/JMFJ2/2bi7BSQZIp9DWziy
 4V1MBgQqqUaEhHMmVe6wgsOz/PrTXD/f5Dl99bcri4uxknPuXlDnIvLY1X9Y92wnGqui
 Sh9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0H7TFjAQrHe7zhzBKR1/l/qXPv+8tc3pxce4O4AgJkYp6vm6QSn4RIM9nNZRnyIcgU2cU5t+0LZDA@nongnu.org
X-Gm-Message-State: AOJu0YxaoYIO0z6UZQrfLazIDSM76ilaP2HQcJ1ucNsjTM/HOUCAAwQG
 tv+aKeoCCumCPoQCdMb9fsOO88wMNKbUvJ5HpeGHmmh6LB7EpEbtUK2pOeL/VF8+1VOOp1cylMJ
 fPswB
X-Gm-Gg: ASbGncurTUm43UTFDDj+FjYs03ekZPRflG+WcAA6RFlSR9eUU6T9PIo0bCjcLN4Mqo6
 ak7f3XyN7xc6cXVEYj7vc/MPJ7qkMm1kqIcxnRjNJvCuBYmwFjYDyCkjj/xxRhjnYXLqaLEwAqL
 R0lGs2f+fPzmu06XQsFSeEH+Da+RGkxWD90ulA3HYC0o1X6MkX7RLEyxN8/oymDnqzeNbbkvs3E
 EQh0iz217xJf+99QiF/OJReTTF6IVLqwrHMgit9hUhn7vS6NBrWBhCWMv6/xeTIea5wtF1hnnbm
 LKbmh01v/o5z45m6ZqDzxivm6d7oOz4r+NRlNgkTqXxWXTio1o8OxJ3J3G84qo0dNYH6KsYD5Zu
 c35EsmHuWTPN7CYgEAT/MRHW8fS9hq7dZu8JJtYWmXqZmM8q2R9Vke2NdEnhDrrb86kpmxoeb2g
 Rf
X-Google-Smtp-Source: AGHT+IGNCAek5/lRo2F1mZqq2HlPWl9Zq1Yv/y0kDZlwY8Ofn6uOM02xCPSNsfulidNqW4wLQS8YGw==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id
 5b1f17b1804b1-45b51f2fe8dmr121000565e9.2.1756419548997; 
 Thu, 28 Aug 2025 15:19:08 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e9c41cfsm10195565e9.21.2025.08.28.15.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:19:08 -0700 (PDT)
Message-ID: <88966d75-2947-4fd7-999d-9b94250a9033@linaro.org>
Date: Fri, 29 Aug 2025 00:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/47] hw/arm/xlnx-versal: sdhci: refactor creation
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-6-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-6-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 22/8/25 17:15, Luc Michel wrote:
> Refactor the SDHCI controllers creation using the VersalMap structure.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal.h |  5 +-
>   hw/arm/xlnx-versal-virt.c    | 43 ++--------------
>   hw/arm/xlnx-versal.c         | 96 ++++++++++++++++++++++++++++--------
>   3 files changed, 83 insertions(+), 61 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
> +{
> +    DeviceState *sdhci, *card;
> +
> +    sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
> +
> +    if (sdhci == NULL) {

Can that happen?

> +        return;
> +    }
> +
> +    card = qdev_new(TYPE_SD_CARD);
> +    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
> +    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
> +    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
> +                           &error_fatal);
> +}


