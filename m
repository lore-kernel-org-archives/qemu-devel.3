Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D5C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgBB-0005zF-BA; Thu, 30 May 2024 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCgB9-0005yv-Cl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCgB6-0006eE-TA
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717077046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KzmLvZJURA5ulAf7+lvrCTlU7WpUECr48EX3yYAWqk=;
 b=c1qShyiiiSIpfcprcIyyUTpqXtd3eOkAOHj70sK1F7i0f+2P3d/WCJ4sts8GuyN4BcH+fy
 Cgh9z+wtrTBD60ts6/B4TWmlWP65m5WgwKFT9JDlu4GlbNKCk57a3wj/OUEGqWlPguIXCK
 ygq1mlcQfKoHTrJEz7eR+X0kjDmYYyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-E01HRIZ3NVmv09F5fAIyhA-1; Thu, 30 May 2024 09:50:44 -0400
X-MC-Unique: E01HRIZ3NVmv09F5fAIyhA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-358f9dffbedso486325f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717077044; x=1717681844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KzmLvZJURA5ulAf7+lvrCTlU7WpUECr48EX3yYAWqk=;
 b=j3fp9KGaVrWEcAcy+xapBOIIR4s24Re5drUMcEZZLbraxjV6jgyqTXtXahH1I4lRsR
 H6mo7BVhCp71nGyPPeQ8aLFVwKfzvlwwkMO3Fn+yH8Y3TbALnD7XEj9kqe7uAbhP3M+l
 RC+Ep8ua9jFRyKOud4iDZhsl9tI8gO6XtVJrVtFa3sHYAwrWc5MvClxkv6MoZ+PkoDZ2
 xvqUHT9eLVOdBdVDAShm3vRhBK+KaPaHC9bEdteS8c8UFNnqM+xbwnhhAMdCeN+NY46A
 IMHFX6o5qUTe6fEuRuGuPYcnwiZp/+srObkmp0aPLgOCqppqP+bkdyWZd6svxDYQjd5Y
 PqCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZmEgjJ6QohLx4k5jPwQQiI8JYBjiyHqRX1owDhn/j6AmWiCdZPwMKhkgqncM6B6WemyrNRKCEcViNTtuwXj9cmhWziS4=
X-Gm-Message-State: AOJu0Yx9uIDHtXBf5u2fzGjwTP9YaHl7aXHrH5I6yHj/OuE9N7TBRUsq
 Y0WBT5dIJ7SZ6QkUCubL9VP9iFcT1k9yPdqXkhddX8fPKBn++ciFce6YAi76latkRnPuiYI6BjI
 HwzlbmkTQKx+hoUcAJX9LGDgqSY1KroLZ/l27Qpn5vgQltB9StY2A
X-Received: by 2002:adf:ec02:0:b0:354:fa7d:dcfe with SMTP id
 ffacd0b85a97d-35dc00923e6mr2423553f8f.23.1717077043639; 
 Thu, 30 May 2024 06:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7HMkTZS5xraw/KfIdVaU8iPObbCPP39OCkVskykdDtKI7LiquKyl9HOjz63SrTiYCIdP3A==
X-Received: by 2002:adf:ec02:0:b0:354:fa7d:dcfe with SMTP id
 ffacd0b85a97d-35dc00923e6mr2423528f8f.23.1717077043181; 
 Thu, 30 May 2024 06:50:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35588c707ccsm17482913f8f.117.2024.05.30.06.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 06:50:42 -0700 (PDT)
Date: Thu, 30 May 2024 15:50:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, Andrea Righi
 <andrea.righi@canonical.com>
Subject: Re: [PATCH] hw/i386/acpi-build: Return a pre-computed _PRT table
Message-ID: <20240530155041.563678d2@imammedo.users.ipa.redhat.com>
In-Reply-To: <CANiDSCv=2roABFXP9=BURxU_qvJrTPJaU5Zm=YrFzcyoVRp4Yw@mail.gmail.com>
References: <20240417135608.2613586-1-ribalda@chromium.org>
 <CANiDSCv=2roABFXP9=BURxU_qvJrTPJaU5Zm=YrFzcyoVRp4Yw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Fri, 3 May 2024 11:09:47 +0200
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Friendly ping
> 
> On Wed, 17 Apr 2024 at 15:56, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > When qemu runs without kvm acceleration the ACPI executions take a great
> > amount of time. If they take more than the default time (30sec), the
> > ACPI calls fail and the system might not behave correctly.
> >
> > Now the _PRT table is computed on the fly. We can drastically reduce the
> > execution of the _PRT method if we return a pre-computed table.

It's heavily depends on used hw or resources if it's running inside VM,
one can always find a slow enough environment where above stated limit
will not be sufficient regardless of what QEMU does.
Correct approach would be to fix guest OS timeout issue so it won't
timeout if there is a progress.

As for the patch, question is what DSDT size difference is between
static _PRT version and the current dynamic one?
(if it shrinks _PRT, I'm all for it)

Also see tests/qtest/bios-tables-test.c
In the top of process to follow when one touches ACPI tables
to avoid breaking tests. 



> > Without this patch:
> > [   51.343484] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   51.527032] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   51.530049] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> > [   51.530797] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > [   81.922901] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   82.103534] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   82.106088] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> > [   82.106761] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> > [  112.192568] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [  112.486687] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [  112.489554] virtio-pci 0000:00:05.0: can't derive routing for PCI INT A
> > [  112.490027] virtio-pci 0000:00:05.0: PCI INT A: no GSI
> > [  142.559448] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [  142.718596] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [  142.722889] virtio-pci 0000:00:06.0: can't derive routing for PCI INT A
> > [  142.724578] virtio-pci 0000:00:06.0: PCI INT A: no GSI
> >
> > With this patch:
> > [   22.938076] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> > [   24.214002] ACPI: \_SB_.LNKD: Enabled at IRQ 11
> > [   25.465170] ACPI: \_SB_.LNKA: Enabled at IRQ 10
> > [   27.944920] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> >
> > ACPI disassembly:
> >         Scope (PCI0)
> >         {
> >             Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
> >             {
> >                 Return (Package (0x80)
> >                 {
> >                     Package (0x04)
> >                     {
> >                         0xFFFF,
> >                         Zero,
> >                         LNKD,
> >                         Zero
> >                     },
> >
> >                     Package (0x04)
> >                     {
> >                         0xFFFF,
> >                         One,
> >                         LNKA,
> >                         Zero
> >                     },
> >
> >                     Package (0x04)
> >                     {
> >                         0xFFFF,
> >                         0x02,
> >                         LNKB,
> >                         Zero
> >                     },
> >
> >                     Package (0x04)
> >                     {
> >                         0xFFFF,
> >                         0x03,
> >                         LNKC,
> >                         Zero
> >                     },
> >
> >                     Package (0x04)
> >                     {
> >                         0x0001FFFF,
> >                         Zero,
> >                         LNKS,
> >                         Zero
> >                     },
> > Context: https://lore.kernel.org/virtualization/20240417145544.38d7b482@imammedo.users.ipa.redhat.com/T/#t
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  hw/i386/acpi-build.c | 118 ++++++++-----------------------------------
> >  1 file changed, 21 insertions(+), 97 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 53f804ac16..4c14d39173 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -725,40 +725,7 @@ static Aml *aml_pci_pdsm(void)
> >      return method;
> >  }
> >
> > -/**
> > - * build_prt_entry:
> > - * @link_name: link name for PCI route entry
> > - *
> > - * build AML package containing a PCI route entry for @link_name
> > - */
> > -static Aml *build_prt_entry(const char *link_name)
> > -{
> > -    Aml *a_zero = aml_int(0);
> > -    Aml *pkg = aml_package(4);
> > -    aml_append(pkg, a_zero);
> > -    aml_append(pkg, a_zero);
> > -    aml_append(pkg, aml_name("%s", link_name));
> > -    aml_append(pkg, a_zero);
> > -    return pkg;
> > -}
> > -
> > -/*
> > - * initialize_route - Initialize the interrupt routing rule
> > - * through a specific LINK:
> > - *  if (lnk_idx == idx)
> > - *      route using link 'link_name'
> > - */
> > -static Aml *initialize_route(Aml *route, const char *link_name,
> > -                             Aml *lnk_idx, int idx)
> > -{
> > -    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
> > -    Aml *pkg = build_prt_entry(link_name);
> > -
> > -    aml_append(if_ctx, aml_store(pkg, route));
> > -
> > -    return if_ctx;
> > -}
> > -
> > +#define N_ROUTES 128
> >  /*
> >   * build_prt - Define interrupt rounting rules
> >   *
> > @@ -771,74 +738,31 @@ static Aml *initialize_route(Aml *route, const char *link_name,
> >   */
> >  static Aml *build_prt(bool is_pci0_prt)
> >  {
> > -    Aml *method, *while_ctx, *pin, *res;
> > +    Aml *rt_pkg, *method;
> > +    const char link_name[][2] = {"D", "A", "B", "C"};
> > +    int i;
> >
> >      method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
> > -    res = aml_local(0);
> > -    pin = aml_local(1);
> > -    aml_append(method, aml_store(aml_package(128), res));
> > -    aml_append(method, aml_store(aml_int(0), pin));
> > +    rt_pkg = aml_varpackage(N_ROUTES);
> >
> > -    /* while (pin < 128) */
> > -    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
> > -    {
> > -        Aml *slot = aml_local(2);
> > -        Aml *lnk_idx = aml_local(3);
> > -        Aml *route = aml_local(4);
> > -
> > -        /* slot = pin >> 2 */
> > -        aml_append(while_ctx,
> > -                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
> > -        /* lnk_idx = (slot + pin) & 3 */
> > -        aml_append(while_ctx,
> > -            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
> > -                      lnk_idx));
> > -
> > -        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
> > -        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
> > -        if (is_pci0_prt) {
> > -            Aml *if_device_1, *if_pin_4, *else_pin_4;
> > -
> > -            /* device 1 is the power-management device, needs SCI */
> > -            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
> > -            {
> > -                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
> > -                {
> > -                    aml_append(if_pin_4,
> > -                        aml_store(build_prt_entry("LNKS"), route));
> > -                }
> > -                aml_append(if_device_1, if_pin_4);
> > -                else_pin_4 = aml_else();
> > -                {
> > -                    aml_append(else_pin_4,
> > -                        aml_store(build_prt_entry("LNKA"), route));
> > -                }
> > -                aml_append(if_device_1, else_pin_4);
> > -            }
> > -            aml_append(while_ctx, if_device_1);
> > -        } else {
> > -            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
> > +    for (i = 0; i < N_ROUTES; i++) {
> > +        Aml *pkg = aml_package(4);
> > +        const char *name;
> > +
> > +        name = link_name[((i >> 2) + i) & 3];
> > +
> > +        if (is_pci0_prt && i == 4) {
> > +            name = "S";
> >          }
> > -        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
> > -        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
> > -
> > -        /* route[0] = 0x[slot]FFFF */
> > -        aml_append(while_ctx,
> > -            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
> > -                             NULL),
> > -                      aml_index(route, aml_int(0))));
> > -        /* route[1] = pin & 3 */
> > -        aml_append(while_ctx,
> > -            aml_store(aml_and(pin, aml_int(3), NULL),
> > -                      aml_index(route, aml_int(1))));
> > -        /* res[pin] = route */
> > -        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
> > -        /* pin++ */
> > -        aml_append(while_ctx, aml_increment(pin));
> > +
> > +        aml_append(pkg, aml_int((i << 14) | 0xFFFF));
> > +        aml_append(pkg, aml_int(i & 3));
> > +        aml_append(pkg, aml_name("LNK%s", name));
> > +        aml_append(pkg, aml_int(0));
> > +        aml_append(rt_pkg, pkg);
> >      }
> > -    aml_append(method, while_ctx);
> > -    /* return res*/
> > -    aml_append(method, aml_return(res));
> > +
> > +    aml_append(method, aml_return(rt_pkg));
> >
> >      return method;
> >  }
> > --
> > 2.44.0.683.g7961c838ac-goog
> >  
> 
> 


