Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A7F53D69
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29hd-0007op-K2; Mon, 16 Mar 2026 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w29ha-0007og-CJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w29hX-0000f6-C4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773674268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BxNr7H2mX+Kdhxq70Cxxn8oUkDSwQnLmR5gHrgzGPpE=;
 b=OTxLSF00qtY/Sr5aesUSpBL9vWbZ7x/kn44STbvtZO6FRxnKpda6YTaWGNpcFNh4E/0fPR
 atlHfoQOb1a/oCPob+LxfdRX/EzP1t+utfTFjqEuRkTmIvIKcZVRcNeFfQgk3nkuv4i98x
 Mk/xby7KfiTI0RtKapgnPf6ENZK8vL8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-_IPfEnwtMIOBav3X2wKUYw-1; Mon, 16 Mar 2026 11:17:47 -0400
X-MC-Unique: _IPfEnwtMIOBav3X2wKUYw-1
X-Mimecast-MFC-AGG-ID: _IPfEnwtMIOBav3X2wKUYw_1773674267
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5091f12ed3bso370294481cf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773674267; x=1774279067; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BxNr7H2mX+Kdhxq70Cxxn8oUkDSwQnLmR5gHrgzGPpE=;
 b=QUAV1FGhJEkRFS8DflsVYzSBZ6Ih1DXSysisSxqpBkA3vqfO2N363JET3rVh9kLnha
 yNpHV7gcAXpsXc0iv+t5bmGs6DRfy/kEuercnE9HB4ErFQg5r4hBTVWRC+frPZ3Hvy8O
 Dtv1w1TPYXNBReINtO2r9k41jzqasHOMftj0NvaL9r229/dcBVMt0fwGECVAdGOxHaqb
 n7z/ZFBTMUgAzbYPMrgzyLyfDzrqKRyuO3mNmKpdfbWXFs0x0JgL/qS/fi1jTIdYx1/b
 5zCd5SyXs+3TEMRdfG6RWaNJzPcUK+ZiFJ4SOcWCus/BHchi54PVPpSfaBT1orHRkBGj
 Bk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773674267; x=1774279067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxNr7H2mX+Kdhxq70Cxxn8oUkDSwQnLmR5gHrgzGPpE=;
 b=FAOHV5Jp14LRJeKGQxSWw+wHrK7K9bSDMpAMV+vwHC+jjzlhs+TiYAUmhn8UHwOb1Q
 i1sfEZqvbcs2u+x66+3D/9IvL2NQyF3yGUXTKAumRhVRgCMDBrs2O1SnFjJlx7zlnJVk
 78BPZCheyhvYdNAIHcQMfL6JaKNoetzUprmHYD/vMwYVKRdRg/gaOVjvhOPV449Yrsm/
 /nLok1y95zeRALUKLq0wVEP/qNmP1ZGLQLJ+44NdH5GLruQbMLP72cr0DoIirW1oRwmK
 ad+CYyD0HvAUpzO8o7DtE3BIdNoPVrhJ+4ArlhWQtC7xRsKkKkPNUO2omKUjm4HVxpcy
 eOaQ==
X-Gm-Message-State: AOJu0YxVE0CiopJhtzGxXS+bOj1zBBmqFWlkoipfKruhZjmV7RpieJc6
 bh5TpRiamg6MsnWjoNXI6VXmo6xQlAe9ixz6yg4rVCpSS7azhVeaBc9FpL+ZKnjAxXoWJx1dX/B
 jrb23UbRr+ZEHi6DSXBsKWk5/4SLAiIbXcjqc9n/4xaC5pUw3Y6p2d57T
X-Gm-Gg: ATEYQzx/4FGzmHUBdjNK/4krqj37SSxCgdNzmr8kpgO81IHk9M5guHWErYbP4h63pb4
 qqALakbxEjgJKVJqyuw233Yk9y9yUScsTCGN+aPWlqL29Bb034dbTozVO8GvnZ9EZOjs4coF15l
 3qSTqbY4u5hnb06eQ0CqWD3YxOOyyO1HJjLdqpEXkQHMK2xbQmhiy7HQ+g20YeCYbvlXrrQ0RvE
 sFTWkNjm0FzlkuZCILteMrREO2IDGIB3lU2vHa/5ZkAV/8H8iMRKQtl2LJpclKDTq6kN8/8FK1Z
 HqqfretzskcodYtdz6uT8W1YJ/sh2u5AvRaJUN+o0Hvi+rBUT7q/xypTB56UG/AZsSWC9x5rmI0
 r7FTPwB27uxm/5Q==
X-Received: by 2002:ac8:5fc9:0:b0:509:27e7:a067 with SMTP id
 d75a77b69052e-50957b89146mr176348931cf.6.1773674266720; 
 Mon, 16 Mar 2026 08:17:46 -0700 (PDT)
X-Received: by 2002:ac8:5fc9:0:b0:509:27e7:a067 with SMTP id
 d75a77b69052e-50957b89146mr176348371cf.6.1773674266042; 
 Mon, 16 Mar 2026 08:17:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939ec6326sm117332581cf.13.2026.03.16.08.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:17:45 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:17:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, marco.cavenati@music.ethz.ch
Subject: Re: Call for GSoC internship project ideas
Message-ID: <abgfF1HP3LX8rSkh@x1.local>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local>
 <20260314194706.637-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314194706.637-1-junjie.cao@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 15, 2026 at 03:47:06AM +0800, Junjie Cao wrote:
> Hi Peter, Marco, and QEMU community,

Hi, Junjie,

> 
> I'm Junjie Cao -- I graduated from the National University of Singapore
> last year and am currently working at Intel. I'd like to express my
> interest in the GSoC 2026 Fast Snapshot Load project.
> 
> Much of my background is in network device virtualization -- specifically
> the QEMU/DPDK/Virtio-net/VHost stack (emulation and tuning). This has
> given me hands-on experience with QEMU's guest memory management and
> device state serialization, and helps me appreciate how practical the
> problem this project aims to solve really is -- Marco's fuzzing use case
> of loading snapshots frequently is a great example.
> 
> == Preparation so far ==
> 
> - Built QEMU from latest master; will be sending a small fix patch soon to
> get familiar with the QEMU community workflow.
> 
> - Read Peter's original proposal and the follow-up discussion with Marco;
> read mapped-ram.rst -- the fixed-offset format allows pread() of any page
> by RAMBlock+offset directly from the snapshot file, which is the
> prerequisite for demand paging to work.
> 
> - On the source level, focused on two paths: the uffd infrastructure in
> migration/postcopy-ram.c (postcopy_ram_fault_thread,
> postcopy_ram_incoming_setup, ram_block_enable_notify) to understand how
> postcopy registers and handles page faults; and ram_load() in
> migration/ram.c to understand RAM section deserialization during loadvm.
> The intersection of these two paths is where the core changes for this
> project would go.
> 
> == Implementation path as I understand it ==
> 
> The core idea: split loadvm into "device state loading" and "RAM
> loading", bridged by uffd. Based on file: migration + mapped-ram:
> 
> - Modify the ram_load() path: parse_ramblock_mapped_ram() reads the
> MappedRamHeader and bitmap but skips read_ramblock_mapped_ram(), building
> an offset table for on-demand pread() instead. Other device states load
> normally.
> 
> - Register userfaultfd (MISSING mode) on all migratable RAMBlocks.
> postcopy-ram.c has similar infrastructure; the difference is we don't
> need discard logic or the source-side page request protocol.
> 
> - Start vCPUs with two threads populating RAM in parallel: a background
> loader doing sequential pread() + UFFDIO_COPY for bulk prefetch, and a
> fault handler resolving vCPU-triggered page faults on demand. A
> per-RAMBlock atomic bitmap with test_and_set coordinates the two to
> avoid double-copy. Once all pages are loaded, unregister uffd. Loadvm is
> complete.
> 
> Peter mentioned that the MVP could start with no multifd and anonymous
> memory only -- I think that would be a great approach. Since mapped-ram
> and postcopy are currently mutually exclusive in migrate_caps_check(), 
> a new capability will likely be needed for this feature.

Thanks for your interest.  Yes above all look sane.  We may also consider
reusing postcopy-ram + mapped-ram only on incoming side, so as to avoid a
new feature bit.

> 
> == A thought and a question ==
> 
> Some devices' load_state handlers access guest RAM during restore.
> Postcopy handles this by registering uffd before device state loading
> (inside the POSTCOPY_LISTEN handler, before device sections in the
> CMD_PACKAGED blob). The same ordering applies here: register uffd, start
> the fault handler, then load device states -- any RAM touch is
> intercepted and resolved via pread().

Note that we can't resolve page faults using pread(). One thing is because
it is not atomic, hence vCPU can see partially copied pages.  The other
thing is pread*() won't kick blocked threads properly.  We need to use
something like postcopy_place_page() through the userfaultfd facilities.

> 
> This relies on the kernel queuing faults between UFFDIO_REGISTER and the
> first poll(). I noticed postcopy_ram_incoming_setup() has a similar
> window (fault thread created before blocks registered) -- is this the
> same guarantee we'd rely on here?

The kernel must be able to queue requests right after REGISTER, OTOH poll()
can happen whenever late it is.  From kernel's POV, REGISTER enables this
feature already.  Whether someone will be polling or reading the fd (for
further fault resolution) will not stop the kernel from trapping memory
faults.

So yes, this should work similarly like original postcopy.

> 
> == Next steps ==
> 
> Besides attempting a QEMU patch submission and working on my proposal,
> is there anything else you'd suggest I prepare?

Feel free to apply via GSoC official website, it should open shortly today
and the deadline is March 31th.

Thanks,

> 
> Any feedback or guidance would be very much appreciated!
> 
> Best regards,
> Junjie Cao
> junjie.cao@intel.com
> 

-- 
Peter Xu


