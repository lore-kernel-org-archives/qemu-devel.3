Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC7C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTUr-0005yT-BR; Thu, 18 Jul 2024 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUTUp-0005xb-IS
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUTUn-0001BB-7x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721318199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psdyXtxcjtiBBXhDetV+GB4YIl9/dNVKaz0XkWdAjgQ=;
 b=TMtY9GAmz1MxTuvMmTcC0V6C7rysLVnKqQu0i8zz8gaITjSUwmQ8Rp6OBuB5HRiYzBLe7N
 jigi5wLequQrgNFEW4EYo4ZPXDYdOtjkip6q/NFNsn2mWgT91Mt4KZPiKefudUm29Re3CG
 Z7mGOR+lt6XgGX6If1GmuchPPOvDOUM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-a6knK6ABNFWj3KqxAufKzQ-1; Thu, 18 Jul 2024 11:56:38 -0400
X-MC-Unique: a6knK6ABNFWj3KqxAufKzQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b7678caf7dso2948526d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721318198; x=1721922998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psdyXtxcjtiBBXhDetV+GB4YIl9/dNVKaz0XkWdAjgQ=;
 b=DNCKfyi+DEfeFJ00c3rcCus77V1phpb8bfT/pFPUCep3Rk9SxXHIwdjQir5ntPum2g
 +NmPyibQsFeYXftgaSuDKQ0o445BM5+2zWP/uEAeMVWlVaNSYy8LtIa/uylUchIg0Mj6
 h7zpHsYd1OIzu6HAaAN5L2rQcrMC5cdf8ZL3dgDV0p8vQrGB3dXAI+Vs/NXiWHldZquB
 Gr9tgjLp/Nfnu+NVCGsqep8pW9YpxKzKUZ0zXrztcDi8GaDSQrGRYmpN2y+lc9k4Y+rY
 70NdgnCppJcqwTz8Ypu9NzBby4TAyFV+/Hx5GCEDovrWzc4dG5Wf55BctfTc03M9gmHY
 +aDQ==
X-Gm-Message-State: AOJu0YxF9XtVPUd+zUk/RoDOjmFZWg5/QV74EB1vfgQ5pLph81zN6yUG
 G4R4zdeuveM9s7TBB40oyezgAW8oT12cIawqQPvJjV6A0o4ABAqc8QaK1z+ljLTQzNAPyyMCfRz
 AlxNIi/QETWmUA9hMpYdb0sEW4Nc0elkQGTeig7eY0+5eko8ehq88
X-Received: by 2002:a05:620a:450d:b0:79f:9fa:8222 with SMTP id
 af79cd13be357-7a196e16624mr449385a.6.1721318197431; 
 Thu, 18 Jul 2024 08:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKEKyz2SvFQq+ATqgvUg783HbLQOwEhrNH0klZWRPbnI9ftLirY3Uw8W1KNdyHOPFRnDkUQQ==
X-Received: by 2002:a05:620a:450d:b0:79f:9fa:8222 with SMTP id
 af79cd13be357-7a196e16624mr446685a.6.1721318196924; 
 Thu, 18 Jul 2024 08:56:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19394f394sm37429185a.87.2024.07.18.08.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 08:56:36 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:56:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zpk7Mf2c7LiNV2xC@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Steve,

On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
> What?

Thanks for trying out with the cpr-transfer series.  I saw that that series
missed most of the cc list here, so I'm attaching the link here:

https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com

I think most of my previous questions for exec() solution still are there,
I'll try to summarize them all in this reply as much as I can.

> 
> This patch series adds the live migration cpr-exec mode, which allows
> the user to update QEMU with minimal guest pause time, by preserving
> guest RAM in place, albeit with new virtual addresses in new QEMU, and
> by preserving device file descriptors.
> 
> The new user-visible interfaces are:
>   * cpr-exec (MigMode migration parameter)
>   * cpr-exec-command (migration parameter)

I really, really hope we can avoid this..

It's super cumbersome to pass in a qemu cmdline in a qemu migration
parameter.. if we can do that with generic live migration ways, I hope we
stick with the clean approach.

>   * anon-alloc (command-line option for -machine)

Igor questioned this, and I second his opinion..  We can leave the
discussion there for this one.

> 
> The user sets the mode parameter before invoking the migrate command.
> In this mode, the user issues the migrate command to old QEMU, which
> stops the VM and saves state to the migration channels.  Old QEMU then
> exec's new QEMU, replacing the original process while retaining its PID.
> The user specifies the command to exec new QEMU in the migration parameter
> cpr-exec-command.  The command must pass all old QEMU arguments to new
> QEMU, plus the -incoming option.  Execution resumes in new QEMU.
> 
> Memory-backend objects must have the share=on attribute, but
> memory-backend-epc is not supported.  The VM must be started
> with the '-machine anon-alloc=memfd' option, which allows anonymous
> memory to be transferred in place to the new process.
> 
> Why?
> 
> This mode has less impact on the guest than any other method of updating
> in place.

So I wonder whether there's comparison between exec() and transfer mode
that you recently proposed.

I'm asking because exec() (besides all the rest of things that I dislike on
it in this approach..) should be simply slower, logically, due to the
serialized operation to (1) tearing down the old mm, (2) reload the new
ELF, then (3) runs through the QEMU init process.

If with a generic migration solution, the dest QEMU can start running (2+3)
concurrently without even need to run (1).

In this whole process, I doubt (2) could be relatively fast, (3) I donno,
maybe it could be slow but I never measured; Paolo may have good idea as I
know he used to work on qboot.

For (1), I also doubt in your test cases it's fast, but it may not always
be fast.  Consider the guest has a huge TBs of shared mem, even if the
memory will be completely shared between src/dst QEMUs, the pgtable won't!
It means if the TBs are mapped in PAGE_SIZE tearing down the src QEMU
pgtable alone can even take time, and that will be accounted in step (1)
and further in exec() request.

All these fuss will be avoided if you use a generic live migration model
like cpr-transfer you proposed.  That's also cleaner.

> The pause time is much lower, because devices need not be torn
> down and recreated, DMA does not need to be drained and quiesced, and minimal
> state is copied to new QEMU.  Further, there are no constraints on the guest.
> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
> and suspending plus resuming vfio devices adds multiple seconds to the
> guest pause time.  Lastly, there is no loss of connectivity to the guest,
> because chardev descriptors remain open and connected.

Again, I raised the question on why this would matter, as after all mgmt
app will need to coop with reconnections due to the fact they'll need to
support a generic live migration, in which case reconnection is a must.

So far it doesn't sound like a performance critical path, for example, to
do the mgmt reconnects on the ports.  So this might be an optimization that
most mgmt apps may not care much?

> 
> These benefits all derive from the core design principle of this mode,
> which is preserving open descriptors.  This approach is very general and
> can be used to support a wide variety of devices that do not have hardware
> support for live migration, including but not limited to: vfio, chardev,
> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
> to allow a descriptor to be used in a process that did not originally open it.

Yes, I still think this is a great idea.  It just can also be built on top
of something else than exec().

> 
> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> container and its assigned resources.  By contrast, consider a design in
> which a new container is created on the same host as the target of the
> CPR operation.  Resources must be reserved for the new container, while
> the old container still reserves resources until the operation completes.

Note that if we need to share RAM anyway, the resources consumption should
be minimal, as mem should IMHO be the major concern (except CPU, but CPU
isn't a concern in this scenario) in container world and here the shared
guest mem shouldn't be accounted to the dest container.  So IMHO it's about
the metadata QEMU/KVM needs to do the hypervisor work, it seems to me, and
that should be relatively small.

In that case I don't yet see it a huge improvement, if the dest container
is cheap to initiate.

> Avoiding over commitment requires extra work in the management layer.

So it would be nice to know what needs to be overcommitted here.  I confess
I don't know much on containerized VMs, so maybe the page cache can be a
problem even if shared.  But I hope we can spell that out.  Logically IIUC
memcg shouldn't account those page cache if preallocated, because memcg
accounting should be done at folio allocations, at least, where the page
cache should miss first (so not this case..).

> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> is that the container may include agents with their own connections to the
> outside world, and such connections remain intact if the container is reused.
> 
> How?
> 
> All memory that is mapped by the guest is preserved in place.  Indeed,
> it must be, because it may be the target of DMA requests, which are not
> quiesced during cpr-exec.  All such memory must be mmap'able in new QEMU.
> This is easy for named memory-backend objects, as long as they are mapped
> shared, because they are visible in the file system in both old and new QEMU.
> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
> the device that locked them remains open.
> 
> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> and by sending the unique name and value of each descriptor to new QEMU
> via CPR state.
> 
> For device descriptors, new QEMU reuses the descriptor when creating the
> device, rather than opening it again.  The same holds for chardevs.  For
> memfd descriptors, new QEMU mmap's the preserved memfd when a ramblock
> is created.
> 
> CPR state cannot be sent over the normal migration channel, because devices
> and backends are created prior to reading the channel, so this mode sends
> CPR state over a second migration channel that is not visible to the user.
> New QEMU reads the second channel prior to creating devices or backends.

Oh, maybe this is the reason that cpr-transfer will need a separate uri..

Thanks,

-- 
Peter Xu


