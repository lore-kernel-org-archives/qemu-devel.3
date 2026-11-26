Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA71606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=mI6D1ycV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWXxm-0005f1-Hx; Thu, 26 Nov 2026 06:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xWXxi-0005do-3z
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 06:48:26 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xWXxg-0004Em-4w
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 06:48:25 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id AE3B690C3;
 Thu, 26 Nov 2026 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1795693699;
 bh=b2LrEwQnK1s6GBks4Hg2pDFQjA2AuhP5hPajdFq9tU0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mI6D1ycVsA3Qb7eGKwgaBemqbAp2YfxlBrLSjXflKqAYqAEhfB40VVxKisrt5B1OI
 6N97na5ADbY0AbCG3P6glq5eQdjRga8Lzt4BLK6sWtCthJnEheLb1SoOuu7586uY73
 wov2cMXXsh+Q+atpFhePVuGoKLzzj0efRfKTWVsFYu+E/ikjn5LMFQm8elCg3UXVe5
 ilh2VBbmA2IrQ7yV0M4wSG7+dNolCxloMINFgKcIN6MY+FyruQgqXmlUbzFlrwoU0S
 lam1SqQBFODDgMnZqpplFSK+49Rq4D4EarzN1x75wRaNP09NUl9uNmgwRdvHKjexCO
 JPuHW/oSeHOhA==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id E539423247;
 Thu, 26 Nov 2026 11:48:19 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v4 0/6] vhost-user-gpu fixes
Date: Thu, 26 Nov 2026 11:48:16 -0000
Message-ID: <179569369656.3375745.17238189610521746462@taktcycles.com>
In-Reply-To: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=136.243.71.244;
 envelope-from=rdmitry@taktcycles.com; helo=mail.taktcycles.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marc-André,

I retested v4 on top of 2bfbe39d0fff on x86_64/KVM, with the same setup
as for v3: vhost-user-vga with the contrib backend (--virgl), the D-Bus
display with a listener attached, and a Debian 13 guest.

- #4848: a fence reported while GET_EDID waits for its reply no longer
  kills the backend.
- #4847: the main loop no longer spins on the closed socket: no "failed
  to read msg header" lines in 90 s, and QEMU used 7 s of CPU time.
- #4849: stop/cont, then a guest reset, then another stop/cont keep the
  backend alive with no sock_fd or wait_in assertions, and the guest
  driver comes back after the reset.
- For the queue-stop change in 2/6 I added a stress case: 60 cycles of
  SetUIInfo on the console (the guest then sends GET_DISPLAY_INFO and
  GET_EDID), each followed 0-4 ms later by QMP stop and cont. QEMU and
  the backend stayed up, with no assertions and no hung tasks in the
  guest, and the display kept updating afterwards. Four RESOURCE_FLUSH
  commands and one SET_SCANOUT command hit a stop, and the new error
  handling completed them with ERR_UNSPEC. None of the 60 stops caught a
  GET_DISPLAY_INFO or GET_EDID while it waited for its reply, so that
  exact window is still untested.
- With the reset patches dropped, #4846 still reproduces as it does on
  master: QEMU segfaults on the first system_reset with a D-Bus listener
  attached. That matches the changelog.

So the Tested-by on 1/6-3/6 still holds for v4.

Dmitry


