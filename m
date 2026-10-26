Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XGrcIEuZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLQ5y-0006wR-OD; Mon, 26 Oct 2026 15:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLQ5f-0006pe-I7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 15:10:39 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLQ5b-0002Ny-Ol
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 15:10:38 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ab395abf79so29896077b3.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 12:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793041834; cv=none;
 d=google.com; s=arc-20260327;
 b=hh5+dlMjRQJiSLmTMobnaDgxp4cKc4X47HyAm2UiqnQZfUmJQ5QZrhjEsSKkhULVQL
 PPPs9Y9A/Q5qDw/S+JQeZylJhvOMPQmM/j7bXmKOR9ow4Z+h4YT9wOeo3GU3rCbTrnKY
 TpXTcjlk8uSdqm/ZUavB5w2/e74VZOLAPuPrMIy6a542Y1Fu4h4QZyFZi3mNdqFi0SKg
 pJtWjAoE+p/lVU5EIrK11IVkA3mlQHhyNKiUZbBNfhzT4kYQXow0AiVlZX3++P7ijiT3
 cQ0Qc2B28H2kAreg2+spZAS7oH+hNJuiB2O0Bb3ieVKSteb7lekIrXB/R93VeESAplu3
 3VDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yROP98eLJ5aaqcG9PSVaLm1ZeSN4EnTW9HQtVDEs/Mg=;
 fh=Zz5jHKBISnkS4wrX92XSr8YpffgIXEGIECltbGgHypQ=;
 b=UYROHmmQymF5nIG39wagvls7iTJE6LRJXp2g8+LCpmWgaGOqzXeJjtx/HB/dfqESkX
 Zm2biH+GIZ+7kXsxiFw3ICmkAy4igFiMkobfhF3KQpbaujwktmBuoP0XoHsfLhQzQy7I
 JSUxniZ0jW0xV65KIKTj9wDG4wf6zTQ/hSo4hu9os3awNqaEa0iJptdMJkL25ELVkd6I
 nXak245KhRHvh4Z+lj0U60w/uMvrt5LoRXxRWqSPxwSID9jkNr6AXxIfyLxAGUu6QxKn
 PqoCh1VKtpJ1IvlAoa9Hahu8GaLti21jDmeG7LrSzYBEVmQL6kSZAtyLzAx9baSLxz2p
 iLaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793041834; x=1793646634; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yROP98eLJ5aaqcG9PSVaLm1ZeSN4EnTW9HQtVDEs/Mg=;
 b=XGrcIEuZmj0GP8g2jz03d6Z/+7zllVgqgd/UaDBt/iPvga/yNjY1Zl78KQiEId+N+8
 a05RP1kc7nQjmiUMMJY2/E/6Rxi1LiLvtd4YtXQPE33KQjYWlsmFabzCXkkDdw8V25qH
 h2AoRI4KnCRqtsAk4pFlCYVclIXAUTsnV0iAoqLFrDEaLf768+qa5sS+uOJYJKrnT0SQ
 OW2v8Y3p6J5+TuD4qwfouZPC0hQoAg2qtBZL/OPh5QAvkYabq2WMnjxGzrx5q8r6VJyK
 +vBCAPWT8+jVTkOWTTHiExj1diqhGo+xivoAna5szKlT+vE2mC9TJvAmlmL73Xwgeg4s
 01KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041834; x=1793646634;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yROP98eLJ5aaqcG9PSVaLm1ZeSN4EnTW9HQtVDEs/Mg=;
 b=UMYeD1nKG/4ZiByQ9o4YYzhGbFb8s+Wy8Fhgfff7Dy9PWNLB20gavDM5KG4Xwwc4pu
 GdUjnKgW/6TuEFN13yfdrmog+tzG/OCApz2EdAFzPwHp9uSjx4qKmpHwSfzZpxVa9tHb
 HxrLhwXcCxfye+tLnjV83P8LIiwbOiNu96COGfLapVX/JZzVbY2x7Peuem5nolNtCu0Y
 OweE86zorC1rYVPILB+sjJSU1Q+SDf2eBGhX7kk+1us4F1vdHTZdOkhCLKXTC6i6R3wL
 Yw6qUKpi0RO8uTKPcksYKbBcgzeobw8Z+dCZedDL9WYlEDOnspOQa5YHzxuhc0+Xl/8l
 XrqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxn+o9iUzqr7UoJ4erVOeCdsAAt0Erv0gNb3ddQAMZRTir6qb5LuoqNeN/IDjU9YW8IokK00mI41D0@nongnu.org
X-Gm-Message-State: AFq9FYIesc2eOjp3L/nmM6D+Lnk1OkeEPSfT9BrZlJMegPnMLAJ3S8Jx
 H1LHb1KNHjUqJxkKr1pdG0xl9TyGzXz3fWzeJd9kPu25cwI7AS8Uw+kt3hhzXR8vgis4rSDnRgY
 JskdV4yiwJHd+ZMIf5UsW9I2oU4rj05Fqx/jc2dVHUQ==
X-Gm-Gg: AYBFou0IYN0MryW6STPVT/q9Izk7BAk3ZugnXyuAA5ue9Ep7F3fZBqesOyfWeK4cH/g
 q7mbbKKJqHXozP8rn+lp+eJ8WBx72UEH+4MLpwL0x/jteEvv0ZGXoJD5ZZAQI12MrGii4/lmQBn
 uRPfZ1LSmmwBoMB5Kgse4/Cwo0Z4mugtcdw7q5JMwbw0jbnvtx5yyiDzbgalXiwLjEvzBkTkxnu
 m/kuynYi/YeLrcGtxVtBfo8ndpiAEZw33oTrAttmsHGh6qVOWGlHBT9oBhCwssCLuq2BoXJjsgf
 GhqdAn/4XAtUEJw+FgtLpanevyqtqEJ8kgH+juDMpDrpGWUjhlzcUQ6Zhrkk79v/RlGH8MpVsI0
 Zoo4/hU7IBZzoh/mz5iANtuoGNmSfHkEOK2QUXfRWySuEmjavOURpg2y/66xxQnCj7infoM73rE
 fOk9FkCXuHGiWWbjgw5q9a
X-Received: by 2002:a05:690c:60c1:b0:8ac:927:f7c9 with SMTP id
 00721157ae682-8b166c1ae39mr64856817b3.26.1793041834003; Mon, 26 Oct 2026
 12:10:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA_1ESA4Uan=gJyiRrjj4-EVvtfgn2dUT8qDa8zUU_gf=g@mail.gmail.com>
 <20261026121828-mutt-send-email-mst@kernel.org>
 <at-QMTmel_ZAWLPa@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <at-QMTmel_ZAWLPa@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 19:10:21 +0000
X-Gm-Features: AclHuK8i-Hk9KCFelqoOwXz7posqDS_sm927n2R3hwDiqmsICoLwoEI6STL_BN0
Message-ID: <CAFEAcA8WxxFBfUc+TJa33aouEbFtpMkCVk_auuwWk3EKyB7V2g@mail.gmail.com>
Subject: Re: migration, PCIE ports, and parent_obj.parent_obj.parent_obj
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 17:39, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 26, 2026 at 12:19:07PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Oct 26, 2026 at 04:11:57PM +0000, Peter Maydell wrote:
> > > In reviewing a new pcie host bridge, I noticed (because this new device
> > > copied existing code) that the vmstate structs for pcie root ports do
> > > this in their vmstate structs:
> > >
> > >     .fields = (const VMStateField[]) {
> > >         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > >         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
> > >                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> > >         VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
> > >                      GenPCIERootPort),
> > >         VMSTATE_END_OF_LIST()
> > >     }
> > >
> > > (this specific example is hw/pci-bridge/gen_pcie_root_port.c).
> > >
> > > Devices shouldn't have to have ugly long chains of "parent_obj"
> > > like this and shouldn't have to care what in their parents needs
> > > migration; compare e.g. SCSI devices, which start with a
> > > "VMSTATE_SCSI_DEVICE" that captures all the parent class's needs,
> > > followed by only the state that the child added.
> > >
> > > How can we get to something more like that for PCIE port classes?
> > >
> > > thanks
> > > -- PMM
> >
> > Yea makes total sense. Anyone has the bandwidth to take a stab?
> > I'm buried under a pile of ai generated security reports.
>
> /me buried too on other things downstream.  I'm prepared to not be able to
> work much upstream until after forum..
>
> A quick look is this is not too bad yet:
>
> $ git grep parent_obj.parent_obj | wc -l
> 20
> $ git grep parent_obj.parent_obj.parent_obj | wc -l
> 11
> (and, some of above lines are part of vm static checker script)
>
> Looks not too bad yet?

Depends on your definition of "bad" :-)  This is basically
the only vmstate that's doing this thing, and it would be
nice to correct it before we add more devices that end up
following the same pattern.

I agree it's not super urgent; I posted mostly because I have
no idea what the right fix is (especially given we want to
retain migration compat here).

thanks
-- PMM

