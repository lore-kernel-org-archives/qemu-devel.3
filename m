Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC519CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9yx-0007PE-OC; Wed, 27 May 2026 04:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1wS9yq-0007Om-2S
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:51:13 -0400
Received: from flow-a2-smtp.messagingengine.com ([103.168.172.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1wS9yn-0000ba-U4
 for qemu-devel@nongnu.org; Wed, 27 May 2026 04:51:11 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 5999913802E6;
 Wed, 27 May 2026 04:38:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 04:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1779871131; x=1779878331; bh=ZtNZmtiIIS
 +/5uqlnIxpDzlIEiTdqZ1oGuuwWO812Rk=; b=DLFepVlVEUU3mTXOYqKl4t2kKG
 Gzyh4GNheQPYIYcov8y7HmD8cT/rfGzx8J5T3qXjJ+S0PXtojhC/QcfwrhXCvNlk
 PxOBw8GHUcghGz/8IFxUYOpXkvEoKKMObOM/Z9cf7V0jiOUAdYZosKUyG9exzI0V
 mtX8cdloP92OZyvOQKPFxeEY3iUlBw4dblrC5kkePW1fD9MlQZ94oGDUJjcM/+TK
 61e68hTdKWt66rXawGt77Y4ODLjiICirBTIm6PcOnoxm3YNb5XQHeuWXOr6SwvBl
 75AZsRqcPAw526y+TcQew9YBrdXe99BICPsYWoQcjwdvhoOsSiIIwHg9RmcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779871131; x=1779878331; bh=ZtNZmtiIIS+/5uqlnIxpDzlIEiTdqZ1oGuu
 wWO812Rk=; b=ktocf3k3wPd1cP2DFPw7SyoA4xABdJq3v5rDRstugcynWH+42Ui
 AllWe9cdCDVZU8Wy0606rfUKTtdvR38ZkeyqvJxnhlytAPuKkMco6oin+zYOYBb2
 xgGqRFzuGGwBHwvlmhRchqMuucqdPi6PAzqrjQ5E7f4RIKnD6wqkvei1DZavigaO
 5+EJ0vIj/AibYYgXo9d2PsjpQeElATddHdb5mv5qJ924rYz+EJu1jTB4BpvNpL7y
 XGECWnx2EjyjNfg26Ud2wUEvyJzlbokAcjBkNvBqxi7UtI8CTd6OUE/gVYlxJF4r
 eyAKwDb0nvBm5ciCqhpOBTZVwp+AONPXgDA==
X-ME-Sender: <xms:m60WaiPRUBz1Go4pN-YL4TmA4m1dLudyQluJ2d9DpfS4dBjM4gyVXw>
 <xme:m60WaspNNd0O4l7deVDFUR5MYw4TONpAEzyaheYnGlNBY8qRT8ArA8Z2ByC1BnGzv
 lVmPHivu3hwrwjJmBXNNyolE4ADWV22zRqT0Zm5YqUl3Zio70YRvQ>
X-ME-Received: <xmr:m60Waj_0FZLeVDSDNwI4oDLrGFfbbdFr2NZjbGviIFxD3asXjpAZDVbfAaA32ZiU7vOyHtUJ5fyqoGdDUJV4MtELnwFBG0Cd07e8IA>
X-ME-Proxy-Cause: dmFkZTGAC8yCyMBMPFep+txMvQfFEKOjea1ZMmQG3rz4yqKsMRKTshV8R29jcoIG+ngcD7
 AsWN9B4qYRlZDues5y2lR/P20wyJKoYvAO+r/KIWC5W5u/5rYUbrRzc6yuPmSLJI6/FqWn
 VkOsKBhM+XFy5hu77LiX4dTq4tfcmaBkX5XIhEL7qfb/Gsp8wumodT0trqM/V/InqjhUpy
 mFBRiWVvoKVtB9t0dLEqLOYbF4/Z+1UquPfguqusSOzvR8/bfird+srmoevnlFmE/T2n/q
 sF4IkyoRPummlNNApa9neloOdt9HpARJ/z6/e7UGtyWyL2XtPeT9TnrIPHpRUyCubG2CGN
 5yQPXAcQUPlgv2TUcYDjBu3Gk1BZYkFolUjMietVWwDYfasRZuryHh1IgMnNXLM+oWdkXy
 o/Me0aO0LBgWC5g4WjtiHmsDvhuSOR7gPKUF1sRf7eNXhEiBRMdD1F9d3M1vrD+mE+Vodu
 7xjdIYgRQM03JQ8bCD3eYXmX3ijTzaHYABs5dqvggyjQSzMQO5OTiwUZBaJ58CBAviJ1RZ
 hPuTVlyf7JEn4A4QohjgryOIMok/W/4Bo3ZkdzUOZZZRD78pvXs5VQ7b9byc5+h945FwIn
 913X51IaFRye6Bx2FvGHdw1+pa6k4jXZ6go+SS521WlxeWA4roxpwe9RiH4Q
X-ME-Proxy: <xmx:m60WajrgB4f4-veWBgN6zroxQfHsGT3aXdc_-xlZ7kcn9I9P2nAn5g>
 <xmx:m60WapjUA9y5KDAjSHB-Clnw-3CHw2s8-wycDrFTuzV3anFCyfo-eg>
 <xmx:m60WapAlnlz0nlDhnWhl8cbzki2v2WipmKGtuNT7G2Z34pFqd9jqWg>
 <xmx:m60WavuwndRLYzkWLUU6gKhjGY1muy3UHqsOZAsYzGlsHF8uyRFyIA>
 <xmx:m60Waqhi8VZ-n6t8Hc0QndufDlPL4be812rcjsbIcHCxmlZDE0E_pCUk>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 04:38:50 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 419FC8198F13; Wed, 27 May 2026 10:20:16 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Albert Esteve
 <aesteve@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Eric
 Blake <eblake@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, Auger Eric <eric.auger@redhat.com>,
 felipe@nutanix.com, Jan Kiszka <jan.kiszka@web.de>, Joao Martins
 <joao.m.martins@oracle.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Subject: vhost-user(?) breaking changes
In-Reply-To: <878q961nkz.fsf@draig.linaro.org>
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
 <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
 <878q961nkz.fsf@draig.linaro.org>
Date: Wed, 27 May 2026 10:20:09 +0200
Message-ID: <87mrxlgt6u.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.137; envelope-from=hi@alyssa.is;
 helo=flow-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[Trimming CC substantially.]

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> On Mon, May 25, 2026 at 5:03=E2=80=AFAM Demi Marie Obenour
>> <demiobenour@gmail.com> wrote:
>>>
>>> The first is whether vhost-user memory regions
>>> are guaranteed to not overlap.  I sent a patch in
>>> https://lore.kernel.org/qemu-devel/20260522-vhost-user-dev-v1-1-b31646c=
f19b8@gmail.com
>>> to guarantee this is not the case.  However, this is technically a
>>> breaking spec change.  The virtio vhost-user device I'm working on
>>> requires this.
>
> Breaking spec changes are always a red flag because of whats already
> deployed. Are you sure there is no way to make changes optional with use
> of feature flags?

There's some nuance between breaking changes and clarifications though,
right?  e.g. 97f24a0496 ("vhost-user.rst: clarify when FDs can be sent")
tightened things up, so could also have been in principle have been seen
as a breaking change, but not practically.

Are there likely to be devices that use overlapping memory regions
today?  Would we expect that to work?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCahapOQAKCRBbRZGEIw/w
om1VAQDMZQB4dyZ5RIn9gjXaSvs5LU8v5JG4AhLkvighhzm09wD9HlNL7heSkkp1
QwckcP0XI70EoJ2VXJhhRwJdGMV5TgA=
=YR7B
-----END PGP SIGNATURE-----
--=-=-=--

