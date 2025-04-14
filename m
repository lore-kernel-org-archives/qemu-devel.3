Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052DDC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LqD-0005n9-Eb; Mon, 14 Apr 2025 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4Lq1-0005ih-Hr
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4Lpz-0006ru-6j
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744644904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTtdttDpMRCIR7RfY29Gl2AoWEWL6IbplTk10NoHapc=;
 b=ZHX09ltNl6K8uceai+coCjYTi5VTQibGtNIHWZDkC5d0Qk1Fu/APp/6cG1H0zfnWnFvxNl
 u2cPwevncJc4NRGJMUGzPo2Gn/uaqhd9mHsRNzUJUIDdPKY7PI6hdN3IwMD1v2MrY8Du8N
 LNvgnS1x6lltgIL+fTYMfWJEWzuTJyA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-rvIazJjVOxOkS6crMzGRuw-1; Mon,
 14 Apr 2025 11:34:56 -0400
X-MC-Unique: rvIazJjVOxOkS6crMzGRuw-1
X-Mimecast-MFC-AGG-ID: rvIazJjVOxOkS6crMzGRuw_1744644895
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E899F1954B36; Mon, 14 Apr 2025 15:34:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03AA91828AAA; Mon, 14 Apr 2025 15:34:52 +0000 (UTC)
Date: Mon, 14 Apr 2025 11:34:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/2] file-posix: probe discard alignment on Linux
 block devices
Message-ID: <20250414153451.GC117758@fedora>
References: <20250410184103.23385-1-stefanha@redhat.com>
 <20250410184103.23385-2-stefanha@redhat.com>
 <c7b9ddb4-10de-4c66-9f2f-c964d77275e0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cFhVdxoYEyX1w5mf"
Content-Disposition: inline
In-Reply-To: <c7b9ddb4-10de-4c66-9f2f-c964d77275e0@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--cFhVdxoYEyX1w5mf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:15:13AM +0200, Hanna Czenczek wrote:
> On 10.04.25 20:41, Stefan Hajnoczi wrote:
> > Populate the pdiscard_alignment block limit so the block layer is able
> > align discard requests correctly.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   block/file-posix.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> Ah, I didn=E2=80=99t know sysfs is actually fair game.=C2=A0 Should we no=
t also get the
> maximum discard length then, too?

The maximum discard length behaves differently: the Linux block layer
splits requests according to the maximum discard length. If the guest
submits a discard request that is too large for the host, the host block
layer will split it and the request succeeds. That is why I didn't make
any changes to the maximum discard length in this series.

>=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 56d1972d15..2a1e1f48c0 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1276,10 +1276,10 @@ static int get_sysfs_zoned_model(struct stat *s=
t, BlockZoneModel *zoned)
> >   }
> >   #endif /* defined(CONFIG_BLKZONED) */
> > +#ifdef CONFIG_LINUX
> >   /*
> >    * Get a sysfs attribute value as a long integer.
> >    */
> > -#ifdef CONFIG_LINUX
> >   static long get_sysfs_long_val(struct stat *st, const char *attribute)
> >   {
> >       g_autofree char *str =3D NULL;
> > @@ -1299,6 +1299,30 @@ static long get_sysfs_long_val(struct stat *st, =
const char *attribute)
> >       }
> >       return ret;
> >   }
> > +
> > +/*
> > + * Get a sysfs attribute value as a uint32_t.
> > + */
> > +static int get_sysfs_u32_val(struct stat *st, const char *attribute,
> > +                             uint32_t *u32)
> > +{
> > +    g_autofree char *str =3D NULL;
> > +    const char *end;
> > +    unsigned int val;
> > +    int ret;
> > +
> > +    ret =3D get_sysfs_str_val(st, attribute, &str);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    /* The file is ended with '\n', pass 'end' to accept that. */
> > +    ret =3D qemu_strtoui(str, &end, 10, &val);
> > +    if (ret =3D=3D 0 && end && *end =3D=3D '\0') {
> > +        *u32 =3D val;
> > +    }
> > +    return ret;
> > +}
> >   #endif
> >   static int hdev_get_max_segments(int fd, struct stat *st)
> > @@ -1318,6 +1342,23 @@ static int hdev_get_max_segments(int fd, struct =
stat *st)
> >   #endif
> >   }
> > +/*
> > + * Fills in *dalign with the discard alignment and returns 0 on succes=
s,
> > + * -errno otherwise.
> > + */
> > +static int hdev_get_pdiscard_alignment(struct stat *st, uint32_t *dali=
gn)
> > +{
> > +#ifdef CONFIG_LINUX
> > +    /*
> > +     * Note that Linux "discard_granularity" is QEMU "discard_alignmen=
t". Linux
> > +     * "discard_alignment" is something else.
> > +     */
> > +    return get_sysfs_u32_val(st, "discard_granularity", dalign);
> > +#else
> > +    return -ENOTSUP;
> > +#endif
> > +}
> > +
> >   #if defined(CONFIG_BLKZONED)
> >   /*
> >    * If the reset_all flag is true, then the wps of zone whose state is
> > @@ -1527,6 +1568,19 @@ static void raw_refresh_limits(BlockDriverState =
*bs, Error **errp)
> >           }
> >       }
> > +    if (S_ISBLK(st.st_mode)) {
> > +        uint32_t dalign =3D 0;
> > +        int ret;
> > +
> > +        ret =3D hdev_get_pdiscard_alignment(&st, &dalign);
> > +        if (ret =3D=3D 0) {
> > +            /* Must be a multiple of request_alignment */
> > +            assert(dalign % bs->bl.request_alignment =3D=3D 0);
>=20
> Is it fair to crash qemu if the kernel reports a value that is not a
> multiple of request_alignment?=C2=A0 Wouldn=E2=80=99t it make more sense =
to take the
> maximum, and if that still isn=E2=80=99t a multiple, return an error here?

I'll replace the assertion with an error.

The Linux block layer sysfs documentation says:

  [RO] Devices that support discard functionality may internally
  allocate space using units that are bigger than the logical
  block size.

I don't expect dalign to be smaller than request_alignment, but it
doesn't hurt the check if request_alignment would work.

>=20
> Hanna
>=20
> > +
> > +            bs->bl.pdiscard_alignment =3D dalign;
> > +        }
> > +    }
> > +
> >       raw_refresh_zoned_limits(bs, &st, errp);
> >   }
>=20

--cFhVdxoYEyX1w5mf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf9KxsACgkQnKSrs4Gr
c8jPnQf8D1+1twXgXGCJABQ3O0xx3wX4AE1mK/MZwqCaece9Re1CHKo++NahrrjK
wY9wAwTrL6kzJpE/nyRoH/2zJvsx23w0vCKoqaOtyFuGUzLF8SFTkfHs01t2ezSv
iQaQz4l6H7K3cgRyD5uw72z/kqDEcDWKLGnGkWIOI/Exag8h8VDvOiP4tk7cNezi
bGvvHCjyUnQYxsKvAyRpZx46X8HtyvK+jRWbJ++JvuvlOnysUxR2lMfqmEZfV03g
vT0NDt0xIDdcfLxRltEBOrFeLjzXtOAFC21EWv1WwUv41jMU7jI4r7ywXJW9+hz1
DKO71EE8m7/22mDkOXCCHjOKhvQlDQ==
=QbKK
-----END PGP SIGNATURE-----

--cFhVdxoYEyX1w5mf--


