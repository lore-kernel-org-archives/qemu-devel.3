Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF89FC6185
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6ZN-0001UW-W6; Sat, 03 Jan 2026 13:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6ZM-0001UG-FY
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:41:44 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6ZK-0006bL-On
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767465700; x=1768070500; i=deller@gmx.de;
 bh=XzLImh1arDHiSfkyNZaO383Ex6VjINBV9dK+fjTNdAI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cw+WrHD1CIeSt99OnDpNw6LRqJqfFfMUFjGGCIrz/i6nOYUtsifL5RB6YN/cdWUj
 qKzdIUoTQbgol0LkrAlUztzRpyLKLu5fUVPE3xFaPKnw4FWkEVJAxm8p4wTWRnj2f
 T6k3A3QIC4lMzjCLq//hvxuW4fGIu4TTuumprs7tO10XvTRYZ1KPoejGpz9V06mL7
 8SJkaWSH7TFLvBgQbXunGXUNWttymVNcG3n3xW7clMcsXmUquJx145wJhHTmJ501f
 XVGrilNvhwonIOrjyhEBBzhhufE5wos8cN8kFm+TxgMMBZCjWtoWAK6sptaA9yEzy
 mYHDzFtaToC4GdwZWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1vkb0n2TBJ-00Ev1r; Sat, 03
 Jan 2026 19:41:40 +0100
Message-ID: <653b6777-c75c-4dc6-80c1-f80bef3b8867@gmx.de>
Date: Sat, 3 Jan 2026 19:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] Add termios2 support to sh4 target
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-6-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-6-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lmP0R8MyyK7Wr3taMQ4GYt/xURaqQsJTG1/onR48e7GDvQS0Waa
 vmi3OM8sisnKKbn5FQqwKUwPFsoh8GLEvPYOpPoSzfWZ8MGAwmskC/hga4GE3q76fMeUS0T
 Jp8OJcex0WRmXrVOkwx103WqYDeSZBKgSYhFq+bh67bKkDFPP2z/Q62WU7PL8ZWBnXg2Zhy
 PYHd0XSDrMoGUgWDQXuOw==
UI-OutboundReport: notjunk:1;M01:P0:V8giNhX9zZI=;GMlq1D92EnYbQWdGC3+Y2hybNAo
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/3/26 16:25, Andreas K. H=C3=BCttel wrote:
> From: Luca Bonissi <qemu@bonslack.org>
>=20
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> Link: https://lore.kernel.org/qemu-devel/642b32de-2985-45d2-bbdf-c0b2e3e=
a0551@bonslack.org
> ---
>   linux-user/sh4/termbits.h | 46 +++++++++++++++++++++++++++++----------
>   1 file changed, 34 insertions(+), 12 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

