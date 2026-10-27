Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B012606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nh2.me header.i=@nh2.me header.a=rsa-sha256 header.s=mail header.b=pm1gg0+a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXLV-0004ba-5E; Mon, 26 Oct 2026 22:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@nh2.me>)
 id 1xLXLE-0004az-Ob; Mon, 26 Oct 2026 22:55:14 -0400
Received: from mail.nh2.me ([116.202.188.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@nh2.me>)
 id 1xLXLC-0005HS-LM; Mon, 26 Oct 2026 22:55:12 -0400
Message-ID: <4ddf5981-4748-4519-b367-98d2a528b99b@nh2.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nh2.me; s=mail;
 t=1793069704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EqrxicweeIB9trcEaBw8JyxDP8w6nP8GfyykeE069Y=;
 b=pm1gg0+aS83SH6iMthlMiprKaJs/ZvPwdreaUIKbb0Sro/Rzpz8Mlj9HUHeMObUMpS7eET
 xSsOiY462X1RBkrrgAbjoAIiNGfXYLzF/nUB1uiUulu4RSGqfdGNcU73XsDtZCrWzscxrm
 025o6OroThB2/mx+w1ONbu+nzuUlz8lp93MAujpijc1X/KAZqmqgwXyUWxCddDSqDyENsi
 c8nCxMtZ4Pc1r9+E68/UtfP1C3s5r42pNZVYAzhAqvWRTa59EEeU6Hj25wTkWlRTd5L1YM
 8FGgz0BhKIzz1hn2hPNGyk2n65mEUyxfxt7hIfIdUAHEtP9zRnqz4qSsZBubmQ==
Date: Tue, 27 Oct 2026 03:55:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/slirp: Fix incorrect permissions on samba >= 2.0.5
From: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>
To: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <c2b98872-4649-c291-bfb2-0fd5b3d40ac4@nh2.me>
 <CAFEAcA-TxOys5d=SAqwqU749j3-UoBf+WsWpMYZW_35w1r2ypQ@mail.gmail.com>
 <55c9d253-8f4c-cd06-77b4-fbbb26cda619@nh2.me>
 <c1c454bb-bf22-c985-5aba-0c7ffb3cb759@nh2.me>
Content-Language: en-US
In-Reply-To: <c1c454bb-bf22-c985-5aba-0c7ffb3cb759@nh2.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=116.202.188.98; envelope-from=mail@nh2.me;
 helo=mail.nh2.me
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

Hello,

I would like to follow up on my 5-years old 2-line patch that so far hasn't seen much review and fixes the QEMU + Samba integration.

Much appreciated!
Niklas

On 2021-12-06 19:25, Niklas Hambüchen wrote:
> Hey all,
> 
> just checking on an update. It would be great if this could be included in the coming/next QEMU release.
> 
> Cheers!
> Niklas


