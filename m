Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB3AC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKamX-0005lX-4n; Fri, 21 Jun 2024 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKamV-0005jk-51
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKamT-00010n-Qi
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718962925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vGRNhCrmHELlXVqLW/vxdTkcKuL7V0ZSWCyZh2jmZEQ=;
 b=dGv+BsV4lYXsCGwAZVgFgh5sRKnTxGZ1VBKEFddGHD1x0oq38cg8PWoyoHnncSe8MYk4O8
 pgee6TMZENeDLZfB4c5aXIgdkN1Zc3jgaNZ8lj3EJ/z2y3krxDwOKoHSX//TeE8c40L8Uw
 86BQfhVYV+oU3XNhva1yDymX3sL6ues=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-bcZpqQDCNxqePoR0OwHQtg-1; Fri, 21 Jun 2024 05:42:03 -0400
X-MC-Unique: bcZpqQDCNxqePoR0OwHQtg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-444c70c9171so4152501cf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 02:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718962922; x=1719567722;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vGRNhCrmHELlXVqLW/vxdTkcKuL7V0ZSWCyZh2jmZEQ=;
 b=bXhxCXSn1Rw8mmxJZ7y/G08doc10zhxhYgy2zFXVjMaXQbsW4oOu7SSTUD2VNWPUXt
 j+HArdM1KQh8AkGFY1MNF9h7wkdvAEJJiNYNbLnUVKNGnLKJR7y5tZRlzNKE+2XerIrk
 ldS7CxXRI3Tv62+RkDt5HuF7bCtRJBn2CvF3cfbxpdZeNOHt4WrJ9VyV8nLMIigMxivM
 WCoHOHUib13Hy1Ifmu9fZRqqbpwOxCOFglC3jxSILTclM/V819vPcwOTWg9CMOj//+sf
 6yLPv0sqnKAvmWZVAFYD+Ohg2oJIoqtnbTUIVCKN1GY1x2fBxTk80IYp1BgmYOaOMn0v
 2+Dw==
X-Gm-Message-State: AOJu0YyKhvFN5AjyqhLzX5h0ESrf4BHbde7mU8AvUOJUNuSGVMeYEAOB
 es+SZ0lFHKpu1bubINXP2Pe+zLSk5Em1dJ4ngMdC/8kXQjSS0mTw4l+I+Dx0KMPDPHTWX1gMavf
 5Ir6+gYPYS17xpBPzwb8Qo9A4UCddrQIhETFSOtdH6Ost+OstTThC
X-Received: by 2002:a05:622a:40a:b0:43b:1546:f8a9 with SMTP id
 d75a77b69052e-444a7a4b961mr81703391cf.51.1718962922717; 
 Fri, 21 Jun 2024 02:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHDTdOSyFtQ8FY2dg2tUCUWcd1SDeFpq8koQOtiGKyuOZyAsoIIP1c9HYk31K6Lo4pkDuRQ==
X-Received: by 2002:a05:622a:40a:b0:43b:1546:f8a9 with SMTP id
 d75a77b69052e-444a7a4b961mr81703231cf.51.1718962922380; 
 Fri, 21 Jun 2024 02:42:02 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-117.web.vodafone.de.
 [109.43.178.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-444c2c3d062sm8980801cf.77.2024.06.21.02.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 02:42:02 -0700 (PDT)
Message-ID: <98e98281-f650-4052-ac85-26d95e17c9d8@redhat.com>
Date: Fri, 21 Jun 2024 11:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org, 
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20240621082422.136217-1-thuth@redhat.com>
 <ae2a498e-e809-424b-93f8-d4e7d646df2c@linux.ibm.com>
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
In-Reply-To: <ae2a498e-e809-424b-93f8-d4e7d646df2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 21/06/2024 11.39, Christian Borntraeger wrote:
> [...]
>>   docs/system/s390x/bootdevices.rst |  20 +++----
>>   pc-bios/s390-ccw/netboot.mak      |  62 ---------------------
>>   hw/s390x/ipl.h                    |  12 ++--
>>   pc-bios/s390-ccw/cio.h            |   2 +
>>   pc-bios/s390-ccw/iplb.h           |   4 +-
>>   pc-bios/s390-ccw/libc.h           |  89 ------------------------------
>>   pc-bios/s390-ccw/s390-ccw.h       |  10 +++-
>>   pc-bios/s390-ccw/virtio.h         |   1 -
>>   hw/s390x/ipl.c                    |  65 +++-------------------
>>   hw/s390x/s390-virtio-ccw.c        |  10 +---
>>   pc-bios/s390-ccw/bootmap.c        |   4 +-
>>   pc-bios/s390-ccw/cio.c            |   2 +-
>>   pc-bios/s390-ccw/dasd-ipl.c       |   2 +-
>>   pc-bios/s390-ccw/jump2ipl.c       |   2 +-
>>   pc-bios/s390-ccw/libc.c           |  88 -----------------------------
>>   pc-bios/s390-ccw/main.c           |  15 +++--
>>   pc-bios/s390-ccw/menu.c           |  25 ++++-----
>>   pc-bios/s390-ccw/netmain.c        |  15 +----
>>   pc-bios/s390-ccw/sclp.c           |   2 +-
>>   pc-bios/s390-ccw/virtio-blkdev.c  |   1 -
>>   pc-bios/s390-ccw/virtio-scsi.c    |   2 +-
>>   pc-bios/s390-ccw/virtio.c         |   2 +-
>>   pc-bios/meson.build               |   1 -
>>   pc-bios/s390-ccw/Makefile         |  69 +++++++++++++++++++----
>>   pc-bios/s390-netboot.img          | Bin 67232 -> 0 bytes
> 
> Shouldnt you also update the s390-ccw.img file?

Sure, but I didn't want to spam the mailing list with a binary blob as long 
as this is not final yet (not sure whether we want to commit this separately 
or wait 'til Jared finished his series, too). Sorry, I should have mentioned 
it in the cover letter.

  Thomas


