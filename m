Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111F7EEB582
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sogYp-0003PB-3X; Thu, 12 Sep 2024 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sogYm-0003DY-9L
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sogYj-0006qy-QB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726134976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49HWheMy+Y9SY98csL0by7ES4cUPjs8VWRW0Xsu7XVM=;
 b=DBNmz8goqJHYWbUiFzrBDGDX0VhiOdYOMGH6cpZubvPV5DwB8XkycBes9XNMsnhRVvUsro
 DvjovREFxlinP0d/7/d8r86U69+PMGZXP29z9rjjKE1JRHET5La82E+oEShGovqiIwvqHS
 s0iBgwUeNdaDyw0sJm1knQQtU+NQpbk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-xFU-rNEnPkO_0byD5hXOCg-1; Thu, 12 Sep 2024 05:56:15 -0400
X-MC-Unique: xFU-rNEnPkO_0byD5hXOCg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso5401085e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 02:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726134973; x=1726739773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=49HWheMy+Y9SY98csL0by7ES4cUPjs8VWRW0Xsu7XVM=;
 b=Edw9EWA0YRjpOa4y0t3aI+/obs9bqIp1NDVFouJIh9ko24cQSM1GI7TQpfNIiGn8lM
 MJyDm7IT5pHy5HMdbzYz/o0Mi6bhUgH8KRJok/2aSw8zRGGGlBlRKSSxrqZRNUmddinc
 JYbINgWZH4/flCHsPMaNdWbbNVGXxbvPs/MoKHumGNvVnTUqBHsrtSC6GY+qUiRXyP+l
 x6csXy++7ECQn56Fhomdp/MMebQ6RsBU3OmfXslW6vAg8J6+gi1QQGyGFtExRMeI8NWG
 OFwa/3rur9IGh/szhastcazZk9eZGt/CFLgo4y2fMSC7dTbwUwKYYo+iiGmNzix6Ww7V
 nBQw==
X-Gm-Message-State: AOJu0YwXymWCxQ782jO7zAWV3o0pARdk/SLZfpbP2Euti1ryaexN7Am3
 hGVjA3/2IwYpl0IKtgr0XJozIjImCkP8jbVw4Okv+kew//+eadnzKh2GzyBSpQLleq+bgWYl68w
 4XzJ5M7FkkNqGhKGHiZtXuz2eEs0G5zcn3QrAHlepj80oBazxrmCXquyhQ/ei
X-Received: by 2002:a05:600c:3b15:b0:42c:bdb0:c625 with SMTP id
 5b1f17b1804b1-42cdb539d15mr18920145e9.14.1726134973251; 
 Thu, 12 Sep 2024 02:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdjRZdb+g2HtUNnMZ1CY8OiCZCnrWuNWribZO/53Svv9qk3u6aD4an1C2QPNwOQN9cmTK08g==
X-Received: by 2002:a05:600c:3b15:b0:42c:bdb0:c625 with SMTP id
 5b1f17b1804b1-42cdb539d15mr18919975e9.14.1726134972744; 
 Thu, 12 Sep 2024 02:56:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb5affb16sm142806205e9.37.2024.09.12.02.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 02:56:12 -0700 (PDT)
Message-ID: <92b61c0a-b770-4065-9a97-ba111fb092f6@redhat.com>
Date: Thu, 12 Sep 2024 11:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix null pointer deference from error API
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20240912051734.5298-1-jim.shu@sifive.com>
 <5fca8390-33c8-4139-8238-caef3e3f1dbe@redhat.com>
 <CALw707pkot65Zh_kpmKjZoQcm5f=VLLAFZwGbgR3D1qoDmiUGg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CALw707pkot65Zh_kpmKjZoQcm5f=VLLAFZwGbgR3D1qoDmiUGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Jim,

On 9/12/24 08:36, Jim Shu wrote:
> Hi Cédric,
> 
> Thank you very much for the quick response!
> 
> I have checked the error API again. It seems to be my porting issue of
> set_iommu_device() callback.

Are you adding support for a new IOMMU ?

> I think "pci_device_set_iommu_device(..., *errp)" should set 'errp' if
> this function returns false, right?

yes, this is a requirement for routines using an Error parameter.
You can take a look at the "= Rules =" section in include/qapi/error.h
for more info.

Thanks,

C.


