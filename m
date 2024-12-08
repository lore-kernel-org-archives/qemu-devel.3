Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C98FE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 15:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKJHJ-0002MC-UT; Sun, 08 Dec 2024 10:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKJHG-0002Lh-5t; Sun, 08 Dec 2024 10:32:58 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKJHC-00037G-EF; Sun, 08 Dec 2024 10:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733671975; x=1765207975;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dYWmi23TQoVyAfM+oeJ4DI3Wu614MnS7MQcn3XO2veA=;
 b=EHNhn6D1U64eIxkhgG8eUb+Du0yojPBVxrijLsGfq0ryHXDAx4C9Rx/l
 QIdV6/eIzbkFH43KYj+8p48wX7tPObABP+qO3bCBerRUaATfjj7jHkRUs
 La7bdT3GnxGC9W7a9zQXJz/8/GWeg+yMxU3/XwcBrbcrDDh6p/CXgtHRP
 I4jUwe0wbXrTi/dCGO1eqOSSN06nr0S69jQQlioz/twJJQCOqoCVp3IBi
 uzQs+9DQ1W1lzYQN7PdIIEWPSXKAtoFBA6hGb8nPl5XWIkpNCEMcd/nhz
 swhR7kNiGP2Et13OG2uaGiKOxrCyF0rkdFQdy7JUAzMShwlRmlTV9lQ7R w==;
X-CSE-ConnectionGUID: ZiG3cgkhTbKKQ1QHoRl3DA==
X-CSE-MsgGUID: LreneVcvTqKej4QlTqxjHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44440957"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; d="scan'208";a="44440957"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 07:32:50 -0800
X-CSE-ConnectionGUID: XaTshz/9QqOTqdlEm7QrxQ==
X-CSE-MsgGUID: qgkmR0rHT+2YayiqvIaxxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; d="scan'208";a="99670656"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 08 Dec 2024 07:32:46 -0800
Date: Sun, 8 Dec 2024 23:51:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
Message-ID: <Z1XAZA9K40hfrOrl@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <06e90014-40b3-4928-b61f-6598193151f1@linaro.org>
 <CABgObfbYfR=OjsQk78TyqUwyfAr0Mxn2bgX062Ck5kuAwW3f3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbYfR=OjsQk78TyqUwyfAr0Mxn2bgX062Ck5kuAwW3f3g@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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

On Sun, Dec 08, 2024 at 10:30:34AM +0100, Paolo Bonzini wrote:
> Date: Sun, 8 Dec 2024 10:30:34 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 06/13] rust: add bindings for memattrs
> 
> Il sab 7 dic 2024, 10:21 Philippe Mathieu-Daudé <philmd@linaro.org> ha
> scritto:
> 
> > >> is still decently packed and simplifies things a lot.
> > >
> > > The old struct is 4 bytes, and the new one is 8 bytes. We do
> > > a lot of directly passing 'struct MemTxAttrs' arguments around
> > > as arguments to functions (i.e. not passing pointers to them),
> > > so increasing it in size is not completely free.
> >
> > Should we add a check to not pass 8 bytes?
> >
> >    QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) != sizeof(uint64_t));
> >
> 
> Yes, why not.
>

Thank you all! Will also include this in the followup clean-up patches.

Regards,
Zhao



