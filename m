Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F049C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rme1d-0000Gh-E2; Tue, 19 Mar 2024 14:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rme1X-0000Fi-24
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:17:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rme1V-0001TU-LK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:17:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56b8e4f38a2so1873489a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710872235; x=1711477035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtpK5fBho7BrjSL7qakMLYqtd+Ktooc+QK9cHywYyJY=;
 b=dbroMd6TJw0sJI84KF0G+vfgrUMIJzmwSBns8mnCoq3waWi1ZE3WHRAKvYZPz4drcO
 Tx57nK/FrtKVHyjnwPrb2JdQs9n1bZ907w9QXDC+AKCq00fjIabnQAC8nXUx1s5NkkSd
 eaqPJ7U3rcup0AtrBejpDsNjssWrHrjjTT29gq4UemfWTyeerNjnDtZaVvBfhLlOaV1V
 fd/FHAOGeJG0geuY0dpRhieFp7NPQuy1dwSp9nL02XyFH4sqTUdBjHnISt6nSBzDdWQ8
 l4iL/ZUG0ebztzQW4EofhEFxbNr/JXjaFU26iOQq4yjcvgPtp5HWpGu9KraGo7hJQXyz
 nuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710872235; x=1711477035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtpK5fBho7BrjSL7qakMLYqtd+Ktooc+QK9cHywYyJY=;
 b=SHbMF9Y3ImvRbVIm9VOkvcVGb+UYYxxTunKRTZoUd6/3nS/nIpSqNu6GxG2xyEo6p7
 Ah4Jy7W8vr+66Z4HeZWMHIkhLKvmBY0M1LnFoW1h3XfnhZqoU8e1Ifbu6h9u2WakOfOP
 0M7csczJaTt+tCRI9GEE3nPLKy67ooTDsLpaArHnQB4jxikZlTHkcRx+lpLTDrJQEG+C
 Hhvk9RqxIsHh8/K10FXoybatr2Tlo6Aja2X21sxEGOWTx4gz0hkywUyJqLTTOdpcJMPs
 VOeqNjDt6Io0nZARZ7egnJ8Kuljt3Itak88urrwgpXTc+SVc/zGJFHwW3cYVJDpRiQcY
 ritg==
X-Gm-Message-State: AOJu0YxeVh5XITETYEwvtjVsFk/+0khGMqH88oYrmrZgr2x24V/iKsrQ
 wfm+LbkIHqWfvWmGW0fiOUWGxS2r2HJmb/QEOn6OblMsH/fTKZyoyBUI7UslJ5z1A4IjGFmrlpP
 Z
X-Google-Smtp-Source: AGHT+IHpMzdomN2933UkjfiX+YmW7ZNsCtiAq+7gAc/V7aJvuVudJv4TbAlxN4gu16882Vz6QY/N8A==
X-Received: by 2002:a17:906:6d1a:b0:a46:bbb3:f0d2 with SMTP id
 m26-20020a1709066d1a00b00a46bbb3f0d2mr5188166ejr.47.1710872235377; 
 Tue, 19 Mar 2024 11:17:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a17090634d900b00a4519304f8bsm6448897ejb.14.2024.03.19.11.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 11:17:14 -0700 (PDT)
Message-ID: <dde20cea-e4cb-484c-b282-8808cbe9b09b@linaro.org>
Date: Tue, 19 Mar 2024 19:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 5/8] target/microblaze: Restrict 64-bit 'res_addr'
 to system emulation
Content-Language: en-US
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-6-philmd@linaro.org> <Zfm88Hit3Kni1f_4@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zfm88Hit3Kni1f_4@toto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 19/3/24 17:27, Edgar E. Iglesias wrote:
> On Tue, Mar 19, 2024 at 07:28:52AM +0100, Philippe Mathieu-Daudé wrote:
>> 'res_addr' is only used in system emulation, where we have
>> TARGET_LONG_BITS = 64, so we can directly use the native
>> uint64_t type instead of target_ulong.
> 
> 
> Hi Philippe,
> 
> This breaks linux-user, lwx and swx are valid user-mode insns.

Now I see I missed cpu_res_addr. Thanks for the quick review!

> 
> Best regards,
> Edgar
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/microblaze/cpu.h       | 10 +++++-----
>>   target/microblaze/cpu.c       |  2 ++
>>   target/microblaze/machine.c   |  2 +-
>>   target/microblaze/translate.c |  9 +++++++--
>>   4 files changed, 15 insertions(+), 8 deletions(-)


