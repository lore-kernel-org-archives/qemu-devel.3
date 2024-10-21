Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E0D15DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ue6-0001Rj-A4; Mon, 21 Oct 2024 11:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2uds-0001MW-O0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:48:29 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2udp-0008OO-Iv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729525701; x=1761061701;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=T3G0u/cUjk3EH8Vy3qwElQg5P1ET/Wtc0oEqlD9wyXg=;
 b=ESPcFcwXtJQxq4deSf9sF65b4qpyegSbXubQCrDeH/D4PiKJCJ4QHWKw
 Ms7AWWUab7iqzC/fkxK8MLYosZWwhPdh605czdBqkVYVvebR1Xlwlfhkr
 Z5696mQ1h4yA79JTmbEr2QudogvDoKlrekTv1LlF+IrVhBm8U6cEh04bn
 AiiYoiQZGiczPCUKJTLJ+TdK0ahwYxFOM7maM/uq9y5MnPusbghy0VSFc
 GStK3GH/PkYF06PgoKAGflWiSlFtfkgbnHoylZPbJUcQSBKiQ9tGShw9k
 5MW7jpzVE17PG3RzJNkXzUBKny+iEJnGJuferhfX0xr3stBY4wejSUePt g==;
X-CSE-ConnectionGUID: ThOq1UlfTI+qaGF7KrgXCQ==
X-CSE-MsgGUID: dV2MK9rKQe27iJ8DTUW8gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39557531"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39557531"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 08:48:16 -0700
X-CSE-ConnectionGUID: FPHJ926BRtWgWwS5jEuAPg==
X-CSE-MsgGUID: dpovGzziQbiH65w8g6Kl6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="79201240"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 21 Oct 2024 08:48:15 -0700
Date: Tue, 22 Oct 2024 00:04:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/16] rust: build tests for the qemu_api crate
Message-ID: <ZxZ7kIeCIfiLAbPw@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-9-pbonzini@redhat.com>
 <ZxZqcuYx16BVXMK1@intel.com>
 <CABgObfZzG92rj0vNuQMEKPmxQ+U+Yyuak6gMaNSmf4Jcex6Xug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZzG92rj0vNuQMEKPmxQ+U+Yyuak6gMaNSmf4Jcex6Xug@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

On Mon, Oct 21, 2024 at 04:36:24PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 16:36:24 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 08/16] rust: build tests for the qemu_api crate
> 
> On Mon, Oct 21, 2024 at 4:35 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 03:17:26PM +0200, Paolo Bonzini wrote:
> > > Date: Tue, 15 Oct 2024 15:17:26 +0200
> > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > Subject: [PATCH 08/16] rust: build tests for the qemu_api crate
> > > X-Mailer: git-send-email 2.46.2
> > >
> > > Fix some bitrot in tests.rs, and allow the unit tests to be run via
> > > "meson test".
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  rust/qemu-api/meson.build  | 3 +++
> > >  rust/qemu-api/src/tests.rs | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> >
> > Codes look good to me,
> >
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Note that, in the extracted series (to which I am moving your
> Reviewed-by tags, so no need to go through it again), I'm changing
> this to an integration test and making it actually create the object
> it defines.

Thank you! I mixed up the versions; I will move over to there.



