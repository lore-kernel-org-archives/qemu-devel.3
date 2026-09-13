Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EE2C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5onk-0006P2-Uq; Sun, 13 Sep 2026 14:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5on4-00062J-Rb; Sun, 13 Sep 2026 14:18:59 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x5on1-0002C5-HI; Sun, 13 Sep 2026 14:18:57 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hjc3v4SJ6zBqQy;
 Sun, 13 Sep 2026 20:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789323531;
 bh=keAKrq+P1s5aL89sVKnDO6TazU+R3uUBPCY5E1jztx0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CuddhvujOx54KSEmR9FAjE2sddZ7oo59k9mXrNbEIPvfzD8Q9sjFuvDkeyKbs/fEI
 sEO7mMNzvct1bLEOK8n3Dp4sQ4eVczZBGPkzV9C9veXaKy0qCdHl1Lc1/A5fO3hIyN
 OtL39RP8xfQ6iYXOs6i7blMA16vGaTl0uECZcg6L3jYwEgoQKsnmxpIMrXVf3B0f2V
 hZt8zcYeQPzofILH8JCuTk8XWrDgf1mjqzTZy1BuQOileE1sjqzEi7yUOeSoZnjAhN
 821oZEEnI4nf2uWXsUNnGEL2k9ortaNQ4YXpoDjPKyRlu8pygrOZKTSbeb1NW9hWUx
 0ECC64yxhG/vQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hjc3v326gz7yMX;
 Sun, 13 Sep 2026 20:18:51 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Subject: Re: [RFC PATCH v3 00/36] arm: add Raspberry Pi Pico/RP2040 machine
Date: Sun, 13 Sep 2026 20:18:50 +0200
Message-ID: <20260913181850.3301-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFEAcA8s4UXp=hp9R=Pq1mMP6VvB8ergnsm7Yq1xooOGgTPsCg@mail.gmail.com>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA8s4UXp=hp9R=Pq1mMP6VvB8ergnsm7Yq1xooOGgTPsCg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

Thanks for pointing this out, and sorry for breaking the series
threading.

My university SMTP relay enforces a limit of 100 envelope recipients per
hour. Since each patch was sent to the QEMU lists and to the recipients
selected by scripts/get_maintainer.pl, the 37-message series reached that
limit partway through the submission. The relay then blocked further
messages as suspected bulk mail, and I cannot change that policy.

I therefore resumed the series in two later git-send-email invocations. I
passed the original cover letter Message-ID with --in-reply-to, but I had
misunderstood how git-send-email threads a partial series: the first patch
of each resumed invocation became the parent of the remaining patches in
that batch. This produced the groups 17-30 and 31-36 seen in the archive
and prevented Patchew from recognizing the complete series.

This was my mistake. I think I can avoid it for the next patch series by
using the appropriate git-send-email options to spread the messages over
time.

I will also keep subsequent review discussions on the mailing list. My
earlier private reply was a mistake; I was trying to avoid triggering the
same SMTP restrictions, but review discussion should remain public.

Thanks,
Gilles

