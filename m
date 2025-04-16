Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A856AC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 10:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zaP-0002Lv-WE; Wed, 16 Apr 2025 06:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4zYl-0000OS-ME; Wed, 16 Apr 2025 06:00:00 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4zYi-00011v-Lp; Wed, 16 Apr 2025 05:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744797596; x=1776333596;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Ne8pzpJiZGIpH61ngDLPEs3Z3DMm/OvMamEe6rhPgIQ=;
 b=Z17kxjbP8fusxp9inOvyzIp8TXs1UtjXQFPSgyMacb5kZo29MnyvGoOu
 RCJuZJEpF7OxEckEAeh9gVNa0b4icqyfHFeevfNWPc3c/0WcmWwSY+r/U
 VefYrL0Ftfz4grKriswqWDERIdNvyhQ7ASbihu+ZB1jQbwMpJUhB2018e
 CiY6ABKW1QIjuBK1jE+J/dripkKF2r8y+VBG5WSdlZLZQIKft0Gh2gcBq
 u1w9JoXTGq6RDjf5iJfoBnQqQNvth2ImZcAtVrLbBp2+QpB2h1cJGLWOa
 FKyYmisMAy3X0wwqEdvnoK5H4yd0M8geYyL8laYP5cET3LeIUwQMM3rut g==;
X-CSE-ConnectionGUID: NAMWSdEpTky8bVkkOr7HSw==
X-CSE-MsgGUID: diFZ7soJQtWrIFWOKXV8wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46219484"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="46219484"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 02:59:52 -0700
X-CSE-ConnectionGUID: gfKsDdOZRSa26ldDLBXy4g==
X-CSE-MsgGUID: CS9U8NVDRAOvPSJ96iOhpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="135477205"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 16 Apr 2025 02:59:51 -0700
Date: Wed, 16 Apr 2025 18:20:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 8/9] rust/hpet: Support migration
Message-ID: <Z/+Ee4YlUBSVtArJ@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-9-zhao1.liu@intel.com>
 <Z/5KlfQgC65g6Kid@intel.com>
 <78fdfdaf-7c94-4d79-be39-8215c033b423@redhat.com>
 <CABgObfb9z6r0vY1ojr1XMoCyYujEt4dX1UONcZEJgzDx8mry3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb9z6r0vY1ojr1XMoCyYujEt4dX1UONcZEJgzDx8mry3Q@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 15, 2025 at 07:43:00PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Apr 2025 19:43:00 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 8/9] rust/hpet: Support migration
> 
> On Tue, Apr 15, 2025 at 4:21 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > An additional difficult case is vmsd(). Passing the raw VMStateDescription
> > > looks not good, while passing the VMStateDescription<> wrapper requires
> > > bounding DeviceImpl with 'static. Ultimately, I added an extra
> > > StaticVMStateDescription trait to successfully compile...
> >
> > Hmm I cannot fully understand it so I'll check it out later.
> 
> So the problem is that, in a "&'a Foo<T>", T must also be "T: 'a".
> One solution is for vmsd() to return an
> Option<VMStateDescription<Self>>, and do Box::into_raw(Box::new(vmsd))
> in the class_init method. Once we have const_refs_static, "fn vmsd()"
> can become a const and the Box is not needed anymore.

Thanks so much, that's a good idea!

About `Box::into_raw(Box::new(vmsd))`, do you think it's necessary to use
Box::leak(Box::new(*))? (though the Box<> isn't actively dropped during
the class's existence)

    pub fn class_init<T: DeviceImpl>(&mut self) {
        ...
        if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
            let static_vmsd: &'static mut bindings::VMStateDescription = Box::leak(Box::new(vmsd.get_vmsd()));
            self.vmsd = static_vmsd;
        }
    }

> Also please turn get_vmsd_ptr() into get_vmsd_ref() so that we get
> more checks that things are not copied behind our back (leaving behind
> a dangling pointer)

Sure!

> I attach the conversion I did of the other devices and tests. I am not
> sure if it's possible to avoid having a huge patch to do everything at
> once (except HPET since that can be added separately).

Thank you again! From my initial thoughts: Splitting is also possible,
but it requires first renaming VMStateDescription<T> to
VMStateDescriptionWrapper<T>, then replacing it in pl011 and test (and
hpet) one by one, and finally renaming it back to VMStateDescription<T>.
If you prefer this approach, I can help you split your patch below.

> +const VMSTATE_HPET: VMStateDescription<HPETState> =
> +    VMStateDescriptionBuilder::<HPETState>::new()
> +        .name(c_str!("hpet"))
> +        .version_id(2)
> +        .minimum_version_id(1)
> +        .pre_save(&HPETState::pre_save)
> +        .post_load(&HPETState::post_load)
> +        .fields(vmstate_fields! {
> +            vmstate_of!(HPETState, config),
> +            vmstate_of!(HPETState, int_status),
> +            vmstate_of!(HPETState, counter),
> +            vmstate_of!(HPETState, num_timers_save).with_version_id(2),
> +            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> +            vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),

And it seems like you don't oppose the hack in patch 1? ;-)

> +        })
> +        .subsections(vmstate_subsections!(
> +            VMSTATE_HPET_RTC_IRQ_LEVEL,
> +            VMSTATE_HPET_OFFSET,
> +        ))
> +        .build();

Thanks,
Zhao



