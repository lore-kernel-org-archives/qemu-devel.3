Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6805C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZ5Q-0008KI-3u; Mon, 10 Mar 2025 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1trZ5K-0008Gt-9a
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:06:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1trZ5I-0003uN-FG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:06:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22548a28d0cso40257075ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741597561; x=1742202361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:references:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hs7+unaKl2CtCEMbcrC+vLxqiUsD7/N7LF09BCQ50TY=;
 b=HRuJF/cOLobWfPBsfnq31v94/L0s0vlfaImRGkp/+6yBIn5+wV57MJ47mCAH98aad8
 sB1j7xTBeaeVo9J1XxaoONFLu8nVUPwJKHUNYaI+/xhM2wUnkTHMBmRecyTq3sm7rkLl
 sp3cwkC30JvFuOraOO7DdWYegpB/VmEBh6izgEafCAPBpnd/YKR1NKYW833q9SLH1HrX
 hBhzO7gw19Zpt7dirqasphHip5PJL0wHA+f8t47jpkoZydXxDQfN/shBIzHCaQBIbqlg
 hJLVHfaK8K0RmtVQC6RvpEJmLh9fzcSPDJZwiH6RXPNmh9Sc3LJybpTTsMfCVKJWE2Up
 1JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741597561; x=1742202361;
 h=content-transfer-encoding:in-reply-to:cc:references:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hs7+unaKl2CtCEMbcrC+vLxqiUsD7/N7LF09BCQ50TY=;
 b=mOh4emsSm93+8r5iE2sPk0xxTC/Q/XUOj9SOmFua4U9dZpdXWQJbQBZMpqRHg097Ur
 +Fv4Sl/zVaABaNT0yWW+HVFM5zxCtxK5VvcV4Z+S9zMCnXApp6O9EtunztE5hvBSiCZT
 AyoWG40uYmjSbiJra7iLa4oUS/dVPO/130EnEwL83vfG0qGGvbGuH2ktG8uD3J6N84GK
 +cGgl1r7YpQtK9qeJ6oJcWrY/9GUWJsKzAk4vah76caDMCG0grlKXkH++wt/dNx1yBai
 8LbbLEi6BTFi4d7yA8EeY6J2H/u128RMUTmVTqUrkc+rG4YYidhlPYETVzon7uuQZIQ0
 yEAw==
X-Gm-Message-State: AOJu0YwxMgdx3wgPenji5rDg23DfANTi5k2kuBuRugJELKJhwZm4pvC2
 o2R/I4qlw8ZP1sif+KwbF1HaRc0Ecb8oxL7ATM/8Lkq9etUZfEqW
X-Gm-Gg: ASbGncsuYNxP2FMLSYeW4ZkG+wcQsTiE+urQCSgC2by34wiJNefLDVowZZ6I1YLZdwH
 SZfGXxQdzyeTLDSK96sLCPD3qHbepPS0gCqbT44+rQv7SQoAkxmJR/wZ4Kb/jfz2y10vIprv4de
 EoifcJ4HMoUvScXVzn+TCheZgk9D5PJCxTjgeVZqDICshlT/oNtmbPA0ZLs/tIz49yWEvG2bkqk
 DO1xn+wWaBbfGI0ZOKG0ebjkielIlMmbmTKNzynuZPZy20Bm/m3WNboShLEc+Ie7Qx7pjWD+FnX
 1gZis2mKY/pnL+QgF575ssmiSi2ug0xpqrcMjHNELsHS7X9BVdgxUEVsBmwn
X-Google-Smtp-Source: AGHT+IHp0JPjZvz3saCdbYkqFdxbm/QqI8Y2rhGhC6OFU64E5BTeq0jK6HgCDy1kSr2dgcBTAHrZ8Q==
X-Received: by 2002:a17:903:2f86:b0:223:4b88:780f with SMTP id
 d9443c01a7336-22428895b52mr163817725ad.17.1741597560956; 
 Mon, 10 Mar 2025 02:06:00 -0700 (PDT)
Received: from [101.5.21.253] ([101.5.21.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddffesm72845795ad.40.2025.03.10.02.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 02:06:00 -0700 (PDT)
Message-ID: <ad31f5db-a432-49b9-bb98-0e2315960832@gmail.com>
Date: Mon, 10 Mar 2025 17:04:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: Re: [PATCH] virtio-pci: fix memory leak from device realization
 failure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <7702b335-6e92-47c7-baf9-a384f75a0db3@gmail.com>
 <69cb6f19-d87a-4ddf-9fca-612b30828679@gmail.com>
 <c6bf97bf-df26-495d-9886-dfda55cc99db@linaro.org>
Cc: qemu-devel@nongnu.org
In-Reply-To: <c6bf97bf-df26-495d-9886-dfda55cc99db@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


Hi Philippe,

On 2025/2/28 17:24, Philippe Mathieu-Daudé wrote:
> Hi Zheng,
> 
> On 28/2/25 06:03, Zheng Huang wrote:
>> This commit adds failback routine for `virtio_pci_realize` to
>> fix the memory leak of an address space and the virtio-net device object.
>> If the realization of the device failed, the address space should be
>> destroyed too.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2845
>>
>> Signed-off-by: Zheng Huang <hz1624917200@outlook.com>
>>
>> ---
>>   hw/virtio/virtio-pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index c773a9130c..4b0d8cd90a 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -2266,6 +2266,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>>       virtio_pci_bus_new(&proxy->bus, sizeof(proxy->bus), proxy);
>>       if (k->realize) {
>>           k->realize(proxy, errp);
>> +        if (*errp) {
>> +            address_space_destroy(&proxy->modern_cfg_mem_as);
>> +        }
>>       }
>>   }
>>   
> 
> I think instead we want to add an instance_init in virtio_pci_class_init
> and move the address_space_init call from virtio_pci_realize there.
> 
> Regards,
> 
> Phil.

I have reviewed the relevant code again and found that if address_space_init
is moved into instance_init, it will not be able to take follow-up actions
such as free the AS if device realization failed, thus failing to address the
issue. Additionally, I referred to the code for AS initialization and
destruction in other devices and found that they are managed in device
realize and unrealize handlers. Therefore, I still believe the previous
approach is a better choice.

If there are other potential solutions or considerations that I might have
missed, please let me know. I'm looking forward to hearing your thoughts!

Sorry to bother you again, but I wanted to follow up on my previous email. Apologize
if this is inconvenient

Best regards,

Zheng.

