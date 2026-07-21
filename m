Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD24C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bn-0005N6-Mb; Tue, 21 Jul 2026 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wm6Bm-0005MP-By; Tue, 21 Jul 2026 04:50:58 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wm6Bk-0005fo-P0; Tue, 21 Jul 2026 04:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=RjimWnqmHsNVDASdqxBR6CDlPbi3iLgTQoVIt7skhHg=; b=PM8Q9kJ50RgUnZhenHWgJSroUh
 9d24X9ALnyODosKeawNs8M6RHGbxAkDzATbRverUFQYS7kN5i0/YEvE7riyVXuhByoCzNpmR2F+uf
 RjnvN2dr9hCERsctmaCk4YtCDhRDCobIHQfCt5IbJinWlRblSfkbdP3vauJxybxrdkmb6BjPVIPq6
 Y3dPvXSo7YoNHggKhg11q2VbfDI9nX6GlxuRl+bgvsiQUUrwdU3QZoHKceWE0OR4wmg24OQJR978y
 H0S1KbsDzUINWYfyXe/JdwBDJMagAgsKONq5NzYXK0/aVx7upfaugcoPIf8Uy88cgbHTM+siOVFOB
 CQoQVBOus418Sta3g+c3LtDvyboclxS4nxR9s83FADKEzoE8YO4Peb1ik/A5uAYEBG9k48HtTll+y
 I7efPhu8rU2PqqX9+d/Lj3tFEiFi16IwD4rtbLFlNYcYmuSlU8+WcYZYwjrABF8TXV9e5z8PPn24j
 YiAPBd9MMgTtNpu7Z5QJpDxVIzKMXr9aKP+uRba+rXGYbLjRCgYBhVw+e34/gTOojL18GhiVtAMvO
 N8sxa+8/F4xJFqIXONy2UmIkCJXBEXmyYYZMm42MOGhPVHe7fPP98RKEyezazCKeQkAY5MGwp2jtC
 kr/Rte0ErDQ9ZiJx75A3aVMCCKhmjgoeHiozfK7UQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
Date: Tue, 21 Jul 2026 10:50:49 +0200
Message-ID: <1962171.tdWV9SEqCh@weasel>
In-Reply-To: <CAMxuvay01r=EchTO=PocqPtdtZtxcJs+AJZExRA8rBao31mH7w@mail.gmail.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <6287083.lOV4Wx5bFT@weasel>
 <CAMxuvay01r=EchTO=PocqPtdtZtxcJs+AJZExRA8rBao31mH7w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Tuesday, 21 July 2026 10:39:52 CEST Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jul 21, 2026 at 12:38=E2=80=AFPM Christian Schoenebeck
>=20
> <qemu_oss@crudebyte.com> wrote:
> > On Tuesday, 21 July 2026 10:25:34 CEST Philippe Mathieu-Daud=C3=A9 wrot=
e:
> > > On 21/7/26 10:06, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > > > Hi
> > > >=20
> > > > On Tue, Jul 21, 2026 at 11:58=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> >=20
> > > > <marcandre.lureau@redhat.com> wrote:
> > [...]
> >=20
> > > >> most of them are "return-type co_annotation fn(..)"
> > > >> we even have scripts/block-coroutine-wrapper.py that relies and
> > > >> produce this order..
> > > >> a bit late to change the style imho...
> > > >>=20
> > > >> At least, let's not make this a requirement for this series, please
> > >=20
> > > Not a requirement on my side, but if we had to pick a style,
> > > I'd vote for "attribute before return type".
> >=20
> > Yep, because that's a) the most compiler-friendly option (all compilers
> > allow it, including MSC) and b) it's the most diff-noise friendly
> > solution (can be prepended on its own line without touching any of the
> > existing line(s) at all).
>=20
> ok, what should I do? Send a preliminary patch to fix all annotation
> positions? or just change the position in this patch or series?

Your decision. I'm just giving my 2cts. As this is not a behaviour change, =
it=20
is way below my threshold level for taking any strong position. If you can=
=20
make this for this patch for now, that would nice, but if not, not a deal=20
breaker either:

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>



