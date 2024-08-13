Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A51C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdyMS-0001Yw-Iq; Tue, 13 Aug 2024 16:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdyMR-0001Ug-BO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdyMP-00016M-I3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723581795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y95b4aF5TiUzwUL+WNWP1EyFDs2fFxavfLllY0yoacw=;
 b=dt0HaVqp3DLF5wNStUUlwO4imuPsQa3JAwOOtDnXaFBgCdjytIspF/fdD2xmscapQt/9mx
 kbgICJVKMGNmluNgfmUb8APLdvDLRvRyaEk7c9JRP2KWUJRDOsd0yGq2pOGYE1kwiEZyPJ
 8B8ULi87Et7I+Nkde8Q4kRan7d0atYA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-hzh0wrx6PauSf4e-d2Me6w-1; Tue, 13 Aug 2024 16:43:12 -0400
X-MC-Unique: hzh0wrx6PauSf4e-d2Me6w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ba92dd246fso12138356d6.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723581792; x=1724186592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y95b4aF5TiUzwUL+WNWP1EyFDs2fFxavfLllY0yoacw=;
 b=S+osFkjXtRF8qPtKqXPM1cykGBOdlx+Uta5W7bmInmukgxAG5AnZ1XoRPVkFcI8G0d
 LnqCPsxLO1eVuUx6z3FQiK8Ut9MYV5wdlM5cYhf7JAd4m2eYQUKbho2aJLQAIIhvnamX
 2cuPuv5op/bXH7IrOqokLtVJkwP1V19JmqaJdlONAmrTYP20bTz+K161DFc4YeP1RtRQ
 cP6NF0yMlpaywdNzVfstJqz4Z27xcbZw93gWjB+ILARwlzqw/NlUQN8pPElJpHr7C18Q
 om7OJSO/u0HJeTJb+ESKcZPtx2M7hKMTJULNbbvAU1ihrhMWmRwkuFLWuGcdrJ9Wt0Om
 WRpw==
X-Gm-Message-State: AOJu0YxGET3fwUgkkm61XlM3cguyFjfDzWL6CVHrbgT/slI22PMX1/R5
 R8YTtnh5fUsrnB6O2NGyHXgj+TfdHljvgXYyTgL2eik+HB1x/nJXna9/T3T86OJ8+JwJGo601BM
 3ksO223M3vKl9rXi6xLskTuhQgwhqiDtpQP2v0N+9TL9W3lew9UCG
X-Received: by 2002:a0c:ff4a:0:b0:6bf:5d84:1318 with SMTP id
 6a1803df08f44-6bf5d841a07mr3955826d6.0.1723581792077; 
 Tue, 13 Aug 2024 13:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfLVXAx/uzRB1N1dJtuIf86d+N+gUEroNZFU/iuJs8QEcQ+ZrMYbYbW5XCkqS9fcprAxFrUg==
X-Received: by 2002:a0c:ff4a:0:b0:6bf:5d84:1318 with SMTP id
 6a1803df08f44-6bf5d841a07mr3955596d6.0.1723581791674; 
 Tue, 13 Aug 2024 13:43:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82e53a83sm37029096d6.118.2024.08.13.13.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:43:11 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:43:08 -0400
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
Message-ID: <ZrvFXCRPczXvCu2n@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n>
 <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

On Wed, Aug 07, 2024 at 05:04:26PM -0400, Steven Sistare wrote:
> On 7/19/2024 12:28 PM, Peter Xu wrote:
> > On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
> > > For new cpr modes, ramblock_is_ignored will always be true, because the
> > > memory is preserved in place rather than copied.  However, for an ignored
> > > block, parse_ramblock currently requires that the received address of the
> > > block must match the address of the statically initialized region on the
> > > target.  This fails for a PCI rom block, because the memory region address
> > > is set when the guest writes to a BAR on the source, which does not occur
> > > on the target, causing a "Mismatched GPAs" error during cpr migration.
> > 
> > Is this a common fix with/without cpr mode?
> > 
> > It looks to me mr->addr (for these ROMs) should only be set in PCI config
> > region updates as you mentioned.  But then I didn't figure out when they're
> > updated on dest in live migration: the ramblock info was sent at the
> > beginning of migration, so it doesn't even have PCI config space migrated;
> > I thought the real mr->addr should be in there.
> > 
> > I also failed to understand yet on why the mr->addr check needs to be done
> > by ignore-shared only.  Some explanation would be greatly helpful around
> > this area..
> 
> The error_report does not bite for normal migration because migrate_ram_is_ignored()
> is false for the problematic blocks, so the block->mr->addr check is not
> performed.  However, mr->addr is never fixed up in this case, which is a
> quiet potential bug, and this patch fixes that with the "has_addr" check.
> 
> For cpr-exec, migrate_ram_is_ignored() is true for all blocks,
> because we do not copy the contents over the migration stream, we preserve the
> memory in place.  So we fall into the block->mr->addr sanity check and fail
> with the original code.

OK I get your point now.  However this doesn't look right, instead I start
to question why we need to send mr->addr at all..

As I said previously, AFAIU mr->addr should only be updated when there's
some PCI config space updates so that it moves the MR around in the address
space based on how guest drivers / BIOS (?) set things up.  Now after these
days not looking, and just started to look at this again, I think the only
sane place to do this update is during a post_load().

And if we start to check some of the memory_region_set_address() users,
that's exactly what happened..

  - ich9_pm_iospace_update(), update addr for ICH9LPCPMRegs.io, where
    ich9_pm_post_load() also invokes it.

  - pm_io_space_update(), updates PIIX4PMState.io, where
    vmstate_acpi_post_load() also invokes it.

I stopped here just looking at the initial two users, it looks all sane to
me that it only got updated there, because the update requires pci config
space being migrated first.

IOW, I don't think having mismatched mr->addr is wrong at this stage.
Instead, I don't see why we should send mr->addr at all in this case during
as early as SETUP, and I don't see anything justifies the mr->addr needs to
be verified in parse_ramblock() since ignore-shared introduced by Yury in
commit fbd162e629aaf8 in 2019.

We can't drop mr->addr now when it's on-wire, but I think we should drop
the error report and addr check, instead of this patch.

Thanks,

-- 
Peter Xu


