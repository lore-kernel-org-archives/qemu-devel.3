Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC94C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rea07-0005IB-SX; Mon, 26 Feb 2024 07:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rea05-0005Cc-8C
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 07:22:29 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1reZzz-00065x-Jw
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 07:22:28 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so12480115ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 04:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708950142; x=1709554942;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cDlHDrC2sXx/wFIpF7ENRE5ZHGFJqcpEgzRWGY9SY5M=;
 b=RBVZlXCxkwQnBKa/et4HcGrvdfuArIpp4qrLDuF46Ivbnx6J8VK2i1Ou0t+2EythtV
 6qVFTIg8WGBirhASrYASK5rkrYlPmRog4BewSqcagSTADeEb7Rc5ua98YeMQq5BwgN7s
 Oi0oUjgbxbO2CduFjHA46q/mkeK3UEPQb5ECfRiuEiHY1vwQyVJZ0gCzcKUbli9+KxjU
 Wo7LRfLAT81vS4EtAaxncfu23ShMcHjKTICvl354/RtKc0q2WLwbyQxWXqTXKR+r/XeH
 coq8pZzDluTc1/Vn6WbXN1/PemDpOksnjiuIQkQyMQMspvLlENMP+7R0YL3zRiFw2kQT
 TVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708950142; x=1709554942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cDlHDrC2sXx/wFIpF7ENRE5ZHGFJqcpEgzRWGY9SY5M=;
 b=KSu87lwxMru+jJMIt6F4q6DpeJQZsVPuYthXIaik7tjE9kGkKTFOVFGq0AwKCRPTP5
 W14YkqCzxWN2KMNsF4rfOGD0keh9eUeNpg4HMgQfQ6EAIjFUkRk2t+8XzGdgCd44a8vc
 5ZIWkK8O5kvrDxkRdgpHY5DvJZn0hmYb7ZEppq+H8Yyj6JoYcnG3VbA78SVDeSdTAm2/
 vksZBLVqo7Kn28L697mHK7k97tB07u4HsBzbxvARYwcffym1/QwACDtmiXWsFB3OJA88
 EG/Yp09av83gawLOe2x+dk7w6NDjaAVevlJk9PvIjyJFhzvBuhZ9inZXY2bMGf01tn4r
 5EGQ==
X-Gm-Message-State: AOJu0YzPOjPHIDtVkhuPRFn+T3khCufPm071cmkNf5YYPIgfZky1emHq
 n0gYUh4EAS/3aKL/qT7khNcmCblRKiSkNXLcCXBK+y4+pRJNr/nBLuT5l7xiXhY=
X-Google-Smtp-Source: AGHT+IGujwpUcOVein8hvIc4zxJU7gkmldLs7Wdd8XjfOVtMmR3NGgwcvrIXettxCaZdoiq1724PjQ==
X-Received: by 2002:a17:902:aa81:b0:1d9:3843:3f07 with SMTP id
 d1-20020a170902aa8100b001d938433f07mr6396069plr.61.1708950142073; 
 Mon, 26 Feb 2024 04:22:22 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170902c3c500b001d5f1005096sm3801042plj.55.2024.02.26.04.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 04:22:21 -0800 (PST)
Message-ID: <691af6af-bc4f-45ce-b017-7a82269e9381@daynix.com>
Date: Mon, 26 Feb 2024 21:22:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/27] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
 <20240223162202.1936541-22-alex.bennee@linaro.org>
 <2a7f0e06-0bc9-4fad-add7-9675a4cc2a0a@daynix.com>
 <87y1b7eay6.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87y1b7eay6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/26 20:12, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/24 1:21, Alex Bennée wrote:
>>> We can only request a list of registers once the vCPU has been
>>> initialised so the user needs to use either call the get function on
>>> vCPU initialisation or during the translation phase.
>>> We don't expose the reg number to the plugin instead hiding it
>>> behind
>>> an opaque handle. As the register set is potentially different for
>>> each vCPU we store a separate set of handles for each vCPU. This will
>>> become more important if we are able to emulate more heterogeneous
>>> systems.
>>> Having an internal state within the plugins also allows us to expand
>>> the interface in future (for example providing callbacks on register
>>> change if the translator can track changes).
> <snip>
>>> +
>>> +/*
>>> + * Register handles
>>> + *
>>> + * The plugin infrastructure keeps hold of these internal data
>>> + * structures which are presented to plugins as opaque handles. They
>>> + * are local to each vCPU as there can be slight variations for each
>>> + * vCPU depending on enabled features. We track this in
>>> + * CPUPluginState.
>>> + */
>>
>> Since we do no longer coalesce registers for different classes, I need
>> to bring my old question back: Why don't you just cast register
>> numbers into pointers and use it as handles?
> 
> In the interest of getting this merged before the fast approaching
> soft-freeze I shall do this for now. However once the plugin system has
> knowledge of individual registers exposed by TCG it will need to track
> internal state so will need some sort of container for that.

Indeed it's likely that we would have containers for registers, but we 
don't know who would own them yet.

These containers may not be held by vCPU classes as you previously 
proposed because we may support different configurations of one vCPU class.

The current proposal to allocate handles for each vCPU may not be what 
we would want to do in the future either. To support SMP debugging with 
gdbstub, gdbstub must know sets of vCPUs that have identical registers, 
and once it does, it's better to allocate handles for each of such sets, 
not each of vCPUs.

Let's figure out how we should manage containers when a need arises.

> 
>> You can even just expose gdb_reg_num with the interface.
> 
> As I have explained before I don't want plugins to treat the handle as
> a pure index in case they start providing numbers that aren't in the
> list provided by qemu_plugin_get_registers.
> 

You can assert the given number has an associated name.

