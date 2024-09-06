Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6541CE7AF8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 09:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVIz-0003yO-4L; Fri, 06 Sep 2024 05:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smVIx-0003tk-3t
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smVIv-00059B-KA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725615056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qOKKFKYbuMQSWR+axMZoJMgi6WWlB9+9yyfdqg1rhvE=;
 b=glF31BXYL3jBFFQpnyz2kxiC2EbnsG5E07qt0MuYCFpz3UlQ1tXGWPZb2V+Mx5Rj8MIKeM
 KNkpIRQw+2x9WDsHlGqO8IPU88xjKN1BCSiNj7ifdbhencRWmODzXTpVgx1w1/7H4IKdlm
 f+DZOL4X43nawINQ9izXPEKgtvXs15I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QpxBRbyBNmeQCSjyuFBw4Q-1; Fri, 06 Sep 2024 05:30:53 -0400
X-MC-Unique: QpxBRbyBNmeQCSjyuFBw4Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c36310588fso70991786d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 02:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725615053; x=1726219853;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOKKFKYbuMQSWR+axMZoJMgi6WWlB9+9yyfdqg1rhvE=;
 b=PpXE+bcuRO7k2QKTJAQM181h/pmqO/Y6jc968240FKFcMYU35UzxmUzQjrv8vK9bGc
 1Wo4TmOEw0Fs9WGB/rq1+FTa0b2ov8Ok6hywx4TV/TTfH4HIuIRPOik54Y2QiYIegojH
 ZR/411XUNhFkEAgCaLtyz+mfriXJSPt6xj0G1Z1J4ECkOQh7t0glgjaRGsdKZcHFA4Wn
 tCobEXzCoBRmxQ7TFEBJhkCtqNPdcN7FOalNp8kbjZwfeHvmGmMu7n6mb/6t6tgQRIYi
 flzeq/zoentKnprxpckCzz7lvEo1/KUA2FBV0adpszUdwWzYo82lz6YnYdjcisCFNVz4
 9jvA==
X-Gm-Message-State: AOJu0Yz0KJQrPoeLbEzayGgHMKeDkOmf1GNyBvXIG2MbOhHEfFXVY8ep
 /zSAyWeCrAU/rhVb+fzvHL1ZZ30i/OniXpa5i9gjqt7H+/fEf4OIFW+zxs4ryhXfZ4Qxh/idOjr
 bSzIAsbQJBYm53F8A1hXbOLGYr1umSwAEnOKZLkxymNhLkinhycmr
X-Received: by 2002:a05:6214:20a1:b0:6c3:5e89:3b60 with SMTP id
 6a1803df08f44-6c518de510dmr152303146d6.3.1725615052952; 
 Fri, 06 Sep 2024 02:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjb1DZ+45M+vUASwwQ6EVH6AKeDiGOrZP919fX9iriHaHaC3ksYWtTaDGSqTnxcAoa3iAG6g==
X-Received: by 2002:a05:6214:20a1:b0:6c3:5e89:3b60 with SMTP id
 6a1803df08f44-6c518de510dmr152302846d6.3.1725615052584; 
 Fri, 06 Sep 2024 02:30:52 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-115-52.web.vodafone.de.
 [109.43.115.52]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5202de5adsm14990916d6.60.2024.09.06.02.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 02:30:52 -0700 (PDT)
Message-ID: <229d09a5-afbe-4ee1-942c-77e30d629e4d@redhat.com>
Date: Fri, 6 Sep 2024 11:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240906080928.710051-1-thuth@redhat.com>
 <CAFEAcA9b5V8xY0bOn7VdMUuuhSsBF8xmagYxqhgzAyXbFjLNrg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA9b5V8xY0bOn7VdMUuuhSsBF8xmagYxqhgzAyXbFjLNrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06/09/2024 10.58, Peter Maydell wrote:
> On Fri, 6 Sept 2024 at 09:09, Thomas Huth <thuth@redhat.com> wrote:
>>
>> When QEMU has been configured with "--without-default-devices", the build
>> is currently failing with:
>>
>>   /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o:
>>    in function `riscv_cpu_do_interrupt':
>>   .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined
>>    reference to `do_common_semihosting'
>>
>> Avoid calling into do_common_semihosting() if the corresponding Kconfig
>> switch has not been set.
> 
> This would be inconsistent with Arm, where you always
> get semihosting if you're using TCG. (For KVM, semihosting
> is up to the kernel to provide, which is why we don't
> want the code in that case.)
> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/riscv/cpu_helper.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 395a1d9140..c7a6569e2d 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -34,6 +34,10 @@
>>   #include "debug.h"
>>   #include "tcg/oversized-guest.h"
>>
>> +#ifndef CONFIG_USER_ONLY
>> +#include CONFIG_DEVICES
>> +#endif
>> +
>>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>>   {
>>   #ifdef CONFIG_USER_ONLY
>> @@ -1674,10 +1678,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>       if (!async) {
>>           /* set tval to badaddr for traps with address information */
>>           switch (cause) {
>> +#ifdef CONFIG_ARM_COMPATIBLE_SEMIHOSTING
>>           case RISCV_EXCP_SEMIHOST:
>>               do_common_semihosting(cs);
>>               env->pc += 4;
>>               return;
>> +#endif
>>           case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
>>           case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>>           case RISCV_EXCP_LOAD_ADDR_MIS:
> 
> If you do want to do this thhen this isn't sufficient, because
> you would also need to change the code that generates the
> RISCV_EXCP_SEMIHOST exception so that it instead generates
> the "behave as if we don't have semihosting and the
> semihosting-trap instruction sequence were executed "normally".
> But I think the best thing is to use "select if TCG" in the Kconfig.

Ok, but I think we then still need a #ifdef CONFIG_TCG here, otherwise 
linking will fail for KVM-only builds?

  Thomas


