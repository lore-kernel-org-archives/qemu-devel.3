Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbpT-0005z0-1d; Thu, 13 Mar 2025 02:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsbpO-0005xK-Gz
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsbpM-0008OY-9J
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741846434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HyqbIgG1LZFidzjGtCm4GgFOA6RiM8RZ3pkt6y+EWqs=;
 b=FXbeBrTgew8p4jVg8FFY3nJ8n+Ymv3QMdJvMc/DplGYX4MHduScx1mcZM0LknQkgBunvLW
 g5diDRJQ6Tn9uvNkaOpdBF3eqIHYg1/AZwQbxKGsfCUGEjLK8uklBpYaZ/dnxN6ENE8Tlh
 4Y8+D4ZXvW21M02/KFKTQVxaSIfFAMU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-ZlLxa9kqMaen3IvgmmXRIA-1; Thu, 13 Mar 2025 02:13:51 -0400
X-MC-Unique: ZlLxa9kqMaen3IvgmmXRIA-1
X-Mimecast-MFC-AGG-ID: ZlLxa9kqMaen3IvgmmXRIA_1741846430
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso3731315e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741846430; x=1742451230;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HyqbIgG1LZFidzjGtCm4GgFOA6RiM8RZ3pkt6y+EWqs=;
 b=u5EXXHH8K9euLEcaDrSkCOZBXhVv2mGJ1M5VEn1op9o7EK+Yq3xHALdkg83Xufv/OF
 DxWExn91TV1lryBxyMObN2emUkXltKItX7JxfLoTjTHWv7uvyH+zpat1+oNSZXvc2bbM
 WcbnasEgRtWPL6iUVFVRsfeMhhSuSlDvpg6g9K6Q172VyYRRViZZGxSNtdEzkmecWVfx
 8uvt5qGK3Cu2ldhdek7gGQQpJfDmAN4UJvewdCTannbtipSU8lvLbSuMllIz2eb7TYR9
 kfBwJ5WzM8MDH+m/TpbKTHuDdGyVhe+1n2Gi0OCE8e0xI4MT8UZm+TEe7MZEKXKrHJnc
 oHjA==
X-Gm-Message-State: AOJu0Yy7ClGr+88a8I1CObhGwjA8KIify7PPm1I8wavuG+QC5S7rfJnB
 q2/giJhAQH62WGxoHSUGJuN2VEHuVl/h8HBU+S3VCV6Q+BlPdIMmCBLW9K0OZ8yLimIomY/qmCQ
 9tXOtibfoyHFTSnfLbjsCf4suQcvPriXGyNIup+gs+wk3PNaz4/HJ
X-Gm-Gg: ASbGnctGkHxU9p/d5/XUuI+mgnT7xdJWQRWiKgT79Lsh4lNBLV4C6p+FlFc3Ic3FSzx
 EiWOVuEIve5OY/py7ZX5IiXwEoN8qM2355cDVeVxcHqGyLMPVx7N8zvNSWXkpeWhclxFVeBeb9/
 3eOITsyr1gtQ2tRu+8weSV+AlSW/4WrbSTYsECGz7EJCWe9oA7W6RfGhdW/kfKwicd+FWFqFPgc
 VG85p3FyWvstOLagXKyIhhsu5oEGOSH+H0FQkgXKpZp/rVhOq7OXB+X4qZp15z+GOC/pjVMdqGv
 kvk7XdSY9lSSc/fOkIgt9ZRkAYlDKuDg6tDFu5uVHHdUQLQ=
X-Received: by 2002:a05:600c:3b0e:b0:43c:f575:e305 with SMTP id
 5b1f17b1804b1-43cf575eac0mr151878725e9.8.1741846430157; 
 Wed, 12 Mar 2025 23:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd2S7IYhgXGMY1iEEyzVy0aPwYW4ri/jc6As+mjUGy3EY/jIW3bc7qGBKGkt+kyrQWHHxBwQ==
X-Received: by 2002:a05:600c:3b0e:b0:43c:f575:e305 with SMTP id
 5b1f17b1804b1-43cf575eac0mr151878545e9.8.1741846429802; 
 Wed, 12 Mar 2025 23:13:49 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d14813085sm29214715e9.28.2025.03.12.23.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:13:49 -0700 (PDT)
Message-ID: <71d0b4bf-7732-44f2-8796-f19eb2822958@redhat.com>
Date: Thu, 13 Mar 2025 07:13:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/72] ppc-for-10.0-1 queue
To: Stefan Hajnoczi <stefanha@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250311125815.903177-1-npiggin@gmail.com>
 <CAJSP0QWLW+YwsLeJ1496Q8uT92E3wUDsOiVyzVFwrOFid3FUWA@mail.gmail.com>
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
In-Reply-To: <CAJSP0QWLW+YwsLeJ1496Q8uT92E3wUDsOiVyzVFwrOFid3FUWA@mail.gmail.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/03/2025 03.34, Stefan Hajnoczi wrote:
> On Tue, Mar 11, 2025 at 8:59 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:
>>
>>    Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-10.0-1-20250311
>>
>> for you to fetch changes up to 0f17ae24b53eaab4bbe9cfab267c536e2f7fdbd7:
>>
>>    docs/system/ppc/amigang.rst: Update for NVRAM emulation (2025-03-11 22:43:32 +1000)
>>
>> ----------------------------------------------------------------
>> * amigaone enhancements, NVRAM and kernel/initrd support
>> * Next round of XIVE group/crowd changes
>> * SPI updates for powernv
>> * Power10 2nd DAWR support for powernv and spapr
>> * powernv HOMER/OCC fixes and improvements for power management
>> * powernv PNOR support
>> * Big cleanup to move TCG code under ifdef or into its own file
>> * Update SLOF and skiboot ROMs
>> * Remove 405 boards and deprecate 405 CPU
>> * Add support for nested KVM "hostwide state" data.
> 
> I fixed a CI failure on FreeBSD 14 hosts because of the __packed macro
> redefinition in hw/ppc/pnv_occ.c:
> https://gitlab.com/qemu-project/qemu/-/jobs/9388495246#L5857
> 
> Here is my fix in the merge commit, if you prefer a different fix,
> please send a follow-up commit:
> diff --git i/hw/ppc/pnv_occ.c w/hw/ppc/pnv_occ.c
> index d9ce35a4d6..bda6b23ad3 100644
> --- i/hw/ppc/pnv_occ.c
> +++ w/hw/ppc/pnv_occ.c
> @@ -394,7 +394,9 @@ type_init(pnv_occ_register_types);
>   #define s64 int64_t
>   #define __be16 uint16_t
>   #define __be32 uint32_t
> +#ifndef __packed
>   #define __packed QEMU_PACKED
> +#endif /* !__packed */

We should never define such macros in userspace - everything with two 
underscores at the beginning is reserved for the system and the compiler and 
must not be created by the userspace code.
Why doesn't this code use QEMU_PACKED directly instead?

  Thomas


