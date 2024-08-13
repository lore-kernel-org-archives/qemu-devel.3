Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEE7C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduum-00079P-2J; Tue, 13 Aug 2024 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sduuh-0006rD-Lo; Tue, 13 Aug 2024 13:02:28 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sduuf-0002hG-Ug; Tue, 13 Aug 2024 13:02:27 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52efd8807aaso7623889e87.3; 
 Tue, 13 Aug 2024 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723568542; x=1724173342; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JGJpkmzwhAHPEBfWQMTLg/zF6IPgm68M3yUmp2d77TM=;
 b=c6pDxC0W4QcigvorQAKUZIVfU88yQU0BhuoyCjOjii2tu5jxQO5CL+GYL/apd83vE8
 MU7BLxk9SHHEn2kT9UMgwllh0Y75LNtv8BllkO7KFEVnz0Tb7YQjOnQFC2GxIAXzWs1E
 WvQBgYQGHhB0wLXy9HQBgcbyMeNSpaHOcsxH/XZk8K9aC6C/JE90FBO251d4SeJRV29L
 SdNYryS9CwPN7R7n71++jAFkGb+2MN36v1COZlV1INTR6v9v/55y6ltlUZ4QiphjUBZE
 hChiFYwJoTBlOR2RppAnd3pZ5MSDo5pLVwlrWq19vh4TPGaNEiapDDX/yk8nJIkY6fq1
 MPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568542; x=1724173342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGJpkmzwhAHPEBfWQMTLg/zF6IPgm68M3yUmp2d77TM=;
 b=TO1jQ9fjeueiCAj/LiqdYAxW6qEFhVwmIdy00CgvaRhNM1HiNbjz5wHb98vj4lj9N6
 CUlBLmEcv2uaqA7CpU4lVTnEyazfC1fckQImsoVIoSo6GFhaMMb9OxH17UqyyQdfd0kE
 OjwLrOTz7yfKcB+url9Sy/XT2juFKn0MeoEvi/Jgj0kMF9erJ8/FGZxsPnrUaE9dd06j
 ukP9E5ELBWorzW/CBwNukX9fyxJX1OBC136j1zBVfWvOOYs4/kH1KH3XDu2gtZ+H7Mco
 Kf3Ga4Le1IkLMLqFjne5cc+776hoF5+gHt6u0TIsWFdMk9VaGyFx3QZZIBxYVQDXaEo3
 Z2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzNftJtCp47Uv3DcjdYW4RHPNbtiJHIWvVNkt3YzB33yYMbilcGwJkRzU+tzQuQZaWXZsedRTVv6C6olycXpjszL1e
X-Gm-Message-State: AOJu0YxcDEB3yAUZCxRAGY2bH3wJTTdPiF1+zO3zTTWCqYVqOWj2C67E
 9L9x++bwV7PjuI0EMF3yL2SZpt+CGHFw4dSL4pb+j7gXaqq8bP7U
X-Google-Smtp-Source: AGHT+IHZuurj1sUG8YFtdeInfXPdWplweffYruWCp+QQjqA/XiC02As6mGM3q9lJSfLX6jrUtjaRPw==
X-Received: by 2002:a2e:90cd:0:b0:2f1:585b:f326 with SMTP id
 38308e7fff4ca-2f3aa1fe856mr50841fa.45.1723568541128; 
 Tue, 13 Aug 2024 10:02:21 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f29203d817sm11755511fa.99.2024.08.13.10.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:02:20 -0700 (PDT)
Date: Tue, 13 Aug 2024 19:02:19 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v1 04/10] hw/arm: xenpvh: Add support for SMP guests
Message-ID: <ZruRm34zIMtUm7oH@zapote>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-5-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121650590.298534@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2408121650590.298534@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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

On Mon, Aug 12, 2024 at 06:47:17PM -0700, Stefano Stabellini wrote:
> On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Add SMP support for Xen PVH ARM guests. Create max_cpus ioreq
> > servers to handle hotplug.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/arm/xen_arm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > index 5f75cc3779..ef8315969c 100644
> > --- a/hw/arm/xen_arm.c
> > +++ b/hw/arm/xen_arm.c
> > @@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
> >  
> >      xen_init_ram(machine);
> >  
> > -    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
> > +    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
> >  
> >      xen_create_virtio_mmio_devices(xam);
> >  
> > @@ -218,7 +218,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
> >      MachineClass *mc = MACHINE_CLASS(oc);
> >      mc->desc = "Xen PVH ARM machine";
> >      mc->init = xen_arm_init;
> > -    mc->max_cpus = 1;
> > +    /* MAX number of vcpus supported by Xen.  */
> > +    mc->max_cpus = GUEST_MAX_VCPUS;
> 
> Will this cause allocations of data structures with 128 elements?
> Looking at hw/xen/xen-hvm-common.c:xen_do_ioreq_register it seems
> possible? Or hw/xen/xen-hvm-common.c:xen_do_ioreq_register is called

Yes, in theory there's probably overhead with this but as you correctly
noted below, a PVH aware xl will set the max_cpus option to a lower value.

With a non-pvh aware xl, I was a little worried about the overhead
but I couldn't see any visible slow-down on ARM neither in boot or in network
performance (I didn't run very sophisticated benchmarks).


> later on with the precise vCPU value which should be provided to QEMU
> via the -smp command line option
> (tools/libs/light/libxl_dm.c:libxl__build_device_model_args_new)?

Yes, a pvh aware xl will for example pass -smp 2,maxcpus=4 based on
values from the xl.cfg. If the user doesn't set maxvcpus in xl.cfg, xl
will set maxvcpus to the same value as vcpus.

Best regards,
Edgar

