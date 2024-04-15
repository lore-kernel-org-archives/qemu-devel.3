Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413EDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 19:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwSE6-0001ub-6f; Mon, 15 Apr 2024 15:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rwSE2-0001tf-Kv
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 15:42:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rwSE0-0002Or-NR
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 15:42:46 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6eaf9565e6bso2218977b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713210163; x=1713814963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqbZVWKfwAtfC5PEEGsa9W/MfnxWJLaGVPV/IbilxHU=;
 b=MdlZdTO2y6tcCtl2rD1s1dreg4GUumVJNKIdn584ebbJxmaLlDz19C5ymBuKjUzau/
 qi+o83j77sf3zF5fdluRR0bO/uZJXyyoAGrRxcCdw0kYu4UjUWIDSQFfjWl0E7HbaCuk
 lBI6VhV0IC79734b15CQtEeJryDM0g6F8LPFGC7J1xaVnal78n8dszwVcrzYXYk2Uz95
 K9n4uKhVR+tSNM3xwPUBJs5aOThuMCw4EF9gmeL65QcA0rJLmECnzI4wkrpJLSibhRA+
 Q2WxPQ+72LMAfqfuhgHBoXV3mUVSqzD99eu2gT3ylwkdDznv6rXGoUPb5z6AtT4Jx7Bl
 zZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713210163; x=1713814963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqbZVWKfwAtfC5PEEGsa9W/MfnxWJLaGVPV/IbilxHU=;
 b=DEIH9PKJTuhVKAce375u1P9RJozwKGsBhqvhA9f/wk3rXEdKAifqURuCSD1x+miwCh
 sF0xZUXx3cB2k/yUrvC5q2ObYmMsebFxnR1/IHjVKR4r4+Wd771zi5zNCs9/d8C87i8I
 Trq1iVvqZWt2f61t/MGs6ZzIMsHEXhVrkLRq70wuDJaSzwDmtBYUaXOq6YQ1cZmVOgb0
 qpNEmkY/kq6qh9cLTj7MuBb4dqhjnRORyofJ4CneS3TouIHJFWVXVn5ZnXyNebtTrjm0
 naLZnA4YMS+0SFrNsDTOZj3NiRQz0FjjQjwUeT7epf352o/Hp4CnRWh4tx7wiqVSXlKl
 518g==
X-Gm-Message-State: AOJu0Yy5PBj3Kpq9PK86O9oSfjUlSQgmORDo+yXHzSm/SVTOBR+xWNYs
 df/dmo/Kl4d5DkoCZIejk/cCJmrSWbEh0JiqalYt+L69Ml0RtfN5
X-Google-Smtp-Source: AGHT+IHY8MWH3Jf481MOS3YkJTCebwxbs0mdfdXvFoKnYQQNGE+h71IM7n/2jTxIWcQpECXKlB2txA==
X-Received: by 2002:a05:6a20:3cab:b0:1a9:694b:cfbd with SMTP id
 b43-20020a056a203cab00b001a9694bcfbdmr10343455pzj.5.1713210162478; 
 Mon, 15 Apr 2024 12:42:42 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.80.199])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a170902748200b001e3dda6511esm8243900pll.101.2024.04.15.12.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 12:42:41 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Tue, 16 Apr 2024 01:12:37 +0530
Message-ID: <5933234.MhkbZ0Pkbq@valdaarhun>
In-Reply-To: <CAJaqyWcxK6i6iYiktPhq59gg0G8YzkD0X+Ji0XbOVgK0E1Hdwg@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <2192541.Mh6RI2rZIc@valdaarhun>
 <CAJaqyWcxK6i6iYiktPhq59gg0G8YzkD0X+Ji0XbOVgK0E1Hdwg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thank you for your reply.

On Monday, April 15, 2024 2:27:36=E2=80=AFPM IST Eugenio Perez Martin wrote:
> [...]
> > I have one question though. One of the options (use case 1 in [1])
> >=20
> > given to the "qemu-kvm" command is:
> > > -device virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpcie.0,addr=3D0x7\
> > > ,disable-modern=3Doff,page-per-vq=3Don
> >=20
> > This gives an error:
> > > Bus "pcie.0" not found
> >=20
> > Does pcie refer to PCI Express? Changing this to pci.0 works.
>=20
> Yes, you don't need to mess with pcie stuff so this solution is
> totally valid. I think we need to change that part in the tutorial.
>=20

Understood.

> > I read through the "device buses" section in QEMU's user
> > documentation [5], but I have still not understood this.
> >=20
> > "ls /sys/bus/pci/devices/* | grep vdpa" does not give any results.
> > Replacing pci with pci_express doesn't give any results either. How
> > does one know which pci bus the vdpa device is connected to?
> > I have gone through the "vDPA bus drivers" section of the "vDPA
> > kernel framework" article [6] but I haven't managed to find an
> > answer yet. Am I missing something here?
>=20
> You cannot see the vDPA device from the guest. From the guest POV is a
> regular virtio over PCI bus.
>
> From the host, vdpa_sim is not a PCI device either, so you cannot see
> under /sys/bus. Do you have a vdpa* entry under
> /sys/bus/vdpa/devices/?
>

After re-reading the linked articles, I think I have got some more
clarity. One confusion was related to the difference between vdpa
and vhost-vdpa.

So far what I have understood is that L0 acts as the host and L1
acts as the guest in this setup. I understand that the guest can't
see the vDPA device.

I now also understand that vdpa_sim is not a PCI device. I am also
under the impression that vdpa refers to the vdpa bus while
vhost-vdpa is the device. Is my understanding correct?

After running the commands in the blog [1], I see that there's a
vhost-vdpa-0 device under /dev.

I also have an entry "vdpa0" under /sys/bus/vdpa/devices/ which
is a symlink to /sys/devices/vdpa0. There's a dir "vhost-vdpa-0"
under "/sys/devices/vdpa0". Hypothetically, if vhost-vdpa-0 had
been a PCI device, then it would have been present under
/sys/bus/pci/devices, right?

Another source of confusion was the pci.0 option passed to the
qemu-kvm command. But I have understood this as well now:
"-device virtio-net-pci" is a pci device.
=20
> > There's one more thing. In "use case 1" of "Running traffic with
> > vhost_vdpa in Guest" [1], running "modprobe pktgen" in the L1 VM
> >=20
> > gives an error:
> > > module pktgen couldn't be found in /lib/modules/6.5.6-300.fc39.x86_64.
> >=20
> > The kernel version is 6.5.6-300.fc39.x86_64. I haven't tried building
> > pktgen manually in L1. I'll try that and will check if vdpa_sim works
> > as expected after that.
>=20
> Did you install kernel-modules-internal?

I just realized I had the wrong version of kernel-modules-internal
installed. It works after installing the right version.

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-1



