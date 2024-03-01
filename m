Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6270BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5WU-00086A-UK; Fri, 01 Mar 2024 11:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rg5WM-00085Y-RZ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rg5WK-0001UC-CF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709309639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBP0TDDVdwAOEYm7nyivjARpTdtgcQHk6YZWbsGSFTQ=;
 b=SAh4IcvZ7d5xgPdIFXWAFYlVB5wjU2kdJCRuBNlqQ6LiltwzIYcwLBqc4SErA9FlCJjAE8
 I7STOQyx32IBUWegvOVkJ7k7JuaxnwMjcFYo3tlxS15DI1NbLG27S2dd6AamnrP1fgjLbl
 3tkzFtJGdGpOSq/4Osk4Rmy1ox9BpO8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Zk7aXo5vOt2cd080ghFNEg-1; Fri, 01 Mar 2024 11:13:47 -0500
X-MC-Unique: Zk7aXo5vOt2cd080ghFNEg-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-365b4dc6c3eso23481345ab.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 08:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709309627; x=1709914427;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QBP0TDDVdwAOEYm7nyivjARpTdtgcQHk6YZWbsGSFTQ=;
 b=uwNMtzeLA+OmbCRg4OAVpqS3/zTkSYxX+6worJfvJ5NC/tTolA0R8az6EO4bwvP6Ra
 F9LdLeUJUzhlKzLrEIkowDfDJB6qWOw4KHgAep8KstFsTKH0wjh/3MCWi4J101HE/9Oh
 Xy5qXuhJDIhY5nmYU/xpImife8CIpHqTVmt/lTRoYxn6oIh0RaPwReKiStK0dr7eZbs3
 hdeVSzeT3/jX2uLMHuCGRxvY2wmdt9LGTDsUpxNfnK1pIhOszFz1Q1vVZSml4Gi0tYA8
 z9jwcXhgigqWnLhDr+xvsjzD/5Zf747UcpyaAx1Bt/qBZ4StP04mqV47SYh2dlcKS/f9
 56Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSn+/3r5GcKjD9si1QHQBWYMNpsWxhe4lkfWmkdOOnD8YZhmrqKJBVbpTqpDBXRK8b9I175UHGh7DyeDgVH93144yfLx8=
X-Gm-Message-State: AOJu0Yyf5GjZzwBVCyPyWgfOV77z2GmJKQhv6ezoUA3o+fZRSzMbC203
 KDPv/Ws9VOjpQVKvOxYBR10KjjDYolfHu3C4bYxCl3NeeP6ybH8h6Vk4YvYUa+I+NNtMhQ2drbY
 GeSG60sQ7zvbzrutp/mLb1RqqbrpwfiumnvNGkBBKIvVzrCjXQC7E
X-Received: by 2002:a05:6e02:2181:b0:365:b570:cbbc with SMTP id
 j1-20020a056e02218100b00365b570cbbcmr2581668ila.10.1709309626869; 
 Fri, 01 Mar 2024 08:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9uX5/Md2fe9UZFpy1tgV7qrUeYBxp1s1gBUh7csdub2rgfB44HeLcjKPqOAa1QQnOLHr23A==
X-Received: by 2002:a05:6e02:2181:b0:365:b570:cbbc with SMTP id
 j1-20020a056e02218100b00365b570cbbcmr2581648ila.10.1709309626618; 
 Fri, 01 Mar 2024 08:13:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 p1-20020a92d681000000b003657c7530bcsm978325iln.16.2024.03.01.08.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 08:13:46 -0800 (PST)
Date: Fri, 1 Mar 2024 09:13:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Markus Armbruster
 <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang
 <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
Message-ID: <20240301091343.2e69359c.alex.williamson@redhat.com>
In-Reply-To: <SA1PR12MB71999E1863F1FD4C2505294DB05E2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>
 <8734td3uty.fsf@pond.sub.org> <20240228135504.00005d12@Huawei.com>
 <87bk80vaft.fsf@pond.sub.org>
 <SA1PR12MB7199F868F1C300B1E795CD39B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240229102230.00004277@Huawei.com>
 <SA1PR12MB71993D9D99F4756C17CAE9DBB05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240229163232.0000478d@Huawei.com>
 <SA1PR12MB71999E1863F1FD4C2505294DB05E2@SA1PR12MB7199.namprd12.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Fri, 1 Mar 2024 08:33:42 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >> As for your suggestion of using acpi-dev as the arg to take both
> >> pci-dev and acpi-dev.. Would that mean sending a pure pci device
> >> (not the corner case you mentioned) through the acpi-dev argument
> >> as well? Not sure if that would appropriate.  
> >
> > Ah, looking up my description is unclear. I meant two optional parameters
> > pci-dev or acpi-dev - which one was supplied would indicate the type
> > of handle to be used.  
> 
> Yes, that makes sense. But for now only have pci-dev until we have any
> acpi-dev related code added? IIRC, this is what we discussed earlier.

Yep, I think we acknowledged that this device supports either PCI or
ACPI devices and we only currently have a use case for PCI devices, so
that's what's implemented and what the interface expects.  A separate
ACPI device interface could be added later or derived from updating the
interface to accept a generic device object.  Thanks,

Alex


