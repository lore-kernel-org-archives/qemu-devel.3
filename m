Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C645C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 03:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYdYO-0001Pr-HB; Mon, 29 Jul 2024 23:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYdYM-0001No-UY; Mon, 29 Jul 2024 23:29:34 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYdYK-0001y2-DF; Mon, 29 Jul 2024 23:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722310173; x=1753846173;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0MekyinQUkNuzL8U3f4L7bhZChwK4ZWMIhCw9jsQ3R8=;
 b=KDrr13th3BkVd5BCwdWKqhZwmbM/JiyJkX93PnvoA+vbCdVxOr6egW3C
 ukJnXMjE/O7bh+df7VchIBCfhwmPzZ2/Bpn3BHKxMnUG6wcnI8ACmO4Og
 kXOueBVtUepNTZ4dY3F3Kqr4pqlGr1hole1ZP/AjPvn/T12vu9KgFR6vH
 JzDda7NdwHWK1wsDDXKNiiJotKV5mkLHKyvKND1pzw0btkCx14d3A9iRt
 su1vAoTJ6y1aPPU1Wvq42dhAX6HdsrNXR+AzgPjlD9hLLPud5J47QWYzQ
 Q2W3U2GLSm+LBiNKb7I6nlwQvO5WaeNxqauF/2dNr0qyoCOFeBpTozHwu Q==;
X-CSE-ConnectionGUID: 5CQAaSqbR7GhfBEj0luzSg==
X-CSE-MsgGUID: 1t4s6TCqRRqRQ2V0koZJfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37611999"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="37611999"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 20:29:19 -0700
X-CSE-ConnectionGUID: qzwYEDnoRxST/1Sibgy04A==
X-CSE-MsgGUID: tvVmyQSASdOog1Wcq58y+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; d="scan'208";a="84831126"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 29 Jul 2024 20:29:17 -0700
Date: Tue, 30 Jul 2024 11:45:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] doc/net/l2tpv3: Update boolean fields' description to
 avoid short-form use
Message-ID: <Zqhhv3lnyMfxLCvV@intel.com>
References: <20240708092630.2596945-1-zhao1.liu@intel.com>
 <ZpdlQDIjGp4wR8aR@intel.com>
 <CACGkMEsGyKb932T_AJ63sWFObYSJRvghTYywvbDT0BpVV-c9Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsGyKb932T_AJ63sWFObYSJRvghTYywvbDT0BpVV-c9Vw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, Jul 30, 2024 at 10:54:07AM +0800, Jason Wang wrote:
> Date: Tue, 30 Jul 2024 10:54:07 +0800
> From: Jason Wang <jasowang@redhat.com>
> Subject: Re: [PATCH] doc/net/l2tpv3: Update boolean fields' description to
>  avoid short-form use
> 
> On Wed, Jul 17, 2024 at 2:15 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Hi Jason,
> >
> > Just a kind ping. Does this update satisfy you?
> > Since the original example generates the warning.
> >
> > Thanks,
> > Zhao
> 
> Queued.
> 
> Thanks
>

Hi Jason, thank you! I noticed Michael has already helped me merge this
(commit cb8de74ac6df "doc/net/l2tpv3: Update boolean fields' description
to avoid short-form use"). 

Best Regards,
Zhao


