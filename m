Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E317CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Wu3-00078T-2X; Tue, 30 Sep 2025 05:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Wu1-00077w-0O
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Wtw-0003D6-Dy
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759225442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZS6ES16sP6izyUK3cirrwFNPZZwk8SUF8J4M0xJ0kU0=;
 b=Qu22aoV76deF6T0H/GMiFGlZHV+XKncwZ57eYEYvzJehEpnkphtw0tkXcJc7Rmc4tEaxUq
 he/pGwOt/RE2uaCsKvv5YQp5enB27GhqM2tQl/JlhVop+zkgovhNJdxacwIJnMhR/H22n8
 dsl6FayaoRwVXIxKQw1XiNU4ED6GE8g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-OZUErcbiOWyGCJEVPWW9ZQ-1; Tue, 30 Sep 2025 05:44:00 -0400
X-MC-Unique: OZUErcbiOWyGCJEVPWW9ZQ-1
X-Mimecast-MFC-AGG-ID: OZUErcbiOWyGCJEVPWW9ZQ_1759225440
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e38957979so26777675e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759225439; x=1759830239;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZS6ES16sP6izyUK3cirrwFNPZZwk8SUF8J4M0xJ0kU0=;
 b=qsCYOIo9j6DTlc4y7PCXXQib0zg3abDfaRKHEYjPh5D+9CD3idMetpDDMg/poHWLp4
 HBOukdC2e4rZXLJpsfyWGtbl7wV5wySry24OD0CN8y9tiwdFoyCvP/xdPXPC9PQz6MX9
 lfV3w1ExoKSFLrJrLOfzfKIgds1IRKHYY3doA8zPtT9SbU192SuNWgG+sjJ3vMrU9w/8
 IeSMsNUWY5ueKl08dLH6qYQ3wTMpURO7VbschsFlzbJa+aLU4cssbmwtfNtRjnqcbno5
 Ixq6wozszPmEnkMVgSL/h6JSyl6m57nUVRrvV6+kO6LAd9QTE7qCfIv63GH5j2a8sbp5
 48yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIjfz7a4TX5R3BKOA+WxtxtpWqdh0LE89DUKuwW8daqSFG8QAxgUmbzxk7RLVfUOWSX/1lE0y1FVOt@nongnu.org
X-Gm-Message-State: AOJu0Yw9EkpHvSZ5mKyJFwz5+fDyLawzD6npbYO6j66gzFeVL76B9RiE
 071zRXpufW+hohQ28ZDjTX2883cOxRIDsxeYmTnf0lrAh4xA+AorJ2ZtavFIbbPxLr/LHaCx2xy
 3m77ZoeJ0UwOwedCivBvoRlXET6j+uHAerq2ZYkzJhq/yWcn53JoIAmVo
X-Gm-Gg: ASbGncsVOA0osOhDZ01S4l6UvpBK4uVZrvOIIIAyN50zi5f8X1IQpoX6LaBTlmhH+S6
 2dWvs2ig0qYgW80lqWQ0FYdF08sT9uAOfU/5LqWvhAaJ0BLtH8BODftPDMqQhg3kw/g4oBwNwTP
 HG0f1FzfbGFUfLosnSt3sxQe5VuiM009qnIrpH5iTt/u+yIoOsWgEpSwiz2dQpy2+OzbHwHvKAY
 LiGQvduol/jbwWlLMwHS8Uwr+kaXehjGRRDVYwbQQip8wIrgwujncZAgKOg3U/0T6u6hVfo95Qc
 Z8pvEkLrcyIRFOwk/n5lVACHCQk8T7mseePAjFJM7/t+TNZHDP6yJy2TTivZd9Twvz9CAiq6d8M
 VzdUZxhDQSg==
X-Received: by 2002:a05:600c:154b:b0:46e:4004:a296 with SMTP id
 5b1f17b1804b1-46e4004a52cmr136515845e9.9.1759225439617; 
 Tue, 30 Sep 2025 02:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzwAN7CtqAzj/6vlUc0lbxWQPhntXOJhC2rm/UjvhXWfqmL3iy7/6p6FGtsQuW7IB7kWJpuw==
X-Received: by 2002:a05:600c:154b:b0:46e:4004:a296 with SMTP id
 5b1f17b1804b1-46e4004a52cmr136515595e9.9.1759225439174; 
 Tue, 30 Sep 2025 02:43:59 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm22466627f8f.49.2025.09.30.02.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 02:43:58 -0700 (PDT)
Message-ID: <490df077-5765-4efe-a424-62e168f6be2b@redhat.com>
Date: Tue, 30 Sep 2025 11:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com>
 <9f3a8d43-c428-45d4-bce5-1af764cf18a9@redhat.com>
 <aNuk7o2XYjoFsfXT@redhat.com>
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
In-Reply-To: <aNuk7o2XYjoFsfXT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 30/09/2025 11.37, Daniel P. Berrangé wrote:
> On Tue, Sep 30, 2025 at 11:34:23AM +0200, Thomas Huth wrote:
>> On 18/09/2025 01.21, Zhuoying Cai wrote:
>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>> machine. This allows users to specify one or more certificate file paths
>>> or directories to be used during secure boot.
>>>
>>> Each entry is specified using the syntax:
>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>
>>> Multiple paths can be specify using array properties:
>>> 	boot-certs.0.path=/path/to/cert.pem,
>>> 	boot-certs.1.path=/path/to/cert-dir,
>>> 	boot-certs.2.path=/path/to/another-dir...
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>    docs/system/s390x/secure-ipl.rst   | 21 +++++++++++++++++++++
>>>    hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>>>    include/hw/s390x/s390-virtio-ccw.h |  2 ++
>>>    qapi/machine-s390x.json            | 22 ++++++++++++++++++++++
>>>    qapi/pragma.json                   |  1 +
>>>    qemu-options.hx                    |  6 +++++-
>>>    6 files changed, 81 insertions(+), 1 deletion(-)
>>>    create mode 100644 docs/system/s390x/secure-ipl.rst
>>>
>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>>> new file mode 100644
>>> index 0000000000..92c1bb2153
>>> --- /dev/null
>>> +++ b/docs/system/s390x/secure-ipl.rst
>>> @@ -0,0 +1,21 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +Secure IPL Command Line Options
>>> +===============================
>>> +
>>> +The s390-ccw-virtio machine type supports secure IPL. These parameters allow users
>>> +to provide certificates and enable secure IPL directly via the command line.
>>> +
>>> +Providing Certificates
>>> +----------------------
>>> +
>>> +The certificate store can be populated by supplying a list of X.509 certificate file
>>> +paths or directories containing certificate files on the command-line:
>>> +
>>> +Note: certificate files must have a .pem extension.
>>> +
>>> +.. code-block:: shell
>>> +
>>> +    qemu-system-s390x -machine s390-ccw-virtio, \
>>> +                               boot-certs.0.path=/.../qemu/certs, \
>>> +                               boot-certs.1.path=/another/path/cert.pem ...
>>
>> Using newlines/spaces between parameters does not work, so people cannot
>> copy-n-paste this example to the shell.
>>
>> So I think you either have to merge it into one line, or use multiple
>> "-machine" statements, e.g.:
>>
>>      qemu-system-s390x -M s390-ccw-virtio \
>>                        -M boot-certs.0.path=/.../qemu/certs \
>>                        -M boot-certs.1.path=/another/path/cert.pem ...
> 
> The inability to copy+paste is unfortunate, but IMHO the docs are better
> in the way they are already expressed. Repeating the -M arg in this way
> is not a natural way we'd expect people to configure QEMU, even if it
> happens to work in the case of -M/-machine.

Then I'd vote to have it rather in one line instead.

  Thomas


