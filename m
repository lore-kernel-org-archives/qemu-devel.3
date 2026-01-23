Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1163D778B0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjMxe-0003XV-LA; Fri, 23 Jan 2026 14:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vjMxa-0003PC-LZ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:36:47 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vjMxZ-0007wM-7t
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769197003; x=1769801803; i=deller@gmx.de;
 bh=9IgLhUs4Yij7zwmk4oki1I5WJoFSf52R0xrK/91DhV8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GYaDJ36rqxIgHGDYSU6UPnN1mpE/piM2Kp3JFYJjkInb/I4BWT+ljGtRVFhcvRIu
 s7M9DPnJ1hj8fXAAMFVul5y8W1H3GPZ9cvmYCYLipzgSiyxv30FKOv5wwpmuhHCSe
 xNZtOVwYuHJygDrFd8sy0JUDVdqCvTLLylR0RACIfne/VyPK2stbGfO0164FMT7Po
 ihb6yNPeGF1n/dU3LhEmbIe1/3TAIApad1M+qH+eIDkUVBDx+UY0NTVa+M8591iMd
 MbyOUo4B48KpkYU7hi2qiv7Q97lzLpAdqKXJFILzKSUB/dpfJl+au0ZjI6O/KQOQ0
 OTjoDh0Ysz06iXi2lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.227]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1vXriC47wo-00Esen; Fri, 23
 Jan 2026 20:36:43 +0100
Message-ID: <33c396be-6411-4dad-8d9a-fa756d4267a1@gmx.de>
Date: Fri, 23 Jan 2026 20:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] linux-user: Fix MADV_XXX constants on hppa target
To: Peter Maydell <peter.maydell@linaro.org>, deller@kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20260123150921.17891-1-deller@kernel.org>
 <20260123150921.17891-4-deller@kernel.org>
 <CAFEAcA8X7NObV60MV_uKaRzo33iXUkRMty68iwftrfhcyWJ_sA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA8X7NObV60MV_uKaRzo33iXUkRMty68iwftrfhcyWJ_sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VGS64aqpdxxEA87eSuc8Amstac3PbsupZRunXJhcft/7ZS44FxU
 D/qJiNp8qqFaNervJr/tO68rqYTWi6HlqFB5aQojBxGrpBAxfAMXtrATHivAB7S18iTOgXp
 kVwejPtaHkri43DfdACiEsKxJm2DEgkzdXXKcZqSj4Fv4zlam5Cv/z2r/HICy+LdM8FUrh5
 RLJ2/h2BOgQl2vYtJ4UnQ==
UI-OutboundReport: notjunk:1;M01:P0:A/VfUV497ck=;lUwTh7aAfBQGyBLceOiNrqKkWpz
 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
 YoJINCuI=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/23/26 16:57, Peter Maydell wrote:
> On Fri, 23 Jan 2026 at 15:11, <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> Older hppa binaries may still use the old MADV_XXX constants for the
>> madivise() syscall. Fix it up in the same manner as it's done in the
>> Linux kernel in the parisc_madvise() function.
>=20
> "Remove this wrapper in year 2025" it says :-)

Yes, I think I was too optimistic when I added that code back then.
I found such programs yesterday....

>> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!
Helge

