Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A6CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 10:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUkez-0001hJ-ON; Fri, 19 Jul 2024 06:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sUkew-0001fI-R0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 06:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sUkeu-0001fG-3R
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 06:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721384174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k2ouxdVDC1rHN/Qr0qzDIV3r7AVoitIcwtn5Up6vdhc=;
 b=Q0ZbPaAWF0BWSdWN/naJyj18T+wp8p6eR6vWjOWWxrOnmfiofz7L9+AnAVJGjE/glPpHKn
 N/4k6RFDiI+yb11Y+l70TetdTPL8rXwA1ZE6FEHLm6oO3GWslMhal1nX/Ott71f1i6Eanc
 vcYaUeyR5yLKK85F9Emou85J0PeUXGw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-QzLdU8DTM5ehukQAPYriqg-1; Fri, 19 Jul 2024 06:16:12 -0400
X-MC-Unique: QzLdU8DTM5ehukQAPYriqg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee8b7eafffso19853891fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 03:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721384171; x=1721988971;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2ouxdVDC1rHN/Qr0qzDIV3r7AVoitIcwtn5Up6vdhc=;
 b=Re+YWTLn+Gfe7BL0mDfTP/S2WLq8tWkhh6ty12WGJixeT0TxVE5CeT+HXl7lNxtYkq
 CdU9KJLH61PhKS1XGFue0rh5iUkRMxXF3mphH5y6LAjDgDu1E0cuBNNMeOEFfvTvMzWU
 l0P2W+Ib7kpw0ls5k/2gLti8iXEdVTwP3RCW9gels97HS6aGJJhaJ5WDCskPnID08QmM
 MaYojs//Z9UojhlN3WhXGfbvTSicCv1XyqSdQn+GJfPUY2JL45igpmkG1fxRTaXMgbnK
 QAAYBVSTFib9+7+/wDDGiRfzdM43Fjq71Qd+C90R/3Ujjm3U8D5l7nMWCKNWRmlB9Yp/
 nnaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiKP9V5f3Wn+rYOpqUebMznmD4SMULPNYHs/FquvtH3QGYQVW6bu3AkEB6xeBp1nzwIvnDTf0fMr0imriuBfNLfZ6tMbY=
X-Gm-Message-State: AOJu0Yz7YS895HdNVr0NakNHYDFbcTsc3iJ4oh0sDmNbhXXVLzH+nS50
 /LBShJb/Xt3d2+OzkJorbTMyD3J1lBHfxej00idfu8H13dmPskcqkBCysIAxGtQieHNhj2Z34l2
 E7du1z3nVUJPJHCAzLges447n0Bh1s+AdssrlJXSruTLzCO2JdBj/
X-Received: by 2002:a2e:7d01:0:b0:2ec:53fb:39cb with SMTP id
 38308e7fff4ca-2ef05c503bamr34459731fa.6.1721384171330; 
 Fri, 19 Jul 2024 03:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUW6ww3IdhoFOKZJ3/vaObAXVQzR1RmlpoGw/jLbZKeDv3hc46VkIP8hk8ZDZrZDoZZcAxqg==
X-Received: by 2002:a2e:7d01:0:b0:2ec:53fb:39cb with SMTP id
 38308e7fff4ca-2ef05c503bamr34459561fa.6.1721384170876; 
 Fri, 19 Jul 2024 03:16:10 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6937fc7sm18940525e9.46.2024.07.19.03.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 03:16:10 -0700 (PDT)
Message-ID: <16c9703c-79b9-4e52-bc40-2857c0c06672@redhat.com>
Date: Fri, 19 Jul 2024 12:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
To: Collin Walling <walling@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, Jiri Denemark <jdenemar@redhat.com>
References: <20240716173253.28533-1-walling@linux.ibm.com>
 <87le1yn7jy.fsf@pond.sub.org>
 <32379d4f-9b6f-4673-9b87-1db4a8ada649@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <32379d4f-9b6f-4673-9b87-1db4a8ada649@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/07/2024 20.22, Collin Walling wrote:
> On 7/18/24 9:39 AM, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>>
>>> As s390 CPU models progress and deprecated properties are dropped
>>> outright, it will be cumbersome for management apps to query the host
>>> for a comprehensive list of deprecated properties that will need to be
>>> disabled on older models. To remedy this, the query-cpu-model-expansion
>>> output now behaves by filtering deprecated properties based on the
>>> expansion type instead of filtering based off of the model's full set
>>> of features:
>>>
>>> When reporting a static CPU model, only show deprecated properties that
>>> are a subset of the model's enabled features.
>>>
>>> When reporting a full CPU model, show the entire list of deprecated
>>> properties regardless if they are supported on the model.
>>>
>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>
>>> Changelog:
>>>
>>>      v2
>>>      - Changed commit message
>>>      - Added documentation reflecting this change
>>>      - Made code changes that more accurately filter the deprecated
>>>          properties based on expansion type.  This change makes it
>>>          so that the deprecated-properties reported for a static model
>>>          expansion are a subset of the model's properties instead of
>>>          the model's full-definition properties.
>>>
>>>          For example:
>>>
>>>          Previously, the z900 static model would report 'bpb' in the
>>>          list of deprecated-properties.  However, this prop is *not*
>>>          a part of the model's feature set, leading to some inaccuracy
>>>          (albeit harmless).
>>>
>>>          Now, this feature will not show during a static expansion.
>>>          It will, however, show up in a full expansion (along with
>>>          the rest of the list: 'csske', 'te', 'cte').
>>>
>>> @David, I've elected to respectully forgo adding your ack-by on this
>>> iteration since I have changed the code (and therefore the behavior)
>>> between this version and the previous in case you do not agree with
>>> these adjustments.
>>>
>>> ---
>>>   qapi/machine-target.json         |  8 ++++++--
>>>   target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index a8d9ec87f5..d151504f25 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -21,8 +21,12 @@
>>>   # @props: a dictionary of QOM properties to be applied
>>>   #
>>>   # @deprecated-props: a list of properties that are flagged as deprecated
>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>> -#     definition list of properties. (since 9.1)
>>> +#     by the CPU vendor.  (since 9.1).
>>> +#
>>> +# .. note:: Since 9.1, the list of deprecated props were always a subset
>>> +#    of the model's full-definition list of properites. Now, this list is
>>> +#    populated with the model's enabled property set when delta changes
>>> +#    are applied. All deprecated properties are reported otherwise.
>>
>> I'm confused.
>>
>> "Since 9.1, the list of deprecated props were ..." and "Now, this list
>> is" sounds like you're explaining behavior before and after a change.
>> What change?  Since only released behavior matters, and
>> @deprecated-props is new, there is no old behavior to document, isn't
>> it?
> 
> I admittedly had some difficulty articulating the change introduced by
> this patch.  The @deprecated-props array, as well as a way for s390x to
> populate it, was introduced in release 9.1.  Prior to this patch, the
> deprecated-props list was filtered by the CPU model's full feature set.
> I attempted to explain this with:
> 
> "Since 9.1, the list of deprecated props were always a subset of the
> model's full-definition list of properties."

Version 9.1 has not been released yet (see 
https://wiki.qemu.org/Planning/9.1), so I agree with Markus, this sounds 
confusing/wrong to me, too.

  Thomas



