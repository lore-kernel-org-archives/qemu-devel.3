Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8092C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEEu-0002Dx-4c; Tue, 06 May 2025 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCEEp-0002DP-TG; Tue, 06 May 2025 05:05:20 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCEEn-0001A6-CG; Tue, 06 May 2025 05:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746522317; x=1778058317;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=v5zH9RdPH71zib3r0Zp4xLqriAHg+HUYZtnitwmeMJU=;
 b=h5TYMbdIW4+/fMtbSuJV71PJv+YB8KODEQXXe/06apz48ng2HDjDMQPi
 Kvit4vcbqCbsH/zmQR2bEAEneAUEmsEMZ3adR0xNGIpEfE4iRk6fxVXmi
 yTeCle/5/u9Ac5t0cIvm5AQlHxdcJsct47IzSN2+daBPgLWbod08cEVEx
 Vsmxu90Q+h6abZdyg8nraTRu0fVfJQHxfzYEWGaHmAEEVFFDDU8Oyq9Rd
 oOaBA0XfY+W01w59PWfj74MceJBcBw79SKynhbZ6K/jsXumcUnjgvih3W
 R6bM1yjHTgSDKonKdSlUq/n10byMYdsUU9xy+G0pso1jyYnRxKvFuvhvE Q==;
X-CSE-ConnectionGUID: DBK6fdmIT1uEsAOX5SezUA==
X-CSE-MsgGUID: yOyJZSeyS7C0LJP/SxeZkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65585352"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="65585352"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 02:05:13 -0700
X-CSE-ConnectionGUID: mZ0MeCGKSEGGlLdDRIqGRg==
X-CSE-MsgGUID: 1qT7WaKaRFKNdZjlH78HPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="140310958"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 06 May 2025 02:05:12 -0700
Date: Tue, 6 May 2025 17:26:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
Message-ID: <aBnVtNgdjQ9DlugK@intel.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <aBnOyhMawDaY9yyR@intel.com>
 <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

> > "enable Rust" supports v1.77 and "enable all devices written in Rust"
> > supports v1.83, correct?
> 
> Both support v1.83 only.  However, if Rust is missing or old, "enable
> all devices written in Rust" will fail compilation (e.g. Kconfig would
> fail for ARM/x86 targets due to unsatisfiable CONFIG_PL011);

In this case, a brand new Rust device (without a corresponding C
version) would be unable to compile on the above platforms which don't
support v1.83. I'm not sure if this is an acceptable limitation or
policy. (Has there been a similar case in history?)

> "enable Rust" will simply pick the C version of the PL011 and HPET devices.

I support this, at least the compatibility with the old QEMU won't be
broken! Then all C devices rewritten in Rust can be covered by this
category.

> > The current vmstate builder is excellent, but I'm concerned it might not
> > land soon. Can we find a compromise?
> 
> Do you think the above would be a good compromise?
 
Overall, I think it's OK (it's not even a compromise).

Thanks,
Zhao


