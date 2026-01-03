Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF56FFC6187
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6m1-0005OQ-5C; Sat, 03 Jan 2026 13:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6lz-0005OD-Ti
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:54:47 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6ly-0002GJ-Bw
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767466484; x=1768071284; i=deller@gmx.de;
 bh=RUEqiEkKUYLSEzHeY2Prf3iygt7D+PlJngFC8fMAV9A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YTCWEDIbnRSKJrFY0sgh8HySBrncV/QF9yhIPiQPiK7Vv4Hs04zhXkXM8cEByhW3
 0XyThS62PNm21pSxeohvWedL58qoT497bbTHhajmWA/NIkr1uwekL5HxRI5KDgz2f
 WWuHwtGPzPARA2LDkN14gHYqwrvw8uQU2rAZKEQRHDxXGE+egahLv4plXwV0UBTF4
 us4KFOo2MAYHgbnPCmAdGRWEf6wApwOfgta/CHSE716tFA8qhM1W+6LrL9ZOpM2mx
 wK8BbGg/xOZ7emGHISO4Hp9WKmQZRvi8RP+fdgM5qSxduIVpHHRi36wVGzaDwXy03
 VwPG1vy88iWj+raZ0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1vOp4G22Ma-00SN5u; Sat, 03
 Jan 2026 19:54:44 +0100
Message-ID: <8f2885c4-f2b5-4514-bd2f-43a255766ad8@gmx.de>
Date: Sat, 3 Jan 2026 19:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] Add termios2 support to linux-user
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-2-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-2-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NLSy4j0/QCG02KcazDaM/R/tyhxCsnH4huxKW9fMcPuSQlIjaSy
 WAyiWETWgkG9dZn+zomDoeaMOQnSF2ej3OB10nCy24dha0RmRDewo7lDsql5bLInLKvdxbP
 IJdTqttlHNzjwMpJfHHnLLxXBEFah/ELmudn1JPJ5WTULAqeqnlAX5KSoj+lwHEq0RU0E1P
 3ZWdL9Pe7ztN4zOY+YcVQ==
UI-OutboundReport: notjunk:1;M01:P0:xHUJbyyRhkw=;0fUVE1xmYhOosoJ2Bh2XFeWxbkF
 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
 /c4GKqPOYe5qxjCeQ=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Link: https://lore.kernel.org/qemu-devel/745f18b6-ee62-4903-9a56-dcb903b=
610cf@bonslack.org
> ---
>   linux-user/ioctls.h         |  6 +++
>   linux-user/strace.c         | 69 ++++++++++++++++++++++++++++++
>   linux-user/syscall.c        | 84 +++++++++++++++++++++++++++++++++++++
>   linux-user/syscall_types.h  |  3 ++
>   linux-user/user-internals.h |  3 ++
>   5 files changed, 165 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>

