Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E4CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ghP-0007iY-T7; Fri, 17 Oct 2025 05:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1v9ghN-0007i3-He; Fri, 17 Oct 2025 05:24:33 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1v9ghI-0003Fi-NT; Fri, 17 Oct 2025 05:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760693064; x=1761297864; i=deller@gmx.de;
 bh=nTYU7PTzmjs06U80PCamLRY3uFF7jC345VRvx0qAOvE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GLtCb/6g9wAnXppKMyVrMEkjpmvt6qUcpjCQDWAcy6kL3Ws0wNN7A/Mp/xhHcS+V
 /ZLQxMCSrZ+SqFDnBG3rnMU9zQILSNx+pSHyBXX58W09AJRmbXnrQ7RetSjUrWJ3P
 J7O90nyzluOCc3iMX26mmC8NM0RSkuRt4dzeDpQb3cuTh2wyXaYdIpzrDMUov26Ab
 7WA9GfoBGj8xLdNuDFZjrpBfb54IvBmf+NnkKVqMf61isxIpXri2uW+YR1Kwov0so
 uAQBZ0josZf/QWhOFLC3QjyNUPWYHt0yREafa8dum+HwUOwSkymFc/5RqBxiMyEYR
 J+CmL6P32YiM1vdBRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.190]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1uNCbc3IZ9-00oJll; Fri, 17
 Oct 2025 11:24:23 +0200
Message-ID: <46bf13bb-0308-4737-86d9-ed5aff87b415@gmx.de>
Date: Fri, 17 Oct 2025 11:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
To: Michael Tokarev <mjt@tls.msk.ru>,
 Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Andreas_H=C3=BCttel?= <andreas.huettel@ur.de>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
 <5ee3a3db-8fa2-426f-961b-aae09cb11c40@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <5ee3a3db-8fa2-426f-961b-aae09cb11c40@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jSVE6kcNnDkwG9JDMJW7WZrPFVtHxc0JEZUKAqlbjU7ZYRlCA0K
 w2fT+9MU8bMHa4u/v4M2Phb4pbG8CXyUzGbtL/sCxB6B/gkGAXolLH1ALa5J8U8SRklPfxn
 ez65/i9f15qEdfqKPA8RDI5F5rptxhhTb/+GM5G6LZMRL3UhNfcbjsDxy47aq7OeYmpMUOq
 DiE0V1DllE5H3e62tK6+g==
UI-OutboundReport: notjunk:1;M01:P0:IDmLDLEPymM=;zyREgJbe6QnTIUw5G86SBWrArrK
 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
 G7eLyz/cteZ3ZA==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/17/25 07:55, Michael Tokarev wrote:
> On 10/9/25 23:51, Gabriel Brookman wrote:
>> For the fmpyadd instruction on the hppa architecture, there is a bit
>> used to specify whether the instruction is operating on a 32 bit or 64
>> bit floating point register. For most instructions, such a bit is 0 whe=
n
>> operating on the smaller register and 1 when operating on the larger
>> register. However, according to page 6-57 of the PA-RISC 1.1 Architectu=
re
>> and Instruction Set Reference Manual, this convention is reversed for t=
he
>> fmpyadd instruction specifically, meaning the bit is 1 for operations o=
n
>> 32 bit registers and 0 for 64 bit registers. Previously, QEMU decoded
>> this operation as operating on the other size of register, leading to
>> bugs when translating the fmpyadd instruction. This patch fixes that
>> issue.
>>
>> Reported-by: Andreas H=C3=BCttel <andreas.huettel@ur.de>
>> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3096
>> ---
>> Hi all,
>>
>> This patch fixes the decoding of the fmpyadd instruction on the hppa
>> target, which uses an inverted bit convention to select between
>> 32-bit and 64-bit floating-point registers. The issue was reported by
>> Andreas H=C3=BCttel after observing incorrect behavior when running rea=
l
>> binaries under that target. He kindly submitted a minimal reproducer
>> which I was able to use to debug the issue. I used this reproducer
>> to verify correct operation after my fix.
>>
>> Thanks,
>> Gabriel
>>
>> Reported-by: Andreas H=C3=BCttel
>> ---
>> =C2=A0 target/hppa/insns.decode | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> I'm picking this up for qemu-stable (10.0 & 10.1).
Yes, please.

Helge

