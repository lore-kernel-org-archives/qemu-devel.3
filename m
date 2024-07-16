Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3852C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbPc-0004r8-5s; Tue, 16 Jul 2024 02:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbPa-0004ik-BN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:11:42 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbPX-0008Vs-Ok
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:11:41 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7037c464792so2647950a34.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721110298; x=1721715098;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BhDmh1YH6MrxRwAKLSf82Z0h779hsGkQGNeijO70fLo=;
 b=ldMG8QnIJh+hlo51AQLXaMd2Ut25/D665950Oslc2sIQ76PjxtZTtgww/ru+N+qUyl
 ShqVAgaZIe2OEoZ20aIT7OHYwHbzvZSsPpYTT/AEGeK/NAYYdfqu93iZVSSLlSL6W7tD
 S/iyAVcoJsQgaz1mlfJ3M1qhdJlTLwXJ7PiKVbT6qunzdPbBoKbF3U2Cw8/sk8q1BFgF
 ECSQjv3+M4tg7wDFFsvkc4YMxFm9m1r0KKEpCemiryXjisK472Xayi97YGCTuQAPCbI+
 YhqiaZtItFnaXUNmtHaVvf5RErST6XAT0TvmUFpvLA1KH7c6cvWt/odwlUv25d/sG+iz
 Zweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721110298; x=1721715098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhDmh1YH6MrxRwAKLSf82Z0h779hsGkQGNeijO70fLo=;
 b=snXjhmNdS5BIHJQ/qe7Q35EFfwXI/cjRnTJOiMxZpXP/x7wEKXm1zNztVVKT9jk0bl
 xY7ggbUWXvZ1QcegtfTnpfbu0JxyMO4qUGQpeatsrhxAI/4Qk64lJwYsEvpxp57NnrEC
 nBRPGNgs241VktH2u/lo6AzprYHVC3llKRLrWweyceeKb1lz3iX9UsQuP1R7E4RfRXMC
 MSN2o23CVROPq1kus4JVNKxNkrjzu9+S+T/X9o5EOWCvRcnV/4+xz/+Wj0otVHc0NdVL
 /KWSFqU0fjz4s9rnuaShJ2SN4d6XXpUEMLICgviPMQqrYDKC5a3eJC54Ckkstccv2bUl
 0mUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4VYh1U/taOn5EOXKhxPLixs5gyhEdfNExJ5MPxbs4+734bx/yvG7GMXt84KrcR1u8lbc8XqJRC4MMyXoTV+9Bg3Aw91A=
X-Gm-Message-State: AOJu0YzOJSRNX8VOYt3zd6ootwWz5HgQAtAtyt9yalHVR8l7DXAnOg6k
 m0+O2K7H+cgg4BKhAjtyCqT1MWeTUSfvrG7Q60nhhYi4kkP/1JrzmkN7CrYOO3g=
X-Google-Smtp-Source: AGHT+IGuFQIy02qsTYOtESontphA7IHp3JPHEV5OG2OYd6QjRzMXxO9zeKOAUE5fwaLCDKXmVBPfJw==
X-Received: by 2002:a05:6830:918:b0:708:c1e7:912a with SMTP id
 46e09a7af769-708d99205cbmr1634919a34.8.1721110298495; 
 Mon, 15 Jul 2024 23:11:38 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ec7e131sm5421409b3a.131.2024.07.15.23.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:11:38 -0700 (PDT)
Message-ID: <8b3f3601-50b3-4372-b9ed-452dd0887ded@daynix.com>
Date: Tue, 16 Jul 2024 15:11:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] qdev-properties: Accept bool for OnOffAuto
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
 qemu-devel@nongnu.org
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
 <20240714-auto-v3-1-e27401aabab3@daynix.com> <ZpUKI6ARTpGXI3Oi@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZpUKI6ARTpGXI3Oi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32d.google.com
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

On 2024/07/15 20:38, Daniel P. Berrangé wrote:
> On Sun, Jul 14, 2024 at 02:11:01PM +0900, Akihiko Odaki wrote:
>> Accept bool literals for OnOffAuto properties for consistency with bool
>> properties.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/core/qdev-properties.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 86a583574dd0..f0a270bb4f61 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
>>       .set   = set_string,
>>   };
>>   
>> +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
>> +                            void *opaque, Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    int *ptr = object_field_prop_ptr(obj, prop);
>> +    bool value;
>> +
>> +    if (visit_type_bool(v, name, &value, NULL)) {
>> +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>> +        return;
>> +    }
>> +
>> +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
>> +}
> 
> IMHO this is highly undesirable. It is adding redundant new syntax
> across countless places in QEMU that use OnOffAuto.

We already embrace the redundant syntax for bool properties and do not 
say it is deprecated. This is the most consistent way of handling on/off 
I came up with.

Regards,
Akihiko Odaki

