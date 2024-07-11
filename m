Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB53C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvuo-00028X-92; Thu, 11 Jul 2024 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRvuk-00021j-V7
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRvuj-0006pB-CN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720712456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OsjfsTlsj/Ghe1NV6WpqPyLw4t3Xvvi5gxbEOGMofqU=;
 b=UO8EnvNjJLSvUQH7OG/Xmchud8pfoVm0OcnECZ+72CW009Y9NU6I+WRHxMWjxlX0jJhrhQ
 pbbFWcJyVVlkS1mc1ctZnRIZJ8vMNhr8nL4HrX2AHrCRaHvWxUZkMBZJe5NDaOPgKRSjf+
 jb9WJXXS6pvyhU7kdwE9FEy/ARBbElM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-yAcY--pIOjOHQjgllE6bPQ-1; Thu, 11 Jul 2024 11:40:54 -0400
X-MC-Unique: yAcY--pIOjOHQjgllE6bPQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42668796626so6575465e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720712453; x=1721317253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsjfsTlsj/Ghe1NV6WpqPyLw4t3Xvvi5gxbEOGMofqU=;
 b=rXtnlxSqtvE3EIf443KBylEZ6cq8u5dgxgkX9IATVHcfhSR2b08h900eoy+bRmSMAc
 45IOKiULk/v4uo9aQe1k8yXWje7dqE8oFHzEzygKlbF7FWx7X2rkcktS8cuU4ZiqX5xF
 xEXu2DbdDrfMufzD0P0f1qjfzURG+n1WRXbwAbA0BtlKCiyhe1F+lxpAoJTBA/NwDlpM
 pryM6I81wYYrAkfTLTr+sDYJOopyTQvGdVQSocs6mLnf4zT+TIksYTQ7PCcsWXngtIgK
 oc1xSqPSJVNqMCRgev6B1kfrtnudrDSxdNIyrIcKtUip2ykhog57fy7FbNONZ2fCppmH
 vaFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPOZSdpDWuaUmPml7nKxFBOUBiUY6Vc5iPqpX31PLxWQjXxjEaOZnRmXTyXSw5HIlDcyLkn+9buG7aSIv1/b3lg/lkUrE=
X-Gm-Message-State: AOJu0YxepWJo8hYHf9nAHtWYLNtuzoVusdF17A1P7MbvRwOtJxoDGfks
 J/0OZ8OJHL1EugZhR4TzBLLH/GNuOGZ9V2aT5GJqAkNEDyi6B4BOMWfrwUyd3YQHI/Z4V+yN/vZ
 s3LQ8FRItHzV1ozb7XBaZ8gM/Xi0ddf31RC9J3H7q50I84DAQGv3W
X-Received: by 2002:a05:600c:17c7:b0:426:654e:16d0 with SMTP id
 5b1f17b1804b1-4267018b105mr74065725e9.0.1720712453026; 
 Thu, 11 Jul 2024 08:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRjy+TOeaReztYTSjC/8SCGznQL2TkFSPfZoMqe2yvPzpSmQoBY88yy1Yd7PIYFZg0fPeDJQ==
X-Received: by 2002:a05:600c:17c7:b0:426:654e:16d0 with SMTP id
 5b1f17b1804b1-4267018b105mr74065465e9.0.1720712452473; 
 Thu, 11 Jul 2024 08:40:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42662315363sm201463505e9.26.2024.07.11.08.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 08:40:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:40:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 ankita@nvidia.com, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 linuxarm@huawei.com, Dave Jiang <dave.jiang@intel.com>,
 Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
 linux-cxl@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 06/13] acpi/pci: Move Generic Initiator object
 handling into acpi/pci.*
Message-ID: <20240711114034-mutt-send-email-mst@kernel.org>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
 <20240702131428.664859-7-Jonathan.Cameron@huawei.com>
 <20240711141240.0ec77fd2@imammedo.users.ipa.redhat.com>
 <20240711163851.00002f93@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711163851.00002f93@Huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 04:38:51PM +0100, Jonathan Cameron wrote:
> 
> > > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > > index 20b70dcd81..174b490e5f 100644
> > > --- a/hw/acpi/pci.c
> > > +++ b/hw/acpi/pci.c
> > > @@ -24,8 +24,12 @@
> > >   */
> > >  
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"  
> > 
> > > +#include "qapi/error.h"  
> > is this necessary? 
> > it seems to be compiling just fine without it.
> The error_fatal extern is in there.
> 
> I guess there is a non obvious path via which that's getting included
> anyway. is in there and it's not obvious how it is included I'd rather
> keep it as an explicit include to reduce fragility if the chain of
> includes involved gets changed.
> 

+1

> > 
> > > +#include "hw/boards.h"
> > >  #include "hw/acpi/aml-build.h"
> > >  #include "hw/acpi/pci.h"
> > > +#include "hw/pci/pci_device.h"
> > >  #include "hw/pci/pcie_host.h"
> > >  


