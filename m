Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ACECA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC4ar-000219-LW; Wed, 30 Sep 2026 20:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xC4an-00020G-Sj; Wed, 30 Sep 2026 20:24:09 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xC4am-0007r9-4V; Wed, 30 Sep 2026 20:24:09 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C94AA14000CA;
 Wed, 30 Sep 2026 20:24:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 20:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1790814244; x=1790900644; bh=KC31Sheg6jxzKjFfamPBL9+0+hh0gJKE
 BLHBG0V29XE=; b=uDEfMFNvsm2CPN+fTYN1IE+Rc4M17UjEPfzH3w4tAmItQfqR
 vXS6IWH6iVXsGPuKfUeRJY7719kfPf7yG0lksAKyDJEsyFMrpZZgnRQh9jQPw8+1
 qbqJ3YgElIHFHlirLbzx27WBXPgQMqqfYrvY+vcsVNhPdzNWgKOiw99bDcqrlV3X
 ciHDzfN2gwJoU/VLzW23Kmfa49z6bdHQ4sFbXc7/JMV/Z93RVthHqmdwdTtdGayw
 n2OQAKVqd/9InRbhP8eBhE2qpvHhgth6R/jdiELEHX4aBL6YRduI4ku9wEdyDMEA
 BAXBz/IoUZFKt4DaPDTE5eZ6jl+PB+Hj6f707Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790814244; x=
 1790900644; bh=KC31Sheg6jxzKjFfamPBL9+0+hh0gJKEBLHBG0V29XE=; b=j
 9HMZg7XM3VWaapBJpb7Ebm2Wb+CHsjqVCVPYMDIiodoUb84MgN21M3EVMyKyG5KD
 c4atQiXzfTKzLG2akL/Y/glYVv+6TK9ihTGaA3v6plWzlQrgNWX3h0Qa6T455nYA
 YF43k/lL257Xtltx4RxouU5PzygOdCHo8w37Ek0WBgAUpPkDq9TUPmxRe0xNP72M
 N2+ScoXcoXVnaX6XSOwSOTerW/Cdy5nXjxKy619cLqNM6LV3HUJUhS/tZE2aQqPd
 FoOM1v9z8nfcJBauI1bl/AxNQzIMWaim+vjVlMsgraM2zIpBrMnXXYeRXMiETz7H
 sK7J2/IxhetjVh8D/i7cA==
X-ME-Sender: <xms:I6i9an3EacSkRrDovvpbmzZZ9ostvOGg_Xo6OyAW6UgFMCNzIzcDvA>
 <xme:I6i9aiH1hBENTXgFawpj3wi9QQZdnpoCgpu-kfBumN82Zf-s04Fm20PE78GwsH0HH
 Y3hRzhuaB4D-Y8F4JZ3T_ztdLtM64pzEM9ISesAX7L7X8SokV5pdw12>
X-ME-Received: <xmr:I6i9aqFVBwVH_PPiYlgAq1IAc9hHDmJdu0xjf_hNlpHhqa6BHPPGA7b0_d2bgAO-w9e6oFdHufZvioMxfjVSxqjctts>
X-ME-Proxy-Cause: dmFkZTEiDYPVdN/C80muXjPlKwzL5oj3U0+lQPwE7gafVM6B8BEe42YAkt9f/FLDOdjFf+
 Q83XRI2daXx4D3tyIe91RvBanQYdjvOqixsx5jIKrDjS2NiTZM0nscMDRUVa3JgII82vBZ
 WPGaj/gblbhE2lcGn84NazB7lELlNW+QRWTHU9BaTfZXi7c+Pnb+jZm9+psaUQOZ8cPWUx
 JXYIh3Ku8Zz1hzzJGcIgTaq/ZZU3rgHeYvhr4mPCmgsQ9plt1dmyS4QvaC0zD1+l+3QuJc
 +hnCsZELxJtzy6ItrULZSe90HUAYsjDtXq8i3AsgiixZSIYMxb1ICnjnjA4oujzn6lgmQg
 TDyWhojCn+mNNpXWEVBKAIi4OWhzG04HZVa03rFkPGDBiNO1C8qST71lIDWY1ZeOtdeO6B
 RFIS+dRYhKj1iRc70KKO7xsz61A4yTSeiVC5op/E1UriEYHp8ZZq8ypiK9HVCI8g3SUMDM
 AvFIgsjAxOkdEWwvTReH1PRGYi0zpcGWw4MuhLZYNGPBGFpXmCsYpzxJI7tOXe9wLHkOJf
 gEbTArH6XwkVvf7L2g6gOppuCIJYwZ5q5KCMiAYdv5Osh/SKBryQXCVxM+cR4oZe7NBUdJ
 Ap6jZQed9F1IcgCc0zFqCSEQUbVtCJWN0o1O0JS8I8kT4lSmxD7PvyxTiOkw
X-ME-Proxy: <xmx:I6i9at77LXxrPqBPdpeEdt3VOKIFd7KuvedhlVBxXqLySnvYHpvzRw>
 <xmx:I6i9anyGo2uaez4JMbzyyNy35ILmJnhzhLyl-CcUeGIOn4oeNjA5jQ>
 <xmx:I6i9akNgUE9WuG3BKF8USk7FqKKBheWg1iz1A-sCV7y94EahNhWkRA>
 <xmx:I6i9alle-VR85thZQ_lcGzNSvF7TJdPtYDa6O3UI0R8h6a1Tr_ZBHA>
 <xmx:JKi9app3ffeU3UcEqb5z5njCxWQ0HMIoTmzZXxEwqMBzLHR7TBRzmsvl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 20:24:00 -0400 (EDT)
Message-ID: <394b2d27330214cace489d762689b58617bd989a.camel@alistair23.me>
Subject: Re: [Stable-11.1.2 v2 64/92] linux-user/riscv: invalidate
 reservations after stores
From: Alistair <alistair@alistair23.me>
To: Rick <rick@sloservers.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>, Helge
 Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org
Date: Thu, 01 Oct 2026 10:23:57 +1000
In-Reply-To: <9dd3c99c-5f57-43b6-b591-84e10b425443@sloservers.com>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
 <20260927104821.196183-8-mjt@tls.msk.ru>
 <9dd3c99c-5f57-43b6-b591-84e10b425443@sloservers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=alistair@alistair23.me; helo=fhigh-a8-smtp.messagingengine.com
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

On Sun, 2026-09-27 at 19:59 -0700, Rick wrote:
> On 9/27/2026 3:47 AM, Michael Tokarev wrote:
> =C2=A0> From: wangyang <wangyang25@otcaix.iscas.ac.cn>
> =C2=A0>
> =C2=A0> In linux-user parallel execution, AMO and ordinary integer stores
> do not
> =C2=A0> invalidate load reservations held by another hart.
> [...]
> =C2=A0> Use the existing EXCP_ATOMIC path to re-execute LR, SC, AMO, and
> ordinary
> =C2=A0> integer store instructions in a serial context.
> [...]
>=20
> Please hold this patch out of 11.1.2. It makes riscv64 user-mode
> emulation much slower, and multi-threaded guests can stall.
>=20
> Once a guest has a second thread (CF_PARALLEL), gen_store() exits
> through EXCP_ATOMIC on every ordinary integer store, so each store
> stops all other vCPUs (cpu_exec_step_atomic -> start_exclusive).
> LR, SC and AMOs take the same path. In addition, every store,
> single-threaded or not, calls helper_riscv_invalidate_reservations(),
> which walks all CPUs.
>=20
> xz compressing 2 MB at -6, without and with the patch:
>=20
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 without pat=
ch=C2=A0 =C2=A0 with patch
> =C2=A0=C2=A0 xz -T1=C2=A0 =C2=A0 =C2=A0 =C2=A0 5 s=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 122 s=C2=A0 =C2=A0(identical output)
> =C2=A0=C2=A0 xz -T8=C2=A0 =C2=A0 =C2=A0 =C2=A0 1 s=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 no output after 600 s
>=20
> Measured with bsd-user on a FreeBSD 15.1/amd64 host running a FreeBSD
> riscv64 userland. The only difference between the two builds is
> reverting 5089493e45. The code involved is target/riscv under
> CONFIG_USER_ONLY, which linux-user shares, but I have not measured
> linux-user yet. I found this today while investigating riscv64 hangs
> in bsd-user.
>=20
> I'm not disputing the correctness fix for work item 4149 (a same-
> value
> store by another hart must break an LR reservation), only the cost of
> serializing every store to get it. That issue was found by a
> synthetic
> test, while this regression hits ordinary multi-threaded programs, so
> I'd suggest leaving the patch out of stable until master has a
> cheaper
> approach.

wangyang <wangyang25@otcaix.iscas.ac.cn>, any thoughts here?

The patch seems to stop all CPUs to check reservations on every single
store. Which would have a very large performance overhead. That's way
too much over head.

I'm going to revert this patch until we have a better solution

Alistair

>=20
> Rick Richard

