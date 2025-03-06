Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18109C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCq8-0008Pk-M0; Thu, 06 Mar 2025 10:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqCq1-0008L9-JL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqCpx-0000Qs-KM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741273716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mkQrA/zKAv8e3ZrA8TEwp4K9TsSniKa1JXAtYY+dUiQ=;
 b=UaaidSsjW02+I6BY96c/Xf7FQCu4xx4cw5rFL1DyL8FsgGEde+xYB4SrNcvWRLaJGvSXX9
 SfpxFOlr7H66oKLX2AMrRU01Iq5chPBN9Koibqyk68ORQ02mVAETjkUwW/XEi4JGt0zTuT
 AECjoD9uDawCuF3NN6RRMo5uNErfQ/4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-smbYTYzUOmy52XTE3MVrEA-1; Thu, 06 Mar 2025 10:08:35 -0500
X-MC-Unique: smbYTYzUOmy52XTE3MVrEA-1
X-Mimecast-MFC-AGG-ID: smbYTYzUOmy52XTE3MVrEA_1741273714
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so310672f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741273714; x=1741878514;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mkQrA/zKAv8e3ZrA8TEwp4K9TsSniKa1JXAtYY+dUiQ=;
 b=eV+XwpyrkTmJGFnP2coC8Be6KCXHdx2XcXidEHL3M+gRvi600ykTziTTk0PkZD9PxP
 FfdR9fdxE/yXDMKyK6+rOcK9O0w66boGRRZitVYQkFjpm9pEzWty2smKK23IYzmuD8kZ
 E2wfaPCcOUqh946ze22YugKt5t+1xfKpJu00RIBYnVEXoxBeuFoJOtEbNsCDkXOpW0Hp
 4NvtC69dCywJK4ZOUTsJgEwykvD2UGFGW4p5QH+yDL/K+DveeJaJryRCBmzuJdp84HiV
 kYbA7p4Sh/zELa1M0c20zJyRqsYJ2himgbQMNF+dX3oUewbRQWj2vz4kpSQR+yLxXkiH
 5SeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVG3dRbqGw7si5GW131BweQ9h3L9Mfw6ui38RSuB3taOnr+vQ1r2lUtjHjHRAwmlU1ZA777kB8QBhe@nongnu.org
X-Gm-Message-State: AOJu0Yyfs6OH744EwklG3vEOeUJvxG+IcNyp6HPnhI9rG1CeAxMLeHo8
 P4KkJotEK9k1S5GymlOCu58jONPOoueTnNuKHZ+llakIWSMldSXHS0Sf9+7VwqdDJSpgRSyXHXG
 7KJy8R9wzsMwXlr/OSVe34dZ9vDkzyytyERLlu/q7jlQF0B1+TPAj
X-Gm-Gg: ASbGnctTl8WavQRojqk03AUuyPTElVdaB7OntjUabQ2PDzSMjNF+f09MUs92EoWgDBZ
 LoIZmLC7oWCzL1leXoPnwGyegmFar+I7yAmScC+jN0cRMwJuILUaV2+4rZkEIly3ySIBihUPIty
 Y4fWzeUG5ixX8EDMG3OPC5sZAMLtHD/tayX+QPSe7CzyZ7r6XP3nTGoIna2IZwZNbNzUK8fdLeg
 3WOYoUT/VjMn+dNIN+PURil7KNfqFULH44+UbNY5Ko2FKJL3Rwr//IV/FbxK1yIedpB2+w6mv0Y
 uPUZ8hWkDugD7o0BJ6U/yUa9h7yzo2ZlHLTF9ynViLtBzR4=
X-Received: by 2002:a5d:5846:0:b0:391:2353:8a57 with SMTP id
 ffacd0b85a97d-39123538ab5mr5077026f8f.34.1741273713950; 
 Thu, 06 Mar 2025 07:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbS4OYvJ2HuZgUIA0iUnq6Khyr/jOnQ5pCqHexe/b/IaWQmZZuRpBgXcjgTUKmosmshLsdUw==
X-Received: by 2002:a5d:5846:0:b0:391:2353:8a57 with SMTP id
 ffacd0b85a97d-39123538ab5mr5076993f8f.34.1741273713438; 
 Thu, 06 Mar 2025 07:08:33 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f39sm2273321f8f.80.2025.03.06.07.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 07:08:33 -0800 (PST)
Message-ID: <020b1851-1249-446f-844c-2bc598128446@redhat.com>
Date: Thu, 6 Mar 2025 16:08:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 3/3] hw/s390x: support migration of CPI values
To: shalini <shalini@imap.linux.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-3-shalini@linux.ibm.com>
 <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
 <ac723d90e0536e42707420b0fc329a5c@imap.linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <ac723d90e0536e42707420b0fc329a5c@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 06/03/2025 15.10, shalini wrote:
> On 2025-03-05 19:33, Thomas Huth wrote:
>> On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>>> Register Control-Program Identification data with the live
>>> migration infrastructure.
>>>
>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>> ---
>>>   hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 13ea8db1b0..4d0838d037 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -260,6 +260,20 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
>>>       qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>>>   }
>>>   +static const VMStateDescription vmstate_control_program_id = {
>>> +    .name = "s390_control_program_id",
>>> +    .version_id = 0,
>>> +    .minimum_version_id = 0,
>>> +    .fields = (const VMStateField[]) {
>>> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
>>> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
>>> +        VMSTATE_UINT64(system_level, ControlProgramId),
>>> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
>>> +        VMSTATE_UINT64(timestamp, ControlProgramId),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>>   static void ccw_init(MachineState *machine)
>>>   {
>>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>> @@ -308,6 +322,9 @@ static void ccw_init(MachineState *machine)
>>>       ret = css_create_css_image(VIRTUAL_CSSID, true);
>>>       assert(ret == 0);
>>>   +    /* register CPI values */
>>> +    vmstate_register_any(NULL, &vmstate_control_program_id, &ms->cpi);
>>
>>  Hi again,
>>
>> after looking at this for a while, I think it might be cleaner to
>> store the state in the TYPE_SCLP_CPI device instead of storing it in
>> the machine state. Then you can also use dc->vmsd there instead of
>> using the legacy vmstate_register_any() function.
>>
> 
> Hello Thomas,
> 
> The SCLP event type CPI is used to transfer the data mentioned below from 
> guest operating system to QEMU. The job of the CPI event is complete, when 
> this transfer is done.
> 
> The received data must be saved in the QEMU object model, so that it is 
> possible for the user to retrieve the data via QMP. The received data 
> provides information about the guest virtual machine.
> 
> System type - Operating system of the guest (eg: LINUX)
> System name - Hostname provided to the guest (eg: TESTVM)
> System level - Kernel version of the guest operating system (eg: 0x50e00)
> Sysplex name - Sysplex refers to a cluster of logical partitions  that 
> communicates and co-operates with each other. Sysplex name is the name of 
> the cluster which the guest belongs to(If any).(eg: PLEX)
> 
> In my perspective, I believe that the s390 machine state is appropriate for 
> storing the data about the guest virtual machine. Please do let me know if 
> you still want to change this?, thank you.

  Hi Shalini,

yes, please change this patch to put the migration state into the SCLP_CPI 
device.

vmstate_register_any() is a legacy function, see its description in 
include/migration/vmstate.h ... so if anyhow possible, this should be 
avoided in new code.

You introduced a new device in patch 2 which will be handling the related 
data. Devices are the right place for storing migration data in new QEMU 
code, so I think this really should go into dc->vmsd of TYPE_SCLP_CPI.

For retrieving the information, the user should then just get the property 
from /machine/sclp/s390-sclp-event-facility/sclpcpi instead of /machine. 
This should be fine since it is a well-defined location, too.

  Thanks!
   Thomas


