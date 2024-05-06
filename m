Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CC0C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 17:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s42ag-0008Ee-7X; Mon, 06 May 2024 13:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1s42ae-0008D2-6u; Mon, 06 May 2024 13:57:28 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1s42ac-0007tq-2I; Mon, 06 May 2024 13:57:27 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 160CCA05A4;
 Mon,  6 May 2024 19:57:22 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 8MdzYGTSPzDP; Mon,  6 May 2024 19:57:21 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 72CE2A05BB;
 Mon,  6 May 2024 19:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 72CE2A05BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1715018241;
 bh=vmw06Qox83AKkQJWjlT22YUALewD7ZEpz6nr+31ZcdE=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Go7Wtubu1ZxnkWJwWzy4usfTlxaSOGIhr5FsOzv91f/yFsA7/bQDssVsLPL8tkPhK
 qeXn8rhg8GL3r9+9sRWJL5M6KqKG7Q/tlazZyArBPsNEYJF6wPn7gVtnT1tS2J9slf
 dtRUEQetRIDFawBvMRjPOVclyQ+ByEFZOFUSYqzI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id EGjEvQV5SwiT; Mon,  6 May 2024 19:57:21 +0200 (CEST)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy3.enst.fr (Postfix) with ESMTP id 00442A05A4;
 Mon,  6 May 2024 19:57:20 +0200 (CEST)
Date: Mon, 6 May 2024 19:57:20 +0200 (CEST)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 peter maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1102315161.3797279.1715018240611.JavaMail.zimbra@enst.fr>
In-Reply-To: <cf86b648-b150-428e-b415-01db237158ef@redhat.com>
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-5-ines.varhol@telecom-paris.fr>
 <cf86b648-b150-428e-b415-01db237158ef@redhat.com>
Subject: Re: [PATCH 4/4] tests/qtest: Check STM32L4x5 clock connections
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a02:1808:204:9e3b:a413:1409:5494:38ad]
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF125 (Linux)/9.0.0_GA_4612)
Thread-Topic: tests/qtest: Check STM32L4x5 clock connections
Thread-Index: /bXIl7YHwsppfV9lbUhw7w2YFATabA==
Received-SPF: pass client-ip=137.194.2.222; envelope-from=ivarhol-21@enst.fr;
 helo=zproxy3.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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



----- Le 6 Mai 24, =C3=A0 6:16, Thomas Huth thuth@redhat.com a =C3=A9crit :

> On 05/05/2024 16.05, In=C3=A8s Varhol wrote:
>> For USART, GPIO and SYSCFG devices, check that clock frequency before
>> and after enabling the peripheral clock in RCC is correct.
>>=20
>> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> ---
>> Hello,
>>=20
>> Should these tests be regrouped in stm32l4x5_rcc-test.c ?
>=20
>  Hi,
>=20
> sounds mostly like a matter of taste at a first glance. Or what would be =
the
> benefit of putting everything into the *rcc-test.c file? Could you maybe
> consolidate the get_clock_freq_hz() function that way? (maybe that
> get_clock_freq_hz() function could also be consolidated as a inline funct=
ion
> in a shared header instead?)
>=20
>  Thomas

Hello,

I was indeed looking to consolidate the functions get_clock_freq_hz() and
check_clock() from *usart-test.c (along with the definitions for RCC
registers).
Thank you for your suggestion, I'll use a header file.

In=C3=A8s Varhol


