Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC85C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 16:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw2oe-0006ni-Pv; Sun, 14 Apr 2024 12:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rw2oY-0006lb-Bm
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 12:34:46 -0400
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rw2oW-00087H-Fk
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 12:34:46 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id EC8F1A0636;
 Sun, 14 Apr 2024 18:34:37 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id Pb_E9ZU9s8NK; Sun, 14 Apr 2024 18:34:37 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 82767A0602;
 Sun, 14 Apr 2024 18:34:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 82767A0602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713112477;
 bh=994MydJ2g7EjBtG0ZGQo/+IZcCEAG2KgDOutVfO/8dQ=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=LGuEEd4/9KMkPLyhJe5YoSJDpcTrvzlRcOwZL0pgCFWiXe9fIbDd0dtDlE5Sdbrrv
 +BVyuWPUHG3fFIfoq8/AhCjr6ag5z/9xEC3p2nAb/A20yOsR43D+6vxuL/nDzPQWLT
 dXNZ5w7U+HLl/o1KmhF1EPXBcBzemyE2YPpOZO38=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id iUuXbLbyXSV2; Sun, 14 Apr 2024 18:34:37 +0200 (CEST)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy3.enst.fr (Postfix) with ESMTP id 32397A05DB;
 Sun, 14 Apr 2024 18:34:37 +0200 (CEST)
Date: Sun, 14 Apr 2024 18:34:36 +0200 (CEST)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Message-ID: <1522538853.18428176.1713112476711.JavaMail.zimbra@enst.fr>
In-Reply-To: <f8878a58-8eb6-4a2d-8e77-d38b11a5d4c1@linaro.org>
References: <20240414132518.278858-1-ines.varhol@telecom-paris.fr>
 <f8878a58-8eb6-4a2d-8e77-d38b11a5d4c1@linaro.org>
Subject: Re: [PATCH] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a02:1808:204:ac85:d9f9:fe2c:cd32:5d75]
X-Mailer: Zimbra 9.0.0_GA_4597 (ZimbraWebClient - FF123 (Linux)/9.0.0_GA_4597)
Thread-Topic: tests/qtest : Use `g_assert_cmphex` instead of `g_assert_cmpuint`
Thread-Index: o+f9pbgg2G/DZkCg8j+xbEi40M1ECg==
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ivarhol-21@enst.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



----- Le 14 Avr 24, =C3=A0 18:19, Philippe Mathieu-Daud=C3=A9 philmd@linaro=
.org a =C3=A9crit :

> Hi In=C3=A8s,

Hello Philippe !

>=20
> On 14/4/24 15:24, In=C3=A8s Varhol wrote:
>> The messages for STM32L4x5 tests will be easier to understand with
>> `g_assert_cmphex` since the comparisions were made with hexadecimal
>=20
> "comparisons"

Ouch thank you I'm fixing it.

>=20
>> numbers.
>>=20
>> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> ---
>>   tests/qtest/stm32l4x5_exti-test.c   | 138 ++++++++++++++--------------
>>   tests/qtest/stm32l4x5_syscfg-test.c |  74 +++++++--------
>>   2 files changed, 106 insertions(+), 106 deletions(-)
>=20
> $ git grep g_assert_cmpuint.*,\ 0x tests/qtest/stm32*| wc -l
>      105
>=20
> Nice cleanup!
>=20
> $ git grep g_assert_cmpuint.*,\ 0x | wc -l
>      148
>=20
> Still 33 to go... (not asking you to do it!).

Very cool tool. I can fix it (also with a regex), should I change those wit=
h
comparisons to 0x0 and 0x1 though?

Best,

Ines

