Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED23FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmgT-0006Z3-Bh; Wed, 21 May 2025 12:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uHmgQ-0006Yf-Q2
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:52:47 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uHmgJ-0007Wu-Rp
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:52:46 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70df67e1b17so8624337b3.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747846356; x=1748451156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tYuM7NArQlPe2LQn+VCpOU0Gw2OMOKcagy0TIUjo1Wc=;
 b=VxDXMYnGjFNNPHEMb7uJtyimnsMmW8JRmrtwj040xjXv/4sgvoxKCuRujrI5swOogF
 +2Dh5XZh6J03FiUFGMrgv/DtD1kRR3VMt8wnf9sJe3FYjEv+uswWM59j4GhuYrtXS9Ud
 TnpFceuxJMd812VRdtiP3N154MRstsqTbj3g5jWArh6IMo5vdcQRep8fn/YQ10HuWYm4
 B8r9lv/jWIlorIccBP6dG1IcRi6641NN11UesB6UAsnILothoh6eJmEZ+o8pBHFXDwU8
 W/nz3th/mw3Xc3N4jCIPhcogt3V/oeG5e+VtbIEn+c2glZpr4Rs10o7IaAMXky7dTlGC
 ZAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747846356; x=1748451156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tYuM7NArQlPe2LQn+VCpOU0Gw2OMOKcagy0TIUjo1Wc=;
 b=MHZ60ERBRckNcCL2QvqvFjFJ56Ijb9AWzz4S9LZJNvz+A43omBRIffymUjrSSbuQh6
 y9Sz1CpXalYkjlrQid8XRB+cMY8/jBsUIqMOJT22p0hFo0Gfaxa4pVKiynjKijdh19Ao
 gGebvlAtmf2URv4H8P/VqzLT32gMIg8Ro0uS2upwV3jv2tUTuYTwLnc6tPxTazj4pV2E
 FqAAVblOocrTO8XxGno9u6G6Y5yI7SELhVP1O38ryJ08Ges5+joOAMd30V2CLcf0ASAx
 ZeOZPg/nVrBZ8RD6LQdrtCFKdYlgS7Hdu3UxEq0W23hvQcmNfq0v9LBgRcqVxgHdL46C
 BOqQ==
X-Gm-Message-State: AOJu0YzrBkOXqIn0sQi+aw1/+4x6zfL+Umz648Vovm7oT67GU/vYo/CR
 TqwNWDmmtcB+zL9p7zvD/qTHMseQdMC0j/1203l84SUa90EBNsTKytU3UTh40oCQvjOIRQ9UE1N
 IuuqeCq+wjmxzDKWQve6xK2WNWNZ1Rjo=
X-Gm-Gg: ASbGnctGLVOE5S+Bh++lq5tSHaWVZT9GNZcqyaqg3SEzGJvUFNm8ffr1SDtJx2e0GYv
 xbGnkJuerd1FztzicIgTuxLxngUWedxJtBlwu5qPmpl2fijMSNkzZjcDgNYqZ7lr0F1116COJVw
 CCDMumTMjk0jBX8qicWhKkpPGDl5nO4gUTRuMrf6qWdUyGcXQgt1Y/1N7gda8l/k7ItQ+fL6WXi
 tLZ
X-Google-Smtp-Source: AGHT+IEf6Ovh7bfyruQD5to3VwKmzCDqRZ3IuZBdcLCyYZwCBHbnqAdi2E20WGGkGCEVtfNWcqWdQ3dp4vgdzjwKN30=
X-Received: by 2002:a05:690c:4b8f:b0:702:72e3:1cb6 with SMTP id
 00721157ae682-70ca7b7eaf5mr322481027b3.26.1747846356121; Wed, 21 May 2025
 09:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250516150052.30818-1-conte.souleymane@gmail.com>
 <20250516150052.30818-3-conte.souleymane@gmail.com>
 <CAFEAcA925nKoPW5HwdNUNm8a9baEufNyPosw34-rHVkBppZVxA@mail.gmail.com>
In-Reply-To: <CAFEAcA925nKoPW5HwdNUNm8a9baEufNyPosw34-rHVkBppZVxA@mail.gmail.com>
From: =?UTF-8?Q?souleymane_cont=C3=A9?= <conte.souleymane@gmail.com>
Date: Wed, 21 May 2025 18:52:23 +0200
X-Gm-Features: AX0GCFvRgV_u7b5E6P3bnPKNW06sHur9FJZJOoJY9JruGpKNeKzoLNj_dQjxdPA
Message-ID: <CAOw3OrHSa+_19ONrPYdhLVw+KX1LVLKZ6C1TgSrgxHPkz626AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs/interop: convert text files to
 restructuredText
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002dcb5b0635a83140"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=conte.souleymane@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000002dcb5b0635a83140
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thank you for the review and the advices also.

I will make some corrections based on the review for v3. Here are the main
changes:
- Nested table rending in code blocks
- monospace usage for all filenames, fields name and function references
- rendering of "\0" character using ``

Thanks,
Souleymane Conte


Le lun. 19 mai 2025 =C3=A0 15:37, Peter Maydell <peter.maydell@linaro.org> =
a
=C3=A9crit :

> On Fri, 16 May 2025 at 16:01, <conte.souleymane@gmail.com> wrote:
> >
> > From: Souleymane Conte <conte.souleymane@gmail.com>
> >
> > buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
> >
> > Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
>
> Thanks for this patch. It looks good, so I only have
> some minor changes to suggest below.
>
> A minor thing: for a single patch, please don't send a
> cover letter -- it confuses some of our automated tooling.
> Cover letters are only needed for multi-patch series.
>
> For a single patch, if you want to add notes about e.g.
> changes between v1 and v2, you can put them below the '---'
> line...
>
> > ---
>
> ...here. Text here won't go into the final git commit
> message.
>
> >  docs/interop/index.rst                |   1 +
> >  docs/interop/{qcow2.txt =3D> qcow2.rst} | 218 +++++++++++++++---------=
--
> >  2 files changed, 128 insertions(+), 91 deletions(-)
> >  rename docs/interop/{qcow2.txt =3D> qcow2.rst} (88%)
> >
> > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > index 999e44eae1..bfe3cf0beb 100644
> > --- a/docs/interop/index.rst
> > +++ b/docs/interop/index.rst
> > @@ -23,6 +23,7 @@ are useful for making QEMU interoperate with other
> software.
> >     qemu-ga-ref
> >     qemu-qmp-ref
> >     qemu-storage-daemon-qmp-ref
> > +   qcow2
>
> I think I would put this a little further up in the
> index, just below "parallels". That way it goes together
> with the other image-format specs in the index list.
>
> >     vhost-user
> >     vhost-user-gpu
> >     vhost-vdpa
> > diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.rst
> > similarity index 88%
> > rename from docs/interop/qcow2.txt
> > rename to docs/interop/qcow2.rst
> > index 2c4618375a..2295dd4ae6 100644
> > --- a/docs/interop/qcow2.txt
> > +++ b/docs/interop/qcow2.rst
> > @@ -1,6 +1,8 @@
> > -=3D=3D General =3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Qcow2 Image File
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -A qcow2 image file is organized in units of constant size, which are
> called
> > +A *qcow2* image file is organized in units of constant size, which are
> called
> >  (host) clusters. A cluster is the unit in which all allocations are
> done,
> >  both for actual guest data and for image metadata.
> >
> > @@ -9,10 +11,10 @@ clusters of the same size.
> >
> >  All numbers in qcow2 are stored in Big Endian byte order.
> >
> > +Header
> > +------
> >
> > -=3D=3D Header =3D=3D
> > -
> > -The first cluster of a qcow2 image contains the file header:
> > +The first cluster of a qcow2 image contains the file header::
> >
> >      Byte  0 -  3:   magic
> >                      QCOW magic string ("QFI\xfb")
> > @@ -38,7 +40,7 @@ The first cluster of a qcow2 image contains the file
> header:
> >                      within a cluster (1 << cluster_bits is the cluster
> size).
> >                      Must not be less than 9 (i.e. 512 byte clusters).
> >
> > -                    Note: qemu as of today has an implementation limit
> of 2 MB
> > +                    Note: Qemu as of today has an implementation limit
> of 2 MB
>
> If we're going to change this kind of thing: the correct spelling
> is all-caps "QEMU".
>
> >                      as the maximum cluster size and won't be able to
> open images
> >                      with larger cluster sizes.
> >
> > @@ -48,7 +50,7 @@ The first cluster of a qcow2 image contains the file
> header:
> >           24 - 31:   size
> >                      Virtual disk size in bytes.
> >
> > -                    Note: qemu has an implementation limit of 32 MB as
> > +                    Note: Qemu has an implementation limit of 32 MB as
> >                      the maximum L1 table size.  With a 2 MB cluster
> >                      size, it is unable to populate a virtual cluster
> >                      beyond 2 EB (61 bits); with a 512 byte cluster
> > @@ -88,6 +90,7 @@ The first cluster of a qcow2 image contains the file
> header:
> >  For version 2, the header is exactly 72 bytes in length, and finishes
> here.
> >  For version 3 or higher, the header length is at least 104 bytes,
> including
> >  the next fields through header_length.
> > +::
> >
> >           72 -  79:  incompatible_features
> >                      Bitmask of incompatible features. An implementatio=
n
> must
> > @@ -185,7 +188,8 @@ the next fields through header_length.
> >                      of 8.
> >
> >
> > -=3D=3D=3D Additional fields (version 3 and higher) =3D=3D=3D
> > +Additional fields (version 3 and higher)
> > +----------------------------------------
> >
> >  In general, these fields are optional and may be safely ignored by the
> software,
> >  as well as filled by zeros (which is equal to field absence), if
> software needs
> > @@ -193,21 +197,25 @@ to set field B, but does not care about field A
> which precedes B. More
> >  formally, additional fields have the following compatibility rules:
> >
> >  1. If the value of the additional field must not be ignored for correc=
t
> > -handling of the file, it will be accompanied by a corresponding
> incompatible
> > -feature bit.
> > +   handling of the file, it will be accompanied by a corresponding
> incompatible
> > +   feature bit.
> >
> >  2. If there are no unrecognized incompatible feature bits set, an
> unknown
> > -additional field may be safely ignored other than preserving its value
> when
> > -rewriting the image header.
> > +   additional field may be safely ignored other than preserving its
> value when
> > +   rewriting the image header.
> > +
> > +.. _ref_rules_3:
> >
> >  3. An explicit value of 0 will have the same behavior as when the fiel=
d
> is not
> > -present*, if not altered by a specific incompatible bit.
> > +   present*, if not altered by a specific incompatible bit.
> >
> > -*. A field is considered not present when header_length is less than o=
r
> equal
> > +(*) A field is considered not present when *header_length* is less tha=
n
> or equal
> >  to the field's offset. Also, all additional fields are not present for
> >  version 2.
>
> For references in formatted text to things like field names, function
> names, filenames and similar fixed-strings, I recommend ``header_length``
> (which gives monospaced) rather than *header_length* (which is italics)
> or **header_length** (which is bold).
>
> > -              104:  compression_type
> > +::
> > +
> > +        104:        compression_type
> >
> >                      Defines the compression method used for compressed
> clusters.
> >                      All compressed clusters in an image use the same
> compression
> > @@ -219,28 +227,30 @@ version 2.
> >                      or must be zero (which means deflate).
> >
> >                      Available compression type values:
> > -                        0: deflate <
> https://www.ietf.org/rfc/rfc1951.txt>
> > -                        1: zstd <http://github.com/facebook/zstd>
> > +                       - 0: deflate
> https://www.ietf.org/rfc/rfc1951.txt
> > +                       - 1: zstd <http://github.com/facebook/zstd>
>
> We should be consistent about whether we have the angle brackets
> or not.
>
> This is all in a fixed-width text block, so the URL isn't going
> to be formatted anyway. Might as well leave the angleb rackets in,
> for consistency with e.g. below.
>
> >
> > -                    The deflate compression type is called "zlib"
> > +                    The deflate compression type is called zlib
>
> Any reason to drop the quotes here ?
>
> >                      <https://www.zlib.net/> in QEMU. However, clusters
> with the
> >                      deflate compression type do not have zlib headers.
> >
> >          105 - 111:  Padding, contents defined below.
> >
> > -=3D=3D=3D Header padding =3D=3D=3D
> > +Header padding
> > +--------------
> >
> > -@header_length must be a multiple of 8, which means that if the end of
> the last
> > +*header_length* must be a multiple of 8, which means that if the end o=
f
> the last
> >  additional field is not aligned, some padding is needed. This padding
> must be
> >  zeroed, so that if some existing (or future) additional field will fal=
l
> into
> > -the padding, it will be interpreted accordingly to point [3.] of the
> previous
> > +the padding, it will be interpreted accordingly to point `[3.]
> <#ref_rules_3>`_ of the previous
> >  paragraph, i.e.  in the same manner as when this field is not present.
> >
> >
> > -=3D=3D=3D Header extensions =3D=3D=3D
> > +Header extensions
> > +-----------------
> >
> >  Directly after the image header, optional sections called header
> extensions can
> > -be stored. Each extension has a structure like the following:
> > +be stored. Each extension has a structure like the following::
> >
> >      Byte  0 -  3:   Header extension type:
> >                          0x00000000 - End of the header extension area
> > @@ -270,17 +280,19 @@ data of compatible features that it doesn't
> support. Compatible features that
> >  need space for additional data can use a header extension.
> >
> >
> > -=3D=3D String header extensions =3D=3D
> > +String header extensions
> > +------------------------
> >
> >  Some header extensions (such as the backing file format name and the
> external
> >  data file name) are just a single string. In this case, the header
> extension
> >  length is the string length and the string is not '\0' terminated. (Th=
e
> header
> > -extension padding can make it look like a string is '\0' terminated, b=
ut
> > +extension padding can make it looks like a string is '\0' terminated,
> but
>
> The original text is correct: this should be "make it look like".
>
> Sphinx will interpret the '\' in '\0' as an escape, so it renders this
> as "'0' terminated". If you write this with the ``...`` for fixed-width
> text:
>     make it look like a string is ``\0`` terminated
> then Sphinx will output the backslash as a literal in the output.
>
>
> > @@ -377,35 +392,42 @@ Logically the layout looks like
> >
> >    +-----------------------------+
> >    | QCow2 header                |
> > +  +-----------------------------+
> >    | QCow2 header extension X    |
> > +  +-----------------------------+
> >    | QCow2 header extension FDE  |
> > +  +-----------------------------+
> >    | QCow2 header extension ...  |
> > +  +-----------------------------+
> >    | QCow2 header extension Z    |
> >    +-----------------------------+
> > +  | ...                         |
> > +  +-----------------------------+
> > +  | ...                         |
> > +  +-----------------------------+
> >    | ....other QCow2 tables....  |
> > -  .                             .
> > -  .                             .
> >    +-----------------------------+
> > -  | +-------------------------+ |
> > -  | | LUKS partition header   | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material 1     | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material 2     | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material ...   | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material 8     | |
> > -  | +-------------------------+ |
> > +  | +------------------------+  |
> > +  | | LUKS partition header  |  |
> > +  | +------------------------+  |
> > +  | | LUKS key material 1    |  |
> > +  | +------------------------+  |
> > +  | | LUKS key material 2    |  |
> > +  | +------------------------+  |
> > +  | | LUKS key material ...  |  |
> > +  | +------------------------+  |
> > +  | | LUKS key material 8    |  |
> > +  | +------------------------+  |
> > +  +-----------------------------+
>
> This does not seem to render as a nested table.
>
> Probably the simplest thing is to use the "::" syntax to
> keep this as ASCII art, similar to the way you've handled
> the other fixed-width tables in this document.
>
> > +  |   QCow2 cluster payload     |
> > +  +-----------------------------+
> > +  |                             |
> >    +-----------------------------+
> > -  | QCow2 cluster payload       |
> > -  .                             .
> > -  .                             .
> > -  .                             .
> >    |                             |
> >    +-----------------------------+
> >
>
> >
> > -Refcount block entry (x =3D refcount_bits - 1):
> > +Refcount block entry (x =3D refcount_bits - 1)::
>
> You could put ``(x =3D refcount_bits - 1)`` to make the code fragment
> render in monospace.
>
>
> > -Compressed Clusters Descriptor (x =3D 62 - (cluster_bits - 8)):
> > +Compressed Clusters Descriptor (x =3D 62 - (cluster_bits - 8))::
>
> and similarly here.
>
> thanks
> -- PMM
>

--0000000000002dcb5b0635a83140
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>Thank you for the review and the advices also.<br><=
br>I will make some corrections based on the review for v3. Here are the ma=
in changes:<br>- Nested table rending in code blocks<br>- monospace usage f=
or all filenames, fields name and function references<br>- rendering of &qu=
ot;\0&quot; character using ``=C2=A0<br><br>Thanks,<br>Souleymane Conte<br>=
=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 19 mai 2025 =C3=A0=C2=A015:37, P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Fri, 16 May 2025 at 16:01, &lt;<a href=3D"mailto:=
conte.souleymane@gmail.com" target=3D"_blank">conte.souleymane@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; From: Souleymane Conte &lt;<a href=3D"mailto:conte.souleymane@gmail.co=
m" target=3D"_blank">conte.souleymane@gmail.com</a>&gt;<br>
&gt;<br>
&gt; buglink: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/527"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/=
-/issues/527</a><br>
&gt;<br>
&gt; Signed-off-by: Souleymane Conte &lt;<a href=3D"mailto:conte.souleymane=
@gmail.com" target=3D"_blank">conte.souleymane@gmail.com</a>&gt;<br>
<br>
Thanks for this patch. It looks good, so I only have<br>
some minor changes to suggest below.<br>
<br>
A minor thing: for a single patch, please don&#39;t send a<br>
cover letter -- it confuses some of our automated tooling.<br>
Cover letters are only needed for multi-patch series.<br>
<br>
For a single patch, if you want to add notes about e.g.<br>
changes between v1 and v2, you can put them below the &#39;---&#39;<br>
line...<br>
<br>
&gt; ---<br>
<br>
...here. Text here won&#39;t go into the final git commit<br>
message.<br>
<br>
&gt;=C2=A0 docs/interop/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 docs/interop/{qcow2.txt =3D&gt; qcow2.rst} | 218 +++++++++++++++=
-----------<br>
&gt;=C2=A0 2 files changed, 128 insertions(+), 91 deletions(-)<br>
&gt;=C2=A0 rename docs/interop/{qcow2.txt =3D&gt; qcow2.rst} (88%)<br>
&gt;<br>
&gt; diff --git a/docs/interop/index.rst b/docs/interop/index.rst<br>
&gt; index 999e44eae1..bfe3cf0beb 100644<br>
&gt; --- a/docs/interop/index.rst<br>
&gt; +++ b/docs/interop/index.rst<br>
&gt; @@ -23,6 +23,7 @@ are useful for making QEMU interoperate with other s=
oftware.<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-ga-ref<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-qmp-ref<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-storage-daemon-qmp-ref<br>
&gt; +=C2=A0 =C2=A0qcow2<br>
<br>
I think I would put this a little further up in the<br>
index, just below &quot;parallels&quot;. That way it goes together<br>
with the other image-format specs in the index list.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-user<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-user-gpu<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-vdpa<br>
&gt; diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.rst<br>
&gt; similarity index 88%<br>
&gt; rename from docs/interop/qcow2.txt<br>
&gt; rename to docs/interop/qcow2.rst<br>
&gt; index 2c4618375a..2295dd4ae6 100644<br>
&gt; --- a/docs/interop/qcow2.txt<br>
&gt; +++ b/docs/interop/qcow2.rst<br>
&gt; @@ -1,6 +1,8 @@<br>
&gt; -=3D=3D General =3D=3D<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +Qcow2 Image File<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;<br>
&gt; -A qcow2 image file is organized in units of constant size, which are =
called<br>
&gt; +A *qcow2* image file is organized in units of constant size, which ar=
e called<br>
&gt;=C2=A0 (host) clusters. A cluster is the unit in which all allocations =
are done,<br>
&gt;=C2=A0 both for actual guest data and for image metadata.<br>
&gt;<br>
&gt; @@ -9,10 +11,10 @@ clusters of the same size.<br>
&gt;<br>
&gt;=C2=A0 All numbers in qcow2 are stored in Big Endian byte order.<br>
&gt;<br>
&gt; +Header<br>
&gt; +------<br>
&gt;<br>
&gt; -=3D=3D Header =3D=3D<br>
&gt; -<br>
&gt; -The first cluster of a qcow2 image contains the file header:<br>
&gt; +The first cluster of a qcow2 image contains the file header::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Byte=C2=A0 0 -=C2=A0 3:=C2=A0 =C2=A0magic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 QCOW magic string (&quot;QFI\xfb&quot;)<br>
&gt; @@ -38,7 +40,7 @@ The first cluster of a qcow2 image contains the file=
 header:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 within a cluster (1 &lt;&lt; cluster_bits is the cluster size).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Must not be less than 9 (i.e. 512 byte clusters).<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Note: qemu as of today has an implementation limit of 2 MB<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Note: Qemu as of today has an implementation limit of 2 MB<br>
<br>
If we&#39;re going to change this kind of thing: the correct spelling<br>
is all-caps &quot;QEMU&quot;.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 as the maximum cluster size and won&#39;t be able to open images<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 with larger cluster sizes.<br>
&gt;<br>
&gt; @@ -48,7 +50,7 @@ The first cluster of a qcow2 image contains the file=
 header:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024 - 31:=C2=A0 =C2=A0size<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Virtual disk size in bytes.<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Note: qemu has an implementation limit of 32 MB as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Note: Qemu has an implementation limit of 32 MB as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 the maximum L1 table size.=C2=A0 With a 2 MB cluster<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size, it is unable to populate a virtual cluster<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 beyond 2 EB (61 bits); with a 512 byte cluster<br>
&gt; @@ -88,6 +90,7 @@ The first cluster of a qcow2 image contains the file=
 header:<br>
&gt;=C2=A0 For version 2, the header is exactly 72 bytes in length, and fin=
ishes here.<br>
&gt;=C2=A0 For version 3 or higher, the header length is at least 104 bytes=
, including<br>
&gt;=C2=A0 the next fields through header_length.<br>
&gt; +::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A072 -=C2=A0 79:=C2=A0 incompati=
ble_features<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Bitmask of incompatible features. An implementation must<br>
&gt; @@ -185,7 +188,8 @@ the next fields through header_length.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 of 8.<br>
&gt;<br>
&gt;<br>
&gt; -=3D=3D=3D Additional fields (version 3 and higher) =3D=3D=3D<br>
&gt; +Additional fields (version 3 and higher)<br>
&gt; +----------------------------------------<br>
&gt;<br>
&gt;=C2=A0 In general, these fields are optional and may be safely ignored =
by the software,<br>
&gt;=C2=A0 as well as filled by zeros (which is equal to field absence), if=
 software needs<br>
&gt; @@ -193,21 +197,25 @@ to set field B, but does not care about field A =
which precedes B. More<br>
&gt;=C2=A0 formally, additional fields have the following compatibility rul=
es:<br>
&gt;<br>
&gt;=C2=A0 1. If the value of the additional field must not be ignored for =
correct<br>
&gt; -handling of the file, it will be accompanied by a corresponding incom=
patible<br>
&gt; -feature bit.<br>
&gt; +=C2=A0 =C2=A0handling of the file, it will be accompanied by a corres=
ponding incompatible<br>
&gt; +=C2=A0 =C2=A0feature bit.<br>
&gt;<br>
&gt;=C2=A0 2. If there are no unrecognized incompatible feature bits set, a=
n unknown<br>
&gt; -additional field may be safely ignored other than preserving its valu=
e when<br>
&gt; -rewriting the image header.<br>
&gt; +=C2=A0 =C2=A0additional field may be safely ignored other than preser=
ving its value when<br>
&gt; +=C2=A0 =C2=A0rewriting the image header.<br>
&gt; +<br>
&gt; +.. _ref_rules_3:<br>
&gt;<br>
&gt;=C2=A0 3. An explicit value of 0 will have the same behavior as when th=
e field is not<br>
&gt; -present*, if not altered by a specific incompatible bit.<br>
&gt; +=C2=A0 =C2=A0present*, if not altered by a specific incompatible bit.=
<br>
&gt;<br>
&gt; -*. A field is considered not present when header_length is less than =
or equal<br>
&gt; +(*) A field is considered not present when *header_length* is less th=
an or equal<br>
&gt;=C2=A0 to the field&#39;s offset. Also, all additional fields are not p=
resent for<br>
&gt;=C2=A0 version 2.<br>
<br>
For references in formatted text to things like field names, function<br>
names, filenames and similar fixed-strings, I recommend ``header_length``<b=
r>
(which gives monospaced) rather than *header_length* (which is italics)<br>
or **header_length** (which is bold).<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 104:=C2=A0 compressi=
on_type<br>
&gt; +::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 104:=C2=A0 =C2=A0 =C2=A0 =C2=A0 compressi=
on_type<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Defines the compression method used for compressed clusters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 All compressed clusters in an image use the same compression<br>
&gt; @@ -219,28 +227,30 @@ version 2.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 or must be zero (which means deflate).<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Available compression type values:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0: deflate &lt;<a href=3D"https://www.ietf.org/rfc/rfc1951.t=
xt" rel=3D"noreferrer" target=3D"_blank">https://www.ietf.org/rfc/rfc1951.t=
xt</a>&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 1: zstd &lt;<a href=3D"http://github.com/facebook/zstd" rel=
=3D"noreferrer" target=3D"_blank">http://github.com/facebook/zstd</a>&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0- 0: deflate <a href=3D"https://www.ietf.org/rfc/rfc1951.txt"=
 rel=3D"noreferrer" target=3D"_blank">https://www.ietf.org/rfc/rfc1951.txt<=
/a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0- 1: zstd &lt;<a href=3D"http://github.com/facebook/zstd" rel=
=3D"noreferrer" target=3D"_blank">http://github.com/facebook/zstd</a>&gt;<b=
r>
<br>
We should be consistent about whether we have the angle brackets<br>
or not.<br>
<br>
This is all in a fixed-width text block, so the URL isn&#39;t going<br>
to be formatted anyway. Might as well leave the angleb rackets in,<br>
for consistency with e.g. below.<br>
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 The deflate compression type is called &quot;zlib&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 The deflate compression type is called zlib<br>
<br>
Any reason to drop the quotes here ?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &lt;<a href=3D"https://www.zlib.net/" rel=3D"noreferrer" target=3D"_=
blank">https://www.zlib.net/</a>&gt; in QEMU. However, clusters with the<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 deflate compression type do not have zlib headers.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 105 - 111:=C2=A0 Padding, contents d=
efined below.<br>
&gt;<br>
&gt; -=3D=3D=3D Header padding =3D=3D=3D<br>
&gt; +Header padding<br>
&gt; +--------------<br>
&gt;<br>
&gt; -@header_length must be a multiple of 8, which means that if the end o=
f the last<br>
&gt; +*header_length* must be a multiple of 8, which means that if the end =
of the last<br>
&gt;=C2=A0 additional field is not aligned, some padding is needed. This pa=
dding must be<br>
&gt;=C2=A0 zeroed, so that if some existing (or future) additional field wi=
ll fall into<br>
&gt; -the padding, it will be interpreted accordingly to point [3.] of the =
previous<br>
&gt; +the padding, it will be interpreted accordingly to point `[3.] &lt;#r=
ef_rules_3&gt;`_ of the previous<br>
&gt;=C2=A0 paragraph, i.e.=C2=A0 in the same manner as when this field is n=
ot present.<br>
&gt;<br>
&gt;<br>
&gt; -=3D=3D=3D Header extensions =3D=3D=3D<br>
&gt; +Header extensions<br>
&gt; +-----------------<br>
&gt;<br>
&gt;=C2=A0 Directly after the image header, optional sections called header=
 extensions can<br>
&gt; -be stored. Each extension has a structure like the following:<br>
&gt; +be stored. Each extension has a structure like the following::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Byte=C2=A0 0 -=C2=A0 3:=C2=A0 =C2=A0Header extensi=
on type:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x00000000 - End of the header extension area<br>
&gt; @@ -270,17 +280,19 @@ data of compatible features that it doesn&#39;t =
support. Compatible features that<br>
&gt;=C2=A0 need space for additional data can use a header extension.<br>
&gt;<br>
&gt;<br>
&gt; -=3D=3D String header extensions =3D=3D<br>
&gt; +String header extensions<br>
&gt; +------------------------<br>
&gt;<br>
&gt;=C2=A0 Some header extensions (such as the backing file format name and=
 the external<br>
&gt;=C2=A0 data file name) are just a single string. In this case, the head=
er extension<br>
&gt;=C2=A0 length is the string length and the string is not &#39;\0&#39; t=
erminated. (The header<br>
&gt; -extension padding can make it look like a string is &#39;\0&#39; term=
inated, but<br>
&gt; +extension padding can make it looks like a string is &#39;\0&#39; ter=
minated, but<br>
<br>
The original text is correct: this should be &quot;make it look like&quot;.=
<br>
<br>
Sphinx will interpret the &#39;\&#39; in &#39;\0&#39; as an escape, so it r=
enders this<br>
as &quot;&#39;0&#39; terminated&quot;. If you write this with the ``...`` f=
or fixed-width<br>
text:<br>
=C2=A0 =C2=A0 make it look like a string is ``\0`` terminated<br>
then Sphinx will output the backslash as a literal in the output.<br>
<br>
<br>
&gt; @@ -377,35 +392,42 @@ Logically the layout looks like<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension X=C2=A0 =C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension FDE=C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension ...=C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension Z=C2=A0 =C2=A0 |<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt; +=C2=A0 | ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt; +=C2=A0 | ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | ....other QCow2 tables....=C2=A0 |<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS partition header=C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material 1=C2=A0 =C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material 2=C2=A0 =C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material ...=C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material 8=C2=A0 =C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; +=C2=A0 | +------------------------+=C2=A0 |<br>
&gt; +=C2=A0 | | LUKS partition header=C2=A0 |=C2=A0 |<br>
&gt; +=C2=A0 | +------------------------+=C2=A0 |<br>
&gt; +=C2=A0 | | LUKS key material 1=C2=A0 =C2=A0 |=C2=A0 |<br>
&gt; +=C2=A0 | +------------------------+=C2=A0 |<br>
&gt; +=C2=A0 | | LUKS key material 2=C2=A0 =C2=A0 |=C2=A0 |<br>
&gt; +=C2=A0 | +------------------------+=C2=A0 |<br>
&gt; +=C2=A0 | | LUKS key material ...=C2=A0 |=C2=A0 |<br>
&gt; +=C2=A0 | +------------------------+=C2=A0 |<br>
&gt; +=C2=A0 | | LUKS key material 8=C2=A0 =C2=A0 |=C2=A0 |<br>
&gt; +=C2=A0 | +------------------------+=C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
<br>
This does not seem to render as a nested table.<br>
<br>
Probably the simplest thing is to use the &quot;::&quot; syntax to<br>
keep this as ASCII art, similar to the way you&#39;ve handled<br>
the other fixed-width tables in this document.<br>
<br>
&gt; +=C2=A0 |=C2=A0 =C2=A0QCow2 cluster payload=C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt; +=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt; -=C2=A0 | QCow2 cluster payload=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt;=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt;<br>
<br>
&gt;<br>
&gt; -Refcount block entry (x =3D refcount_bits - 1):<br>
&gt; +Refcount block entry (x =3D refcount_bits - 1)::<br>
<br>
You could put ``(x =3D refcount_bits - 1)`` to make the code fragment<br>
render in monospace.<br>
<br>
<br>
&gt; -Compressed Clusters Descriptor (x =3D 62 - (cluster_bits - 8)):<br>
&gt; +Compressed Clusters Descriptor (x =3D 62 - (cluster_bits - 8))::<br>
<br>
and similarly here.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000002dcb5b0635a83140--

