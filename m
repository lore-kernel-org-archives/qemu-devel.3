Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D722C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5HZ-0005Bs-FA; Mon, 19 Feb 2024 10:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rc5HT-0005B5-G2
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rc5HS-0002yK-5g
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708355403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fn20nNl7dbY3edZzZCJCUFkQxAwvyHtOlqL+/63Jntg=;
 b=e30SmNsp+87SYyBx3krACY+kAtKD4thvpfqTrldICQwhNQ0SbbRQqLx2J6HzdFqKhRte9W
 5eqecUjvZS1JuW7/BDNSmdMfmodV4MXtsRsdH/n80y43o83rBR6cztD6ljLPxmfQMRgQeb
 rDngTzVhnCOrzm0yIznpOA4A2P0j594=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-n1R5euXmP4aJVxeY5IW31g-1; Mon, 19 Feb 2024 10:10:01 -0500
X-MC-Unique: n1R5euXmP4aJVxeY5IW31g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68f75058f07so9728126d6.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 07:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708355401; x=1708960201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fn20nNl7dbY3edZzZCJCUFkQxAwvyHtOlqL+/63Jntg=;
 b=qHATW7h4dkr6ndnO+mqzh0425ZLtpuffNfZNv5SC8q5etCtDBebFYm1ITMZd8hlC8f
 bhy6Xiy4Qp/QipQ8RxcjbFfO1X0CTny+r7uuKpJ+nPlui0PVsdqlO/4Ttmeje3klAXeb
 i91qkN6Y5f5vg3kzt4jC42l5duR6vmp0g2Kxa4ES6XiuxEgobFixhMkXhbS6/XeyoOPn
 loMgkN6VeT5YP/s/mBUj3juLlOabqkxPpCUi0yXXrvjaRvX0aE/Nirgssmejhs3cIcFN
 PVxjl+99LuErKrTtooDYlHMzfjRYz36eDnuMaaIlODxQOHYgixgn9yzlCAbMWFsTXwYU
 jvAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWALifKOiLbqxw7nQpB32K0U0DesilbA/a6pmU5owros40x01pV/vGlSp49BU/h0u8HbUfkXEkkl8HwcIbIXL94qRB/Q64=
X-Gm-Message-State: AOJu0Yzirw1hzEjH4UTKBIstqU0CyIw1hJQL0T6lXAuLY8vx1gEh5eLd
 OEaszDo7MMRfsNnOOALedROhbf8h92Ii9a0VZkdCbppYGWWBE+yaIL7+F3iihN6tt/3K78cBlbt
 uBp21P0STsGDRYsu0BVK5tYN9P2UDrU15vf6Lsr+4fQF8q1NQk6+f
X-Received: by 2002:a05:6214:cae:b0:68f:2d21:d634 with SMTP id
 s14-20020a0562140cae00b0068f2d21d634mr17764406qvs.24.1708355401448; 
 Mon, 19 Feb 2024 07:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYPsHIrGP06Nw+EH5VooQk0d2m1jZGh//8y4+2Rutcv/yZu9MNbWVOdef0JrJXQELCKGTM6g==
X-Received: by 2002:a05:6214:cae:b0:68f:2d21:d634 with SMTP id
 s14-20020a0562140cae00b0068f2d21d634mr17764382qvs.24.1708355401186; 
 Mon, 19 Feb 2024 07:10:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 of5-20020a056214434500b0068f62f175fdsm1573746qvb.6.2024.02.19.07.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 07:10:00 -0800 (PST)
Message-ID: <16008b98-8e74-44e4-b7d5-8c9b839007cf@redhat.com>
Date: Mon, 19 Feb 2024 16:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/49] hw/pci-host/raven.c: Mark raven_io_ops as
 implementing unaligned accesses
Content-Language: en-US, fr
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-23-npiggin@gmail.com>
 <754804d1-8bde-b23b-d136-e93d6d967987@eik.bme.hu>
 <b2820e70-9e58-4087-b072-5049dda7023a@kaod.org>
 <CAFEAcA93B8cJRhuqROufrrY37d-Rp=grp9mApiX=f1W65mKSag@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAFEAcA93B8cJRhuqROufrrY37d-Rp=grp9mApiX=f1W65mKSag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 2/19/24 15:55, Peter Maydell wrote:
> On Mon, 19 Feb 2024 at 14:53, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 2/19/24 15:49, BALATON Zoltan wrote:
>>> On Mon, 19 Feb 2024, Nicholas Piggin wrote:
>>>> From: Peter Maydell <peter.maydell@linaro.org>
>>>>
>>>> The raven_io_ops MemoryRegionOps is the only one in the source tree
>>>> which sets .valid.unaligned to indicate that it should support
>>>> unaligned accesses and which does not also set .impl.unaligned to
>>>> indicate that its read and write functions can do the unaligned
>>>> handling themselves.  This is a problem, because at the moment the
>>>> core memory system does not implement the support for handling
>>>> unaligned accesses by doing a series of aligned accesses and
>>>> combining them (system/memory.c:access_with_adjusted_size() has a
>>>> TODO comment noting this).
>>>>
>>>> Fortunately raven_io_read() and raven_io_write() will correctly deal
>>>> with the case of being passed an unaligned address, so we can fix the
>>>> missing unaligned access support by setting .impl.unaligned in the
>>>> MemoryRegionOps struct.
>>>>
>>>> Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Hm, this seems to be missing the actual patch.
>>
>> It's merged already and git knows how to handle this.
> 
> Mmm, though this is the result of "rebased onto a tree that
> already had the commit" rather than "two merges both contain
> the commit", so we end up with a genuinely empty commit upstream,
> which is a bit odd looking, though harmless.

git rebase -i db5f7f9e3ceb and dropping the first patch would
cleanup the empty patch.

C.



