Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0889DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBTW-0001QA-4r; Thu, 05 Dec 2024 08:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBT7-0001MY-Ob
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:00:50 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBT4-0001gp-A3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:00:33 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 7E4431803B2
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 14:00:25 +0100 (CET)
Received: (qmail 4235 invoked by uid 990); 5 Dec 2024 13:00:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 14:00:20 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 13:00:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <c30dd97f956725875d9454685692ce3a91155646@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <76cbce17-0318-436c-b295-0a8ef12b24b9@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <76cbce17-0318-436c-b295-0a8ef12b24b9@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-1.153755) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.246244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=c7YH6JQimKzP45LJgyBfrhYBchPiTUEtqG3riN9Yqfc=;
 b=EsAje3iv5AR9dPTfZ8m/TxpasJvHysDoQRwGp6kP0hNfAvpzGXquN3lY5aOX5HL5seDQM+1lz5
 7C1dt5dk/4OeLgFQVPKmFc1DJ7xE4suVhGLSrKN2F8ygpPl1jnUuohHpusMKt1DuDgww5THqcx/B
 D9qX/y14+Do6JjIaIq2627NcABP3/7J4JkYdUZVgPFEpfmF4apvnm4w7EB4Y2ipfN2hhOOQWGW5I
 rfKdkcTdHm5IuyEto2p+45jPKRwU+3O5gsdW6BIvRVQzgy8gbI++0QM12Z1W7NqMc0qDIlwpfadc
 SMJHFABbA0ReO2iyPVJnp45snmKYESTwN8TH43idM+IjK1n7vYxn56ctuubpYMMWKykOhecqrgTe
 ixonJR8ANP4YMo3EgNWZ/cm3NYmhiQVNUweBLQUuF6KqBv5QOfGUOa/0xMCkbk4HNAQ4WI3ZpsPw
 Nlib7ymsQgjAQw75ja8vt4lvb0R7aaAGdqNCh++Fl2iiin+K762xsw52EINqHu9qACF/yZ7AmgWR
 RIWsjsLD4+CRfucy50YnpaQSFNrnW4aGDX1EbOn4q+B/mFuRpOaekpxVSZkxoYHCfmqJH6yYRqeX
 qdiyqbOTAuwtxwasdJE6eOaxkf+7RB+Zbn2azPRNYMyuQ1xsO7oe5jgqM8QMIRfENemD/mjutyuU
 8=
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

Hi Pierrick,

December 5, 2024 at 12:14 AM, "Pierrick Bouvier" wrote:
> On 12/2/24 11:26, Julian Ganz wrote:
> >  +typedef struct {
> >  + uint64_t interrupts;
> >  + uint64_t exceptions;
> >  + uint64_t hostcalls;
> >  + bool active;
> >=20
>=20The active field can be removed, as you can query qemu_plugin_num_vcp=
us() to know (dynamically) how many vcpus were created.

Yes, if the ids of dynamically initialized VCPUs are contiguous. I
wasn't sure they really are. And I distinctly remember we originally
used some query function and ended up with the maximum number of VCPUs
supported rather then those actually used. But that may have been
another function, or some unfortunate result of me being too cautious
and doing

| qemu_plugin_vcpu_for_each(id, vcpu_init);

in qemu_plugin_install.

> >=20
>=20> + break;
> >  + }
> >  +}
> >  +
> >  +static void plugin_exit(qemu_plugin_id_t id, void *p)
> >  +{
> >  + g_autoptr(GString) report;
> >  + report =3D g_string_new("VCPU, interrupts, exceptions, hostcalls\n=
");
> >  + int vcpu;
> >  +
> >  + for (vcpu =3D 0; vcpu < max_vcpus; vcpu++) {
> >=20
>=20vcpu < qemu_plugin_num_vcpus()

Yes, max_vcpus was introduced as an optimization. If we can rely on all
VCPUs with id < qemu_plugin_num_vcpus() having been active at some point
this becomes unnecessary.

> >  + qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_TRAPS,
> >  + vcpu_discon);
> >  +
> >=20
>=20The change from QEMU_PLUGIN_DISCON_TRAPS to QEMU_PLUGIN_DISCON_ALL sh=
ould be included in this patch, instead of next one.

Ah, thanks for pointing that out. I likely fumbled this at some point whe=
n rebasing.

Regards,
Julian Ganz

