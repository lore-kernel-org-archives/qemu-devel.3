Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330A6C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvsK-0000jU-2p; Tue, 13 Feb 2024 11:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvsH-0000ie-NV
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:43:14 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvsG-0007H7-4L
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:43:13 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2907a17fa34so3421722a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707842590; x=1708447390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOwl5k/h1KDqksz2Wse0qLE2glUEserFMJa5leufMzI=;
 b=TGvnTzqyUPXvkiOoiBvdQhHPISI6NM2PvZnHIV40YGbT4qRTBom3UhfXoWP2G+Mw6m
 JZ+845HPUHgbulXEuaREfbAwPH9DgnYEMMU80q5eH0crg/5vVhDIeH3itTF0DKGFFWtw
 M8oMKhQ0nUPdsjTpB8H4TIhnHD39gI7oJDvVanVTKOBRprn8Q2SnpJ++loitRezZ5TP+
 pvEpwvnL4AcQFhfEac5Zit75yPS/7ZlfBAN5nCB6ibo271neCtPs6Dc7YMdzd39ZMlvG
 DTDh1apSjI8AjhgEDACEl1FXOx422kwsGVAIqFxa6TMkanXMb00rNJQ87Y9I4s7EEeUG
 VjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707842590; x=1708447390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOwl5k/h1KDqksz2Wse0qLE2glUEserFMJa5leufMzI=;
 b=Mv7ttzJgqHxplWErm4pCXKZJNTq04E1dkbYlS6KCbvLriXu8cvr6umCWoBDrHEdqxn
 lTF6w/wj2Af7QUzP/gWHo0hQs2tmK7Xd2ndvN5vxTANdZbbC84AW2ZXDRgJKyIPAgm0H
 LqQJakuEH6lIe8tMUHr1sWFkCqR1QOXfeYuETwu00LLt9EO6uTp39plPiLy4hA0iwI/4
 w6SVut3CwDvYHSRDW2xFL8MuWaQrMedvBUMbS8EwZ1YDS9ZSupEzSYiRbJqvaUitSwwR
 cXuRBxB5dw4jSeUN8/3sJxqaYIHXwPHvAWlCyzVtWl0iz3Xf4ScWP2EY02XrVu78gPNV
 Mplw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz5YZ3x1VlYdGYjNE3KbDaj2rLEUuXRil3g4CGLb3gHjj0RhE177tdOvI64h2/ogL1r63vKYLifpcZ1JaYX/AkBZDI6ow=
X-Gm-Message-State: AOJu0YyZ/7XMY8UWnJDRamuV2qgqz6wnJd5rBYhs7ajjHecJ5ij1z2zS
 PLi4C4RtzJIi7kyBWACzqWJX551KiqTV6CY0u+nxfy6L/QRiTP4k0vZ41c01h7I=
X-Google-Smtp-Source: AGHT+IESkuvKBBexoxW+9Hq5zsnHAmC0FB83EXMYi/fbT7O91erP92WixIqALRxT/gAo4kJ8136ePQ==
X-Received: by 2002:a17:90b:24f:b0:293:f16d:e53f with SMTP id
 fz15-20020a17090b024f00b00293f16de53fmr64404pjb.0.1707842590275; 
 Tue, 13 Feb 2024 08:43:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWaYWXbC9AHWMMDSpbAVUbaLHORA05uyPGFkRGiLBjsZzO4QlLzvT24sWczkJm7KnwaO/h5jZ8x6EqvNh+hw4+xuaJtZI+vBMo18Mn23BwafnLupi16PJ4iXJhhtgzbacSIH2ckhf6yBWCczZ74KMp81JbpXdoxanW0VbW+SLEMwmAfxH163nUdh2rABaD5OdzC3FyidN0+g7GekWkXaT7SiyEzfux9Z7H2XrYUhCQGVB4V2ZV9ZzIfX44WZ0zMFVqotyJUWHcWPCOyMb8rjjSGX+uznGqzBAdSh+PBzBY0UzdDZZcGFW1Gtrg18qEHz+lvFg==
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ep23-20020a17090ae65700b00298a1d613c4sm1832683pjb.27.2024.02.13.08.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:43:09 -0800 (PST)
Message-ID: <f2dd89fd-db4c-410a-bcdc-2a117e4f633a@linaro.org>
Date: Tue, 13 Feb 2024 06:43:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] hw/ide/ahci: Inline ahci_get_num_ports()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
> Introduce the 'ich9' variable and inline ahci_get_num_ports().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ide/ahci.h | 1 -
>   hw/i386/pc_q35.c      | 6 ++++--
>   hw/ide/ahci.c         | 8 --------
>   hw/mips/boston.c      | 6 ++++--
>   4 files changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

As far as it goes.  But it certainly highlights that

> +        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
> +        ide_drive_get(hd, ich9->ahci.ports);
....
> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
> +    ide_drive_get(hd, ich9->ahci.ports);

ports is always a constant.  Or perhaps that's only from this PCI usage?


r~


