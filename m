Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EB0EE499C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 19:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soT8e-0001pn-Nk; Wed, 11 Sep 2024 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1soT8a-0001op-PK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:36:24 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1soT8Y-0003eq-TA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:36:24 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so143745a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726083380; x=1726688180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plZDg/aqem1LDe5YmPsy7DJrFoL9URBqDHrFPu+fJgw=;
 b=O63U/Ma4EF76HhcZfVxroTF8GrkR01NklzoRvWyF59Okou8RvSqiVqTPGrWVLa8Dqj
 ZShu+HBIODloeUrUvCTqDboncvC68Vchd8w9jmCh4eLIkgY0cKzd1O1IZ1/QnMOJbgg7
 3CFgizKH6LMC/3xwr7YvFT3/+jeEGKK2fAFR2YiqbbPTgIgl5AYmoskMh71Fg0zXRxmZ
 uKbEXaVd2hMDvCQ75AZ4F/ZtvLBtg0fWqSFDKTmVlTC4JRsBwQfOqhXbzuLIKQ27w/dm
 Cu+b+dxYYqYgeO3qgrRBqmUVWNO2PphOOEDGwQeVixuZ3GYJYfgF4v3f3jX9osqGdquT
 o8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726083380; x=1726688180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plZDg/aqem1LDe5YmPsy7DJrFoL9URBqDHrFPu+fJgw=;
 b=CvaBodNk9s3jtIoIxeAoxWHVFqoDIVr8gcp2YgSRXi9kio6aUb2Yg0BYyziSc9kVR+
 vnmrxdtvYX5tHy60WOJBOLrCxMuMv/t4a6DkqNJlDESjZvE5AqWL5mkC8nIV2q3yQ5oj
 zP+TW2nLjRaNsRYLK/jZtPbQWeeq0klkAmIkTtv8z1n7dpIB0QhBt+vr4WX35bofhAj4
 sSW5ZShMj8WSryD8Fam3pmDfh6IERS7uVrrfVAIyHJ/7ILdlwCCHi+cZ7Il4qRqA8y9f
 0MRe26JCsiqBjISY/CCzHfuigXSTSwUycka9MGvsxiYlmR6zqsVPlzfdk/PiQtxc1r5B
 4H9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmm4UJyjtzae4keaOvfagU5CcHVqO4rC4ADj2KqTvrbFWGM4ntBV4OiNoVLzdqyoLM2wUGYNbumR1U@nongnu.org
X-Gm-Message-State: AOJu0YwZwJUeBkMniNdLUjYTg/n01+4lPiAj0kH6mzNmKpMgMmMv/lFu
 iwZVg9fLk7DVkxFfwZBC4gt8qJ4s0gs49u01T8GCosH5AWCKOGOZ
X-Google-Smtp-Source: AGHT+IGL7xC8Avs8qqPLny2ntdvEpGFiLHdjFSinUR3ImQQJdhyFyD50laLi2m+0/htiihNwkEvWzg==
X-Received: by 2002:a05:6a21:e8e:b0:1c6:a65f:299 with SMTP id
 adf61e73a8af0-1cf75eef9edmr351277637.21.1726083380002; 
 Wed, 11 Sep 2024 12:36:20 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.86.30])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fba4866sm356936a12.3.2024.09.11.12.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 12:36:19 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Thu, 12 Sep 2024 01:06:14 +0530
Message-ID: <1803917.VLH7GnMWUR@valdaarhun>
In-Reply-To: <CAJaqyWdFB=UfxV8LNoajP2+CC=8h98Wuow6oaiHcfjU8d69hpg@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <9355562.CDJkKcVGEf@valdaarhun>
 <CAJaqyWdFB=UfxV8LNoajP2+CC=8h98Wuow6oaiHcfjU8d69hpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=icegambit91@gmail.com; helo=mail-pg1-x533.google.com
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

On Monday, September 9, 2024 6:04:45=E2=80=AFPM GMT+5:30 Eugenio Perez Mart=
in wrote:
> On Sun, Sep 8, 2024 at 9:47=E2=80=AFPM Sahil <icegambit91@gmail.com> wrot=
e:
> > On Friday, August 30, 2024 4:18:31=E2=80=AFPM GMT+5:30 Eugenio Perez Ma=
rtin wrote:
> > > On Fri, Aug 30, 2024 at 12:20=E2=80=AFPM Sahil <icegambit91@gmail.com=
> wrote:
> > > [...]
> > > vdpa_sim does not support packed vq at the moment. You need to build
> > > the use case #3 of the second part of that blog [1]. It's good that
> > > you build the vdpa_sim earlier as it is a simpler setup.
> > >=20
> > > If you have problems with the vp_vdpa environment please let me know
> > > so we can find alternative setups.
> >=20
> > Thank you for the clarification. I tried setting up the vp_vdpa
> > environment (scenario 3) but I ended up running into a problem
> > in the L1 VM.
> >=20
> > I verified that nesting is enabled in KVM (L0):
> >=20
> > $ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
> > vmx
> >=20
> > $ cat /sys/module/kvm_intel/parameters/nested
> > Y
> >=20
> > There are no issues when booting L1. I start the VM by running:
> >=20
> > $ sudo ./qemu/build/qemu-system-x86_64 \
> > -enable-kvm \
> > -drive file=3D//home/ig91/fedora_qemu_test_vm/L1.qcow2,media=3Ddisk,if=
=3Dvirtio
> > \
> > -net nic,model=3Dvirtio \
> > -net user,hostfwd=3Dtcp::2222-:22 \
> > -device intel-iommu,snoop-control=3Don \
> > -device
> > virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=3Doff,i=
ommu_pla
> > tform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x4 \ -netdev
> > tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> > -nographic \
> > -m 2G \
> > -smp 2 \
> > -M q35 \
> > -cpu host \
> > 2>&1 | tee vm.log
> >=20
> > Kernel version in L1:
> >=20
> > # uname -a
> > Linux fedora 6.8.5-201.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 11
> > 18:25:26 UTC 2024 x86_64 GNU/Linux
> Did you run the kernels with the arguments "iommu=3Dpt intel_iommu=3Don"?
> You can print them with cat /proc/cmdline.

I missed this while setting up the environment. After setting the kernel
params I managed to move past this issue but my environment in virtualbox
was very unstable and it kept crashing.

I managed to get L1 to run on my host OS, so scenario 3 is now up and
running. However, the packed bit seems to be disabled in this scenario too.

L0 (host machine) specs:
=2D kernel version:
  6.6.46-1-lts

=2D QEMU version:
  9.0.50 (v8.2.0-5536-g16514611dc)

=2D vDPA version:
  iproute2-6.10.0

L1 specs:

=2D kernel version:
  6.8.5-201.fc39.x86_64

=2D QEMU version:
  9.0.91

=2D vDPA version:
  iproute2-6.10.0

L2 specs:
=2D kernel version
  6.8.7-200.fc39.x86_64

I followed the following steps to set up scenario 3:

=3D=3D=3D=3D In L0 =3D=3D=3D=3D

$ grep -oE "(vmx|svm)" /proc/cpuinfo | sort | uniq
vmx

$ cat /sys/module/kvm_intel/parameters/nested
Y

$ sudo ./qemu/build/qemu-system-x86_64 \
=2Denable-kvm \
=2Ddrive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3Ddis=
k,if=3Dvirtio \
=2Dnet nic,model=3Dvirtio \
=2Dnet user,hostfwd=3Dtcp::2222-:22 \
=2Ddevice intel-iommu,snoop-control=3Don \
=2Ddevice virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-modern=
=3Doff,iommu_platform=3Don,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D=
0x4 \
=2Dnetdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
=2Dnographic \
=2Dm 8G \
=2Dsmp 4 \
=2DM q35 \
=2Dcpu host \
2>&1 | tee vm.log

=3D=3D=3D=3D In L1 =3D=3D=3D=3D

I verified that the following config variables are set as decribed in the b=
log [1].

CONFIG_VIRTIO_VDPA=3Dm
CONFIG_VDPA=3Dm
CONFIG_VP_VDPA=3Dm
CONFIG_VHOST_VDPA=3Dm

# modprobe vdpa
# modprobe vhost_vdpa
# modprobe vp_vdpa

# lsmod | grep -i vdpa
vp_vdpa               	20480  0
vhost_vdpa             	32768  0
vhost                  	65536  1 vhost_vdpa
vhost_iotlb            	16384  2 vhost_vdpa,vhost
vdpa                   	36864  2 vp_vdpa,vhost_vdpa
irqbypass              	12288  2 vhost_vdpa,kvm

# lspci | grep -i ethernet
00:04.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 0=
1)

# lspci -nn | grep 00:04.0
00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network device=
 [1af4:1041] (rev 01)

# echo 0000:00:04.0 > /sys/bus/pci/drivers/virtio-pci/unbind
# echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id

# vdpa mgmtdev show
pci/0000:00:04.0:=20
  supported_classes net < unknown class >
  max_supported_vqs 3
  dev_features  CSUM  GUEST_CSUM  CTRL_GUEST_OFFLOADS  MAC  GUEST_TSO4
  GUEST_TSO6  GUEST_ECN  GUEST_UFO  HOST_TSO4  HOST_TSO6  HOST_ECN
  HOST_UFO  MRG_RXBUF  STATUS  CTRL_VQ  CTRL_RX  CTRL_VLAN  CTRL_RX_EXTRA
  GUEST_ANNOUNCE  CTRL_MAC_ADDR  RING_INDIRECT_DESC  RING_EVENT_IDX
  VERSION_1  ACCESS_PLATFORM  bit_40  bit_54  bit_55  bit_56

# vdpa dev add name vdpa0 mgmtdev pci/0000:00:04.0
# vdpa dev show -jp
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:00:04.0",
            "vendor_id": 6900,
            "max_vqs": 3,
            "max_vq_size": 256
        }
    }
}

# ls -l /sys/bus/vdpa/devices/vdpa0/driver
lrwxrwxrwx. 1 root root 0 Sep 11 17:07 /sys/bus/vdpa/devices/vdpa0/driver -=
> ../../../../bus/vdpa/drivers/vhost_vdpa

# ls -l /dev/ |grep vdpa
crw-------. 1 root root    239,   0 Sep 11 17:07 vhost-vdpa-0

# driverctl -b vdpa
vdpa0 vhost_vdpa [*]

Booting L2:

# ./qemu/build/qemu-system-x86_64 \
=2Dnographic \
=2Dm 4G \
=2Denable-kvm \
=2DM q35 \
=2Ddrive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
=2Dnetdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0 \
=2Ddevice virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-m=
odern=3Doff,event_idx=3Doff,packed=3Don,bus=3Dpcie.0,addr=3D0x7 \
=2Dsmp 4 \
=2Dcpu host \
2>&1 | tee vm.log

=3D=3D=3D=3D In L2 =3D=3D=3D=3D

# cut -c 35 /sys/devices/pci0000:00/0000:00:07.0/virtio1/features
0

Based on what I have understood from the kernel's source, vhost-vdpa and
vp-vdpa both support packed vqs and v6.6.46 is more recent than the
minimum required kernel version. I am not sure where I am going wrong.

> > However, I managed to set up scenario 4 successfully
> > and I see that packed vq is enabled in this case.
> >=20
> > # cut -c 35 /sys/devices/pci0000:00/0000:00:04.0/virtio1/features
> > 1

So far scenario 4 is the only scenario where the virtio-net device has the =
packed
feature enabled. The difference between scenarios 3 and 4 in terms of the k=
ernel
modules loaded is that scenario 4 uses virtio_vdpa while scenario 3 uses vd=
pa and
vhost_vdpa.

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-2



