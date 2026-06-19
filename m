Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00F7CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 21:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wah6s-0006Hw-23; Fri, 19 Jun 2026 17:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wah6q-0006GD-Ge
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:50:44 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wah6m-0000Ty-5P
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=wxexhclfojhujjvz6hdrfuvhly.protonmail; t=1781905834; x=1782165034;
 bh=rRaLDmicmWGBeCeiagx3kfn7IotXH3ZB77cNqhyQeqc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AVtTAvn+SUaWuHMAO97YS7qrVecuH0o9SPLfoPl6vcLyST6+PJT55DmKt11x/g27L
 NRCifXEXdqmho438xK5tK10jRa4HlAnaPDezzukNSnyBYemlMzSDrU0cViWtGiz5BK
 jzaeZWoazgj8/kM4P8FJOMeI56r3760oqzMkP9oOPqbdx4M+yI+0NwaXU9/h4PRHqU
 HaJuDlQEEJ9JUuo8/J2KC9yU9yHwljBzwUVmrOiGvztOuMO7dTQpnFPgzN8+Lsrs9u
 SZTuBHP40bZz/naycoS5nxO7K5eVoepPAc6hEC10i7RpajQrSfR+jtyku/MwYdJEAX
 mbu9RkFPIe7Qg==
Date: Fri, 19 Jun 2026 21:50:28 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: Christian <christianslima@proton.me>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] audio: converts malloc to g_new and free to g_free
Message-ID: <bUMk4pFxeIYKRVxgLxqyzYkaJEhhwIUDafAfM3R7kWm-NI8zRkuHmWs-awnUIZD5bkYze7jZBVCyvA-aXqDG3dhrDPWddvEaNhGeGEIDP6w=@proton.me>
In-Reply-To: <CAFEAcA9bzM19ny_wGKahRETFEp2_Od=O_TdPFxAkXnr=9Xvwiw@mail.gmail.com>
References: <20260619080934.237834-1-christianslima@proton.me>
 <CAFEAcA9bzM19ny_wGKahRETFEp2_Od=O_TdPFxAkXnr=9Xvwiw@mail.gmail.com>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: a4b85ebea8841ade8a8eb6866011937a541053d3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45;
 envelope-from=christianslima@proton.me; helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> Hi; we already have somebody working on updating this
> set of malloc/free calls:
>=20
> https://lore.kernel.org/qemu-devel/20260428162048.2995097-1-luc.fast2004@=
gmail.com/

Oh, I'm sorry. I didn't know, sorry for the inconvenience.

Thanks,
Christian.

