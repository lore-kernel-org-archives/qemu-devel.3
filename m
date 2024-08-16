Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7394DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyB4-0006C5-8x; Fri, 16 Aug 2024 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seyAv-0006BO-50
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 10:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seyAs-0003EW-0y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 10:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723819408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ySH+14f6tKskyENhcKqAqt56ugMrjuhVTnIWMiyRHc=;
 b=GyCyjgQVUW6e0aYRcFUSS/OjS4KuOum0Js2C+n+7sleZ7vkTVuxXseBTcFx2xkSJ1gEVk5
 kr2c6ndaBueFLXbQywT8OQTSDo7I4VeCdG+stntEfotBisvrRVsRzmnuxjejEGIu3cArnT
 s4fXrULzamgYYy+KxDJznsEwjGJLLQE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-7fothGcIMZCWbG6ee7Ss1A-1; Fri, 16 Aug 2024 10:43:26 -0400
X-MC-Unique: 7fothGcIMZCWbG6ee7Ss1A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b7678caf7dso5880566d6.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 07:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723819406; x=1724424206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ySH+14f6tKskyENhcKqAqt56ugMrjuhVTnIWMiyRHc=;
 b=RSQ6Mths9T5tGMu2WQHFA4HzN0kpjgyG6beCIXe6Gb6LEn7y1DYX52b9BR7NZnBRZI
 Iy1/Bwp5+OkaVGIvYx8mKS4Ej2ERV+CRds2Bio4hHfqaSUh2YDMNBmDg5tA+AN8+H1Io
 LEw92FnqKJ5+bTQWg5xeYPRCUpaEEHbZmxZJNAeOpGhL+dJx9aW60cQXM32c6A4i+6k6
 25Ofzpe1eyPd33QVfEOovvGKg3VMTnh3wubIaf8zTAh8MFRoZIvpqEyZK7e5H9UkpBgh
 7sENQbF3AlSP27CXA0hr5CXzgmCnkesLz4V3o3pQ2l4LNqn9rvFBKchJy5+HqJw9SHOw
 qalw==
X-Gm-Message-State: AOJu0Yyk56wGZZVrqQ2mvsFjy/7uvoEX0AfHJekKDNsfu59qzWv28RXx
 lgqDywp2zk5JN66v68Po/8vV/KJQ8qg/v9BxvNAV24Iqi9Qqc8gi8fNFpfwMguJCnUmhWlveOEu
 w4nK5fW69zuY2vbsenboRkwSnBrOgtklsmUIkLTbBQSh5WILuIoeo
X-Received: by 2002:a05:6214:e8c:b0:6b4:fda5:88b6 with SMTP id
 6a1803df08f44-6bf7cd912f4mr19740796d6.1.1723819406057; 
 Fri, 16 Aug 2024 07:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO/38Bybm+YA8pozloyqkzfIZdvgTZpX+9FP2dQ3YwPfcQpYSDTXaO+32TxK2ovbfyrhZUFQ==
X-Received: by 2002:a05:6214:e8c:b0:6b4:fda5:88b6 with SMTP id
 6a1803df08f44-6bf7cd912f4mr19740586d6.1.1723819405592; 
 Fri, 16 Aug 2024 07:43:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fdd9336sm17937786d6.23.2024.08.16.07.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 07:43:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:43:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
Message-ID: <Zr9li88goR-YKcng@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n>
 <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
 <ZrvFXCRPczXvCu2n@x1n>
 <5f763763-1479-4585-98ce-83fcec03b4db@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f763763-1479-4585-98ce-83fcec03b4db@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 15, 2024 at 04:54:58PM -0400, Steven Sistare wrote:
> On 8/13/2024 4:43 PM, Peter Xu wrote:
> > On Wed, Aug 07, 2024 at 05:04:26PM -0400, Steven Sistare wrote:
> > > On 7/19/2024 12:28 PM, Peter Xu wrote:
> > > > On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
> > > > > For new cpr modes, ramblock_is_ignored will always be true, because the
> > > > > memory is preserved in place rather than copied.  However, for an ignored
> > > > > block, parse_ramblock currently requires that the received address of the
> > > > > block must match the address of the statically initialized region on the
> > > > > target.  This fails for a PCI rom block, because the memory region address
> > > > > is set when the guest writes to a BAR on the source, which does not occur
> > > > > on the target, causing a "Mismatched GPAs" error during cpr migration.
> > > > 
> > > > Is this a common fix with/without cpr mode?
> > > > 
> > > > It looks to me mr->addr (for these ROMs) should only be set in PCI config
> > > > region updates as you mentioned.  But then I didn't figure out when they're
> > > > updated on dest in live migration: the ramblock info was sent at the
> > > > beginning of migration, so it doesn't even have PCI config space migrated;
> > > > I thought the real mr->addr should be in there.
> > > > 
> > > > I also failed to understand yet on why the mr->addr check needs to be done
> > > > by ignore-shared only.  Some explanation would be greatly helpful around
> > > > this area..
> > > 
> > > The error_report does not bite for normal migration because migrate_ram_is_ignored()
> > > is false for the problematic blocks, so the block->mr->addr check is not
> > > performed.  However, mr->addr is never fixed up in this case, which is a
> > > quiet potential bug, and this patch fixes that with the "has_addr" check.
> > > 
> > > For cpr-exec, migrate_ram_is_ignored() is true for all blocks,
> > > because we do not copy the contents over the migration stream, we preserve the
> > > memory in place.  So we fall into the block->mr->addr sanity check and fail
> > > with the original code.
> > 
> > OK I get your point now.  However this doesn't look right, instead I start
> > to question why we need to send mr->addr at all..
> > 
> > As I said previously, AFAIU mr->addr should only be updated when there's
> > some PCI config space updates so that it moves the MR around in the address
> > space based on how guest drivers / BIOS (?) set things up.  Now after these
> > days not looking, and just started to look at this again, I think the only
> > sane place to do this update is during a post_load().
> > 
> > And if we start to check some of the memory_region_set_address() users,
> > that's exactly what happened..
> > 
> >    - ich9_pm_iospace_update(), update addr for ICH9LPCPMRegs.io, where
> >      ich9_pm_post_load() also invokes it.
> > 
> >    - pm_io_space_update(), updates PIIX4PMState.io, where
> >      vmstate_acpi_post_load() also invokes it.
> > 
> > I stopped here just looking at the initial two users, it looks all sane to
> > me that it only got updated there, because the update requires pci config
> > space being migrated first.
> > 
> > IOW, I don't think having mismatched mr->addr is wrong at this stage.
> > Instead, I don't see why we should send mr->addr at all in this case during
> > as early as SETUP, and I don't see anything justifies the mr->addr needs to
> > be verified in parse_ramblock() since ignore-shared introduced by Yury in
> > commit fbd162e629aaf8 in 2019.
> > 
> > We can't drop mr->addr now when it's on-wire, but I think we should drop
> > the error report and addr check, instead of this patch.
> 
> As it turns out, my test case triggers this bug because it sets x-ignore-shared,
> but x-ignore-shared is not needed for cpr-exec, because migrate_ram_is_ignored
> is true for all blocks when mode==cpr-exec.  So, the best fix for the GPAs bug
> for me is to stop setting x-ignore-shared.  I will drop this patch.
> 
> I agree that post_load is the right place to restore mr->addr, and I don't
> understand why commit fbd162e629aaf8 added the error report, but I am going
> to leave it as is.

Ah, I didn't notice that cpr special cased migrate_ram_is_ignored()..

Shall we stick with the old check, but always require cpr to rely on
ignore-shared?

Then we replace this patch with removing the error_report, probably
together with not caring about whatever is received at all.. would that be
cleaner?

Thanks,

-- 
Peter Xu


