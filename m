Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E230CC54F32
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 09:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIlHf-0003lZ-Tz; Sat, 24 May 2025 05:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uIlHe-0003jx-86
 for qemu-devel@nongnu.org; Sat, 24 May 2025 05:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uIlHa-0004Le-2N
 for qemu-devel@nongnu.org; Sat, 24 May 2025 05:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748079306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJMf8mV/vrCseW7P7INA/2njK7m6Kj/xvi2LsolW5U4=;
 b=PVPUGbBNv2EDqU0OC/4w5QBxrC+h3k+zNH7YomKWUMG3jkEBTX2z1Iz4vT9YZewKFgowGm
 CZGlAYNkvZqcrfA0Zj7ZlPhKpUg5OLJ/KSRsww8rncjBjKr3YV+/+azFDehi/QVhz4cmxS
 l6QZSOiyiJ2XFIUC25jalsnw/81z+8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-tF9o_sDhMzKWgidTSe04Pg-1; Sat, 24 May 2025 05:35:05 -0400
X-MC-Unique: tF9o_sDhMzKWgidTSe04Pg-1
X-Mimecast-MFC-AGG-ID: tF9o_sDhMzKWgidTSe04Pg_1748079304
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so2922005e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 02:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748079304; x=1748684104;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJMf8mV/vrCseW7P7INA/2njK7m6Kj/xvi2LsolW5U4=;
 b=QbeEpneLhcyjSIdGxQjuHN+FEk78E4HnSIjUsk22g5+I/1JemZrOosFjGhNlmDxUPT
 msk1RdP5itIO8tIh3qFK9xaKwqUQmtREcKzcfGaHCEW++b8cZwq6jnQGZ8S0znO43LvL
 c8DjwiyD9yxGSQSaFdu2lRsj+VXo19LqWZmhzhnmIgSpSfuOFEkkHQBlFXQswsI4kcYf
 MuB1FQK/7XC/sInRbby4CJAGUpN1BWI3hL6OLCYh5gmaBzGMUC2IUHEkZkM9nn04Kv/c
 /1P/6H6Q1Fsfl4YVessq1R+mTXwOnsfS3kgdPbAOFWj2TgNbAEiJVIcNE9eho+ii06YZ
 krtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiiREAI+dOVtvqmNLdUNwvelzVpzD7DW27EvbaZAy5TsUF65VPKslFFSPn/oFvLtOxmghFfaeazMKc@nongnu.org
X-Gm-Message-State: AOJu0YzdrIyEepGYFwRed6vEeMAC7ckFCGSUY076t+LJd94iiYb0Nsin
 KEYlMaOdtx+TcjO/BhkUTHvSNkp0rrhc1QZBEFALtJKncUMSgOymI6LXlc3B3X0YNkcztR1jSR3
 cU9XlsC8aitZqzPogLYTMh4wxDTPsJHJQEe5fqb0vEDMtAXwwu6SWieb8
X-Gm-Gg: ASbGncuHd2NEDC4LVulS/OrjqHNGC2atooctiWoi048SviPrq94SfmHkSx0pqNBIaZT
 z3SCqriq4MzkTvAqYrEXTVPqcAf/e0xNLSOr3L1WkAopPC5I0D+D1aNSvCCDWcMn1VzZp4kNWuk
 j82LITVXbHrOaEm/UKdMkMGI+PkUW9jl2ob6XamY8HvkZBk7C6+Eq+N9Kf3d/+1YA7K4grECQb6
 Hb274njxEWa2bGbFqLdUU37z6Y3T6IWY2HwSo19jfgcZinUvNtVK6CJLwUUMtITyYFQS1lrna0k
 O7WGvQ==
X-Received: by 2002:a05:600c:34cb:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-44b51b67c5fmr61897795e9.4.1748079303848; 
 Sat, 24 May 2025 02:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHtHbHu3qAhIixGHHV4ucEjUvG2LmAyQl6Ej4ZBXiDkkODFCd0sQqnYjvdwwiT4+mUWRGkJg==
X-Received: by 2002:a05:600c:34cb:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-44b51b67c5fmr61897475e9.4.1748079303483; 
 Sat, 24 May 2025 02:35:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef035csm167912855e9.11.2025.05.24.02.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 02:35:02 -0700 (PDT)
Date: Sat, 24 May 2025 05:34:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 14/42] pci: skip reset during cpr
Message-ID: <20250524053413-mutt-send-email-mst@kernel.org>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
 <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 16, 2025 at 10:19:09AM +0200, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
> > Do not reset a vfio-pci device during CPR.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >   hw/pci/pci.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index fe38c4c..2ba2e0f 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -32,6 +32,8 @@
> >   #include "hw/pci/pci_host.h"
> >   #include "hw/qdev-properties.h"
> >   #include "hw/qdev-properties-system.h"
> > +#include "migration/cpr.h"
> > +#include "migration/misc.h"
> >   #include "migration/qemu-file-types.h"
> >   #include "migration/vmstate.h"
> >   #include "net/net.h"
> > @@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
> >   static void pci_do_device_reset(PCIDevice *dev)
> >   {
> > +    /*
> > +     * A PCI device that is resuming for cpr is already configured, so do
> > +     * not reset it here when we are called from qemu_system_reset prior to
> > +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
> > +     * safe to skip this reset for all PCI devices, because vmstate load will
> > +     * set all fields that would have been set here.
> > +     */
> > +    if (cpr_is_incoming()) {
> 
> Why can't we use cpr_is_incoming() in vfio instead of using an heuristic
> on saved fds?
> 
> Thanks,
> 
> C.

Think I agree.

> 
> 
> > +        return;
> > +    }
> > +
> >       pci_device_deassert_intx(dev);
> >       assert(dev->irq_state == 0);


