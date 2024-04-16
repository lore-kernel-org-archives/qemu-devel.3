Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CC3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 08:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rweO9-0000Ku-Oh; Tue, 16 Apr 2024 04:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rweO8-0000Kk-6c
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rweO6-0001DL-6R
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713256916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rcd5rk3eb6LpzS92atXmdCYUCC//fUXzUaCNdNvBQvw=;
 b=g6DGkb5H5s36J4uxX91gCSBSPl0i8L5HzR2vXxfACwzdaAwR38WGid5Nazcq2u0NFP90Nw
 PI0AspZq1la5hnoETMJSjP51fzDblaQFKOhhDBTZRsD6gV9uB96IM/9AOCrx0NCOeTZP/U
 F9Ksnci1T2tLbWJg+90pajCh1rG8YJg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-8jmd86Y2OIKWf4WKFOn-Ow-1; Tue, 16 Apr 2024 04:41:53 -0400
X-MC-Unique: 8jmd86Y2OIKWf4WKFOn-Ow-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-61ac7b815e5so32554217b3.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 01:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713256913; x=1713861713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rcd5rk3eb6LpzS92atXmdCYUCC//fUXzUaCNdNvBQvw=;
 b=kcQnQlnStbfx4ndWX/5E098TwBXwnRRd5KXzgm5D6QwZ+nItFYYyZnRyZttRAbeGjD
 kqXRLSjLA9UiwjageE9UiMsPHsbvXXArDluxgu42WRuZ7/KT3Oxi0dfARxCValcXWFyl
 G3BO6Am38i6++cLCCT/hWLpuY1BgcWXKMhGVmhDKbGkUeZZd5kMW4WRqe8f9khU8ESvn
 opX9Tx4h5tRd5pr3m1TiP0lgxf/5zb4zLeGapRndAVsW03EFh7AQTiNa1gq67QfIeaPX
 1tVgYsa84DfgGSCWB05fbNSNabcv9Q7BqHwh9ENVYW1J759o558TNG9fbH+V0s+yX9rZ
 nW7w==
X-Gm-Message-State: AOJu0YzKjB+7aimA1gaOUeXbgS3O18XYBGcb1kC3ju6RSnJiE2tMgrlA
 O4Ob2bX4LjW/hOqMjDavh5J+MmfmYZoSo2UDYRCJ3YbO98cVdRQBXcqA8AmNbP8HqP4DlEszhb8
 ssaojNbtMCuFJamkDL/ApFBErmYiNBtLj09OOAZTccP/QDBkmUL6rZI90n27z8K7ZOSK/cwRoDL
 e6ixmwGG2kh+ZGhEH85QN/gxWDZtg=
X-Received: by 2002:a25:918a:0:b0:dc6:9c51:760f with SMTP id
 w10-20020a25918a000000b00dc69c51760fmr10972999ybl.56.1713256913362; 
 Tue, 16 Apr 2024 01:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbmrTq10wucYZMSQxcObpjYefVoDuu0XDPtkntI8tQDYvKU2ehHkCRKuFM5PLG5dEq2kKueVAl00t6oRGYpTI=
X-Received: by 2002:a25:918a:0:b0:dc6:9c51:760f with SMTP id
 w10-20020a25918a000000b00dc69c51760fmr10972989ybl.56.1713256913078; Tue, 16
 Apr 2024 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun> <2192541.Mh6RI2rZIc@valdaarhun>
 <CAJaqyWcxK6i6iYiktPhq59gg0G8YzkD0X+Ji0XbOVgK0E1Hdwg@mail.gmail.com>
 <5933234.MhkbZ0Pkbq@valdaarhun>
In-Reply-To: <5933234.MhkbZ0Pkbq@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Apr 2024 10:41:16 +0200
Message-ID: <CAJaqyWdD7futYvUFt7=zV1xsoBdyAET6mvneOOjR2oob2U1-qg@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On Mon, Apr 15, 2024 at 9:42=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> Thank you for your reply.
>
> On Monday, April 15, 2024 2:27:36=E2=80=AFPM IST Eugenio Perez Martin wro=
te:
> > [...]
> > > I have one question though. One of the options (use case 1 in [1])
> > >
> > > given to the "qemu-kvm" command is:
> > > > -device virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpcie.0,addr=3D0x7=
\
> > > > ,disable-modern=3Doff,page-per-vq=3Don
> > >
> > > This gives an error:
> > > > Bus "pcie.0" not found
> > >
> > > Does pcie refer to PCI Express? Changing this to pci.0 works.
> >
> > Yes, you don't need to mess with pcie stuff so this solution is
> > totally valid. I think we need to change that part in the tutorial.
> >
>
> Understood.
>
> > > I read through the "device buses" section in QEMU's user
> > > documentation [5], but I have still not understood this.
> > >
> > > "ls /sys/bus/pci/devices/* | grep vdpa" does not give any results.
> > > Replacing pci with pci_express doesn't give any results either. How
> > > does one know which pci bus the vdpa device is connected to?
> > > I have gone through the "vDPA bus drivers" section of the "vDPA
> > > kernel framework" article [6] but I haven't managed to find an
> > > answer yet. Am I missing something here?
> >
> > You cannot see the vDPA device from the guest. From the guest POV is a
> > regular virtio over PCI bus.
> >
> > From the host, vdpa_sim is not a PCI device either, so you cannot see
> > under /sys/bus. Do you have a vdpa* entry under
> > /sys/bus/vdpa/devices/?
> >
>
> After re-reading the linked articles, I think I have got some more
> clarity. One confusion was related to the difference between vdpa
> and vhost-vdpa.
>
> So far what I have understood is that L0 acts as the host and L1
> acts as the guest in this setup. I understand that the guest can't
> see the vDPA device.
>
> I now also understand that vdpa_sim is not a PCI device. I am also
> under the impression that vdpa refers to the vdpa bus while
> vhost-vdpa is the device. Is my understanding correct?
>
> After running the commands in the blog [1], I see that there's a
> vhost-vdpa-0 device under /dev.
>
> I also have an entry "vdpa0" under /sys/bus/vdpa/devices/ which
> is a symlink to /sys/devices/vdpa0. There's a dir "vhost-vdpa-0"
> under "/sys/devices/vdpa0". Hypothetically, if vhost-vdpa-0 had
> been a PCI device, then it would have been present under
> /sys/bus/pci/devices, right?
>

Right. You'll check that scenario with the vp_vdpa one.

> Another source of confusion was the pci.0 option passed to the
> qemu-kvm command. But I have understood this as well now:
> "-device virtio-net-pci" is a pci device.
>
> > > There's one more thing. In "use case 1" of "Running traffic with
> > > vhost_vdpa in Guest" [1], running "modprobe pktgen" in the L1 VM
> > >
> > > gives an error:
> > > > module pktgen couldn't be found in /lib/modules/6.5.6-300.fc39.x86_=
64.
> > >
> > > The kernel version is 6.5.6-300.fc39.x86_64. I haven't tried building
> > > pktgen manually in L1. I'll try that and will check if vdpa_sim works
> > > as expected after that.
> >
> > Did you install kernel-modules-internal?
>
> I just realized I had the wrong version of kernel-modules-internal
> installed. It works after installing the right version.
>

Good! So you can move to vp_vdpa, or do you have more doubts about vdpa_sim=
?

Thanks!


