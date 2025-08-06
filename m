Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FFDC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 19:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujjXS-00062v-HC; Wed, 06 Aug 2025 15:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujjXM-0005yF-EC
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 15:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujjXJ-0005id-Kc
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 15:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754507451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2unwycyxalgIY6gwhbClvJSyB+7Z4smUBo9/rq6Bt4=;
 b=aEl+SmRlf4GSz1ximMJ7bAtt7wMs8ZHfge12m8Gov3Kf6BKxUkhVrRobuIEhiTgrusL6FK
 5AV9aUCj9/DRD2Bn+vLH3nGIoRt02MLt15U/SUN3HaIcv42GhZLsk03Os/aClPpMGtWlhe
 MaGM49fxCCF56BIurw0ahaTqiAzY+HY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-DPGvPIxcMZCqvYj4PcrooA-1; Wed, 06 Aug 2025 15:10:50 -0400
X-MC-Unique: DPGvPIxcMZCqvYj4PcrooA-1
X-Mimecast-MFC-AGG-ID: DPGvPIxcMZCqvYj4PcrooA_1754507450
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71b7182633cso2368977b3.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 12:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754507449; x=1755112249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2unwycyxalgIY6gwhbClvJSyB+7Z4smUBo9/rq6Bt4=;
 b=F73wWDKxalq2+Ec6GV9VWfvD8tDMDlQ6vuRZBIoiKy7T4G/vZuQQqJIL7t2+d/cJ/z
 rX/ox2feWa7hy3bPOkpQuFXawvlpXqi52harOqdRVRWsMFbaA0mzrTVKuGJYyyn+zvCE
 sD2vCTZUWRbK9/OsPjPhvwTGszyK42QTEDx8UMaX2zxbP8ujAp4JJ++W64w4rP3fccWv
 vkcKpl939L2xCo2IsJOzQxcfLSEC+uRqI2h5KsqtwB4YsNbtziHHjAGDhGVAP4Q4T1UY
 HgNnA9NsKSpj0WPnJP/eCMCVn8k3i/eYTVkIKQ9drp0/0abKBiKbJrhPeJw4TDTQhO8K
 OhVA==
X-Gm-Message-State: AOJu0Yx/GBqyNrBpzWze3vtpPQ4IIt2dqyuaXuLuGncH3aAZn4Aqqk73
 ULw2KC5rXmerfXWddrCCF5ZL0+02WeLBUz55Hnq0e+9EON8TOIQPdPpHJyPHyNbQyh4sjpuRyH/
 FFHoB2XfI28KFOGXC1fXz+DKraDzlUWSkL0ewwUqr6uxboclxhG4v55zn
X-Gm-Gg: ASbGncv79ITR4eI7fWNbdbo2hAnvd5C6QEOqDt6UCT9Bnw/Am6gWDQ6ZhU4JGQP9wen
 /7/wC8z9S6ZMKz0iNExvVFVRTC9KbfiCRGZqXt5E70cGQzHRjpONsGCRQH7yVFa0F7nRidR+sWG
 htDPzojfKBP97wur5ILMq5Oy6XE25115PKaqBY4m+rRokmTBETWdxjKDs02M2rirOMWFjy63+4a
 XqCLef1urAc+3g60HQnYxW17nHfcLpPmzRcfUQXLmBfmCcuNxWbEdoeuYKgyythgwRJynIxqtbH
 cDob3+irduYKzI3yU7VjmtWUgyoBMS7PczH3OZyMACXue6Do10w7yd/sPMdjhDdwyxcD2HhFCIZ
 2PxCJJxmLMJw+7QnEidukzA==
X-Received: by 2002:a05:690c:9b07:b0:719:a4af:9639 with SMTP id
 00721157ae682-71bc96f347amr51014267b3.1.1754507449116; 
 Wed, 06 Aug 2025 12:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtullivX09IJI9WE9a54bgd+1DXyEShWd3Rpm+06JmSxpEWYevMWz3ekDrb95j9EkZ+nvh2A==
X-Received: by 2002:a05:690c:9b07:b0:719:a4af:9639 with SMTP id
 00721157ae682-71bc96f347amr51013897b3.1.1754507448602; 
 Wed, 06 Aug 2025 12:10:48 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a5ca37fsm40552437b3.64.2025.08.06.12.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 12:10:48 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:10:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Pete Bridgman <pb@fourieraudio.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, bonzini@gnu.org
Subject: Re: kvm_log_clear_one_slot: Assertion `mem->dirty_bmap' failed
Message-ID: <aJOotXGZbew8EmUm@x1.local>
References: <CAB+FeODh6Zhh2pRJPgps4=kzic9TU0=k62OOqdkQuq51vrMgMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB+FeODh6Zhh2pRJPgps4=kzic9TU0=k62OOqdkQuq51vrMgMQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 04, 2025 at 03:57:33PM +0100, Pete Bridgman wrote:
> Good afternoon,

Hi, Pete,

> 
> We're seeing a rare assertion failure in production on
> 
>     qemu-system-x86_64: ../../accel/kvm/kvm-all.c:909:
> kvm_log_clear_one_slot: Assertion `mem->dirty_bmap' failed.
> 
> We have seen this very occasionally in logs from devices running QEMU 7.2
> on Linux 5.19
> with a Windows 10 guest, seemingly spontaneously; there are no migrations
> involved which
> afaict has been implicated when this assertion has been hit previously
> (https://bugzilla.redhat.com/show_bug.cgi?id=1772774).

It is surprising indeed if this triggers without migration in progress.

Do you have any of the coredumps available?  Some dump from "thread apply
all bt" on a gdb session attached to the core dumps may provide some more
information.

Thanks,

> 
> We would love to be able to reproduce this (ideally on a more recent QEMU
> version) so that
> we can determine whether a later QEMU version has resolved the issue, and
> if not file a bug
> / work on a patch, but have thus far been unable to reproduce it on demand,
> with only very
> occasional logs from customer devices showing this issue.
> 
> Would anyone have any ideas about what conditions might make it more likely
> to reproduce,
> or any pointers on what might be going wrong here - or alternatively any
> thoughts about
> whether a later version might be expected to resolve this?
> 
> In the following bugzilla comment:
> https://bugzilla.redhat.com/show_bug.cgi?id=1772774#c11
> it was mentioned that perhaps this assertion failure could be downgraded to
> an early exit as
> it would likely be safe to continue operation in this case. Would anyone
> have any thoughts on
> this? Would we be unwise to make that change (even if in just our own fork?)
> 
> I have attached our QEMU command line for reference; many thanks in advance
> for any insight
> or guidance. I've CCd people who were involved in a bugfix for this
> assertion failure previously
> (9b3a31c7) on the advice of folks in IRC, hope you don't mind.
> 
> Kind regards
> 
> Pete
> 
> Peter Bridgman (he/him)
> 
> Co-Founder & CEO
> 
> +44 (0) 7917 448150
> pb@fourieraudio.com
> www.fourieraudio.com
> 
> Fourier Audio Ltd is registered in England and Wales (No. 13122782)
> registered at 8 Denmark Street, London, WC2H 8LS. The content of this email
> is confidential and intended for the recipient specified in the message. It
> is strictly forbidden to share any part of this message with any third
> party, without a written consent of the sender. If you received this
> message by mistake, please reply to this message and follow with its
> deletion, so that we can ensure such a mistake does not occur in the future.

> /usr/bin/qemu-system-x86_64 \
> -name guest=doppler-win-base,debug-threads=on \
> -S \
> -object '{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/var/lib/libvirt/qemu/domain-4-doppler-win-base/master-key.aes"}' \
> -machine pc-q35-5.2,usb=off,vmport=off,dump-guest-core=off,memory-backend=pc.ram \
> -accel kvm \
> -cpu host,migratable=off,hv-time=on,kvmclock=off,kvm-pv-eoi=on,kvm-pv-unhalt=on,hv-relaxed=on,hv-vapic=on,hv-spinlocks=0x1fff,hv-vpindex=on,hv-runtime=on,hv-synic=on,hv-stimer=on,hv-stimer-direct=on,hv-frequencies=on,hv-tlbflush=on,hv-ipi=on,hv-avic=on,hv-crash,kvm-hint-dedicated=on,kvm-poll-control=on,host-cache-info=on,l3-cache=off \
> -m 24576 \
> -object '{"qom-type":"memory-backend-memfd","id":"pc.ram","hugetlb":true,"hugetlbsize":1073741824,"x-use-canonical-path-for-ramblock-id":false,"prealloc":true,"size":25769803776}' \
> -overcommit mem-lock=on \
> -smp 10,sockets=1,dies=1,cores=10,threads=1 \
> -object '{"qom-type":"iothread","id":"iothread1"}' \
> -object '{"qom-type":"iothread","id":"iothread2"}' \
> -object '{"qom-type":"iothread","id":"iothread3"}' \
> -object '{"qom-type":"iothread","id":"iothread4"}' \
> -uuid b5cc201d-58cb-4e3b-b2e7-d540e2541e85 \
> -smbios 'type=1,manufacturer=Fourier Audio,product=Doppler,version=0,serial=TF-RD-0,sku=FTE-0' \
> -smbios 'type=2,manufacturer=Fourier Audio' \
> -smbios 'type=3,manufacturer=Fourier Audio' \
> -no-user-config \
> -nodefaults \
> -chardev socket,id=charmonitor,fd=33,server=on,wait=off \
> -mon chardev=charmonitor,id=monitor,mode=control \
> -rtc base=utc \
> -no-hpet \
> -global kvm-pit.lost_tick_policy=delay \
> -no-shutdown \
> -global ICH9-LPC.disable_s3=1 \
> -global ICH9-LPC.disable_s4=1 \
> -boot menu=off,strict=on \
> -device '{"driver":"pcie-root-port","port":16,"chassis":1,"id":"pci.1","bus":"pcie.0","multifunction":true,"addr":"0x2"}' \
> -device '{"driver":"pcie-root-port","port":17,"chassis":2,"id":"pci.2","bus":"pcie.0","addr":"0x2.0x1"}' \
> -device '{"driver":"pcie-root-port","port":18,"chassis":3,"id":"pci.3","bus":"pcie.0","addr":"0x2.0x2"}' \
> -device '{"driver":"pcie-root-port","port":19,"chassis":4,"id":"pci.4","bus":"pcie.0","addr":"0x2.0x3"}' \
> -device '{"driver":"pcie-root-port","port":20,"chassis":5,"id":"pci.5","bus":"pcie.0","addr":"0x2.0x4"}' \
> -device '{"driver":"pcie-root-port","port":21,"chassis":6,"id":"pci.6","bus":"pcie.0","addr":"0x2.0x5"}' \
> -device '{"driver":"pcie-pci-bridge","id":"pci.7","bus":"pci.6","addr":"0x0"}' \
> -device '{"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.2","addr":"0x0"}' \
> -device '{"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.3","addr":"0x0"}' \
> -blockdev '{"driver":"file","filename":"/opt/fa/win/image/base.qcow2","node-name":"libvirt-4-storage","auto-read-only":true,"discard":"unmap"}' \
> -blockdev '{"node-name":"libvirt-4-format","read-only":true,"driver":"qcow2","file":"libvirt-4-storage","backing":null}' \
> -blockdev '{"driver":"file","filename":"/var/opt/fa/image/current.qcow2","node-name":"libvirt-3-storage","auto-read-only":true,"discard":"unmap"}' \
> -blockdev '{"node-name":"libvirt-3-format","read-only":true,"driver":"qcow2","file":"libvirt-3-storage","backing":"libvirt-4-format"}' \
> -blockdev '{"driver":"file","filename":"/var/opt/fa/image/user.qcow2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}' \
> -blockdev '{"node-name":"libvirt-2-format","read-only":false,"driver":"qcow2","file":"libvirt-2-storage","backing":"libvirt-3-format"}' \
> -device '{"driver":"ide-hd","bus":"ide.0","drive":"libvirt-2-format","id":"sata0-0-0","bootindex":1}' \
> -blockdev '{"driver":"file","filename":"/opt/fa/winbin/winbin-current.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
> -blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}' \
> -device '{"driver":"ide-hd","bus":"ide.1","drive":"libvirt-1-format","id":"sata0-0-1"}' \
> -netdev '{"type":"tap","fd":"34","vhost":true,"vhostfd":"38","id":"hostnet0"}' \
> -device '{"driver":"virtio-net-pci","netdev":"hostnet0","id":"net0","mac":"52:54:00:7a:e8:17","bus":"pci.1","addr":"0x0"}' \
> -chardev pty,id=charserial0 \
> -device '{"driver":"isa-serial","chardev":"charserial0","id":"serial0","index":0}' \
> -device '{"driver":"usb-tablet","id":"input0","bus":"usb.0","port":"1"}' \
> -audiodev '{"id":"audio1","driver":"none"}' \
> -vnc 0.0.0.0:1,websocket=5902,password=on,audiodev=audio1 \
> -device '{"driver":"qxl-vga","id":"video0","max_outputs":1,"ram_size":67108864,"vram_size":67108864,"vram64_size_mb":0,"vgamem_mb":16,"bus":"pcie.0","addr":"0x1"}' \
> -device '{"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.4","addr":"0x0"}' \
> -object '{"qom-type":"rng-random","id":"objrng0","filename":"/dev/random"}' \
> -device '{"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","max-bytes":1024,"period":10,"bus":"pci.5","addr":"0x0"}' \
> -device qemu-xhci,id=xhci-external,addr=0xF,p2=15,p3=15 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=12,vendorid=0x088e,productid=0x5036 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=10.1 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=10.2 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=10.3 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=10.4 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=3 \
> -device usb-host,bus=xhci-external.0,hostbus=1,hostport=4 \
> -device usb-host,bus=xhci-external.0,hostbus=2,hostport=3 \
> -device usb-host,bus=xhci-external.0,hostbus=2,hostport=4 \
> -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny \
> -device '{"driver":"ivshmem-doorbell","id":"shmem0","chardev":"charshmem0","vectors":1,"ioeventfd":true,"bus":"pci.7","addr":"0x1"}' \
> -chardev socket,id=charshmem0,path=/tmp/ivshmem_socket \
> -msg timestamp=on


-- 
Peter Xu


