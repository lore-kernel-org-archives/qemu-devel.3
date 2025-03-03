Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF59C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9ek-00014a-JE; Mon, 03 Mar 2025 12:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp9eQ-00013n-ED
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp9eN-00050c-3W
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741023134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dHnuUMPawBaVwBPhf5THOQV46IVm61j7QRL8lSdTRqI=;
 b=Lgl/H59LZ1PcFz0RITdlImNvLC0zjrCRoEbPJWp+SgLXLvmDbd+SVPNOCWIoa8wDP3v+zk
 LBQe2O3ANYtcpbidb9rHJj95p/JbXobyDS9ZhMuRgFVZ54YZpWs+nOPpJOisOJer5w9r2c
 tmV5XqAB/qANk9K9sxPZ5qbNS4JlWa0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-xp0Ek7AnNFKBsPxJFCJiXA-1; Mon, 03 Mar 2025 12:32:13 -0500
X-MC-Unique: xp0Ek7AnNFKBsPxJFCJiXA-1
X-Mimecast-MFC-AGG-ID: xp0Ek7AnNFKBsPxJFCJiXA_1741023132
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bcb061704so113795e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741023132; x=1741627932;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHnuUMPawBaVwBPhf5THOQV46IVm61j7QRL8lSdTRqI=;
 b=fw2OezUenKUESA6Du0aMsFiKvHLKroPSlLsmDiBaEyzJgI16PGivk1g/6wa0jp8kvW
 VF+p6TbF4gqZ3ijMTGi+mEAu2a4jSVvs4r0MvumTYxsvqHLKx1tBHi5D6U78EMDrS1vn
 m/lDuP1LlILYmh9Jde4JpZoHyDDiQzNgaCsuBD73wALVTQM8Hq6IgzaAakN7Ccc0Rk/q
 SZIkHkOOQqKHfu5C2aptqQyASfVMNMJ4gg1OFP0ityNRu0xWmZZVT0gNUUNjjC74bedv
 IES0OnUzMRvUdPDZqTB3NcuQ3tF4VdlpjErFjaDVk3iD5qoMokh9E9FXscLk5Htjzbqy
 zBxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGTEzvC8oVero4JAGc5SKhgDgae2vAfPm7Pl3U/n5LpxRMn+bItJXZpO4bKCgG9943kFpN+3My5KxB@nongnu.org
X-Gm-Message-State: AOJu0YzWlDI4pDnO5bULo9s2wPz9rSxYVeLwqdCHmrMmxkkLOt5cVY1p
 2a7FqRczxQb/UNp5HUNKOlpGmEv+R0Brc4U0WuLiNu+yeE7uEVMetX7As1EsfjOek5Q3C417vII
 hPNdTuWiR3f/FWxl58djID8Tov/6TRlf29ZzudGktwUlUxMbZx6EF
X-Gm-Gg: ASbGncu/ZY1NI/v1Xqme+/iaZseuru6iaZxBNmket+NtkwnUzRv+ny7jALH3RrWUBv7
 EiT4s1AS3E8k0Xi780K1VOJzCfnHPA39vkz0f08pHiMik+IgOkzyjNpAdOBQRPibFAH0DZnZQpO
 JKTBQbbGnVSa98CO4t5IOJMat/4K5kpjQiR1qI5LxqfXqaPYQjIp4rPkZ0VKAML2jNI4DmK6YHP
 8EtPBLgeVzEw84sWlzRYRAn+DZzuX89fmNnWGTd7ITVlKwOc4O0QvI72dvq6t94uVCJnGWwgmrk
 bJk8qU/mojuLNb64FAZ1iZv7+nsAeGX+nKAM4g22j10jdSoDtbbcIw==
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43ba66fec18mr132354615e9.15.1741023131913; 
 Mon, 03 Mar 2025 09:32:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEAOwg+25wS66XWXK6BCALG82LKMprDKrME6vA71k/oIMoqIbz/ZPo7ppJV0ZAtHTSSccdxQ==
X-Received: by 2002:a05:600c:1548:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43ba66fec18mr132354385e9.15.1741023131598; 
 Mon, 03 Mar 2025 09:32:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27af83sm168188775e9.30.2025.03.03.09.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:32:10 -0800 (PST)
Message-ID: <a5220b2e-0833-4461-828f-4fe6109c15e6@redhat.com>
Date: Mon, 3 Mar 2025 18:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <CABgObfZ4-qKX5SCp+3fD2a54SVUZ3+fA--gq6=tf1idjQYVTrw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CABgObfZ4-qKX5SCp+3fD2a54SVUZ3+fA--gq6=tf1idjQYVTrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/3/25 17:50, Paolo Bonzini wrote:
> 
> 
> Il lun 3 mar 2025, 16:05 Cédric Le Goater <clg@redhat.com <mailto:clg@redhat.com>> ha scritto:
> 
>     On 3/3/25 15:46, Paolo Bonzini wrote:
>      > On 3/3/25 15:30, Philippe Mathieu-Daudé wrote:
>      >>>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the target not the host. Vfio-pci works with qemu-system-ppc
>      >>>
>      >>> I've seen people do this on x86_64 host
>      >>
>      >> Since this patch does:
>      >>
>      >>    LINUX && PCI && (...  X86_64 ...)
>      >>
>      >> these users won't see any change.
>      >
>      > This is wrong---clearly this patch was never tested on the 32-bit platforms where it was supposed to have an effect.
> 
>     euh it was.
> 
> 
> Uff—I should have said was *only* tested on the 32-bit platforms where it was supposed to have an effect! The problem is with the 64-bit hosts...
> 
>     With this patch, on 32-bit and 64-bit host systems :
> 
>         # build/qemu-system-i386 -device vfio-pci,?
>         # qemu-system-i386: -device vfio-pci,?: Device 'vfio-pci' not found
> 
>     Same for qemu-system-ppc and qemu-system-arm
> 
>     What I am doing wrong ?
> 
> 
> ... Where you were testing the wrong target. :) qemu-system-i386 should still support VFIO if compiled on a 64-bit host, according to the subject.

yep. I have a test case for it now ! on q35 and pc-i440fx machines.

Thanks,

C.


