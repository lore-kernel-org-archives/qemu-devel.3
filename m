Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5C9C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCaG-0003JK-P0; Tue, 09 Apr 2024 10:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCaA-0003Dv-MR
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:36:22 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCa8-0002lH-S0
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:36:18 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so60262201fa.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712673375; x=1713278175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1y7ONgYzzuVX+v2KfoKFecZF0j7kC1NfAZ8boavzSE=;
 b=fFA0Z4AIkY7Rs5PCn8qUeIxXFUG/neGOoZzfb1NHukySUJK9xnTzXIsAMwy5xTJg2j
 Nzcka+dvmls1WxkQWZ9uh9w3gvXeAElv8NrGPiRrvbpAHL6FO+JnJoLu8FEhJLGF0qMG
 OKmKL4t1KdgrOpAeyt4uhK8XIeS+ajw+P97wOUPUEHxXRehIjuIKhsh/afbBcZTIfRxE
 QDzj+qtImhUCErj0aK77AEJ+RQmqYhh/zWbbrKuUhwkjwjm2BNz2ynRA2VFc12IQsC3k
 wghLStkal61f5Kw++MG5e5tYe2zq/2l0nEsU44A8Qf9A9550sReLrIIuLKyLv36nqdzB
 V9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712673375; x=1713278175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1y7ONgYzzuVX+v2KfoKFecZF0j7kC1NfAZ8boavzSE=;
 b=Ei+FmAG4raY9Aas10MvO3a+FDP2CxN1RWolpOAELHtq0Qg2ba/6oYH9nh+bL0pEAOa
 6wa/wn9UEVQ2L1g2QU+WmIqFdSLXpFDrfznH6WDeNSxTz9AM9jZ/+78RPaPQTWqLaW9v
 a3WFVw2xiHJQywNmcwgsRLO52BTNWsaTLzmipIcSaIvMdwtuWBooH0KiIBmelEdnjAPh
 GAqopCC+WrvXTGF+8Mjbiyk3c66bshaGv2k0S02bhWk0l9qUsrQ9WyiXpjWaOWgGQPCz
 TdxDR8y5IImFFjD6uv8xWmYLZoJCTDtDYR5q2g5vx3o17Iy9YK1BqZueWf8PTYJeC9Z+
 Pslw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkM5h1cILTqp4m0Xr6U1C1anZyCMhXZXnc2nRmx6auCIYB7PiQHJ66e4btqfBixiiJhrmZjt9VaSIuOnz/CYbrNpp+Yd0=
X-Gm-Message-State: AOJu0YxkZbDR0lWfwFLH1/rZ7TyBmGj+10ZtPw4lxc6t70CqJYWDZiWN
 DMkSOroWi9RIXtonEq0gJpoMIQHHujo+5M+xXq/Mm/ki7YEq30d5NQREhRkvi+E=
X-Google-Smtp-Source: AGHT+IFQdb6v/bv5gUnbxLZIknJix8A9xKEZ9c6wm8Vr/AZBZK/VIsjxMHdsqLraGl9Pg19ukBsecw==
X-Received: by 2002:a2e:9209:0:b0:2d8:11cd:4223 with SMTP id
 k9-20020a2e9209000000b002d811cd4223mr19513ljg.2.1712673374809; 
 Tue, 09 Apr 2024 07:36:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a05600c1c1600b004165315d885sm10362148wms.11.2024.04.09.07.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 07:36:14 -0700 (PDT)
Message-ID: <c754fce7-2466-48e9-8508-27e46e80f9fd@linaro.org>
Date: Tue, 9 Apr 2024 16:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2] backends/cryptodev: Do not abort for invalid
 session ID
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Alexander Bulekov <alxndr@bu.edu>, Zheyu Ma <zheyuma97@gmail.com>
References: <20240409094757.9127-1-philmd@linaro.org>
 <6a36727c-0104-4631-bd18-41c4b0befa00@bytedance.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6a36727c-0104-4631-bd18-41c4b0befa00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 9/4/24 12:23, zhenwei pi wrote:
> LGTM, thanks!
> Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
> 
> On 4/9/24 17:47, Philippe Mathieu-Daudé wrote:
>> Instead of aborting when a session ID is invalid,
>> return VIRTIO_CRYPTO_INVSESS ("Invalid session id").
>>
>> Reproduced using:
>>
>>    $ cat << EOF | qemu-system-i386 -display none \
>>       -machine q35,accel=qtest -m 512M -nodefaults \
>>       -object cryptodev-backend-builtin,id=cryptodev0 \
>>       -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
>>       -qtest stdio
>>    outl 0xcf8 0x80000804
>>    outw 0xcfc 0x06
>>    outl 0xcf8 0x80000820
>>    outl 0xcfc 0xe0008000
>>    write 0x10800e 0x1 0x01
>>    write 0xe0008016 0x1 0x01
>>    write 0xe0008020 0x4 0x00801000
>>    write 0xe0008028 0x4 0x00c01000
>>    write 0xe000801c 0x1 0x01
>>    write 0x110000 0x1 0x05
>>    write 0x110001 0x1 0x04
>>    write 0x108002 0x1 0x11
>>    write 0x108008 0x1 0x48
>>    write 0x10800c 0x1 0x01
>>    write 0x108018 0x1 0x10
>>    write 0x10801c 0x1 0x02
>>    write 0x10c002 0x1 0x01
>>    write 0xe000b005 0x1 0x00
>>    EOF
>>    Assertion failed: (session_id < MAX_NUM_SESSIONS && 
>> builtin->sessions[session_id]),
>>    function cryptodev_builtin_close_session, file cryptodev-builtin.c, 
>> line 430.
>>
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> v2: Removed error_report()
>> ---
>>   backends/cryptodev-builtin.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, patch queued.

