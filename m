Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76BEFC6160
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6kK-0004dV-JC; Sat, 03 Jan 2026 13:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6kJ-0004cU-9S
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:53:03 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6kH-00026u-C1
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767466377; x=1768071177; i=deller@gmx.de;
 bh=UXMgHvTMQKlvWT1+87baccSi+VD8C5dfjC3JV+vVh4Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s2tZAQGzCL2j7otxXrQwjG47NGDRd/tm4RyqpHpAaCPYQWd0UBTP7JoKyXRrr9W7
 r9kKBETqLuYAdOvYa604iAEOmB3TPXpzxz++TbjSUtQaMABEzExe6pOxVJ7ZI9WYv
 OBOtsai76nOCVSecMaLV/NzEUVFiJT6hPAE9L3JoWQSf0tujg3pGHEbNKDLuzDO/8
 puS8FMBIc5+8M3HsNIfzKBVHtaOaReYp0OgxBelwO7D+tbjYcJdjnyQqOJKuCgLBF
 GBbGgXwZvFqJCtyxCG+NLl/F3t4GcvQtjTHs3D6Jdn4ZmKeU2FGm7gT/28drRj2qX
 EVl4fJ/82rLNkQYV2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1vS6se42to-00QzSg; Sat, 03
 Jan 2026 19:52:57 +0100
Message-ID: <6dd86cba-02a3-4c9d-8719-6a6ab7abae82@gmx.de>
Date: Sat, 3 Jan 2026 19:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] linux-user: fixup termios2 related things on PowerPC
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Icenowy Zheng <uwu@icenowy.me>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-9-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-9-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pLuIuXgnDFDuy2bdbEpoXZi7JLb6ejOmL8i3+vA41R+5nPNr2iJ
 YvdE4MfFsDZtkQ6wc9+mIxuJXpMhRhEc6dr61mvVE/93A7KXRYTgMYOZWehUdtVa2r8tkwO
 zOuVOCxfvxicCuy3gMruthLwWKEAjcv/p6Rj93g+7sqPMaYDZe7HeVv43WFROiH26rYg3I8
 V6xzwE9zon/wLUeCakqcA==
UI-OutboundReport: notjunk:1;M01:P0:/aXrbd6BE+U=;brMoRFFtPBUVnAFfMqtuYR8M1Dz
 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
 TFid7gaq7xIfvTAuN+YK0pyh0R2Op
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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
> From: Icenowy Zheng <uwu@icenowy.me>
>=20
> The termios things on PowerPC equal to termios2 things otherwhere.
>=20
> Use some simple #define's to allow both termios and termios2 to map to
> termios on PowerPC.
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Link: https://github.com/AOSC-Dev/aosc-os-abbs/blob/8d77eeaa76e9b159c3f3=
5adaf73c875751aa7d17/app-virtualization/qemu/01-shared/patches/0005-AOSCOS=
-linux-user-fixup-termios2-related-things-on-P.patch
> Link: https://lore.kernel.org/qemu-devel/4403eb94ddbb2934f1f75d94ce921f0=
f1078ad9f.camel@icenowy.me
> ---
>   linux-user/syscall.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>


