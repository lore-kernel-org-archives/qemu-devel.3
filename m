Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381B5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCVR-00018A-4O; Wed, 14 Aug 2024 07:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seCVP-0000zT-90; Wed, 14 Aug 2024 07:49:31 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seCVJ-0002Ad-AU; Wed, 14 Aug 2024 07:49:31 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso100071961fa.2; 
 Wed, 14 Aug 2024 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723636163; x=1724240963; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dp0L+GamiTI78LaNXUI0L+8bA2ZqatuVzlZrQCRiNiI=;
 b=Wt9DScROpp0FtGNvwGkwa+SuxNaulhE4far2y1uIEb4cP8LR734CfM7AOqky5wh1vc
 jz0aT+hXpttshRjTXvZhS9p7rofXTCaAyFmdIgbdPKOpuZmhPaLYfTI5UrnDhUxoFU9c
 ksa8LYCHeMFUz34aEL6iuiqCXRMhj0iOue5jnLgYW+fOEXc8ehWZALLehhppJ39HGmgB
 5y18TTvyyw6kMpBwL68BgvaXBDnc569u8u64sXVsvfh4jyrZjDfIzeNs3ipHUMH841rX
 RKBclmPgqPArXobCObh4MCBGyvFNsehwprFciA+ZvG7Gs8n3wQu/PZCUm7c+binyIVRd
 ZWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636163; x=1724240963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dp0L+GamiTI78LaNXUI0L+8bA2ZqatuVzlZrQCRiNiI=;
 b=vKcFI+XACUDK2mBKFCreXVJ6h2D0z+Pe6qdLBjr9JekkaeX0LfrPOLsHGtJCZsR4uK
 4CGawxgI1B64/Tryl7WHUSwRQvxG9ZZmU2qiIB1P7yDqCcqe24/axL2fO84jLixyJTOM
 ACggQ4Wr/21sqHsVq0mqxNmAavt9TgIdMty/ScXoo8+sqNaOOQ5uMhAFBsMQOJ3bfsby
 1DKt920vvmfNrYoRjb+m62nzHBclRvrPvzpX4gh2RxQ+1NWqRr9W2cRUlLIB0/rJTASi
 scY+nxBwX0JPcqJxBEzfJvtdJJYHlTk9ne2LN1X2u6/v/l0iQZXi2egggqrPzswsppWb
 VmUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrDgFg6ci7PcRNzBLd15CHZDeOPVAHf09xyPesK1a2NwiJMAiT9ci2jGK3ojnFbzexjhTxKn+ltw==@nongnu.org
X-Gm-Message-State: AOJu0YzIYQBR+BgQGcvegDlsJkLGQ9FzvczA3lxLpwzJcjvNXsIQY/vd
 2A4c/BQ9RuDST79SQtpzSUvxkkhjO7II/ghaAVHIBq9FmKTkdHMCSUxGBEmr
X-Google-Smtp-Source: AGHT+IFMKxXSID3krkFoZ71TRri2uuaWjn55H1yF6EWyj543s/obDY84Jsw9e73Y36BCyYIts5LDiQ==
X-Received: by 2002:a05:651c:1079:b0:2ef:26f2:d3ec with SMTP id
 38308e7fff4ca-2f3aa1df0e5mr17466981fa.12.1723636161891; 
 Wed, 14 Aug 2024 04:49:21 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f291ddbaedsm14068641fa.18.2024.08.14.04.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 04:49:21 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:49:20 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 qemu-arm@nongnu.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH v1 04/10] hw/arm: xenpvh: Add support for SMP guests
Message-ID: <ZryZwOoadeb1UWK8@zapote>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-5-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121650590.298534@ubuntu-linux-20-04-desktop>
 <ZruRm34zIMtUm7oH@zapote>
 <alpine.DEB.2.22.394.2408131550080.298534@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2408131550080.298534@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 13, 2024 at 03:52:32PM -0700, Stefano Stabellini wrote:
> On Tue, 13 Aug 2024, Edgar E. Iglesias wrote:
> > On Mon, Aug 12, 2024 at 06:47:17PM -0700, Stefano Stabellini wrote:
> > > On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > > > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > > > 
> > > > Add SMP support for Xen PVH ARM guests. Create max_cpus ioreq
> > > > servers to handle hotplug.
> > > > 
> > > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > > ---
> > > >  hw/arm/xen_arm.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > > > index 5f75cc3779..ef8315969c 100644
> > > > --- a/hw/arm/xen_arm.c
> > > > +++ b/hw/arm/xen_arm.c
> > > > @@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
> > > >  
> > > >      xen_init_ram(machine);
> > > >  
> > > > -    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
> > > > +    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
> > > >  
> > > >      xen_create_virtio_mmio_devices(xam);
> > > >  
> > > > @@ -218,7 +218,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
> > > >      MachineClass *mc = MACHINE_CLASS(oc);
> > > >      mc->desc = "Xen PVH ARM machine";
> > > >      mc->init = xen_arm_init;
> > > > -    mc->max_cpus = 1;
> > > > +    /* MAX number of vcpus supported by Xen.  */
> > > > +    mc->max_cpus = GUEST_MAX_VCPUS;
> > > 
> > > Will this cause allocations of data structures with 128 elements?
> > > Looking at hw/xen/xen-hvm-common.c:xen_do_ioreq_register it seems
> > > possible? Or hw/xen/xen-hvm-common.c:xen_do_ioreq_register is called
> > 
> > Yes, in theory there's probably overhead with this but as you correctly
> > noted below, a PVH aware xl will set the max_cpus option to a lower value.
> > 
> > With a non-pvh aware xl, I was a little worried about the overhead
> > but I couldn't see any visible slow-down on ARM neither in boot or in network
> > performance (I didn't run very sophisticated benchmarks).
>  
> What do you mean by "non-pvh aware xl"? All useful versions of xl
> support pvh?


I mean an xl without our PVH patches merged.
xl in upstream doesn't know much about PVH yet.
Even for ARM, we're still carrying significant patches in our tree.


> > > later on with the precise vCPU value which should be provided to QEMU
> > > via the -smp command line option
> > > (tools/libs/light/libxl_dm.c:libxl__build_device_model_args_new)?
> > 
> > Yes, a pvh aware xl will for example pass -smp 2,maxcpus=4 based on
> > values from the xl.cfg. If the user doesn't set maxvcpus in xl.cfg, xl
> > will set maxvcpus to the same value as vcpus.
> 
> OK good. In that case if this is just an initial value meant to be
> overwritten, I think it is best to keep it as 1.

Sorry but that won't work. I think the confusion here may be that
it's easy to mix up mc->max_cpus and machine->smp.max_cpus, these are
not the same. They have different purposes.

I'll try to clarify the 3 values in play.

machine-smp.cpus:
Number of guest vcpus active at boot.
Passed to QEMU via the -smp command-line option.
We don't use this value in QEMU's ARM PVH machines.

machine->smp.max_cpus:
Max number of vcpus that the guest can use (equal or larger than machine-smp.cpus).
Will be set by xl via the "-smp X,maxcpus=Y" command-line option to QEMU.
Taken from maxvcpus from xl.cfg, same as XEN_DMOP_nr_vcpus.
This is what we use for xen_register_ioreq().

mc->max_cpus:
Absolute MAX in QEMU used to cap the -smp command-line options.
If xl tries to set -smp (machine->smp.max_cpus) larger than this, QEMU will bail out.
Used to setup xen_register_ioreq() ONLY if -smp maxcpus was NOT set (i.e by a non PVH aware xl).
Cannot be 1 because that would limit QEMU to MAX 1 vcpu.

I guess we could set mc->max_cpus to what XEN_DMOP_nr_vcpus returns but I'll
have to check if we can even issue that hypercall this early in QEMU since
mc->max_cpus is setup before we even parse the machine options. We may
not yet know what domid we're attaching to yet.

Cheers,
Edgar

