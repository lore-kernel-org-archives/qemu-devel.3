Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4835CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 21:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0nmn-0004ca-EO; Mon, 22 Sep 2025 17:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0nml-0004cH-KC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 17:09:23 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0nmj-0001zx-Ba
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 17:09:23 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id EDDBE60B19
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 23:09:14 +0200 (CEST)
Received: (qmail 859 invoked by uid 990); 22 Sep 2025 21:09:14 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 22 Sep 2025 23:09:14 +0200
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 21:09:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <cb3883849f7d98da9b3b8700b7738f8085f1eb77@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 08/25] target/hppa: call plugin trap callbacks
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Helge Deller"
 <deller@gmx.de>
In-Reply-To: <fe7c9f9a-3198-44ff-bbcc-2ede230b2278@linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <c0b0251e53f1d602cfc333c53c6aeb723d9ddf01.1757018626.git.neither@nut.email>
 <fe7c9f9a-3198-44ff-bbcc-2ede230b2278@linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: BAYES_HAM(-1.120059) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.220059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=ZcU9lbMBMhdzHLPjumJcL0lYeHENyuFRL/Zka9QEM+E=;
 b=POQKs4q3yIpxs+e2tmF2BQI4u0QdWKbEUYBgJm6xWQCe9bLxFa0q/SrDj6Xg9OkzJba7OrgG5R
 TjzQO+dZYRYXp8M2jw29eXQgnXRgCubXEFwXef7XhaDtJ3ypc2tbcFi513JIWFJsiY6JJhdu3Y9k
 +n4VTs6m4Fl7BFlSpBcwF2e3DCbPTQEUWMuPEcN7Cz1Uzast+PQmmuSCRBSvvirnPMCe36x+0F7Y
 fm2e7e6Vrsh8ymKyFgTgoQ5ZhSFlNXsOOduZnSUiktQv8YBiIerbyKrzAkyPGuCJh44023g7vo31
 RHil4EiFZbBn8HBrjbeSAfV8bKbXhBU8+SEFqkWarbl45GRy2amIfib7RpARv8ypvH+tWV5Yo9/H
 U9eOCFrHhX33zMK00hGQmxRMUayTbAmXjMmRIWg0Is5iw5buSA/WVB11YIbX/4Yb/5VR720Lg6GG
 rcG/RTLTgQSrWsGiUI+Z04nIvHwZaQgL0Mde98YjdBb6vnzjGZhHczO+VwYYkah5ECwEndM0rXrV
 R+XysMICOGZ68Dj2so0BIzWMYZ/wrwHftWjJhPSba3qU9h1bs7CYQi0GTahHX1PFLapFlUAx5opR
 3logypXVUG7kZeHw+bCh0tLZp7ZSYm6hmi+vLchdITFdXJsFB5nxQNkthOxCOeO0bQw/8IOgpzpT
 0=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Philippe,

September 22, 2025 at 1:38 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> On 4/9/25 22:46, Julian Ganz wrote:
> >  diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> >  index 191ae19404..0742990c90 100644
> >  --- a/target/hppa/int_helper.c
> >  +++ b/target/hppa/int_helper.c
> >  @@ -212,6 +214,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
> >  env->iasq_f =3D 0;
> >  env->iasq_b =3D 0;
> >  > + switch (i) {
> >  + case EXCP_HPMC:
> >  + case EXCP_POWER_FAIL:
> >  + case EXCP_RC:
> >  + case EXCP_EXT_INTERRUPT:
> >  + case EXCP_LPMC:
> >  + case EXCP_PER_INTERRUPT:
> >  + case EXCP_TOC:
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >=20
>=20In the other target patches you list a set and default to
> the rest, why listing here the 2 sets and then falling
> back to the default? Should the default be g_assert_not_reached()?

Most architectures have either few inerrupts (and lots of exception) or
some clear distinction (e.g. RISC-V has a bit differentiating the two).
I found HPPA a bit confusing in this regard. Or to be more precise had
the feeling I would forget some case if I did not write them all down.
This _should_ mean that I already covered anything, but the logging code
further down also makes a point of covering the case that the exception
index is not one of these constants.

My memory is hazy but I might have read somewhere that some HPPA
platforms _may_ have additional interrupts not covered in the ISA spec.
At least this would not have been unheard of for an architecture.

If I'm wrong about that I'm happy to declare the default case
unreachable.

Regards,
Julian

