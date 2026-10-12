Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0533BCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDSK-0002D0-73; Mon, 12 Oct 2026 06:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xGDSI-0002Cm-O3; Mon, 12 Oct 2026 06:40:30 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xGDSH-0006xx-1v; Mon, 12 Oct 2026 06:40:30 -0400
Received: from example.com (unknown [167.220.208.79])
 by linux.microsoft.com (Postfix) with ESMTPSA id EAAA420B7166;
 Mon, 12 Oct 2026 03:40:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAAA420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791801623;
 bh=6aiHTVkxGVXqlGfnWmhkNb2TS97vFmN58Whbfr3hA9Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PQ1dKS/WRd2KU9u/fGnSWlEs5Z8//VM2RuQtxYjwgFbibV0QQrsSFO6KP7SZskkap
 bkWW4QjLEZV7wuJRUQXP02jNLA0rY+EWc1iYUx98BUQPvIOp1lMYASzk2j3tmyzcvf
 w34H2S+MPnvlhkaVFBBVcp9dIpxw30PldT+0NtYk=
Date: Mon, 12 Oct 2026 12:40:22 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 00/11] MSHV changes for 2026-10-06
Message-ID: <asy5FpdFyEd5hfUQ@example.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
 <ae9c6c15-f071-47b4-8d2c-f6113c24aff3@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae9c6c15-f071-47b4-8d2c-f6113c24aff3@tls.msk.ru>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Oct 11, 2026 at 10:24:58AM +0300, Michael Tokarev wrote:
> On 06.10.2026 19:48, Magnus Kulke wrote:
> > Various minor fixes and a feature (gdb debugger support) for the Microsoft
> > Hypervisor (mshv) accelerator. The changes have been rebased and re-tested
> > individually.
> > 
> > My public certificate is available at:
> > https://mkulke.github.io/magnuskulke.asc
> > 
> > Primary key fingerprint:
> > 5255 B617 7982 9168 7022 31CA 68D9 BB56 DD17 8417
> > 
> > The following changes since commit 3377670ee96b5a68361016680a95b9013709d4b7:
> > 
> >    Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-05 07:14:51 +0200)
> > 
> > are available in the Git repository at:
> > 
> >    https://github.com/mkulke/qemu.git tags/mkulke-pull-20261006
> > 
> > for you to fetch changes up to 7d42b0a4f52d57cd2d9e0a9ceb8ad5102219a801:
> > 
> >    target/i386/mshv: support single-stepping (2026-10-06 18:14:35 +0200)
> > 
> > ----------------------------------------------------------------
> > mshv changes for 2026-10-06
> > 
> > ----------------------------------------------------------------
> > Doru Blânzeanu (9):
> >        target/i386/mshv: fix read/write memory across the page boundary
> >        include/hw/hyperv: move hv_vp_register_page struct definition
> >        target/i386/mshv: abort when hv_vp_register_page setup fails
> >        target/i386/mshv: remove fallback for register page get registers
> >        target/i386/mshv: remove fallback for register page set registers
> >        target/i386/mshv: fix pio handlers clobbering device-modified registers
> >        include/hw/hyperv: add ABI for exception intercepts and pending events
> >        accel/mshv: add gdbstub software breakpoint support
> >        target/i386/mshv: support single-stepping
> > 
> > Magnus Kulke (2):
> >        target/i386/mshv: zero-init msr hvcall args
> >        target/i386/mshv: Fix cpu feature-leak from host
> 
> Is there anything in this patch set to be picked up for the currently
> active stable qemu series (10.0.x lts and 11.1.x)?
> 
> Or do we skip mshv updates in there still?
> 
> Thanks,
> 
> /mjt

Yes, I would still skip backports of mshv code for stable qemu at this
point. access to l1vh-enabled compute is still limited and there are no
critical fixes in this set.

best,

magnus

