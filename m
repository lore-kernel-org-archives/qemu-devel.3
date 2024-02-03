Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC8C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 11:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWEAY-0005dJ-K0; Sat, 03 Feb 2024 06:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWEAW-0005cs-Pq
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:26:44 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWEAV-0001jh-Ao
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:26:44 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29026523507so2432962a91.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706959602; x=1707564402;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JP7fjve27cRWZSwtQL1qGz21c5P7C8MIPbzmVOFgw6M=;
 b=lBakW8nXma5mTr/yiZJ6q08gOLab7gOXioNSuLGpHEEE9tHh60pIxclVk4PQSYPDXt
 aMb7vlUfdut623LTlylI37Zwlqvy2xOZ7GcKSwnmI5DVQ6T3a2NsOlO5Cn9ygVmurCCq
 VZbAXOz0QWNgEqE07lB92Qe+HQY/k30rUpLcuvDdiejHo/hdf3Zyo+j4VNYV5oA1WYd4
 +ckaq5X9eMXXec2vRVBZjOiADhxJQXpBOeg1ExUEGfbncy7/3oIy15C3KHyu17bg5Nwy
 TW2ssydfGpi9nLZXlCN9XnK50FiRgtatEAdn0a4n4cv+/6Wp8iWi6+HAUfllDQ3Reim2
 sUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706959602; x=1707564402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JP7fjve27cRWZSwtQL1qGz21c5P7C8MIPbzmVOFgw6M=;
 b=M6ptCutrFXlMapm/bXum61TAfETiU9K25gFBqXFjWZKqiOuMjVw+bsFWl7AuyspoML
 nKEGW+auVDO09Z3rt9WTtR/9NawKwn1iro5tO3XaZ29enq7ysN7TfN9LmG+EZ4ygP/lO
 zNspJLB5N71FfEnh0dxl2nAhkcjVxw/8EyNh5OHLHBL0Ex7ljTHxicreC4ErfZkPZRK0
 bygi+og9l4xPPgbQ3LKb8bbuGOvvBFsjbTXgeI8ok7PeWLQkOCzCWcu64A7RH10wJ2/W
 o4Hbqg69P+zBHbN970RFSP2tGtsaIMfD7b6Pbg/mZbqk+LLWIUdAat5nh5nuHyAZQYtZ
 OjkQ==
X-Gm-Message-State: AOJu0YxNG95oJLZMlLnR36y1e9nuHcnTsEsjYHCPuVPCoMtE3NS1nnbx
 E1OHYLzOBR59KddxxerayvKHrlg4ZmIacS0x3DOlmnSwt66WrnS9fKuCZbgISHk=
X-Google-Smtp-Source: AGHT+IHB0WShbtdUAlVGkZswHt5OQoPU9Z4WM8IgqgcSGcH0G6AUtNwxMpu3S6irZSib9eczQ5zSiQ==
X-Received: by 2002:a17:90b:1915:b0:296:6a74:bfcb with SMTP id
 mp21-20020a17090b191500b002966a74bfcbmr692836pjb.47.1706959602033; 
 Sat, 03 Feb 2024 03:26:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXLRJuZ/35WGejiqPCI1E2Mf9dhN/OFi5ISUd2hS9PKQRMOmRwU+LLwEqu60j4mEd+aWetUgH9pl3QLWcH/YLBMgBunUaboiQqpChp6So9JdN3uCfupbOyX7Eu2nIuvIc04gWyNKuUjbFAdygdZRnssO1rT6I4czf9AW3E//b/tkYbATHoEg/OOlBBlXildR+HPtEwXnRG8ACOoAcaC0SUTchVccVOB/JcWS1cfvGofat/bRlMEKuf8sQadNzOSbJaevS5ixFLSkDwZo53MPK1B/nKAZEUjVL5260c7aEguU60Pk8YJiYuwrwVYbAGvYlctVdANpcIPnRXLrMQTQYgQ/h4BWYZGnTE2BH5Dac+wxHFmXcZeCO7woCo5xegaIt1s0cM+/1y23X62Km6F3LoM0vQMFDibFCzV/OMWUMl6I5KH
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 oe12-20020a17090b394c00b00296743c9035sm197080pjb.21.2024.02.03.03.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 03:26:41 -0800 (PST)
Message-ID: <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com>
Date: Sat, 3 Feb 2024 20:26:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
 <87bk8xpzyl.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87bk8xpzyl.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/03 20:08, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> This series extracts fixes and refactorings that can be applied
>> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>>
>> The patch "target/riscv: Move MISA limits to class" was replaced with
>> patch "target/riscv: Move misa_mxl_max to class" since I found instances
>> may have different misa_ext_mask.
> 
> As this is re-based on Alistair's riscv-to-apply.next tree I'll wait for
> this to go through the RiscV trees and then re-base the plugin patches
> and dropping the merged riscv patches from my tree.
> 
> In the meantime feel free to review:
> 
>    Message-Id: <20240122145610.413836-1-alex.bennee@linaro.org>
>    Date: Mon, 22 Jan 2024 14:55:49 +0000
>    Subject: [PATCH v3 00/21] plugin updates (register access) for 9.0 (pre-PR?)
>    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
> 
> For:
> 
>    contrib/plugins: extend execlog to track register changes
>    gdbstub: expose api to find registers
> 
> So I can add this to my maintainer omnibus series for the next PR I
> send.

I added one trivial comment to: "gdbstub: expose api to find registers"

"contrib/plugins: extend execlog to track register changes" depends on 
"plugins: add an API to read registers". The comments for the patch in 
the following email are not addressed yet:
https://lore.kernel.org/all/4b2156ed-688d-4617-b52d-200413f01156@daynix.com/

Please check them out.

