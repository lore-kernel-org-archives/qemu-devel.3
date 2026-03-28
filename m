Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3D810F3DE2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 12:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6TEd-0002ds-0z; Sat, 28 Mar 2026 08:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1w6TEa-0002dV-TA
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 08:57:49 -0400
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1w6TEZ-0001vd-67
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 08:57:48 -0400
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id A75001C00C2;
 Sat, 28 Mar 2026 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1774702657; bh=/50tGBuvTx+zlPh3SBzV5ihkLwKIQh0kJQLBln1MQls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KgO0Xfxl6+TYFedNgc3sOaEYuBh4tlh2tvfnWoEXoZx+QHfWl4kqPrMenNqW85nBE
 SK9/Gx8VUaIlnTbuRUC1e8qrCerNfxoF2jPcBbD6qwe4vXADLpyKitlFyZ219zYyaM
 v+KcRFykUq8XF8m+MrNqbgoZK2eVaitJ6tRT6ma+Uh5T681mTERVyWwvB365+xK1IW
 JGgj0LcrJe5cU1AQRO61bMfxuK4+r3RipsTVncQAH0UVmi+fJKBU4EQKggJMBnfkZ/
 Ifk/2aDJmIGpVWKC5NsldBDT4KAJHo3pL8JViA1H5lanr8PgwrF71GXMs/BA1IXxv8
 mjYx/aSvkNoiIovvBsz8NA/Cbeq+a8Xu1yivSWWkt4hvy8dvTH4ELdwEh7+VsQCrT2
 RMQHNM1HX2qs3KvCP4ykxn+6nOpquqHNEGy08Hb3Ffqj0OviJLPra1JxA7LDEPDBNt
 w3o3mGeR5A78QR1T3MJR0iNXmyF2WM+BBhWLa+IntqbX21hWqy7djt/A1QF0VZw4Kk
 dGvqCb586rndmjxqiB9lE647gzE5VocUobp0CHDyqZ2gKe4CJfn2CgtVHaHSwXs0Bg
 vRx0sBpnaeA2ZXsGY51KSnb7b6z0s94mOlodLvGWYbBlG+SkG0jQ+6d2k/h4p+vQUH
 Z/Y97+85gbCuzNAMFUCApi7k=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id S4zI-ywIoGlD; Sat, 28 Mar 2026 12:57:31 +0000 (UTC)
Received: from xtex1.localnet (unknown [155.117.3.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Sat, 28 Mar 2026 12:57:30 +0000 (UTC)
From: xtex <xtex@envs.net>
To: qemu-devel@nongnu.org
Cc: WANG Xuerui <git@xen0n.name>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 WANG Xuerui <i.qemu@xen0n.name>
Subject: Re: [PATCH RESEND] tcg/loongarch64: Support every TCGCond for cmp_vec
 ops (ping)
Date: Sat, 28 Mar 2026 20:57:23 +0800
Message-ID: <6343986.lOV4Wx5bFT@xtex1>
In-Reply-To: <20251207055626.3685415-1-i.qemu@xen0n.name>
References: <20251207055626.3685415-1-i.qemu@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Just a gentle ping on this patch. Please let me know if you need any
changes or have any feedback.

On Sunday, December 7, 2025 1:56:26=E2=80=AFPM China Standard Time WANG Xue=
rui wrote:
> From: WANG Xuerui <git@xen0n.name>
> ...

=2D-=20
xtex @ Sat, 28 Mar 2026 12:53:26 +0000




