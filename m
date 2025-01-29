Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECBEC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 20:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdEIq-0001dh-Mv; Wed, 29 Jan 2025 15:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tdEIo-0001dJ-IH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 15:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tdEIm-0007K1-Cd
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 15:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738181081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owhrd8cWGW4rtZQz8iu8nYjLIYR3mq1uvIP/BqRMHxk=;
 b=FSrXNa1gVSBaz6hGf/sn4VpmeQSAGbWHS5hA1EU3uIuRRUB6DmWMah0aF2fVVatxrC/SVr
 TBzDhAdQNvwf692dpAfObi870w/K4NbppURhb5hbCM2wRREmZ/ZbUDv5bDuqR7Z9w8VVtU
 FahzUhT27Jz3BRmcyLz7qS6osCjTxfE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-hpaR9letP2ycl-KOOej6Jg-1; Wed, 29 Jan 2025 15:04:39 -0500
X-MC-Unique: hpaR9letP2ycl-KOOej6Jg-1
X-Mimecast-MFC-AGG-ID: hpaR9letP2ycl-KOOej6Jg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso49891845e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 12:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738181078; x=1738785878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owhrd8cWGW4rtZQz8iu8nYjLIYR3mq1uvIP/BqRMHxk=;
 b=CEWwo5K4YohfiXOc+vCkSgywvG3ZxesRxoRXhGjqK97eSmIhxqlaLleBAdx6vFsudc
 zqXUgCKy4f3fx5OICm6a3E/G7N6gr+3QA5vnJoucTozkndrNL7nTm5Uq9YJPHNFlOi8g
 nv+1XXX3fZoXUqWeMMhVYaMzLHvOPs0mYzMNM73qjgLm9esjTN6/JNCwDkFuLPI5Aoz9
 1sDF/Fo7v84mlzMI0qdwedjYMnJAjQCF5Ng2uy/TRWFE/IbD6exPaumeAzkqPz9IMNVF
 5pdqAuVsArl2C036C5bzIfoLIIXP1APTnyTCvpldjE5ssHAxOKMW4LBhRBFRyBFkPCPs
 evEQ==
X-Gm-Message-State: AOJu0YwMNhZzMlpzaybig/G6vsAdQN0rpKm3mcEC8KJdxJVTsZa5823h
 30iraydwaKEZBW2t59ZEt8SeDyue3QpGDdVoQ528bWNXxBFReVDTs1wRBB7wLVlFbHsOvywqNkw
 UWAWZQxtosYlElXywCU3YXW6r0MDmY6jPE5Y8XP1ssoZfF8ZIadiJ
X-Gm-Gg: ASbGnct/h4A2ek+V7VaxPomTM2JR1bzUDiSESQ2gDyji8v//T8mVN8PR9gmLkUKjhUr
 lFVlRvdRsaBWGtudPmJz3BqWPv0QPjiPMJ5lK5vMBWNuPVVr175XkVJG1kqMKD0TU7lPqzK5RMW
 fED44yVW+epf+ElzxuyPU4yrjT52G/Jx67Bw3zkX3iDchJGJGbF1SFIcFiiU5XvbccGxD5U4NfK
 0eBH0SzYSosKrqg7uoez/O9AMRXbxlzbjcinqB8i7TkUqOcskijUaiROk13oUPYKd1rqMijrQc=
X-Received: by 2002:a05:600c:4f07:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-438dc40da5dmr38237785e9.23.1738181078575; 
 Wed, 29 Jan 2025 12:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeEnz8qBq5ww4bZ52zQTKc+Rpqlvf+dvEBDixCX1tiGA7i/UNZQvbr05wRwHTl/+Uu0J5Xbg==
X-Received: by 2002:a05:600c:4f07:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-438dc40da5dmr38237535e9.23.1738181078238; 
 Wed, 29 Jan 2025 12:04:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:abf2:bc7d:34cf:2ab9:c2f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764e9sm18211832f8f.17.2025.01.29.12.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 12:04:37 -0800 (PST)
Date: Wed, 29 Jan 2025 15:04:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
Message-ID: <20250129150352-mutt-send-email-mst@kernel.org>
References: <20250117192106.471029-1-thuth@redhat.com>
 <7e719e2d-1f89-4f67-b519-3279f18bccd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e719e2d-1f89-4f67-b519-3279f18bccd6@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jan 29, 2025 at 08:00:40AM +0100, Thomas Huth wrote:
> On 17/01/2025 20.21, Thomas Huth wrote:
> > QEMU currently crashes when you try to inspect the machines based on
> > TYPE_PC_MACHINE for their properties:
> > 
> >   $ echo '{ "execute": "qmp_capabilities" }
> >           { "execute": "qom-list-properties","arguments":
> >                        { "typename": "pc-q35-10.0-machine"}}' \
> >     | ./qemu-system-x86_64 -M pc -qmp stdio
> >   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
> >    "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
> >   {"return": {}}
> >   Segmentation fault (core dumped)
> > 
> > This happens because TYPE_PC_MACHINE machines add a machine_init-
> > done_notifier in their instance_init function - but instance_init
> > of machines are not only called for machines that are realized,
> > but also for machines that are introspected, so in this case the
> > listener is added for a q35 machine that is never realized. But
> > since there is already a running pc machine, the listener function
> > is triggered immediately, causing a crash since it was not for the
> > right machine it was meant for.
> > 
> > Such listener functions must never be installed from an instance_init
> > function. Let's do it from pc_basic_device_init() instead - this
> > function is called from the MachineClass->init() function instead,
> > i.e. guaranteed to be only called once in the lifetime of a QEMU
> > process.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   hw/i386/pc.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index b46975c8a4..85b8a76455 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
> >       /* Super I/O */
> >       pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
> >                       pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
> > +
> > +    pcms->machine_done.notify = pc_machine_done;
> > +    qemu_add_machine_init_done_notifier(&pcms->machine_done);
> >   }
> >   void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
> > @@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
> >       if (pcmc->pci_enabled) {
> >           cxl_machine_init(obj, &pcms->cxl_devices_state);
> >       }
> > -
> > -    pcms->machine_done.notify = pc_machine_done;
> > -    qemu_add_machine_init_done_notifier(&pcms->machine_done);
> >   }
> >   static void pc_machine_reset(MachineState *machine, ResetType type)
> 
> Friendly ping!
> 
>  Thomas


donnu how i missed it.  pls address Philip's comment though.


