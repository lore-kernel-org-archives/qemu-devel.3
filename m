Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8F1E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 02:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKpqz-00046y-1B; Mon, 09 Dec 2024 21:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKpqx-00046g-5A; Mon, 09 Dec 2024 21:19:59 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKpqu-00064p-E3; Mon, 09 Dec 2024 21:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733797196; x=1765333196;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uysF80S1yd/OJmgxa+64hcQYxG7HISslCaMN3yYx/Uc=;
 b=eotoB0i920+9PvzBpKAL7QqyMM+M1CSBxpEnrleEG+3VWN1TUQCQVJ3S
 /9jVjw0J9pPUsp2kvwqucivlCO8H2vALkErj+8Qk4ytbizXYayNbYBFNw
 zAAkpLERl2+1vFwlYlZDKHxcs5RrwPYgC7K6PcqVoAhGn7/e2bfI+qiSW
 5MeLHNPZFD+m/hklZvMKst4P23cjuYbd0NbYAq7i6/cqjBJdc3bzweS0p
 b0bViEQjcHcbw/N6CtER541GMbQCzwxKsCrPG1zQa8wTNPC7zq2Ni5BJB
 2YYAtwolGWxOROy8x8UlFYTzPgg794jKpRvXExx7S6/+JjSemNgRpqQK3 Q==;
X-CSE-ConnectionGUID: 2HIMuuw6QOuwyBh4agpZ8w==
X-CSE-MsgGUID: d4/a+9fFQK6V34myUOy0Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44800205"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="44800205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 18:19:50 -0800
X-CSE-ConnectionGUID: 6i/bHd7sS+ySDe4uleCwIA==
X-CSE-MsgGUID: LijIjvBrQzSl2eO3Vlix8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="100314131"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 09 Dec 2024 18:19:49 -0800
Date: Tue, 10 Dec 2024 10:38:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 00/26] rust: bundle of prerequisites for HPET
 implementation
Message-ID: <Z1epij0qxzewmyd4@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <f85a2be4-f2ad-4c00-aecf-c045b7cd2e1f@linaro.org>
 <CABgObfaT7cSDpuUzZ-imuhdBnsg86Qi7mt7KZ+-V-SU60+TXkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaT7cSDpuUzZ-imuhdBnsg86Qi7mt7KZ+-V-SU60+TXkg@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Dec 09, 2024 at 06:23:21PM +0100, Paolo Bonzini wrote:
> Date: Mon, 9 Dec 2024 18:23:21 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 00/26] rust: bundle of prerequisites for HPET
>  implementation
> 
> On Mon, Dec 9, 2024 at 5:24 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > On 9/12/24 13:36, Paolo Bonzini wrote:
> >
> > > Paolo Bonzini (26):
> > >    bql: check that the BQL is not dropped within marked sections
> > >    rust: cell: add BQL-enforcing Cell variant
> > >    rust: cell: add BQL-enforcing RefCell variant
> > >    rust: define prelude
> > >    rust: add bindings for interrupt sources
> > >    rust: add a bit operation module
> > >    rust: qom: add default definitions for ObjectImpl
> > >    rust: qom: rename Class trait to ClassInitImpl
> > >    rust: qom: convert type_info! macro to an associated const
> > >    rust: qom: move ClassInitImpl to the instance side
> > >    rust: qdev: move device_class_init! body to generic function,
> > >      ClassInitImpl implementation to macro
> > >    rust: qdev: move bridge for realize and reset functions out of pl011
> > >    rust: qom: automatically use Drop trait to implement instance_finalize
> > >    rust: qom: move bridge for TypeInfo functions out of pl011
> > >    rust: qom: split ObjectType from ObjectImpl trait
> > >    rust: qom: change the parent type to an associated type
> > >    rust: qom: put class_init together from multiple ClassInitImpl<>
> > >    rust: qom: add possibility of overriding unparent
> > >    rust: rename qemu-api modules to follow C code a bit more
> > >    rust: re-export C types from qemu-api submodules
> > >    rust: tests: allow writing more than one test
> > >    rust: qom: add casting functionality
> > >    rust: qom: add initial subset of methods on Object
> > >    rust: qom: move device_id to PL011 class side
> > >    rust: qemu-api: add a module to wrap functions and zero-sized closures
> > >    rust: callbacks: allow passing optional callbacks as ()
> >
> > Am I correct some patches are from Zhao Liu and got the
> > authorship inadvertently removed?
> 
> Just one, which is co-authored; it has
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> So I should have put either Co-authored-by him or left him as the
> primary author.
> 

Thank you Paolo! You deserve to be credited as the author. It's
completely different from my previous solution, so it's all your
work! HPET will be a user.

Regards,
Zhao


