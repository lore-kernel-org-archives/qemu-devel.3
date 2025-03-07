Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A35C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZi5-0001km-7m; Fri, 07 Mar 2025 10:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqZhv-0001bn-IM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqZht-0007rL-5f
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741361626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hCRhPXvyCX85zsMcwDpUE6RMIA84YiIbV1AGRbpJT5U=;
 b=HUsANzY84iRNB4CyUQnegJzniLo+Lm7Yx6UpDGgw/NDP/K1pc3ZTOqzAG8ro6met8ytJLh
 8lqIMfY9VzYOXIxEffDZj1oL1LVPF7whsm+dKjYVSYbAzTVwcyBAb9QqCZXeqEv9gZqTFN
 ffB8kJFbbuI5woDLTMm9i6rgPYmiOs4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104--ocwwZuXM2mVJwKc7k9Zpg-1; Fri, 07 Mar 2025 10:33:44 -0500
X-MC-Unique: -ocwwZuXM2mVJwKc7k9Zpg-1
X-Mimecast-MFC-AGG-ID: -ocwwZuXM2mVJwKc7k9Zpg_1741361624
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c0b0cf53f3so362776185a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741361624; x=1741966424;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCRhPXvyCX85zsMcwDpUE6RMIA84YiIbV1AGRbpJT5U=;
 b=VlAdhwnaq2jnfepedY9kp1DupP9WoOaIK5X1ZPT1SBlXf3+59fUZrewvD/T9Vubk2X
 jtwEGG2e3KsxVoDmY1oIucO7xib3Hem0+v39oyJKj/NO1Ak4cT3miiAFXmCrSD+OmLDO
 gkAEkIwpi3Pd7B0D7qrS1fI6zcRGOsW/yzMR1Ih+i0xioS4oBZmRsndy94qm1Z94+3ln
 C6s++JLZDoyBVV7N4aSmEX7bNSSXCUDDZtCbHEH06AXcPvXawzs6eNLfIn56dH3dTO+S
 j4o9QvqW46bjtHs4LT/gqozwlB8bjYFI2dpiKGMRzRnMrzLAUYpKnjiMOeNlsnQGYtzL
 r7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW105gCjbLrJ/xbaVi5bkNX5eY4rssj9JSJrmj74uWPPUXmzmWVcEycGJLxoPF0IaICinkRazryHTy8@nongnu.org
X-Gm-Message-State: AOJu0YzWUgnJ3QTUYZTAyDqFFENtclQ6yIgnWwDLYPXx75XMoY6i+lnS
 zLe2Tw1Ni1ISSi7+li5dCTnmK2MI5YXkLnopBqPwPX3c5MGaplAWrE1z2fEBtJBawkQMzW5+oy8
 uLF35QhLoedScXj9DUf6jpVmaiNExONFTlkNb0BiYibudxEFmO5sf
X-Gm-Gg: ASbGncvCps/rNoYWCRbAh4SmHmdTsa9O7r3y0lTdlfM10dEBbzBhc8dp+igsSQdbAxh
 31T5VXq/20XmJylGfQJm5LmikK22GoRU95bhcdRKjlF4x99MId/t5dVooOnzdfTt2OCwGTexOTc
 ZztAd+xWAxuG7+p7B00uyg+nz4AI+xnFo8M8j2VXUAJgZSLWwSaCeRyhAVXbngapwNdY2ROvn3G
 +pBciCdHRrKwu3ETcT5p+Ddu4XScbcMLjkMg14AnDC3CYkIidIO90r5byR1P1edVw7NWxwUL29D
 cobWlC/Foh3d+5j0njxXHD6i7K04Mzvl26VI/Od9kCElrjg=
X-Received: by 2002:a05:620a:4388:b0:7c0:ca33:6a97 with SMTP id
 af79cd13be357-7c4e16826abmr579172585a.18.1741361624288; 
 Fri, 07 Mar 2025 07:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdKgKBXFDwJt/9xp2SUtaiTJkLMx9uvum/iijtMxk/6pRG+VS2o5q1Nl6TDi9WGabhfRVIQQ==
X-Received: by 2002:a05:620a:4388:b0:7c0:ca33:6a97 with SMTP id
 af79cd13be357-7c4e16826abmr579168085a.18.1741361623935; 
 Fri, 07 Mar 2025 07:33:43 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e5511047sm252831985a.100.2025.03.07.07.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 07:33:43 -0800 (PST)
Message-ID: <92f9a303-6a25-452d-adc9-b246953baf50@redhat.com>
Date: Fri, 7 Mar 2025 16:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/11] target/s390x: Add a CONFIG switch to disable legacy
 CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240624091043.177484-1-thuth@redhat.com>
 <20240624091043.177484-12-thuth@redhat.com>
 <ced1ce10-b211-4328-b944-20154c24da63@linaro.org>
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
In-Reply-To: <ced1ce10-b211-4328-b944-20154c24da63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 07/03/2025 16.27, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 24/6/24 11:10, Thomas Huth wrote:
>> The oldest model that IBM still supports is the z13. Considering
>> that each generation can "emulate" the previous two generations
>> in hardware (via the "IBC" feature of the CPUs), this means that
>> everything that is older than z114/196 is not an officially supported
>> CPU model anymore. The Linux kernel still support the z10, so if
>> we also take this into account, everything older than that can
>> definitely be considered as a legacy CPU model.
>>
>> For downstream builds of QEMU, we would like to be able to disable
>> these legacy CPUs in the build. Thus add a CONFIG switch that can be
>> used to disable them (and old machine types that use them by default).
>>
>> Message-Id: <20240614125019.588928-1-thuth@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/s390-virtio-ccw.c | 5 +++++
>>   target/s390x/cpu_models.c  | 9 +++++++++
>>   target/s390x/Kconfig       | 5 +++++
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3d0bc3e7f2..cd063f8b64 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -47,6 +47,7 @@
>>   #include "migration/blocker.h"
>>   #include "qapi/visitor.h"
>>   #include "hw/s390x/cpu-topology.h"
>> +#include CONFIG_DEVICES
>>   static Error *pv_mig_blocker;
>> @@ -1126,6 +1127,8 @@ static void 
>> ccw_machine_2_12_class_options(MachineClass *mc)
>>   }
>>   DEFINE_CCW_MACHINE(2_12, "2.12", false);
>> +#ifdef CONFIG_S390X_LEGACY_CPUS
>> +
>>   static void ccw_machine_2_11_instance_options(MachineState *machine)
>>   {
>>       static const S390FeatInit qemu_cpu_feat = 
>> { S390_FEAT_LIST_QEMU_V2_11 };
>> @@ -1272,6 +1275,8 @@ static void 
>> ccw_machine_2_4_class_options(MachineClass *mc)
>>   }
>>   DEFINE_CCW_MACHINE(2_4, "2.4", false);
>> +#endif
>> +
>>   static void ccw_machine_register_types(void)
>>   {
>>       type_register_static(&ccw_machine_info);
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index efb508cd2e..a27f4b6f79 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -25,6 +25,7 @@
>>   #ifndef CONFIG_USER_ONLY
>>   #include "sysemu/sysemu.h"
>>   #include "target/s390x/kvm/pv.h"
>> +#include CONFIG_DEVICES
>>   #endif
>>   #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
>> @@ -47,6 +48,13 @@
>>    * generation 15 one base feature and one optional feature have been 
>> deprecated.
>>    */
>>   static S390CPUDef s390_cpu_defs[] = {
>> +    /*
>> +     * Linux requires at least z10 nowadays, and IBM only supports recent 
>> CPUs
>> +     * (see https://www.ibm.com/support/pages/ibm-mainframe-life-cycle- 
>> history),
>> +     * so we consider older CPUs as legacy that can optionally be 
>> disabled via
>> +     * the CONFIG_S390X_LEGACY_CPUS config switch.
>> +     */
>> +#if defined(CONFIG_S390X_LEGACY_CPUS) || defined(CONFIG_USER_ONLY)
>>       CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 
>> GA1"),
>>       CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM zSeries 
>> 900 GA2"),
>>       CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM zSeries 
>> 900 GA3"),
>> @@ -64,6 +72,7 @@ static S390CPUDef s390_cpu_defs[] = {
>>       CPUDEF_INIT(0x2096, 9, 2, 40, 0x00000000U, "z9BC", "IBM System z9 BC 
>> GA1"),
>>       CPUDEF_INIT(0x2094, 9, 3, 40, 0x00000000U, "z9EC.3", "IBM System z9 
>> EC GA3"),
>>       CPUDEF_INIT(0x2096, 9, 3, 40, 0x00000000U, "z9BC.2", "IBM System z9 
>> BC GA2"),
>> +#endif
>>       CPUDEF_INIT(0x2097, 10, 1, 43, 0x00000000U, "z10EC", "IBM System z10 
>> EC GA1"),
>>       CPUDEF_INIT(0x2097, 10, 2, 43, 0x00000000U, "z10EC.2", "IBM System 
>> z10 EC GA2"),
>>       CPUDEF_INIT(0x2098, 10, 2, 43, 0x00000000U, "z10BC", "IBM System z10 
>> BC GA1"),
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
> 
> Do we have plan to deprecate or switch that off?

No, this is mainly a config knob for downstream builds that do not want to 
include legacy CPUs, but for upstream it should be fine to keep those around.

Why do you ask?

  Thomas


