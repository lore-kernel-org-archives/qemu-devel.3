Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC0C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 20:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1widw2-0001tk-JY; Sat, 11 Jul 2026 16:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1widvv-0001tH-Vn
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 16:04:20 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1widvu-00061R-1J
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 16:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783800240; x=1784405040; i=deller@gmx.de;
 bh=c9OuIwW+B6txUepOML15yxm7dF4R1db6kRrvo3TS7qA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tM2yYYRNLCggpCmBJ5UxMAVyOg11vTxnbI8bR5FrKJffqzAm2ZOXaOtGlgyy7m1m
 eGjRsp3R+WYRywO5CKwJYRpuQyMp2SNUlFs6Y9oyj1TerP4uRvslNN92Qz8mg0cmK
 6/7qa6pGdEwR3lRSgeBpCA1SenjhmOCRRY0YY3wpybNaKs9QEUtxLSppojk0N94X6
 UaT2vpwn7gP80Mt4ftgNb3T8/j/8+jo84EdBUZ/1xUHvN767jV+Gy2mh7ilxienBg
 /FJELQ2LKNYFhiO64H3DcrQDgwuWYSWaqX6GHol4wFXQBILblf4JN1VlHdbV9IDoY
 4noLdx4KaHMgwRQqAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUjC-1wzcoc2yrC-00xDIq; Sat, 11
 Jul 2026 22:04:00 +0200
Message-ID: <480977b7-60af-4264-8e9d-d8bd4597a11e@gmx.de>
Date: Sat, 11 Jul 2026 22:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Enable TARGET_PAGE_BITS_VARY for
 loongarch64 user-only
To: Miao Wang <shankerwangmiao@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>
References: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
 <2018af95-66aa-40c6-b3eb-b7bba9bd26a1@tls.msk.ru>
 <A00A6FC2-6077-40F6-BF48-4318A2BAB9FC@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <A00A6FC2-6077-40F6-BF48-4318A2BAB9FC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S2+4vfFYrLTR/sNSZnKuKBpuJ3cEyTt++JmH6L9z1TLZCe98hHz
 Fjrv2SjxxyVvmuG9RGmILnPcpnOu5UnMXpKBwMemFs/ycKKV80RceHNido6TuZAjln4cKL8
 0KhNsqmWVz8pyk0niWyP7TmfJRMJp4YdgUrUVRNNTF3UJp1lIccO9mAe92psmota15ksmeF
 FdBQEEB48G83S0mfFbBLA==
UI-OutboundReport: notjunk:1;M01:P0:XGOw/0+qG0A=;YTK4Mjiv9IBBsBLvfHSSa3m5nJ+
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

On 7/8/26 14:09, Miao Wang wrote:
> Hi,
>=20
>> 2026=E5=B9=B47=E6=9C=888=E6=97=A5 19:38=EF=BC=8CMichael Tokarev <mjt@tl=
s.msk.ru> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On 30.06.2026 10:56, Miao Wang via B4 Relay wrote:
>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>> Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
>>> working on hosts with 16K page size.
>>
>> Doesn't the same apply to all other targets - hard-coding PAGE_SIZE to
>> 4k for any linux-user target will prevent this target from working on
>> hosts with 16k page size?
>=20
> I believe so. It seem that qemu-user might have trouble handling guest
> with smaller page size than the host, IIUC. If a certain target requires
> 4K page size while the host has a larger page size, then there will
> be no way to handle this. Using this patch just allows to use the
> same page size as the host when possible.
>=20
> BTW, in Debian, there are currently two "special" architectures,
> which are s390x and loong64. S390x is the only one with big-endianness

Just for the record:
hppa is big-endian as well, and in addition it's a 32-bit arch (for linux-=
user).

> while loong64 is the only one with 16K page size by default. As a
> result, testing results on these two architectures can catch more
> cross-architecture related bugs.
>=20
> Cheers,
>=20
> Miao Wang


