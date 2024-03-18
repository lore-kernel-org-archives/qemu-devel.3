Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41A0C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFK8-0002iQ-Oi; Mon, 18 Mar 2024 11:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFK7-0002gF-Ua
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFK1-0000bN-R3
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMcQqE8GMOb31Ud1w+AYrfP6VToydno2AAZ1yEo67Sk=;
 b=BgT4dXEX2Y9JaA6ze0Tg01xhvqYmZFevM7XOlQjjoVIk0rJ5PMQMXpWvgqRRmh9u+sIiLm
 n4+lRMZ57zpx2qYynDk1AWa3P3op7R6aAEb7qy5t4fApn1dJLT4JifsaSh2oasXPJZSQgq
 XC4W0qM8yRGTE2gDN8mMGswTSvJ9Nbc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-BA5IiSBVNzW1ZlvV8JkIkw-1; Mon, 18 Mar 2024 11:54:43 -0400
X-MC-Unique: BA5IiSBVNzW1ZlvV8JkIkw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-514b4c75fc5so489269e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710777282; x=1711382082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vMcQqE8GMOb31Ud1w+AYrfP6VToydno2AAZ1yEo67Sk=;
 b=TdEfi+NSDS4/MOqY3bPRw+unfT/QfS6Q3F4Fgnio7L6D4SSiPJW/v0cZSZ9fJn4JgH
 l5mylvmDvrHtIZ3oNUmUE6b+EmLgRyVRsV3WdH6nt5w8Gheu/MLU46EUZgoy4LNGQd6L
 8DSxxo7VP9ISIyPLOF2kvUGrKf2vkcH6U3SInoOTPA7zoYKiprtX6eRHlmU4y1CYIl+j
 FsbSS6a63Cevi9gyqMcmIanOjai6o/LaNN49lwIabbJN1DjBlA5adp3GPa34jWEIwux0
 oqiv+LIhmP+WuzQuMUmqS0gceuRIu5Mru0sWXkBkcwTdAqXFohveF0OpgZ2gRPGfEUaP
 xcOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKkgWhbtzWV3iufoqGpAuGJ5k2zn0nPGydUdBqjfAYgJzFMV40cnBdoYSCf+J+Rt9dTl4enRq40krKZxU1LjZuQcMkJoA=
X-Gm-Message-State: AOJu0YxCCRz57c83JuO+ZPijVTnOtD8PHcEzvpG3LvLgVNrmlE8IUeoW
 gk6xxkcA+YwB4gBr9sQkivk/q7ZRf/e5dVIKz/NFBugOhvu+imAJUBT7rRlNME8Vy9zICFo9UMX
 igebbba8PbOq13W4j7fCddngsfBGbHztM5vwcsKoT8E06rwrRaC7Z
X-Received: by 2002:ac2:4db1:0:b0:513:b8a2:8d83 with SMTP id
 h17-20020ac24db1000000b00513b8a28d83mr8844273lfe.3.1710777281949; 
 Mon, 18 Mar 2024 08:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLsjGoG8MVMPzeEH8GGgHYJLA6/2HMfobCkqTvIU7S5z/y/ubgZD7MYqePJpCK+WuDTBhH+A==
X-Received: by 2002:ac2:4db1:0:b0:513:b8a2:8d83 with SMTP id
 h17-20020ac24db1000000b00513b8a28d83mr8844265lfe.3.1710777281699; 
 Mon, 18 Mar 2024 08:54:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fb4-20020a05600c520400b004132901d73asm15091097wmb.46.2024.03.18.08.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 08:54:41 -0700 (PDT)
Message-ID: <558ea248-5ae0-4ff9-8046-8858339094fe@redhat.com>
Date: Mon, 18 Mar 2024 16:54:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: I2C controller is not user creatable
Content-Language: en-US, fr
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240318154420.220734-1-clg@redhat.com>
 <264f2738-6766-4611-95c2-8341409539b2@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <264f2738-6766-4611-95c2-8341409539b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/18/24 16:53, Thomas Huth wrote:
> On 18/03/2024 16.44, Cédric Le Goater wrote:
>> The I2C controller is a subunit of the processor. Make it so and avoid
>> QEMU crashes.
>>
>>    $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
>>    qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize: Assertion `i2c->chip' failed.
>>    Aborted (core dumped)
>>
>> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/ppc/pnv_i2c.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
>> index 4581cc5e5d4645ab3e358d983a633e33a214c425..37d7b3d68a98d88f201b9a297dbb18678ffdcec2 100644
>> --- a/hw/ppc/pnv_i2c.c
>> +++ b/hw/ppc/pnv_i2c.c
>> @@ -559,6 +559,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, void *data)
>>       dc->desc = "PowerNV I2C";
>>       dc->realize = pnv_i2c_realize;
>> +    dc->user_creatable = false;
> 
> Maybe add a comment in front of it (which is good style for setting user_creatable = false):
> 
>          /* This device is part of the CPU and cannot be used separately */
> 
> or so.

ok. will resend.


Thanks,

C.




> 
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
>>       device_class_set_props(dc, pnv_i2c_properties);
>>   }
> 


