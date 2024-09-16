Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6011EC3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 04:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq3Rg-0004vm-7T; Mon, 16 Sep 2024 00:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sq3Re-0004ul-EA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 00:34:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sq3Rc-0003KC-1w
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 00:34:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2059112f0a7so24032875ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 21:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726461273; x=1727066073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4ZXusV6ohOgWgcsq83BanCGkPxXShZC3EHhMYs5dZQ=;
 b=clAo7VVrGs3QaNDXy+icZaWuUzxgCd6vjiozPzyLMiFSv/n8Vym/AIfsV1BWtlcNqk
 /AA9yaZsFD9KS77ZxZ6wjnMAVpGCy2SnvOucy53hmDNe7TjuUIJZrd9AMc3aTqJWm8KQ
 7D+EnE/sPu6/nYxoARvbXqstzi0GR2WBJMEWNJJiYRrKsWahGfE0JvFNSZNffgI+cCJM
 2bsSlfyc+++XUW/cuRYo/B6EnIQPF5lcvCy3syOTzvaff4/+6tqXnj2A4aLzl+Txj13M
 Bf62QKaFA5mLbwt4qcK8xKSJzH5iObeyTFLYUZUYig6tpwM+/bx2LZvbiO4v8QLM4lTB
 D+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726461273; x=1727066073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4ZXusV6ohOgWgcsq83BanCGkPxXShZC3EHhMYs5dZQ=;
 b=AVz12pZqG36Ty5egeKmbUfNGv2WxN/r5ufi2vfSzLhpAoNSWm1GEWVI9YbeunOONoH
 lX3mCwzzAZEg1mgzq6d4oxQvM/mua5xgFxSTMV9XiKyLF0VSK5o3syzZMgPID5kDjvhM
 TvTM7K9Xf/XfXWCrneXOFvuqPsgW3xc4XC0QdkVqx6qZ21eXAX9sTBgfL1xx42abwey4
 TGBx0fs+xM7JS8VPttQ4eUrrifLXIvBU9wrgIXzvog22NkLdHXeqEH71Zlt41WJ4zEQE
 MWyHhOMLpBe7jkl/zGPp7QfDXjgs4Tl3qevFUm6oDroSxIZK9gl+BvCLwSO0/XApfayR
 zgsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU9/fyNZfutUNyb7bWxIg4TmCxM1FIYkRY4Ho81klZp2UNqSLv8KvkDXVgU3piyIvQzJ6bqAwfWHgF@nongnu.org
X-Gm-Message-State: AOJu0YwW/pEjWb1a3WoqmFyGfm6Vy73IqZA6j2pRfxsBdPCUEy2gTHjt
 SygmDiplsFmwHTxuwFFwjUGUM9Zk8SRHPIPIxZtOLn8RkBceJ08L
X-Google-Smtp-Source: AGHT+IHzopwV6DzJAS30JjqlOGaFZ4+NdL2MRLF1Oc4p/Y76Y6ejJVNsZyvRTIyGE4L+XXUV0PDMWw==
X-Received: by 2002:a17:903:987:b0:206:ba20:dd40 with SMTP id
 d9443c01a7336-2078296a3e9mr155398185ad.27.1726461273133; 
 Sun, 15 Sep 2024 21:34:33 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.87.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20794748053sm28952265ad.289.2024.09.15.21.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 21:34:32 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Mon, 16 Sep 2024 10:04:28 +0530
Message-ID: <2196636.irdbgypaU6@valdaarhun>
In-Reply-To: <CAJaqyWeCYrMW8zbLh=kHx_qQWAdXyR8oGpDgfopNeBabXrPovA@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <1803917.VLH7GnMWUR@valdaarhun>
 <CAJaqyWeCYrMW8zbLh=kHx_qQWAdXyR8oGpDgfopNeBabXrPovA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thursday, September 12, 2024 3:24:27=E2=80=AFPM GMT+5:30 Eugenio Perez M=
artin wrote:
> On Wed, Sep 11, 2024 at 9:36=E2=80=AFPM Sahil <icegambit91@gmail.com> wro=
te:
> > Hi,
> >=20
> > On Monday, September 9, 2024 6:04:45=E2=80=AFPM GMT+5:30 Eugenio Perez =
Martin wrote:
> > > On Sun, Sep 8, 2024 at 9:47=E2=80=AFPM Sahil <icegambit91@gmail.com> =
wrote:
> > > > On Friday, August 30, 2024 4:18:31=E2=80=AFPM GMT+5:30 Eugenio Pere=
z Martin wrote:
> > > > > On Fri, Aug 30, 2024 at 12:20=E2=80=AFPM Sahil <icegambit91@gmail=
=2Ecom>
> > > > > wrote:
> > > > > [...]
> > > > > vdpa_sim does not support packed vq at the moment. You need to bu=
ild
> > > > > the use case #3 of the second part of that blog [1]. It's good th=
at
> > > > > you build the vdpa_sim earlier as it is a simpler setup.
> > > > >=20
> > > > > If you have problems with the vp_vdpa environment please let me k=
now
> > > > > so we can find alternative setups.
> > > >=20
> > > > Thank you for the clarification. I tried setting up the vp_vdpa
> > > > environment (scenario 3) but I ended up running into a problem
> > > > in the L1 VM.
> > > >=20
> > > > I verified that nesting is enabled in KVM (L0):
> > > >=20
> > > > $ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
> > > > vmx
> > > >=20
> > > > $ cat /sys/module/kvm_intel/parameters/nested
> > > > Y
> > > >=20
> > > > There are no issues when booting L1. I start the VM by running:
> > > >=20
> > > > $ sudo ./qemu/build/qemu-system-x86_64 \
> > > > -enable-kvm \
> > > > -drive
> > > > file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=3Dv=
irtio
> > > > \
> > > > -net nic,model=3Dvirtio \
> > > > -net user,hostfwd=3Dtcp::2222-:22 \
> > > > -device intel-iommu,snoop-control=3Don \
> > > > -device
> > > > virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=3Do=
ff,iommu_
> > > > pla
> > > > tform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x4 \ -n=
etdev
> > > > tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> > > > -nographic \
> > > > -m 2G \
> > > > -smp 2 \
> > > > -M q35 \
> > > > -cpu host \
> > > > 2>&1 | tee vm.log
> > > >=20
> > > > Kernel version in L1:
> > > >=20
> > > > # uname -a
> > > > Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11
> > > > 18:25:26 UTC 2024 x86_64 GNU/Linux
> > >=20
> > > Did you run the kernels with the arguments "iommu=3Dpt intel_iommu=3D=
on"?
> > > You can print them with cat /proc/cmdline.
> >=20
> > I missed this while setting up the environment. After setting the kernel
> > params I managed to move past this issue but my environment in virtualb=
ox
> > was very unstable and it kept crashing.
>=20
> I've no experience with virtualbox+vdpa, sorry :). Why not use QEMU also =
for
> L1?

No, I was using virtualbox for L0. I wasn't able to create L1.qcow2 on my
host OS (Arch Linux). "Virt-sysprep" was giving me "resolve.conf is a
dangling symlink" issues. I had a Fedora VM set up on virtualbox and I
managed to create L1.qcow2 and L2.qcow2 there.

So my environment looked something like this:

Host OS (Bare metal) -> L0 (Fedora on virtualbox) -> L1 (QEMU) -> L2 (QEMU)

I learnt that shared folders can be set up between the host and virtualbox
and so I managed to move L1.qcow2 from the Fedora VM to my host OS.

So now my environment looks like this:

L0 (Arch Linux on bare metal) -> L1 (QEMU) -> L2 (QEMU)

> > I managed to get L1 to run on my host OS, so scenario 3 is now up and
> > running. However, the packed bit seems to be disabled in this scenario
> > too.
> >=20
> > L0 (host machine) specs:
> >=20
> > - kernel version:
> >   6.6.46-1-lts
> >=20
> > - QEMU version:
> >   9.0.50 (v8.2.0-5536-g16514611dc)
> >=20
> > - vDPA version:
> >   iproute2-6.10.0
> >=20
> > L1 specs:
> >=20
> > - kernel version:
> >   6.8.5-201.fc39.x86_64
> >=20
> > - QEMU version:
> >   9.0.91
> >=20
> > - vDPA version:
> >   iproute2-6.10.0
> >=20
> > L2 specs:
> > - kernel version
> >=20
> >   6.8.7-200.fc39.x86_64
> >=20
> > I followed the following steps to set up scenario 3:
> >=20
> > =3D=3D=3D=3D In L0 =3D=3D=3D=3D
> >=20
> > $ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
> > vmx
> >=20
> > $ cat /sys/module/kvm_intel/parameters/nested
> > Y
> >=20
> > $ sudo ./qemu/build/qemu-system-x86_64 \
> > -enable-kvm \
> > -drive
> > file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddisk,if=
=3Dvirtio
> > \ -net nic,model=3Dvirtio \
> > -net user,hostfwd=3Dtcp::2222-:22 \
> > -device intel-iommu,snoop-control=3Don \
> > -device
> > virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=3Doff,i=
ommu_pla
> > tform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x4 \ -netdev
> > tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> > -nographic \
> > -m 8G \
> > -smp 4 \
> > -M q35 \
> > -cpu host \
> > 2>&1 | tee vm.log
> >=20
> > =3D=3D=3D=3D In L1 =3D=3D=3D=3D
> >=20
> > I verified that the following config variables are set as decribed in t=
he
> > blog [1].
> >=20
> > CONFIG_VIRTIO_VDPA=3Dm
> > CONFIG_VDPA=3Dm
> > CONFIG_VP_VDPA=3Dm
> > CONFIG_VHOST_VDPA=3Dm
> >=20
> > # modprobe vdpa
> > # modprobe vhost_vdpa
> > # modprobe vp_vdpa
> >=20
> > # lsmod | grep -i vdpa
> > vp_vdpa                 20480  0
> > vhost_vdpa              32768  0
> > vhost                   65536  1 vhost_vdpa
> > vhost_iotlb             16384  2 vhost_vdpa,vhost
> > vdpa                    36864  2 vp_vdpa,vhost_vdpa
> > irqbypass               12288  2 vhost_vdpa,kvm
> >=20
> > # lspci | grep -i ethernet
> > 00:04.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (r=
ev
> > 01)
> >=20
> > # lspci -nn | grep 00:04.0
> > 00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network
> > device [1af4:1041] (rev 01)
> >=20
> > # echo 0000:00:04.0 > /sys/bus/pci/drivers/virtio-pci/unbind
> > # echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
> >=20
> > # vdpa mgmtdev show
> >=20
> > pci/0000:00:04.0:
> >   supported_classes net < unknown class >
> >   max_supported_vqs 3
> >   dev_features  CSUM  GUEST_CSUM  CTRL_GUEST_OFFLOADS  MAC  GUEST_TSO4
> >   GUEST_TSO6  GUEST_ECN  GUEST_UFO  HOST_TSO4  HOST_TSO6  HOST_ECN
> >   HOST_UFO  MRG_RXBUF  STATUS  CTRL_VQ  CTRL_RX  CTRL_VLAN  CTRL_RX_EXT=
RA
> >   GUEST_ANNOUNCE  CTRL_MAC_ADDR  RING_INDIRECT_DESC  RING_EVENT_IDX
> >   VERSION_1  ACCESS_PLATFORM  bit_40  bit_54  bit_55  bit_56
> >=20
> > # vdpa dev add name vdpa0 mgmtdev pci/0000:00:04.0
> > # vdpa dev show -jp
> > {
> >=20
> >     "dev": {
> >    =20
> >         "vdpa0": {
> >        =20
> >             "type": "network",
> >             "mgmtdev": "pci/0000:00:04.0",
> >             "vendor_id": 6900,
> >             "max_vqs": 3,
> >             "max_vq_size": 256
> >        =20
> >         }
> >    =20
> >     }
> >=20
> > }
> >=20
> > # ls -l /sys/bus/vdpa/devices/vdpa0/driver
> > lrwxrwxrwx. 1 root root 0 Sep 11 17:07 /sys/bus/vdpa/devices/vdpa0/driv=
er
> > -> ../../../../bus/vdpa/drivers/vhost_vdpa
> >=20
> > # ls -l /dev/ |grep vdpa
> > crw-------. 1 root root    239,   0 Sep 11 17:07 vhost-vdpa-0
> >=20
> > # driverctl -b vdpa
> > vdpa0 vhost_vdpa [*]
> >=20
> > Booting L2:
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
> > ent_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x7 \ -smp 4 \
> > -cpu host \
> > 2>&1 | tee vm.log
> >=20
> > =3D=3D=3D=3D In L2 =3D=3D=3D=3D
> >=20
> > # cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
> > 0
> >=20
> > Based on what I have understood from the kernel's source, vhost-vdpa and
> > vp-vdpa both support packed vqs and v6.6.46 is more recent than the
> > minimum required kernel version. I am not sure where I am going wrong.
> >=20
> > > > However, I managed to set up scenario 4 successfully
> > > > and I see that packed vq is enabled in this case.
> > > >=20
> > > > # cut -c 35 /sys/devices/pci0000:00/0000:00:04.0/virtio1/features
> > > > 1
> >=20
> > So far scenario 4 is the only scenario where the virtio-net device has =
the
> > packed feature enabled. The difference between scenarios 3 and 4 in ter=
ms
> > of the kernel modules loaded is that scenario 4 uses virtio_vdpa while
> > scenario 3 uses vdpa and vhost_vdpa.
>=20
> We're pretty close then :). But I don't see anything obviously wrong here.
>=20
> I guess it is the same L1 VM in both cases, isn't it?

Right, I am using the same L1.qcow2 image in both scenarios.

> The function that gets the features from vhost-vdpa in QEMU is
> hw/virtio/vhost-vdpa.c:vhost_vdpa_get_features. Can you check that it
> returns bit 34 (offset starts with 0 here)? If it returns it, can you
> keep debugging until you see what clears it?
>=20
> If it comes clear, then we need to check the kernel.

Got it. I'll start debugging from here.

> If you don't see anything wrong there, we can keep debugging the
> function that handles getting the features through L2 guest PCI read,
> hw/virtio/virtio-pci.c:virtio_pci_common_read. VIRTIO_PCI_COMMON_DF
> case when proxy->dfselect=3D=3D1.
>=20
> Let me know what you find.

I'll do that. Thank you for the suggestions.

Thanks,
Sahil



