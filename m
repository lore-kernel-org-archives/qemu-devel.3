Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B214F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutiX-00040D-BU; Tue, 24 Feb 2026 09:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vutiT-0003ze-GL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vutiR-0003bC-0H
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771944524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MiA5oyHd1u/HuNQ8wL+OiT/Yk9qvmvN4zzyL140ue68=;
 b=Oqnw5j4rlJoPd6QsT8Kvo/Y7x3Mq7VoKkchmPtp0QIUQaNKx5tBAKbaeo13hyFKT6Np1ZN
 HM4uR6pg3OLNmPtzH4vvhiOJrlSxKbKgD4+7ke6V2pdiAHQGG+qbkaFGpNROPQ7vPHEG5e
 NZvIx3v1LS4Cu2HceQYE1vCeDmJ9QQk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-yj06zpLHPvW_oTW2TRSOYw-1; Tue, 24 Feb 2026 09:48:41 -0500
X-MC-Unique: yj06zpLHPvW_oTW2TRSOYw-1
X-Mimecast-MFC-AGG-ID: yj06zpLHPvW_oTW2TRSOYw_1771944520
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso42366815e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771944520; x=1772549320; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MiA5oyHd1u/HuNQ8wL+OiT/Yk9qvmvN4zzyL140ue68=;
 b=ofGXmjGAOG0jlO9sPQC/sCzP+EPs5qXfbdnfRIW66cv6g/67Uuzsr3HN0MmmAyBUuM
 nyBazRqbIDaMhEij89oJmLfOtkOFagm4BT8SfVl3X7BXpHgFKkgTbjYy5bRxe4A3fRD1
 V86gSH46+tIAaEuEd+PbVfcOEKzKCpiCog8zKK3cdsFVzOOjLv7iDecUZmLkZSawb5/K
 5PhFDRnRzb1sHkxDx5Hs2ysx3ZpnZlai2ssBDnx9THHwGaisU+a0/XHfjP98bP8xeIvt
 wQiZgTGhwioW7TvkkRirbob9IMXqih7RhlRXC1XEdPioHbmmDB5n/OaPZwJnoNZ+hpgw
 A4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944520; x=1772549320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiA5oyHd1u/HuNQ8wL+OiT/Yk9qvmvN4zzyL140ue68=;
 b=YjFREZpNZtp96i2fncDWXnBikTzfDkN+Iq0diLRpcecdL2LkBpZI/3IdvRl1y9miuF
 GG8hcMQ9V6oubtexXTiVO2UyjSE6mPvaYu/4kjpSQ1VIel+wbegi//Xs3G7bjH4PLUiA
 +6GMuEZ1dYH12wzF7eLzTZFThQaQvxgFQZTCDDRzKj/dVbd4MmkZDkb8aofnZCswQlzS
 +jCp3rpC3hbG9v/sPvceeNu3Zea4MiFZnlMgC2d1g2gZFT/XJdZsTwoz5nEoz9GtTFiH
 Atzwf9N1rmrwFbWrKs13xm1FH7C5lGWvB1nUAYSI0e4A2UJW2OkuH5jfmIQXQ3Sj+MhN
 jKlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmFFrcu2NR4luDuPCgKWSjvg/uPgZGQbK25v4BQ+2/CfQ3Jk3QYtd+uGuvoGmLJVui68AsnmWZhXb@nongnu.org
X-Gm-Message-State: AOJu0Ywme4TiOcBlKiS8+neb31R56qwWJ5JkxOSWM72RHqA6KuEN9m0T
 XXdoc0Xu5Bg4R1S8KsEJBqxgUau5IDqCoyWc3fM4uX7jIKlsysE0XQw/NdaDYbfYYlq40QUlXnC
 uVGyzYj0VJ/yStCPhpUfA6IKyeQTyommztuNfC/9MacQ7ZjkiUHlG+GYO
X-Gm-Gg: AZuq6aIdvIbACOB87D+LOuaRkNpTQ5K1jSZjzRuqKXdJdhL7FLCwdnew7XJhyjcp1g2
 qUVlSHRnPq3wTebWICRdCVzfKMxrlzhRtD4Xpf5tdW+Y+PrR07dThjMzThkbX6JWDa70CHYJJSN
 APWc/quT+F12/rTYsmnRzady2fDEfQKruxEP2rZ9g1QgZZPoryRfMT/sJAMEXgRSr2QCga+wMJ/
 FKGNcfR358xQSYdzqezTEaFSq4jQdFCmsbpSUonIUr0VLKrDT4ZholBmQgNFK19DQjA/CZSnySt
 54GxgN1yWR62EKxUBZZeQSmevFH05XTJt+Q70f2wbqcxp/CWOxXVufVue242w6fISYGGIPca357
 rXDt96F0jn1qsJGGXkNAhFZCZ97/R8He6Lo2HpsptTfrcUg==
X-Received: by 2002:a05:600c:3148:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-483a96379e7mr206833645e9.25.1771944519966; 
 Tue, 24 Feb 2026 06:48:39 -0800 (PST)
X-Received: by 2002:a05:600c:3148:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-483a96379e7mr206832945e9.25.1771944519403; 
 Tue, 24 Feb 2026 06:48:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f2f88sm4194375e9.2.2026.02.24.06.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:48:38 -0800 (PST)
Date: Tue, 24 Feb 2026 09:48:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260224094553-mutt-send-email-mst@kernel.org>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ2449e8ucB8e3AJ@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 24, 2026 at 10:42:43AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 24, 2026 at 09:01:30AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Feb 24, 2026 at 09:51:06AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Feb 23, 2026 at 11:13:02AM +0000, Jonathan Cameron wrote:
> > > 
> > > > Ankit, can you give an example complete with table dumps please.
> > > > 
> > > > I'm a little unsure on where things are getting scrambled.
> > > > Everything should be keyed of PXM.  Sounds like we have a bug
> > > > somewhere but ordering shouldn't be relevant.
> > > 
> > > I understood the issue is Linux assigns the uAPI visible NUMA node
> > > numbers based on the ordering. The proximity/etc internal to the
> > > kernel (I thought) was OK?
> > > 
> > > Then the problem is that uAPI has developed meaning based on what the
> > > bare metal HW does and now there are SW stacks that are expecting
> > > these platforms to have certain NUMA IDs in the Linux uAPI. Sure you
> > > can argue this is bad/etc/etc but the point of QEMU is to allow
> > > creating VMs that closely match real HW and in this instance real HW
> > > produces an ACPI table with a certain ordering and the SW is sensitive
> > > to this ordering.
> > > 
> > > Even if there is some Linux bug mis-parsing the ACPI, then that still
> > > should be addressed from a qemu perspective by providing the ACPI
> > > construction that doesn't trigger any bug so existing VM images will
> > > work under qemu.
> > > 
> > > Thus qemu needs a way to reflect the ordering on the command line to
> > > properly emulate this system and accomodate the existing VM software...
> > > 
> > > Jason
> > 
> > Not arguing against this, but if there's a linux bug it is important
> > to fix it as a 1st step. qemu work arounds for broken guests
> > notwithstanding. then we can check how long the uapi has been around,
> > how practical bugfix backport in linux is, and decide on whether
> > a host side work around is worth it.
> 
> Yeah, Ankit should provide more details to check for kernel bugs, but
> I fear it is more userspace bugs in practice :\
> 
> However, I think even if it is minor and easier to backport it still
> doesn't matter. The CSPs all built their VM types for this HW with the
> exepcted ACPI and this stuff is now very widely deployed. It makes no
> sense for qemu to be incompatible with everything pre-existing...
> 
> Jason

not having the data I can't judge, but this would be something to detail
in the commit log.  e.g. since which kernel version did it expose this,
etc etc.

regardless, asking that kernel fix is developed (if possible) and not
just a qemu workaround, is something i routinely do since otherwise it
is hard to find people willing to fix things properly.

-- 
MST


