Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1739CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 05:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v60WP-0007To-Ba; Tue, 07 Oct 2025 01:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v60WJ-0007TI-5W
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 01:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v60WG-0003IS-Gh
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 01:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759815950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w2QoKgdbwuitk5KUsU8yCY6K/P3PNhevGBXKaPuIKmk=;
 b=DGbh6FeoDUBEsoCUJM45Kzs8tdR0yiTon5NJ/FaLqO5J76baPbZfao9xfmk80yymmtuvt1
 9WhIyfigdgwu55olmBsFpAAuo3BFZnNiJpXvLuC4vplxuXYHRtiBLAukCdMls+sCrW5uCq
 hOkJz3tu7ye6V27nc0nfvnxh35WKF60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-issJeNj_OV2PD0IWITIs6w-1; Tue, 07 Oct 2025 01:45:49 -0400
X-MC-Unique: issJeNj_OV2PD0IWITIs6w-1
X-Mimecast-MFC-AGG-ID: issJeNj_OV2PD0IWITIs6w_1759815948
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3ef2dd66so28887835e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 22:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759815948; x=1760420748;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2QoKgdbwuitk5KUsU8yCY6K/P3PNhevGBXKaPuIKmk=;
 b=hNp6bfQAZMfkRnVkAxOBS/yVHVUqtr/RVMU2tFw0WLl3deYrByZ1/JvmyyvbtxH0lH
 TY34jAMnpR2v55slPuW169p3+3ze0DECEMNbpTqwKuFNCSh76/q5sxMHHMxgaJxUPZEq
 qrELNvJXgmDSh+bFjb6WGp3HbXxaxtxis1qmlDAkt9hdlMNZ5bD+dwE9RLIW97h0RUcz
 4rt+x2DUTWeHbabS0gYsBTLc91O5SI7K38F9pKQLoWM5L4I/UW+83Qmy47Njf56j8nz1
 5Wp1i6NR2ChwF6qjLNfaf9zcvc8mgRhmCGBPqbPSdLL5naW3Lfff66LlgbOe7p1GsYgL
 Q4Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDmFa5vBpvZOxrDOiNzBEbztKgpbgHVM/xNiY088RmzytujSe904gCg4wiEFcTpQyM+vqFcKj7W79O@nongnu.org
X-Gm-Message-State: AOJu0YzyLgtI/zciFqdKhlr8JMCyeAHCYxxCDvKf9gS2+5kZDrVUZR0F
 s4I8oc3EmccdNd/Hde0txksHhSoBitutSeAYSXGgT/x2a6k7pBpKsDBRGuks9WwdgMxEh8ACzll
 3qAHty38VLAh39BoTwni3wTfBZQ6lk9UsJqhu46BB4dMePUzrXopIw8An
X-Gm-Gg: ASbGncvuG4UvAg2KB3q3RaXDYGexWnOrTskG0I0BB5Vj6/R+aI7JgqVyRgichbA9JH7
 yzO58n4rtoKCuls1ZOD99WP5WPf+d4CNhVPKNwbseAjMaQQ/YMHFD25bovGwgpj3P2bYHLRTAw9
 qnojgyDewm1FQiejkL3hLsRkW4I/QP+67IX6xZpAZeP5q8Nf5u27QAkm+LkQ/U/ZIDbIMSBd39X
 S5ff6WPjWtxSP+MP5t9WW2SAxbe6RZAnUN4ndfbMguKURvWE/0TP1BoZydFryMhTJswsON5hyIl
 1ibLFjbYVh+Q1CHLDn9p40bQJgZa2lsZcFC5a6ROYeQiFkZHRyR3U/J6Qml+xhAz762SXMFgQ7h
 XZJo27dOs
X-Received: by 2002:a05:600c:8b4c:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-46fa29c94a8mr13489625e9.15.1759815948389; 
 Mon, 06 Oct 2025 22:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvkaEMUtlR9YJI8L5iYBbrY3rEIE/rRZ9X5KhxmU6TrLOhd+fafpfvLbneDXY7xOPK97I49Q==
X-Received: by 2002:a05:600c:8b4c:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-46fa29c94a8mr13489335e9.15.1759815947900; 
 Mon, 06 Oct 2025 22:45:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e970esm23815546f8f.35.2025.10.06.22.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 22:45:47 -0700 (PDT)
Message-ID: <c1db7b86-bdfa-40e6-8713-a0c5bfde81de@redhat.com>
Date: Tue, 7 Oct 2025 07:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, Ankit.Soni@amd.com,
 ethan.milon@eviden.com, boris.ostrovsky@oracle.com
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
 <8e48a225-6ea7-4aeb-8f8a-58955d113319@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8e48a225-6ea7-4aeb-8f8a-58955d113319@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

Hello,

On 10/6/25 20:44, Alejandro Jimenez wrote:
> Hi Cédric,
> 
> On 10/6/25 12:07 PM, Cédric Le Goater wrote:
>> Hello Alejandro,
>>
>> On 9/19/25 23:34, Alejandro Jimenez wrote:
> 
> [...]
> 
>>
>>
>> The current status of AMD-Vi Emulation in MAINTAINERS is Orphan.
>> Since this series is about to be merged, should AMD-Vi be considered
>> maintained now ?
> 
> It should be considered maintained.

Great :)
>> and if so by whom ?
>>
> 
> I volunteer as maintainer. Assuming no objections from the community, I will send a follow up patch updating MAINTAINERS.

Thanks. 
> If there are additional suggestions/volunteers for co-maintainers, please reply to this thread and I'll include them on the patch.
This series includes a co-author who would make an excellent reviewer !

C.



