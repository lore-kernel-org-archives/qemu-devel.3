Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9606C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLaN-0004qD-2G; Thu, 20 Mar 2025 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.aldebert@univ-tlse3.fr>)
 id 1tvJTj-0004QQ-PC
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:14:47 -0400
Received: from gw1-out.univ-tlse3.fr ([195.220.43.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.aldebert@univ-tlse3.fr>)
 id 1tvJTZ-0000ML-0x
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:14:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 prod-zextras-mta-out02.univ-tlse3.fr
 AA7FB17F5DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-tlse3.fr;
 s=c439b0a7-3b73-4fd0-9251-89a2c958e908; t=1742490864;
 bh=t7DeI+Vp0ABtVV8ecwgLihk8WuV4youK74bgGzJwmGg=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=U6PSic4ieOU6Zmk7lr48bdrTWwL1WUw68jKpnaRg33JDVBhC4At9kFUj+Cr+FtxL3
 4N5h9XlAncNVNXPy4nO1j2fLgaYCjQWf+NORbE12ZpPp11/swJBnZGMQLbx5rmkS1t
 Q9ywxrqqscYmI3VW8D2L6vwlmsiPVEEpIXzP1JIkM0q6k4uvitKO2wf12jAfdyTVrU
 5er6gux0VP9aSNDStAfdSazxrH0WqUD0/t3N18zkzF7DsNTCRhtbJwQ6P65SzFJTDe
 ZBUwwiZ/yQILXu9Inn6b7XtIyov5Y0HT5o/Qr0GcoPkqMIVobCFse5M//oSy4PhEEo
 vxAO1SrKCZVrg==
Date: Thu, 20 Mar 2025 18:14:23 +0100 (CET)
From: clement.aldebert@univ-tlse3.fr
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "millian.poquet" <millian.poquet@univ-tlse3.fr>, 
 laurent polzin <laurent.polzin@univ-tlse3.fr>
Message-ID: <4545005.21021813.1742490863752.JavaMail.zimbra@univ-tlse3.fr>
In-Reply-To: <87ecytm2ru.fsf@draig.linaro.org>
References: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
 <87ecytm2ru.fsf@draig.linaro.org>
Subject: Re: Raspberry Pi 3B energy consumption
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_ZEXTRAS_9043 (ZimbraWebClient - GC134
 (Linux)/9.0.0_ZEXTRAS_9043)
Thread-Topic: Raspberry Pi 3B energy consumption
Thread-Index: pA6rk1GkJoiscCDX1gT3qCYyA9gHMQ==
Received-SPF: pass client-ip=195.220.43.153;
 envelope-from=clement.aldebert@univ-tlse3.fr; helo=gw1-out.univ-tlse3.fr
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Mar 2025 15:29:45 -0400
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

Dear Alex Benn=C3=A9e,

Thank you for your response and for the provided documentation link.

To clarify, when we refer to energy consumption, we are specifically lookin=
g at CPU core utilization. Our goal is to ensure that when we turn off CPU =
cores on the emulated Raspberry Pi 3B, the host machine does not keep its c=
orresponding cores running at 100% utilization.

This is particularly relevant for our use case, as our supervisor, M. Poque=
t, intends to use this project for teaching operating system development. S=
tudents using QEMU to emulate a Raspberry Pi 3B may have different host mac=
hines, so our objective is to implement a general approach that ensures CPU=
 core deactivation works properly regardless of the host system.

So far, our measurements indicate that even after turning off cores in the =
emulated system, all CPU cores on the host remain at 100% utilization. We a=
re exploring ways to improve this behavior.

We have looked into using -icount, but we would like to find a more viable =
solution, particularly for the Cortex-A53 CPU used in the Raspberry Pi 3B. =
Ideally, we would like to be able to use -smp 1 without being constrained b=
y QEMU=E2=80=99s limitations and to implement proper CPU core shutdown, sim=
ilar to what is available on x86-64 architectures.

Would you have any recommendations or insights on achieving better power ma=
nagement in this scenario?

Best regards,
Cl=C3=A9ment Aldebert & Laurent Polzin

----- Mail original -----
De: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
=C3=80: "Polzini" <laurentpolzin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, "millian poquet" <millian.p=
oquet@univ-tlse3.fr>, "clement aldebert" <clement.aldebert@univ-tlse3.fr>
Envoy=C3=A9: Mercredi 19 Mars 2025 16:57:41
Objet: Re: Raspberry Pi 3B energy consumption

Polzini <laurentpolzin@gmail.com> writes:

> Dear Sir/Madam, My name is Cl=C3=A9ment Aldebert, and I am a third-year c=
omputer science student at Paul Sabatier University.
> Together with my teammate Laurent Polzin, we are working on a project sup=
ervised by Millian Poquet. Our project focuses on
> reducing the energy consumption of QEMU=E2=80=99s Raspberry Pi 3B emulati=
on, as we have observed that power usage is quite high
> even when the system is idle.

Can you qualify that a bit more? What are you running the emulation on?
What power usage do you see?

Power consumption of the emulation is really just down to computational
efficiency of the emulation and if we ever get to a point that QEMU can
go idle giving the host system a chance to reach a lower power state.

> Ultimately, we also aim to enable emulation on a single CPU core.

If you want to run all emulation on a single core you could use -icount
to do that. It is less efficient though.

> We are reaching out to
> inquire if you have any advice, resources, or suggestions for implementin=
g power management in QEMU, particularly for the
> Raspberry Pi 3B model. Additionally, we would like to understand any cons=
traints or best practices regarding adding new
> code or features to QEMU.

What documentation that exists can be found in the developers section of
the manual:

  https://qemu.readthedocs.io/en/master/devel/index.html

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

