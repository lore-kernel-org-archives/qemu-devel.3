Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C2C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 16:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmxX-0005Sp-IW; Thu, 13 Jun 2024 12:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHmxU-0005Pu-L0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 12:05:53 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHmxS-00086U-2J
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 12:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718294750; x=1749830750;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UvvsdgRWck18Q33F0hqQ78KLGs23IkQhh+KmeDaTrJw=;
 b=eFmbMsxcBce3vqdJlpkFHyuJQ6BAQkjQteCjFaDkMAE29BDO58xHKyBK
 /O9+k10aIjduAp9t9aTphYYqXfCDlCjDQvkCzvq2ImRhgE9GQE+0gS5wT
 OS4MeJGnboX0gZKrci8A8zP2jtmVUOaVk4KJ349F/MZ0ajLWIyeLnFDI7
 OhZIZeOJztvAmOqiT9qrFlz8ADeDn2StAgw26hKKsMfUv98WOwGImrGCE
 /zMVLfQweRXfR0iswQYc4Ineq7ht0AlR8Jdr1TJgav0Ic0Q+UMfoUloQD
 smbKau7Lmm7LAJxAJVnBJX2dE9PJBaeXSpRZn6mT2m4LBJjrsfSRrnZLG A==;
X-CSE-ConnectionGUID: tbbCZyZMRTWRQr6FztKBaA==
X-CSE-MsgGUID: ru4YOlzhQ1+qdnhEICpB6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15101905"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; d="scan'208";a="15101905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 09:04:47 -0700
X-CSE-ConnectionGUID: oPGX4EA1QQK8sx8VLwtoEw==
X-CSE-MsgGUID: z3n+imKgRFGwyz8f9wefBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; d="scan'208";a="40270232"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 13 Jun 2024 09:04:43 -0700
Date: Fri, 14 Jun 2024 00:20:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Message-ID: <ZmscPKyuK7RVgrMo@intel.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Paolo,

On Thu, Jun 13, 2024 at 09:56:39AM +0200, Paolo Bonzini wrote:
> Date: Thu, 13 Jun 2024 09:56:39 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
> 
> Il gio 13 giu 2024, 09:13 Daniel P. Berrang¨¦ <berrange@redhat.com> ha
> scritto:
> 
> > On Wed, Jun 12, 2024 at 11:27:04PM +0200, Paolo Bonzini wrote:
> > > Il mer 12 giu 2024, 22:58 Manos Pitsidianakis <
> > > manos.pitsidianakis@linaro.org> ha scritto:
> > >
> > > > In any case, it is out of scope for this RFC. Introducing wrappers
> > would
> > > > be a gradual process.
> > > >
> > >
> > > Sure, how would you feel about such bindings being developed on list, and
> > > maintained in a (somewhat) long-lived experimental branch?
> >
> > IMHO any higher level binding APIs for Rust should be acceptable in the
> > main QEMU tree as soon as we accept Rust functionality. They can evolve
> > in-tree based on the needs of whomever is creating and/or consuming them.
> >
> 
> My question is the opposite, should we accept Rust functionality without
> proper high level bindings? I am afraid that, if more Rust devices are
> contributed, it becomes technical debt to have a mix of idiomatic and C-ish
> code. If the answer is no, then this PL011 device has to be developed out
> of tree.

I think deeper and higher level bindings will have more opens and will
likely require more discussion and exploration. So could we explore this
direction on another reference Rust device?

I also think there won¡¯t be too many Rust devices in the short term.
Going back to tweak or enhance existing Rust devices may not require too
much effort, once we have a definitive answer.

I wonder if x86 could also implement a rust device (like the x86 timer
you mentioned before, hw/i386/kvm/i8254.c or hw/timer/i8254.c IIRC) to
try this? Or would you recommend another x86 device? :-)

I'd be willing to help Manos try it if you think it's fine.

Regards,
Zhao


