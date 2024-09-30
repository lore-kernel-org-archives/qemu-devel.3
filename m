Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D664ACF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 05:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv93O-0006JT-3a; Mon, 30 Sep 2024 01:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sv93M-0006Iw-DV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 01:34:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sv93K-0000V8-KR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 01:34:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71c5e1ad01cso1597616b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727674473; x=1728279273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWVQCXh46X6Dm+jfJZs4Wpdvcs3Rp3HzhsNj+Bf4UrY=;
 b=maucThfoj0IG5GjzLpTxJ5nErbBuGddkcH5pSU7HOD3cqV6J/sC6Lu0XdRoyU3JBcc
 dy6Mdox3Ax9eu1qaoDnxiwqDvVRBHwy3FqYLVa9VigjU5wqQtLiPFqVND5Z7NkCLIjEB
 ZbqDEm2vubez96RJM02q/aUXK67EC/Xd/15DUsYOZp+Z3U7Z7reW1dZQ0u+arS24gvDl
 x3gj9d+fGmv0SVwqmrerPk1vW7ohWYwE5u7JSv07Rxm42ta4GQSlJ/yBKNpmcMA2/cp+
 JEhnwjAko2sDTegR7FCKQsvroiJa28JibRHihVqqyXFn1uSEtak2u5WLTVtKqGA2+T86
 g63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727674473; x=1728279273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWVQCXh46X6Dm+jfJZs4Wpdvcs3Rp3HzhsNj+Bf4UrY=;
 b=Jf262Tr5etGOf9VbMnxuEMe6g2DO02hFq27NgaqnGqVmh/5x8txqOA5jWEgDrLU8g8
 +5JFuYbAwmwAzWqzv0001wLr1QA6gkO8golKQE3qJxdWd5q/i6l3AU8SupAlHpRGsyyS
 5/tSkVeJRskFgCVv/vO563AjVJOq5/BmpwhX1vBHjhTdriZ42ya/M8UbO78KWiC3Ne3r
 UPpUXLFjYzJB5Yt5Zsb5tnT1s9tRzqeeQqBT12gzxtR8+AhaQzS1Fu0/8sREWksxtpF7
 S8pjNtj/xjkqJdVPJYHH0zrmELL/AlfE5GDtrX7d7ZJx8f/vDQsNPFuzuaFFum5dtnO4
 v2Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhI7QcvOGHoy97k9uQjC+g4K8dFNoysmfZhj9rvHjZGL66ucF5rze1XAvAtTnQvtNA50EbfdR0wLgf@nongnu.org
X-Gm-Message-State: AOJu0YzfrH+U6FJXFLm3wikH2+q/aC4QyN3LIGwBDg2MrMOP8bww7tMn
 CKX8xD8GPyd/OKS9jch+05g7vlNdSlO0MnuIjPhBl58hyIEKjUdJ
X-Google-Smtp-Source: AGHT+IG3HX8IDwXWP6RcC1Z2X9dlv8iTFPlBlzTe+lZYnVqjtX1NO6wBpNX2h2uPwGcgOCl8FuzNWw==
X-Received: by 2002:a05:6a00:2da9:b0:712:7512:add9 with SMTP id
 d2e1a72fcca58-71b260680ebmr15791820b3a.13.1727674472501; 
 Sun, 29 Sep 2024 22:34:32 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.85.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b264bc3f7sm5448048b3a.77.2024.09.29.22.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 22:34:31 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Mon, 30 Sep 2024 11:04:28 +0530
Message-ID: <1904291.tdWV9SEqCh@valdaarhun>
In-Reply-To: <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Tuesday, September 24, 2024 4:16:26=E2=80=AFPM GMT+5:30 Eugenio Perez Ma=
rtin wrote:
> On Tue, Sep 24, 2024 at 7:31=E2=80=AFAM Sahil <icegambit91@gmail.com> wro=
te:
> > Hi,
> >=20
> > I have a small update.
> >=20
> > On Monday, September 16, 2024 10:04:28=E2=80=AFAM GMT+5:30 Sahil wrote:
> > > On Thursday, September 12, 2024 3:24:27=E2=80=AFPM GMT+5:30 Eugenio P=
erez Martin
> > > wrote: [...]
> > >=20
> > > > The function that gets the features from vhost-vdpa in QEMU is
> > > > hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features. Can you check that =
it
> > > > returns bit 34 (offset starts with 0 here)? If it returns it, can y=
ou
> > > > keep debugging until you see what clears it?
> > > >=20
> > > > If it comes clear, then we need to check the kernel.
> > >=20
> > > Got it. I'll start debugging from here.
> >=20
> > I am printing the value of "*features & (1ULL << 34)" in
> > hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features and I see it is 1.
> > I guess that means the vhost device has the packed feature bit
> > turned on in L1.
>=20
> Not quite. That means the device exports the _F_PACKED feature bit.
> Now we need to check if the guest acks it. You can look to
> vhost_vdpa_set_features for that.

Thank you for your reply. I have understood this now. I realized that the
guest was not acking the packed feature bit.

> > I am also printing out the values of "host_features", "guest_features"
> > and "backend_features" set in "VirtIODevice vdev" in
> > hw/virtio/virtio-pci.c:virtio_pci_common_read under "case
> > VIRTIO_PCI_COMMON_DF". I observed the following values:
> >=20
> > dev name: virtio-net
> > host features: 0x10150bfffa7
> > guest features: 0x0
> > backend features: 0x10150bfffa7
> >=20
> > The host features and backend features match but guest features
> > is 0. Is this because the value of guest features has not been set yet
> > or is it because the driver hasn't selected any of the features?
> >=20
> > I am not entirely sure but I think it's the former considering that the
> > value of /sys/devices/pci0000:00/0000:00:07.0/virtio1/features is
> > 0x10110afffa7. Please let me know if I am wrong.
>=20
> Right, it's the former. _DF is the guest selecting on what 32-bit half
> of the 64-bit features willread.
>=20
> You can check the virtio_pci_common_write function,
> VIRTIO_PCI_COMMON_GF case when proxy->gfselect =3D=3D 1. But it should end
> in vhost_vdpa_set_features when the driver writes DRIVER_OK, so maybe
> that one is easier.
>=20
> > I found a few other issues as well. When I shut down the L2 VM,
> > I get the following errors just after shutdown:
> >=20
> > qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Operation not
> > permitted (1) qemu-system-x86_64: vhost VQ 1 ring restore failed: -1:
> > Operation not permitted (1) qemu-system-x86_64: vhost VQ 2 ring restore
> > failed: -1: Operation not permitted (1)
> >=20
> > This is printed in hw/virtio/vhost.c:vhost_virtqueue_stop. According to
> > the comments, this is because the connection to the backend is broken.
>=20
> Can you trace vhost_vdpa_get_vring_base to be sure? In particular, if
> dev->fd is valid.
>
> > I booted L1 by running:
> >=20
> > $ ./qemu/build/qemu-system-x86_64 -enable-kvm \
> > -drive
> > file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddisk,if=
=3Dvirtio
> > -net nic,model=3Dvirtio -net user,hostfwd=3Dtcp::2222-:22 \ -device
> > intel-iommu,snoop-control=3Don \
> > -device
> > virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=3Doff,i=
ommu_pla
> > tform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x4 \ -netdev
> > tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> > -nographic \
> > -m 8G \
> > -smp 4 \
> > -M q35 \
> > -cpu host 2>&1 | tee vm.log
> >=20
> > And I booted L2 by running:
> >=20
> > # ./qemu/build/qemu-system-x86_64 \
> > -nographic \
> > -m 4G \
> > -enable-kvm \
> > -M q35 \
> > -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
 \
> > -device
> > virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-modern=
=3Doff,ev
> > ent_idx=3Doff,bus=3Dpcie.0,addr=3D0x7 \ -smp 4 \
> > -cpu host \
> > 2>&1 | tee vm.log
> >=20
> > Am I missing something here?
> >=20
> > When booting L2, I also noticed that the control flow does not enter the
> > following "if" block in hw/virtio/vhost-vdpa.c:vhost_vdpa_init.
> >=20
> > if (dev->migration_blocker =3D=3D NULL && !v->shadow_vqs_enabled) {
> >=20
> >         ...
> >         vhost_svq_valid_features(features, &dev->migration_blocker);
> >=20
> > }
> >=20
> > So "vhost_svq_valid_features" is never called. According to the comments
> > this is because the device was not started with x-svq=3Don. Could this =
be a
> > result (or reason) of the broken connection to the backend? Is there a =
way
> > to manually set this option?
>=20
> Yes, you can set it in -netdev vhost-vdpa,x-svq=3Don.

I haven't checked that dev->fd is valid yet. I started debugging with
the x-svq=3Don option, and I realized I was booting the L2 VM without
setting packed=3Don.

On Tue, Sep 24, 2024 at 7:31=E2=80=AFAM Sahil <icegambit91@gmail.com> wrote:
> And I booted L2 by running:
>=20
> # ./qemu/build/qemu-system-x86_64 \
> -nographic \
> -m 4G \
> -enable-kvm \
> -M q35 \
> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,event_idx=3Doff,bus=3Dpcie.0,addr=3D0x7 \
> -smp 4 \
> -cpu host \
> 2>&1 | tee vm.log
>

With packed=3Don in the device option, I see that the packed feature bit is
set in L2 :)

However, I see that vhost shadow virtqueues are still not being used. I am
currently trying to find the reason behind this. I have narrowed down the
issue to hw/virtio/vhost-vdpa.c [1]. The "vhost_vdpa_svqs_start" function
is being called but in the loop, vhost_svq_start is never called. I think it
might be because there's an issue with "vhost_vdpa_svq_setup".

I'll send an update once I find something.

Thanks,
Sahil

[1] https://github.com/qemu/qemu/blob/master/hw/virtio/vhost-vdpa.c#L1243



