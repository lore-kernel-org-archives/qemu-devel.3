Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32861C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4sG-0000aX-UQ; Wed, 14 Oct 2026 15:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xH4sE-0000Xb-GY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:42:50 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xH4sC-0001cN-CQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792006960; x=1792611760; i=deller@gmx.de;
 bh=dEvQADx3CgydiNEauNRkQ/f3GFiC7GuwBDvGeg1mutw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=B5wRDsvQlPxAt33zCEZht9Sv5CJBfI/LFkKMYD3uC/xkqh5I2rdE+4pS2GGNzeLa
 S/OSbuoUNLt4PSGgEkZtFS5BLZZRa2dbOnpeps2zWOqqdmf4cFePHp2CZnBmhIimp
 69iaaUQ8PCNFryaDaxkaS5NF9QFVbqtXThrYZl3OCzdP1ywPm1Nv/YMQtUUB4Y1or
 CTxWoLJVf28SQjQJ6ToPVZzNt/mZe4plF2vk12GWecnNS3miaqAHZkNlD9DKTTfV8
 BaLN0ZN1XKDMO2kyopPIN6Kyf4ZPFjpy9KHOe8E8Jc5t6vIJkcsYkUOuh43aYDA8q
 qQkHSSI1DodgmRxoOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1xCLmT2OTR-00X4E7; Wed, 14
 Oct 2026 21:42:40 +0200
Message-ID: <58c1da47-1a6d-444e-b723-ce9a28f39624@gmx.de>
Date: Wed, 14 Oct 2026 21:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: Rick Richard <rick@sloservers.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: laurent@vivier.eu, pierrick.bouvier@oss.qualcomm.com, imp@bsdimp.com,
 kevans@freebsd.org
References: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
 <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
 <094898a9-b3fe-43f8-b335-c149ed8b0a96@sloservers.com>
 <1f1af018-8720-467e-8c8b-b4c19a0b9c5b@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <1f1af018-8720-467e-8c8b-b4c19a0b9c5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qo2Uop5QXaEwA0WqdynH3EbNMPkCRm4efRyUl0ztnUvH+V88Fe9
 +JX3umVLQgeosXH5ZsWDMAR/TI4iFdwc1Xli5RVJoz2TjVtllP8WyAt0mkOn0nk3aRmn6Id
 aU8Mq02GIb2Mk5hypqgt/jeM+C2BoYMwX/p/TUYweHvze7NMFB3m3eOvvSLLf6DTQafUxp/
 0NJG0ao88gAi66QyJ/8Xw==
UI-OutboundReport: notjunk:1;M01:P0:ES8BrNUqKqA=;TP6LEYW+Du/gmApPe+KpZVXTCc5
 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
 NNr4l13PC7/AfcDwA==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/13/26 16:53, Richard Henderson wrote:
> On 10/11/26 08:10, Rick Richard wrote:
>>> There should be no need for this at all.=C2=A0 The probe sequence shou=
ld notice conflicting addresses and adjust.
>>>
>>> What's your failure case?
>>>
>>>
>>> r~
>>
>> You're right about that, but there's a less obvious case that falls
>> through the cracks: programs loaded through ld.so. qemu only loads
>> ld.so, so that's all the probe sees, and it picks guest_base 0. Then
>> ld.so maps the real program at its fixed address, right on top of qemu.
>>
>> An easy way to hit it is ldd on FreeBSD. In an aarch64 jail with the
>> stock perl package:
>>
>> =C2=A0=C2=A0 # ldd /usr/local/bin/perl
>> =C2=A0=C2=A0 /usr/local/bin/perl:
>> =C2=A0=C2=A0 ld-elf.so.1: /usr/local/bin/perl: mmap of entire address s=
pace failed: Cannot allocate memory
>=20
> Mm, right.
>=20
>> FreeBSD can't link static PIE, so qemu-*-static is always linked at
>> 0x200000.
>=20
> That's unfortunate.=C2=A0 We could explicitly link somewhere high in the=
 address space, perhaps.=C2=A0 E.g.
>=20
>  =C2=A0 -Wl,--image-base,0x80000000000
> ?
Rick, will you check and maybe come up with another patch?

Helge

