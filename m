Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10890C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUSIn-00042z-P0; Mon, 29 Jan 2024 09:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rUSIm-00042C-9P
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rUSIf-000088-Ri
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706537268;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxuBZdoXUAsXj1GUkHQPVx95bUOL83JGn+VbAMej3Jk=;
 b=KscLWs8O28cL7ic0C35P8sZhJHb4qjMYgILGWMnRs6ePYbTbgYTfEpJvKqIQvYTNMc/Ttb
 WMDpHClc6aveMMj5kz2auUdf6In7lJqeuhggxZSy+BEVBXkiMi59gjEce07qhV9iV9SuoX
 /3jcnt3u8GH5gwxrWa1gn1H98VENXr0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-gTFsleN8NAm3_M_aEILKSQ-1; Mon, 29 Jan 2024 09:07:47 -0500
X-MC-Unique: gTFsleN8NAm3_M_aEILKSQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-783fb71911bso202809885a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 06:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706537266; x=1707142066;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WxuBZdoXUAsXj1GUkHQPVx95bUOL83JGn+VbAMej3Jk=;
 b=gt6mSS02wnfaSgeD8yGT9CdKG2PdDbJLovRyiHssmosAnuO77S3oN8ZHpRZUyczPGH
 mBjSLx4UdYeuvXIiRWVLw7Uf2zbAy8KfTx2MgHGZgEwbv+dObkuW21DxZgLrafQGUWep
 8inQoCk4sOscAO4StPv1j15AbHjZyCoY9zcqrUGXf29lnk/rkrd7oHudrSmdyncB1++w
 nmQgXywStaYIeDXVUMpFnKYksY4ZKFEVrMyoYswKtjii4yWnlWkJCHfsRGLytYSl85YL
 4AbZFqPRMa6xbE5P+wdkzKJ2fwQljU+n215z/1/1+X6Zw5qz2X7Jj686cP+WjqZrKbTN
 ChKw==
X-Gm-Message-State: AOJu0YyPr3SKavDFkJu4TORSYt65/UabODeN5m9ExI+qsqA9A4WbtZC3
 3/XtFcfdbSomowH/HhNcaX66iz6jtvAvaj6wGkj/EcW+uznxRfG5ORT1XFfBanXfMgpQXfFdFHu
 HJiRP3ySuer048jVpCXQUnBP0Fs5x0f5lxMyk9gz6SQ9pRHB4Z5MW
X-Received: by 2002:a05:620a:1441:b0:783:ebb7:fa41 with SMTP id
 i1-20020a05620a144100b00783ebb7fa41mr4773716qkl.42.1706537266686; 
 Mon, 29 Jan 2024 06:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXz8HaM5od7Vb+Vu1bVM7qofS85ZW70hQbV+XJy89h5xCSlS49zDBj2tcQlQIa3jVyZtnxiQ==
X-Received: by 2002:a05:620a:1441:b0:783:ebb7:fa41 with SMTP id
 i1-20020a05620a144100b00783ebb7fa41mr4773698qkl.42.1706537266246; 
 Mon, 29 Jan 2024 06:07:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a29-20020a05620a439d00b0078400fab7a2sm633726qkp.111.2024.01.29.06.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 06:07:45 -0800 (PST)
Message-ID: <670991f9-e483-4acb-9ae9-6bad47b962b1@redhat.com>
Date: Mon, 29 Jan 2024 15:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240129122332.GA909471@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240129122332.GA909471@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Jean-Philippe,

On 1/29/24 13:23, Jean-Philippe Brucker wrote:
> Hi Eric,
>
> On Tue, Jan 23, 2024 at 07:15:54PM +0100, Eric Auger wrote:
>> In [1] and [2] we attempted to fix a case where a VFIO-PCI device
>> protected with a virtio-iommu is assigned to an x86 guest. On x86
>> the physical IOMMU may have an address width (gaw) of 39 or 48 bits
>> whereas the virtio-iommu exposes a 64b input address space by default.
>> Hence the guest may try to use the full 64b space and DMA MAP
>> failures may be encountered. To work around this issue we endeavoured
>> to pass usable host IOVA regions (excluding the out of range space) from
>> VFIO to the virtio-iommu device so that the virtio-iommu driver can
>> query those latter during the probe request and let the guest iommu
>> kernel subsystem carve them out.
>>
>> However if there are several devices in the same iommu group,
>> only the reserved regions of the first one are taken into
>> account by the iommu subsystem of the guest. This generally
>> works on baremetal because devices are not going to
>> expose different reserved regions. However in our case, this
>> may prevent from taking into account the host iommu geometry.
>>
>> So the simplest solution to this problem looks to introduce an
>> input address width option, aw-bits, which matches what is
>> done on the intel-iommu. By default, from now on it is set
>> to 39 bits with pc_q35 and 64b with arm virt.
> Doesn't Arm have the same problem?  The TTB0 page tables limit what can be
> mapped to 48-bit, or 52-bit when SMMU_IDR5.VAX==1 and granule is 64kB.
> A Linux host driver could configure smaller VA sizes:
> * SMMUv2 limits the VA to SMMU_IDR2.UBS (upstream bus size) which
>   can go as low as 32-bit (I'm assuming we don't care about 32-bit hosts).
Yes I think we can ignore that use case.
> * SMMUv3 currently limits the VA to CONFIG_ARM64_VA_BITS, which
>   could be as low as 36 bits (but realistically 39, since 36 depends on
>   16kB pages and CONFIG_EXPERT).
Further reading "3.4.1 Input address size and Virtual Address size" ooks
indeed SMMU_IDR5.VAX gives info on the physical SMMU actual
implementation max (which matches intel iommu gaw). I missed that. Now I
am confused about should we limit VAS to 39 to accomodate of the worst
case host SW configuration or shall we use 48 instead? If we set such a
low 39b value, won't it prevent some guests from properly working?
Thanks Eric
>
> But 64-bit definitely can't work for VFIO, and I suppose isn't useful for
> virtual devices, so maybe 39 is also a reasonable default on Arm.
>
> Thanks,
> Jean
>
>> This replaces the
>> previous default value of 64b. So we need to introduce a compat
>> for pc_q35 machines older than 9.0 to behave similarly.


