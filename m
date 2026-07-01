Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7731BC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetm1-000268-L3; Wed, 01 Jul 2026 08:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.r28sr6p8bzpanh6=fmhav05ow909=zn3tggzqq5q8bp@em1175899.techtravels.org>)
 id 1wetlz-00025j-3I
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:10:35 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.r28sr6p8bzpanh6=fmhav05ow909=zn3tggzqq5q8bp@em1175899.techtravels.org>)
 id 1wetlx-0002HA-Ir
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782907819; h=from :
 subject : to : message-id : date;
 bh=Kq5Lv8pDJe6O9mnYK373RLl9u+xC/B/Kcaf6oydtFds=;
 b=ZMZEUsR+98d+RV7sz5ZQuHZmcI+eX87LqQCDVC/Hh8p7R5OXpC/yOWW8FBVWaugQoojCv
 KF0kxaatUeHuJur1JT1epIjICya7NtzC3/ozrpRrubx9n1nrkOTvUlr5kUmlAOL0k7lTzGP
 Wkg4oraePVMXoguRbsKtYrQ0wElFKNPeNvz4c+WFHcUekUc4tnhRgazHB7BdIt1RwJTyQdR
 hRQCzabiso0zZK5uRcF/Jr7R/4q1nDwgffjkq/jnmgkSwlmwxDKWZcKvCTszTL1mXSfKyYI
 dHCFCHOUcgP3DsA7AhO/86W8dm4uvRIYXnWyWFUEQW0DnzFCqzb5gCmBVEwA==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wetlg-FnQW0hPxDPU-Dc2K; Wed, 01 Jul 2026 12:10:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1782907814;
 bh=kpthMwghzdxA1NhjXrcjEMD+WvuADDqfpc4H5R7yVq8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QUdJLjrSgZg2vskEWKizhpCfERe1QgXPrlVyhP80Ks2h0/Ll5EzId13tGopDuUb9N
 QEaG8LqcBaatG0Gfdw2Aiuz0hBe6v7q04lwnS/gsyC6BznvrwT94bu/mtX8HwNzRTP
 A+qUcvXMpnutUkFspm3We2ydstiVs101UqD/Q1QFTwdSONSsJxhR+cTEJD6xWOJAjw
 mYgmVwN7tpgEUoe1tdQ+yVA3FmTBLsMOW92/nJwFgKAlacolSeKeI7D+6OTMroFERW
 bSr+bpu0skCz/b3hJ7sSBH3u0S0kuiTvwM2UDxEZGf3Gu4xmRyI5hp4DRpQtUuhL73
 z1YjYN8tLvaPA==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 3111A3F1AC;
 Wed,  1 Jul 2026 08:10:14 -0400 (EDT)
Message-ID: <338c2683-095d-4eb6-b40d-761b79456528@techtravels.org>
Date: Wed, 1 Jul 2026 08:10:14 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, Richard Henderson
 <richard.henderson@linaro.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260701031803.1817812-1-keith@techtravels.org>
 <20260701031803.1817812-3-keith@techtravels.org>
 <CAFEAcA-nmkUPtJgb9---_6eBFNdU5_-EndQibQOXEBn_ifUSmA@mail.gmail.com>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <CAFEAcA-nmkUPtJgb9---_6eBFNdU5_-EndQibQOXEBn_ifUSmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899sPiensU06h
X-smtpcorp-track: j6q8lemfbZFF.DCNUk5AhbLKm.XqJknQVCcm8
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.r28sr6p8bzpanh6=fmhav05ow909=zn3tggzqq5q8bp@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 7/1/2026 6:17 AM, Peter Maydell wrote:

> This is way too much change to be reviewable as a single
> patch, I'm afraid. Can you break it down into meaningful
> pieces, please?

Thanks for taking a look at this. I'm brand new to this process, so 
please bear with me, as my questions come from not understanding more 
than any type of disagreement.

My thoughts are to break it down like this: keep the lasi.c IRR fix 
patch 1 by itself as is, and then further decompose patch 2 into:

* Glue cleanup (lasi_ncr710.c/h): remove dead scaffolding.
* Base engine rewrite + trace-events
* HP-UX overlapped tag support
* ATN-state HP-UX/Netbsd handling

This should help reduce the overall cognitive load in the review process.

However, this still leaves the new 2k lines code in ncr53c710.c, the 
base engine. Because this is a complete rewrite from scratch (using 
existing lsi53c895.c as the base), you can't/shouldn't really diff the 
original to mine. I tried it, fwiw, and the results aren't pretty.

Any further decomposition of the engine you'd end up with non-building 
intermediate states that don't really work by themselves.

Another point is that I haven't done extensive mid-point testing to know 
what deploying half the solution might do. For instance, you MIGHT be 
able to get Linux and NetBSD to boot and/or install without the HP-UX 
support and disambiguation patches, but I'm not sure.

Does my breakdown make sense?

Thanks,
Keith M


