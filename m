Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE72CDE00A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 04:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJlE1-0004LF-Vg; Thu, 13 Nov 2025 23:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJlDs-0004IA-Cg; Thu, 13 Nov 2025 23:15:45 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJlDp-0005IJ-7G; Thu, 13 Nov 2025 23:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763093741; x=1794629741;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=v95B4pMzUV5GxDaF4MSD491zoTSmZN/+twEGJCME1sk=;
 b=lvikJvoEofkvmdRp4mVVot+ll5vcpAe+Gq5R9+2lewtZptGwX60z/hOQ
 LoRSAfU/7iw3J88cQPS6/Vl7muhi8D3g3pj/K5Qsbd7gqdAD/+lEOEXES
 yZBk55RaN+nZ2+p2gNf9IvSFMVnHkCs4rYVl3lTRSxG66Fy3F91IGP2iq
 OB1Gm14JdlAcQb3ll9OJTJvXaH+RUfS8z1KAJa1nV46e+g8c1zcHLK8TS
 AAkBjEtIvV9s4iuJQkrDq1TxUzWWOiJKZTHhRaeasIxIjApJrq8G2fTvZ
 i7ACNt4sTrv/Y/dNscoGqG3kcn/DajS8EW7iGigpkPmSwk7vMu34Uk3eW Q==;
X-CSE-ConnectionGUID: Jk4izkl9RUC5r3PSjmAisA==
X-CSE-MsgGUID: YCFshpKDQMCjaCRC/nXljQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64389620"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="64389620"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 20:15:38 -0800
X-CSE-ConnectionGUID: /Fwn3Pp2RoG7evC20wlCjg==
X-CSE-MsgGUID: 9TlJLg5XTMC6nDNtJ+W6Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="189870695"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 13 Nov 2025 20:15:36 -0800
Date: Fri, 14 Nov 2025 12:37:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/22] rust/hpet: Abstract HPETTimerRegisters struct
Message-ID: <aRayIQYzGkUK4Emv@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-11-zhao1.liu@intel.com>
 <12e93226-b70d-4c9c-bf8a-db7e0e05b585@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e93226-b70d-4c9c-bf8a-db7e0e05b585@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Thu, Nov 13, 2025 at 12:24:07PM +0100, Paolo Bonzini wrote:
> Date: Thu, 13 Nov 2025 12:24:07 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 10/22] rust/hpet: Abstract HPETTimerRegisters struct
> 
> On 11/13/25 06:19, Zhao Liu wrote:
> > Place all timer N's registers in a HPETTimerRegisters struct.
> > 
> > This allows all Timer N registers to be grouped together with global
> > registers and managed using a single lock (BqlRefCell or Mutex) in
> > future. And this makes it easier to apply ToMigrationState macro.
> 
> This is pretty much the crucial patch in the series and it's the only
> one that needs more work, or some fixup at the end.
> 
> In particular, more fields of HPETTimer need to be moved to the
> HPETTimerRegisters. It's possible that it would be a problem to move
> the timer itself inside the mutex but, at least, the HPETTimer could be
> changed to just
> 
> pub struct HPETTimer {
>     timer: QemuTimer,
>     state: NonNull<HPETState>,
>     index: u8,
> }

Good idea!

> as in the patch included at the end (compile-tested only).  Then, the
> BqlRefCell<HPETTimer> can be changed to just HPETTimer because all the
> fields handle their interior-mutable fields.

Yes, this will reduce BQL context in lockless IO a lot. And I'll based
on your patch to extract HPETTimer from BqlRefCell.

> Preserving the old migration format can then be solved in two ways:
> 
> 1) with a handwritten ToMigrationStateShared implementation for
> HPETTimer (and marking the tn_regs array as #[migration_state(omit)])

Yes, compared with 2), I also this is the better choice, which looks
more common and could be an good example for other device.

> 2) by also adding num_timers_save and the timer's expiration to
> HPETRegisters and HPETTimerRegisters, respectively.
> 
> I think I prefer the former, but I haven't written the code so it's
> not my choice. :)
> 
> I'm okay with doing these changes on top of these patches as well.

Thank you!

The code attached looks good. Only a minor question below:
 
> @@ -181,6 +181,9 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
>  #[repr(C)]
>  #[derive(Debug, Default, ToMigrationState)]
>  pub struct HPETTimerRegisters {
> +    // Only needed for migration
> +    index: u8,

I didn't get the point why we need to migrate this "index" instead of
HPETTimer::index?

Anyway, if we continue to keep index in HPETTimerRegisters, we can make
it have usize type with a "#[migration_state(try_into(u8))]" property.

If we just HPETTimer::index for migration, I think it's possible to do
type convertion in handwritten ToMigrationStateShared.

Thanks,
Zhao


