Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D25C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYN3O-0000Mz-FW; Mon, 29 Jul 2024 05:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYN3M-0000FB-Rp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYN3L-0005J8-3h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722246746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X42jPKjfWn3JrUR0dm5rMOtmkyC2iVFcpnst9O683lI=;
 b=TWc42zCtCZAyfqY+LiXD6cR5AhjeIDrnLOVjU2sEyzG/xDi2yBTXsVQSutsfw6KJoKiIJl
 vOC/5Z6/vso2Rx4KQZxKtugijKb1kIzODl5TEAmcHvTt3yKsonQ0Us0eZBx2TgFC5ciskR
 xx7cODD5pUYBZS68Dr4JifYz1nhfwwA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-_ua95Nx0MOqf_B-chzyVSQ-1; Mon, 29 Jul 2024 05:52:22 -0400
X-MC-Unique: _ua95Nx0MOqf_B-chzyVSQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso1319175f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 02:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722246741; x=1722851541;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X42jPKjfWn3JrUR0dm5rMOtmkyC2iVFcpnst9O683lI=;
 b=bPlrnuRcA8HzAADylVBuz+j6+NOsZzYaL/TadKFNky9TS31raTsoWkLVhk7IxQKQus
 yZh/d0BC9rcyx0+Fw88lA9Ka5EPy0pXnmXkmVpnhZ82lzEdvYPWoZDTZolBRmz4OgUYY
 lLMtFWlGs1jlf1Q84Ej1LCXiQtNJijRIY/6e9MURCEl/nUO6kHycLuRVeFIQ879MgytE
 p5O8I4y3u0QeGT+KrjIOUc6wmWt/Ysbis7W7w6YKd/S6EiAkQtFu7A0tqd4t1OIwRFhj
 UYJ8hzld9ikSOCs/cec33yEDW2KypA7yQq7TBjlyt6fQza7ugpxRXZXBj992+tax4PSS
 0WEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJWn8HizmRpwE8mg2gOgi68391tM5GNGjX6OJyeIBVSl8PKKGRcpYhU8Gt5oL9fDL7yHW6pN5fBR5orXr06w4dNcmfPZY=
X-Gm-Message-State: AOJu0YyePw+n+8ce5KHebT9hx2zTPiZUy5raH/93kxmjB8m0qzAt4o8Y
 CgFFZqFvZbpdH8sTewP8j25AaOlN8LiWpRwPv7funFW/0C66rgZTSu3SPbadT69Sqji/HXTfS3Y
 1yTp2UmLOrSW3JRzFMUYQ3eWaIX6xx9ShxKYgazrTykpsZHXXSZl1
X-Received: by 2002:a5d:6510:0:b0:367:905c:823e with SMTP id
 ffacd0b85a97d-36b5d0cd631mr3962814f8f.24.1722246741315; 
 Mon, 29 Jul 2024 02:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELdatkSOfuETyW/OzCKPDuk0FaHsoldmtW7Hp9vVPFDxcOUpXYbO9PKdHOKlkHN9eZ7cLHXg==
X-Received: by 2002:a5d:6510:0:b0:367:905c:823e with SMTP id
 ffacd0b85a97d-36b5d0cd631mr3962802f8f.24.1722246740882; 
 Mon, 29 Jul 2024 02:52:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c06f4sm11880671f8f.6.2024.07.29.02.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 02:52:20 -0700 (PDT)
Message-ID: <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
Date: Mon, 29 Jul 2024 11:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: Markus Armbruster <armbru@redhat.com>,
 Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <877cd7qsnj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 27.07.24 08:02, Markus Armbruster wrote:
> Collin Walling <walling@linux.ibm.com> writes:
> 
>> The @deprecated-props array did not make any sense to be a member of the
>> CpuModelInfo struct, since this field would only be populated by a
>> query-cpu-model-expansion response and ignored otherwise.
> 
> Doesn't query-cpu-model-baseline also return it in its response?  It
> seems to assume the "static" expansion type.
> 
>>                                                            Move this
>> field to the CpuModelExpansionInfo struct where is makes more sense.
>>
>> References:
>>   - https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg05996.html
>>   - commit eed0e8ffa38f0695c0519508f6e4f5a3297cbd67
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>
>> @David, the previous commit header did not align with the changes made
>> here, so I tagged this as a "v1" but added the previous conversation as
>> a reference.  I hope this is appropriate?
>>
>> ---
>>   qapi/machine-target.json         | 18 ++++++++++--------
>>   target/s390x/cpu_models_sysemu.c | 31 ++++++++++++++++++++-----------
>>   2 files changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index a552e2b0ce..09dec2b9bb 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -20,17 +20,11 @@
>>   #
>>   # @props: a dictionary of QOM properties to be applied
>>   #
>> -# @deprecated-props: a list of properties that are flagged as deprecated
>> -#     by the CPU vendor.  These properties are either a subset of the
>> -#     properties enabled on the CPU model, or a set of properties
>> -#     deprecated across all models for the architecture.
>> -#
>>   # Since: 2.8
>>   ##
>>   { 'struct': 'CpuModelInfo',
>>     'data': { 'name': 'str',
>> -            '*props': 'any',
>> -            '*deprecated-props': ['str'] } }
>> +            '*props': 'any' } }
>>   
>>   ##
>>   # @CpuModelExpansionType:
>> @@ -248,10 +242,18 @@
>>   #
>>   # @model: the expanded CpuModelInfo.
>>   #
>> +# @deprecated-props: a list of properties that are flagged as deprecated
>> +#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
>> +#     "static" properties are a subset of the enabled-properties for
>> +#     the expanded model; "full" properties are a set of properties
>> +#     that are deprecated across all models for the architecture.
>> +#     (since: 9.1).
>> +#
>>   # Since: 2.8
>>   ##
>>   { 'struct': 'CpuModelExpansionInfo',
>> -  'data': { 'model': 'CpuModelInfo' },
>> +  'data': { 'model': 'CpuModelInfo',
>> +            '*deprecated-props': ['str'] },
>>     'if': { 'any': [ 'TARGET_S390X',
>>                      'TARGET_I386',
>>                      'TARGET_ARM',
> 
> This solves several interface problems:
> 
> 1. Removes inappropriate @deprecated-props argument of
>     query-cpu-model-comparison, query-cpu-model-expansion,
>     query-cpu-model-baseline.
> 
> 2. Removes @deprecated-props return of query-cpu-model-baseline.
> 
> 3. Properly documents how @deprecated-props depends on the expansion
>     type.
> 
> Remaining problem:
> 
> 4. Only S390 implements this.
> 
> Suggest to capture 1-3 more clearly in the commit message, perhaps like
> this:
> 
>      CpuModelInfo is used both as command argument and in command
>      returns.
> 
>      Its @deprecated-props array does not make any sense in arguments,
>      and is silently ignored.  We actually want it only as return value
>      of query-cpu-model-expansion.
> 
>      Move it from CpuModelInfo to CpuModelExpansionType, and document
>      its dependence on expansion type propetly.

s/propetly/property/

Sounds good!

> 
> The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
> @deprecated-props.
> 

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 09dec2b9bb..0be95d559c 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -253,7 +253,7 @@
  ##
  { 'struct': 'CpuModelExpansionInfo',
    'data': { 'model': 'CpuModelInfo',
-            '*deprecated-props': ['str'] },
+            '*deprecated-props' : { 'type': ['str'], 'if': 'TARGET_S390X' } },
    'if': { 'any': [ 'TARGET_S390X',
                     'TARGET_I386',
                     'TARGET_ARM',


Should do the trick, right?

> I recommend to make @deprecated-props mandatory rather than optional
> then.

Hm, does that make sense judging that previous implementations didn't expose it?

-- 
Cheers,

David / dhildenb


