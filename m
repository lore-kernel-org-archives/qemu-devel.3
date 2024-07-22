Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7166C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpOC-0002HD-Bf; Mon, 22 Jul 2024 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sVpO7-0002GS-1J
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sVpO5-0001P5-8n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721640679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bwWNiVdOQoBQo4/ua4f4nr4uBOVaPb8imQlHiSeU/8=;
 b=fY0X0rnCZZwFcZfCHlNfrxEmZBY2vBFdIKKZSaBWRdg/iIsB4uiK9uaw67auwBHZi0D/Vp
 gDNlO1gJ84eq8CvdgN96+7qqA1nEUitCp4SEmpdFlYC5xZnPXCW+7zm//0X4LpjHAKypGa
 pLdoEunVzbZhkdHBn/+nosNWK5Exb14=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-fLuZogauNz29nzk-x8a2xQ-1; Mon, 22 Jul 2024 05:31:16 -0400
X-MC-Unique: fLuZogauNz29nzk-x8a2xQ-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-4928b926d38so752716137.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721640676; x=1722245476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bwWNiVdOQoBQo4/ua4f4nr4uBOVaPb8imQlHiSeU/8=;
 b=DzmzXgOxi993frIxOZ90jX+JUhfWphn2RhHSFxLzR2iBoJgSiE9aKaAqFuxdLOHfnX
 Rt1yj+WtXCuotDaWyWSguVN6XCHGr8Tzvk7ykG780TWDzhfkFfXhZI2vCgbprUabrWkK
 1hqcuKSaU+Bk6DVHbMBPQqds5B3dlyV1y8gzKldOgN/niPlqW1yXjAL0fJ0CYuT5tjr2
 viiBYadwX/MkydeIu0AbT1fw4Jjc5Bjf00KU+xde8i6e244xk9h5jKj+k4CtdRv8Pdh2
 hvgIA3f/HjifGq5W9+n5ttGJEjhSZ20Z/aPkd5MKVuzmRs6oF9y6DRLQsHNyHkld+0Ju
 MF7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcEId+EyGXCB36SBOS6O1H//OLC4rxn0iOVQwN7vJpQ56UYVZEzoV0rb13wkPnwiV6fy4zgLXA8DbftzZnm8sM+MlNkVE=
X-Gm-Message-State: AOJu0YwdmdaW+5ODIzhfLhIaAes4+nCdydmOZQSuTtqhlM5Q3EM5QaEp
 s43ibx6a9BYcgd6ZQ1G9NWOHTun/rSV3QgFJVnBeCZ2CwhvgyEYn+FgXK9Hq5PfiYWBCM8sg62y
 eQUJUTqauEHZfxqbe7aZixZQAM69oxcHHBBT8sq4H9m8bSmZhGNtw
X-Received: by 2002:a05:6102:2c0a:b0:492:aded:1914 with SMTP id
 ada2fe7eead31-492aded1d67mr674180137.10.1721640675881; 
 Mon, 22 Jul 2024 02:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcoFvUNNit/gjqcn4+sp8qPUjUcKOeQDGFp1WcH6mMvQbwBfTfWfYj04i0tp9pv2zAVxTusA==
X-Received: by 2002:a05:6102:2c0a:b0:492:aded:1914 with SMTP id
 ada2fe7eead31-492aded1d67mr674138137.10.1721640675500; 
 Mon, 22 Jul 2024 02:31:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19905a914sm341180085a.82.2024.07.22.02.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 02:31:15 -0700 (PDT)
Message-ID: <536dcece-a249-4fe6-977d-d970795dfbe2@redhat.com>
Date: Mon, 22 Jul 2024 11:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Don't initialize HOST_IOMMU_DEVICE with mdev
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 chao.p.peng@intel.com
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

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
>   vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
>   vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
For the series
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>
>  hw/vfio/ap.c  | 3 +++
>  hw/vfio/ccw.c | 3 +++
>  2 files changed, 6 insertions(+)
>


