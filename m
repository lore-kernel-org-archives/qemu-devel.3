Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC10606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=F33kY3fk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Q0-0007uU-TA; Mon, 16 Nov 2026 15:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Om-0006Am-Id; Mon, 16 Nov 2026 15:33:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ok-0005sV-Ss; Mon, 16 Nov 2026 15:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794861231; bh=aoktzCiwT5VggrSM2PXay7tFGd//15UsJTN2JDW9QmI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=F33kY3fk9GPLJJ7Slp/hINyY5xlWXSgTXaJ2GrRQb/reIyxjIq6FQ/fQq+j/Sq/2m
 vkkiXu83o2MXNsFCSde6+yVpunF1JmNW6my+qFuHCQH12JRMflJ5i4y+Gsrw4FjnVW
 ajgMb00/sQppnKXJLJ6n7Vy4r3whrH9ru6giDzxbR0VgZbG85VevgTURVvSFK00xws
 AXO+qvrWUUjmbG3NH6vdSUiNP1LgdQ9yLHe+LEkfjKcObpAo6QTLtmiKyOAqPrgswn
 gpsFo50heJr7nitbePkV8QhrHZuGWRfbF6q3+AKiZXyLEJ2v7U2psdrG3KS4POmxjC
 QDabWpFd7mQhQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE5141E71E8;
 Mon, 16 Nov 2026 23:33:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D23EA45FC11;
 Mon, 16 Nov 2026 23:33:51 +0300 (MSK)
Message-ID: <b26d0fb3-f6b4-43a4-86e6-6eff1dfa2a69@tls.msk.ru>
Date: Mon, 16 Nov 2026 23:33:51 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-10.0.16 00/59] Patch Round-up for stable 10.0.16, freeze
 on 2026-11-26
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
 <CAFEAcA-LG0yvbbOW3UyvitEHAXAq9C5Nos+Ac6k92e+aWA6MVA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFEAcA-LG0yvbbOW3UyvitEHAXAq9C5Nos+Ac6k92e+aWA6MVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 23:29, Peter Maydell wrote:

>> Patch freeze is 2026-11-26, and the release is planned for 2026-11-28:

> I think the net/ fixes that are in my target-arm pullreq are
> worth putting into stable (they should have cc tags); they ought
> to make it into master within a few days.
Yeah, I'm watching these patches too.  Hopefully they'll made their
way into the stable branch before the freeze in 10 days.

Thank you for the reminder!

/mjt

