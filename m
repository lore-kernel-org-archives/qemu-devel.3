Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7BDC48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrSW-0000WU-Pb; Tue, 13 Feb 2024 07:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZrSP-0000V9-PJ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZrSM-0000TG-Lp
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707825609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=50E8y+xfA7HBXn40KtIavaY7lMTLKisuAD0rDa6/Gt8=;
 b=Hfxwr3PwenDrKTDr3yaUs0FbGglBZQdMDJl4TX0oYhr5ubTIE/D8MojOA1u4XX9wacDLvk
 HfPElu3pbZzX8+bz8RvNi33lQwxfL1ACoFtXfJYZIVQy2QyQKyqmflBNpGOEpmZ58t8rpw
 wvU4CyByS8+chzJLzzXTErdxopo+YOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-SrjODOpcNYWD3xvIFbyVKA-1; Tue, 13 Feb 2024 07:00:07 -0500
X-MC-Unique: SrjODOpcNYWD3xvIFbyVKA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4102b934ba0so24694095e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825606; x=1708430406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50E8y+xfA7HBXn40KtIavaY7lMTLKisuAD0rDa6/Gt8=;
 b=Fl+u5IVcbDkHkQ0RajsDROmeA4vJwaf8bpB2ohAcRmF7ohowGoEflaJPlENezOZgLs
 V0n8nj/odMUQhXQnrjDSBylAOyRAjp0ac3+hGU+INQXfXRaxuW4HTRK7maYhnqDVD1M+
 Ft37xn++NDKVmmFbTH3IETg4FPqyt/va6U8b7s+N0sgxo0EPhRAdsUfFUvcpmudoZr7R
 8jYa62K+OSrBhv0zhJ6VOmoIDGyolWfneFASD1j8ee4UwWqEB0MgQbZduRCIEH/Qn54S
 BUPPQsoN9Gsoo98uResePgRkgal+CHzoi3EUwj+K3Qr/yPu0DfM3qT3RowyRhoku51dy
 eSXw==
X-Gm-Message-State: AOJu0YzaI0D4a+3JfJTKh6FbH2RXWdmFKIyHyiX1RW9WOCLlT1ujcAmr
 PjKEw1Xd+MQaArL46Wwy7GVZ+KBrEly4TbP+n4isX49gsOqt/MgI7Ay2eMr2U7IksYB6zJo1OOz
 Y29n05trpLcB9QqP0QrUG/c5jL4VSel0qhOHhy6ge+a85Fo2uDrAO
X-Received: by 2002:a05:600c:5247:b0:410:8db2:d5ec with SMTP id
 fc7-20020a05600c524700b004108db2d5ecmr7468560wmb.38.1707825606832; 
 Tue, 13 Feb 2024 04:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHbxNFl6yUskuFEk2oIjjBwlJPl5gc4P9jUQZCpQFn+e/qCoegyFmK9UhorBHa8JfmLzNZyg==
X-Received: by 2002:a05:600c:5247:b0:410:8db2:d5ec with SMTP id
 fc7-20020a05600c524700b004108db2d5ecmr7468534wmb.38.1707825606492; 
 Tue, 13 Feb 2024 04:00:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUrxIgBOmS0wv7Cw55XWTtGjEL/W8neFOoe5UmvddeH7xjHYdhEumb8MOd52wG0kpomVXYtbIamcIv0/DuOmXvVpPDLciqxh4f3rXx7dJxFksh4hiYBX5/GLBN88/VQJ7lxqLmjV1s3TmBYRIrkDGPs1eZKZEMJhGih/kT0zBAB/AaNvmU9/N/NuOU0aYwF5cef/0VhTL294/WAwh9NzjtLKffHjXOcVQkI0IXzYrfFRIeIT9ytqCccSesM/h4xamiP3H7kNZ4kYlNt6yZf
Received: from redhat.com ([2a02:14f:17d:5d88:37b3:ce51:18b:36d9])
 by smtp.gmail.com with ESMTPSA id
 dv5-20020a0560000d8500b0033b483d1abcsm9390789wrb.53.2024.02.13.04.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 04:00:06 -0800 (PST)
Date: Tue, 13 Feb 2024 07:00:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com,
 clg@redhat.com, peter.maydell@linaro.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240213064017-mutt-send-email-mst@kernel.org>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060731-mutt-send-email-mst@kernel.org>
 <417ea71e-fb45-4e1d-b8e5-9d54d93dba3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417ea71e-fb45-4e1d-b8e5-9d54d93dba3b@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 13, 2024 at 12:24:22PM +0100, Eric Auger wrote:
> Hi Michael,
> On 2/13/24 12:09, Michael S. Tsirkin wrote:
> > On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
> >> Do you have an other concern?
> > I also worry a bit about migrating between hosts with different
> > page sizes. Not with kvm I am guessing but with tcg it does work I think?
> I have never tried but is it a valid use case? Adding Peter in CC.
> > Is this just for vfio and vdpa? Can we limit this to these setups
> > maybe?
> I am afraid we know the actual use case too later. If the VFIO device is
> hotplugged we have started working with 4kB granule.
> 
> The other way is to introduce a min_granule option as done for aw-bits.
> But it is heavier.
> 
> Thanks
> 
> Eric
> >

Let's say, if you are changing the default then we definitely want
a way to get the cmpatible behaviour for tcg.
So the compat machinery should be user-accessible too and documented.

-- 
MST


