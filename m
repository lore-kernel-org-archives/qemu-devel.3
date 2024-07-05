Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB4C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 14:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPjg9-0006k3-3f; Fri, 05 Jul 2024 10:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sPjg6-0006js-S0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 10:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sPjg5-0001i5-Aw
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 10:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720188763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkYR99WpRoCZJXm0Q0WKP2bp06IWsxIAsgzVIkFJsIE=;
 b=HJC99HquiVEEWPeKUqTGbAq8b53i2dvIuoIxK8pupk0LO2fNcV8ojGGx57qFWGAncaiIuh
 ubeMAQFCnEdaqPpnWryoSEMEjT2ATJoCGUt/DOKuZwq3O2caMzb/8hu/vhigqd0su2W2g4
 P1v4imxmFySnmyVIO4btDB4rRhyw9R0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-7wy5kYelM4K_J3ZdNhu3WQ-1; Fri, 05 Jul 2024 10:12:40 -0400
X-MC-Unique: 7wy5kYelM4K_J3ZdNhu3WQ-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7f652a0d89dso200616639f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 07:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720188760; x=1720793560;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkYR99WpRoCZJXm0Q0WKP2bp06IWsxIAsgzVIkFJsIE=;
 b=iDQt/KBW8vBdU9O4HNqHoOlt3ZG3adLwajlwZF0e4Y9iMF9L2F7x6DEFLwov3bpbvY
 siKBSC0qYMjmmTBRl0gsQPYYTztu6p0cCEm9gQyKXmM44N0FsvTTC/5A2W7A3sHmfEu8
 +cO/xt97DN2SEW9XEbNj5u9xr8g9OR/J6waE+WGn03BF21gaYp0YYVNTP23gDOhYHe32
 diwvkQ7p9FrvHjrdkpfcvN1XatB6mMreFJ6LcEHuikt7LPG1VEMve8668T7TM0/URq+H
 ZTEE21SG01XVtGPKry/zFu4vMTqQd61y5EZYhhVP7QQBhLrNGnGye7bo7LEESVCvW0ft
 TGgg==
X-Gm-Message-State: AOJu0Yx4gpUvqPMV4InMdLnu9kauQbW5Nfbh+k703ottULqyQiHInZp9
 6PVgMEMZmIbWqvtf7+KAxflSRepfKgDYwl9+NXp8Lt6nViyi6EN+zumqsakZ2QhIKNPynCfldZT
 sUTIjHZTEOVLJRtl8WR/N9o5tZfrV3FfGI1ta01JRa5aOMAcJGFYv
X-Received: by 2002:a05:6602:e19:b0:7f6:1f87:70c7 with SMTP id
 ca18e2360f4ac-7f66dea9ee5mr585711039f.11.1720188760013; 
 Fri, 05 Jul 2024 07:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Mue8LeOIqAdu2vXJpAmBIHwAJTi3x8QadjLTkCZtCRywtdG7lSgQXuTd9SpHdJymvyadhA==
X-Received: by 2002:a05:6602:e19:b0:7f6:1f87:70c7 with SMTP id
 ca18e2360f4ac-7f66dea9ee5mr585708339f.11.1720188759677; 
 Fri, 05 Jul 2024 07:12:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4bb73bba7c0sm4508128173.16.2024.07.05.07.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 07:12:39 -0700 (PDT)
Date: Fri, 5 Jul 2024 08:12:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org
Subject: Re: About VFIO Device Pass-through on Qemu.
Message-ID: <20240705081237.41208949.alex.williamson@redhat.com>
In-Reply-To: <17672e.9050.190822743a6.Coremail.13824125580@163.com>
References: <17672e.9050.190822743a6.Coremail.13824125580@163.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 5 Jul 2024 17:08:49 +0800 (CST)
tugouxp <13824125580@163.com> wrote:

> Hi folks:
> 
> 
>     I have a questions about device vfio pass-through usage snarios,
> PCI device pass-throug for example. did the GPA that host physical
> memory  mapped to Guest vcpu through MMU must be identical with the
> IOVA that host physical memory mapped to gust device thourgh iommu?

I'm having trouble parsing that wording, but without a vIOMMU the
device operates in the GPA address space, so IOVA == GPA.


> if so, that will be convenient for driver developer, because then can
> share data physical address between device and share memory. but is
> this true? is this the pass-through user manner?

If you're asking about a shared DMA memory buffer between devices, yes,
without a vIOMMU the buffer GPA (IOVA) would be the same between
devices.  Also note that device MMIO is mapped into the device address
space, so depending on the underlying host support for peer-to-peer DMA
there might be a working "direct" path between devices (where "direct"
means bounced through the IOMMU).

> my thought: it will be very convent for driver developer if GPA ==
> IOVA. because theuy are all "physical" on Guest, will offer a
> consistent view of memory resource for vCPU and vDevice, but is this
> true?
> 
> 
> VCPU:
>  GVA----(MMU)----GPA-------(+offset)----->HVA------>(MMU)----->HPA.
>  Device in Guest:                      
>   IOVA---->(IOMMU)---->HPA

Yes.  In fact this is the only way we can do transparent device
assignment without a paravirtualized DMA layer is to use the IOMMU to
map the device into the GPA address space.  Also the fixed IOVA/GPA to
HPA mapping in the IOMMU is what necessitates memory pinning.  Thanks,

Alex


