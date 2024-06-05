Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E46C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErfy-00032Y-Vf; Wed, 05 Jun 2024 10:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sErfo-00031a-32
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:31:34 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sErfk-0001Tp-BG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717597889; x=1749133889;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HGuRq+EYTDn/aZjM76gzUtTZHnRGmcLxJ0uJnBiVno0=;
 b=nAHLKgtDkf1DeqlJH377VWrB8DQildn00Cadd6CD1+3MYf/4VfO43S/4
 goF/DuFGhRGSnM51p/ja+q7VwQ1IjQeBiBEsKGT80IBgEsYmyuifrH03i
 6KtK/fBo1xMuPyT4rtku8zJAH/Az+wuo+XGDMLDXLSfkvy4V1TGrGz4JQ
 mGGLe3+KBIsbZ3o04MYfkNIt5ZjRqzY0FoXMOZEvW4ZaInKrX1y2QiM4D
 KAXir7LhtSJI3CHfIGadc8asIXOEZ0NZvsMK5ajYtBF3eI6VFNEc5WSbh
 HJX45uiPEuSEtCXvXhj48GopU2fqCKJZNwpA/u09ht6Km+HTvXWppyFU5 Q==;
X-CSE-ConnectionGUID: LHpo3gwNRdyX9grr0huhFA==
X-CSE-MsgGUID: KXBoOMixTVughrFMKpOLZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24842938"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="24842938"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 07:31:23 -0700
X-CSE-ConnectionGUID: UTkUcKj2Sk6UUyKzYk/f7Q==
X-CSE-MsgGUID: B/jC6NzRRrybeNP7Mrm1vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37743729"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 05 Jun 2024 07:31:22 -0700
Date: Wed, 5 Jun 2024 22:46:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 17/63] stubs: include stubs only if needed
Message-ID: <ZmB6WHbBW5Wkw0cH@intel.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-18-pbonzini@redhat.com>
 <Zl7nYg9l9xOiuGKG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl7nYg9l9xOiuGKG@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 04, 2024 at 11:07:30AM +0100, Daniel P. Berrangé wrote:
> Date: Tue, 4 Jun 2024 11:07:30 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PULL 17/63] stubs: include stubs only if needed
> 
> On Tue, Apr 23, 2024 at 05:09:05PM +0200, Paolo Bonzini wrote:
> > Currently it is not documented anywhere why some functions need to
> > be stubbed.
> > 
> > Group the files in stubs/meson.build according to who needs them, both
> > to reduce the size of the compilation and to clarify the use of stubs.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Message-ID: <20240408155330.522792-18-pbonzini@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  stubs/{monitor.c => monitor-internal.c} |   0
> >  stubs/meson.build                       | 122 +++++++++++++++---------
> >  2 files changed, 75 insertions(+), 47 deletions(-)
> >  rename stubs/{monitor.c => monitor-internal.c} (100%)
> 
> This change breaks the build of many tests in the following situation:
> 
>   ./configure --disable-system --disable-user --disable-tools
> 
> $ makej
> changing dir to build for make ""...
> make[1]: Entering directory '/var/home/berrange/src/virt/qemu/build'
> [1/46] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
> [2/46] Linking target tests/bench/qht-bench
> FAILED: tests/bench/qht-bench 
> cc -m64  -o tests/bench/qht-bench tests/bench/qht-bench.p/qht-bench.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libevent-loop-base.fa libqom.fa -Wl,--no-whole-archive -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a libevent-loop-base.fa libqom.fa -lm -pthread /usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -Wl,--end-group
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
> /var/home/berrange/src/virt/qemu/build/../util/error-report.c:38:(.text+0x93): undefined reference to `error_vprintf'
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
> /var/home/berrange/src/virt/qemu/build/../util/error-report.c:225:(.text+0x195): undefined reference to `error_vprintf'
> collect2: error: ld returned 1 exit status
> [3/46] Linking target tests/unit/check-qdict
> FAILED: tests/unit/check-qdict 
> cc -m64  -o tests/unit/check-qdict tests/unit/check-qdict.p/check-qdict.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libevent-loop-base.fa libqom.fa -Wl,--no-whole-archive -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a libevent-loop-base.fa libqom.fa -lm -pthread /usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -Wl,--end-group
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
> /var/home/berrange/src/virt/qemu/build/../util/error-report.c:38:(.text+0x93): undefined reference to `error_vprintf'
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
> /var/home/berrange/src/virt/qemu/build/../util/error-report.c:225:(.text+0x195): undefined reference to `error_vprintf'
> collect2: error: ld returned 1 exit status
> [4/46] Linking target tests/unit/check-qstring
> FAILED: tests/unit/check-qstring 
> ...snip many more similar errors...
>

error-printf.c should be a common file in stub_ss, since bench test and
unit test both need qemuutil.

It seems the related previous fix 109f1a437f99 ("stubs: Add missing qga
stubs") is not a complete fix.


