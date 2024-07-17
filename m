Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AD4C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxQl-0001QL-4y; Wed, 17 Jul 2024 01:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxQj-0001Pm-Jf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:42:21 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxQh-00075M-Uj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:42:21 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3da5eab691bso2778079b6e.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721194933; x=1721799733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=coZh2sdU2BovlNcANUxti6rI13Juu3KR0k5KjxLS8E4=;
 b=FU07mFHC8ZrqWrWa3Ry1ttoH1V2wbiI3JUcOknshMqNPaBOKrx7GKYdJt/I5x6T+ba
 +n1vxnYb1OxWucZTXYLF1IJNExgEdpY3W2xzYr0YRm07UX9TiJqFyAMz/jRNAZivBO7E
 Q+LdFeCnmBlQQd2Ky19kxXY1FESBBNU7m8/tCDO5mZWxkn1F5Pfp0/2++cLh0EKKdxuZ
 87LrYetn4XB7F6AjMOo6WwBZ1/MvjyT7H/K9is+XpylGVPonemFynj8aj95P+c5F5e6m
 hjUB+AA3NojlRTtFpbdqZgV4dg+f6YnJoaZ+jxZhfeXUI/icklU1Ip/FtjbMlY83jkNv
 TxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721194933; x=1721799733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=coZh2sdU2BovlNcANUxti6rI13Juu3KR0k5KjxLS8E4=;
 b=CSvvrEnS1SPl+6nm40I/T4o/jsBz15H38gF+WX8FFrQxoObw+sAux94Q87NzSHc9eF
 qoxwTimp18BUCYZxV0lqfiAR9zsOZPUln8e+9zjYcEJvv7XkZsKqJlH8Z48BI37wsIFP
 KUdqd8zdYeuroBJmdpoM2/YI15QQG5VNu3B7jBYsiHG0u7TdIaQkUtLyDmXFfPUPzmD0
 17deeEyR5K267Owr4yH0B+srzwbMpgmEWZye9b1iFlr7Av81ftW0ROowj++JgLHxLFGw
 RdksW5e/reT/aurvShlc91g3pOBGj7MgHMRJR7MhezkgaSqZGZxxqk+T+LzDs5QWLmfE
 a9cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTiT8KBO/g/dYCV6YYfy9OOiyWvxCrkfAI76oILqoVQGvJumK5ggkWnyd5rFm7ov4uVdmKfYIrYqhe4J2GgBPJXE4elNs=
X-Gm-Message-State: AOJu0YxL6X/RLusir70by35ni5gr/f9BAUWdpK19vlI6sNFc7WzRDHWO
 EFl/7282uJL7QYGyDPneFArEMViYuZopDBGr7aCR8mkd+5W/JGgYvs/6pp58O2I=
X-Google-Smtp-Source: AGHT+IHOtSiNbHvuL1YSBkvrInjPEl06DpVtuMqhlt1ZU6IXBedu640TkZnUyPzf+EsZbt3rp1mR3g==
X-Received: by 2002:a05:6808:1293:b0:3d6:32a5:66f1 with SMTP id
 5614622812f47-3dad1f90e0amr868796b6e.52.1721194933301; 
 Tue, 16 Jul 2024 22:42:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc50951sm67193305ad.276.2024.07.16.22.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 22:42:12 -0700 (PDT)
Message-ID: <4991f433-0870-4a3b-acce-fdc6732059c3@linaro.org>
Date: Wed, 17 Jul 2024 15:42:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] SD/MMC patches for 2024-07-16
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240716184144.42463-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 7/17/24 04:41, Philippe Mathieu-Daudé wrote:
> The following changes since commit 959269e910944c03bc13f300d65bf08b060d5d0f:
> 
>    Merge tag 'python-pull-request' ofhttps://gitlab.com/jsnow/qemu into staging (2024-07-16 06:45:23 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/sdmmc-20240716
> 
> for you to fetch changes up to c8cb19876d3e29bffd7ffd87586ff451f97f5f46:
> 
>    hw/sd/sdcard: Support boot area in emmc image (2024-07-16 20:30:15 +0200)
> 
> Ignored checkpatch error:
> 
>    WARNING: line over 80 characters
>    #109: FILE: hw/sd/sd.c:500:
>    +    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x01; /* HC write protect group size */
> 
> ----------------------------------------------------------------
> SD/MMC patches queue
> 
> Addition of eMMC support is a long-term collaborative virtual work by:
> 
>   - Cédric Le Goater
>   - Edgar E. Iglesias
>   - Francisco Iglesias
>   - Joel Stanley
>   - Luc Michel
>   - Philippe Mathieu-Daudé
>   - Sai Pavan Boddu
>   - Vincent Palatin

Applied, thanks.

r~

