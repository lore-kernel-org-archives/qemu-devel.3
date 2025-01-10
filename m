Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB13E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDWf-0005Hk-7Y; Fri, 10 Jan 2025 06:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDWd-0005Fc-57
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:50:03 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDWb-0007zy-BM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:50:02 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id A5A95181540
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:49:57 +0100 (CET)
Received: (qmail 14393 invoked by uid 990); 10 Jan 2025 11:49:57 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 10 Jan 2025 12:49:57 +0100
MIME-Version: 1.0
Date: Fri, 10 Jan 2025 11:49:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <957c8754b588a3355e18519d644d9bb05d58645f@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Alexandre Iooss" <erdnaxe@crans.org>, "Mahmoud 
 Mandour" <ma.mandourr@gmail.com>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>
In-Reply-To: <87frls6q2m.fsf@draig.linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <87frls6q2m.fsf@draig.linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999987) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.599987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=t3gQiKnyuQ26oxxAyZIOmhFyiB45Wr8ydPViSQl+b10=;
 b=dOasg2UNYrMYd1WtthJHENQlOWfWvRGk4OmjPmj26LJ+GtfTMxvOJzSMSf6+JO3YTveCzhKNOM
 chVswIxVik76eSstvwfcjBkX8lYDBxYve0oRlSHyeBTYNdwnTe62E5GegrvIOhrmMAPsy1sqa+TK
 2kdCS+Ui8fWC4soIz1eDAcJLn22O8i1MQaUP9/jyA69R0cGMrEvCWu/xx5dPnx+wv7YKMwyhqRX6
 763E02NN8RynCqYmOuLu/72CP3XuvegHWvtpYfG/ZkS265y2E4MBajX0+sGFU8W7t/a0dkSyozFz
 Rjstdqb+zkvpBBZKHnNUgDG+eT/+sSwGDwIUOMqw1TZfaNnC2BW6LuPL5N28/ncpRYI8JYq0onO5
 E1lVkC2UPnqFGKXya2zIKkE93LTZwEoJsYK03dcyMbZeq+S3p7Jv1FY0+ZTuoj6xmgRx8tvsPV9G
 omkBv3U7iikWOwpFwo6bjAYLLEJNo7h2OH02rKXfxTTPo9gRr5+Vgs5kNJoHY6uCziUO0bcBz29T
 JGd4fQNapssLzTZCI+/s6g1mcl14SHswieRz4mJpBzTTSA41ejW7VSUwjz1gf1roa3v2VSubDkMJ
 cLbdTZgkgbvYkgWLSL7AW0/LFPd2/TRwPax/tXQlBlwVpgzn4zxirYkjSsuvSOS2dQRFmThfPBmy
 w=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

January 9, 2025 at 3:04 PM, "Alex Benn=C3=A9e" wrote:
> Julian Ganz <neither@nut.email> writes:
> > We recently introduced new plugin API for registration of discontinui=
ty
> >  related callbacks. This change introduces a minimal plugin showcasin=
g
> >  the new API. It simply counts the occurances of interrupts, exceptio=
ns
> >  and host calls per CPU and reports the counts when exitting.
> >  ---
> >  contrib/plugins/meson.build | 3 +-
> >  contrib/plugins/traps.c | 96 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+), 1 deletion(-)
> >  create mode 100644 contrib/plugins/traps.c
> >=20
>=20>  diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.b=
uild
> >  index 63a32c2b4f..9a3015e1c1 100644
> >  --- a/contrib/plugins/meson.build
> >  +++ b/contrib/plugins/meson.build
> >  @@ -1,5 +1,6 @@
> >  contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'h=
otblocks',
> >  - 'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
> >  + 'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
> >  + 'traps']
> >=20
>=20I wonder if this is better in tests/tcg/plugins? We need to do someth=
ing
> to ensure it gets covered by CI although we might want to be smarter
> about running it together with a test binary that will actually pick up
> something.

The callback is intended as an example. The patch-series does contain a
dedicated testing plugin. And iirc the contrib plugins are now built
with the rest of qemu anyway?

> > +QEMU_PLUGIN_EXPORT
> >  +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *inf=
o,
> >  + int argc, char **argv)
> >  +{
> >  + if (!info->system_emulation) {
> >  + fputs("trap plugin can only be used in system emulation mode.\n",
> >  + stderr);
> >  + return -1;
> >  + }
> >  +
> >  + max_vcpus =3D info->system.max_vcpus;
> >  + traps =3D qemu_plugin_scoreboard_new(sizeof(TrapCounters));
> >  + qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> >  + qemu_plugin_vcpu_for_each(id, vcpu_init);
> >=20
>=20Hmm at first glances this seems redundant - however I guess this is
> covering the use case you load the plugin after the system is up and
> running.

Yep, but really that was just me being paranoid.

> I wonder if you have unearthed a foot-gun in the API that is easy to
> fall into? Maybe we should expand qemu_plugin_register_vcpu_init_cb to
> call the call back immediately for existing vcpus?

Would probably not hurt.

Regards,
Julian

