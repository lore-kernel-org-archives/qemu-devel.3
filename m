Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2244F3C266
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzb3K-0002DT-Rw; Mon, 09 Mar 2026 09:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vzb3D-0002CD-M5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:53:40 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vzb3B-0006rO-Hl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773064414; x=1773669214; i=deller@gmx.de;
 bh=sIvntCWZoMsrUaZ9elCvd0SDHandHLb4Wg0yZLBtfvI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xl6uUAUj7lUXzgLCVyWlMF8Fn92FeXTaWeAJDTFNwX+8SCbI1hQPb+3WsImeXolr
 z7GvusXzppAYa68tCVRdEMhkqxbGY7U6nfuMN63whJ2yTMTrdKtHy0ARwBRLn+bCf
 TShiCCGhlj4nTkXeXvL3+3mpwGGO+LwdsmeOx106m3/z1lRFvdHqZ+D6KaOnesdPN
 nBr2H+VPWaVGvztzTfjsyX+mDt+A1MJHqbHt0VGlk82mgiBfQAX8ZTuRfiHTRuSWA
 tTJW6EzM+Cp/CJath952sY1YFPgyN1LvLFz/Qkp6EAvQnW+TqSBnXFn/jDGs0+i4h
 1TwtVOsVE3VWTXul2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1wHP152v1l-00WGdn; Mon, 09
 Mar 2026 14:53:34 +0100
Message-ID: <e5e94e23-0f8c-4bba-bf70-80dcfeba821a@gmx.de>
Date: Mon, 9 Mar 2026 14:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] For next patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260308172936.2835-1-deller@kernel.org>
 <e389e2d6-2376-46f0-ba48-e38f39d07f20@gmx.de>
 <303bc39e-9fca-4173-be6a-f748d29ba7dc@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <303bc39e-9fca-4173-be6a-f748d29ba7dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pCmOpnJbsIQgmswg3e2ipbgn5A7NmIlmMCrRTov6cutr4jQBm+G
 kpMXB8lITt/uOaQv2zOgTMZOhVOyNzIe5tx8F/sZz46EQPBIdiJwiAf96zucbXjk73zxcRb
 Cn64eyjSspbqpGYLgp9WvkyIxuEyrSXXEaC0law3CrFG7MVvdeDr6XQR8XN7Mw77vwsd3MY
 rAHz6aMdgeOH0f9IycIhQ==
UI-OutboundReport: notjunk:1;M01:P0:IGtH4VRGPX4=;Wh841ZE8PslGntjKvAbLtBIeKgH
 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
 /oKp5pJU=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/9/26 14:51, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/3/26 14:44, Helge Deller wrote:
>> On 3/8/26 18:29, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> The following changes since commit 900682c57287ea308850af4490339455512=
e92e7:
>>>
>>> =C2=A0=C2=A0 Merge tag 'pull-target-arm-20260306-2' of https://gitlab.=
com/pm215/ qemu into staging (2026-03-06 15:58:24 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://github.com/hdeller/qemu-hppa.git tags/for-next-pu=
ll-request
>>>
>>> for you to fetch changes up to 9e8501ba72d5136ee5e6622f8863ce8ea252c29=
a:
>>>
>>> =C2=A0=C2=A0 linux-user: Improve formatting for mremap() (2026-03-07 2=
2:58:27 +0100)
>>>
>>> ----------------------------------------------------------------
>>> linux-user and hppa patches
>>>
>>> Two patches which prevent memleaks when using Diva PCI
>>> cards on the parisc architecture.
>>> All other patches are for linux-user emulation.
>>
>> Please ignore this pull request.
>>
>> The two patches for Diva cards have already been merged via the "misc- =
hw" pull request.
>=20
> My bad, I didn't noticed your PR while I was preparing mine.

That's ok. Thanks for including the other hppa CPU patches as well!
 =20
>> I'll send a new pull request, which will include the "linux-user" patch=
es only.
>=20
> No need, git-merge should figure the commits are identical and proceed
> as usual.

Ah, I didn't know, so I just sent out the second pull request before readi=
ng
your answer. Anyway, both are now out and both should work then :-)

Helge

