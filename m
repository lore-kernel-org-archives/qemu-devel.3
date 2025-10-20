Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB26CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAt5d-0001Hg-4Y; Mon, 20 Oct 2025 12:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAt5b-0001Gs-J1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAt5Y-00057S-4E
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760979021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ij+VDL3oB8KzzJXYrm54Rgidw/MIXTesrQtpPTnMfZI=;
 b=htDZ/+Tmh7YsbpLwMdayiH0sHTGJuJxbPvB5IADsE0wwInueFKwavktocM1/BzfZ2+CJLI
 8mHqlFKAfeHjgHW4ys6gPMyseDSu+bCZY30haHaTf7lc9U2YRdD51dZMrOfL4E9MkOCzW0
 FEzFzCwEvhDE8+iOOqZMQT/kg0Y9fPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-dvTs-Oj3PS-lu94S8g_J-w-1; Mon, 20 Oct 2025 12:50:18 -0400
X-MC-Unique: dvTs-Oj3PS-lu94S8g_J-w-1
X-Mimecast-MFC-AGG-ID: dvTs-Oj3PS-lu94S8g_J-w_1760979018
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47113dcc15dso33767155e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760979017; x=1761583817;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ij+VDL3oB8KzzJXYrm54Rgidw/MIXTesrQtpPTnMfZI=;
 b=qpzZE4PHzYo1X2IEku19lLL3o03EvGVdFv7sfjm1FoUs7+imYHZP8Ut2x5LhLkAYuy
 Pn6gFrg2c43K+LL5m0cuxNtrPUWhHHK9jEgdgohFlRKenXOMG7rmutZiLTPSc6GoBG7w
 GIW20/2ZHrT6W0/uegHLrUmWsX9v8fwAwf4wDHHPp8NrJUUHGdo6oJgOGD69rNSBaNva
 k2DDg1W10daa/RoboqkqGPqiqIqD5eOK4PKiSNHdQW9MuKKC9EGsXNhutlUhpfVFJqH5
 E8RfboVf2pqDPR7qXcIr9mAPLJ0qvlOzKfUM8RAGjMjkhQWXKZ94vIsyFzdyHpupKpyo
 YaYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFgJ9K9pmqJBbef+nyd2HzsTRb0vQi8BOQq554XCaysaHaiM0JjrLQz1ljmV/sfQxxTAa8NTEA+NY@nongnu.org
X-Gm-Message-State: AOJu0YxyzNIhuRB1z6NPp9t7Cb93lHEvm0sNF3JNgOL5XGmkTxvCplTH
 QdrziqY5NUmsFk2MTcUlkt6JNtlehLsubMvHsMAXBt4xjOTTMhfD2gdjcd0pm/Px/RNh7TYEmUv
 Jh3bmscDkos4q0XKmif0wvdnW/89sWxH615My53p0SafOsunUCgoFbLp8
X-Gm-Gg: ASbGncucazYJ5m8z0+Dn38lZ6rTU0q+3HqFwS8DpbFWYMl3pOWmH0gR4Np8w5mP1DyL
 1dR2iWyAEZcoPjbKIvC/mVdFo8AF6p0rdhE/v7wfaigo1fa58BQknxBtID4GDybydKnpKMjBDYq
 G3zEPHxZVbWn7jW5iLsXA6mUugdP4itJ+Rj4BAqH1AK/2T47IsKA4Xw8akjIXpuGMfk1D8Z+G7O
 c6hjYVgyO6efewusvMAmBgwrzgJ7B8kncFPO6MzKU1A8Qqwn1grNRqVigBS5iz6UdLzjYwxrZMP
 KckzVFAjpQN6/fnADljn1YxXNYRCv4GNgPpzedSlVuGiT9WVBpju6qz7cFHcwyM233L+qhvP8B2
 36efEI+i2gV1I2Iq5MIx7NcEyoW9rfZCD0A+zoEJo
X-Received: by 2002:a05:600c:1ca0:b0:471:6f4:601f with SMTP id
 5b1f17b1804b1-4711790084amr119686045e9.19.1760979017550; 
 Mon, 20 Oct 2025 09:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPHMVbBEZjCDsL+8+GlzdQikpa6M7WKS+tjMp6E22/Xg3VAC3dZUjD5aoGG5VEuW8uOUOZTg==
X-Received: by 2002:a05:600c:1ca0:b0:471:6f4:601f with SMTP id
 5b1f17b1804b1-4711790084amr119685855e9.19.1760979017198; 
 Mon, 20 Oct 2025 09:50:17 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82b8sm240025305e9.15.2025.10.20.09.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 09:50:16 -0700 (PDT)
Message-ID: <f1fa94aa-d0b3-4855-ba83-30b8239297ef@redhat.com>
Date: Mon, 20 Oct 2025 18:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pc-bios/s390-ccw: Fix Misattributed Function
 Prototypes
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-2-jrossi@linux.ibm.com>
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
In-Reply-To: <20251020162023.3649165-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The virtio-blkdev functions are incorrectly listed in s390-ccw.h as belonging to
> virtio.c.  Additionally, virtio_load_direct() has an unused subchan_id argument.
> 
> Remove the unused argument and move the prototypes to virtio.h so that they are
> independent from the CCW bus.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---

I'd maybe spell "Misattributed Function Prototypes" with small letters in 
the title, but apart from that, patch looks good to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>


