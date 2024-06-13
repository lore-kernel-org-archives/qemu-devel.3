Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3589FC27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo9x-0004rN-QH; Thu, 13 Jun 2024 13:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHo9t-0004W2-CC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHo9q-0005vN-Gs
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718299361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VKpd9OVyhw3p8ruzm8h2nyli6BEmva8zw89xIxVd7TE=;
 b=QJgaD49ulT+6FeXjJSeEOyiP/ar/nJnu0in+XL5j5CFh+C/QmScBWm+koDb+vvPetc0/Ua
 XttGCd9ADsaf5vVz47Z4ZoK5HmMpnre3lUq9lbdFM7XV04CDUzUDwK1yAfKakLA1WWQBKQ
 eybVRjkCr+w6qmz/vbSHaXATgxv4mi8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-AgQ4sepMOMC3XKJcWHpGvA-1; Thu, 13 Jun 2024 13:22:37 -0400
X-MC-Unique: AgQ4sepMOMC3XKJcWHpGvA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421179fd82bso8319035e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299356; x=1718904156;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKpd9OVyhw3p8ruzm8h2nyli6BEmva8zw89xIxVd7TE=;
 b=uWBkhJ+47W58HKFlZY8Yi2W/VKfgXgxd080a/EGTSj/6Ev65RGeWkgrZu28JcZPYY9
 iVLiv1x4C3YLgpaKWqbwcYH3oZGHYNslZt+enJtJQBvlzsGvyh1kDtHcwEQs11JQVB56
 3EQ9AvpVgdV1O14EFta1s1tS1gBsPY7EvDOS8CSQ9qChLjJYEAZ2bzjS9MpsYK18v9XY
 Bgou336nSISLGUNEDZfv3M1Rwr8ePsHK+u+edSZz+r3zr7vS9BgxTkTGHz9ei9DqbpsX
 gbZ3ubLN3ZZ4a6Cl6zuNFJ9+W+x9oVnKZKATlNg1SW/KUYo+cN9DPji4sKq/cYbnQijT
 M4lQ==
X-Gm-Message-State: AOJu0YxcIP+0qCuxPpgmwL9pW4I4sgrBG8UcMR45vktQ8Ckj9d9SAXkP
 fQee+CIzY0I0kNkqS/6VZYz20bPP49uetizAkkqP2wwxBayZ94UCAeL3Jo1DV0WPB9ehq5klyDB
 DnjCWzQqJrwlS4WbwPXDzSv9PwFGzPGJm6WcSSno6G9qP5KhVPkgq
X-Received: by 2002:a05:600c:1913:b0:421:72f3:33b5 with SMTP id
 5b1f17b1804b1-42304849197mr3644345e9.35.1718299355861; 
 Thu, 13 Jun 2024 10:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwf4ztC/Jzx3bc7nWNsg0RL3AhdZsAsP3H3k7If9JGxD1GwpAVr1OEEvL9IkLKyKKaVQDFJg==
X-Received: by 2002:a05:600c:1913:b0:421:72f3:33b5 with SMTP id
 5b1f17b1804b1-42304849197mr3644155e9.35.1718299355453; 
 Thu, 13 Jun 2024 10:22:35 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-242-210.web.vodafone.de.
 [109.43.242.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33bdasm32672545e9.8.2024.06.13.10.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 10:22:35 -0700 (PDT)
Message-ID: <feaa5adc-01ed-45fa-9a13-e66836f33ef9@redhat.com>
Date: Thu, 13 Jun 2024 19:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Add a CONFIG switch to disable legacy CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240613170702.523591-1-thuth@redhat.com>
 <856c9c4e-8e8b-4d63-a897-ee80fb7ed92a@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <856c9c4e-8e8b-4d63-a897-ee80fb7ed92a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/06/2024 19.17, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 13/6/24 19:07, Thomas Huth wrote:
>> Old CPU models are not officially supported anymore by IBM, and for
>> downstream builds of QEMU, we would like to be able to disable these
>> CPUs in the build. Thus add a CONFIG switch that can be used to
>> disable these CPUs (and old machine types that use them by default).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   If you're interested, the PDF that can be downloaded from
>>   https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
>>   shows the supported CPUs in a nice diagram
> 
> I'd add this link ...
> 
>>   hw/s390x/s390-virtio-ccw.c | 9 +++++++++
>>   target/s390x/cpu_models.c  | 3 +++
>>   target/s390x/Kconfig       | 5 +++++
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
>> index d886be48b4..8a95f2bc3f 100644
>> --- a/target/s390x/Kconfig
>> +++ b/target/s390x/Kconfig
>> @@ -2,3 +2,8 @@ config S390X
>>       bool
>>       select PCI
>>       select S390_FLIC
>> +
>> +config S390X_LEGACY_CPUS
>> +    bool
>> +    default y
>> +    depends on S390X
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index efb508cd2e..ffae95dcb3 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -22,6 +22,7 @@
>>   #include "qemu/module.h"
>>   #include "qemu/hw-version.h"
>>   #include "qemu/qemu-print.h"
>> +#include CONFIG_DEVICES
>>   #ifndef CONFIG_USER_ONLY
>>   #include "sysemu/sysemu.h"
>>   #include "target/s390x/kvm/pv.h"
>> @@ -47,6 +48,7 @@
>>    * generation 15 one base feature and one optional feature have been 
>> deprecated.
>>    */
>>   static S390CPUDef s390_cpu_defs[] = {
>> +#ifdef CONFIG_S390X_LEGACY_CPUS
> 
> ... here :)

Can do ... let's just hope that the link is stable in the course of time!

>>       CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 
>> GA1"),
>>       CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM zSeries 
>> 900 GA2"),
>>       CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM zSeries 
>> 900 GA3"),
>> @@ -78,6 +80,7 @@ static S390CPUDef s390_cpu_defs[] = {
>>       CPUDEF_INIT(0x2964, 13, 1, 47, 0x08000000U, "z13", "IBM z13 GA1"),
>>       CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
>>       CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
>> +#endif
>>       CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>>       CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>>       CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model 
>> ZR1 GA1"),
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3d0bc3e7f2..7529d2fba8 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -47,6 +47,7 @@
>>   #include "migration/blocker.h"
>>   #include "qapi/visitor.h"
>>   #include "hw/s390x/cpu-topology.h"
>> +#include CONFIG_DEVICES
>>   static Error *pv_mig_blocker;
>> @@ -603,6 +604,8 @@ static void s390_nmi(NMIState *n, int cpu_index, Error 
>> **errp)
>>       s390_cpu_restart(S390_CPU(cs));
>>   }
>> +#ifdef CONFIG_S390X_LEGACY_CPUS
>> +
>>   static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
>>   {
>>       /* same logic as in sclp.c */
>> @@ -623,6 +626,8 @@ static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
>>       return newsz;
>>   }
>> +#endif
>> +
>>   static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
>>   {
>>       S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> @@ -989,6 +994,8 @@ static void ccw_machine_6_1_class_options(MachineClass 
>> *mc)
>>   }
>>   DEFINE_CCW_MACHINE(6_1, "6.1", false);
>> +#ifdef CONFIG_S390X_LEGACY_CPUS
>> +
>>   static void ccw_machine_6_0_instance_options(MachineState *machine)
>>   {
>>       static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V6_0 };
> 
> Should we deprecate machines up to v6.0?

I'm still hoping that Daniel will be able to get his auto-deprecation 
patches merged in this cycle - then we shouldn't derive from that, I think.

By the way, what's up with your i440fx removal series? ... it would be good 
to get this finally merged now...?

  Thomas


