Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13225C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtQz-0001JC-ML; Mon, 22 Jul 2024 09:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtQx-0001IW-PN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtQu-000695-WD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721656229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6LC2WP6jEv4eCf3PzKgn/SGsMfxUCl4qUtK8eoxfEI=;
 b=dW94GvaiuZfVWKlp6v+gmLwArQ+dhREkFvbLNkTsWCrUVyqeYGSl6oojTKCTgim8zAv+kC
 rbvXtVP9JV91LvpDFLnk7ijBikYhgWzt+zBtcOGHAP0MQrVSrnnxkZ8TZRJ29dq6Ag/ycH
 2q30/GcEkzFmUH/LFgY+lmwEWepPkvQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-VHkZJeMmPjC-5Thb7-_96Q-1; Mon, 22 Jul 2024 09:50:27 -0400
X-MC-Unique: VHkZJeMmPjC-5Thb7-_96Q-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-66890dbb7b8so113664617b3.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 06:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721656226; x=1722261026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6LC2WP6jEv4eCf3PzKgn/SGsMfxUCl4qUtK8eoxfEI=;
 b=eAuMp0eIKdIKZ5uzFs99SkUbqED19euQzIjOAfZcgirdKJZf70u3jYyJBZ0ZtiY1IV
 eTKIsbcwAsUaxYvV97SJTUQ3zIO/ncuQeiGWEYclAcWpNrZWYN9V7fKR0m+Qoo6plvSq
 8fAhxbAmFJGi5CU9fTx4DSgsbJvCzyvuzntKQ+i251R9uFsResDrCO2Up7sRCoZk2WzE
 PCKj5p48wz1Zsx9wA3j5xRqVPZi+1im35sp4eLcYPQ+iM9CDsbiquL7IJrLvuIfxIPuC
 P5h8yIDjouulnmsB7E0rOw9dBm+ywKO8MiPdSOTPkbqHCur2qXaPmTLm/DCbWkARiENV
 TE/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEZ6YYji8OjyXAZD8t4ZP5wECHWHR1LznuleV7VLsVl0ANMjfH2qmyTHBRkItcs7KKg77W7z0ZjQ0f0IZZXZJjBOMp1kQ=
X-Gm-Message-State: AOJu0YzS1TmoKszPjny4Q6Mt1e9bKa2CTeFX21vSKHJtEVhVkjsFoRTl
 +jt0wxQEOSZIHjXMcjxm6ek/aEzdkfSa5rtk3gTDKHs8d42lY8ZvyTiPEJcE39S54f+WVvlI/vI
 AGyBuaMMHg83TOTZ7ORhv03AmnvEd9I4M+AryXEsp+J16o0tvqGXftbpQ4iKP
X-Received: by 2002:a0d:d003:0:b0:66a:d93b:3047 with SMTP id
 00721157ae682-66ad93b311bmr75599017b3.25.1721656226629; 
 Mon, 22 Jul 2024 06:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl0QPAqlTeXfvCvERXkFt2nl2qHAL7U/kUAqwqdkevpFdi4oRtIR5umD4BOnbJzKMu82YGww==
X-Received: by 2002:a0d:d003:0:b0:66a:d93b:3047 with SMTP id
 00721157ae682-66ad93b311bmr75598837b3.25.1721656226354; 
 Mon, 22 Jul 2024 06:50:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19a49f268sm350205385a.87.2024.07.22.06.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:50:26 -0700 (PDT)
Message-ID: <6f568dca-65d2-4536-9946-596710ba3de4@redhat.com>
Date: Mon, 22 Jul 2024 15:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Don't initialize HOST_IOMMU_DEVICE with mdev
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/22/24 09:07, Zhenzhong Duan wrote:
> This fixes a potential issue with mdev that fails to initialize HOST_IOMMU_DEVICE.
> Reason is mdev isn't physical device and doesn't support IOMMU_GET_HW_INFO.
> 
> I thought ap/ccw are all mdev type and need a fix.
> 
> This series depends on a patch from Joao which fixes the same for vfio-pci.
> See https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg04612.html
> 
> Not tested due to no ap/ccw environment. But build test pass.
> 
> Thanks
> Zhenzhong
> 
> Zhenzhong Duan (2):
>    vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
>    vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
> 
>   hw/vfio/ap.c  | 3 +++
>   hw/vfio/ccw.c | 3 +++
>   2 files changed, 6 insertions(+)
> 


Applied to vfio-next.

Thanks,

C.



