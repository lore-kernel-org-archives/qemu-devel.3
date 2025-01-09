Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56451E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvGe-0000Bw-Gb; Thu, 09 Jan 2025 11:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVvGc-0000Bd-Oq; Thu, 09 Jan 2025 11:20:19 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVvGb-0007YH-6q; Thu, 09 Jan 2025 11:20:18 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so169534466b.0; 
 Thu, 09 Jan 2025 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736439615; x=1737044415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVjsqWNID5T6unoJIkQGaZ8P2szq/f5Opyaqt1sGYvo=;
 b=i4NmSczpkg6sHe2QQOkcynqw8t/vse+/t9eccYm6WVeGdIpT6uZhmL46ppWMwqUaDf
 Sy97eNT0PM8tFkYcaRcbw39TcRI1wKxQ8i5rp86EyZ+tZfl+P2CYnteJ+HvQFYD9JLmC
 02FK0Jhi/darpOpb7OP87dBTdnG/3fu3iw/WK6CVW+Eme1y2Z/3PhPrFguy492aYXOeQ
 j/g4StKCJmo5D8z5DCeGfhoQAk44/N/ClldpPAi6lG/bP810k5CYhvhMzqVIvwoBuwML
 QOiZcEPg1YIxsSAPs5VulQfqcLGkX0U2s7eNIo691mvXWIqgafhod9ogOspYiqv99veP
 Xesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736439615; x=1737044415;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVjsqWNID5T6unoJIkQGaZ8P2szq/f5Opyaqt1sGYvo=;
 b=J3VYtH940qxaVAGkO9uiPJxz+gK++E986Ip7k9acOLkw5o6jPezgIllOGx34x4nTGo
 oDJWFSNlJ9jxNS7MLz2UMVGuWIxwPYFKs7LgBdj+v0YHPfFtMmL4cwuS8Sc3r3ezFBvy
 74+ZZw9OP9bbD/stN25oeWaSFoXtZ+dKAhQfDr2qYWFPZUo3rFC1LZIbR9Olpaz1P5o5
 cK9LJvSBkvi6e1gPZS1C7NP5YREmYFjCTvrzXSK5f/AA2Ke6NfpmKlkm++m1f1qjHxzo
 WULok6Qz4HCm0Q/PtyDj7gMtMRPNYlSArBtRloD7B4ypip3LHpY8aMAWACV5MS7r2RJv
 /Nwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdVs2G6+FMpvH7Jjwmx5zEmRkutT3LdMUYkPWrRfSTvZ3XDTw/keXswi+fwN4FpJ86r6wwgXi56Q==@nongnu.org,
 AJvYcCWbcpMsYJPo62Rhe2I7Fjhf0SMB9yx/+jvVEOHcrSS/Dn8H2XqtVcXm6ZREl2qtc78BYLV3cdneRf+Wcw==@nongnu.org,
 AJvYcCXVh7lIlJqqkwupPc+DqursgQw3nm3o4rCVvZyPAqWTkT9E/djYlIfkWtqjtPJ3swnm5+vCZ4Iz82Wc3w==@nongnu.org
X-Gm-Message-State: AOJu0YzEN4P6UhaUlHtx0aVRCZBfYoP0HF5zwg7kXtpDpfibwUFgbST+
 5s+sqtLhBqcsMTpNgB0aLlhK0c21JxX352k164zJ70fk1wUuwlhj/SToOQ==
X-Gm-Gg: ASbGnct8gJxuMRddIFvr/llhkvIE2R+WqDvXqO35YGnFjpel+A5i8wxcFN/UMHAoztS
 N8hcogB2tlrtpGxnIc9CQXYhx2VR9k4muqjsaBt/bFHpB6Xv1JRz+e63T3jIAG4umonsnBQ5wlx
 fY6qc0YbYN5Cs2H5jFdzg0/zuY/Zv+FJbU4hWhsRKmcVCFOmqEfd/8qQoSzBaeL0wTnKMBJlu7S
 lO0P3c7CrE5LCRJFUxh3NsuguX7lKN5SwKGN7yxs1uo7pVKpSewDqXtqFA3shX6HgxSy63Wx0Yd
 KEkx1jwXuvK6uqTsZiJsACLeFSs=
X-Google-Smtp-Source: AGHT+IEV8ikYJDp7YTRCsW92y8D4+doSayXIuC4/rlZMjvkLHx2SLnpHpamcusx2WS/nXCsWwK2WHQ==
X-Received: by 2002:a17:906:f5a2:b0:aa6:8676:3b33 with SMTP id
 a640c23a62f3a-ab2abc6e768mr545857866b.47.1736439614538; 
 Thu, 09 Jan 2025 08:20:14 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c96468afsm85734166b.170.2025.01.09.08.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 08:20:14 -0800 (PST)
Date: Thu, 09 Jan 2025 16:20:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_08/14=5D_hw/sd/sd=3A_Allow_for_inverting?=
 =?US-ASCII?Q?_polarities_of_presence_and_write-protect_GPIOs?=
In-Reply-To: <342ca371-3e14-4108-9c45-e15cda51b9ca@linaro.org>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-9-shentey@gmail.com>
 <342ca371-3e14-4108-9c45-e15cda51b9ca@linaro.org>
Message-ID: <FBA535B4-8191-4CEB-905F-FA4C3416048C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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



Am 9=2E Januar 2025 11:40:10 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 8/1/25 10:25, Bernhard Beschow wrote:
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/sd/sd=2Ec | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>
>
>> @@ -876,8 +878,8 @@ static void sd_reset(DeviceState *dev)
>>       sd->cmd_line =3D true;
>>       sd->multi_blk_cnt =3D 0;
>>   -    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd));
>> -    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd));
>> +    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd) ^ sd->readonly_a=
ctive_low);
>
>Please embed in sd_get_readonly(),
>
>> +    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd) ^ sd->inserted_a=
ctive_low);
>
>and sd_get_inserted()=2E

Are you sure? I deliberately implemented it as is because embedding would =
change the internal logic of the device as well as SDCardClass::{get_insert=
ed, get_readonly}=2E

Best regards,
Bernhard

>
>>   }
>>     static void sd_cardchange(void *opaque, bool load, Error **errp)
>> @@ -896,9 +898,9 @@ static void sd_cardchange(void *opaque, bool load, =
Error **errp)
>>       }
>>         if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
>> -        qemu_set_irq(sd->inserted_cb, inserted);
>> +        qemu_set_irq(sd->inserted_cb, inserted ^ sd->inserted_active_l=
ow);
>
>Use sd_get_inserted(),
>
>>           if (inserted) {
>> -            qemu_set_irq(sd->readonly_cb, readonly);
>> +            qemu_set_irq(sd->readonly_cb, readonly ^ sd->readonly_acti=
ve_low);
>
>and sd_get_readonly() here=2E
>
>>           }
>>       } else {
>>           sdbus =3D SD_BUS(qdev_get_parent_bus(dev));
>> @@ -2797,6 +2799,8 @@ static void emmc_realize(DeviceState *dev, Error =
**errp)
>>     static const Property sdmmc_common_properties[] =3D {
>>       DEFINE_PROP_DRIVE("drive", SDState, blk),
>> +    DEFINE_PROP_BOOL("cd-active-low", SDState, inserted_active_low, fa=
lse),
>> +    DEFINE_PROP_BOOL("wp-active-low", SDState, readonly_active_low, fa=
lse),
>>   };
>With the requested changes:
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>

