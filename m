Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9749ECA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMkS-0007De-0s; Thu, 01 Oct 2026 15:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCMkE-0007D8-QV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCMkA-0005Hc-OR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790884021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wrozo+qnKn4+FGCw8O6nFXp75AHvKuZhyLw55HXbfBE=;
 b=BmW2dA3xwUBNIqsBkwn1GJEHC9hbzxDyZYJ06nDn/ntJqY3Hb70iPU3ut56til2ZSbFhv2
 2nyIdx41uxUJAhlyXKEtPShTRDwhxoQ+ipl3JMBvTjs6da3a5t+OTFMwawHSeu94goR9se
 hn9EYnqT1XQlM8TG1qmF1GRg/r7dmX0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-zxFO0EwnMJWC2262f54nIg-1; Thu, 01 Oct 2026 15:47:00 -0400
X-MC-Unique: zxFO0EwnMJWC2262f54nIg-1
X-Mimecast-MFC-AGG-ID: zxFO0EwnMJWC2262f54nIg_1790884020
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530d912b923so138936881cf.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790884020; x=1791488820; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wrozo+qnKn4+FGCw8O6nFXp75AHvKuZhyLw55HXbfBE=;
 b=Lc7gS1d4Zl47rx0Z4gTwLXXAJlAaVUpEscFSSW3TmP/qyGrlclYMVEXAkt++BiIiza
 y24ERlO/9W+sgI8338pkh2rZSEPf8S/4jCMR+RhssVNhiUN2x1LHgfgyJKo+2A9Y6Qb5
 7jdOXsanHh1fdMENA3LaMS4SSNYOLvagbd9IB8GMMWVVknaO8fDEpSpaSi6J0alPsdhx
 N2ZxvWDT1+kqSavEqKv51npxVsOGLbEANUTuSsyldoQw574GR/nUXTlTlmkd7VZjCDMf
 T6LkV9wZjsZZHzYIT0HcivEIZK8el4XZT88g8gjkA0t3+GLp/m484mesmi6OmmicWW1G
 D4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884020; x=1791488820;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wrozo+qnKn4+FGCw8O6nFXp75AHvKuZhyLw55HXbfBE=;
 b=GcHdsmc29yqL2xavmor3Ay2EmWtaKN/4Vmt7WPLtgAeWI8jo/tF7jAwnmvBS+J+ffJ
 fH6JeQY6winYwhemx+qBcrN7i3ndrPKreAbLbX0bTsGp9kF3gpcYevFizaRi8SiKXbKg
 80g7DWajRUTSOLuB5QIu63LVMgeeEZBsPJt2RNAASEVmCwTujFryk8NYyFnOgmtZl6Ah
 rWJ+TFvFfTW8KaicLGgLsJRYREEYAAMbXahboIWXqYHlN9D739VlwPcihcAQvPXF2BaZ
 x/gbMMdubWv94x4aYR+pydan3Q7pTEyqxb8LGmH5J2gVSNDlwWdDUOcONhs7THPynlPr
 t82Q==
X-Gm-Message-State: AFuF++nXM0ElFq0gW/Laur9STcfkmhCG/FK/ZPn6fYlC03ZNLy0KI1CQ
 k38O9SiCTkFpZjXlpo96eJkxRedJZyXVEXJ3/fR7mHj+Emp/cJIaCf3soG1TPjEzFE3WPmjeRaV
 FWUuuegV0xJmHIHNgxpxB4BdUBCkYqfyedDaMqt5Bl8PEmqW8sCePztFx
X-Gm-Gg: AYBFou15rTqGHfW9CyIkNre9gkGJa+Eo5Rj/+a+HjfWVfEvxgXS8BhZ5wIKhn5QGrI2
 Tsb9MBQZqcjc8OQyTn5NiKj1PA/x85XvTgJY4FkQgTQZSJOcc0cGo5skDlv1GS57FrM8bX7Vb9U
 sEgmF+hbIdou87ipBxqrLxDMffsSlV4SqIqVGl7MnKuFJJTcF6xAY9eLTwd5UQKc9xKKJ/vb5ln
 FRQxTb6wJpvjVoA/VUfMilUTg2YPPXaxon4sOdrEijyXebIp9R4OqMNJwPOBc6uuKoEKGRMhk3R
 03FQXj9nvCbl1DogkeN/Pr9HvXXLsJmVomzBXoig/Liaf9hQHP3LAmhcMQijcu/ZRiG7fI4=
X-Received: by 2002:ac8:5d8b:0:b0:533:9607:f136 with SMTP id
 d75a77b69052e-533d96a6439mr3242611cf.25.1790884019402; 
 Thu, 01 Oct 2026 12:46:59 -0700 (PDT)
X-Received: by 2002:ac8:5d8b:0:b0:533:9607:f136 with SMTP id
 d75a77b69052e-533d96a6439mr3241951cf.25.1790884018655; 
 Thu, 01 Oct 2026 12:46:58 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398be3089sm6184821cf.21.2026.10.01.12.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:46:57 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:46:56 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH 0/2] migration: defer a post_load which only rearranges
 memory
Message-ID: <ar64sJucQdmgu7mB@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260911142345.3999518-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 11, 2026 at 04:23:43PM +0200, Denis V. Lunev wrote:
> Restoring a big Windows guest spends most of its destination-side time in
> post_load hooks which do nothing but move memory regions around. Each one
> ends a memory transaction, and a transaction commit re-renders every
> flatview it touches at a cost which grows with the number of regions in
> the machine. A hook which runs once per vCPU therefore pays that render
> once per vCPU, and the machine gets slower to migrate the bigger it is.
> 
> The Hyper-V SynIC is the case that hurts: restoring the synthetic
> interrupt controller maps a message page and an event page per vCPU, so a
> 64-vCPU guest forces 128 remaps, each with its own rebuild, while the rest
> of the stream is still being read.

This is partly a known issue, not from Hyper-V, but from virtio mmio
regions.. please see:

https://wiki.qemu.org/ToDo/LiveMigration#Optimize_memory_updates_for_non-iterative_vmstates
https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com

I believe we also thought about do MR update per-device, so batching but
smaller scale, easier to make sure no illegal access to a stale flatview.

So in general, I agree this approach might be the right way to do, which is
to shrink the transaction to be smaller than "batch everything".. as what
Chuang used to do.  I still have some pure questions inline.

> 
> Patch 1 adds post_load_deferrable. A vmsd which sets it has its hook

Nit, IMHO if so it needs to be called "deferred", as "deferrable" implies
the defer is optional.

> queued during the load and run once the stream has been consumed, in the
> order the hooks would have fired, with the whole drain sharing one memory
> transaction. Patch 2 sets it on the SynIC subsection.
> 
> It is opt-in rather than automatic, and the three preconditions are
> spelled out on the field: the hook must not fail, nothing later in the

Actually, I _think_ maybe it can still fail.. IIUC source QEMU only dies if
it receives shut from migrate_send_rp_shut(), which is after the deferred
loads at least with the current change.  Worth check..

> load may depend on what it does, and it must not read guest memory or
> resolve an address space.

Yes, but I think this is partial of the whole picture: IIUC if this
deferred hook may inject some MRs that may be accessed by other VMSD
loaders, or anything (including hard-coded loading process), I think it's
an issue too.

So personally I don't like this API very much yet on how it was defined;
it'll be very hard to be used right unless we fully understand what will
happen..

I wonder if there's better way to define the API to be clearer.

Since all the known issues about this is about MR updates: virtio MMIO
regions, hyper-v, pci bar/bridge (mentioned below), I wonder if this can be
something dedicated to MR updates, and maybe it doesn't need to be
"deferred", just grouped together properly into one transaction, which can
happen in the middle too or maybe it doesn't matter much. Then it applies
some form of limitation to what can be split out from normal VMSD flow. The
current API relies on allowing to defer anything, which is fine but very
hard to control, and we may face tricky bugs if users grows but when
they're not used right..

> A hook which breaks the first is fatal rather
> than silently reported, because by drain time the source may already have
> been told the migration succeeded.
> 
> Deferring is not free in general, which is the other reason it is opt-in.
> Deferring the APIC post_load, whose cost is a synchronous run_on_cpu per
> vCPU rather than a memory remap, moves 3 ms out of the section walk and
> pays about 9 ms of drain for it. Deferral helps a hook which repeats

I'm just curious: why something will take 9ms if deferred, even if it used
to take 3ms?  I think I misread something, but I can't tell myself.

> topology work; it makes a hook which does cross-thread work worse.
> 
> Measurements
> ------------
> 
> Destination-side non-iterable load, ie. the sum of vmstate_downtime_load
> over non-iterable sections, on a guest which has actually programmed its
> Hyper-V state. Five interleaved rounds per point on an otherwise idle
> host, twice; medians, with the spread across all ten rounds.
> 
>   upstream                          377 ms   (363-400)
>   + pci mapping transactions        247 ms   (242-255)
>   + this series                      96 ms   (86-97)

Definitely a great improvement.  I think we need this, just one way or
another. I may have some other trivial comments later in the patch.  Thanks
for working on it.

> 
> Two postings against one problem, so the whole ladder is shown. The first
> step is a pci pair which batches a device's BAR and bridge window updates
> into a single transaction, posted separately and now queued in Michael's
> tree:
> 
>   https://lore.kernel.org/qemu-devel/20260903184542.2629976-1-den@openvz.org/
> 
> Those two are listed because they change what a rebuild costs, and so
> change what this series is worth. Together the postings take the load
> from 377 ms to 96 ms; this series is the 247 ms to 96 ms step.
> 
> Where it goes: the cpu sections fall from 154 ms to 1.3 ms. The deferred
> hooks themselves cost 77 us at the drain, so the work is removed rather
> than moved somewhere the per-section metric cannot see.
> 
> The saving scales with vCPU count, since that is how many times the remap
> repeats, and with the number of memory regions in the machine, since that
> is what a rebuild costs.
> 
> Guest under test
> ----------------
> 
> Windows Server 2022, installed unattended, idle at the console:
> 
>   -machine q35,accel=kvm
>   -cpu host,hv-synic,hv-stimer,hv-stimer-direct,hv-vapic,hv-runtime,
>        hv-time,hv-ipi,hv-crash,hv-reset,hv-frequencies,hv-vpindex,
>        hv-spinlocks=0x1fff
>   -smp 64,sockets=2,cores=32,threads=1
>   -m 4G
>   65 pcie-root-ports, 9 virtio devices behind them, qxl
> 
> Host: AMD EPYC 7443P, 24 cores / 48 threads.
> 
> hv-synic is the flag that matters. Without it the guest never programs
> the SynIC pages and the effect under test does not exist.
> 
> Measured with a save/restore harness rather than a live migration: a
> restore from a captured stream walks the same qemu_loadvm_state_main()
> path a destination does, which removes libvirt, the network and the
> second host from the measurement.
> 
> CC: Peter Xu <peterx@redhat.com>
> CC: Fabiano Rosas <farosas@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
> 
> Denis V. Lunev (2):
>   migration: let a vmstate defer its post_load to end of stream
>   target/i386: defer the Hyper-V SynIC post_load
> 
>  include/migration/vmstate.h |  40 +++++++++++++
>  migration/savevm.c          |  23 ++++++++
>  migration/vmstate.c         |  67 +++++++++++++++++++++-
>  target/i386/machine.c       |   1 +
>  tests/unit/test-vmstate.c   | 111 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 240 insertions(+), 2 deletions(-)
> 
> -- 
> 2.53.0
> 

-- 
Peter Xu


