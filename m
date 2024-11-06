Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA42D29FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8axa-0007Lt-FL; Wed, 06 Nov 2024 03:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8axX-0007Kx-B5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:00:11 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8axQ-0002OF-Ps
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:00:09 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so5049781a91.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730880000; x=1731484800;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RWX/3/GPTkhmyB7O4w6zjiEN4HTP3z4i7P3lEC7pFDQ=;
 b=mro2ESaS+kQmwpSEsOlreKnZEjrzTTYUehhND7/WeXUmeAsrzVCqqOrE605NHTcoJ4
 URsB9rOIohC8PgF4/SljpAT+t/4GOlcy2PgokNQrgsXNzer740TRiuxHDf0417xDOvk7
 +WavtEAeKDqBNpuZBravkEaBMsXMdGj37P61slRCBUCF9so/5WWnIhZ7nuqdM+4ghAvk
 vmUhIrhs1CjaNfCeu3cYDnWC9P8OxmqHGxNSgTAT5P8y1xB62ZNWtjbwI5YKTx759JF6
 f1obrZsOFg5HyT/4NTdUG0PMPqStCtpjHs3VLpz3Nd6WAHZhyJffC15TAWHa4WpjUUfz
 ydAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730880000; x=1731484800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWX/3/GPTkhmyB7O4w6zjiEN4HTP3z4i7P3lEC7pFDQ=;
 b=STzEqPBJaagjzwhdcB+PYuvM7aVpxb/kJIhi+5c1VqVtxfQwv531qNvpdbS/EhRaLI
 67WDWpHBNsGiWJspBkBNPLdFg17+Yc0HFQG2C3hgC45i/zWNOytyi9CQRysafhLUP4ef
 FouvyPfAcp8YFLtUU0JeZSp6topOm470X8M88BJaJoOj5TUgnYgVGeo1K6gh0EmgsbQo
 GFZAEEsnbk6TgZWIAdeR8+NEGCi+TlAOIqlXkKwHjwNAAKl4rMKWAuQXnw4fVUlbOJmV
 xY4FBtjTQffg750ythhtTzairXuMGTQAwnQieaEuVJf1t3HtuMnnZQ54r6JLfTnGS1BV
 QM0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMj2zmQgkxmIsMFWHhjRWnZD8ysXO5jrkrkhymCOnaL/3esCU+0u8FiziwCAiXQZUU1Ba7JaJwy8pk@nongnu.org
X-Gm-Message-State: AOJu0YxB+RapSfYlmUdYb/7mD5fWK7FrvYq+ErErwmbnKZhf5L5Ct9Kw
 f9JU4jifiknTnDGTJhiM1f64UZjiEPlQCihMYPYMNJZllyTPJ4sUedz75VXBKeo=
X-Google-Smtp-Source: AGHT+IGmx7kKBWrxAYonpnKkVCfoTGebNWAoSMZ2FpFyzFHUQv/U2L8XG9PK6pE8LhfhjrI3dcKu/g==
X-Received: by 2002:a05:6a20:7f97:b0:1db:eef0:ce9e with SMTP id
 adf61e73a8af0-1dbeef0cea3mr8404557637.22.1730880000628; 
 Wed, 06 Nov 2024 00:00:00 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee452b1643sm10453469a12.38.2024.11.05.23.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 00:00:00 -0800 (PST)
Message-ID: <46844bf7-e99f-4b32-8931-816baee224f2@daynix.com>
Date: Wed, 6 Nov 2024 16:59:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qdev-properties: Accept bool for OnOffAuto
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-1-b2394236e053@daynix.com> <Zx_Ag0_MFem7Qn3a@redhat.com>
 <3dd9b22b-2e0c-4999-aab0-eac751923c35@daynix.com>
 <ZyS-fx0zjRJTOgkt@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZyS-fx0zjRJTOgkt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/01 20:41, Daniel P. Berrangé wrote:
> On Thu, Oct 31, 2024 at 04:21:08PM +0900, Akihiko Odaki wrote:
>> On 2024/10/29 1:49, Daniel P. Berrangé wrote:
>>> The parent msg was sent off-list orignially, so below is a copy
>>> of my feedback to that off-list posting.
>>>
>>> On Tue, Oct 22, 2024 at 01:50:38PM +0900, Akihiko Odaki wrote:
>>>> Accept bool literals for OnOffAuto properties for consistency with bool
>>>> properties. This enables users to set the "on" or "off" value in a
>>>> uniform syntax without knowing whether the "auto" value is accepted.
>>>> This behavior is especially useful when converting an existing bool
>>>> property to OnOffAuto or vice versa.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    hw/core/qdev-properties.c | 17 ++++++++++++++++-
>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>>> index 86a583574dd0..f0a270bb4f61 100644
>>>> --- a/hw/core/qdev-properties.c
>>>> +++ b/hw/core/qdev-properties.c
>>>> @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
>>>>        .set   = set_string,
>>>>    };
>>>> +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
>>>> +                            void *opaque, Error **errp)
>>>> +{
>>>> +    Property *prop = opaque;
>>>> +    int *ptr = object_field_prop_ptr(obj, prop);
>>>> +    bool value;
>>>> +
>>>> +    if (visit_type_bool(v, name, &value, NULL)) {
>>>> +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
>>>> +}
>>>
>>> My feedback is the same as last time this was posted.
>>>
>>> This is adding redundant new input-only & secret syntax for every
>>> usage of OnOffAuto across QEMU.
>>>
>>> "consistency with bool" isn't a expressing a compelling advantage.
>>>
>>> The new permitted values are invisible to applications, beacuse
>>> introspecting QAPI schema for the "OnOffAuto" type will never
>>> report them, and querying the value of a property will also never
>>> report them.
>>>
>>> I'm not seeing an advantage, or clear problem solved, by adding
>>> this.
>>
>> The intent of this patch is to ease migration from bool to OnOffAuto; a user
>> should be able to set the "on" or "off" value without knowing the "auto"
>> value is accepted.
>>
>> The redundancy of syntax is already present with bool. If it is problematic,
>> the redundant syntax should be deprecated altogether, whether the type is
>> OnOffAuto or bool.
> 
> The redundant syntax for bool is only present in the legacy QemuOpts
> based CLI syntax. If using modern JSON syntax, or QMP, it is required
> to use the navtive JSON bool type.


My understanding of the present situation is different. OnOffAuto always 
requires to specify string "on" or "off", not a JSON bool type.

I see the core problem is that QOM bool and OnOffAuto disagrees how "on" 
and "off" should be specified, especially in the JSON syntax. In JSON 
syntax, QOM bool requires JSON bool, which is inconsistent with OnOffAuto.

If the added redundancy is not OK, I think we need to decide how "on" 
and "off" should be decided, and use the syntax for both of QOM bool and 
OnOffAuto while deprecating the old syntax.

I don't have a strong opinion regarding the JSON syntax that should be 
used for "on" or "off". While I feel the JSON type system fits poor for 
QEMU, QEMU already have code that handles JSON numbers and null so using 
JSON true/false should be OK.

Regards,
Akihiko Odaki

> 
> This proposed change to OnOffAuto is affecting both legacy and modern
> syntax, adding redundancy to both, here none currently exists for the
> latter. So this is qualatively different from the status quo, and
> taking us in a direction we don't want to go.
 > > With regards,
> Daniel


