Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8E7C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 10:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQlAL-0003Xc-9W; Mon, 08 Jul 2024 06:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sQlAI-0003Vl-6T; Mon, 08 Jul 2024 06:00:10 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sQlAG-0003VA-Ek; Mon, 08 Jul 2024 06:00:09 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7f70a708f8aso83085839f.2; 
 Mon, 08 Jul 2024 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720432806; x=1721037606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4aj1sxdQuxq4aGzCcWkLz8jBmDv61PWOKKF4iZWQ4WE=;
 b=OQhroePGuTRj8By7ahJdpBjFaHiUJiOgv0GYMjOr/9HqKYsDYrqN5/HyXC/f/zqU2r
 VW38fGgFCGoUjaCyz2QOjeSRC4uR/I3hCa3z6D8RyGIlDBxpkSSybFWy4Y+IgERG0yam
 3ZT2NK7lU6GgN6RmeRV64Lqrqd0g/gVc9fDdEOdSr/Dk2YoK7S56F471GgDKUmP/uksD
 jgCyBltkhbRHWi3at+Dr0GMTLwz3VlQ47NsVgfUQoifVYud/XZZcTyw9PokKHeHKH/80
 GIamH5N1w/hp9aFySMEBdSPz9sw9epcU4uh1Z6xWp6/36+K/OYVeOch39cOBmIaYwjUd
 1+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720432806; x=1721037606;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4aj1sxdQuxq4aGzCcWkLz8jBmDv61PWOKKF4iZWQ4WE=;
 b=tLhDkBCLunewuN6L7jpqvxkDQyDAzAfKXn+2LxKtxTsQmLqAK/L8UgMaHS/QNTDq1z
 7EaM+3t6D5WweNDDUZJVUYhPnvRg8YUvqx2jjfGAKiY+qar2KLyqFWFldZWMmtLFFvPe
 DnDhIQiqC4el+qzAYifjzd/Q4/P78O1U4Aw/lvM3ivC1veO0gAgGXaKT2HNtVOr+DphG
 OdBUmTSJQGglB1wv+TyBWLMrjUxsFmcZtdkgbhrmRl0VsYBvl0y7yTgysuqYBaWfrVmh
 nf/7VnGe8fiMFl7oT05F4SeJEsZ2jihm89Dh9AMrLtw85QIEmbJP49E6/tRPFXYDUNGT
 GPrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgUwA0EVRxg5G6k5bMME6gJur7WhlPCrnreZX9aiuu8CU8iIljVvlrYc9UEjNoaffRCWIuS2+RIXTMZj/ouqJ+UB4Odvs=
X-Gm-Message-State: AOJu0Yzj2dSet0aQFXIUDjAlBKd7vwFBy5iaWSR8pci3JPArUovJO1+Q
 D49HShgV1HfIO1QUzSOt/zkWY2vfAzG6ZPi26sYOSSWHxvuKCN8QzvcvESBs
X-Google-Smtp-Source: AGHT+IFDVmnYhXBhmzjB8M/F6h/4LC1/I7Oy39ywiVwhW44kc8//L3JHZHYmdeGw2us6jXmELPxRBg==
X-Received: by 2002:a05:6e02:18cb:b0:371:6b02:9da0 with SMTP id
 e9e14a558f8ab-38398fd1965mr140867595ab.19.1720432805738; 
 Mon, 08 Jul 2024 03:00:05 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b1f43c4dasm4074738b3a.98.2024.07.08.03.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 03:00:05 -0700 (PDT)
Message-ID: <75f0b28a-df00-41dc-b5e4-dfe384f43a4d@gmail.com>
Date: Mon, 8 Jul 2024 19:00:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ufs queue
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
References: <cover.1720402238.git.jeuk20.kim@samsung.com>
In-Reply-To: <cover.1720402238.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I'm so sorry. I forgot to add something to the patch, I'll add it and 
resend it to you.
Sorry again.


On 7/8/2024 10:31 AM, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> The following changes since commit b9ee1387e0cf0fba5a73a610d31cb9cead457dc0:
>
>    Merge tag 'sdmmc-20240706' of https://github.com/philmd/qemu into staging (2024-07-07 10:34:52 -0700)
>
> are available in the Git repository at:
>
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240708
>
> for you to fetch changes up to 6db492596dd9204e8fe341b2396472271cf15023:
>
>    hw/ufs: Fix mcq register range determination logic (2024-07-08 10:25:20 +0900)
>
> ----------------------------------------------------------------
> hw/ufs:
> - Fix invalid address access in ufs_is_mcq_reg()
>
> ----------------------------------------------------------------
> Jeuk Kim (1):
>        hw/ufs: Fix mcq register range determination logic
>
>   hw/ufs/ufs.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

