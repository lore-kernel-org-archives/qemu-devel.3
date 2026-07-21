Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A3DC44533
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5z3-0000Hs-Di; Tue, 21 Jul 2026 04:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wm5z2-0000HV-0Z; Tue, 21 Jul 2026 04:37:48 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wm5z0-0004DJ-MI; Tue, 21 Jul 2026 04:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xsiuMtkyvpeTAe9qRj+jiYyJl+i3WSpIPBOaH7CGOv0=; b=iFDyzzP7066gXj9h+Jgg/UenSL
 dVweXKjd0q6HclwRHAKA7c1Fnizh1PzEMdjwep+hbepA1iaG4V2kK++GJHpx6ea6Xl+YTrcMvHQQd
 jCMjt1FduAKdGZKVY48ceRaiPmbeIyZj8+ArG7gzzLUQjYGNhSamPs2WwPO96HkkjOyg0BKTNHFVZ
 zqWLpQT3og38tuJU+fKemXApIURQFoJamtJlNJzJbhCWG03OFlOxynNaH/kQHsPXhIDHT7n5XKAhU
 NW9LDijJq65qXg4etCs3ydNCoXLCejryjDtAg/xHLadW35eBoUACq7qbPpFQfSjDKAXx7PLS/+KGG
 gZ7l62z/G3SDHMubq3hDSfqMxgWxb+syS7dcyfdCXkhc9u16TBWA134cO9AKdZ6WQBDfF2BMPhiK+
 uYpjghSO7TRmhuuVpPtMXIlosrlm8EHQiYNp2TGwgkVdTycEAzhcXWpMQEtus6C1v1f17YULnKWoB
 2ePc0MtTp+kFjj/jU5RxO6aJ1Wo11zmCpoODi8p1gNO3Z6NLri4OxYCmOwaC22zmE0vCopEhcMnJq
 L9FJ8fI37pRBY099WWj+FV/b//3DPq6Cs5zcl0Q9m7aXB+amJxm4ZQKNdKrmKsODpn7Sgn0eh2uUu
 6+prLeedqUAmk3guL221Y6L+C+WuseLVFQjlhlpqI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
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
Date: Tue, 21 Jul 2026 10:37:39 +0200
Message-ID: <6287083.lOV4Wx5bFT@weasel>
In-Reply-To: <af19f823-234c-462d-8c52-4d8cf4b93c4c@oss.qualcomm.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <CAMxuvaySONs4r=1Bmsao1f1cZdviGGwPVM8+1Q+1vdY0X-pYVw@mail.gmail.com>
 <af19f823-234c-462d-8c52-4d8cf4b93c4c@oss.qualcomm.com>
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

On Tuesday, 21 July 2026 10:25:34 CEST Philippe Mathieu-Daud=C3=A9 wrote:
> On 21/7/26 10:06, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Hi
> >=20
> > On Tue, Jul 21, 2026 at 11:58=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> >=20
> > <marcandre.lureau@redhat.com> wrote:
[...]
> >> most of them are "return-type co_annotation fn(..)"
> >> we even have scripts/block-coroutine-wrapper.py that relies and
> >> produce this order..
> >> a bit late to change the style imho...
> >>=20
> >> At least, let's not make this a requirement for this series, please
>=20
> Not a requirement on my side, but if we had to pick a style,
> I'd vote for "attribute before return type".

Yep, because that's a) the most compiler-friendly option (all compilers all=
ow=20
it, including MSC) and b) it's the most diff-noise friendly solution (can b=
e=20
prepended on its own line without touching any of the existing line(s) at=20
all).

/Christian




