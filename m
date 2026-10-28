Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CC60A2601
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=fdoHj8hC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8s9-0006KZ-4U; Wed, 28 Oct 2026 14:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xM8s7-0006KK-BT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:59:39 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xM8s5-0003bz-Cn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793213967; x=1793818767; i=deller@gmx.de;
 bh=Z7FkOitiEqXi6t36PvGX/HFQw61D+1QbpNRyg52NLHM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fdoHj8hCYuUZj7jEMt2cRjMOOATOpUibEl7TzDZ2+AjBSgAKKM43KqBG4KWdP8Lk
 NaOhxfRAJm1sCJeyfEEb49ThisuvdCqnSRr4cRVnZxhRjP6ocR5JuN4yLLp/yLLCZ
 IoWhYUxKm/2hXylJ/6lBRhbS7rWdQ6tupRQMX5T8a4v9zPLS6oLGAcRr71wMtKUen
 UVRORpUiP7CvN7uFk0y2Wbx9pWO+/VBR58LL8Cff9qTJpIf+pfzR/mh9/p0aR+ACZ
 WJSVW99CNNGR/64bUwS7TIoXgnkOIumvUoLN1vMQMbVDUwUkKm01UOMu9WZUl9qne
 wtPEeOtV0c7tm842ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1wSiuL1nDO-00rwDP; Wed, 28
 Oct 2026 19:59:27 +0100
Message-ID: <46bc44a9-5956-4275-8003-275de5ba35ed@gmx.de>
Date: Wed, 28 Oct 2026 19:59:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Hppa 715 patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261028182651.5950-1-deller@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261028182651.5950-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nnxBePmpCI+xnpphBHoDnTpfqpZD18JhHOpXQGxxL3ZkgqqhESy
 kEDrRpyjCKIRyTxinHgvdjMfywCBKgDDgqqpDjG1dpvke1kniFhPUtJUhnWE+k7y9TQR/tR
 1SXokDZjHoaE3C6klnbNGJvqlqNR/V1XPm9MV5sWaskP5pntykqoyMs61rIGID23MkFIkdt
 MP/aLj7xS+YI0HrIWbqZA==
UI-OutboundReport: notjunk:1;M01:P0:2Gg8haQM5AE=;QYGUwiKOpT5GlXYWmsko1Zf3V2K
 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
 EV5z6wsH9ZEaaHQwAEzVuKIDoqdyP8rpC
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 19:26, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a=
9ae:
>=20
>    Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/q=
emu into staging (2026-10-24 16:09:37 +0200)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-715-pull-request
>=20
> for you to fetch changes up to 906a079ca3f466763b622320d230b448f2c12a39:
>=20
>    target/hppa: Update SeaBIOS-hppa to version 27 (2026-10-28 19:22:13 +=
0100)
>=20
> ----------------------------------------------------------------
> HPPA architecture patches for HP-UX 9 and 715 machine
>=20
> A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine=
.
> Includes a graphics/artist fix, adjustment to 15 bits for protection IDs=
 on
> the 32-bit CPUs and various other parts which were missing up to now.
> Included is also the FPU patche from Kirill A. Korinsky.
>=20
> To fully support HP-UX 9.05 an additional NCR710 patch series will follo=
w soon.
There was a merge conflict.
I'll fix it up and resend the series.

Helge

