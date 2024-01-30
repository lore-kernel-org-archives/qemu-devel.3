Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ABCC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 18:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtJh-0007yf-PX; Tue, 30 Jan 2024 13:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rUtJg-0007yH-Jq
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rUtJe-0007Xb-Tc
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706641117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygwQTKzWVwq1rUJ+CoWQ7YcfRPlACm1P4aVkHLVn4j8=;
 b=MzX6NazEokrP90CiyLZa/keaixim67ekaXycSGbwnlKSBnTxXvBqyk3k3QSD+GQbOYA0EM
 K3Dt1ca1X+A/ZZkq+Lxss4yfXOjKGyA1+Us1KGZPSVL3JkTIyaH1dWjgqwkpnl70osSsHt
 Mmh2OkNYoTNmkHbyu/j3SGG6p79HaUE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-d9XiAhJmMIm-K76zjdbuBA-1; Tue, 30 Jan 2024 13:58:35 -0500
X-MC-Unique: d9XiAhJmMIm-K76zjdbuBA-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3610073a306so29145045ab.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 10:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641115; x=1707245915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygwQTKzWVwq1rUJ+CoWQ7YcfRPlACm1P4aVkHLVn4j8=;
 b=cfMeteKSHuVDbqA+kau6+BZ9phr8D5rzdzWcLNF6gvL9Yd8g9uxmhqfq6cVcrCAhuU
 aTx926ZBWYFlkqdz9ZGGQMdAO3jyyjGE4WqZCSMYU0d82xw4mpU7QonCC28FmNWsKCrq
 o6iKYyQH8MC9yEkmLmJgAe3Wv5mTHa6D9TQW2eb/nvMK9cmK7Ya0SxK5/iFGTFespfbs
 1QHI5VTB1rBzknvHNq+qnsApvYDxoYCoZsJQ9jrjA1VabBkEyUDGIBoUwdW4Lpg5rgZ8
 iJG65csdGUXeyvx2Kx+HVYkYsruOYhlcpalZAg6Y0RMrhIfRypT5buyHx7iAKQlEdrsp
 dAcw==
X-Gm-Message-State: AOJu0Yw+QsAYIMnf1iu6jp/v2YB2y4vXQsl9Y26Lb6XcwhGmMopGWjeg
 xrwjX9HYntMjmgwxFJKcTF3HHLNLrncZaylydamc26iqreUqLQy4tJfYVM2+zBqOEvLFw7mba4/
 +nV8QS3ZisetBEdQG44uYyUjiyXJtkiojlLFN5lu62wGZF0Nq66n3
X-Received: by 2002:a05:6e02:ec9:b0:363:91b8:ab7 with SMTP id
 i9-20020a056e020ec900b0036391b80ab7mr65747ilk.1.1706641114976; 
 Tue, 30 Jan 2024 10:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg9ipICFIU0/M1co1BTweQhhnYDIU1RCp6dV8Vu0s7WmeyzMx8u4lgPJkW95Ef/9dVGYLQJQ==
X-Received: by 2002:a05:6e02:ec9:b0:363:91b8:ab7 with SMTP id
 i9-20020a056e020ec900b0036391b80ab7mr65736ilk.1.1706641114744; 
 Tue, 30 Jan 2024 10:58:34 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 t3-20020a05663836c300b0046eb587003dsm2391340jau.127.2024.01.30.10.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 10:58:34 -0800 (PST)
Date: Tue, 30 Jan 2024 11:58:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>
Cc: qemu-devel@nongnu.org, targupta@nvidia.com, cjia@nvidia.com,
 acurrid@nvidia.com, zhiw@nvidia.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Message-ID: <20240130115832.462e76b7.alex.williamson@redhat.com>
In-Reply-To: <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
References: <20240130095617.31661-1-vkale@nvidia.com>
 <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 30 Jan 2024 23:32:26 +0530
Vinayak Kale <vkale@nvidia.com> wrote:

> Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.
> 
> Regards,
> Vinayak
> 
> On 30/01/24 3:26 pm, Vinayak Kale wrote:
> > In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
> > in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
> > 
> > config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
> > 
> > Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
> > If cmask[] is not set for an offset, then qemu skips config space check for that offset.
> > 
> > Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> > ---
> >   hw/pci/pci.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 76080af580..32429109df 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
> >       memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
> >       /* Make capability read-only by default */
> >       memset(pdev->wmask + offset, 0, size);
> > -    /* Check capability by default */
> > -    memset(pdev->cmask + offset, 0xFF, size);
> > +
> > +    if (cap_id != PCI_CAP_ID_VNDR) {
> > +        /* Check non-vendor specific capability by default */
> > +        memset(pdev->cmask + offset, 0xFF, size);
> > +    }
> >       return offset;
> >   }
> >     
> 

If there is a possibility that the data within the vendor specific cap
can be consumed by the driver or diagnostic tools, then it's part of
the device ABI and should be consistent across migration.  A mismatch
can certainly cause a migration failure, but why shouldn't it?

This might be arguably ok (with more details) for a specific device,
but I don't think it can be the default given the arbitrary data
vendors can expose here.  Also, if this one, why not also the vendor
specific extended capability?  Thanks,

Alex


