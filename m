Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F72DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tv7-000178-Ji; Fri, 03 May 2024 10:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2tv3-00011K-Cx
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2tv1-0006uh-G5
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714746586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6YRglGSEvHtPQQxrBeb8HU2Ly7fxSw+r00txKDyHcw=;
 b=KG089KVsyoSUgl0Dapz/mHFSUDhiPEe1RPYQskiZN+HoEONnCkpEcqUHDdBMe0yM328Jt2
 DyLMWqW86eW6haaizNLo91aRam+VTBStiooKsFek1t4E5c0IAV42pZRnu2kercs1BcIXtH
 NC7M4IHZIWwsx+uHJlWNh+a5b/VliuM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-ECGLAmxBMb-7uGhmkDBUJA-1; Fri, 03 May 2024 10:29:45 -0400
X-MC-Unique: ECGLAmxBMb-7uGhmkDBUJA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-78ed22211c4so1219222485a.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714746584; x=1715351384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6YRglGSEvHtPQQxrBeb8HU2Ly7fxSw+r00txKDyHcw=;
 b=FmD1KiG3qReoUz+NWNyFBE2kAPW66gFaouj2ZbmwyQu3ZDBZOsYCO5IRY/D66eOF2e
 YlRqo4yrAZcr3dSLycXWCD8HmlVXmMDD8Wq4k8fltdMPLv3euip20N0wKaI7noz3N5Nu
 /ecXX44SL0oaNAvPzd+TVhFyZ5BbVEuVOjBTgbOw+DdeyUFwk3B33xc/XHlzT6KELRMY
 xhwTVXTbCNGBTrP1tw2eP6xT8DK/BmpQXptq5RmcziS9xT+HUMKJtbe2SGeIeD/No/QZ
 EGFSTTx7eUPH6aNI1TAIrUHkd9txL+Fuy/3NrjF+ZxOLmG2Uag81RIElE0uj8GgQZDGE
 RHpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIg0tmDujXh9Psnj/V9Jy5lQ+7qDAZXP9FeElpORx6ao9gPc3PEdqSup9y16DZFfonEmYljBULKnrt9x8qPiPijqpVY9I=
X-Gm-Message-State: AOJu0YzYrvvv8EYixMqet0SpwRNnjNXGWmkHyN6etrkIK97eHjXI8nfY
 m33ZiFmFR5zkZGnfnSvgsh7sc8vTCB9wuxW8e8S4ebTyZKM9jN4GPIxtLQRwf+fLevbNmEjaelt
 hZQK9m9/qugadDIHo3vLOY4g+Pw8sWSgvi+oBkOEinw+5EpC1ki+iOdbhOIf7
X-Received: by 2002:a05:6214:21a7:b0:6a0:5592:4a44 with SMTP id
 t7-20020a05621421a700b006a055924a44mr2883497qvc.34.1714746584127; 
 Fri, 03 May 2024 07:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEonXxs5x9Wu56OKlv+qAw08iUXKQvycSX4v9w7PF0ORhtnIRJZv/PIgS+bwk31bnSxunHIwg==
X-Received: by 2002:a05:6214:21a7:b0:6a0:5592:4a44 with SMTP id
 t7-20020a05621421a700b006a055924a44mr2883476qvc.34.1714746583829; 
 Fri, 03 May 2024 07:29:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a056214108600b006a0e529642csm1258747qvr.80.2024.05.03.07.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 07:29:43 -0700 (PDT)
Message-ID: <8ae366d9-57c0-42d3-9362-05cf850f9cf2@redhat.com>
Date: Fri, 3 May 2024 16:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
 <20240503141024.GE3341011@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240503141024.GE3341011@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/3/24 16:10, Jason Gunthorpe wrote:
> On Fri, May 03, 2024 at 04:04:25PM +0200, Cédric Le Goater wrote:
>> However, have you considered another/complementary approach which
>> would be to create an host IOMMU (iommufd) backend object and a vIOMMU
>> device object together for each vfio-pci device being plugged in the
>> machine ?
>>
>> Something like,
>>      -device pcie-root-port,port=23,chassis=8,id=pci.8,bus=pcie.0 \
>>      -object iommufd,id=iommufd1 \
>>      -device intel-iommu,intremap=on,device-iotlb=on,caching-mode=on,iommufd=iommufd1 \
>>      -device vfio-pci,host=0000:08:10.0,bus=pci.1,iommufd=iommufd0
> 
> ? The main point of this is to have a single iommufd FD open in
> qemu. Not multiple.

oups. The above example should have the same IOMMUFD object device
instance: iommufd0.

This is bogus copy-paste of a command line with multiple vfio-pci
devices, each using its own IOMMUFD object device instance. That's
where the idea comes from. Sorry for the noise.

C.


