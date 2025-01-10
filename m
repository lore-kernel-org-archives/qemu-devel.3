Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5617E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDQI-0004GI-IF; Fri, 10 Jan 2025 06:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDQH-0004GA-N1
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:43:29 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDQF-0007cM-HY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:43:28 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 234DC18154D
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:43:19 +0100 (CET)
Received: (qmail 5926 invoked by uid 990); 10 Jan 2025 11:43:19 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 10 Jan 2025 12:43:18 +0100
MIME-Version: 1.0
Date: Fri, 10 Jan 2025 11:43:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <e746423c27c0b0646bc1c27905d04c17ed7ebb91@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org
In-Reply-To: <87wmf46qmm.fsf@draig.linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
 <87wmf46qmm.fsf@draig.linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=hC4rMNASC8Z8dpCD8/ONi9WDq8NHKEWI/vsu2tisXiQ=;
 b=gZECQOqX2LFc2m9JdPS1s9w8L3gtCZTNUSKLesn4SC2l2QVdTsoFHtG0Vd0f5ehgvhWnIUXZi9
 7JURFxTcoKwEd1SnYggHVjeZwlrr5C7r2XZ2Ml7aR+LvgXddKhVp56ajg5mF2KGPY5LoEit2tbBT
 MKubU0fxxKE6vMWn8x3v1hf9Fy13wQApvKeDZBIEEymtv4G+M1E/70N0NL/acQOJRHZuOAtZV985
 Q/pRVWjN6WnKfgI/aIy5o/ZbCYTx+bbLhBBG+SloA+g1G69XvrRUves4FLy3/om6wQQ13iMou0br
 f1ZNkkdFqp3+o7TDqhYE/95BZ6Ix9F6P6yY2sX0vYO1zI9UHrFn4Y12CXBRHmhr9UTHWuKoNl2Pd
 SJmvGr9yyTlk7mbvDwCscMrY9i8KeLZyoixhDA1zA96fo5AjHPPgQItrJqwBsQpKA2BZlAoUFJoj
 y9YSXFHXTY3GIQvgsHnenvA7WDQzfMqejVuL+6H85v2oozRWZARL7ewzIGyolNBxLJpmKJO5DgVi
 dnowYqsbOiWcgSRWrW1Fp/MRhHNkbXcYfeMjEWlGOPmp1Ch4b6JfVjrxZmNYLOzkh9glNqGFMBbE
 /ZZ/sn7OiTbZMx9dlBd5QN0FXSsTwtNmG26BiLevv5gWZqy6EBjqO0/Uacg/Lut7WFqHefCOAaQ2
 E=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Alex,

January 9, 2025 at 2:52 PM, "Alex Benn=C3=A9e" wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> >  On 12/2/24 11:26, Julian Ganz wrote:
> > >  diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin=
.h
> > >  index 0fba36ae02..9c67374b7e 100644
> > >  --- a/include/qemu/qemu-plugin.h
> > >  +++ b/include/qemu/qemu-plugin.h
> > >  @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(=
qemu_plugin_id_t id,
> > >  typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_inde=
x,
> > >  void *userdata);
> > >  +
> > >  +/**
> > >  + * enum qemu_plugin_discon_type - type of a (potential) PC discon=
tinuity
> > >  + *
> > >  + * @QEMU_PLUGIN_DISCON_INTERRUPT: an interrupt, defined across al=
l architectures
> > >  + * as an asynchronous event, usually originating
> > >  + * from outside the CPU
> > >  + * @QEMU_PLUGIN_DISCON_EXCEPTION: an exception, defined across al=
l architectures
> > >  + * as a synchronous event in response to a
> > >  + * specific instruction being executed
> > >  + * @QEMU_PLUGIN_DISCON_HOSTCALL: a host call, functionally a spec=
ial kind of
> > >  + * exception that is not handled by code run by
> > >  + * the vCPU but machinery outside the vCPU
> > >  + * @QEMU_PLUGIN_DISCON_ALL: all types of disconinuity events curr=
ently covered
> > >  + */
> > >  +enum qemu_plugin_discon_type {
> > >  + QEMU_PLUGIN_DISCON_INTERRUPT =3D 1,
> > >  + QEMU_PLUGIN_DISCON_EXCEPTION =3D 2,
> > >  + QEMU_PLUGIN_DISCON_HOSTCALL =3D 4,
> > >  + QEMU_PLUGIN_DISCON_ALL =3D 7
> > >  +};
> > >=20
>=20>  Matter of style, but would be better to use:
> >=20
>=20>  enum qemu_plugin_discon_type {
> >  QEMU_PLUGIN_DISCON_INTERRUPT =3D 1 << 0,
> >  QEMU_PLUGIN_DISCON_EXCEPTION =3D 1 << 1,
> >  QEMU_PLUGIN_DISCON_HOSTCALL =3D 1 << 2,
> >  QEMU_PLUGIN_DISCON_ALL =3D -1
> >  };
> >=20
>=20<snip>
>=20
>=20Is this really a bit field though? If you will only report type of
> discontinuity at a time a simple 0 based enum with
> QEMU_PLUGIN_DISCON_MAX would be simpler.

We don't only use this type to communicate the kind of discontinuity but
also when registering callbacks. I'll make this more clear in the commit
message and/or documentation in the next series.

Regards,
Julian

