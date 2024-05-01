Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52859C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 06:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s23ak-0003ux-JU; Wed, 01 May 2024 02:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s23ah-0003uj-IT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 02:37:19 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s23aS-0001MW-J4
 for qemu-devel@nongnu.org; Wed, 01 May 2024 02:37:16 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c74ff209f6so4182090b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714545422; x=1715150222;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSdt5z3KeiUiFaB+5D9an/6yUUGuLeR+Nk3weMxqh70=;
 b=QfkLZy9lvVYVk6Wtlkcgp5bU7rTQKXwKKNp3OcVBNRm/Ez/vXxJ4Q6laYPt6AdBOK1
 GKDwbp6gzV99kJRMe9wuoMt613pRvZ8QNky73SkvMuhNpj7jloBalIGIIq3OuKhkULKO
 WKTnPY/XPhxxmexA8yueF8eRI/FYnJ2XkOheIiDz4jyu2zV9NXvYGAhlfvxVIszrcF5Y
 bedPcuYv7qapg+R/Z86ULA3gu0EgtwthmLBdrrqEhrAU8KyY2xOJVgstYBqMcCT7oP3w
 p+8Z/YZsAuubSDzfRKmDqndrD8Z240yffArAypbP8CxRWgykbMvR6EzA3TgZYgC7orrF
 M/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714545422; x=1715150222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sSdt5z3KeiUiFaB+5D9an/6yUUGuLeR+Nk3weMxqh70=;
 b=NqX0aEw9oo0/XX5DCR5Hx45CKQrM9PWTNjLoZfWXj+munG9bHPJg6XO4A2jbqoBf0A
 ZsF9P8vK79qDd0DH8vME55DT9cWYNoAIXhT4QbxI8hs20jgVnvWUMR3w/uaqgRT5PIMf
 fkYRENfNndztbSsDkt7cBIq1XWHCt4wKtxRVYdF7LvdBKl4gM7j6lsU/Xew628ulKc81
 Sv2+C1wD4x5RzleKXWbiT5lb018aKe0HLCG3AfCPQoo9kMpdLNVXKT67qR9k6GRq8BSh
 t9Md9wBT5W9Ev+SNepeqYXU47nrm6+whwB8lKYX13SjK0teGIQTbOkg37SqMoagYai2y
 kCcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmZpkpKCArmObNRCeQKgJwDjVwHPGD1jAoVTyLGEDwU4nJpLF7Bba7HgDGb8OwFADGw7t8/7Y7A8pcbE0L8m+QgzZTnMw=
X-Gm-Message-State: AOJu0Yx3rrFmOUQLiiucmUCfchmMTCuYJAUaRxWIXm+kf8RNUAJpOBxk
 gPOLITmR0Yx/Aayh2o2h/9/UVkxRPLHlOqSCx69Y57cEVa9W96IyvhlG/rEb0E0=
X-Google-Smtp-Source: AGHT+IFuYQ+zZEb8C4TKJwDEGLyeQ9xkcCY06EjcmT1xKMdZ90pnBzaZRlzt6mXAMdd0EKvtJ9xtng==
X-Received: by 2002:a05:6808:14d2:b0:3c7:fda:2eae with SMTP id
 f18-20020a05680814d200b003c70fda2eaemr2331479oiw.6.1714545422443; 
 Tue, 30 Apr 2024 23:37:02 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a056a00148d00b006ed4aa9d5c0sm371998pfu.188.2024.04.30.23.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 23:37:02 -0700 (PDT)
Message-ID: <f40be341-396c-4d0b-804e-63132ad81d80@daynix.com>
Date: Wed, 1 May 2024 15:36:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 20240428-rss-v10-0-73cbaa91aeb6@daynix.com
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
 <20240428-auto-v1-1-7b012216a120@daynix.com>
 <CAOEp5Oe-uO+Q+btn0bqs1tA-zCc9qth7ngR-fVzDGnSE41yJfg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Oe-uO+Q+btn0bqs1tA-zCc9qth7ngR-fVzDGnSE41yJfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/30 23:41, Yuri Benditovich wrote:
> On Sun, Apr 28, 2024 at 10:21 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
>> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
>> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
>> bool.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/qdev-properties.h | 18 ++++++++++++
>>   hw/core/qdev-properties.c    | 65 +++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index 09aa04ca1e27..afec53a48470 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -43,11 +43,22 @@ struct PropertyInfo {
>>       ObjectPropertyRelease *release;
>>   };
>>
>> +/**
>> + * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
>> + * @on_bits: Bitmap of elements with "on".
>> + * @auto_bits: Bitmap of elements with "auto".
>> + */
>> +typedef struct OnOffAutoBit64 {
>> +    uint64_t on_bits;
>> +    uint64_t auto_bits;
>> +} OnOffAutoBit64;
>> +
>>
>>   /*** qdev-properties.c ***/
>>
>>   extern const PropertyInfo qdev_prop_bit;
>>   extern const PropertyInfo qdev_prop_bit64;
>> +extern const PropertyInfo qdev_prop_on_off_auto_bit64;
>>   extern const PropertyInfo qdev_prop_bool;
>>   extern const PropertyInfo qdev_prop_enum;
>>   extern const PropertyInfo qdev_prop_uint8;
>> @@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
>>                   .set_default = true,                              \
>>                   .defval.u  = (bool)_defval)
>>
>> +#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defval) \
>> +    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,         \
>> +                OnOffAutoBit64,                                             \
>> +                .bitnr    = (_bit),                                         \
>> +                .set_default = true,                                        \
>> +                .defval.i = (OnOffAuto)_defval)
>> +
>>   #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
>>       DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
>>                   .set_default = true,                         \
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 7d6fa726fdf2..b96f54a1b912 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -188,7 +188,8 @@ const PropertyInfo qdev_prop_bit = {
>>
>>   static uint64_t qdev_get_prop_mask64(Property *prop)
>>   {
>> -    assert(prop->info == &qdev_prop_bit64);
>> +    assert(prop->info == &qdev_prop_bit64 ||
>> +           prop->info == &qdev_prop_on_off_auto_bit64);
>>       return 0x1ull << prop->bitnr;
>>   }
>>
>> @@ -233,6 +234,68 @@ const PropertyInfo qdev_prop_bit64 = {
>>       .set_default_value = set_default_value_bool,
>>   };
>>
>> +static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
>> +    int value;
>> +    uint64_t mask = qdev_get_prop_mask64(prop);
>> +
>> +    if (p->auto_bits & mask) {
>> +        value = ON_OFF_AUTO_AUTO;
>> +    } else if (p->on_bits & mask) {
>> +        value = ON_OFF_AUTO_ON;
>> +    } else {
>> +        value = ON_OFF_AUTO_OFF;
>> +    }
>> +
>> +    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
>> +}
>> +
>> +static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
>> +    int value;
>> +    uint64_t mask = qdev_get_prop_mask64(prop);
>> +
>> +    if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
>> +        return;
>> +    }
>> +
>> +    switch (value) {
>> +    case ON_OFF_AUTO_AUTO:
>> +        p->on_bits &= ~mask;
>> +        p->auto_bits |= mask;
>> +        break;
>> +
>> +    case ON_OFF_AUTO_ON:
>> +        p->on_bits |= mask;
>> +        p->auto_bits &= ~mask;
>> +        break;
>> +
>> +    case ON_OFF_AUTO_OFF:
>> +        p->on_bits &= ~mask;
>> +        p->auto_bits &= ~mask;
>> +        break;
>> +    }
>> +}
>> +
>> +const PropertyInfo qdev_prop_on_off_auto_bit64 = {
>> +    .name  = "bool",
> 
> Does it mean that the name of this tristate type is "bool"? Or I miss something?

No, this should be OnOffAuto. Thanks for pointing out this; I'll fix 
this in the next version.

