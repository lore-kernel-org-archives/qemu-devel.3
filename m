Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78BBF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcqB-0006p3-LZ; Mon, 09 Mar 2026 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcpo-0006gZ-VG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:48:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcpn-000711-Db
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:47:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso10821665e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071272; x=1773676072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wYTf19tFA5Ga8Mvs8jxCIv8fEqitWOTW3VQbunH9IHY=;
 b=VlzFJ+SJHVK4IbUkeiniWXgniAaPLd1Yo8XVNg4L5O1EHJJHUSoEuWQm7Npterr9LH
 faju0wAv5zdPgMPPqkkQcdDI7U8U67OU3Tj6pYZ/LDs4fOmgkP9W4nwW6V9hXJHEDkov
 LpLw4KD//cXAiCP0eTJneAszQUG2SpYQjGFF59GLNaqIYvi3pjA5iQoM98HfF6LPdsEF
 4DsjEqlJPndMvl1a3/9jWrArOnmDPelojfucaC5eBpSy7vQ/UgNMN6M82DekKwJsU3u3
 cS2JoLq+N7Q5plwqy4r8oCdkxqQ+bA/P5M2H0JozvgxFIEug6Mg+i7NilntxSsv+H3DN
 WTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071272; x=1773676072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wYTf19tFA5Ga8Mvs8jxCIv8fEqitWOTW3VQbunH9IHY=;
 b=UowSE6rDDgmVXiwgjWAeQgqQgH1kT2T2jR79pA3srDJPvWNuAYkCWp7pMar2/u3+yj
 0a5jM09o5mkG5q/0C5/hBzlbsXmI5CCpThC9OAX7JNupU35UrvMsWxACFWbBI9cyJFQX
 iRfssUEAQAhPySn1LZIJjCFS6DYldyRUb8MbZZvSGP9eLcy9ZGSXunf6Jmy4Rhdb5EZY
 ZlXwMMXcnclMqusQb1yDD8PWTTYwdX6wZsu3IPWG/z+5gL6FrAkDjfmEzKwcnkItNYz5
 MiTZaJwXbPTLo4fT5EGhkHnMFdscVkdK2/b0mTEgfo4kCPzeofpYxIrRou2s8pSscVZb
 4kqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi6nsiZqkWeGX7jyUc2tnysRRWrBiWHTAaypHUBzSWLB+5FhO0CaHR7eMlr8RAuIeNDPr9y3LqBZjR@nongnu.org
X-Gm-Message-State: AOJu0YzddAzF4PrSntSMVwm0LQCzEHNYeQzw8oCb3p5GqmDQlcvcZsnN
 NxoJxo3kpNvAbm836361k2XW40876q4Y0r+iwd1aPz4mo66Yi+m7QS3nWxJxZOhssnU=
X-Gm-Gg: ATEYQzxLxvcSSzTvgU6BoTp7ZjcrX9472yvo3z+jN3NzbQ9wCgfnmqn1Hjcp3U5ctaI
 lcIGRCkv6HrHTCIhYdVzc7RzMDPGYTRbMLJ3HfvRFC6oy4xou4j8k5jLXWNExqJTosGRLwuDJKC
 C2QPif83iungxN4kMzQvYUoRjQQVTw2vcjKJ5NfvlklK/Q8ms9YMlyW0D0YNqgbIqWWKNpJ/iVm
 xxrREIP8F9mq7xgd/of9JFUcTKN2b7uQq+uKTl4lqRGGcadnOqGZJZeNnP+1cUbdvXbISso3FYQ
 SW0vIFAn2yLcgdLRMFMtdGawYYcjiRP5a3/RSGz7KxmTzGOFJRb9NaEWDlF2wAX+HMsJY542xua
 NJSklCCrjM/gQUc2Jz/0twBk+cA9sIgmyoP343bEsMvWoXmAHz5RaQW+rJBd5ooXsgKnLOg40Kn
 ENJNRmCpm9Y9F131VY76vAKGjHd+KJKLZ1STv1jcYLB0MQm9O34meh63rdWKLZnUGjhw==
X-Received: by 2002:a05:600c:a09:b0:485:419c:4eba with SMTP id
 5b1f17b1804b1-485419c503amr1339195e9.1.1773071272163; 
 Mon, 09 Mar 2026 08:47:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba06sm29272097f8f.24.2026.03.09.08.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:47:51 -0700 (PDT)
Message-ID: <9e175373-49e6-4ba0-af0a-792df5239f9d@linaro.org>
Date: Mon, 9 Mar 2026 16:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/sifive_e_aon: Don't leak timer
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
References: <20260309095129.1406506-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309095129.1406506-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/3/26 10:51, Peter Maydell wrote:
> The sifive_e_aon watchdog creates a timer with timer_new_ns() in its
> instance_init method, but does not free it in instance_finalize.
> This means that QMP introspection of the device leaks it:
> 
> Direct leak of 48 byte in 1 object allocated from:
>      #0  in calloc
>      #1  in g_malloc0
>      #2  in timer_new_full /home/pm215/qemu/include/qemu/timer.h:520:21
>      #3  in timer_new /home/pm215/qemu/include/qemu/timer.h:543:12
>      #4  in timer_new_ns /home/pm215/qemu/include/qemu/timer.h:563:12
>      #5  in sifive_e_aon_init /home/pm215/qemu/build/san/../../hw/misc/sifive_e_aon.c:286:21
>      #6  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #7  in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
>      #8  in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
>      #9  in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
>      #10  in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
>      #11  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #12  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>      #13  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
> 
> Allocating a separate QEMUTimer with timer_new() is not the preferred
> interface (per the comments in include/qemu/timer.h); switch to an
> inline struct initialized with timer_init(), which we can clean up
> with timer_del() in finalize.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Incidentally I notice that this device doesn't have vmstate support,
> which is unfortunate -- devices really ought to either support it
> or else install a migration-blocker explaining why they can't.
> 
>   hw/misc/sifive_e_aon.c         | 16 ++++++++++++----
>   include/hw/misc/sifive_e_aon.h |  2 +-
>   2 files changed, 13 insertions(+), 5 deletions(-)

Patch queued via hw-misc, thanks.

