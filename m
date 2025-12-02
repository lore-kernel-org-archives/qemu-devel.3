Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714BCD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 15:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSU7-0006Qu-0G; Tue, 02 Dec 2025 10:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQSU1-0006Pc-PL
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 10:40:07 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQSU0-0006gx-4b
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 10:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=w9e8SrckWJ5ye1v5ZLPUDemAk1WzOrh3dExIt+YNI9Q=; b=PQdlVaWMTvG2sTaqoCfaB2IYd7
 dAfguWuRWzbVzqn0Y05Wp/CxBLTWNrxVIQkh3OKyZcVk+7N+C31ynRebxiCDMoH7TFw0rOjOJeXNW
 lGT+iCzLZPBo17OSiu0BOOqstpPs6w2ZOll33E9D7/Nk/oLgio/cEjevtcH5JByloA2cxbmamb00n
 Ucf1soJt7W8bCFEOSnm3yUkj5NwemVqvKAEPpLpjIdwhpTdaQbJ3HYK9d23fj0qgYJDeEZALKo/Xd
 YVi5HwTYguoe294dyPdBb3jEzs+AqqN2lV2Djmp7+44dW+OWdzXWFZvDCoQ+nmVc54QHUnGuyhar2
 STDty95GygkDV7SjiMIG5qu0NLUfXm2fNZj6CYz+410J87l+FDt0RDz+Gt4Yorwm1vj8kH5UpRFSw
 7oOmnYIleqSPkS4CubEi+WTQXgvmzJkn3hzR++jSE1YhfEmB30f0pJnwU3pVhWBZWk0ixksgI4LzX
 b8Qj6CTAXC3bzJT+emNV27B6GeCz9Q7slfZsmZcjd3/2mBHoNUymckodOmGc07cEyOAqlRt8P/N4t
 XXhWVM7oegxEubLbZqus61DQTTTcCFcBz0A3lUWe0NXrNMp4yPtzcjHsn3PglBENLTTQNeufloucw
 paoyNM91AbpgCtu2o7mtdPFBqEw28KpGyChVn5SsY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Ratchov <alex@caoua.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, dirty.ice.hu@gmail.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 Volker =?UTF-8?B?UsO8bWVsaW4=?= <vr_qemu@t-online.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
Date: Tue, 02 Dec 2025 16:39:44 +0100
Message-ID: <47697442.fMDQidcC6G@weasel>
In-Reply-To: <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <12d3c2d298399c0935edee8caa3e52aa@hostfission.com>
 <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 2 December 2025 15:14:48 CET Marc-Andr=C3=A9 Lureau wrote:
> On Tue, Dec 2, 2025 at 5:26=E2=80=AFPM Geoffrey McRae <geoff@hostfission.=
com> wrote:
> > On 2025-12-02 23:44, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi Geoffrey
> > >=20
> > > On Tue, Dec 2, 2025 at 4:31=E2=80=AFPM Geoffrey McRae
> > >=20
> > > <geoff@hostfission.com> wrote:
> > >> The PipeWire and PulseAudio backends are used by a large number of
> > >> users
> > >> in the VFIO community. Removing these would be an enormous determent
> > >> to
> > >> QEMU.
> > >=20
> > > They come with GStreamer pulse/pipe elements.
> >=20
> > Yes, but through another layer of abstraction/complexity with no real
> > benefit.
>=20
> The benefit is that QEMU would not have to maintain 10 backends and
> all the audio mixing/resampling. The QEMU code would be simpler and
> more maintainable overall. GStreamer has a clear pipeline design,
> better suited (optimized code etc) and you can easily modify the
> pipeline settings.

Nobody questions that it could reduce QEMU code. But it would move complexi=
ty=20
to users by forcing them to add another layer. Many sound systems allow to =
be=20
layered on top of other sound systems for a long time. But even only one=20
additional layer can make it very challenging to find out why you end up wi=
th=20
a certain undesired setup like unexpected sample rate or bit depth (wrong U=
SB=20
profile chosen of external audio device during USB enumeration? some defaul=
t=20
plugin or mixer element of a layer doing resampling?), high latency=20
(additional buffers with higher size on some layer? where and why?) or even=
=20
xruns.

/Christian



