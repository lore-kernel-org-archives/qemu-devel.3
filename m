Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50ADC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 07:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEkM8-0004VZ-AL; Tue, 13 May 2025 03:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uEkM3-0004VF-Nw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:47:11 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uEkM1-0001No-Ij
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:47:11 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 19BCB17F797
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 09:45:06 +0200 (CEST)
Received: (qmail 26642 invoked by uid 990); 13 May 2025 07:45:05 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 13 May 2025 09:45:04 +0200
MIME-Version: 1.0
Date: Tue, 13 May 2025 07:45:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <4f7641d5b610d806e493fed4659a73bfb8a60c0d@nut.email>
TLS-Required: No
Subject: Re: [PATCH v4 21/23] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <53632928-0367-44cf-a93e-6ba14bb85458@linaro.org>
References: <cover.1746968215.git.neither@nut.email>
 <e212e53b98c264366458654493e2fa2e2cdecdcc.1746968215.git.neither@nut.email>
 <53632928-0367-44cf-a93e-6ba14bb85458@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.070084) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.329915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=j1eYROEoR32wiu1fORa9wVL0vuTKSVKAV32SnXZCaQU=;
 b=hdDrDu3oqi/lZli2cgE/XUqEIQ9Cs3572CkcQMBs7IAPkVtq7ddHyCJSvSqhMAwo2pLh0Z+1W3
 krU9PSH3P1Z4uwDtw4U3BxxVjiFZzKmu3qBlRpY0xaln4OeCwlFlUSvETsGeamzucgBie/0ld303
 3MRc1dF5KIapYjG7YmVWB2JAOLt9ABmcskyOa8hBhlyL57l2Gsw8aJORgznjXEDaFJMG2Py4snP1
 5NXjjc7KYBxIm08B+uqhM2+HJhIY8W1VOx4SseYATxPFF34j5Gj+AEDuR0rIyAOPRm2Fkre39f9u
 0YkgO6WrYBC4GtM5t20qbVOoeoJ+FYuqpKkRlZZXbPkvloB6ZfbT48575zZH7BwqLSbmUFPkkrNt
 8vJDz6QgwnwCCfBcBJzOfiYaZ1qY33lCkkZf+KOKLr7G8bGub7wyYHH9Tz4JKfPmPBdtQivnlECz
 6dRFs3KwmJJgErYD0NqNkZ+Aq4Vf5okZ6rZpwjLgoqrZt7cROhQ+b5zWhUNdJCZ4MmdIJgtBkL3q
 0URzTprrhDAcVxFqIQZAJufkXUfCnzXvx/GvDO/Q4Ql2lhAMGLlNE8A1Wa7EVdKex4g7KZ7ysQhq
 ACqD53giysX+9Asfc4ocPCAL2ibaJagwd2pkda4jyw0uNTQyUSqpXtj50/YrT9IJipkFJ1rJ5xRZ
 o=
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

Hi Pierrick,

May 13, 2025 at 2:25 AM, Pierrick Bouvier wrote:
> On 5/11/25 6:14 AM, Julian Ganz wrote:
> > +static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index=
,
> >  + enum qemu_plugin_discon_type type, uint64_t from_pc,
> >  + uint64_t to_pc)
> >  +{
> >  + struct cpu_state *state =3D qemu_plugin_scoreboard_find(states, vc=
pu_index);
> >  +
> >  + switch (type) {
> >  + case QEMU_PLUGIN_DISCON_EXCEPTION:
> >  + /*
> >  + * For some types of exceptions, insn_exec will be called for the
> >  + * instruction that caused the exception.
> >  + */
> >  + if (addr_eq(state->last_pc, from_pc)) {
> >  + break;
> >  + }
> >  + __attribute__((fallthrough));
> >=20
>=20It's a bit hard to follow the codepath with the switch and the fallth=
rough. Maybe we can simply use an empty if for that.


I was likely thinking about other types of discontinuities we may add in
the future. But yes, it's probably not worth thinking about that now.

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
> >=20
>=20With this, for every TB translated, we'll perform an allocation, and =
then lose track of the pointer. It's usually a pain to pass this kind of =
"dynamic" information through udata.
>=20
>=20A more elegant solution is to perform a QEMU_PLUGIN_INLINE_STORE_U64 =
to store this information under a new cpu_state.current_insn field direct=
ly.
> Callbacks are installed in the order you register them, so by storing i=
nformation inline *before* the insn_exec callback, it will work as expect=
ed, as cpu_static.current_insn will be already updated.
> You can find some other plugins which use this trick.

Mh... Thanks for the hint. I'll have a closer look later.

I also wonder whether this could also be useful for solving the issue we
run into with virtual memory: TBs being reused in a context different
from the one may have a different addresses. That's why we introduced
the compare-addr-bits argument.

Regards,
Julian

