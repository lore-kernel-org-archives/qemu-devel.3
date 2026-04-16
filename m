Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE914F8D743
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDN8U-0006RA-6K; Thu, 16 Apr 2026 09:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wDN8S-0006Qt-Gq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wDN8Q-00084y-64
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776347517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWB0NDvNBt7lWDPH4z6EZqxp/p2NT+5Egi8yXhvf2GQ=;
 b=InBZeS5DqRTl+i7o0Xy86iUCsdrvzAdwgITJP58Sv9T3WupHitt+ZzUPbAPcEVf4Z9Gsu9
 HwNs8q9/+Fi+US2fMFHI+2JyD3N/xoPDpMt5ziRu2i0pk+G4ibz2xRNsd14uSb9FTyb3wm
 ZTVUfOdSmm4ctE4jUvJUCPC3KPYDkbU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-hwvfNsuSMWmNHg8Aud4--A-1; Thu,
 16 Apr 2026 09:51:53 -0400
X-MC-Unique: hwvfNsuSMWmNHg8Aud4--A-1
X-Mimecast-MFC-AGG-ID: hwvfNsuSMWmNHg8Aud4--A_1776347512
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D821A1956056; Thu, 16 Apr 2026 13:51:51 +0000 (UTC)
Received: from localhost (unknown [10.44.49.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B29F1180047F; Thu, 16 Apr 2026 13:51:50 +0000 (UTC)
Date: Thu, 16 Apr 2026 09:51:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Christian Speich <c.speich@avm.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 4/6] hw/sd/sdhci: Don't use bounce buffer for ADMA
Message-ID: <20260416135148.GA233931@fedora>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-4-dc1cf172ee57@avm.de>
 <4e0536d5-d7a8-45f7-b2b2-bff9fe2d92cc@linaro.org>
 <t4mncbf2hpzecg23tmuu3rd7ha4zs7fftqyk54n7cfqltk66hw@gnnqucv72rbk>
 <df6688f7-1111-474a-b4f9-8d7eec3ce8d9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n4M105uudhCdgbsM"
Content-Disposition: inline
In-Reply-To: <df6688f7-1111-474a-b4f9-8d7eec3ce8d9@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--n4M105uudhCdgbsM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 10:27:22AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Paolo &  Stefan.
>=20
> On 16/4/26 09:52, Christian Speich wrote:
> > On Tue, Apr 14, 2026 at 03:51:24PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > > On 4/2/26 14:22, Christian Speich wrote:
> > > > Currently, ADMA will temporarily store data into a local bounce buf=
fer
> > > > when transferring it. This will produce unneeded copies of the data=
 and
> > > > limit us to the bounce buffer size for each step.
> > > >=20
> > > > This patch now maps the requested DMA address and passes this buffer
> > > > directly to sdbus_{read,write}_data. This allows to pass much larger
> > > > buffers down to increase the performance. sdbus_{read,write}_data is
> > > > already able to handle arbitrary length and alignments, so we do not
> > > > need to ensure this.
> > > >=20
> > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > ---
> > > >    hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++-------------=
--------------
> > > >    1 file changed, 55 insertions(+), 47 deletions(-)
> > > >=20
> > > > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > > > index c86dfa281f4b0218bf6dda7a38d46abfc9638450..6e07711478cb6ca046a=
7d371a82e2c682ebbda00 100644
> > > > --- a/hw/sd/sdhci.c
> > > > +++ b/hw/sd/sdhci.c
> > > > @@ -775,7 +775,7 @@ static void get_adma_description(SDHCIState *s,=
 ADMADescr *dscr)
> > > >    static void sdhci_do_adma(SDHCIState *s)
> > > >    {
> > > > -    unsigned int begin, length;
> > > > +    unsigned int length;
> > > >        const uint16_t block_size =3D s->blksize & BLOCK_SIZE_MASK;
> > > >        const MemTxAttrs attrs =3D { .memory =3D true };
> > > >        ADMADescr dscr =3D {};
> > > > @@ -817,66 +817,74 @@ static void sdhci_do_adma(SDHCIState *s)
> > > >                if (s->trnmod & SDHC_TRNS_READ) {
> > > >                    s->prnsts |=3D SDHC_DOING_READ;
> > > >                    while (length) {
> > > > -                    if (s->data_count =3D=3D 0) {
> > > > -                        sdbus_read_data(&s->sdbus, s->fifo_buffer,=
 block_size);
> > > > -                    }
> > > > -                    begin =3D s->data_count;
> > > > -                    if ((length + begin) < block_size) {
> > > > -                        s->data_count =3D length + begin;
> > > > -                        length =3D 0;
> > > > -                     } else {
> > > > -                        s->data_count =3D block_size;
> > > > -                        length -=3D block_size - begin;
> > > > -                    }
> > > > -                    res =3D dma_memory_write(s->dma_as, dscr.addr,
> > > > -                                           &s->fifo_buffer[begin],
> > > > -                                           s->data_count - begin,
> > > > -                                           attrs);
> > > > -                    if (res !=3D MEMTX_OK) {
> > > > +                    dma_addr_t dma_len =3D length;
> > > > +
> > > > +                    void *buf =3D dma_memory_map(s->dma_as, dscr.a=
ddr, &dma_len,
> > > > +                                               DMA_DIRECTION_FROM_=
DEVICE,
> > > > +                                               attrs);
> > >=20
> > > We know the descriptor is a consecutive range. Couldn't we map/unmap
> > > outside of the while() loop? (Ditto write path).
> >=20
> > The loop is there to handle dma_memory_map mapping less that we've requ=
ested. I'm not
> > really sure if there are any guranteed cases where it always maps the r=
equested length
> > fully (at least there are non in the dma_memory_map doc string).
> >=20
> > Iff this is guranteed to always map the requested length, we could remo=
ve the whie()
> > loop completly.

I think this loop is required because:

- A consecutive DMA address range can span multiple host address ranges.
  This can happen when there is more than 1 RAM block backing the DMA
  address space.

- When the DMA address range includes non-RAM addresses (e.g. MMIO
  regions), then it is mapped via a bounce buffer that has a size limit
  and could require multiple iterations.

> >=20
> > Kind Regards,
> > Christian
> >=20
> > >=20
> > > > +
> > > > +                    if (buf =3D=3D NULL) {
> > > > +                        res =3D MEMTX_ERROR;
> > > >                            break;
> > > > +                    } else {
> > > > +                        res =3D MEMTX_OK;
> > > >                        }
> > > > -                    dscr.addr +=3D s->data_count - begin;
> > > > -                    if (s->data_count =3D=3D block_size) {
> > > > -                        s->data_count =3D 0;
> > > > -                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> > > > -                            s->blkcnt--;
> > > > -                            if (s->blkcnt =3D=3D 0) {
> > > > -                                break;
> > > > -                            }
> > > > +
> > > > +                    sdbus_read_data(&s->sdbus, buf, dma_len);
> > > > +                    length -=3D dma_len;
> > > > +                    dscr.addr +=3D dma_len;
> > > > +
> > > > +                    dma_memory_unmap(s->dma_as, buf, dma_len,
> > > > +                                     DMA_DIRECTION_FROM_DEVICE, dm=
a_len);
> > > > +
> > > > +                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> > > > +                        size_t transfered =3D s->data_count + dma_=
len;
> > > > +
> > > > +                        s->blkcnt -=3D transfered / block_size;
> > > > +                        s->data_count =3D transfered % block_size;
> > > > +
> > > > +                        if (s->blkcnt =3D=3D 0) {
> > > > +                            s->data_count =3D 0;
> > > > +                            break;
> > > >                            }
> > > >                        }
> > > >                    }
> > > >                } else {
> > >=20
> > >=20
>=20

--n4M105uudhCdgbsM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmng6XQACgkQnKSrs4Gr
c8h41gf/b5Zfl1aI3CuhAyEwu0UCgt8ynbSQJ+8cC10nrHKKUSCPgSTSI7FVtMKr
G7G84hCmS1gjKo8d4fDAhRARz8Up0Erfs4HPg4gnsfJPekne0RLnyjopXf+9yP61
gq2hETXmkDU2Kd4XAOgEEj94sGdHzkwXANfzJvPzrUntPTTtJ4F40i4CFEqb/6rS
N4L72lERsF+RJW0SmL4zRU308aJ7lEqD/jqdj00S8RPMKIW5UKlISPfoWOjxkUGf
cLbhfJFvMmCW+y4tQG0y/snliVXGjIZtHSxS4LTWMHPUJkSXXfLCkRYgf/fGa/wb
awW3Son+JlhVkzbeWnjFVwL7zy9Yqw==
=2pjw
-----END PGP SIGNATURE-----

--n4M105uudhCdgbsM--


