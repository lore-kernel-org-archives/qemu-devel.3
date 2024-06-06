Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACC4C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8fU-0002rV-HW; Thu, 06 Jun 2024 04:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1sF8fR-0002qt-Uj
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1sF8fP-00053n-Nr
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717663214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=PrcPiljQdixba2DiD9EcpVBDB5M1HH767X6Mx2WSc60=;
 b=I6V6GBIO80yr7g9KGP5sfOxZr+iFiZ2IwIgrLbN5LbogA+krzupptEZ7Gi3T7sW+BgttTl
 78KrhCvPJepffvXgZeP+PlRDBnAfMbhVUxEvBRrqfokVcyc547KgYJutw+Vdn5opaHu29k
 2dAnRa2GM6UEd8FubHP1u3pHzvpjxpk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-B0ZX4b2jM3qRTp8LRCxt1g-1; Thu, 06 Jun 2024 04:38:59 -0400
X-MC-Unique: B0ZX4b2jM3qRTp8LRCxt1g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c23f2dcf46so620855a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717663138; x=1718267938;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PrcPiljQdixba2DiD9EcpVBDB5M1HH767X6Mx2WSc60=;
 b=ItOw0X3THd0kd6MHPspOmKgIjkXunQRucnBUETy+m513ModeP1QBKugiGvbCEe3VUW
 JFZqSfBR4KzoDHFWzU1TYKfiQdW41XqIG4oRCJlzFKLIe7mOONZqY0GsoXRgusfCyHQl
 z95V0eUEMgw/K1IqbraidJBOYbxZBKLgr/bYZitWUNazjEJb3V9JgEUveyWcUDZ16HP4
 sMlXMw5sn7CbO45sxVQbHdULVZqP7iWntfr7Ax/VKtsL0poky6NHET700346HIochw7z
 xSb46w7vT+X5VqBfWW7VqAx9UfQ0nB9po54OuQtRVJHydYDMvndenlq7XLnNXH3KmaqG
 D6fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL3PTJaGnw22G9va5r/WoyKFKkMj5rt/TRfvUIfSO5fe/5scjZpyhGf4KlbZ+vIzXZgh4sPFIqgTFs0KTAF5H3693PvAU=
X-Gm-Message-State: AOJu0Yye7xf2hMUrYgU1QYrboKmRysEE0AWwRok4Kqa2LmbFuJ0LXVk+
 5zdfMD/bwot7hDMVmBHbHMWdN4BcPkW1dGcyLWx8GAsmT61F7t+e6f9NzIU2UGbfzD7E8si3Yq2
 SiD/QvVOZUAYjSsdYox7xNMrzgR4gP6nvhOMVmOHqVpzyeDA53Aa8mL9nCnlvG8pBx4R/ShEjFX
 JZ3Vx790ujSjlBU0wzlwPvvNHEyCE=
X-Received: by 2002:a17:90b:4f8a:b0:2b2:6975:bf49 with SMTP id
 98e67ed59e1d1-2c27dafd282mr4430926a91.6.1717663138117; 
 Thu, 06 Jun 2024 01:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcnGvJpqYIdn54/SLj9cOyKIDdhl74zABXsbSA9bkex7RoYFcrlcgvHpaIPKsULE0QPvRQcYDnyQiIu12R3Ak=
X-Received: by 2002:a17:90b:4f8a:b0:2b2:6975:bf49 with SMTP id
 98e67ed59e1d1-2c27dafd282mr4430914a91.6.1717663137693; Thu, 06 Jun 2024
 01:38:57 -0700 (PDT)
MIME-Version: 1.0
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 6 Jun 2024 10:38:46 +0200
Message-ID: <CAOssrKeJbfjhZ1rkL=Tj+zQaYxQLQmwLYYT22Cu8nYnY8nriYA@mail.gmail.com>
Subject: kvm crash with virtiofs
To: virtio-fs@lists.linux.dev, QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

I get the below crash when running virtio-fs on fedora 39.

Note: weirdly this makes chrome running on the host also crash.

Eric Sandeen also reported some bad behavior of virtio-fs on fc39,
which might be related.

Versions:
kernel-6.8.4-200.fc39.x86_64
qemu-kvm-8.1.3-5.fc39.x86_64
virtiofsd-1.10.1-1.fc39.x86_64

Thanks,
Miklos

/usr/libexec/virtiofsd --socket-path=/tmp/vhostqemu --shared-dir /home &

qemu-system-x86_64 -enable-kvm -s -serial none -parallel none -kernel
/home/mszeredi/git/linux/arch/x86_64/boot/bzImage -drive
format=raw,file=/home/mszeredi/root_fs,index=0,if=virtio -drive
format=raw,file=/home/mszeredi/images/ubd1,index=1,if=virtio -chardev
stdio,id=virtiocon0,signal=off -device virtio-serial -device
virtconsole,chardev=virtiocon0 -cpu host -m 16G -smp 8 -object
memory-backend-file,id=mem,size=16G,mem-path=/dev/shm,share=on -numa
node,memdev=mem -net user -net nic,model=virtio-net-pci -fsdev
local,security_model=none,id=fsdev0,path=/home -device virtio-rng-pci
-chardev socket,id=char0,path=/tmp/vhostqemu -device
vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs -device
virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare -append "root=/dev/vda
console=hvc0 "
[...]
root@kvm:~# time md5sum /host/mszeredi/images/ubd1
error: kvm run failed Bad address
RAX=0000000000000000 RBX=ffff888100044240 RCX=0000000000000000
RDX=ffff888420c59ff0
RSI=0000000000000020 RDI=ffff888420c59ff8 RBP=0000000000000000
RSP=ffffc900016d3898
R8 =ffff888420c59da8 R9 =0000000000000040 R10=0000000000036140
R11=0000000000000005
R12=ffff888420c59ff0 R13=000000000000000d R14=ffffea0010831600
R15=ffff888420c59da8
RIP=ffffffff82168d80 RFL=00010046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 ffffffff 00c00000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
DS =0000 0000000000000000 ffffffff 00c00000
FS =0000 00007fb83cea8740 ffffffff 00c00000
GS =0000 ffff88842fd40000 ffffffff 00c00000
LDT=0000 0000000000000000 ffffffff 00c00000
TR =0040 fffffe000012a000 00004087 00008b00 DPL=0 TSS64-busy
GDT=     fffffe0000128000 0000007f
IDT=     fffffe0000000000 00000fff
CR0=80050033 CR2=00007f2d3bd9b0f0 CR3=00000001036ee005 CR4=00770ef0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000d01
Code=90 90 90 90 48 c7 07 00 00 00 00 48 89 fa 48 8d 7f 08 31 c0 <48>
c7 87 30 02 00 00 00 00 00 00 48 89 d1 48 83 e7 f8 48 29 f9 81 c1 40
02 00 00 c1 e9 03


