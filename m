Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21554C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzuC6-0005O9-Ib; Thu, 25 Apr 2024 04:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rzuC4-0005Nn-S7
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rzuC2-0006Wc-Sw
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714032657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J6xBD9R7tPDTkU4QFozdzji0DtDHLOEJnRYGQoK+CLY=;
 b=LVaFMIVjsfaKh98twp1drbgbSmCVNL+1Mmf6AKHkuCmhYqswgGgkHXo77dFKf3TWKhORDC
 d2l7bzwz4bacVP9GO/4+S4BQEcjuG+g0lPd3qgrxiz/F49NG1LQg1kny4+O5SrwDiDFkoy
 7DLQ6e1ceOZchJrM1X/Z4ArsuMx9xUQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-G7u_UFHxNtyF5lY9Z4F5tg-1; Thu, 25 Apr 2024 04:10:55 -0400
X-MC-Unique: G7u_UFHxNtyF5lY9Z4F5tg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-349c63ea688so515991f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 01:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714032654; x=1714637454;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6xBD9R7tPDTkU4QFozdzji0DtDHLOEJnRYGQoK+CLY=;
 b=fmEDA8JAvADULDo9a4SVQ2XaGDvB8GJXN0RLr/gfTHDZqJSc096thcT4+6HnOWfeRA
 7XztZyAx5jpM3FUX/5lqEVub38ilTo3c/gFX6nS2U3FbFeAbs44GhMalfuajbiyUajdz
 WgKBNKVajjxGv7Q7XII8UDk4DdG8Ej24hbVxGm4EK7WimhjS5zw8VqDkn/uJbJXM2LjA
 4o+6vX7I7vETNC4UKKy7UHsjsJayMBk0e2CfusFA9CYXUnbYWJWQerAJwvusluLPnd/c
 F2NmBWKQIGiqk/elPlJs2KF1F4l7JNS+313uTm99YPyY9uiUzaABPvPJRwuBjEMdbMVj
 vnVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwJOy0A4LDFRSFnOsPxtaGVTgeWm1FaxPa+NbhoTaUThfQN2wGIsSFzIQihk14SvLv5mwIY502oa94bj5BY3A0G8TtcMA=
X-Gm-Message-State: AOJu0YxNLXmwTCDZSfW5yhZ447kvM8xg7mJj2Qr3oCE0BCex7txojwkc
 YzSmhlNCPo9IwtEns2qouskPvKblhKnCb8U87jeIO8IUC5EvMWnasVvzt/gIxveZZmYWlE1Fi6V
 gv9AORpQA3eAlgcooQaD1Vqb4b+duyKwIu4qs72IxNuTasIhmvnYl
X-Received: by 2002:a5d:4e90:0:b0:343:74c9:51a8 with SMTP id
 e16-20020a5d4e90000000b0034374c951a8mr3355992wru.68.1714032654131; 
 Thu, 25 Apr 2024 01:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH782qKAZXF43MX9sF+Yxcoakpm7ya3EXZBkugrDLOanOx8H5h1Y9h+19CeFZDBWI3TUaSxQ==
X-Received: by 2002:a5d:4e90:0:b0:343:74c9:51a8 with SMTP id
 e16-20020a5d4e90000000b0034374c951a8mr3355968wru.68.1714032653659; 
 Thu, 25 Apr 2024 01:10:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7?
 (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de.
 [2003:cb:c719:8200:487a:3426:a17e:d7b7])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a5d54cd000000b0034335e47102sm19031843wrv.113.2024.04.25.01.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 01:10:53 -0700 (PDT)
Message-ID: <fa179d3e-aaf7-4297-92af-a9d152b83d8d@redhat.com>
Date: Thu, 25 Apr 2024 10:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: add support for
 "disable-deprecated-feats" expansion option
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-3-walling@linux.ibm.com>
 <ec18d260-a882-480a-b7db-9c20aa4aacf7@redhat.com>
 <92b62a01-1ff0-4ad3-bbed-8a0f56954279@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <92b62a01-1ff0-4ad3-bbed-8a0f56954279@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24.04.24 20:33, Collin Walling wrote:
> On 4/24/24 03:24, David Hildenbrand wrote:
>> On 23.04.24 23:06, Collin Walling wrote:
>>> Retain a list of deprecated features disjoint from any particular
>>> CPU model. When a query-cpu-model-expansion is provided with the
>>> "disable-deprecated-feats" option set, the resulting properties list
>>> will include all deprecated features paired with false. Example:
>>>
>>> 	{ ... "bpb": false, "csske": false, ...}
>>>
>>> It is recommended that s390 guests operate with these features
>>> explicitly disabled to ensure compatability with future hardware.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>    target/s390x/cpu_features.c      | 14 ++++++++++++++
>>>    target/s390x/cpu_features.h      |  1 +
>>>    target/s390x/cpu_models_sysemu.c | 20 ++++++++++++--------
>>>    3 files changed, 27 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>>> index d28eb65845..efafc9711c 100644
>>> --- a/target/s390x/cpu_features.c
>>> +++ b/target/s390x/cpu_features.c
>>> @@ -212,6 +212,20 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>>>        };
>>>    }
>>>    
>>> +void s390_get_deprecated_features(S390FeatBitmap features)
>>> +{
>>> +    static const int feats[] = {
>>> +         /* CSSKE is deprecated on newer generations */
>>> +         S390_FEAT_CONDITIONAL_SSKE,
>>> +         S390_FEAT_BPB,
>>> +    };
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(feats); i++) {
>>> +        set_bit(feats[i], features);
>>> +    }
>>> +}
>>> +
>>>    #define FEAT_GROUP_INIT(_name, _group, _desc)        \
>>>        {                                                \
>>>            .name = _name,                               \
>>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
>>> index a9bd68a2e1..661a8cd6db 100644
>>> --- a/target/s390x/cpu_features.h
>>> +++ b/target/s390x/cpu_features.h
>>> @@ -69,6 +69,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>>>                              uint8_t *data);
>>>    void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>>>                                   void (*fn)(const char *name, void *opaque));
>>> +void s390_get_deprecated_features(S390FeatBitmap features);
>>>    
>>>    /* Definition of a CPU feature group */
>>>    typedef struct {
>>> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
>>> index ef9fa80efd..b002819188 100644
>>> --- a/target/s390x/cpu_models_sysemu.c
>>> +++ b/target/s390x/cpu_models_sysemu.c
>>> @@ -171,7 +171,8 @@ static void qdict_add_enabled_feat(const char *name, void *opaque)
>>>    
>>>    /* convert S390CPUDef into a static CpuModelInfo */
>>>    static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>>> -                                bool delta_changes)
>>> +                                bool delta_changes,
>>> +                                bool disable_deprecated_feats)
>>>    {
>>>        QDict *qdict = qdict_new();
>>>        S390FeatBitmap bitmap;
>>> @@ -201,6 +202,13 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>>>            s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
>>>        }
>>>    
>>> +    /* features flagged as deprecated */
>>> +    if (disable_deprecated_feats) {
>>> +        bitmap_zero(bitmap, S390_FEAT_MAX);
>>> +        s390_get_deprecated_features(bitmap);
>>> +        s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
>>> +    }
>>
>> Likely, we should remove these features from the actual bitmap, such
>> that they won't appear twice in the output? I'd expect the
>> cpu_info_from_model() caller to handle that.
>>
>> Just adding them to the list as disabled is likely wrong.
>>
>> For example, if someone were to expend a given model with "... bpb:
>> true" with disable-deprecated-feat=on, that should be remove from
>> "bpb:true", and only replaced by "bpb=false" if it would be part of the
>> CPU model we would be expanding to.
>>
>> Or am I missing something?
>>
> 
> qdict_add_disabled_feat will handle updating the feature if it already
> exists. I placed the code to process deprecated features as the last
> step of cpu_info_from_model to override any features that have already
> been added to the bitmap. Whether it should be the deprecated feats that
> take priority, or what the user requests is up in the air, however...

Yes, that's one of my concern. IIRC, if the user specifies the same 
property multiple times, it's unclear which one will win.

"bpb=true,bpb=false" might mean that bpb=true might win.

I think this is something that this interface should sort out, so it 
will be actually usable!

> 
> ... Daniel's suggestion to modify the QMP response to include a separate
> list of "deprecated-props" seems like a much more efficient and readable
> way that alleviates both your and Markus' concerns.

Would you only include properties that would apply to the current model 
and would be set to true in the current model?

How would libvirt make use of this interface, and could it run into the 
issue spelled out above?

-- 
Cheers,

David / dhildenb


