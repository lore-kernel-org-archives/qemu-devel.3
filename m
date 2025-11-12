Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8425ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 12:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJAR9-0000fR-JT; Wed, 12 Nov 2025 07:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vJA0q-0001IP-L6
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:32:10 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vJA0n-0006Ew-1M
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=C64E2AeNc/MA8cIoR5P2g27BOg0VGvriHynndK/LiaI=; b=XmwEaF7LxruExw9l5yMWW7Adc8
 s0PmaitP8E56qLEA7r/4C78Dr0C2fZlilfBR+UKwUu+b25JYVc+gvUCL+XacMxAmWvEmdyOjWNuCv
 PaKhsuRGMQoOlHZ7hs5y2ydOOucdKSZ+V+TGmxdDDy+8iR0FdH0/F0yFYMTQRe7tfftb6uLEjfnkn
 nXhH7Z32pvYnNnlD+BBSa8N8sxV7PGzYQZSFsZW1xUi+1VHNYcbx5e4+LNTIXg02gFNsv4WLUg/w3
 5WyzV1wAJCdFZPHYurIv/C8ia73J+3TXFAE0uHGJ4dUbPlAqx04ukxsrDk98K/dsv8+LgVmrcYIkH
 0XUpcXyAZefualFbDS0AFTtnwQI9N73B4c57eDbjkHJGDsPs4VEPxe8eA+e3uNbarLAlwNecmk5LO
 gj9TUKOOVI0LwLIMNrJqzpxdOPZwy/ibuTSCt6pAVSlm89o3kKbIAf0zhdK8rcqAF7HiO4Q+P06fr
 SS/+6YCmCb7oG7xWqjMQ8SJhz1HzOO8NqO/N6fFfHNjByIYiu/kDyOe9JSafwuMyI1TltTOH4v4mm
 J+xhFbcm22MLDb8KGiG2zBwN826ZAiLqHTR8RYYtI6gH6sKhBSghzsoZnlHd2s5fBLPw4iZqOKMWs
 a9OmCD665fUetVdRSxJnesWecAlQ/YPnrs0zTIvW8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 groug@kaod.org
Cc: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/9pfs: Drop unused print_sg helper
Date: Wed, 12 Nov 2025 13:30:56 +0100
Message-ID: <3260517.0rzgI7jUu0@silver>
In-Reply-To: <dfbdc47a-6e70-44d6-8e87-eddf5363ff77@linaro.org>
References: <20251110155424.694664-1-osama.abdelkader@gmail.com>
 <dfbdc47a-6e70-44d6-8e87-eddf5363ff77@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

On Wednesday, November 12, 2025 8:03:28 AM CET Philippe Mathieu-Daud=E9 wro=
te:
> Hi Osama,
>=20
> On 10/11/25 16:54, Osama Abdelkader wrote:
> > Remove the print_sg() debug helper and its always-disabled call sites
> > in v9fs_read() and v9fs_write(). The function was only reachable via
> > if (0) blocks, so it has been dead code for a long time.
> >=20
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---

TBH low care level for this on my side. It's just passive debug code and th=
e=20
suggested change does not change anything on the resulting binary.

It's not that this debug code is not used at all, but very seldom. Last tim=
e I=20
personally used it was like 3 years ago.

> >=20
> >   hw/9pfs/9p.c | 20 --------------------
> >   1 file changed, 20 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index bc4a016ee3..a8de894f4c 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1389,20 +1389,6 @@ static int stat_to_v9stat_dotl(V9fsPDU *pdu, con=
st
> > struct stat *stbuf,>=20
> >       return stat_to_qid(pdu, stbuf, &v9lstat->qid);
> >  =20
> >   }
> >=20
> > -static void print_sg(struct iovec *sg, int cnt)
> > -{
> > -    int i;
> > -
> > -    printf("sg[%d]: {", cnt);
> > -    for (i =3D 0; i < cnt; i++) {
> > -        if (i) {
> > -            printf(", ");
> > -        }
> > -        printf("(%p, %zd)", sg[i].iov_base, sg[i].iov_len);
> > -    }
> > -    printf("}\n");
> > -}
> > -
> >=20
> >   /* Will call this only for path name based fid */
> >   static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
> >   {
> >=20
> > @@ -2468,9 +2454,6 @@ static void coroutine_fn v9fs_read(void *opaque)
> >=20
> >           do {
> >          =20
> >               qemu_iovec_reset(&qiov);
> >               qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.siz=
e -
> >               count);
> >=20
> > -            if (0) {
> > -                print_sg(qiov.iov, qiov.niov);
>=20
> Alternatively, consider converting to trace event so we can keep
> dumping the entries, but select that at runtime (see for conversion
> example commit 4847c5701a3 "hw/rtc/mc146818rtc: Convert CMOS_DPRINTF
> into trace events").

Probably overkill. We have a bunch of trace events where it makes, especial=
ly=20
for investigating issues on 9p protocol level. But this debug code is usual=
ly=20
just enabled if you are working on a virtio transport issue or new virtio=20
feature and then you are usually working on this source code already.

But again: no strong opinion about this overall issue whatsoever.

/Christian



