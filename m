Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01BDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSt5-0002R6-NS; Mon, 26 May 2025 04:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJSt0-0002H5-2v
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:08:42 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJSsy-0002d4-39
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:08:41 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id CA1C117FA4E
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 10:08:21 +0200 (CEST)
Received: (qmail 18846 invoked by uid 990); 26 May 2025 08:08:21 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 26 May 2025 10:08:21 +0200
MIME-Version: 1.0
Date: Mon, 26 May 2025 08:08:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <ec6f71c19f2f000844e0767e6742e7de3213e023@nut.email>
TLS-Required: No
Subject: Re: [PATCH v5 03/25] plugins: add hooks for new discontinuity
 related callbacks
To: "Richard Henderson" <richard.henderson@linaro.org>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>,
 qemu-devel@nongnu.org
In-Reply-To: <20250525205645.4366-1-neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
 <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
 <edf78ed0-7ada-467e-86de-47e2515588bc@linaro.org>
 <20250525205645.4366-1-neither@nut.email>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.967172) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.567172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=byvEIwHH+LL0d171JjrxH80XMie19ZFmlJaeQ0BmJVQ=;
 b=vJUX/JN54yZiLvtDWpoC8ZIE+ARnqUY+opj9AXawK2AnQ5JfcoHqtEQFRoT1xc8ZkTjvH0/zLA
 79Li5n0ANt3jRIY9uxnCFApoO7OrHwvV4/V9N3NQcZSWyKNjRmIdjl1l315QmtZdWwQok6CHod/c
 WJMAN8dTpFS1urE2NHSsVLrvny/N+kHDFTp/e742dL4mBy74z793frCa2GKGn45ovSS0HXa5CtrG
 oN/I7KMNzvlBjw62UhiyZvofQdQBqmAj0V9PRUs4KPKs830oQAlNHewQekqiBjDKcaOolV2tRwfR
 grmFd8kU6JpxZWAUR6I4Rjd9LI/bFTTmLChcoOIObJEfyhLwsluSST+VqvGAqDq3Dd0YHfQHCUsQ
 gjtSUwFmnS4nV4K8livN/2xL7jNjtEHiE9QDit9wV2x5wb6USZaERQK9Y4BZfHXpoIAnoCThl5M+
 zAMtrjfPt6BHBek7kD25tz6I+Jvy8E4I2W4Wtg0F0AVH6R1r9HggoYnzPSB/a1AEs9NfkffAQHHb
 4s92KVdc71rk5FnjMukL92a7GCuk57clomXpsoJe/zQ7UJmjggtBMF2u4c7Ccrp7usmBFYeEWp30
 RGjdSwmn8PK+JNHCYpHD2CVQS9745Iqdly2kuHth2WxiSzoPfhUlcUy4P1RduHnTqxEqdfDkK8/z
 M=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
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

May 25, 2025 at 10:56 PM, "Julian Ganz" wrote:
> Richard Henderson wrote:
> > On 5/19/25 16:19, Julian Ganz wrote:
> >  +QEMU_DISABLE_CFI
> >  +static void plugin_vcpu_cb__discon(CPUState *cpu,
> >  + enum qemu_plugin_discon_type type,
> >  + uint64_t from)
> >  +{
> >  + struct qemu_plugin_cb *cb, *next;
> >  + enum qemu_plugin_event ev;
> >  + uint64_t to =3D cpu->cc->get_pc(cpu);
> >  +
> >  + if (cpu->cpu_index < plugin.num_vcpus) {
> >  + switch (type) {
> >  + case QEMU_PLUGIN_DISCON_INTERRUPT:
> >  + ev =3D QEMU_PLUGIN_EV_VCPU_INTERRUPT;
> >  + break;
> >  + case QEMU_PLUGIN_DISCON_EXCEPTION:
> >  + ev =3D QEMU_PLUGIN_EV_VCPU_EXCEPTION;
> >  + break;
> >  + case QEMU_PLUGIN_DISCON_HOSTCALL:
> >  + ev =3D QEMU_PLUGIN_EV_VCPU_HOSTCALL;
> >  + break;
> >=20=20
>=20>  No point passing in QEMU_PLUGIN_DISCON_* only to covert it to QEMU=
_PLUGIN_EV_*.
> >=20
>=20It easily looks that way, and I myself stubled upon this at least one=
 or two
> times, but `type` is the enum we pass to the callback a few lines down =
and part
> of the public plugin API. `ev` on the other hand is the offset in the `=
cb_list`.
> So some translation is neccessary, unfortunately.

I just realized that you probably meant that we should pass ev as a
parameter to plugin_vcpu_cb__discon. This we can obviously do.

Regards,
Julian

