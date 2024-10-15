Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FCAD216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0idB-0004SZ-8Z; Tue, 15 Oct 2024 10:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1t0id8-0004Rp-5x; Tue, 15 Oct 2024 10:34:34 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1t0id6-0005LP-Am; Tue, 15 Oct 2024 10:34:33 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 6CC46A0840;
 Tue, 15 Oct 2024 16:34:26 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id AJy_xfe6odRP; Tue, 15 Oct 2024 16:34:25 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id BCA1FA0602;
 Tue, 15 Oct 2024 16:34:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr BCA1FA0602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1729002865;
 bh=pQ+//zyPjrbjIR7o2OZ2SNr6BUwBDomIyH0iHTZbzck=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=TWKLF4fumg8MAufG16cz9K5OETw0+sdUGK3mxprj2WV/MfFAJKt0JKjzwaUjSKAO5
 ImVF5CCZwAzWn6nfFJkpS0xN3R3fXAoa4/UjBfAO8AcVLA1cVTFkYmw2dSM4Sf2fSM
 vkIs7UT65Up1QxGKTdPNBKjI4V/HlpcLnwOTRLPA=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id Hnuvo_AQ9Oui; Tue, 15 Oct 2024 16:34:25 +0200 (CEST)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy3.enst.fr (Postfix) with ESMTP id 39464A0889;
 Tue, 15 Oct 2024 16:34:25 +0200 (CEST)
Date: Tue, 15 Oct 2024 16:34:24 +0200 (CEST)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: peter maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>, 
 qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Laurent Vivier <lvivier@redhat.com>
Message-ID: <698508180.2421226.1729002864954.JavaMail.zimbra@enst.fr>
In-Reply-To: <CAFEAcA_0eyAa=XjDnobYqkinEnW1wOetKDBqus7k1BTWTyLLpQ@mail.gmail.com>
References: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
 <20241003081105.40836-4-ines.varhol@telecom-paris.fr>
 <CAFEAcA_0eyAa=XjDnobYqkinEnW1wOetKDBqus7k1BTWTyLLpQ@mail.gmail.com>
Subject: Re: [PING PATCH v5 3/3] tests/qtest: Check STM32L4x5 clock connections
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2001:861:4680:b1b0:b400:8d99:1692:e69c]
X-Mailer: Zimbra 9.0.0_GA_4653 (ZimbraWebClient - FF131 (Linux)/9.0.0_GA_4653)
Thread-Topic: tests/qtest: Check STM32L4x5 clock connections
Thread-Index: 4f/g2E/kFYRd7h99URcQ2H0ATraGUw==
Received-SPF: pass client-ip=137.194.2.222; envelope-from=ivarhol-21@enst.fr;
 helo=zproxy3.enst.fr
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



----- Le 15 Oct 24, =C3=A0 16:20, peter maydell peter.maydell@linaro.org a =
=C3=A9crit :

> On Thu, 3 Oct 2024 at 09:11, In=C3=A8s Varhol <ines.varhol@telecom-paris.=
fr> wrote:
>>
>> For USART, GPIO and SYSCFG devices, check that clock frequency before
>> and after enabling the peripheral clock in RCC is correct.
>>
>> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Luc Michel <luc@lmichel.fr>
>=20
>=20
>> +static void test_clock_enable(void)
>> +{
>> +    /*
>> +     * For each USART device, enable its clock in RCC
>> +     * and check that its clock frequency is SYSCLK_PERIOD
>> +     */
>> +    QTestState *qts =3D qtest_init("-M b-l475e-iot01a");
>> +
>> +    check_clock(qts, "machine/soc/usart[0]/clk", RCC_APB2ENR, 14);
>> +    check_clock(qts, "machine/soc/usart[1]/clk", RCC_APB1ENR1, 17);
>> +    check_clock(qts, "machine/soc/usart[2]/clk", RCC_APB1ENR1, 18);
>> +    check_clock(qts, "machine/soc/uart[0]/clk", RCC_APB1ENR1, 19);
>> +    check_clock(qts, "machine/soc/uart[1]/clk", RCC_APB1ENR1, 20);
>> +    check_clock(qts, "machine/soc/lpuart1/clk", RCC_APB1ENR2, 0);
>> +}
>=20
> This new test is missing the qtest_quit(qts) call at the
> end, which makes it hang when run on OpenBSD. (I fixed
> this up in the pullrequest.)
>=20
> thanks
> -- PMM

Thanks for the fix!

In=C3=A8s

