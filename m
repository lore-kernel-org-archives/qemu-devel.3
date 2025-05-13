Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE75C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 19:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEvIm-0001sd-C5; Tue, 13 May 2025 15:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1uEv6J-0000US-Kh
 for qemu-devel@nongnu.org; Tue, 13 May 2025 15:15:44 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1uEv6F-00053k-Ln
 for qemu-devel@nongnu.org; Tue, 13 May 2025 15:15:38 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 8C3921800C2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 21:15:26 +0200 (CEST)
Received: (qmail 2472 invoked by uid 990); 13 May 2025 19:15:26 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 13 May 2025 21:15:26 +0200
MIME-Version: 1.0
Date: Tue, 13 May 2025 19:15:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <2de62b27ba2bcaea3e5d70295dd231b487d6abdb@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [PATCH v4 21/23] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Julian Ganz" <neither@nut.email>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre 
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <4f7641d5b610d806e493fed4659a73bfb8a60c0d@nut.email>
References: <cover.1746968215.git.neither@nut.email>
 <e212e53b98c264366458654493e2fa2e2cdecdcc.1746968215.git.neither@nut.email>
 <53632928-0367-44cf-a93e-6ba14bb85458@linaro.org>
 <4f7641d5b610d806e493fed4659a73bfb8a60c0d@nut.email>
X-Rspamd-Bar: --
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.103122)
 MIME_GOOD(-0.1)
X-Rspamd-Score: -2.703122
Received-SPF: pass client-ip=185.26.156.114;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

May 13, 2025 at 9:45 AM, Julian Ganz wrote:
> May 13, 2025 at 2:25 AM, Pierrick Bouvier wrote:
> > [...]
> >  + if (trace_all_insns) {
> >  + g_autoptr(GString) report =3D g_string_new(NULL);
> >  + g_string_append_printf(report, "Exec insn at %"PRIx64" on VCPU %d\=
n",
> >  + insn->addr, vcpu_index);
> >  + qemu_plugin_outs(report->str);
> >  + }
> >  +}
> >  +
> >  +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_t=
b *tb)
> >  +{
> >  + size_t i;
> >  + size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> >  + struct insn_data *udata =3D calloc(n_insns, sizeof(struct insn_dat=
a));
> >  +
> >=20=20
>=20>  With this, for every TB translated, we'll perform an allocation, a=
nd then lose track of the pointer. It's usually a pain to pass this kind =
of "dynamic" information through udata.
> >=20=20
>=20>  A more elegant solution is to perform a QEMU_PLUGIN_INLINE_STORE_U=
64 to store this information under a new cpu_state.current_insn field dir=
ectly.
> >  Callbacks are installed in the order you register them, so by storin=
g information inline *before* the insn_exec callback, it will work as exp=
ected, as cpu_static.current_insn will be already updated.
> >  You can find some other plugins which use this trick.
> >=20
>=20Mh... Thanks for the hint. I'll have a closer look later.
>=20
>=20I also wonder whether this could also be useful for solving the issue=
 we
> run into with virtual memory: TBs being reused in a context different
> from the one may have a different addresses. That's why we introduced
> the compare-addr-bits argument.

Never mind, I had a look at what the API allows for. Your apporach looks
reasonable. I'll implement it the way you suggested.

Regards,
Julian

