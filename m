Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D433DC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXp0-0005fv-TG; Tue, 20 Feb 2024 16:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcXow-0005es-Je
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:38:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rcXos-0004G0-OB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708465109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmOwF+DAyMIdSV9DcRGz70bKDrXBdZ9noerZKo7mWzU=;
 b=QBuijgWg39NrCOG6Og9p3z5JStCMg5MD1c5aSPUJTIu/EA4qLRw4Yn9O8qW3cBgSk2MoMG
 h0yZbuee8zX/pUuWeLw6IbNnbaLBOP+dlLXbArm55Nv3gmDXsxWFftk5e5TlPLZgBXCxpA
 YW4Gi7UagoUbDTFjNtRBP9SW5ka/Rl8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-kajozs2zPqiYiXrLTuuQVA-1; Tue, 20 Feb 2024 16:38:27 -0500
X-MC-Unique: kajozs2zPqiYiXrLTuuQVA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56451e5801dso1183011a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708465106; x=1709069906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmOwF+DAyMIdSV9DcRGz70bKDrXBdZ9noerZKo7mWzU=;
 b=iYr8ZqnYZfiRbFHJ7Qv7Nb8wRa4sNI3x+kBzGjZbtKYS2LbhXeq79yOP1HNsAg2R+f
 +l1tjHJikHw14h6J8WqHbj4lez4WiH6kQwDsWfk1qX0SHXtP7OnOZmwUXqz53tQS2YD/
 VEA4vWiZnYiMKyAwDXZ9hYaqAiFbwCB5IZaXv6FfREgLt1LBAVF7eweRfQlNeLqzNxTv
 QYjVcmUEQ9bTu/qNmPaX+D9/JCGilWyr3ytgLqkxZPpyxXIG+SVBm0GeXbrTsAzHtIyB
 /WSLHKFaWWNuelTIusuG+xD58x9ymfHLy1jIEeDe4W9xYnuLreDghfSXaZaXWKPAki3I
 OwTA==
X-Gm-Message-State: AOJu0YwlsqaQ6oFWEFaDFn+u81pH5L+U2+KrEHSZfz/oBiA2onKX4eid
 FywMdB0LhuJzFVUA80a7llGx9tztD+6ZVABiK0F/7Hiv0yIHjiVHk9JyTXRZZqBjtyCWJrPk8wI
 Xfgkgb65ARKhiZzkLeAvl0EXCuFy2jxdsoypO+nwJ2ft9UXGF6VTK
X-Received: by 2002:aa7:d508:0:b0:564:5407:ce22 with SMTP id
 y8-20020aa7d508000000b005645407ce22mr5101471edq.21.1708465106714; 
 Tue, 20 Feb 2024 13:38:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNJM7+bjae7odHHnifREhjLQ8pkr72rW97xUSsgTE1F1R8/njXgtT7AgmZA6VADdJXPP1ZFw==
X-Received: by 2002:aa7:d508:0:b0:564:5407:ce22 with SMTP id
 y8-20020aa7d508000000b005645407ce22mr5101464edq.21.1708465106325; 
 Tue, 20 Feb 2024 13:38:26 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:1091:ae5:ff2a:ccd0:5e19])
 by smtp.gmail.com with ESMTPSA id
 fd5-20020a056402388500b00564bd1724cesm1070713edb.65.2024.02.20.13.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 13:38:25 -0800 (PST)
Date: Tue, 20 Feb 2024 16:38:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 00/10] reset: Make whole system three-phase-reset aware
Message-ID: <20240220163700-mutt-send-email-mst@kernel.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Tue, Feb 20, 2024 at 04:06:12PM +0000, Peter Maydell wrote:
> This patchset is an incremental improvement to our reset handling that
> tries to roll out the "three-phase-reset" design we have for devices
> to a wider scope.
> 
> At the moment devices and buses have a three-phase reset system, with
> separate 'enter', 'hold' and 'exit' phases. When the qbus tree is
> reset, first all the devices on it have their 'enter' method called,
> then they all have 'enter' called, and finally 'exit'. The idea is
> that we can use this, among other things, as a way to resolve annoying
> "this bit of reset work needs to happen before this other bit of reset
> work" ordering issues.
> 
> However, there is still a "legacy" reset option, where you register a
> callback function with qemu_register_reset(). These functions know
> nothing about the three-phase system, and "reset the qbus" is just one
> of the things set up to happen at reset via qemu_register_reset().
> That means that a qemu_register_reset() function might happen before
> all the enter/hold/exit phases of device reset, or it might happen after
> all of them.
> 
> This patchset provides a new way to register a three-phase-aware reset
> in this list of "reset the whole system" actions, and reimplements
> qemu_register_reset() in terms of that new mechanism. This means that
> qemu_register_reset() functions are now all called in the 'hold' phase
> of system reset. (This is an ordering change, so in theory it could
> introduce new bugs if we are accidentally depending on the current
> ordering; but we have very few enter and exit phase methods at the
> moment so I don't expect much trouble, if any.)
> 
> The first three patches remove the only two places in the codebase
> that rely on "a reset callback can unregister itself within the
> callback"; this is awkward to continue to support in the new
> implementation, and an unusual thing to do given that reset is in
> principle supposed to be something you can do as many times as you
> like, not something that behaves differently the first time through.
> 
> Patch 4 is an improvement to the QOM macros that's been on list as an
> RFC already.
> Patches 5 and 6 are the "new mechanism": qemu_register_resettable()
> takes any object that implements the Resettable interface. System
> reset is then doing 3-phase reset on all of these, so everything
> gets its 'enter' phase called, then everything gets 'hold', then
> everything gets 'exit'.
> 
> Patch 7 reimplements the qemu_register_reset() API to be
> "qemu_register_resettable(), and the callback function is called
> in the 'hold' phase".
> 
> Patch 8 makes the first real use of the new API: instead of
> doing the qbus reset via qemu_register_reset(), we pass the
> root of the qbus to qemu_register_resettable(). (This is where
> the ordering change I mention above happens, as device enter and
> exit method calls will now happen before and after all the
> qemu_register_reset() function callbacks, rather than in the
> middle of them.)
> 
> Finally, patch 9 updates the developer docs to describe how a
> complete system reset currently works.
> 
> This series doesn't actually do a great deal as it stands, but I
> think it's a necessary foundation for some cleanups:
>  * the vfio reset ordering problem discussed on list a while back
>    should now hopefully be solvable by having the vfio code use
>    qemu_register_resettable() so it can arrange to do the "needs to
>    happen last" stuff in an exit phase method
>  * there are some other missing pieces here, but eventually I think
>    it should be possible to get rid of the workarounds for
>    dependencies between ROM image loading and CPUs that want to
>    read an initial PC/SP on reset (eg arm, m68k)
> I also think it's a good idea to get it into the tree so that we
> have a chance to see if there are any unexpected regressions
> before we start putting in bugfixes etc that depend on it :-)
> 
> After this, I think the next thing I'm going to look at is whether
> we can move the MachineState class from inheriting from TYPE_OBJECT
> to TYPE_DEVICE. This would allow us to have machine-level reset
> (and would bring "machine as a container of devices" into line
> with "SoC object as container of devices").
> 
> thanks
> -- PMM


Like this overall and the pc cleanup is nice.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>




> Peter Maydell (10):
>   hw/i386: Store pointers to IDE buses in PCMachineState
>   hw/i386/pc: Do pc_cmos_init_late() from pc_machine_done()
>   system/bootdevice: Don't unregister reset handler in
>     restore_boot_order()
>   include/qom/object.h: New OBJECT_DEFINE_SIMPLE_TYPE{,_WITH_INTERFACES}
>     macros
>   hw/core: Add documentation and license comments to reset.h
>   hw/core: Add ResetContainer which holds objects implementing
>     Resettable
>   hw/core/reset: Add qemu_{register,unregister}_resettable()
>   hw/core/reset: Implement qemu_register_reset via
>     qemu_register_resettable
>   hw/core/machine: Use qemu_register_resettable for sysbus reset
>   docs/devel/reset: Update to discuss system reset
> 
>  MAINTAINERS                      |  10 ++
>  docs/devel/qom.rst               |  34 ++++++-
>  docs/devel/reset.rst             |  44 +++++++-
>  include/hw/core/resetcontainer.h |  48 +++++++++
>  include/hw/i386/pc.h             |   4 +-
>  include/qom/object.h             | 114 ++++++++++++++++-----
>  include/sysemu/reset.h           | 113 +++++++++++++++++++++
>  hw/core/machine.c                |   7 +-
>  hw/core/reset.c                  | 166 +++++++++++++++++++++++++------
>  hw/core/resetcontainer.c         |  76 ++++++++++++++
>  hw/i386/pc.c                     |  40 +++-----
>  hw/i386/pc_piix.c                |  16 ++-
>  hw/i386/pc_q35.c                 |   9 +-
>  system/bootdevice.c              |  25 +++--
>  hw/core/meson.build              |   1 +
>  15 files changed, 587 insertions(+), 120 deletions(-)
>  create mode 100644 include/hw/core/resetcontainer.h
>  create mode 100644 hw/core/resetcontainer.c
> 
> -- 
> 2.34.1


