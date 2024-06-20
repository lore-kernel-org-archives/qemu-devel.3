Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD56C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLRC-0008KD-HG; Thu, 20 Jun 2024 13:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKLRA-0008JZ-Em
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKLR8-0004vp-Nv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718903940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4HV8IXNm9fsVPDhyNHFw3KBX78cttSIyqr1tkW2rGhY=;
 b=frFzdKeLChfd9oUUg5pYMA7BNUUlYtgKj30IyY4IK57d0t2hTJaUJCIqG3zmUbRgvvjtqQ
 qhm4I64kmPjUoUESUH9Y1f9lOHxt1oA1V/xPmjcgzfteSpLInGahnlsdyAehfQlpTFh164
 vtfWe0xVYYLGugIJzH3KyoqUxfyUFMk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-qmc8FIasPoyVniVYn1E89A-1; Thu, 20 Jun 2024 13:18:56 -0400
X-MC-Unique: qmc8FIasPoyVniVYn1E89A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d22ea3e71so507734a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 10:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718903935; x=1719508735;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4HV8IXNm9fsVPDhyNHFw3KBX78cttSIyqr1tkW2rGhY=;
 b=siGk0vF0aQbLrw5QJJRoM29cbV1ebpqpqRmHRp/DVLLN9nFGOG0Wl2UCTgoLXU6E/+
 MIvXPhE6EmzahYxYJqhT61N7C0PW0+szZqNxKkyPcQtNpVWXos3JfYXHvQ92iGwsnHIw
 ob6rOoTVYx1RMxvHfRzgXjJsZsXggBztUYUbqPaJNaSXG682yashtzlHxn2iKyOiTWVa
 yUfW+6GAaUukeJRxWRkE+fsdxYJwRSjgtzO/Du4CbYa67C1AR2gSCMo03F3GIskmLP5y
 KAup0C+zVeww6mxBy8gAt41z+d6CZuS1lr2KkGaqiwaCPJuZKfYd2SdhN4O/rOYWENdW
 jVZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgImkrxYpm7junyLD3mfkkajmLsH2/RW/LRAND5Xf8L2K8bEuLNCWUCdGcfEo3Z5V3zvHsfsn8qfEK3Kmo5NgVB+cMwFM=
X-Gm-Message-State: AOJu0YwtGs4VZ6hizz/OrXgMWTHZ/Q8LzYlQtkVPBY4dwZRkWdiWvtER
 Wk3zYItEu893TddHMA9CaqI/ocT+kRh5Tm1LmjbKuX0W1wE0cqLbXnIJq3jEQUuAXgOPxve9L+S
 uPbDHAubkLIAojIZEDzMwQsq6TT4zy0Jgl/y2M1ANNd35RHKxa1ZB
X-Received: by 2002:a05:6402:50c9:b0:57d:15d4:a685 with SMTP id
 4fb4d7f45d1cf-57d15d4a9fdmr3555230a12.40.1718903935374; 
 Thu, 20 Jun 2024 10:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVexZNb3iKApxhhE3Kvs4c6ov6DkieaxjgHpjKK9h7f0Du+GiB8N7bF0RYp9fw4ua6pbOQAg==
X-Received: by 2002:a05:6402:50c9:b0:57d:15d4:a685 with SMTP id
 4fb4d7f45d1cf-57d15d4a9fdmr3555210a12.40.1718903934982; 
 Thu, 20 Jun 2024 10:18:54 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-117.web.vodafone.de.
 [109.43.178.117]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d0d9c3b7fsm1999762a12.55.2024.06.20.10.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:18:54 -0700 (PDT)
Message-ID: <fb06af10-2647-4f1b-9fbe-ab4e45a924d9@redhat.com>
Date: Thu, 20 Jun 2024 19:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] include/hw: temporarily disable deletion of
 versioned machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-10-berrange@redhat.com>
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
In-Reply-To: <20240620165742.1711389-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On 20/06/2024 18.57, Daniel P. Berrangé wrote:
> The new deprecation and deletion policy for versioned machine types is
> being introduced in QEMU 9.1.0.
> 
> Under the new policy a number of old machine types (any prior to 2.12)
> would be liable for immediate deletion which would be a violation of our
> historical deprecation and removal policy
> 
> Thus automatic deletions (by skipping QOM registration) are temporarily
> gated on existance of the env variable "QEMU_DELETE_MACHINES" / QEMU
> version number >= 10.1.0. This allows opt-in testing of the automatic
> deletion logic, while activating it fully in QEMU >= 10.1.0.
> 
> This whole commit should be reverted in the 10.1.0 dev cycle or shortly
> thereafter.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/hw/boards.h | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 187ed76646..ef6f18f2c1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -686,11 +686,28 @@ struct MachineState {
>    * suitable period of time has passed, it will cause
>    * execution of the method to return, avoiding registration
>    * of the machine
> + *
> + * The new deprecation and deletion policy for versioned
> + * machine types was introduced in QEMU 9.1.0.
> + *
> + * Under the new policy a number of old machine types (any
> + * prior to 2.12) would be liable for immediate deletion
> + * which would be a violation of our historical deprecation
> + * and removal policy
> + *
> + * Thus deletions are temporarily gated on existance of
> + * the env variable "QEMU_DELETE_MACHINES" / QEMU version
> + * number >= 10.1.0. This gate can be deleted in the 10.1.0
> + * dev cycle
>    */
>   #define MACHINE_VER_DELETION(...) \
>       do { \
>           if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
> -            return; \
> +            if (getenv("QEMU_DELETE_MACHINES") || \
> +                QEMU_VERSION_MAJOR > 10 || (QEMU_VERSION_MAJOR == 10 && \
> +                                            QEMU_VERSION_MINOR >= 1)) { \
> +                return; \
> +            } \
>           } \
>       } while (0)
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


