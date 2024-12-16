Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753EAE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCGx-0005ri-6r; Mon, 16 Dec 2024 09:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tNCGg-0005ph-Hy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tNCGd-0003ey-QH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734360014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAOMZqTgbIpDyVstporeYctILlj8MEC5pXbGQerD7Us=;
 b=HEv/lDa7Q6jzYamujf3qLA88rtorR1VGlsMwPrRf4va7gprV+ObPtVaSp6nYkNt4OyVDm/
 ecRs4JX0yE+Bwm0sDZvhJr2HAsggzcTrNCR1HuaBXwaEzgAHRwAArJA8bjmC2+1ci3frP6
 Ie+i9MLQ65Jp4ar58dm8qnW0mKqd/ZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-_CjYIAgOP-CJO4-Die2pPQ-1; Mon, 16 Dec 2024 09:40:10 -0500
X-MC-Unique: _CjYIAgOP-CJO4-Die2pPQ-1
X-Mimecast-MFC-AGG-ID: _CjYIAgOP-CJO4-Die2pPQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43627bb20b5so31283795e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734360009; x=1734964809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAOMZqTgbIpDyVstporeYctILlj8MEC5pXbGQerD7Us=;
 b=u0VspxH3x0o2aO4KRrwW8xn8Rg+iw0iE4h9eIbfgVn9I9Nt7MlaIGulmXNlxKCHeFC
 u5+g0fRlXIGD+a9wY6nIpJGmvil9rLQ9d6qU04Y/psSR+L1peWFdNMlbQ2KxKYKgDtP2
 zG8aST3aIs3syzJpBKxhG/00Ik9p0xx+CZj3HV3spMMa+BhKmej2AJbvIG6jg7AaKlGu
 gLAStaMo/NHW8SJv6wa9d8mTdb9cyxX/Pa/OAb8CncI8KN4HhvhFm5O8Xrt7cQB7Y6SE
 QU7SAX3UDvUFlLEox3Y2a2Y9eTn3ROzBbA8Lxtqe85OGJvvjmSTaees1ITVEjMU5pxvS
 sp8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS/0gxVFWTXZW8w7UUljRBHgcFV5U+U7+LS5yzuBTHHcsjOJbUwBbh2QElS5MsWYJM5tqxSgkMqOp2@nongnu.org
X-Gm-Message-State: AOJu0YyfwVGc9HWMr4NP6M8619OeI4xjzFuajTZCg8gVHjaqDYi1LIaN
 U1OhbD1aqsYLxavT0sEXgJu8Y0pK1euaSK2U7QaBcShAfl1Rr4fBsqzPzFlt1J9gmj5Ons3GzYU
 aEW5uZt6w+yXoq9uvRfVPZBvbLTHKLY4TP1as37J2K1a0c6mdth/9
X-Gm-Gg: ASbGncsZrfnNJCBY41IGZwfAVHMDzijPA/ItspRKc+P99t4EYhKXWqLnn1+67b7mRIK
 XQNQO4GZdxnPGzIEvB4xJMp0E5otQ0gnoL8PrzpUjwi0uIbt6Y/Tiqys0kBjD4VRJVbt0Td+G1F
 PqrpsBdrSJx/XxyImjCsQVv4HqPdciZCHVaM/tu20Aqoc348P1rdagXzQ0DwIZfDf3C/oNRZf0m
 ZY6Il+2lCQ6zcRTUjnGYUSEvp0gD6WsRD3zOJ9XpkDHmhpvyr/bRAHV9D4xSDHZ2fh8Xy0j/J6e
 kNUbEDdkDAPZD1ShivjNlW+EW0Qv
X-Received: by 2002:a05:600c:468a:b0:434:f99e:a5b5 with SMTP id
 5b1f17b1804b1-4362aaa919fmr97143575e9.28.1734360009145; 
 Mon, 16 Dec 2024 06:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfGvXzqjiZ1ZFmtNYHBTlbz8+5FWjRqePnsE3CrsDE+je3WvP6007zWp0tUAqCHsylC85zKA==
X-Received: by 2002:a05:600c:468a:b0:434:f99e:a5b5 with SMTP id
 5b1f17b1804b1-4362aaa919fmr97143385e9.28.1734360008788; 
 Mon, 16 Dec 2024 06:40:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436257176a4sm141694465e9.38.2024.12.16.06.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:40:06 -0800 (PST)
Date: Mon, 16 Dec 2024 15:40:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Cc: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>
Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
Message-ID: <20241216154005.080389f3@imammedo.users.ipa.redhat.com>
In-Reply-To: <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
 <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
 <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Tue, 10 Dec 2024 21:51:40 +0000
"Luo, Zhigang" <Zhigang.Luo@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: David Hildenbrand <david@redhat.com>
> > Sent: Tuesday, December 10, 2024 2:55 PM
> > To: Luo, Zhigang <Zhigang.Luo@amd.com>; qemu-devel@nongnu.org
> > Cc: kraxel@redhat.com; Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
> >
> > On 10.12.24 20:32, Luo, Zhigang wrote:  
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi David,
> > >  
> >
> > Hi,
> >  
> > >>>
> > >>> Thanks for your comments.
> > >>> Let me give you some background for this patch.
> > >>> I am currently engaged in a project that requires to pass the
> > >>> EFI_MEMORY_SP  
> > >> (Special Purpose Memory) type memory from host to a virtual machine
> > >> within QEMU. This memory needs to be EFI_MEMORY_SP type in the
> > >> virtual machine as well.  
> > >>> This particular memory type is essential for the functionality of my project.  
> > >>
> > >> Which exact guest memory will be backed by this memory? All guest-memory?  
> > > [Luo, Zhigang] not all guest-memory. Only the memory reserved for specific  
> > device.
> >
> > Can you show me an example QEMU cmdline, and how you would pass that
> > hostmem-file object to the device?
> >  
> [Luo, Zhigang] the following is an example. m1 is the reserved memory for pci device "0000:03:00.0". both the memory and pci device are set to same numa node.
> 
> -object memory-backend-ram,size=8G,id=m0 \
> -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on \
> -numa node,nodeid=0,memdev=m0 -numa node,nodeid=1,memdev=m1 \
> -device pxb-pcie,id=pcie.1,numa_node=1,bus_nr=2,bus=pcie.0 \
> -device ioh3420,id=pcie_port1,bus=pcie.1,chassis=1 \
> -device vfio-pci,host=0000:03:00.0,id=hostdev0,bus=pcie_port1

Is /dev/dax0.0 a part of host device 0000:03:00.0 that you pass-through to guest using vfio?



> 
> > >  
> > >>
> > >> And, what is the guest OS going to do with this memory?  
> > > [Luo, Zhigang] the device driver in guest will use this reserved memory.  
> >
> > Okay, so just like CXL memory.
> >  
> > >  
> > >>
> > >> Usually, this SP memory (dax, cxl, ...) is not used as boot memory.
> > >> Like on a bare metal system, one would expect that only CXL memory
> > >> will be marked as special and put aside to the cxl driver, such that
> > >> the OS can boot on ordinary DIMMs, such that cxl can online it etc.
> > >>
> > >> So maybe you would want to expose this memory using CXL-mem device to
> > >> the VM? Or a DIMM?
> > >>
> > >> I assume the alternative is to tell the VM on the Linux kernel
> > >> cmdline to set EFI_MEMORY_SP on this memory. I recall that there is a way to  
> > achieve that.  
> > >>  
> > > [Luo, Zhigang] I know this option. but it requires the end user to know where is the  
> > memory location in guest side(start address, size).
> >
> > Right.
> >  
> > >
> > >  
> > >>> In Linux, the SPM memory will be claimed by hmem-dax driver by
> > >>> default. With  
> > >> this patch I can use the following config to pass the SPM memory to guest VM.  
> > >>> -object
> > >>> memory-backend-file,size=30G,id=m1,mem-path=/dev/dax0.0,prealloc=on,
> > >>> al
> > >>> ign=1G,hmem=on
> > >>>
> > >>> I was thinking to change the option name from "hmem" to "spm" to
> > >>> avoid  
> > >> confusion.
> > >>
> > >> Likely it should be specified elsewhere, that you want specific guest
> > >> RAM ranges to be EFI_MEMORY_SP. For a DIMM, it could be a property,
> > >> similarly maybe for CXL- mem devices (no expert on that).
> > >>
> > >> For boot memory / machine memory it could be a machine property. But
> > >> I'll first have to learn which ranges you actually want to expose
> > >> that way, and what the VM will do with that information.  
> > > [Luo, Zhigang] we want to expose the SPM memory reserved for specific device.  
> > And we will pass the SPM memory and the device to guest. Then the device driver
> > can use the SPM memory in guest side.
> >
> > Then the device driver should likely have a way to configure that, not the memory
> > backend.
> >
> > After all, the device driver will map it somehow into guest physical address space
> > (how?).
> >  
> [Luo, Zhigang] from guest view, it's still system memory, but marked as SPM. So, qemu will map the memory to guest physical address space.
> The device driver just claims to use the SPM memory in guest side.
> 
> > >  
> > >>  
> > >>>
> > >>> Do you have any suggestions to achieve this more reasonable?  
> > >>
> > >> The problem with qemu_ram_foreach_block() is that you would indicate
> > >> also DIMMs, virtio-mem, ... and even RAMBlocks that are not even used
> > >> for backing anything to the VM as EFI_MEMORY_SP, which is wrong.  
> > > [Luo, Zhigang] qemu_ram_foreach_block() will list all memory block, but in  
> > pc_update_hmem_memory(), only the memory block with "hmem" flag will be
> > updated to SPM memory.
> >
> > Yes, but imagine a user passing such a memory backend to a DIMM/virtio-mem/boot
> > memory etc. It will have very undesired side effects.
> >  
> [Luo, Zhigang] the user should know what he/she is doing when he/she set the flag for the memory region.
> 
> 
> > --
> > Cheers,
> >
> > David / dhildenb  
> 


