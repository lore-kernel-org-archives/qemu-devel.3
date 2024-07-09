Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C730FC3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREIx-0002kS-4b; Tue, 09 Jul 2024 13:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sREIv-0002jV-Km
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sREIs-0008Rt-Ov
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720544817;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAZGjImkX2HQuFPZOVYzNYKh/FgsBpv4IZdaz1kVazk=;
 b=VaNZDcKh9GPvDcoFv174Ufwi9T2Os6cg6QWmojZkFvX87ZC2wGc/R0PK/ugw3y2+0wJek0
 J/A8+PpCyzDeXVmMx3NyBVXfEFmj3mzT0B62HL6SL+2/qH7rXLoUtQjWYh0BkvjSlaNZI7
 SU7yBHRzNBf2nQ4wDfEsltLNW+E5cvs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-df4LIRmKOVeHOUeJru8WlA-1; Tue, 09 Jul 2024 13:06:54 -0400
X-MC-Unique: df4LIRmKOVeHOUeJru8WlA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ea3c7dfdcso5618281e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 10:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720544813; x=1721149613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAZGjImkX2HQuFPZOVYzNYKh/FgsBpv4IZdaz1kVazk=;
 b=OR2zLtfvO33W8zfpTBT603QmlUz+jTm2uPWx2PqedwaT+YnSqDST7QnpG/XcLEOxW0
 +q6O8deanTM3UC8rftQPmHfChN5j6u6Gt9Y0M8up3KZ0VwmeUcYCNOeEZbDn4UnVSb28
 z08bdX5rcuVsuRUxWpaBUIamPbxZb5Fd9YebYIZoUoXi+HvwXcPtma456qZ6NIws9fcy
 heVQ+qr3+OCgVx8FflmTNsF80jKKCIbh3KCnIzcBNj+dVVYXbp1KvkOEcQJMJ2+sYpdE
 ivbZVbOJE6CPGZDYXpxqH7gapNrwE7sBrS+qUPAvBOdyqhUSKnIiTzxYQJM2ZHJPCX4A
 BRQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZeC52e3SLfZwCwQRXrhuwPQCf3lcAd70nR5Rx8jpMqUzBlcObrWzj2L1jM+pciTwMcU5P53DYvA/7WeWKOwzHaGtuZI=
X-Gm-Message-State: AOJu0Yx9UiI/6VdZ3NWfZje7siiQXTacU5009q0Zgv/uMLKNRKR9lqYC
 b1c55yWzORXytHcXqwtygpv1SiBovRYNEWa0A+SOUYLmBiaOqhVOeJdM5+M2fgOKcRJqNAq9no1
 O/bs4jt06hbO0F35Tym0n2IIaOrDFVaJiiQJDD84op5PSMcusbwct
X-Received: by 2002:a19:9105:0:b0:52c:d617:f4da with SMTP id
 2adb3069b0e04-52eb99a3100mr1716673e87.41.1720544813388; 
 Tue, 09 Jul 2024 10:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvNP73KKWowZO8JxmMRacGdJYLr0LziiOGAdqqdMtggp/OvWXghYnLi5YSEhFj8k1A07R6+Q==
X-Received: by 2002:a19:9105:0:b0:52c:d617:f4da with SMTP id
 2adb3069b0e04-52eb99a3100mr1716653e87.41.1720544812983; 
 Tue, 09 Jul 2024 10:06:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f7361b5sm48602915e9.29.2024.07.09.10.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 10:06:52 -0700 (PDT)
Message-ID: <af440fe7-faf7-43a4-9f04-9d0059ef7e90@redhat.com>
Date: Tue, 9 Jul 2024 19:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peterx@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
 <efec2974-ce96-4cb1-a00c-30fe93c5fa7b@redhat.com>
 <Zo1sblmS9+xlWObT@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zo1sblmS9+xlWObT@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/9/24 18:59, Nicolin Chen wrote:
> Hi Eric,
>
> Thanks for the comments!
>
> On Tue, Jul 09, 2024 at 11:11:56AM +0200, Eric Auger wrote:
>> On 6/26/24 02:28, Nicolin Chen wrote:
>>> A nested SMMU must use iommufd ioctls to communicate with the host-level
>>> SMMU instance for 2-stage translation support. Add an iommufd link to the
>>> ARM virt-machine, allowing QEMU command to pass in an iommufd object.
>> If I am not wrong vfio devices are allowed to use different iommufd's
>> (although there is no real benefice). So this command line wouldn't
>> match with that option.
> I think Jason's remarks highlighted that FD should be one per VM:
> https://lore.kernel.org/qemu-devel/20240503141024.GE3341011@nvidia.com/
OK I thought this was still envisionned althought not really meaningful.
By the way, please add Yi and Zhenzhong in cc since thre problematics
are connected I think.
>
>> Also while reading the commit msg it is not clear with the iommufd is
>> needed in the machine whereas the vfio iommufd BE generally calls those
>> ioctls.
> I think I forgot to revisit it. Both intel_iommu and smmu-common
> used to call iommufd_backend_connect() for counting, so there was
> a need to pass in the same iommufd handler to the viommu driver.
> For SMMU, since it is created in the virt code, we had to pass in
> with this patch.
>
> That being said, it looks like intel_iommu had removed that. So,
> likely we don't need an extra user counting for SMMU too.
OK at least it deserves some explanation about the "why"

Thanks

Eric
>
> Thank you
> Nicolin
>


