Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B08C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 04:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAMCS-0007jE-53; Fri, 24 May 2024 00:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sAMCN-0007iN-44
 for qemu-devel@nongnu.org; Fri, 24 May 2024 00:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sAMCK-0007yd-VO
 for qemu-devel@nongnu.org; Fri, 24 May 2024 00:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716523588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+YCppyObxRYu70r5SrOmdANgE9gKPqwFGLGJ1MpppgQ=;
 b=Q9E8gZv+PhuaD5ug4n/0z72GLRpi2g6hHjKeBH7aHbA4SRS5NXgkpYJhl1fLQm3Qm50uuP
 5BsLc8NYTZSh0+TlTBRl8zXSHwB1trAzXc/asbhHazl5lVw+iAi2jT0pfqa9b32vZXs7gC
 NZbD66KUqgQhQsIGZ36HyQ4jT0RNtck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-wPknf_IXP0yszKypzttNzg-1; Fri, 24 May 2024 00:06:18 -0400
X-MC-Unique: wPknf_IXP0yszKypzttNzg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6266c77502so16168366b.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 21:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716523567; x=1717128367;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YCppyObxRYu70r5SrOmdANgE9gKPqwFGLGJ1MpppgQ=;
 b=cZ4rym+20O9xMY9WezxO13EO3ZaVoN6VumEhlYorezRwGK+xNqW0QqRlVm4JW/dQYe
 AS3nJbCgziiPQElETzdrPESEcKqPL4jb2uOptrzpwZuzd84wNreCCplF5aiSO1PUlVTz
 TsZ9NB8Ruj65TTBJYoNSd2hoPCqLI0vxALH9hdvGLXIVTp3QxH4Wfnt6G/W/RTK/Pgj6
 1QQUuGiySLFcZpGPrgQmgzOvfa6WhQi4yUZXSNWOZS4z59FQK6mBF/IHEP4JasnqOJ2z
 p5qWMIlyq6Y6YkaP2fqz0ZvCilsLd2HntVu6bGac4WRXzW2ZBnCl2YtOYBUievFbG5lx
 AR7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUekcOry53mLsL4idtbVx78pJa1eew12pd2YGRfzc2Ln4Tod9LpwGBO+sQUu/R5QQWSRe3INLf5o0gaiarrUdcvfILbVy8=
X-Gm-Message-State: AOJu0YwzJ1VVHIAeE1pg/y8O5zRykZ6MyUhLFJOweHHUH6XjS9k3C+Ay
 RC5PhbI9cdvt014cDZVJ5RfN5rSazmvbA06HwITpmtYquOMcCR25FsboGVi5awmql6WF3BvkSRk
 A/oNsEvllo5mfnSh/+C3awC6QWVZ+kZVSAADQQ63HLdGIeMiVzEIK
X-Received: by 2002:a17:906:bca:b0:a5a:743b:20d2 with SMTP id
 a640c23a62f3a-a62643e2436mr56697566b.38.1716523567190; 
 Thu, 23 May 2024 21:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNIQH7dsRVaFEjArZSXUofgJ9qwGrn9dgqaP/k3qNc/s98Isyp3OgTscG3Mw8QZAHQGCTplA==
X-Received: by 2002:a17:906:bca:b0:a5a:743b:20d2 with SMTP id
 a640c23a62f3a-a62643e2436mr56696366b.38.1716523566799; 
 Thu, 23 May 2024 21:06:06 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c938828sm57698566b.81.2024.05.23.21.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 21:06:06 -0700 (PDT)
Message-ID: <0842ead9-6bb2-48c8-a2e6-09c843411ceb@redhat.com>
Date: Fri, 24 May 2024 06:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/migration-test: Run some basic tests on s390x
 and ppc64 with TCG, too
To: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20240522091255.417263-1-thuth@redhat.com>
 <D1HFPB97OMKO.1ALCD8QC6OJ4P@gmail.com>
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
In-Reply-To: <D1HFPB97OMKO.1ALCD8QC6OJ4P@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/05/2024 02.05, Nicholas Piggin wrote:
> On Wed May 22, 2024 at 7:12 PM AEST, Thomas Huth wrote:
>> On s390x, we recently had a regression that broke migration / savevm
>> (see commit bebe9603fc ("hw/intc/s390_flic: Fix crash that occurs when
>> saving the machine state"). The problem was merged without being noticed
>> since we currently do not run any migration / savevm related tests on
>> x86 hosts.
>> While we currently cannot run all migration tests for the s390x target
>> on x86 hosts yet (due to some unresolved issues with TCG), we can at
>> least run some of the non-live tests to avoid such problems in the future.
>> Thus enable the "analyze-script" and the "bad_dest" tests before checking
>> for KVM on s390x or ppc64 (this also fixes the problem that the
>> "analyze-script" test was not run on s390x at all anymore since it got
>> disabled again by accident in a previous refactoring of the code).
> 
> ppc64 is working for me, can it be enabled fully, or is it still
> breaking somewhere? FWIW I have a patch to change it from using
> open-firmware commands to a boot file which speeds it up.

IIRC last time that I tried it was working fine for me, too, but getting a 
speedup here first would be very welcome since using the Forth code slows 
down the whole testing quite a bit.

  Thomas


