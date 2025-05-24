Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC7CC54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 23:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIy9w-0006AY-Bu; Sat, 24 May 2025 19:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uIy9s-0006AC-E3
 for qemu-devel@nongnu.org; Sat, 24 May 2025 19:20:05 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uIy9p-0002Xd-Bm
 for qemu-devel@nongnu.org; Sat, 24 May 2025 19:20:03 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 077EC17FC6B
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 01:19:51 +0200 (CEST)
Received: (qmail 14573 invoked by uid 990); 24 May 2025 23:19:50 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 25 May 2025 01:19:50 +0200
MIME-Version: 1.0
Date: Sat, 24 May 2025 23:19:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <d63337579fd7eac49aea0452496a3f8cef9f8fc7@nut.email>
TLS-Required: No
Subject: Re: [PATCH v5 08/25] target/hppa: call plugin trap callbacks
To: "Richard Henderson" <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Helge Deller" <deller@gmx.de>
In-Reply-To: <54ddae99-e399-465d-ac9e-7f01ed26207f@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <62a954b31818763a2f3e0806fb9c912f6dd44972.1747666625.git.neither@nut.email>
 <54ddae99-e399-465d-ac9e-7f01ed26207f@linaro.org>
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.089823) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.189823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=Wzk/ulonSPvsCag0Q6asSn567vy93cry/B7nngri8YY=;
 b=Cv6883SyQpOoCYJ6kq03kfdTNPXLu/3OAmaf4fc1PhqGREgrP82KXJd+cNjOfuRrBxJGr6Pdic
 bQ0wW+KZvT9sMjdvUJcKB7mv9L0EC9SV/xZ18s/stOGdtv7JSx9qrwP/+fnHDx8182ynsMkT9ED6
 vdP6Ls3roWMnit9xwDG8Vgb7QkyfT1a5wgottKHYXLqFJoNsVH8D650mAzPVkcbKLMSntTM7bn+O
 R+TfGGCZ4tz5XCAM9Qq7B+EjeWjcuGfbcsKzdEEbFFscltg4If0uZ0IyMJYXQ3m5SKw19EMCM6KK
 2Z62CKXNkv98V4H9HAUP0xX8aCKupT7ouL6qExvAvO9ShPPvvJ1ZXqT70E+u32gBIBVEvrFO1aR0
 GsPp3JY+82NBw3otzd43Lcz0H0DBNUoae2fh/8f9RqOgM/ZL2og45eM5In+M6xIqPLo23xpSt++v
 Vv3wee2twHFfp28RefVTtVU8gvSKLYA7mC5N+2n6GP87MtKHOrABP+rc5z+t/pdKf15C1qNShD3L
 LzIEu3meryxm5+Ct39MSQHbTLtoMRAsQhDaqUYLE8iSjwc3yThwiy/atgeIHQNcApDSfSmDlB6Wn
 U1w9wIhCZensBXojDUhNLsdwrsHuNz27ak+KJ9yuX68gkOqVHDgonDjBMbYzqJ4ewvAPMb4C4AXc
 A=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hi Richard,

thanks for the feedback. For some reason only three of your replies made
it to my inbox, but I've seen them (on lore.kernel.org) and I will
incorporate it.

May 24, 2025 at 7:07 PM, Richard Henderson wrote:
> On 5/19/25 16:19, Julian Ganz wrote:
> >  diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> >  index 7d48643bb6..e9325319a7 100644
> >  --- a/target/hppa/int_helper.c
> >  +++ b/target/hppa/int_helper.c
> > <snip>
> >  @@ -208,6 +210,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
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
> >  + qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >=20
>=20Interrupts. Why are these separate from default:?

Oh, right. That should have been interrupts. Thanks for catching that.

It's a crude attempt to make sure I covered all exception types
correctly. The default case handles unknown exceptions, which I _assume_
are interrupts triggered by some periphery (but i might be wrong about
that). I was afraid that the simple absence of a name from the list
below would be too error-prone in terms of long-term maintenance. I'm
not against removing this, though.

Regards,
Julian

