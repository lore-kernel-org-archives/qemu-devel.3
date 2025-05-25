Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B34C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJGjV-0001iy-Ri; Sun, 25 May 2025 15:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJGjU-0001ik-5a
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:10:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJGjS-0005QU-Bc
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:10:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so11763035e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748200200; x=1748805000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a/EuDC5lMwk7lNciuUI5wEWbaDayqJ3KVMIvJeEB21o=;
 b=yUkioJikD9Wv8LfNvEVE/F0rfAPOffZR13mqnENaG8S7Ni/fsQw9xkHP6PBfK055P2
 cOdJ3jZneZuPHjHBNZUHdeOCYEuwOyW7iJBdf6JZqi1aWbbcr62x2+kfIxQEZCJR2Jum
 2tInjMdJxWlAWzYavj1uyh+BoWERLxeL30RbGe8gS6TOAca8Y780M5huEkT1lrAxY0J6
 mVJPdgv0kENEJgwHKfdmVDoFjFIrz0jYiaKAfplSmZd/ZWzY9hk/otpifl3JdTEJWAGQ
 ptwhSlBKqMXZ5Bzd7+p+JJjy5SQasNpdOE21kgBX+hdAW3BqZWXf8WtvcjSnuCTypGyB
 zJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748200200; x=1748805000;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/EuDC5lMwk7lNciuUI5wEWbaDayqJ3KVMIvJeEB21o=;
 b=NHpe1SqQUYjCHPMm9xp1xMwSSE2U/s7sLLYYRMMu+ToOBH5/65ucaKhxBNZPypb7Tk
 VU1F3tX4uRAdKwul/Y44LaIJezBlWiLOu2nEpphTG5Kq6eYaelrGd2av5KNT3NLhxw7x
 2kAaeJp83n3sFGccpWs0cFwEx1ug0fETkXRBUbgqTUgATytyiSLU60WIEA0/jmPkHm4B
 mO6wUFDWV9ljkG361RWBleV3QsCT/gaT11hO5ozESiFDRCQx5sGnKNdjKy9hZypbfYFH
 ve9GP3hodnnVRaj/4OQ+rtRUtI8zedlnCnc32hGsd312arS0XWl63zk4zccxWCfxdzCw
 5HWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOWQRjNlTa9xgodQe8NuAPG2xyi4Tpf2H/LXpGO6gV+1KZ7m6gRe2oQn6WW5MiSrNcdsokpkAQ2uLB@nongnu.org
X-Gm-Message-State: AOJu0YzlTCg5XoDbw/wzMB3m66Ld0Ia2dRI2bYM4ha64YxU0KLkQ4+gC
 HaIjy9f6NPjb3N3LGO9XkJCz/WDmzo2WJ5HWCIVmleP8v1EOehGY7WiGCngIbWsrbVw=
X-Gm-Gg: ASbGncsI/JdsDCPjM4paZHGfwvPJDn5ShXd1Pkxe03UKQgFe2WKBLauYmdMBoQ5rnh3
 a/ymnNVe7FVg3Y9rUM7PT0HonBbWkesMin+6yj2MSHXFt6yacWe+c64Hb5vedfESk00QRiqXPHW
 Tq0paekyBZDRHB5/mYi2NT5Almz/p8MCXcU5307gxaK45I1I65PYNPvY2Z8Vea8IO17Y7cbzA/E
 TmfWmBXsfIxT4vkBNFRT13TLB1WoVe0vbdW/QQ8Cl6oKZpiQxB40oBOovkKKvDyTywG7eRZzEU+
 4KBgzTyIJo8MSbxhqKLp4alku9jDqeY5H5AIynfGWVSYdQWRJuD/GzIff3dqmUrg75Xos80qJRd
 okkde93duNbmGZPqoFCXAjJv2
X-Google-Smtp-Source: AGHT+IFAizI5Tb7Jvs/CKOGpzii2iOYgGVCjYzYTO3d3y401TbBKbTgswfLbN/NGxPl9NaUd+b1Iaw==
X-Received: by 2002:a05:600c:3f09:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-44c7ad31729mr63531085e9.8.1748200200591; 
 Sun, 25 May 2025 12:10:00 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c9220245sm6191818f8f.23.2025.05.25.12.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 12:10:00 -0700 (PDT)
Message-ID: <9f5fddbd-8989-4549-af89-87a19cb68a19@linaro.org>
Date: Sun, 25 May 2025 21:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/microblaze: Add endianness property to the
 petalogix_s3adsp1800 machine
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-2-thuth@redhat.com>
 <00ec097f-b43a-4831-b4b6-c5d20aac236f@linaro.org>
Content-Language: en-US
Cc: Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00ec097f-b43a-4831-b4b6-c5d20aac236f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+Markus

On 24/5/25 13:55, Richard Henderson wrote:
> On 5/15/25 14:20, Thomas Huth wrote:
>> +static int machine_get_endianness(Object *obj, Error **errp 
>> G_GNUC_UNUSED)
>> +{
>> +    S3Adsp1800MachineState *ms = PETALOGIX_S3ADSP1800_MACHINE(obj);
>> +    return ms->endianness;
>> +}
>> +
>> +static void machine_set_endianness(Object *obj, int endianness, Error 
>> **errp)
>> +{
>> +    S3Adsp1800MachineState *ms = PETALOGIX_S3ADSP1800_MACHINE(obj);
>> +    ms->endianness = endianness;
>> +}
>> +
>>   static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
>>                                                       const void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> +    ObjectProperty *prop;
>>       mc->desc = "PetaLogix linux refdesign for xilinx Spartan 
>> 3ADSP1800";
>>       mc->init = petalogix_s3adsp1800_init;
>>       mc->is_default = true;
>> +
>> +    prop = object_class_property_add_enum(oc, "endianness", 
>> "EndianMode",
>> +                                          &EndianMode_lookup,
>> +                                          machine_get_endianness,
>> +                                          machine_set_endianness);
>> +    object_property_set_default_str(prop, TARGET_BIG_ENDIAN ? "big" : 
>> "little");
>> +    object_class_property_set_description(oc, "endianness",
>> +            "Defines whether the machine runs in big or little endian 
>> mode");
> 
> 
> Better with Property?  You don't have to write get/set...
> 
>    static const Property props[] = {
>      DEFINE_PROP_ENDIAN("endianness", S3Adsp1800MachineState, endianness,
>                         TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : 
> ENDIAN_MODE_LITTLE),
>    };
> 
>    device_class_set_props(dc, props);

DEFINE_PROP_FOO() are restricted to QDev (DeviceClass). Here we have
a MachineClass, which only inherits ObjectClass, not DeviceClass.

Markus once explained me the difference between QDev properties
and bare object ones; I asked why we couldn't make qdev properties
generic to objects, but I don't remember the historical rationale.
QDev predates QOM, QDev used static properties, QOM introduced
dynamic ones? We definitively should document that...

