Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E75C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 06:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri6pB-0000sw-5I; Thu, 07 Mar 2024 01:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ri6p9-0000sn-LQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ri6p7-0006l7-UV
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709791304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hEodcv759yWJDz/L5AEWQMJ/8SwIEBh3cgCcN9Btero=;
 b=gddStgswo7DMc3H00Ir66GY6vL3xuvCb6bUYH4N+In5ZwE9+SQBQw9az1uKiz/iOUINUG4
 JlUEbW0L3lwyX9R7dx/T37DJiV3GEP8C+qv4dnpWmwpAN2LqvIBECjSx1ob1mTt7+JLpD/
 VjtfEI9kPZloBhmoPYnnn/g5ifcaGeo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-BrzTnbUcNVmRyvZsAQ9ckw-1; Thu, 07 Mar 2024 01:01:43 -0500
X-MC-Unique: BrzTnbUcNVmRyvZsAQ9ckw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d30bed153fso3463591fa.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 22:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709791301; x=1710396101;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEodcv759yWJDz/L5AEWQMJ/8SwIEBh3cgCcN9Btero=;
 b=aqDDqHHiV5tBPxw8rnMTFjzplZs9wlwu+NzggbZGLq3uG8WdtWrimruLCTka03V2H+
 zdFtuMnA5ZuByOMHM4tNBOjzZjnthUBCMGflmrJZWScU+ZuSzwn2Q4R6nP2DqkTFCit4
 NBvq36A+wAFWlGY50u8sL5YDO9Z5RJKF4PxmPfVHUa/r13iSmCMMTD1h+q65S8TVpeFE
 GllkSgDaPXNGxMiWLHAHPv/YY54lrQ9rRu2uyV+qlC5zCTmKL2+zTFny080/GgsQFFnr
 sr41VqFJ7fv67EBRHKkIx1Nm0/ZsDMbiyOa9v9kY+9/mhrZSN0LvN4wztiwJj0J2Nsv1
 nqlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo47JqgA5HeEAF3uY1dV2UbRCEqoBOEuyGzCyunA4CYvZNL/YYzlWQ3XL6kjG6nNsnZTx5Ygj23G+mczaGlnThxmxOW48=
X-Gm-Message-State: AOJu0YzoYud0nO25rZLb4DsEB03WRvxCYSOCmFBuzlZHWzrqBT0O8o7Q
 FbtKjZICwiqW2fqE1Gih+k1NHtTs8goiDLre9dudPiFgPuqkB2XrkbRENFAgnm5gyPLBo3zgRis
 dNbebL4xfYwlGH81GYyAYpokc5+XKtb6nArROaiN5ZITF3K3eTJO6
X-Received: by 2002:a2e:8019:0:b0:2d2:8727:4504 with SMTP id
 j25-20020a2e8019000000b002d287274504mr689147ljg.28.1709791301703; 
 Wed, 06 Mar 2024 22:01:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBXvSBdtpUHEPfY32sZ3IbO1lWX4WGVe3DaNGzMwMKVHhrWdObwUn4gla3SgP80OJT0ZFXGg==
X-Received: by 2002:a2e:8019:0:b0:2d2:8727:4504 with SMTP id
 j25-20020a2e8019000000b002d287274504mr689136ljg.28.1709791301338; 
 Wed, 06 Mar 2024 22:01:41 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 n7-20020a05640206c700b00566757b30fbsm7637255edy.45.2024.03.06.22.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 22:01:40 -0800 (PST)
Message-ID: <90b8cc0e-3ad7-4121-8797-41cb65903fa8@redhat.com>
Date: Thu, 7 Mar 2024 07:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] tests/unit/test-smp-parse: Bump max_cpus to 4096
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-8-zhao1.liu@linux.intel.com>
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
In-Reply-To: <20240306095407.3058909-8-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06/03/2024 10.54, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The q35 machine is trying to support up to 4096 vCPUs [1], so it's
> necessary to bump max_cpus in test-smp-parse to 4096 to cover the
> topological needs of future machines.
> 
> [1]: https://lore.kernel.org/qemu-devel/20240228143351.3967-1-anisinha@redhat.com/
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Xiaoling Song <xiaoling.song@intel.com>
> ---
>   tests/unit/test-smp-parse.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 84e342277452..2eb9533bc505 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -20,8 +20,8 @@
>   #define T true
>   #define F false
>   
> -#define MIN_CPUS 1   /* set the min CPUs supported by the machine as 1 */
> -#define MAX_CPUS 512 /* set the max CPUs supported by the machine as 512 */
> +#define MIN_CPUS 1    /* set the min CPUs supported by the machine as 1 */
> +#define MAX_CPUS 4096 /* set the max CPUs supported by the machine as 4096 */
>   
>   #define SMP_MACHINE_NAME "TEST-SMP"
>   
> @@ -333,13 +333,13 @@ static const struct SMPTestData data_generic_invalid[] = {
>                           "by machine '" SMP_MACHINE_NAME "' is 2",
>       }, {
>           /*
> -         * config: -smp 512
> +         * config: -smp 4096
>            * The test machine should tweak the supported max CPUs to
> -         * 511 (MAX_CPUS - 1) for testing.
> +         * 4095 (MAX_CPUS - 1) for testing.
>            */
> -        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
> -        .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
> -                        "by machine '" SMP_MACHINE_NAME "' is 511",
> +        .config = SMP_CONFIG_GENERIC(T, 4096, F, 0, F, 0, F, 0, F, 0),
> +        .expect_error = "Invalid SMP CPUs 4096. The max CPUs supported "

You could maybe use stringify(MAX_CPUS) in above line
(but it won't work for the 4095 below, so it's maybe not worth the effort)

> +                        "by machine '" SMP_MACHINE_NAME "' is 4095",
>       },
>   };

Reviewed-by: Thomas Huth <thuth@redhat.com>



