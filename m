Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43459D15D96
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2t8g-0006S5-HM; Mon, 21 Oct 2024 10:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2t8e-0006Rd-SB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:12:04 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2t8d-00066I-1T
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729519923; x=1761055923;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UTFrVXL5K+ylAs5E73U+ZbIJwcpW2Lg1Ac0bigQ/TyQ=;
 b=oIpWPv6Vg0NTFamTODuhvMES7VfYcF9jZCF5BQQnQalVS2EkIs85n8xc
 jxchI1FYLqhrE716Sl6tmGHkosszLTIh7v9yurPI1EX9Ble2xjI7usb8d
 8mEL1/rBEAMZYi310v/pOlruqyJteQjoNs4kl/T3jdlOut4l7rJ7VUrMD
 +E4fPUv5A1Y0MXO/fh2IP6cfspfawCl6twH9DpJf7tik4pcbHdWFYlxcg
 g86VLWV2VqNAOBrw0Lmd7XqqFbqNN2IZdwiQ9GqiS7+vz6ZQV8dfyHhBB
 SOt8ZbINeP5uYstR7ftW6Z3VfoMlbXitoIZbUu6PYjUa4YW++li3jEB/q g==;
X-CSE-ConnectionGUID: gVNaKWU+RlGsp/Yu+iFauw==
X-CSE-MsgGUID: 8FB/wuIEQIW5O4uNa5K5fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31871244"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="31871244"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:06:20 -0700
X-CSE-ConnectionGUID: qZrrlj7sQqOHPzINKcaubQ==
X-CSE-MsgGUID: HIQ/vDAWSbCbEPRRF3oKQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="110293811"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2024 07:06:18 -0700
Date: Mon, 21 Oct 2024 22:22:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the =?gb2312?Q?defi?=
 =?gb2312?B?bml0aW9uIG9mIKGwcHJpdmF0ZaGx?= fields in QOM?
Message-ID: <ZxZjqypRL7d2rMuQ@intel.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.421, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On Mon, Oct 21, 2024 at 10:25:07AM +0100, Peter Maydell wrote:
> Date: Mon, 21 Oct 2024 10:25:07 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [Question] What is the definition of ¡°private¡± fields in
>  QOM?
> 
> On Sat, 19 Oct 2024 at 16:54, Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Hi maintainers and list,
> >
> > In the QOM structure, the class and object structs have two members:
> > parent_class and parent_obj, which are often marked as "< private >" in
> > the comment.
> >
> > I couldn¡¯t find information on why to define ¡®private¡¯ and ¡®public¡¯,
> > even in the earliest QOM commits and the patch emails I could find.
> 
> This is a rather old thing which I think was originally
> borrowed from glib's commenting convention.
> 
> I'm fairly sure that we decided a while back that they were entirely
> unnecessary, so you don't need to add them in new code. (I can't
> actually find anything with a quick list search about that though
> so maybe I'm misremembering.)

Thanks for your explanation! So I understand that directly accessing
parent_obj/parent_class is actually allowed.

> Either way, there's still a lot of them floating around in the codebase
> that were added before we made that decision.

Yes, then I understand that <private> and <public> are historical
burdens that can also be cleaned up.

Thanks,
Zhao


