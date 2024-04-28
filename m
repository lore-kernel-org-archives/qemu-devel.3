Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2C1C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Chj-0004i0-1q; Sun, 28 Apr 2024 18:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Chh-0004hm-P3
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:09:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Chg-0004NL-AQ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:09:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso3613387b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342139; x=1714946939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uKhUKot3vzJCZLDAzNqGhj0dvY9BfvFBYllFA3dDmCU=;
 b=ydIP38dm28MZkwZq9Y+7mZJL3tEamsEX7xmAvoW6LBuKd/BI82TmGMl7pBYHhzjg+v
 Fp3SBgwN5ttIPoWMT2sAXJXg3yBb6mTAgPpviZPmMo9QG1Qv8RjcSwLQcAmMjjZzhx1s
 H+pqvBn2ugEpIjC5aYmJ0Yx4eKNRHYfSW0fYXLdsMy5Y4GEF56ECp7lJoDY3NrlQa+FU
 C3RAF+N4rsRF39bHGfz4UdQTG638VcncGhUKot4jucbX8SKuYs6Q/hIw6gWP7Hk9O4VM
 eAo04I3V/+aca/kIojK1ErWVocotHla+bFmeviF+KjbDP/8WB0vBlWAEStYi8kSgf7VR
 FR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342139; x=1714946939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKhUKot3vzJCZLDAzNqGhj0dvY9BfvFBYllFA3dDmCU=;
 b=aqrI33NeGtWTyk/dog4F0j5SxfFUo6j3PH3Dwv1tYltsuIfzeK+Kjrh2BCYU3pUYyh
 bQUn6x9rb1fSK8Vqgj6Gg1keyTgUjFMQv11lW3odqND2Dr9qfTW44rI0woTqLFjiIItD
 auFQwOwKncfWaLtVvdR1d+0H9GGx+ORfhBwtx5NppbUaPQN2zZTWoqK8friIkJ0g2SjZ
 a+cxjGnay0Ym0EAYM5U0RkBee8I53ZlDPX2niNoIWXjLD5wMQaw5JX1TURtPfYx7oUq8
 VN8EO0vebBzVhSXBVeLVsXq4FKByCUq0n92wZ/GhJiCOKhqL9cdODf6ipG05GCA4ppci
 S+ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtDfKGj4VfRZ/UuEFfSyQD61kXLTX97IWE1BNJms0M6hVQvy4X9HZnz9td/r3aCeXvhmvGb3j9JlMUh04pjvY6QfG5OMo=
X-Gm-Message-State: AOJu0YxSfIy90F7zBHH+jmLa8shhlCNCnOQKzKXc6/unp13l/ehTQY3v
 u6d7AOCdmzhJ3AueC6P0rFpLe5F6KdgP4KvKs+CoXvOiB2Xb38gGq+Ij2xXX+BPRQ+1QbaY5pbt
 G
X-Google-Smtp-Source: AGHT+IE/16ZasGAvit6LpoGahFPYkIvJs/YEWsAPmqb36XclUrHooRUra4L2Tr0ilCZBSHljA1uZiA==
X-Received: by 2002:a05:6a21:32aa:b0:1aa:6100:3b01 with SMTP id
 yt42-20020a056a2132aa00b001aa61003b01mr10014665pzb.50.1714342138962; 
 Sun, 28 Apr 2024 15:08:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a17090a420a00b002ad059491f6sm14187066pjg.5.2024.04.28.15.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 15:08:58 -0700 (PDT)
Message-ID: <28f02378-b01a-4986-9dcd-9c397297d25a@linaro.org>
Date: Sun, 28 Apr 2024 15:08:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] accel/tcg: Restrict cpu_loop_exit_requested() to
 TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240428214915.10339-1-philmd@linaro.org>
 <20240428214915.10339-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428214915.10339-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/28/24 14:49, Philippe Mathieu-Daudé wrote:
> cpu_loop_exit_requested() is specific to TCG, move it
> to "exec/translate-all.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/exec-all.h       | 17 -----------------
>   include/exec/translate-all.h  | 20 ++++++++++++++++++++
>   target/arm/tcg/helper-a64.c   |  1 +
>   target/s390x/tcg/mem_helper.c |  1 +
>   4 files changed, 22 insertions(+), 17 deletions(-)

I guess we could dither about whether this is the best place, but I guess it doesn't 
matter.  Do you really need the CONFIG_TCG ifdef?

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

