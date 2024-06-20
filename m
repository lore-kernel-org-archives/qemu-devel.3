Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC39BC27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 01:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK6u5-0001nA-IY; Wed, 19 Jun 2024 21:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK6u2-0001mh-DH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 21:47:54 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK6tz-0005Q6-Mt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 21:47:53 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso331006a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718848070; x=1719452870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1WL/uXz6ZvN5PxBqQDIoSSId9n7AXghiUqdKP6Xmac=;
 b=wYhbL9EgNLbI8h0TWhEEQKPZp7VOtcRfcXqCwxU0lFaawMCn2s5Rps0TZ7Cpe86gfJ
 LMN16r84/p4rJ99I9TjuCYT33A8r2eebidseEppUcee313R12f6tTG9yvvc35RYRa+Nu
 dPD8fT7CKd/ZmtRLot9VVmHXAtH5fzCTDf1ET+LCOOD1VZbU6szXrLxnfA+gvwLfXeTg
 8xSG4Lmr7Ourxz6gxMbuu+CpYtZtJNrdD3CnOVqAXHqS4saWefXWIzzdeaqe3dZQmbxC
 DqvQvHSNpS5otkclosp60XKpFGfPAgSeI3c7F87uxdh/CsujSJkZcSm87HFcd0BQYieL
 Njdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718848070; x=1719452870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z1WL/uXz6ZvN5PxBqQDIoSSId9n7AXghiUqdKP6Xmac=;
 b=oKEr2cWZO9HNGs8qCEoP15QH1GHlvjpuU2AO91C1eAZ/zsEEEgchVCWb9zoyecVJRT
 JLFniRFIep4/Cl47VNKJcVZpRRhxEtww9fWmdRoZC3wCGCOTxqdgZ7LVsoAgusz42WSY
 BQnQh6pE/5mLGC0kdCV6cJRwixkFqdf/0yJ4hB1iWQomH5VOJ2X2EpZN2TY/dannqjNx
 eL+hWQ1DZxPUjLg0bJj91ZVEnMZxqOqxEWLZOUCYX7vvdpaSOA/cXze0bvB3z1O9u7Ya
 jlRdTPcD/bEHiz0/7/isSszEN2bYkF1K0Slazfr+Xbm+QOT+kV5G/pKHPGJo4Ua+l5MG
 ju1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXagjl0GoUR4r95uh8TIeNyDCR9+gRmLVbhvC53w2iUqWh1pnyt/cwGM3RE3uERfzQ9F0Eq16LdvofXebLQzyyE0Te1068=
X-Gm-Message-State: AOJu0YwSx5+0KWaAdU+CMKFU/cn7VDGjjX+9Ox658lses8l0Kjztw1j/
 4YaY2HDcVrf2880BB54QITO8O97X3PWMbryOfhUCwXpVstNxjkWke0/8dQY3A5U=
X-Google-Smtp-Source: AGHT+IFEcbx4tZ8gcMLMY9Lb2QnNHw/u6ua66ly5SqKZKYepkuIXyV2x3L3/lTvWWeZMQKgw6uHM1g==
X-Received: by 2002:a17:90b:60b:b0:2c2:ebc5:ffec with SMTP id
 98e67ed59e1d1-2c7b59fa605mr4217854a91.5.1718848069993; 
 Wed, 19 Jun 2024 18:47:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e55dcc0asm371848a91.28.2024.06.19.18.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 18:47:49 -0700 (PDT)
Message-ID: <d1bb7ffd-cdb2-4753-9503-a4a57f8cfe2b@linaro.org>
Date: Wed, 19 Jun 2024 18:47:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] exec: avoid using C++ keywords in function parameters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224553.878869-1-rkir@google.com>
 <ee4149fd-890d-43c6-a7c0-0d6df63bbb2f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ee4149fd-890d-43c6-a7c0-0d6df63bbb2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 6/19/24 03:22, Philippe Mathieu-Daudé wrote:
> On 19/6/24 00:45, Roman Kiryanov wrote:
>> to use the QEMU headers with a C++ compiler.
>>
>> Google-Bug-Id: 331190993
>> Change-Id: Ic4e49b9c791616bb22c973922772b0494706092c
>> Signed-off-by: Roman Kiryanov <rkir@google.com>
>> ---
>>   include/exec/memory.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 1be58f694c..d7591a60d9 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -945,7 +945,7 @@ struct MemoryListener {
>>        * the current transaction.
>>        */
>>       void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
>> -                      int old, int new);
>> +                      int old_val, int new_val);
>>       /**
>>        * @log_stop:
>> @@ -964,7 +964,7 @@ struct MemoryListener {
>>        * the current transaction.
>>        */
>>       void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
>> -                     int old, int new);
>> +                     int old_val, int new_val);
> 
> OK but please keep the implementations in sync with the prototype
> argument names:
> 
> accel/hvf/hvf-accel-ops.c:264: MemoryRegionSection *section, int old, int new)
> accel/hvf/hvf-accel-ops.c:274: MemoryRegionSection *section, int old, int new)
> accel/kvm/kvm-all.c:549:                          int old, int new)
> accel/kvm/kvm-all.c:566:                          int old, int new)
> hw/i386/xen/xen-hvm.c:430:                          int old, int new)
> hw/i386/xen/xen-hvm.c:441:                         int old, int new)
> hw/virtio/vhost.c:1070:                            int old, int new)
> hw/virtio/vhost.c:1077:                           int old, int new)
> include/exec/memory.h:948:                      int old, int new);
> include/exec/memory.h:967:                     int old, int new);
> 
> See also:
> target/arm/tcg/translate-a64.c:2161:        int new = a->imm * 3;

We're not trying to purge "new" from the entire tree, only (some) header files.


r~

