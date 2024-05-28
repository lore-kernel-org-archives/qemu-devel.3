Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E153AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 03:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBn77-0000gd-Dp; Mon, 27 May 2024 23:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBn70-0000fv-1z; Mon, 27 May 2024 23:02:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBn6y-00071x-7b; Mon, 27 May 2024 23:02:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f48e9414e9so12467895ad.0; 
 Mon, 27 May 2024 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716865370; x=1717470170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uTrA8Anqfurv7/nMoxfbb7tMZKaxEhklTjeMnQvA6cU=;
 b=dSzR05Xz0Z+OdrdPA0I2g+ES1E6vEQJ4K43DRyTfWAGHbmsLYzPAfG3MZ3ozKUmMhF
 RgTP5EYB8ogIW/hI1/vXf8PMjx0WUVRfBHY/MzWPKrt5bsurh3h4LD5IC5NK0liUd2gd
 KK8fD0nRHMdmheaMj58KioRmA1Uudsf/5DZhtpx6Y9ZeKav2ENIkqRoO8P4nx/Dy6d1v
 o2mtuHOEGJYVw0GNoOQCcGL2o+D+AU2CJWU9Ow2SOfXgzWJhQ2+FjdkmPRgvctVSbxF3
 wQ7A5XtnPClVaW2klqzx6rVD9PjSKpWt4ool9LAHQU4CcFOYzkWO/8R+e16sHClswgRG
 E05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716865370; x=1717470170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTrA8Anqfurv7/nMoxfbb7tMZKaxEhklTjeMnQvA6cU=;
 b=wbHi9qFd4QdyKeGfZ3+O+WSHYEfhCpQulRerq2GJIyl7kpVk50XWmRhz8rkwdYs6bY
 ZaOEb2wu9nEp50CKVtTSduWb/qQCI6Ps0xKzJhKE3qhor75UdxmIAr09r84Ok86bvY8g
 Mtr/fhjpW4K5MrY/wOeLX0gRlQ6RTs0bCzeIFc2JFd484F7/7+Pus8L1VZRPDWw2aRf+
 EB10P69jVwsJjmovOca7ESSoSYtiavDsCg+pZaEkx14wFsrsP1YtRU5ZagGKwAagr6nG
 SOVhv7J/IHieNMYxU0Iptb3l3LUbcquKxnpt/1MWB6H3NWgpe3CqgzAdd0VzdUgvJULK
 jkDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUus4lG6apEZ8/HErLWa4eGEX66rERE++xUCwxkMOuedy48LgQPVdsd1BiFGJ60kXmUxcHV2IrwWvDCScGDM0ZOjXBA3aE=
X-Gm-Message-State: AOJu0YzZpR9ARHz8EIDItPJi0WqTbVDz/xRH5VZlVZXnXF5wtmE0LYW0
 KrxHgcGK0pRiS4iWmBoGkbzNYRBgVnQlkHA758bHBaOKqSUNnrNq
X-Google-Smtp-Source: AGHT+IGqRKUH1Q//bBmhFHIhdHuYqcP/vmwyFKAOAROvjYqfAp9WhYsoMLbBlf4SvrcizK6KEmjqMg==
X-Received: by 2002:a17:902:d505:b0:1f4:58c6:d5b with SMTP id
 d9443c01a7336-1f458c60fb1mr157544825ad.28.1716865370220; 
 Mon, 27 May 2024 20:02:50 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f48faad28fsm32511955ad.286.2024.05.27.20.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 20:02:49 -0700 (PDT)
Message-ID: <d8fd8103-8d74-4f61-8478-89210eafd954@gmail.com>
Date: Tue, 28 May 2024 12:02:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/ufs: Add support MCQ
Content-Language: ko
To: Minwoo Im <minwoo.im@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <CGME20240528024226epcas2p1667c281607ce0496703c688b2559a8f1@epcas2p1.samsung.com>
 <20240528023106.856777-1-minwoo.im@samsung.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240528023106.856777-1-minwoo.im@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 5/28/2024 11:31 AM, Minwoo Im wrote:
> UFSHCI 4.0 spec introduced MCQ(Multi-Circular Queue) to support multiple
> command queues for UFS controller.  To test ufs-mcq path of kernel, MCQ
> emulated device would be a good choice to go with.
>
> The first patch added newly introduced fields in UFSHCI 4.0 to support
> MCQ.  The other one made the actual changes for MCQ.
>
> v2:
>    It fixed printing error event trace even in normal shutdown cases for
> SQ/CQ tear-down by checking whether each SQ/CQ is valid or not.  The
> default value of mcq-maxq was updated to 2 from 1 to prevent the kernel
> from allocating a single queue as a poll_queue by default and to ensure
> that io_queues exist to handle device commands.
>
> Please review.
>
> Thanks,
>
> Minwoo Im (2):
>    hw/ufs: Update MCQ-related fields to block/ufs.h
>    hw/ufs: Add support MCQ of UFSHCI 4.0
>
>   hw/ufs/trace-events |  17 ++
>   hw/ufs/ufs.c        | 478 ++++++++++++++++++++++++++++++++++++++++++--
>   hw/ufs/ufs.h        |  98 ++++++++-
>   include/block/ufs.h | 131 +++++++++++-
>   4 files changed, 702 insertions(+), 22 deletions(-)

Thank you for the patch.


Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>


