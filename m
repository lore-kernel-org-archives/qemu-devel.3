Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40E9FC617E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6SU-0007xi-QV; Sat, 03 Jan 2026 13:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6ST-0007xa-Ol
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:34:37 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6SR-0003VA-US
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767465270; x=1768070070; i=deller@gmx.de;
 bh=V7jTA9d4bHI9dTdi6QsWE6EUTivZ8Nrep3v8rjmTOhQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cSh1+Xz0IzubEDHBirCTUtEcxyvVRselA00JY7uugDW3K0sIBIkhlCmXW1uu/wQj
 YsNTf3hb5opHHtTERARLSXiIVv55myeCTBxis9HfhLtWDVd4wuUhjCBYplaZnNlyK
 Ml5qiTc7IykzCh+wGJ4cVUJ06XUpTEyug9O06oaDT2KwjHGP74vQu9QilAEPTU018
 IJBNgABNnjb0OpLG/drQKsg1ur4G5j2h49Z1ad82GwbZraM3diH+K01clnRjURIGh
 Pz1294CAsYBMn1P5q+7h6NiYlM/y89LwMMDh9w1UoZlJekjMffwuTY5KO/ehVH5sZ
 6N9/cfC60JyCHSr5mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1w3utt0pfj-0148cH; Sat, 03
 Jan 2026 19:34:30 +0100
Message-ID: <ac6fa45e-39aa-4bfd-901c-4d5019b69c28@gmx.de>
Date: Sat, 3 Jan 2026 19:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] Add termios2 support to alpha target
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-3-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-3-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mnRun1n8Zv4i56Ul2dmhniux2dGnFbT6McUlI56SAzCqq5W2Vr1
 fBtExxxVDPULMAkZKA2HE87SeMEFKoq80cgN0UgjMu8ZRB0yWvpEtl8LHqiZFZvd8HwbzyG
 XZz1Eaaz6nIOXndPEaKyCFIL9m3hlX4UYry9pSdvMrvp7YgX3CBjyT2TmgnXOh0d1/rCtmh
 GXVfbhzFHSaHVBz7ta4GQ==
UI-OutboundReport: notjunk:1;M01:P0:6KGBhFddvhM=;iiIhmhikcBI9Nw1a+kn21J4IYpi
 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
 jTiceWRtyiXhIqLes=
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
> Link: https://lore.kernel.org/qemu-devel/02dba951-1bcf-4c74-8a6a-f4f4aa5=
ce909@bonslack.org
> ---
>   linux-user/alpha/termbits.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>


