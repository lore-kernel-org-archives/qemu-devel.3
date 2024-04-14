Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE723C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 18:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw4xo-0001gn-0G; Sun, 14 Apr 2024 14:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rw4xm-0001gb-JX
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 14:52:26 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rw4xk-0003BU-6L
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 14:52:26 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5aa318db8a0so1749861eaf.1
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713120742; x=1713725542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtLbwdlhUjBV1zcrpKenNTXqLDtwVrzXUvVG+OxVtdg=;
 b=DL6geLu5JUq2E+T59dBNXnSxXF2j+H3Kr3FNF/CpRKdEJRJjXPyrSvYizH8Q1gsiB8
 EAdfCHOP9CnwdVr3k+CBuK9AvJr48CMqEsd8Sn/RYba3x8xeUlKfkL6s9xXablA37OJS
 jWLcft//v0m5X3mHtFpunxYiDBS2Zntn1QQOQeJm5vuqNQjtYSDkfKeINqjTDEQPvQUp
 +Qvi5WDmyff6p3hZbHux3nW1GWQFYfHLX6iQLXsBoJGf/dyhUr+y4jjg42oDVHJorjec
 v9NZvmfWKAw4ArkmcP1r4wwyq69AQFTXZ5ygSWPaD3Bi/Sft00rX6lc8aayob6O0Ri+s
 xc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713120742; x=1713725542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtLbwdlhUjBV1zcrpKenNTXqLDtwVrzXUvVG+OxVtdg=;
 b=XkDUR8Sa/gX+vkPbeBWvggrEhvl0GGhexi3FfHxoO3OAZHmvj/FU6l55uJch19PIl3
 Rk7sKlqtun1BEaM5Tq6erbeB64tdTGMfKmVvLWLEuz0MKYBPbmA2qbmHr3oCVmh+6LHe
 D4NbOhvEShEkwnoNd0FZJm4W7sLIC/LOlVjGISAyk9tCsivp9GtF8Dm6d1exOg8Blra8
 019urQVwMseIe/df/P/N3e2NWGMFniYZSMsqC/VpOdlsSy6Yh7a4Lvh169oENbFqF/z/
 KWrTryCVgBBco8dyKb0mD4Kq5bI5jAcnoYhkOutDQBqtJxbPvpPkzGRB+UIQIsCh8ZG5
 skwg==
X-Gm-Message-State: AOJu0YztdqX3aZmnUaLD0KyRmrlbOMkyPF+xJ79JC9TrA6PqfgesgxNX
 kEOmU4zR72+g8cDxHnK0YSs1PC9/FpFvK82ShRvy2V1Jr+99uBlx
X-Google-Smtp-Source: AGHT+IHtA3B45rsjVLDDAlBw7uW2ieFC5Vr2BgFBTFNAxGKoPP8DJFQeOZmAsw5QWEpcI9g8av8zUA==
X-Received: by 2002:a05:6871:4101:b0:22e:c6b2:849e with SMTP id
 la1-20020a056871410100b0022ec6b2849emr10576503oab.9.1713120742217; 
 Sun, 14 Apr 2024 11:52:22 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.85.160])
 by smtp.gmail.com with ESMTPSA id
 u6-20020aa78486000000b006edca18c194sm5874245pfn.22.2024.04.14.11.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 11:52:21 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Mon, 15 Apr 2024 00:22:18 +0530
Message-ID: <2192541.Mh6RI2rZIc@valdaarhun>
In-Reply-To: <3316716.aeNJFYEL58@valdaarhun>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWc+8OJZ33TtqeBy+Vy9HdW8zzbMKqg2mNWVaFda=g0XBA@mail.gmail.com>
 <3316716.aeNJFYEL58@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=icegambit91@gmail.com; helo=mail-oo1-xc33.google.com
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

On Friday, April 5, 2024 12:36:02=E2=80=AFAM IST Sahil wrote:
> [...]=20
> I'll set up this environment as well.

I would like to post an update here. I spent the last week=20
trying to set up the environment as described in the blog [1].
I initially tried to get the L1 VM running on my host machine
(Arch Linux). However,  I was unable to use virt-sysprep or
virt-cutomize to install packages in the qcow2 image. It wasn't
able to resolve the hosts while downloading the packages.

According to the logs, /etc/resolv.conf was a dangling symlink.
I tried to use "virt-rescue" to configure DNS resolution. I tried
following these sections [2], [3] in the Arch wiki but that didn't
work either. I tried using qemu-nbd as well following this section
[4] to access the image. While I managed gain access to the
image, I wasn't able to install packages after performing a
chroot.

One workaround was to set this environment up in a VM. I
decided to set up the environment with a Fedora image in
virtualbox acting as L0. I have managed to set up an L1 VM
in this environment and I can load it using qemu-kvm.

I have one question though. One of the options (use case 1 in [1])
given to the "qemu-kvm" command is:
> -device virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpcie.0,addr=3D0x7\
> ,disable-modern=3Doff,page-per-vq=3Don

This gives an error:
> Bus "pcie.0" not found

Does pcie refer to PCI Express? Changing this to pci.0 works.
I read through the "device buses" section in QEMU's user
documentation [5], but I have still not understood this.=20

"ls /sys/bus/pci/devices/* | grep vdpa" does not give any results.
Replacing pci with pci_express doesn't give any results either. How
does one know which pci bus the vdpa device is connected to?
I have gone through the "vDPA bus drivers" section of the "vDPA
kernel framework" article [6] but I haven't managed to find an
answer yet. Am I missing something here?

There's one more thing. In "use case 1" of "Running traffic with
vhost_vdpa in Guest" [1], running "modprobe pktgen" in the L1 VM
gives an error:
> module pktgen couldn't be found in /lib/modules/6.5.6-300.fc39.x86_64.

The kernel version is 6.5.6-300.fc39.x86_64. I haven't tried building
pktgen manually in L1. I'll try that and will check if vdpa_sim works
as expected after that.

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-1
[2] https://wiki.archlinux.org/title/QEMU#User-mode_networking
[3] https://wiki.archlinux.org/title/Systemd-networkd#Required_services_and=
_setup
[4] https://wiki.archlinux.org/title/QEMU#Mounting_a_partition_from_a_qcow2=
_image
[5] https://qemu-project.gitlab.io/qemu/system/device-emulation.html
[6] https://www.redhat.com/en/blog/vdpa-kernel-framework-part-1-vdpa-bus-ab=
stracting-hardware

Thanks,
Sahil



