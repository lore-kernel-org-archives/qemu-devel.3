Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E54DC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9Ja-0007LD-Mh; Thu, 05 Jun 2025 08:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN9JW-0007L2-Ds
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN9JU-00074i-E2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749124994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xxUSL9AAETHy8Gj5MVLvxJfKj65M/HmZ3WhW6W97gqw=;
 b=h0VF+2TbQsRR2IB+OFl0OGs4ZRqlFBSSF9pbGrU00oPwXeoF32YrkdSHh3GPEr/9CvUG8F
 o5LfPgwRWMm0+wtkkkMLXKJlhmWDmJynAPmEneFvonf9gROseWgRc0AjJIojEpBEPtJ/GC
 lKgx4vKQaAIUiTv66Z7Gi12B1dlA39o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-7HwaK7u2PtSrkCDJUSi9tA-1; Thu, 05 Jun 2025 08:03:13 -0400
X-MC-Unique: 7HwaK7u2PtSrkCDJUSi9tA-1
X-Mimecast-MFC-AGG-ID: 7HwaK7u2PtSrkCDJUSi9tA_1749124992
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so503862f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 05:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749124992; x=1749729792;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxUSL9AAETHy8Gj5MVLvxJfKj65M/HmZ3WhW6W97gqw=;
 b=jDwtrDpS+lfqHtawiYH2771SmspsguHR4ShOrmiMTLft+E+WzFgF6RiIPX7nzHmkL/
 /I6bB7G4W4kFJ8RN9bPNk1s0pHFBCRA2ovnVRxgT5Pfkr4gNfeCf1BIYFdkXjAIkf96+
 v4KGOB6BUHrPGkomGSy7ZBzI2Y6ai9ZSWMJ0npD7+41LTORKDxsT1zNwSgQBWJOH0G6u
 f06OH65GHNYm/EMx/auA9gDT08v0gY3KLHpI55sBs2kVXnVCToN246Ep9ZAWJu5Jfof6
 vDF35eiXRWtck+ZQSQupzYbUg816uk4/1UeEBpDOCjj2qBNeVK24/D1DIkwK/3EFLZx0
 9yFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtz7Yd+sXbQJV53JxJZHlUcgmmQjvg7nlevM8bDeELz8fpvNGdwlWLFp739tB5Sza1RJ7MV04dX+TJ@nongnu.org
X-Gm-Message-State: AOJu0Yx0OWpB/1M/A46vPgXYFiZLq82h/GpPpxO+NodtCls4yAgeLlUU
 sMTO/X4ExPLCzM6KkFB33EJ7K4mcMpMbfH8dDPNSJ6z71crwS8j8JQ/m3zi/H3TnggUv5CFIvBN
 7hF5sICZDsCacidB+sSGrLdhLkSrrPzeCNAVrNox1+sFBBjzjsSSumjZS
X-Gm-Gg: ASbGnctf3T/ofDQ/9uShxGwrFsjrucrxTPGidJ/kT7SD5nRQSF4133/AnauPZJP40sc
 yWvu42CVJ/tDU6dVF6wsZlAyxZRXvIXVHxA/OAYEGIAoQ2/S52P+Lq8DmqV8hA9lYIQY7n2SG2b
 +ykBP20AWRlLdiPM/9CfVq6O1bxe+644fDj9INfxdcS8xPp5srkZ2OyzpArUJzeH1NB1iE+DAkn
 IX1PmqvEsAYmdVTLWIgwVz0V/aDOjpPPh7SReDU6UrCzbEuAruUR3YxRLdVSwIr/0vnOBGcHih5
 0BHoMjTqJiNzwG8Y26ZS1cJAtO8doxUiemI/lFQRIf8=
X-Received: by 2002:a05:6000:2890:b0:3a5:23c6:eeee with SMTP id
 ffacd0b85a97d-3a526e03916mr3276795f8f.21.1749124991693; 
 Thu, 05 Jun 2025 05:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMgjSzRphxHRIqCD2qCokV/MLvJGLT+BNS5UW3XfrdeYxL+MKMZ8Z/Gkyuvn9aDaYrFtTTNw==
X-Received: by 2002:a05:6000:2890:b0:3a5:23c6:eeee with SMTP id
 ffacd0b85a97d-3a526e03916mr3276728f8f.21.1749124991214; 
 Thu, 05 Jun 2025 05:03:11 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c8b4sm24844617f8f.36.2025.06.05.05.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 05:03:10 -0700 (PDT)
Message-ID: <00c7e7f0-1c94-4f6f-aa08-5e557bbb91aa@redhat.com>
Date: Thu, 5 Jun 2025 14:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
From: Thomas Huth <thuth@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
 <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 05/06/2025 13.56, Thomas Huth wrote:
> On 05/06/2025 10.34, Nina Schoetterl-Glausch wrote:
>> On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
>>> Add Control-Program Identification (CPI) data to the QEMU Object
>>> Model (QOM), along with the timestamp in which the data was received
>>> as shown below.
>>
>> [...]
>>>
>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>> ---
>>>   hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
>>>   include/hw/s390x/event-facility.h |  5 +++
>>>   qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>>>   3 files changed, 110 insertions(+)
>>>
>>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>>> index 935fa87acd..ec711e2291 100644
>>> --- a/hw/s390x/sclpcpi.c
>>> +++ b/hw/s390x/sclpcpi.c
>>> @@ -15,7 +15,9 @@
>>>     */
>>
>> [...]
>>> +static void cpi_init(Object *obj)
>>> +{
>>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>>> +
>>> +    object_property_add_str(obj, "system_type", get_system_type, NULL);
>>> +    object_property_add_str(obj, "system_name", get_system_name, NULL);
>>> +    object_property_add_str(obj, "sysplex_name", get_sysplex_name, NULL);
>>> +    object_property_add_uint64_ptr(obj, "system_level", &(e->system_level),
>>> +                                   OBJ_PROP_FLAG_READ);
>>> +    object_property_add_uint64_ptr(obj, "timestamp", &(e->timestamp),
>>> +                                   OBJ_PROP_FLAG_READ);
>>> +}
>>
>> I think it would be cleaner if those were class properties.
>> You could use object_class_property_add_str in cpi_class_init,
>> but I think it'd be nice to use DEFINE_PROP_(STR|UINT64) and
>> device_class_set_props.
> 
> For "normal" properties I'd say "yes" ... but in this case, this would also 
> allow the user to set the properties from the host side - which would be a 
> little bit weird? So I think it might be cleaner to keep it this way here 
> without the "setter" functions? WDYT?

By the way, Shalini, could you please add a description of the properties 
via object_property_set_description() here, please?

  Thanks,
   Thomas

PS: FWIW, Markus recently also provided a nice summery about the different 
property types here:
  https://lore.kernel.org/qemu-devel/87o6vfzdig.fsf@pond.sub.org/


