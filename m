Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD6CC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK1Sd-0001Jk-Rs; Tue, 27 May 2025 17:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uK1Sa-0001JO-ME
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uK1SX-0008TD-RI
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748379819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xRHJE8/BUSSFNtS5U9LsOCvsT4LkgBSmyoMrUCdNko=;
 b=SQVjZtTE36II2z2sl2w/D6QE4RpbucXZCxtcIPYVB475YV+ogysJ10us3gG1Yij7YEQQvw
 bpnnfMqv6uFGyMwj/+GbvtjEa6iHHN/f3rpAXLkzLhyQXkxwu1ojqB7n1SYhxtp308os6I
 V+ET6bFKmDuoZZ2JBYmTx2bPARe/YsE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-VYzfEdJTNamAicIcid4KVw-1; Tue, 27 May 2025 17:03:38 -0400
X-MC-Unique: VYzfEdJTNamAicIcid4KVw-1
X-Mimecast-MFC-AGG-ID: VYzfEdJTNamAicIcid4KVw_1748379817
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso1630938f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748379817; x=1748984617;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1xRHJE8/BUSSFNtS5U9LsOCvsT4LkgBSmyoMrUCdNko=;
 b=qqdGqYgRhZJxKocDoFMEXkPh9ZPwEswUaVbT6Ur6sJ0uNdETpebrxKRFF9U4qv7LgR
 mgyNAxf5tpBP6Dg802ngt86tWfcyFmHnvaXW57QmeSA6o4mJHEq96sZLh9CdQhzV66Ca
 3xqN9Ultqvgd6wOJlwguVNYhUR6lqG6lS59lPJEzCPJlPwhtSavUifyPhxGXfANZjW3s
 VUXHgmItTCeTpsgYcEQ1ojUTxpDfdqwQTE/sTeIXjZPQgFORbY0NakfNOsiJRBoVdJCn
 GieDBUQM54cWZ1M2n8JwUdgP6zzl8CJeNVJPrjuraVQPNU3nQDNeR7itepMq7E+nUM2d
 SNOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUue31kinNAvUm5n8p5RYjv4/3uWq7C2SrVMzuB+6K2STSq7/lvndKQ/aZvq8jpHEKy7EtroqY8a9i0@nongnu.org
X-Gm-Message-State: AOJu0YzZZEUM5itubSKh6huOxqKlY3/yf8riiNleJg8vr6VSF7mNtpiO
 +corFe/HmxvKuKJwgWyg+uWM7AO0AxHYzKwBdluqo4jN4o8OeRsQGoWTZAVYR/PO7VpaUdOHHDc
 9mG4CUWGLkBMy7Kh/HFbwWOxOTD8En3WK2TlJ68hn5FELjtNGj7uulbdz
X-Gm-Gg: ASbGncuww519FPm1yT+RYKwr4pHY2WUpUeJA7v2QNnZmZWXVngpTUoOViTTEx/a7n9G
 dRnk7tXM+IAELVuZN98saGFd+zmBzprjK7B0bmSwHOi3FtRCsj0mnbtwocYRydfzw5IFprCfiqB
 dQ8Qs4jCltvH/GQOaZrIqcSRPf/L1/RMoK21mGSRs+I88bKLHDgulh7gMKLN6FA/HtUE5KdxzIb
 KN3at3GSy2eTiQhU5O2Y5qzwA4I3+qmeAZkbsepGIgLHa9KG5s0IcTznSP/2JfT2iED4twRRDQq
 nGcIZw==
X-Received: by 2002:adf:a3c1:0:b0:3a3:6af1:cc88 with SMTP id
 ffacd0b85a97d-3a4cb49df92mr8811194f8f.46.1748379816920; 
 Tue, 27 May 2025 14:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqb6uaibZjiIG/0kEBdiT+UcU4pVyCAzDZy16bckG+CjjFkEdRcLv9vTohkotWQ1Kofzah9A==
X-Received: by 2002:adf:a3c1:0:b0:3a3:6af1:cc88 with SMTP id
 ffacd0b85a97d-3a4cb49df92mr8811156f8f.46.1748379816497; 
 Tue, 27 May 2025 14:03:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4e8b94817sm109632f8f.31.2025.05.27.14.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:03:35 -0700 (PDT)
Date: Tue, 27 May 2025 17:03:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 14/42] pci: skip reset during cpr
Message-ID: <20250527165128-mutt-send-email-mst@kernel.org>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
 <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
 <20250524053413-mutt-send-email-mst@kernel.org>
 <061a43b2-b96e-4d32-9e81-f5d50824fb12@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061a43b2-b96e-4d32-9e81-f5d50824fb12@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 27, 2025 at 04:42:16PM -0400, Steven Sistare wrote:
> 
> 
> On 5/24/2025 5:34 AM, Michael S. Tsirkin wrote:
> > On Fri, May 16, 2025 at 10:19:09AM +0200, Cédric Le Goater wrote:
> > > On 5/12/25 17:32, Steve Sistare wrote:
> > > > Do not reset a vfio-pci device during CPR.
> > > > 
> > > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > > ---
> > > >    hw/pci/pci.c | 13 +++++++++++++
> > > >    1 file changed, 13 insertions(+)
> > > > 
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index fe38c4c..2ba2e0f 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -32,6 +32,8 @@
> > > >    #include "hw/pci/pci_host.h"
> > > >    #include "hw/qdev-properties.h"
> > > >    #include "hw/qdev-properties-system.h"
> > > > +#include "migration/cpr.h"
> > > > +#include "migration/misc.h"
> > > >    #include "migration/qemu-file-types.h"
> > > >    #include "migration/vmstate.h"
> > > >    #include "net/net.h"
> > > > @@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
> > > >    static void pci_do_device_reset(PCIDevice *dev)
> > > >    {
> > > > +    /*
> > > > +     * A PCI device that is resuming for cpr is already configured, so do
> > > > +     * not reset it here when we are called from qemu_system_reset prior to
> > > > +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
> > > > +     * safe to skip this reset for all PCI devices, because vmstate load will
> > > > +     * set all fields that would have been set here.
> > > > +     */
> > > > +    if (cpr_is_incoming()) {
> > > 
> > > Why can't we use cpr_is_incoming() in vfio instead of using an heuristic
> > > on saved fds?
> > > 
> > > Thanks,
> > > 
> > > C.
> > 
> > Think I agree.
> 
> OK.  I will delete the "reused" variable everywhere, and use cpr_is_incoming.
> 
> Michael, since I already use cpr_is_incoming in this pci patch, can I have
> your RB or ack?
> 
> - Steve

My problem is not with cpr_is_incoming as such.

First this comment is a very low level thing to say in common pci code.
vfio will change and we will not remember to keep this up to date.


Second, do we really know vmload for all devices sets all fields as
opposed to assume that qemu_system_reset cleared them?  If not this
introduces an information leak.

It feels safer to just add a way for VFIO to opt out of
(all or part of) reset, instead.

> > 
> > > 
> > > 
> > > > +        return;
> > > > +    }
> > > > +
> > > >        pci_device_deassert_intx(dev);
> > > >        assert(dev->irq_state == 0);
> > 


