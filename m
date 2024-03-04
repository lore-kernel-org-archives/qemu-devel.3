Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1CFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhGLZ-00023X-Gd; Mon, 04 Mar 2024 16:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rhGLV-00023C-KF
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rhGLS-0007jA-RD
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709589577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYr9RxLE7ICQP5M8LuYJaBjIKBfoxquqKHOKlfU1Ml0=;
 b=E6fEa4h2WT4yPX0gomQSdVxKaHgOfHHhUJusx2HI9mmLb1I3nBg3fhOgFeZwST2HsOPCtj
 nZ8jBhNZRFAMFisGRbbTS1kUo5nvjzhMDxuiju60eoj37y5oMlPGZAhSdDVxpPuX4aiiQI
 BdHkcoE2oIQ7HFQ/gIl5Oujrhw7TXoM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-6BzMknmKNIOEIe6Zxwcmxw-1; Mon, 04 Mar 2024 16:59:35 -0500
X-MC-Unique: 6BzMknmKNIOEIe6Zxwcmxw-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7c784b01313so1591039f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 13:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709589575; x=1710194375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYr9RxLE7ICQP5M8LuYJaBjIKBfoxquqKHOKlfU1Ml0=;
 b=a71IYzkh78/6vi7xhqysSD6IUoWfM1WK2KZoNC859tk5qAnJyAbpjGawAVmypgZUz5
 Z098kEJKT0VjnzphJb70jYM8qWOCgMydH4XcQvfksvbCN8RSZ+TL5hlOSk/RJu9bHBXa
 J0/sqMnHHmbprjJn57eNRizdAqHal6x7s5pyMbGQwib76aUpYTXqNdox7tkFmtZCdSK5
 LDH+L0G5TyCzfpYjQ3smco4AVKMj04gumrtPeZhTRNJf6+m5zgY88UYVUbR41HVpcWpL
 yPXk11D0rJmj7vBD88spAZZbHQ6s+jmyCEh/bgV40gTKS/I3YMXvFCSX+gG03Jhnedzl
 znHw==
X-Gm-Message-State: AOJu0Yz33kdey7VJGdOtNDwWrYWcYnoavKon3iRR+kYs9DsyO+JuO8DX
 Qpq5eilQ1pvf9DI2T3l9Ag192YN4G92w5PvqEQcg6L7xjMDg55+H2ca6NqfrcdHm8DA1dHXHJ0K
 7DjdemY3Clr+VbeV6/ol2wy0ccMpDMHRhlLfUolXDtsP+3nXnyBwGVxQDg0eA
X-Received: by 2002:a05:6602:38e:b0:7c8:560f:19a8 with SMTP id
 f14-20020a056602038e00b007c8560f19a8mr3821634iov.0.1709589574809; 
 Mon, 04 Mar 2024 13:59:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5OzQhRN4IV8xTWTw1t3YUnE/L009vfT2eF63he7m5wXkyjJuk0adjSmxV8P3au4sJM3yMiQ==
X-Received: by 2002:a05:6602:38e:b0:7c8:560f:19a8 with SMTP id
 f14-20020a056602038e00b007c8560f19a8mr3821623iov.0.1709589574525; 
 Mon, 04 Mar 2024 13:59:34 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 a36-20020a029427000000b00474393b4ed5sm2632863jai.10.2024.03.04.13.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 13:59:34 -0800 (PST)
Date: Mon, 4 Mar 2024 14:59:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Xu Liu <liuxu@meta.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: Re: Why does the vmovdqu works for passthrough device but crashes
 for emulated device  with "illegal operand" error (in x86_64 QEMU, -accel =
 kvm) ?
Message-ID: <20240304145932.4e685a38.alex.williamson@redhat.com>
In-Reply-To: <39E9DB13-5FA3-4D1A-A573-7D58BA83B35C@fb.com>
References: <39E9DB13-5FA3-4D1A-A573-7D58BA83B35C@fb.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Sun, 3 Mar 2024 22:20:33 +0000
Xu Liu <liuxu@meta.com> wrote:

> Hello,
>=20
> Recently I am running my programs in QEMU (x86_64) with =E2=80=9C-accel=
=3Dkvm=E2=80=9D.
>  The QEMU version is 6.0.0.
>=20
> I run my programs in two ways:
>=20
> 1.   I pass through my device through vfio-pci  to QEMU,  this way
> works well.
>=20
> 2.  I write an emulated PCI device for QEMU, and run my programs on
> the emulated PCI device. This crashes when  the code try to do memory
> copy to PCI device when the data length is longer than 16 bytes.
> While the  passthrough device works well for the same situation.
>=20
>=20
> After  dump the assembly code.  I noticed when the data is <=3D 16
> bytes,  the mov assembly code is chosen, and it works well.
>=20
> When the data is > 16 bytes,  the vmovdqu  assembly code is chosen,
> and it crashes with =E2=80=9Cillegal operand=E2=80=9D.
>=20
> Given the code and data are exactly same for both passthrough device
> and emulated device.  I am curious about why this happens.
>=20
> After turn on  kernel trace for kvm by   echo kvm:*
> /sys/kernel/debug/tracing/set_event And rerun the QEMU and my code
> for both passthrough device and emulated device, I noticed that:
>=20
> 1) for passthrough device,  I didn=E2=80=99t see  any trace events relate=
d to
> my  gva and gpa.  This makes me think that the memory copy to PCI
> device went through different code path . It is handled by the guest
> OS without exit to VMX.
>=20
> 2) for emulated device, if I use   compiler flag
> target-feature=3D-avx,-avx2 to force compiler use  mov assembly code,
> I can see the memory copy goes through the KVM_EXIT_MMIO, and
> everything works well. if I don=E2=80=99t force the compiler use mov ,  t=
he
> compiler just chooses the vmovdqu ,  which just crash the programs,
> and no KVM_EXIT_MMIO related to my memory copy appears in the trace
> events. Looks like the guest OS handles the crash.
>=20
>=20
> Any clue about why the vmovdqu works for passthrough device but not
> work for emulated device.

For an assigned device, the device MMIO space will be directly mapped
into the VM address space (assuming the PCI BAR is at least PAGE_SIZE),
so there's no emulation of the access.  You can disable this with the
x-no-mmap=3Don option for the vfio-pci device, where then I'd guess this
behaves the same as your emulated device (assuming we really don't
reach QEMU for the access).

Since you're not seeing a KVM_EXIT_MMIO I'd guess this is more of a KVM
issue than QEMU (Cc kvm list).  Possibly KVM doesn't emulate vmovdqu
relative to an MMIO access, but honestly I'm not positive that AVX
instructions are meant to work on MMIO space.  I'll let x86 KVM experts
more familiar with specific opcode semantics weigh in on that.

Is your "program" just doing a memcpy() with an mmap() of the PCI BAR
acquired through pci-sysfs or a userspace vfio-pci driver within the
guest?

In QEMU 4a2e242bbb30 ("memory: Don't use memcpy for ram_device
regions") we resolved an issue[1] where QEMU itself was doing a memcpy()
to assigned device MMIO space resulting in breaking functionality of
the device.  IIRC memcpy() was using an SSE instruction that didn't
fault, but didn't work correctly relative to MMIO space either.

So I also wouldn't rule out that the program isn't inherently
misbehaving by using memcpy() and thereby ignoring the nature of the
device MMIO access semantics.  Thanks,

Alex

[1]https://bugs.launchpad.net/qemu/+bug/1384892


