Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5373FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4d53-0001nK-6e; Tue, 15 Apr 2025 05:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4d4y-0001mO-Ux
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4d4x-0006IR-BH
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744711182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pxbpjgQMeC9eNrJWHZPnLyPC//BluIigPNV7FD0541w=;
 b=Flm3s3hQ0vH0FF88MWmPBYsxPoASTYnkglS+YOwH0Yj1OvBGyj4lx4NJjzQEa/jRCWMTl8
 i8DtlF60TdXb6hm3M9jos2OxwHR+U2zH+NQ7Oy6FdOM+8kZMSGHCTwjNSO8x9wHfB/o5kD
 7VA9T5ZgW52ZnHLMcrK0h8SqS9aEQYY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-IAtZ_fzDNJmgUpq3qW5mWQ-1; Tue, 15 Apr 2025 05:59:38 -0400
X-MC-Unique: IAtZ_fzDNJmgUpq3qW5mWQ-1
X-Mimecast-MFC-AGG-ID: IAtZ_fzDNJmgUpq3qW5mWQ_1744711177
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so40543115e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 02:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744711177; x=1745315977;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxbpjgQMeC9eNrJWHZPnLyPC//BluIigPNV7FD0541w=;
 b=WNHzRZdVfRj7adBglddMcFATpHF5HfKe1KsPwEFF35ZS2a8Jv0l4kG/R1Hqwe0Yofy
 1SZ7Pqnok0ck3zy4qkfpMTBG8OXnUSd70OjOEirH0Mn8Ai+Oq5r2iPQ/+4J0hha1tXDg
 A6P+sWMSrM6n+ydWwaJL5UxQgQQIreCAa5ioUlGRxjIS4FXauXKi2BJ2mc8mD8c6rFFo
 W7Ie3xDp68lKmCh/nMG8PXIBALTQW5ct7/+Jwl66j4SGKp8zMbdpEAVDZhUARu+hAGmK
 PcHdX6OrRS1jcPVVqjR4eRyqlDmuEEiOHgl1o/AflFq7rRga/PvtMi0Itwdi1p3EZkcN
 IFoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeVR6o5Cn63/blskT6QEbI03O5ya4N/lxM8eNsL31ZA4+8vAEVFndy1UK/jaHSi9BCjmXIP2P9n+P1@nongnu.org
X-Gm-Message-State: AOJu0YwQy/zYdVjdwRf8geeWyXnwvj9rOdlMYUXNEvdf03p9c9KUwurt
 COTYIeuc6ydLe8kS1siRwVZ+rVdfT+bSL5hXkWsv+bcVkH/i1OV1uayOpE3WS3GnA2+hCZsHHT6
 DIHRc8zmc0Dt3YT7tZYjPzGNPLh2C13bjQ2fthsMiKp+sDqBcniGIYbgWCREMrpk=
X-Gm-Gg: ASbGncucFeswXnSVwB03G8/y1bLmMQY3bBKttVngCg8mjh+96oscBUTgjG+2Fpo/S05
 NdFunUY2FFgnQ5rjAx8ZvVu9RxT40KeB+McRhRK30QJGRG28HkHI1hKXYYZfALm9WZgewc1yNt4
 kIJov+GDhrOVoULkAxUBC+hkzeXcTAvNL/nxsCL7x6m9mPatTjw8pzXs+2kYLY07YuVKYKqgEyU
 mNMlMiI/6HNDo3fzwUdPWrnqjnZE4ijWxamSVdXuzxNiiMSOPRbOgF42dHC4GhuSjMKzQUR7nds
 tc8rxr6rliVFb+A5eXTcJUjVoE96zDC9cbJSK/2rcNs=
X-Received: by 2002:a05:600c:a04:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-43f3a93f7c6mr136240015e9.13.1744711177330; 
 Tue, 15 Apr 2025 02:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHunuwPoK8tSeZLtyxII1zIqJgBqCGs5Dp5nwXBgzvmc5vSdqAYqMT7SIhEZavKFRt5mydv0A==
X-Received: by 2002:a05:600c:a04:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-43f3a93f7c6mr136239785e9.13.1744711176994; 
 Tue, 15 Apr 2025 02:59:36 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c81f6sm200731825e9.20.2025.04.15.02.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 02:59:35 -0700 (PDT)
Message-ID: <88084780-38b2-4ca9-a2ff-ecd70d62c361@redhat.com>
Date: Tue, 15 Apr 2025 11:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/s390x: Return UVC cmd code, RC and RRC
 value when DIAG 308 Subcode 10 fails to enter secure mode
To: Gautam Gala <ggala@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, seiden@linux.ibm.com
References: <20250414154838.556265-1-ggala@linux.ibm.com>
 <20250414154838.556265-4-ggala@linux.ibm.com>
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
In-Reply-To: <20250414154838.556265-4-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi!

On 14/04/2025 17.48, Gautam Gala wrote:
> Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
> in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
> function does not complete successfully (in addition to the
> previously returned diag response code in bit position 47-63).
> 
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
...
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d9e683c5b4..e35997acbd 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -53,6 +53,13 @@
>   
>   static Error *pv_mig_blocker;
>   
> +struct Diag308Response {
> +    uint16_t pv_cmd;
> +    uint16_t pv_rrc;
> +    uint16_t pv_rc;
> +    uint16_t diag_rc;
> +};
> +
>   static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
>                                 Error **errp)
>   {
> @@ -364,7 +371,10 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
>       ram_block_discard_disable(false);
>   }
>   
> -static int s390_machine_protect(S390CcwMachineState *ms)
> +static int s390_machine_protect(S390CcwMachineState *ms,
> +                                uint16_t *pv_cmd,
> +                                uint16_t *pv_rc,
> +                                uint16_t *pv_rrc)

Instead of adding these three pointer parameters to each and every 
functions, how's about only adding a Diag308Response pointer instead?

...
> @@ -539,8 +550,9 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
>           }
>           run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>   
> -        if (s390_machine_protect(ms)) {
> -            s390_pv_inject_reset_error(cs);
> +        if (s390_machine_protect(ms, &resp.pv_cmd, &resp.pv_rc, &resp.pv_rrc)) {
> +            resp.diag_rc = DIAG_308_RC_INVAL_FOR_PV;
> +            s390_pv_inject_reset_error(cs, (uint64_t *)(&resp));

Uh, this smells like it could break strict aliasing rules, please don't do 
type-punning like this. I'd suggest to either wrap Diag308Response in an 
union with an uint64_t as second field, or calculate the value by shifting 
the individual fields and pass that 64-bit result to the function.

  Thanks,
   Thomas


> -void s390_pv_inject_reset_error(CPUState *cs)
> +void s390_pv_inject_reset_error(CPUState *cs, uint64_t *resp)
>   {
>       int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
>       CPUS390XState *env = &S390_CPU(cs)->env;
>   
>       /* Report that we are unable to enter protected mode */
> -    env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
> +    env->regs[r1 + 1] = *resp;
>   }
>   


