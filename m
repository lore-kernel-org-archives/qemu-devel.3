Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A3C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 19:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXR17-0003J4-Nd; Fri, 26 Jul 2024 15:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXR14-0003Ez-IH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 15:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXR10-0001tt-Ue
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 15:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722023647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=95HAwFR9/LxcH0aL73+L8JsEwsfpsQzWxNFIytZhhDI=;
 b=hbSv5Dh++PzFI+ZLky+0IhF9yBgIKdGIHxyholU1RVBqSzRpAnFli0W9bEEsNVq8JlZFWC
 lIxfeWZLUF3niMAIB4sgAlOQx+MDx/9pB8hjDt87Y26ogGuyLSBKRI+3leN22HvJ6GHybv
 W6L5+nrDlZ09yu5OabKuQPiRWzHWPjo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-9pJyMWOWMNWqqTpqFcjtQA-1; Fri, 26 Jul 2024 15:54:04 -0400
X-MC-Unique: 9pJyMWOWMNWqqTpqFcjtQA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36865706f5eso17985f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 12:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722023643; x=1722628443;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=95HAwFR9/LxcH0aL73+L8JsEwsfpsQzWxNFIytZhhDI=;
 b=eF7toPGyr3PvVUaxCpBoHDMX9rzKCArSUhYlWOVmaRX6hbHa3g8m9OtfwFHiopIqUr
 pLOXmTFWticpVr+r7xmgUtjV8n/CSQKyuUi7JsnquiMYMfyxq+aw/DXk8VJlkD6vzpxB
 c6KcRgW1MIdQ3Fpbrb4dxi7q6bxBl+P8CLwe2IIAn+Y43yFiihqgz0BW1m/IoEe5CsVR
 CPCCENoS4OU1kf6360eEb5ZBHonqtI6gkuh3k3qAxFvdryJtn5jo7UmC+MHvkYldIV1o
 R9JdkHwWnqgAgtc2FcNldHv5WZKzVFU37OJQkFMgWUJmVTq4z8UfLCdjfI2fJki3YZh5
 BFlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo7tn98MqSwYOyjeXOA1o+/CoP49Vf6Ejr+FZ1oVc05DG2VoNCPJuV5njgiYwHVXzaDnbtkOHeoX5aN+W9Xs14Q/CcUpM=
X-Gm-Message-State: AOJu0YwfYfXN66BWv05hMpUDFJ7tglGc3yaPJxe9kr3fkmjBtDf5h4nU
 qGWWMO8lUOenol1FE/Zjv5eSqWbOjJ5hpRlCeejJb1CqLXNSRBy9HF6zove/QyUr4PiDPNU3nke
 R6hb6arbn/rpweM8NAliDWd+VTRrPmtf98cjR1kV21l+0lD1JDcsv
X-Received: by 2002:a05:6000:dcd:b0:368:7fd3:291c with SMTP id
 ffacd0b85a97d-36b5d0b7b9dmr384703f8f.60.1722023643731; 
 Fri, 26 Jul 2024 12:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Y9QTSdbJ7hDIvqyy3Gg5dBlYDHN2Yv0jsPK3ksAePu4f4/aNWCzRKne4DDSYc1XG+I3Lgw==
X-Received: by 2002:a05:6000:dcd:b0:368:7fd3:291c with SMTP id
 ffacd0b85a97d-36b5d0b7b9dmr384696f8f.60.1722023643268; 
 Fri, 26 Jul 2024 12:54:03 -0700 (PDT)
Received: from [192.168.3.141] (p4ff238dc.dip0.t-ipconnect.de. [79.242.56.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857c78sm5845813f8f.87.2024.07.26.12.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 12:54:02 -0700 (PDT)
Message-ID: <3956a1ff-d036-4ef8-b1b3-7380933f49f6@redhat.com>
Date: Fri, 26 Jul 2024 21:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Collin Walling <walling@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
 <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
 <87cyn2ugyi.fsf@pond.sub.org> <87v80tudo7.fsf@pond.sub.org>
 <d20cdad7-89c2-47f7-8acf-dcce767d8db5@redhat.com>
 <fa452b18-d19c-4d00-a566-3ec82d53b153@linux.ibm.com>
 <87ed7gipxu.fsf@pond.sub.org>
 <474aa180-431d-4724-945d-8e7dc4b91228@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <474aa180-431d-4724-945d-8e7dc4b91228@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26.07.24 21:11, Collin Walling wrote:
> On 7/26/24 3:15 AM, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>>
>>> On 7/25/24 3:39 AM, David Hildenbrand wrote:
>>>> On 25.07.24 09:35, Markus Armbruster wrote:
>>>>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> [...]
>>
>>>>>> Arguments that are silently ignored is bad interface design.
>>>>>>
>>>>>> Observe: when CpuModelInfo is an argument, @deprecated-props is always
>>>>>> ignored.  When it's a return value, absent means {}, and it can be
>>>>>> present only for certain targets (currently S390).
>>>>>>
>>>>>> The reason we end up with an argument we ignore is laziness: we use the
>>>>>> same type for both roles.  We can fix that easily:
>>>>>>
>>>>>>       { 'struct': 'CpuModel',
>>>>>>         'data': { 'name': 'str',
>>>>>>                   '*props': 'any' } }
>>>>>>
>>>>>>       { 'struct': 'CpuModelInfo',
>>>>>>         'base': 'CpuModel',
>>>>>>         'data': { '*deprecated-props': ['str'] } }
>>>>>>
>>>>>> Use CpuModel for arguments, CpuModelInfo for return values.
>>>>>>
>>>>>> Since @deprecated-props is used only by some targets, I'd make it
>>>>>> conditional, i.e. 'if': 'TARGET_S390X'.
>>>>>
>>>>> If we want just query-cpu-model-expansion return deprecated properties,
>>>>> we can instead move @deprecated-props from CpuModelInfo to
>>>>> CpuModelExpansionInfo.
>>>>
>>>> That might a bit more sense, because deprecated-props does not make any
>>>> sense as input parameter, for example.
>>>
>>> Will do.  Thanks for the feedback.  v4 in the works.
>>
>> We better get this into 9.1.  Plan B: mark @deprecated-props unstable to
>> avoid backward compatibility pain.
>>
>>
> 
> Agreed, it would go a long way to squeeze this in before things get too
> messy.
> 
> v4 is posted.  I think Thomas is unavailable, so if @David would not
> mind handling this?

Will do!

-- 
Cheers,

David / dhildenb


