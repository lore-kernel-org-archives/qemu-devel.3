Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA7E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 15:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJwZK-000227-39; Sat, 07 Dec 2024 10:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwZJ-00021v-06; Sat, 07 Dec 2024 10:18:05 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwZF-00084i-Se; Sat, 07 Dec 2024 10:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733584681; x=1765120681;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WUYGX/IYYqVOWV7Uhwlgnr4ydak7ZxnHOH21+Mofdmw=;
 b=JffetjIpH00l/jILq76GhaPFkm4SFTcaEgs4HLInh4hU2jgIY0WjGxWm
 1o6qhyEYZeq2NBxeOmWnql1J+bMrJS91cng+SVAqcmZc7peW7qQvGeCcA
 0+iOaa9O5mHxgjb8Ym/X0Tzbv9lpC/dinPVUgPPrZ5/G35+Ct3hq8qLMM
 L+7K0JPtWEwAes4x2jndyWV23m7p6QhwnPq3JpIVH83vuvNjb3ZcygGeP
 9UEK8rXBLGsLbswmzjXL1LG4mNmfncApfYgTFlNBrytH7SUb5ht+kz0oi
 Ist5Ne03mjAx5n005iJuWU8xNXyEeHPw25ef2GSeudE/l0ss+Cs9k5N5/ w==;
X-CSE-ConnectionGUID: TwcpxMwtTg6ezkCZFLjLHQ==
X-CSE-MsgGUID: Lumvvq+LRMaCEdFYRFm/+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34077317"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="34077317"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 07:17:58 -0800
X-CSE-ConnectionGUID: gi5Tz/0nR6m1NwvRCN9aLw==
X-CSE-MsgGUID: k8IPtAZBTkSIGXEJqapfQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="99737188"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 07 Dec 2024 07:17:57 -0800
Date: Sat, 7 Dec 2024 23:36:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
Message-ID: <Z1RraaYrQFS9btEc@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org>
 <Z1GgjZOCc8vkkB3A@intel.com>
 <8cb0a692-420a-4645-b1b8-bc6e47bbb116@linaro.org>
 <CABgObfa7ojzTWOdzd9MUq76ebO8oEU24ew=N80JOOEd=7XuO5g@mail.gmail.com>
 <45018b0d-d741-49a2-8680-993a2eeb285a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45018b0d-d741-49a2-8680-993a2eeb285a@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Sat, Dec 07, 2024 at 10:16:03AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat, 7 Dec 2024 10:16:03 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
> 
> On 5/12/24 22:19, Paolo Bonzini wrote:
> > On Thu, Dec 5, 2024 at 10:18 PM Philippe Mathieu-Daudé
> > <philmd@linaro.org> wrote:
> > > 
> > > On 5/12/24 13:46, Zhao Liu wrote:
> > > > Hi Philippe,
> > > > 
> > > > On Thu, Dec 05, 2024 at 01:04:58PM +0100, Philippe Mathieu-Daudé wrote:
> > > > > Date: Thu, 5 Dec 2024 13:04:58 +0100
> > > > > From: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
> > > > > 
> > > > > On 5/12/24 07:07, Zhao Liu wrote:
> > > > > > HPET device needs to access and update hpet_cfg variable, but now it is
> > > > > > defined in hw/i386/fw_cfg.c and Rust code can't access it.
> > > > > > 
> > > > > > Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
> > > > > > allows Rust HPET device implements its own global hpet_fw_cfg variable,
> > > > > > and will further reduce the use of unsafe C code access and calls in the
> > > > > > Rust HPET implementation.
> > > > > > 
> > > > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > > > ---
> > > > > >     hw/i386/fw_cfg.c        |  4 +---
> > > > > >     hw/timer/hpet.c         | 16 +++++++++-------
> > > > > >     include/hw/timer/hpet.h |  2 +-
> > > > > >     3 files changed, 11 insertions(+), 11 deletions(-)
> > > > > 
> > > > > 
> > > > > > diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> > > > > > index d17a8d43199e..dbf709251a8f 100644
> > > > > > --- a/include/hw/timer/hpet.h
> > > > > > +++ b/include/hw/timer/hpet.h
> > > > > > @@ -74,7 +74,7 @@ struct hpet_fw_config
> > > > > >         struct hpet_fw_entry hpet[8];
> > > > > >     } QEMU_PACKED;
> > > > > > -extern struct hpet_fw_config hpet_cfg;
> > > > > > +extern struct hpet_fw_config hpet_fw_cfg;
> > > > > 
> > > > > Could this field belong to the (yet unexisting) HPETClass?
> > > > 
> > > > Several instances would share the same class, so HPETClass could manage
> > > > multiple HPETState info.
> > > > 
> > > > But in fw_cfg.c, do you have idea about how to get the HPETClass?
> > > 
> > > Have hpet_find() return an Object and call object_get_class()?
> 
> Implemented as
> https://lore.kernel.org/qemu-devel/20241206191124.9195-1-philmd@linaro.org/,
> hoping it simplifies the Rust model integration.
> 

Hi Philli, thank you very much!

This approach is very helpful for more “rich” QOM class attempts, and if
Paolo feels the same way, I'll move to your approach for the next
version!

Regards,
Zhao



