Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A1C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkZl-0001r2-Sh; Wed, 24 Jan 2024 16:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkZk-0001qg-8H
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:14:24 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkZi-0005Gy-PC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:14:23 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-361a1f8c675so19986035ab.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706130861; x=1706735661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C/ejqr6P1E0Bdya7gU00H6SmgcHcgPFRMBw4QymJIb0=;
 b=zX0kVzKDzJi3uEVPnij1IwPEF1X8P6MP1jnpTvZ/DYKpGzOZezU+ycmz8V6ekW3lDQ
 kG54OmvUai2fda4z7SKUtQ5CgXgQ0VEEVYGUXlzwqJvHDvz2+18X0/pXqx2snDvyU3Ax
 jJYcSc+w0pcYZzV+9nvXC+PRXiu0R2fwDaPUrl0Z9FUStddbMlE2JsL2nsxMXmJ5yBVF
 wvVjdBzco2fj2qbQKILcM9CDav09XaLhvrpmB86Svx4deq6U2G/udDaQyQB8giRtyPCk
 KJAc+pVeKUUUIQSxko1bETm39aB55UtSymMWnU+cbG6H2861tPLcdavQRV+4rzTmmBaP
 Xe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130861; x=1706735661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C/ejqr6P1E0Bdya7gU00H6SmgcHcgPFRMBw4QymJIb0=;
 b=DTdm+qfqUXLfeIFx+Hm/YhF1PCYiRgDDCwAaelk/8DUZnBwwR/FQ4BoSAFQ68Mu7Bq
 PGrQca1mEbtni+w+P54OCX+1iBSz1QJLTkiufI/wtiISmMK3uL8gRHyWUgNcuJAlDsxv
 aqjGrVh98CD+zaqmbsC2QgMuSwEFP3ZnqzBIhj8rTbYBuz9QQA14nP10fpa2fTEm4/vs
 +yZH8EIQMRGNdXdTvg/LAJyUicchU/VQ3qjcSxg7vtw5W5K5J0+k9gz5c8cMf024B/Vm
 X3t6U7nje4qEZbQ2LnvQ7tk8jAwFX/QWvIQvjKxpmXCqn52D04UkPwcgVARcmEznSIwR
 s0LQ==
X-Gm-Message-State: AOJu0YzWhxpsKz8rWtmckX4dHGCVaP/PeZOfoewBZccgV0z2s5kTQMLg
 qnAHrAdq0kLxbq3GbSTf+lqNTWL6YW5YEET+0fOQfNYS9QZwa5MkuW3ynDjmigY=
X-Google-Smtp-Source: AGHT+IHJPYWUGG/YH8FA2L0RMs6dR8HY8j1ZxAPuzAKrW35Sq2LgN6n9H0ixHdZA22MPhyyXzu/hwQ==
X-Received: by 2002:a05:6e02:1285:b0:362:8a67:477d with SMTP id
 y5-20020a056e02128500b003628a67477dmr44180ilq.3.1706130861502; 
 Wed, 24 Jan 2024 13:14:21 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 73-20020a63004c000000b005cd835182c5sm12174815pga.79.2024.01.24.13.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 13:14:21 -0800 (PST)
Message-ID: <6bceadf2-0426-45b1-afcd-abec5efbb5e7@linaro.org>
Date: Thu, 25 Jan 2024 07:14:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] accel/tcg/cpu-exec: Use RCU_READ macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124074201.8239-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 1/24/24 17:41, Philippe Mathieu-Daudé wrote:
> Replace the manual rcu_read_(un)lock calls by the
> WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
> "docs/style: call out the use of GUARD macros").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    };

Stray ;


r~

