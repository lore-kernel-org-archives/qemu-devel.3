Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D077FC6185
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6dG-0002aB-FP; Sat, 03 Jan 2026 13:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6dC-0002ZT-SL
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:45:42 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6dA-0000AE-Et
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767465935; x=1768070735; i=deller@gmx.de;
 bh=r4M559rzZd4BwTz2lNRLjNrsO9cAUgPVkPJbq+vFwic=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bedYs3Bwel+vsrf4ar7jSXTlAlU5OzV+UgD+iBO+cl7CYDjLFwFbtAfkWw3H03rs
 N/iXXy78Ufd0Wz40uVHx5kB3hF8TSfC9BTXntKzGLWEFVlQo0o0DlNTQnPMTQwpFD
 cVs6Gd84HzejmJeqc0PEeUltyEDXuqj9kUCGoqCPDcs0xay6lGH/2r5qdxvJ09sTT
 +kb5w/t9hcryqyaRJ4BDzb6Ff69U4DrFglSa0rFZVxjwZkZp+7Gg67NrQ9oRUFe3M
 KpjuutSnAgzELHVgJJi4Vkzji2m6Zi8wTRlYSJeybpk+rT8Nrfqp5daBWriHdD8Wb
 LVm3C4BflOiNnDVuiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1vsPSN3qjl-00y8JD; Sat, 03
 Jan 2026 19:45:35 +0100
Message-ID: <0d9d8718-1dc2-4d33-bd45-f90f374454c6@gmx.de>
Date: Sat, 3 Jan 2026 19:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] Add termios2 support to sparc target
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-7-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-7-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETGVpCcbC8ESwGmejJ2MAXkDhlWXa5HTY414XI1L66toVx5L0PE
 hJHby8pULif/NG9NAJIVLyHakSR0IzAUayrTI5PpVwztV/6PyYebW4ycT4LdfQAiWlfHJYK
 wKe42wsT7bWpRzRFwcUuo0HUC9cjWFANHILySK8L0dLAFVCLVUYDNAOdry/LdyDUJ88g4LH
 DhUHLcfXYXGQnTwvlYMgg==
UI-OutboundReport: notjunk:1;M01:P0:NEzd1rh2hQ4=;tcXrXZGmqxJEiWwUQAzWZg16QZw
 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
 xK4Ra4RuuJ6ZJ+7pI=
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
> From: Luca Bonissi <qemu@bonslack.org>
>=20
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> Link: https://lore.kernel.org/qemu-devel/909d9d68-c6fe-4368-825c-6aa8fdb=
d3bbc@bonslack.org

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   linux-user/sparc/termbits.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)

