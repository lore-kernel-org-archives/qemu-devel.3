Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CEC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 06:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjujL-0006tw-Em; Mon, 17 Feb 2025 01:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjujG-0006tZ-N8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 01:35:43 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjujD-0006QN-45
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 01:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739774140; x=1771310140;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Um23laF/+FhLpr4XZQ1HNfNWOfBaPnecObKsqL/ht4E=;
 b=V5H6Tf3K2ohM8iGvGf8oYRw+tV/tszWa4kOZ0GQ3OGnY/H7ltGsfqD09
 dvJYIK7okojj9xDI4krnXSdWPSKwr8ZSF69Vy3VvUTKVpwXbgk7qsKHM7
 Gczki6D3hItrYS42l8XX1zhkulzZ1ItZnwbNy7lFNo5w8Jqe6Tu69jURR
 K8+MywE+v9guWgVBDVSjvEO9857HLcyeJOTk1JtgUISJwCp6GzQBwfL83
 kQOWdgRn7y1ESkPRgYTx8WF2jjh4aRjlF2DkvwAX8a//wQcutbtv4kWZR
 G7oIaSL9NBS3ywvPvg3jXR8pYMhMewJ/YuTXHIGAGj1tlIJui8lPUD+p9 Q==;
X-CSE-ConnectionGUID: sBIn0ig3S6u2SaFFnOiomg==
X-CSE-MsgGUID: vcUiyeeMR0qZNM8qqAs7sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51855682"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="51855682"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2025 22:35:35 -0800
X-CSE-ConnectionGUID: DsQ5DYN4QMem+3osokJOIA==
X-CSE-MsgGUID: 3IqARD+DReahlOH6negC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="114008438"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 16 Feb 2025 22:35:34 -0800
Date: Mon, 17 Feb 2025 14:55:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hpet: do not overwrite properties on post_load
Message-ID: <Z7LdS0JkMBqUugRZ@intel.com>
References: <20250216092853.4169458-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216092853.4169458-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> @@ -347,14 +330,13 @@ static const VMStateDescription vmstate_hpet = {
>      .version_id = 2,
>      .minimum_version_id = 1,
>      .pre_save = hpet_pre_save,
> -    .pre_load = hpet_pre_load,
>      .post_load = hpet_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(config, HPETState),
>          VMSTATE_UINT64(isr, HPETState),
>          VMSTATE_UINT64(hpet_counter, HPETState),
> -        VMSTATE_UINT8_V(num_timers, HPETState, 2),
> -        VMSTATE_VALIDATE("num_timers in range", hpet_validate_num_timers),
> +        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),

This change is safe since it doesn't change the vmstate layout so that
there's no need for bumping up the version.

But I still have the question as the comment in v1 [*]. User doesn't
have any way to modify the number of timers, why not just replace this
vmstate field with "VMSTATE_UNUSED_V(2, 1)"?

Or do you think we should keep the status quo for the future use, even
if these properties have not been modified yet?

[*]: https://lore.kernel.org/qemu-devel/Z5Oq4LppNuN7N6NL@intel.com/

> +        VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
>          VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
>                                      vmstate_hpet_timer, HPETTimer),
>          VMSTATE_END_OF_LIST()
> -- 
> 2.48.1
> 
> 

