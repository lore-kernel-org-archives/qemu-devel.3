Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B1CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9589-0001lI-8b; Wed, 15 Oct 2025 13:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9587-0001l2-CG
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:17:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v957w-0005QU-DR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:17:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so43968075e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548645; x=1761153445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOeVQ73bG+j/W6aRXCTreXn4GBCouD+R7IeYtBzs3UU=;
 b=P2AdOw8oKO5bdJ7UT3SDXPp6hHDGVKNJW3RSAS5jcH1oY2LsBgGZMkLFZc1vLgxleg
 Mb+s0WNbIhkeE4CoS2ZLd5B9gb7XcS39v3ovo1cU/6hHimC7D2qqXpvUHQ8tORqc8JPm
 b1dTB7hbsrMVtfOTTx+PLwWsRMNbszHysCH8jCcJb7aMk8BXKh+L2PXfHbotLdtaxQ3H
 8x0tw90ZZX61UOfp08BSnyndQpcKnQ7/L6iSb5nZ3R9aFnbFlvLKhoS6XUC/9UcXLrZY
 4TP7jIxqIuFsTo3Ja8z8vwyKkrFfQkCAlNPwtJ925jT+p4waKCzoRdwPE4QqYUmzIiRM
 2Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548645; x=1761153445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOeVQ73bG+j/W6aRXCTreXn4GBCouD+R7IeYtBzs3UU=;
 b=smBxRFEnutZEbZKsHXbVfh7rgDiZDFjysAOa6PaLUdRDe7pvkVk143mpakNoNYUjOW
 6mDZYWhJfKvFjMtDNMADPQ60SF/oWWyffaRKNsLSuLyMxG6/Z0PWJWg1RkJSdzEZrY6o
 oYU2ThL0RtcvEyNNt/Ewm2MiUvcl9gKV/bFxH6ozVm/b6EVcV4A1Kc+XxEwlgzfh3PC0
 I7or8Rixa9yduGpSnuPk1rvg5/ZT0aW7dJ++UM/viQNddw93HnOdlscs9iZO0XkIBGkU
 j9GFgUko7KGTjWHk7qp9406Ed6ovQn4Yt2X+VzUxFBdJI/kSty1hk4to0A4/QDC9/bXC
 APHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1+7QHnpP+4humJsXpTIffv1ldzrlFq1az7IHYn5bEtOjbmX8q6YxZJZcyTbQu9C3+cwRLQI48n8fg@nongnu.org
X-Gm-Message-State: AOJu0YwIrUVnzH07xNt2MndRiLaeEUCQzQ1B+mTfXaY4xRmZjd80pFrM
 ciMJN5xMlDShbSmyhW/TtYCs3UTcEEPCHHmCL1lb1pHkSGKLAqfShwgOyWyp0ryaYc0=
X-Gm-Gg: ASbGncs65lR47TNrJSTzMReG1lM73h8qaH122p6K1YeAyrjo1mhSgOQucLkuHZdDiRw
 B/Yh9q2JIAZibXIilbef5nfBV8dlzX6IfrcUfkxrqmytRg+FXeRBapzciYSREyWBk76fBNIqWr6
 nPR1XYg098sNfKVs3VBATGpKkQey8/imBd/H4sr9qeFvlbkksexMm6pnS3ALJHEI7/mjL1AaCgf
 wwPNC4LvCrNAqPpCJIS3kgZvk3OcEecKTGUCyk5RA3ihliRH3+fwYtL6f/j2yaKgNeTC2tX2lcG
 jppuOW4VN9IjUZio2m9RsmxvNhhyw5WxM1Vf5cxjCbKAQoQS7lPqzq99rThxuR5sU/1T3X0bOUP
 dGV1b9X5Qq2Tk3neVUQlyVHhmueXHl5stxNOyda4+2FCBMLH8rReYEu8t/fhHNm6dOvnA0AQWmt
 HNt8rK16IHySHM+IAHuVxs8a0=
X-Google-Smtp-Source: AGHT+IExa9lHHsjUoJyIl+Ff3tIFGm+s3EHNRkKwTldJ9DCVFINsR+fLeDCdF8mFqJFpP9cu8mQjfQ==
X-Received: by 2002:a05:600c:a41a:b0:46f:b327:31c5 with SMTP id
 5b1f17b1804b1-46fb3273828mr108524905e9.0.1760548645047; 
 Wed, 15 Oct 2025 10:17:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47106fc96bbsm13905115e9.3.2025.10.15.10.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:17:24 -0700 (PDT)
Message-ID: <bcd6b497-6b44-4163-9193-20ab4c6d9a3b@linaro.org>
Date: Wed, 15 Oct 2025 19:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/loongarch: Remove some unnecessary
 target_ulong uses
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251009201947.34643-1-philmd@linaro.org>
 <aea58191-206c-c193-d539-cdf642d4fa59@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aea58191-206c-c193-d539-cdf642d4fa59@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 14/10/25 12:00, gaosong wrote:
> 在 2025/10/10 上午4:19, Philippe Mathieu-Daudé 写道:
>> Remove few invalid target_ulong uses in LoongArch frontend.
>>
>> Philippe Mathieu-Daudé (4):
>>    hw/loongarch/boot: Remove unnecessary cast to target_ulong
>>    target/loongarch: Remove target_ulong use in gen_goto_tb()
>>    target/loongarch: Remove target_ulong use in gdb_write_register
>>      handler
>>    target/loongarch: Do not use target_ulong type for LDDIR level
>>
>>   target/loongarch/cpu-mmu.h                             | 2 +-
>>   target/loongarch/tcg/helper.h                          | 2 +-
>>   hw/loongarch/boot.c                                    | 7 ++++---
>>   target/loongarch/cpu_helper.c                          | 2 +-
>>   target/loongarch/gdbstub.c                             | 2 +-
>>   target/loongarch/tcg/tlb_helper.c                      | 4 ++--
>>   target/loongarch/tcg/translate.c                       | 2 +-
>>   target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
>>   8 files changed, 12 insertions(+), 11 deletions(-)
>>
> Sorry for the wrong  'sig
> Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks! Series queued.


