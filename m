Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E63C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaJw-0007PV-8F; Thu, 27 Aug 2026 09:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1wzaJn-0007OE-N4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:38:59 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1wzaJl-0003d1-Qi
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:38:59 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id CC72218041B
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:38:48 +0200 (CEST)
Received: (qmail 16823 invoked by uid 990); 27 Aug 2026 13:38:48 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
 by skiff.uberspace.de (Haraka/3.1.1) with ESMTPSA;
 Thu, 27 Aug 2026 15:38:48 +0200
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 13:38:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <39c0afbc330cd144bc1ae3757e7638b2a8c8fc57@nut.email>
TLS-Required: No
Subject: Re: [PATCH 13/35] target/avr: call plugin trap callbacks
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@oss.qualcomm.com>, 
 "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, "Alexandre Iooss"
 <erdnaxe@crans.org>, "Chinmay Rath" <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Ilya Leoshkevich"
 <iii@linux.ibm.com>, "David Hildenbrand" <david@redhat.com>,
 qemu-ppc@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, "Bastian Koppelmann"
 <kbastian@mail.uni-paderborn.de>, "Helge Deller" <deller@gmx.de>,
 "Stafford Horne" <shorne@gmail.com>, "Mahmoud Mandour"
 <ma.mandourr@gmail.com>, "Artyom Tarasenko" <atar4qemu@gmail.com>,
 "Eduardo Habkost" <eduardo@habkost.net>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Alistair Francis" <alistair.francis@wdc.com>,
 "Laurent Vivier" <laurent@vivier.eu>, "Weiwei Li" <liwei1518@gmail.com>,
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, "Mark Cave-Ayland"
 <mark.cave-ayland@ilande.co.uk>, "Yoshinori Sato"
 <yoshinori.sato@nifty.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "Aurelien Jarno" <aurelien@aurel32.net>,
 "Richard Henderson" <richard.henderson@linaro.org>, "Thomas Huth"
 <thuth@redhat.com>, "Max Filippov" <jcmvbkbc@gmail.com>, "Jiaxun Yang"
 <jiaxun.yang@flygoat.com>, "Michael Rolnik" <mrolnik@gmail.com>, "Song 
 Gao" <gaosong@loongson.cn>, qemu-riscv@nongnu.org, "Aleksandar Rikalo"
 <arikalo@gmail.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <aa4bdaf5-6669-4ed7-90fb-4e766f160118@oss.qualcomm.com>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-14-alex.bennee@linaro.org>
 <aa4bdaf5-6669-4ed7-90fb-4e766f160118@oss.qualcomm.com>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.035663) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.364336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=3YLSykSOgjx+A88sO5o8Doo1klTySZuA845vpIUw5f0=;
 b=H1PcMs5+zwTIkGKISmDQF6XsH1GKukHw6JTHx/8TPfnydTyCr4ykemYtPDftAjnQoJ020j7vm9
 AmseTI8Zro2L70wLz2Njk3pqaBdB5WCQpO/JjbRlY8wTJdIN77cNftOLtQZDIf6ATqP9o5JOLEyx
 yDiIVMEzndB344dUfhnXSaOE+QWJIwu4w/WprywWJifQTvtHODRT1nlXSiSsnKbLaQQ/5BkoZp7h
 tJcDSnJKXVR8IoZGw2DMIS1VxP8P2C3gpa5HerBPZTQN8CJHu2lVKLdJz69ZPtxxsLFDMrVhcRXh
 cEuQHpxZ4xL2yOFxM63RydIALfQOc2QdG+49xvXXJXn3lzqybSnl8MNFtOFsEOsflsk/AH5/Xu3k
 OpafC1ImSENz15gil/HpHDH5BK71wO8dDAeU/kyYkOIlXyCf1YawOb9UssC6R5lDVyWNfkvq5oCa
 Gx5o+9xml+2eXRIsblZA0bw5oCndn5ZQjx8YGM1LpfVvxvBclbY08bc3/DQMHX5GsZ3BDK+Sh4Dz
 588aAsBB+dBe51yR82sNO7Ru9RydbThLbcN4Vguujf9h/UUwqGgIbHl7ZWrmaFIB9+eevERTOZBw
 r9nRZiTyL4S8p2VTNiibysLDlYONScXBN8cM36KltX2scgObYGT3rbUwTGKcO06H4wa4j4A2UL0T
 A=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philippe,

sorry for the late reply. Did not realize I hadn't checked mails this
long.

August 17, 2026 at 1:14 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> Expanding a bit ...
>=20
>=20 77 void avr_cpu_do_interrupt(CPUState *cs)
>  78 {
>  79 CPUAVRState *env =3D cpu_env(cs);
>  80
>  81 uint32_t ret =3D env->pc_w;
>  82 int vector =3D 0;
>  83 int size =3D avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
>  84 int base =3D 0;
>  85
>  86 if (cs->exception_index =3D=3D EXCP_RESET) {
>  87 vector =3D 0;
>  88 } else if (env->intsrc !=3D 0) {
>  89 vector =3D ctz64(env->intsrc) + 1;
>  90 }
>=20
>=20Unconditionally recording exception vector as interrupt seems wrong,
> shouldn't we call qemu_plugin_vcpu_exception_cb() in that case?
>=20
>=20 91
>  92 if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
>  93 do_stb(env, env->sp--, ret, 0);
>  94 do_stb(env, env->sp--, ret >> 8, 0);
>  95 do_stb(env, env->sp--, ret >> 16, 0);
>  96 } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
>  97 do_stb(env, env->sp--, ret, 0);
>  98 do_stb(env, env->sp--, ret >> 8, 0);
>  99 } else {
> 100 do_stb(env, env->sp--, ret, 0);
> 101 }
> 102
> 103 env->pc_w =3D base + vector * size;
> 104 env->sregI =3D 0; /* clear Global Interrupt Flag */
> 105
> 106 cs->exception_index =3D -1;
> 107
> 108 qemu_plugin_vcpu_interrupt_cb(cs, ret);
> 109 }

Yes. As should be apparent from _some_ commit message, I wrote this
under the impression that AVR did not have exceptions. Or rather, what
we call exceptions in the discon API, which are synchronous events or
traps resulting from specific instructions being executed (including
things such as invalid instructios and instruction load failures).

We _do_ want to make sure to call qemu_plugin_vcpu_interrupt_cb only for
interrupts. At the same time, we don't necessarily want to call
qemu_plugin_vcpu_exceptions_cb either, at least if AVR just resets on an
illegal instructions.

Regards,
Julian

