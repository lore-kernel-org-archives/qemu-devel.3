Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50481C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0dg-0003Q0-Qt; Mon, 05 May 2025 14:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uC0df-0003PQ-2z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:34:03 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uC0dd-0005KO-DC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:34:02 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C26561F1A;
 Mon,  5 May 2025 18:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4384C4CEE4;
 Mon,  5 May 2025 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746470032;
 bh=wMba/W0JavIYKQeeLc2LLiB3yrkJUeBPAfoA8e27ZDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cVOj5CHmOjsX+8Km6Xi67EpOxka5pidhi+OAx1lNCyYEowSj0zXIcyRN0omzwdG/7
 0g8Egd6y6uD/0EVZZqlpGU2OAGX6bZOtGtZZVo+oVlfwCm39V0DyLh4fzaEIjRF8tr
 Ho44zOs/3y9kXkTqZT/a0Wz235fYalBMjOg3NRM761rsNeEnUivIrH1vkzNH/J3uoU
 foZ82nnNxF4fdwdavf4cUKCWTeMCJD2OhLfsI6aoaXy97E9++dCQkBV0qgSApoIyGA
 nODewxNy3mag4hQOEvPXID/Gb27/QiR45fycPsab611HTbXjVZ2mL78oIeSeniV7Sx
 8SIqNiOYqmdxg==
Date: Mon, 5 May 2025 18:33:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [CFT PATCH 0/4] target/i386/emulate: cleanups
Message-ID: <aBkEjjaOGhSdZToM@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <aBWr8FH9otBP5dqd@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <CABgObfbv8eRMTsgkzXfp_dFHGfjh_eu+z-U=4y9-2OUxvyyUhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbv8eRMTsgkzXfp_dFHGfjh_eu+z-U=4y9-2OUxvyyUhA@mail.gmail.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, May 03, 2025 at 09:01:46AM +0200, Paolo Bonzini wrote:
> Il sab 3 mag 2025, 07:39 Wei Liu <wei.liu@kernel.org> ha scritto:
> 
> > FWIW this series builds fine on for x86 HVF.
> >
> 
> Thanks, can you also test it on either HVF or Hyper-V?
> 

I will leave it to Magnus to test your changes on MSHV.

Wei.

