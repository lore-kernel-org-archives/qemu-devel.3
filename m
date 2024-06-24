Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63A9C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLiHL-00086l-AR; Mon, 24 Jun 2024 07:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sLiHJ-000863-LG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:54:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sLiH9-0004MI-B0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:54:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so3534918b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719230061; x=1719834861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9exiM9nxej1c+gcLd3nCNe4L/RX8HFT4G0YVY7w/bM=;
 b=CSrapPXwvm6HuRNfr9qN64OR4c0OFMlkGpEXs+bLPHx1FPeIQOj6dhqm6Xo7Y7kf6+
 +wIVCuM4m/ob9GWP1L6cx3oRPyqzlVTImNd8kWx8qUYUMr3lgjxBWk6ylBlERT+pHOB6
 7XDD4kERzO4EC0IAIv+D0oTiOgMDHnLxb5QfQdupo/5IDN15KFcJ47TTosjx8c0wL/Rb
 XALcev2brJN/OcULinLuRyeBKj8FOPQs3cH9qNXwJYEq/CxBMI5DO2xohm6VXEhVLD/u
 kteD5PhXnfi6SGWwLg9i5AclQ9+RvrGydeefuAzowgoBmy6Ej/YbguhgOiKO1udbs+xl
 Aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719230061; x=1719834861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9exiM9nxej1c+gcLd3nCNe4L/RX8HFT4G0YVY7w/bM=;
 b=CANVGz2yfPjwIDdguKFxAR8Mgu2RlpB6FXJiJDyemKuw2Tp4OEf3/4mxOJvOZ3l7gp
 fJqo19HJu9E3uxdmxY45jmOLNA73XElGsEv7Bo7T98DQU3oNDA415iZhs7NX3g0RbLoB
 yfjKnAnpi/5hbR82CPmALzDakCOv53ytNN4FPbBkTQzqd64c8lE0gLR6j/qkW9MEJGku
 eE5sAkejLBWDGFG34HsLjVp4p6mONz+l5ZNZQCdZg0FBM3BCzMYrnEqAydcOIqpEZlbK
 oTuqmbGAI97+4K2XRS/9ce1K0uScCLA02+pSyuHY5JiN/gzzbNH/mr92T420oHbL01lz
 TgTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ELW9eMUzLysfhZoXD5FPWZz+Qdy5eZLAyOHDLkziAMUoGRTqWVEha+6ZsNeFg0ORTKuCnnJchiUKDdnOfL0B/be7U+k=
X-Gm-Message-State: AOJu0Yw54tm24b0dwK/fLTxd0FmPXUqUlPvhpUEWQHF7ySvmzUjBv/0e
 IvA0w2PFkbZG9GWobXJCCZvGjGp/907uhNv8dMKjG/x+xEwZcBiZ
X-Google-Smtp-Source: AGHT+IFcafTasGrwwkGcfJxx9D/+kLd8UeVbTpvBJOLxY9Kiu4rJ4Ubh3Gn/v+MTW6x8M4Wvh5uq1w==
X-Received: by 2002:a05:6a21:999e:b0:1b2:b60a:a42d with SMTP id
 adf61e73a8af0-1bcf7e3cc4emr5272286637.4.1719230061300; 
 Mon, 24 Jun 2024 04:54:21 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fa1d3773d1sm34433535ad.270.2024.06.24.04.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 04:54:20 -0700 (PDT)
Message-ID: <1cf11ba0-5b4c-4294-a34a-f238225dc261@gmail.com>
Date: Mon, 24 Jun 2024 20:54:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Fix potential bugs in MMIO read|write
To: Peter Maydell <peter.maydell@linaro.org>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
References: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
 <CAFEAcA-NmcugQwa1u=Yt0GF4y1BAGUhi3ZnLhs6SPGP+s1sDLA@mail.gmail.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <CAFEAcA-NmcugQwa1u=Yt0GF4y1BAGUhi3ZnLhs6SPGP+s1sDLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42d.google.com
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


On 6/24/2024 7:27 PM, Peter Maydell wrote:
> On Sun, 23 Jun 2024 at 03:46, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
>> This patch fixes two points reported in coverity scan report [1].  Check
>> the MMIO access address with (addr + size), not just with the start offset
>> addr to make sure that the requested memory access not to exceed the
>> actual register region.  We also updated (uint8_t *) to (uint32_t *) to
>> represent we are accessing the MMIO registers by dword-sized only.
>>
>> [1] https://lore.kernel.org/qemu-devel/CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com/
>>
>> Cc: Jeuk Kim <jeuk20.kim@gmail.com>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
>> ---
>>   hw/ufs/ufs.c | 31 ++++++++++++++++---------------
>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
>> index 71a88d221ced..bf2ff02ac6e5 100644
>> --- a/hw/ufs/ufs.c
>> +++ b/hw/ufs/ufs.c
>> @@ -55,17 +55,18 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
>>       return ufs_mcq_op_reg_addr(u, 0) + sizeof(u->mcq_op_reg);
>>   }
>>
>> -static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr)
>> +static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
>>   {
>>       uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
>> -    return addr >= mcq_reg_addr && addr < mcq_reg_addr + sizeof(u->mcq_reg);
>> +    return (addr >= mcq_reg_addr &&
>> +            addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
>>   }
>>
>> -static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr)
>> +static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr, unsigned size)
>>   {
>>       uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
>>       return (addr >= mcq_op_reg_addr &&
>> -            addr < mcq_op_reg_addr + sizeof(u->mcq_op_reg));
>> +            addr  + size <= mcq_op_reg_addr + sizeof(u->mcq_op_reg));
> Stray extra space after "addr".

Thank you for your comment.

I'll fix it when I send the pull request.

>
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM

