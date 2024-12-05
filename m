Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4997E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBAD-0005zi-2x; Thu, 05 Dec 2024 07:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBA3-0005xk-L1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:40:52 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBA0-00022f-G5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:40:50 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 26EE418044B
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 13:40:26 +0100 (CET)
Received: (qmail 19725 invoked by uid 990); 5 Dec 2024 12:40:26 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 13:40:25 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 12:40:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=zCMw2VC5NVaMEa0mPJe1ygnrt705qhMTE3Co87tWO1M=;
 b=GiJIFoiODfLn8tyWViDeaT4EDB8U3a1+EuzA3EEDtFfCv9BgK481q72AN2Y+op+R9pwhjn+K/2
 09ifOl683HHnq2VokrGiYFxRSlYvYz/sVc9mqpujWTJ8DBawPqEGQaniuXhYNu06TsVe5rUlOATW
 6difA5awJL+zAvjHy6owqe+Y4HQjKOGXTcw/hGeymbG5d8nL1Y9iRZPBPfVpq1O6PiMflJw1dfht
 a2zVeb58jS+IMHWn/1naO4wvU8R9hxQmIT8NA0O2XooTdyINLf10792IHcMk9ANJFTgQi0iyyDBC
 tCPQRiR9RchmjJfXKvyOp5qE1qImc0G+FeK+3B3rrRUkS7Zx/c4FbQplD37IygEu2vg9Om7cJ653
 cmLiYq3A+4piBtTZhe1dRhHqL04vioBgfHuuqGYNvwSARHTPJhMmzAPcBCXYRYnorJu2xHbpEEeF
 Ucnl70VeZ3/Q5n4YKyDIXnZloyMdU8yjBWmkOQvmE+hdm7PDtOvifGQlmnG5Kgj1EgUYMG0AKvWu
 LHqeAqqtsgzHHoS9Buj5ARaVc78b9I2WNzWPNxFtKXYMdB9RSVR+6+X6tjr7lv3+ADqyS4OeFPOE
 ny/3PcEWTRgiJ4SdB7WEBpqhNpCX8P+IO03iMWbNr/ZOynAvest1Wmzs9F1EZaPOcCNp+JOrUBuy
 U=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Pierrick,

December 4, 2024 at 11:41 PM, "Pierrick Bouvier" wrote:
> On 12/3/24 00:45, Julian Ganz wrote:
>=20
>=20>=20
>=20> Hi,
> >  December 2, 2024 at 8:26 PM, "Julian Ganz" wrote:
> >=20
>=20> >=20
>=20> > diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugi=
n.h
> > >  index 0fba36ae02..9c67374b7e 100644
> > >  --- a/include/qemu/qemu-plugin.h
> > >  +++ b/include/qemu/qemu-plugin.h
> > >  @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(=
qemu_plugin_id_t id,
> > >=20
>=20>  <snip>
> >=20
>=20> >=20
>=20> > +/**
> > >  + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity call=
back
> > >  + * @vcpu_index: the current vcpu context
> > >  + * @type: the type of discontinuity
> > >  + * @from_pc: the source of the discontinuity, e.g. the PC before =
the
> > >  + * transition
> > >  + * @to_pc: the PC pointing to the next instruction to be executed
> > >  + *
> > >  + * The excact semantics of @from_pc depends on @the type of disco=
ntinuity. For
> > >  + * interrupts, @from_pc will point to the next instruction which =
would have
> > >  + * been executed. For exceptions and host calls, @from_pc will po=
int to the
> > >  + * instruction that caused the exception or issued the host call.=
 Note that
> > >  + * in the case of exceptions, the instruction is not retired and =
thus not
> > >  + * observable via general instruction exec callbacks. The same ma=
y be the case
> > >  + * for some host calls such as hypervisor call "exceptions".
> > >=20
>=20>  Some more notes about this bit: I originally tried to make the fro=
m_pc
> >  semantics independent from the type of event, i.e. either of the two
> >  cases. I obviously did not succeed in doing so. As, in most cases, t=
he
> >  instruction pointed to by from_pc is not observable via exec callbac=
ks
> >  I could also not test this behaviour in the testing plugin (see patc=
h
> >  11). I am therefore in favor for dropping the from_pc for the next
> >  iteration of this patch series.
> >=20
>=20Does it mean that information returned should be dependent of type of=
 event, as we previously discussed on v1?

Yes, and I don't like it.

Regards,
Julian Ganz

