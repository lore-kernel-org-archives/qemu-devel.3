Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE92C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 08:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIAZ-0002EE-2P; Mon, 15 Apr 2024 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rwIAV-0002Du-DQ
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rwIAL-0004HX-Rn
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713171495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHN9OvFQbClXwhMn6WkuyKD2daUFSyyn0EPGkcVzZWk=;
 b=Txv5KM0E3YwhrYm3t/rVTRIzLF37b5JLpMa2E/LQ3aaHyCE/j/1LqQ9u4Cqun8QfISyeMb
 IKao4Cf2RuxqfHvvYZRGTif0k9MRrXJHcltfRqbuOr6t+fYbhxZZiVowSvtls77X6sGmM0
 tJk36La9iag9/Qk3G8atuDDTMZDEMF8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-eQnuvxJHNnyDvrODia9unQ-1; Mon, 15 Apr 2024 04:58:13 -0400
X-MC-Unique: eQnuvxJHNnyDvrODia9unQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dcd94cc48a1so5170647276.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 01:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713171493; x=1713776293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHN9OvFQbClXwhMn6WkuyKD2daUFSyyn0EPGkcVzZWk=;
 b=fXlNxL5xS8CipKUC+jYAGnkVS+RUoZnMTEhsqHGxklfzixANle8+gduyhNAMxM+wuf
 eqnevSmf3wsyk+oF2ezIDVzcuHCvFYWpVmxFMV0tuVe4/jnELviuqDK2NcoctNOiyySt
 ura2/w16VV71P5orU0Slk+h255C3gcSb7YR6rDzeNw7ab7hctHU22v3sLcW5m0Whj5US
 qGnhRDrz4zuWF+xGiQcCgpxk4dJiZvLajVGuhPJg146feTFekb7EZNL3v5FRcZTDADNv
 Isg6DYQ8YTrC8b83TK5j/4HGtrweMLtJNmwAxbGEIRoY0tu6pG7oo9RHChruXjVtVhtY
 9FsA==
X-Gm-Message-State: AOJu0YywjAo5Et3QVbHzrJ3QAfPCaLMAMx6jqApl6NB25GlJq2cdTBgV
 iA42vCHFK5p20R3qllr50e8DtTu2kyvr+M9nO8U1t8V/M+pWalHIzyN+9FZ25p8z/nPZuyasd/Y
 16EolbmgRi/rk+2ofV9DFoBHTXTDyvqfNV7D/+43wxKiczHlef5+Zj/fv7KW2RU3pMKOZsXQUVX
 rH8oMoZZUouTgkiox6GG78PoNYE1w=
X-Received: by 2002:a25:912:0:b0:dd9:1d94:e581 with SMTP id
 18-20020a250912000000b00dd91d94e581mr6944937ybj.64.1713171493180; 
 Mon, 15 Apr 2024 01:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn96mnn8WhENnOTAhxKUgm6zISVnVjIvBAJ7H+vqs44kI9PAjkR+jaMfmYPWGHQxCT137amREk8HcNhXkwFUs=
X-Received: by 2002:a25:912:0:b0:dd9:1d94:e581 with SMTP id
 18-20020a250912000000b00dd91d94e581mr6944932ybj.64.1713171492864; Mon, 15 Apr
 2024 01:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWc+8OJZ33TtqeBy+Vy9HdW8zzbMKqg2mNWVaFda=g0XBA@mail.gmail.com>
 <3316716.aeNJFYEL58@valdaarhun> <2192541.Mh6RI2rZIc@valdaarhun>
In-Reply-To: <2192541.Mh6RI2rZIc@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 15 Apr 2024 10:57:36 +0200
Message-ID: <CAJaqyWcxK6i6iYiktPhq59gg0G8YzkD0X+Ji0XbOVgK0E1Hdwg@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 14, 2024 at 8:52=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Friday, April 5, 2024 12:36:02=E2=80=AFAM IST Sahil wrote:
> > [...]
> > I'll set up this environment as well.
>
> I would like to post an update here. I spent the last week
> trying to set up the environment as described in the blog [1].
> I initially tried to get the L1 VM running on my host machine
> (Arch Linux). However,  I was unable to use virt-sysprep or
> virt-cutomize to install packages in the qcow2 image. It wasn't
> able to resolve the hosts while downloading the packages.
>
> According to the logs, /etc/resolv.conf was a dangling symlink.
> I tried to use "virt-rescue" to configure DNS resolution. I tried
> following these sections [2], [3] in the Arch wiki but that didn't
> work either. I tried using qemu-nbd as well following this section
> [4] to access the image. While I managed gain access to the
> image, I wasn't able to install packages after performing a
> chroot.
>
> One workaround was to set this environment up in a VM. I
> decided to set up the environment with a Fedora image in
> virtualbox acting as L0. I have managed to set up an L1 VM
> in this environment and I can load it using qemu-kvm.
>

I'm not clear if the complaint of the dangling pointer comes from the
host or from the guest env, but I think it is ok to continue if you've
been able to build the env.

> I have one question though. One of the options (use case 1 in [1])
> given to the "qemu-kvm" command is:
> > -device virtio-net-pci,netdev=3Dvhost-vdpa0,bus=3Dpcie.0,addr=3D0x7\
> > ,disable-modern=3Doff,page-per-vq=3Don
>
> This gives an error:
> > Bus "pcie.0" not found
>
> Does pcie refer to PCI Express? Changing this to pci.0 works.

Yes, you don't need to mess with pcie stuff so this solution is
totally valid. I think we need to change that part in the tutorial.

> I read through the "device buses" section in QEMU's user
> documentation [5], but I have still not understood this.
>
> "ls /sys/bus/pci/devices/* | grep vdpa" does not give any results.
> Replacing pci with pci_express doesn't give any results either. How
> does one know which pci bus the vdpa device is connected to?
> I have gone through the "vDPA bus drivers" section of the "vDPA
> kernel framework" article [6] but I haven't managed to find an
> answer yet. Am I missing something here?
>

You cannot see the vDPA device from the guest. From the guest POV is a
regular virtio over PCI bus.

From the host, vdpa_sim is not a PCI device either, so you cannot see
under /sys/bus. Do you have a vdpa* entry under
/sys/bus/vdpa/devices/?

> There's one more thing. In "use case 1" of "Running traffic with
> vhost_vdpa in Guest" [1], running "modprobe pktgen" in the L1 VM
> gives an error:
> > module pktgen couldn't be found in /lib/modules/6.5.6-300.fc39.x86_64.
>
> The kernel version is 6.5.6-300.fc39.x86_64. I haven't tried building
> pktgen manually in L1. I'll try that and will check if vdpa_sim works
> as expected after that.
>

Did you install kernel-modules-internal?

Thanks!

> [1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ain=
t-got-hardware-part-1
> [2] https://wiki.archlinux.org/title/QEMU#User-mode_networking
> [3] https://wiki.archlinux.org/title/Systemd-networkd#Required_services_a=
nd_setup
> [4] https://wiki.archlinux.org/title/QEMU#Mounting_a_partition_from_a_qco=
w2_image
> [5] https://qemu-project.gitlab.io/qemu/system/device-emulation.html
> [6] https://www.redhat.com/en/blog/vdpa-kernel-framework-part-1-vdpa-bus-=
abstracting-hardware
>
> Thanks,
> Sahil
>
>


