Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A846C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 04:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlL6g-00049P-Nr; Thu, 20 Feb 2025 23:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlL6c-00048c-VV; Thu, 20 Feb 2025 23:57:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlL6b-00015P-50; Thu, 20 Feb 2025 23:57:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B16E75C62B6;
 Fri, 21 Feb 2025 04:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FE7C4CEE4;
 Fri, 21 Feb 2025 04:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740113854;
 bh=a0SRT1xcLYPZMLZVfUK4U1sanv0c+3i36Oq5Gopf9mE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y40I6oRuqHoTRQj41+lBW9ZWJrZUON7emuyU3tsiMVJHONZNYs//mAE7+Q3thPSL8
 7lJOEXrTCFNGzZ3JtwqyVknSRteDG0kgOEhiD3/DZS004c+27Of+I6ygTFfsIso6R3
 FN5aEW8uQKHNCwcUbk08cY/oHo1iPO4Q4KxPeddSJTTx9FdSTCzrjrdW69rHj2nhVp
 P/QDG5lk79eFvcOTLMg/qntEHFaF7AhmWXdg7M0Gvfky7uGilqipeJc2ueL+ry6T+f
 nC7AzyTvS4Wu0ljvq3ymt9E1jkOiFwcLc+WZNXdPqM2d0AKuz/QplarYcMmLp7yE5c
 1kuWZvOzHb95g==
Date: Fri, 21 Feb 2025 05:57:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju
 Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/14] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20250221055728.03289b6c@foz.lan>
In-Reply-To: <87bjvg6c22.fsf@pond.sub.org>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <80858743b6fd67db3f48ac8cb466bbcde5b11132.1738345063.git.mchehab+huawei@kernel.org>
 <87bjvg6c22.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Em Wed, 05 Feb 2025 09:16:53 +0100
Markus Armbruster <armbru@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Using the QMP GHESv2 API requires preparing a raw data array
> > containing a CPER record.
> >
> > Add a helper script with subcommands to prepare such data.
> >
> > Currently, only ARM Processor error CPER record is supported, by
> > using:
> > 	$ ghes_inject.py arm
> >
> > which produces those warnings on Linux:
> >
> > [  705.032426] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> > [  774.866308] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > [  774.866583] {4}[Hardware Error]: event severity: recoverable
> > [  774.866738] {4}[Hardware Error]:  Error 0, type: recoverable
> > [  774.866889] {4}[Hardware Error]:   section_type: ARM processor error
> > [  774.867048] {4}[Hardware Error]:   MIDR: 0x00000000000f0510
> > [  774.867189] {4}[Hardware Error]:   running state: 0x0
> > [  774.867321] {4}[Hardware Error]:   Power State Coordination Interface state: 0
> > [  774.867511] {4}[Hardware Error]:   Error info structure 0:
> > [  774.867679] {4}[Hardware Error]:   num errors: 2
> > [  774.867801] {4}[Hardware Error]:    error_type: 0x02: cache error
> > [  774.867962] {4}[Hardware Error]:    error_info: 0x000000000091000f
> > [  774.868124] {4}[Hardware Error]:     transaction type: Data Access
> > [  774.868280] {4}[Hardware Error]:     cache error, operation type: Data write
> > [  774.868465] {4}[Hardware Error]:     cache level: 2
> > [  774.868592] {4}[Hardware Error]:     processor context not corrupted
> > [  774.868774] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> >
> > Such script allows customizing the error data, allowing to change
> > all fields at the record. Please use:
> >
> > 	$ ghes_inject.py arm -h
> >
> > For more details about its usage.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> [...]
> 
> > diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
> > new file mode 100644
> > index 000000000000..b0e8450e667e
> > --- /dev/null
> > +++ b/scripts/arm_processor_error.py
> > @@ -0,0 +1,476 @@
> > +#!/usr/bin/env python3
> > +#
> > +# pylint: disable=C0301,C0114,R0903,R0912,R0913,R0914,R0915,W0511
> > +# SPDX-License-Identifier: GPL-2.0  
> 
> Sorry if this has been answered already...  why not GPL-2.0-or-later?
> 
> More of the same below.

No particular reason. It is just that GPL-2.0 is my preferred license.

I'll change the license of the three scripts to be GPL-2.0-or-later.

> 
> [...]
> 



Thanks,
Mauro

