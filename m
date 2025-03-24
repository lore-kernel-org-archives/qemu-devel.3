Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47039C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkoL-0004ab-P6; Mon, 24 Mar 2025 12:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.aldebert@univ-tlse3.fr>)
 id 1twkoJ-0004aL-B5
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:37:59 -0400
Received: from gw2-out.univ-tlse3.fr ([195.220.43.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.aldebert@univ-tlse3.fr>)
 id 1twkoG-0008Pf-GM
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:37:59 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 prod-zextras-mta-out02.univ-tlse3.fr
 9F25A18043B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-tlse3.fr;
 s=c439b0a7-3b73-4fd0-9251-89a2c958e908; t=1742834268;
 bh=R4kvN5qczl48uagi1mURVMUSoXMvNrXjxCY5Yardw04=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=k1PvA1GCE3OGpe4xB9IbA8cKJrpBsY1SYKkcb0JTP5Y0kaclrXwO/AyXcAg3/tahO
 vCnEjpZposZFqKRNcODgl4lnGLcjE1O7u3dIQFUiTU0PJX8tX6AqXnxuUEJwNxwIqZ
 U/Z1qZDzWtpdbi70dqo6jkwShfFIF5Xc1ViufedXqiQG49OSWKo/6O4WD+vciZqkvM
 n2fs1wfqwtDKKWI5qi2q1eOceCiRWCa4jYno5mgBJ1aJouCg406PrRUbfPXeILLrs4
 xAgDGfSkQIP2N9hHpU2Es4uHfRhQYGnM6U+v4v4d52hpJNk9Abem1Rk5QIEO0hUvYH
 Y1lsGyTRVJwng==
Date: Mon, 24 Mar 2025 17:37:48 +0100 (CET)
From: clement.aldebert@univ-tlse3.fr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: laurent polzin <laurent.polzin@univ-tlse3.fr>, 
 "millian.poquet" <millian.poquet@univ-tlse3.fr>, 
 qemu-devel <qemu-devel@nongnu.org>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <975738318.22990772.1742834268217.JavaMail.zimbra@univ-tlse3.fr>
In-Reply-To: <CAFEAcA-aCi8CrHOffPJxFQq9xqnR+-_S6LUFg69PsdSR+g60gw@mail.gmail.com>
References: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
 <87ecytm2ru.fsf@draig.linaro.org>
 <4545005.21021813.1742490863752.JavaMail.zimbra@univ-tlse3.fr>
 <CAFEAcA8rBnTD3pqiraQvgLLyOWMCj=2cftgDkZp5h8N7F8nq6g@mail.gmail.com>
 <CAFEAcA-aCi8CrHOffPJxFQq9xqnR+-_S6LUFg69PsdSR+g60gw@mail.gmail.com>
Subject: Re: Raspberry Pi 3B energy consumption
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_ZEXTRAS_9043 (ZimbraWebClient - GC134
 (Win)/9.0.0_ZEXTRAS_9043)
Thread-Topic: Raspberry Pi 3B energy consumption
Thread-Index: 2B2R7v52zFgHfxmwHzbb6pF5oa658g==
Received-SPF: pass client-ip=195.220.43.154;
 envelope-from=clement.aldebert@univ-tlse3.fr; helo=gw2-out.univ-tlse3.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Dear Peter Maydell,

Thank you for your detailed response.

We will take a closer look at why, when using WFI, the affected cores still=
 appear to be at 100% utilization in htop. Additionally, we will investigat=
e whether implementing WFE in QEMU would be necessary to achieve proper CPU=
 core shutdown.

Currently, we are not using PSCI, but this does seem like a promising appro=
ach that we will explore further.

Regarding the use of the "virt" machine, our supervisor, M. Poquet, require=
s the Raspberry Pi 3B specifically for his courses due to its hardware spec=
ifications. Therefore, switching to "virt" would only be considered as a la=
st resort.

Thank you again for your insights. Any further recommendations would be gre=
atly appreciated.

Best regards,
Cl=C3=A9ment Aldebert & Laurent Polzin



----- Mail original -----
De: "Peter Maydell" <peter.maydell@linaro.org>
=C3=80: "clement aldebert" <clement.aldebert@univ-tlse3.fr>
Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, "qemu-devel" <qemu-devel@n=
ongnu.org>, "millian.poquet" <millian.poquet@univ-tlse3.fr>, "laurent polzi=
n" <laurent.polzin@univ-tlse3.fr>
Envoy=C3=A9: Jeudi 20 Mars 2025 21:11:52
Objet: Re: Raspberry Pi 3B energy consumption

On Thu, 20 Mar 2025 at 20:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> If you need WFE to work, that's certainly feasible and something it would
> be nice to see, but potentially quite a bit of work in the guts of QEMU's
> arm emulation. (Basically going to sleep on WFE is easy but then making
> sure that all the events  and situations that need to wake up a WFE is
> tedious. We implement sleep-on-WFI but not sleep-on-WFI because the set

should read "sleep-on-WFI but not sleep-on-WFE", of course. Oops...

> of WFI-wakeup events is rather smaller than the WFE-wakeup events.) It's
> been in the "we really should implement this but since the only downside
> is the host CPUs spinning, we've never got round to it" bucket for years.

-- PMM

