Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6711CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVTd-00047G-Cm; Mon, 25 Aug 2025 07:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqVTY-00046K-SS
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqVTR-0005wq-OT
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756121688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6//xgR4ehJunBpKrOSTEk+Vg96Os9BXcvEztpOAIduw=;
 b=V8MI7rbH+WqmKLtKfK4DVwJz9JTG9szByXpa+NC+kgZEhX9DK36iciykebvgvQ9wW4BbXG
 QvijhL105MCkKYMX3kkB1U9nWi8BfRY8BGqjlvomxHRj/6N3hRaQ92Rg8EbHKpRTj7wby1
 lgfpyiQv3mkSzpeipReag9TtMDC28X8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-OvY-MTrUOFGcHX3HxB5TJg-1; Mon, 25 Aug 2025 07:34:47 -0400
X-MC-Unique: OvY-MTrUOFGcHX3HxB5TJg-1
X-Mimecast-MFC-AGG-ID: OvY-MTrUOFGcHX3HxB5TJg_1756121687
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b109ab1e1dso181688521cf.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756121687; x=1756726487;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6//xgR4ehJunBpKrOSTEk+Vg96Os9BXcvEztpOAIduw=;
 b=lPRfY5jRnggR1EbcqmZ6hTfxKU2hlvr9D9lk4YKLHODL555Am1jnbEZDX+bA4jndkz
 XsHF/H1xU5YZZUDu83A1hVjof25xLJLBvxBsRi71b3yMONljX3+ARyEri77FGS+G/A7M
 Sk0hBj5nPX+u0d1Rurv74QOVu4k1ov1sA5k8HiI2ab7L7p360ulyWc3fmUHbLuEkwU0d
 Qd4X4yntOeVGD/npPQ0vwtkJafZeAjisbyfh++kbHjaulQkYUk7yo/KNR5pQqSR0JAdi
 n8DTFFufdQiVFRT0+qBIQDOhNg3pd8r8tAXvKouMcqL0mEK4OSQHt4UUqHq7Q1VUgVIs
 2WVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV12UQ+MkMxKeRE+4/rBBARHMkMRvx9qktaXQE3mjetZAH1YlQYRR//mwsHd1267J/7rmqCbjj2zIgy@nongnu.org
X-Gm-Message-State: AOJu0Yzg59/gWUNKIjCRIlnUGxZuqiElrTrU75g0k39JU8+zI8fjMcnA
 tBghPqIbo79W6N1+Do3cKIvR8fwpop77aLcsg4okJjroThAypVrW0d4JHLnZIjYPTf402UYKyxC
 AF4JXKZU7pMPArxHagu+QiZ1wykkGb0XFP93SJN68aS2yC61sy99Tfx+m
X-Gm-Gg: ASbGnctbItzoEvklYvJmAMzfPz0LOPfnwn7DqL5DZMcPkiyzbUfDk70unS6m2OyqY8p
 kppPK8v5EDVYlbyFtYbfccWnLCsns0Y4LeTklG4iZWvT5qeFs6D34gL1POaJCHYc4V3nHZ9E6i9
 xEyVQ8b/leRLy9iUIKT0p1HEg9de5kbNeOmYJ0aTFQrtWfROwCNnxVYYFuQqJ23TtQivnfAQTlp
 IAH9I9X5qKKp1Ynn/3IK3wKqx95UohPh3vVXeMHN3IKpYRJdogZNZGg6FPOcRLXvRn+mgnRmi1C
 5OflHYr0joaiBYpLOnLt2AwNvZZQbLb+FVVLL2pNS+iOwPmPDhBd+O6F1e5CW5x9iDolBDmhU+B
 EhUo=
X-Received: by 2002:a05:622a:1a16:b0:4af:c0b6:b297 with SMTP id
 d75a77b69052e-4b2aab4a136mr145631141cf.50.1756121686344; 
 Mon, 25 Aug 2025 04:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF84dx3EqCTx1qVX+9tZBEtyN4yH0LRlcLmg2havOQQIQMZZy/bzGhtIYUGK854YEdN69TKmg==
X-Received: by 2002:a05:622a:1a16:b0:4af:c0b6:b297 with SMTP id
 d75a77b69052e-4b2aab4a136mr145630771cf.50.1756121685926; 
 Mon, 25 Aug 2025 04:34:45 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ebeca23e05sm474735585a.1.2025.08.25.04.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 04:34:45 -0700 (PDT)
Message-ID: <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
Date: Mon, 25 Aug 2025 13:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
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
In-Reply-To: <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/08/2025 13.24, Harsh Prateek Bora wrote:
> Hi Glenn,
> 
> This seems significant work. Thanks for upstreaming.
> 
> On 8/20/25 02:58, Glenn Miles wrote:
>> Adds the IBM PPE42 family of processors supporting the
> 
> family of 32-bit processors ?
> 
>> PPE42, PPE42X and PPE42XM processor versions.  These
>> processors are used as embedded processors in the IBM
>> Power9, Power10 and Power12 processors for various
>> tasks.  It is basically a stripped down version of the
>> IBM PowerPC 405 processor, with some added instructions
>> for handling 64-bit loads and stores.
>>
>> For more information on the PPE 42 processor please visit:
>>
>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>
>> Supports PPE42 SPR's (Including the MSR) and  Exceptions.
>>
>> Does not yet support new PPE42 instructions and does not
>> prevent access to some invalid instructions and registers
>> (currently allows for access to invalid GPR's and CR fields).
>>
>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>> ---
>>   target/ppc/cpu-models.c      |   7 +
>>   target/ppc/cpu-models.h      |   4 +
>>   target/ppc/cpu.h             |  66 +++++++-
>>   target/ppc/cpu_init.c        | 286 ++++++++++++++++++++++++++++++-----
>>   target/ppc/excp_helper.c     | 171 +++++++++++++++++++++
>>   target/ppc/helper_regs.c     |  28 +++-
>>   target/ppc/tcg-excp_helper.c |  12 ++
>>   target/ppc/translate.c       |   6 +-
>>   8 files changed, 535 insertions(+), 45 deletions(-)
>>
>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>> index ea86ea202a..09f73e23a8 100644
>> --- a/target/ppc/cpu-models.c
>> +++ b/target/ppc/cpu-models.c
>> @@ -116,6 +116,13 @@
>>                   NULL)
>>       POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
>>                   NULL)
>> +    /* PPE42 Embedded 
>> Controllers                                            */
>> +    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42,                  ppe42,
>> +                "Generic PPE 42")
>> +    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X,                 ppe42x,
>> +                "Generic PPE 42X")
>> +    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM,                
>> ppe42xm,
>> +                "Generic PPE 42XM")
> 
> Can all the PPE42 specific code be conditionally compiled only for
> !TARGET_PPC64 (and !CONFIG_USER_ONLY wherever possible)?
> Not only to reduce the bloating size of respective binaries, but also to
> avoid some code being added to hot path routines like 
> hreg_compute_hflags_value().

qemu-system-ppc64 is a superset of qemu-system-ppc, and there are even 
efforts to unify all system functionality into a singly binary, so excluding 
a 32-bit feature from qemu-system-ppc64 sounds like a step into the wrong 
direction to me right now...?

  Thomas


