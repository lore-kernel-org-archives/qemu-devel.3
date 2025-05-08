Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB40C3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 01:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCplW-0007KI-8S; Wed, 07 May 2025 21:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uCplT-0007K0-If
 for qemu-devel@nongnu.org; Wed, 07 May 2025 21:09:31 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uCplS-0004D2-5C
 for qemu-devel@nongnu.org; Wed, 07 May 2025 21:09:31 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BFCB438AC;
 Thu,  8 May 2025 01:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28327C4CEE2;
 Thu,  8 May 2025 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746666566;
 bh=ls52icprft9OMVau01V3TNJQdID0Gzc0JOe1BN8+u54=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vNw8rqEY5ypW0cbpuMqJwFTgdL3isMGGC7WlKIgslDUyvB/7FIMRkiw8UTaymAMz8
 OgR+UGXpeiea/TX7lgqAqGm0T+KZ2mt07wMqUGEJXE0vOjLmSQOycv2C4RhgauBth4
 zDLOYnnIQjdHRbE36Hc79HMkijathui2NnPRK0K8ED1TFSssKLSC7mTF+gurVhO4jf
 ijgrgo/EA9ifAL+ZFVvu3a7GAK/kaGdUFTg1rnh598pAou80Q8Ip26fh7eWAJFzFb9
 z0otQsSq277+PlE4xHPX/VwjUtye909l3Xfg/gyZu7daEEdcaZegfjWeWkCVrvAzsr
 8HURw2AmVd4Wg==
Date: Thu, 8 May 2025 01:09:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Wei Liu <wei.liu@kernel.org>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PULL 05/22] target/i386/hvf: Include missing
 'exec/target_page.h' header
Message-ID: <aBwERHkcHPymjbk8@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250506143512.4315-1-philmd@linaro.org>
 <20250506143512.4315-6-philmd@linaro.org>
 <aBr_MzqaoGwN7gpQ@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <36eee8b9-2ffe-461f-a1c6-2e19ad623a10@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36eee8b9-2ffe-461f-a1c6-2e19ad623a10@linaro.org>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 07, 2025 at 01:20:49PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Wei,
> 
> On 7/5/25 08:35, Wei Liu wrote:
> > On Tue, May 06, 2025 at 04:34:54PM +0200, Philippe Mathieu-Daudé wrote:
> > > Include "exec/target_page.h" to be able to compile HVF on x86_64:
> > > 
> > >    ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
> > >                uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
> > >                                                  ^
> > >    ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
> > >                hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
> > > 
> > > Fixes: 9c2ff9cdc9b ("exec/cpu-all: remove exec/target_page include")
> > > Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > Reported-by: Wei Liu <wei.liu@kernel.org>
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Message-Id: <20250425174310.70890-1-philmd@linaro.org>
> > > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > 
> > FYI Paolo merged a patch from me that does the same thing. My patch is
> > already in the master branch.
> 
> Paolo said he'd replace your patch by this older one which mentions
> the problematic commit, which is why I didn't notice your patch,
> I was expecting this one to disappear on rebase. I don't plan to
> repost this PR except if there is a serious problem with it. In
> this case, we can still revert if we are picky. Duplicated includes
> aren't a problem, missing ones are.
> 

Sure.

> BTW since you are testing / using HVF on x86, do you know if your
> employer could help extending our CI infrastructure coverage for
> your use cases?
> 

No, we don't have a use case for HVF. I only tested it because I wanted
to refactor the instruction emulator out of the HVF code base.

Thanks,
Wei.

> Regards,
> 
> Phil.

