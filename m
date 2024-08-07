Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D116C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbW6A-0005bA-Of; Tue, 06 Aug 2024 22:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbW67-0005T8-SG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:08:19 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbW63-0007w3-Gx
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:08:19 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-26808290f43so275139fac.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1722996368; x=1723601168;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aSl1qgXvnrIU/W2JQD/9YRReeCIW4KmrscN5kVhC2fc=;
 b=vK77dFtZgK/d6xfO76Mz5WO9p+YHsCrD44p+UB7nagMPkdWqXgUzDCPupOpd/qWRwP
 0jCnhzre4NvlIpRGg8epGsaqWRdL3ZzZlOuTA90mj8adcpqv/bO0v5wtFZVkM3qrl1yb
 NmvHyVere9ccRUzSdYpqIJ8N+I0RHBTd46CDZ5ia+zjb7M3ZbxQwAcv3I8eDu/wtDG4i
 0fEUnBvssCBErXgyoSNBgS3gs0L+4ETOgyCXT9vlg9tA2fOzeudMZMCkXzOESeDx4AV1
 jBibGq87C69/YGY3hQeKohv4CWvzeTX3ML3NQopxr6J3WM8xV0wUlfm/OuZkxziyazh3
 FdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996368; x=1723601168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aSl1qgXvnrIU/W2JQD/9YRReeCIW4KmrscN5kVhC2fc=;
 b=R/VdxuzVVeamQcSWjdScvtb+eheWttq/6pDJ6beWXtP0ohuOMeSgb6aidruQL4Yc/v
 Bpuwpc5uNXGi+J5rjjJaqEseuhalAsYZnW0grUUDMTt1EWCF8/Qpqpa4mhQeOYp21ZtY
 b6se9GBmiBBomsGpzn1UA68zIVxXFOYvyhbWsTfyclXx8rAhUP5CFy6uN69a+fyPXw2g
 Hx0HiL0ljBM17vusYyqCJEU/XfQeXMy8ALXGIhtbMA5bPxpUu6iyyqYoPtR1eQiOcuGn
 N2QikAtNb7LdWg1r3dCHQX3itz3+R8NA0dfTKC8UTGQU21V55OFphK82kO73JVqopLLO
 l0VQ==
X-Gm-Message-State: AOJu0YxNajto6zG1SffMDFbJAHC/QK1EYhv7oBZapedycd1dwwlYU16M
 Oc4a0sqhFcSf/2uO6Jj2lVH3OrPw+Ipy/dnMVR7cjHxJeamBDjkLjM2Olktt6vfeLW/UWrSA/c4
 k9Llzr3RChfA2/bmClRbOTwaVp7e9LWY/YENPbg==
X-Google-Smtp-Source: AGHT+IFNYnPk5c8+0Du+y4lnSVsVAa5qvxvq5Olv/Lpt9WJKQAwTqu0DdRy0XduJc2RzHsWl3FOXBBJOX2cfvXTcwRo=
X-Received: by 2002:a05:6870:8093:b0:25e:b8ca:4b5 with SMTP id
 586e51a60fabf-2691150348bmr338061fac.4.1722996367445; Tue, 06 Aug 2024
 19:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1722957352.git.yong.huang@smartx.com>
 <8af3ae48cd4c3116b9f0f478bd5cf6df64198d66.1722957352.git.yong.huang@smartx.com>
 <875xsdh2xu.fsf@suse.de>
In-Reply-To: <875xsdh2xu.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 7 Aug 2024 10:05:51 +0800
Message-ID: <CAK9dgmYS+Wzr6xMgs6U6Jncy6UFWSKCYsD1i-mCr6k8e3CArAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/migration: Introduce multifd compression into
 guestperf
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006e6786061f0e5ad9"
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000006e6786061f0e5ad9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:22=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wrot=
e:

> yong.huang@smartx.com writes:
>
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > Guestperf tool does not cover the multifd compression option
> > currently, it is worth supporting so that developers can
> > analysis the migration performance with different
> > compression algorithms.
> >
> > Multifd support 4 compression algorithms currently:
> > zlib, zstd, qpl, uadk
> >
> > To request that multifd with the specified compression
> > algorithm such as zlib:
> > $ ./tests/migration/guestperf.py \
> >     --multifd --multifd-channels 4 --multifd-compression zlib \
> >     --output output.json
>
> Aren't you hitting this bug?
>
> /init (00001): INFO: 1722970659523ms copied 1 GB in 00382ms
>
>
> /init (00001): INFO: 1722970659896ms copied 1 GB in 00372ms
>
>
> /init (00001): INFO: 1722970660279ms copied 1 GB in 00382ms
>
>
> qemu-system-x86_64: multifd_send_pages: channel 0 has already quit!
>
>
> qemu-system-x86_64: Unable to write to socket: Broken pipe
>
>
>
> qemu-system-x86_64: check_section_footer: Read section footer failed: -5
>
> qemu-system-x86_64: load of migration failed: Invalid argument
>

No, I use the older qemu (6.2.0) to do the test since the guestperf
script updates infrequently. I'll use the latest version to do the
regression testing.


>
> >
> > To run the entire standardized set of multifd compression
> > comparisons, with unix migration:
> > $ ./tests/migration/guestperf-batch.py \
> >     --dst-host localhost --transport unix \
> >     --filter compr-multifd-compression* --output outputdir
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  tests/migration/guestperf/comparison.py | 13 +++++++++++++
> >  tests/migration/guestperf/engine.py     | 12 ++++++++++++
> >  tests/migration/guestperf/scenario.py   |  7 +++++--
> >  tests/migration/guestperf/shell.py      |  3 +++
>
> While here, if you'd like to move the whole guestperf into
> scripts/migration and make initrd-stress.img built by default I'd
> appreciate it.
>

Of course, I'm glad to.


>
> >  4 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/migration/guestperf/comparison.py
> b/tests/migration/guestperf/comparison.py
> > index 40e9d2eb1d..71208e8540 100644
> > --- a/tests/migration/guestperf/comparison.py
> > +++ b/tests/migration/guestperf/comparison.py
> > @@ -158,4 +158,17 @@ def __init__(self, name, scenarios):
> >          Scenario("compr-dirty-limit-50MB",
> >                   dirty_limit=3DTrue, vcpu_dirty_limit=3D50),
> >      ]),
> > +
> > +    # Looking at effect of multifd with
> > +    # different compression algorithm
>
> s/algorithm/algorithms/
>
> > +    Comparison("compr-multifd-compression", scenarios =3D [
> > +        Scenario("compr-multifd-compression-zlib",
> > +                 multifd=3DTrue, multifd_channels=3D4,
> multifd_compression=3D"zlib"),
> > +        Scenario("compr-multifd-compression-zstd",
> > +                 multifd=3DTrue, multifd_channels=3D4,
> multifd_compression=3D"zstd"),
> > +        Scenario("compr-multifd-compression-qpl",
> > +                 multifd=3DTrue, multifd_channels=3D4,
> multifd_compression=3D"qpl"),
> > +        Scenario("compr-multifd-compression-uadk",
> > +                 multifd=3DTrue, multifd_channels=3D4,
> multifd_compression=3D"uadk"),
> > +    ]),
> >  ]
> > diff --git a/tests/migration/guestperf/engine.py
> b/tests/migration/guestperf/engine.py
> > index 608d7270f6..883a7b8ab6 100644
> > --- a/tests/migration/guestperf/engine.py
> > +++ b/tests/migration/guestperf/engine.py
> > @@ -31,6 +31,8 @@
> >                               '..', '..', '..', 'python'))
> >  from qemu.machine import QEMUMachine
> >
> > +# multifd supported compressoin algorithms
>
> compression
>
> > +MULTIFD_CMP_ALGS =3D ("zlib", "zstd", "qpl", "uadk")
> >
> >  class Engine(object):
> >
> > @@ -205,6 +207,16 @@ def _migrate(self, hardware, scenario, src, dst,
> connect_uri):
> >              resp =3D dst.cmd("migrate-set-parameters",
> >                             multifd_channels=3Dscenario._multifd_channe=
ls)
> >
> > +            if scenario._multifd_compression:
> > +                if scenario._multifd_compression not in
> MULTIFD_CMP_ALGS:
> > +                    raise Exception("unsupported multifd compression "
> > +                                    "algorithm: %s" %
> > +                                    scenario._multifd_compression)
> > +                resp =3D src.command("migrate-set-parameters",
> > +                    multifd_compression=3Dscenario._multifd_compressio=
n)
> > +                resp =3D dst.command("migrate-set-parameters",
> > +                    multifd_compression=3Dscenario._multifd_compressio=
n)
>
> Should these be src.cmd() and dst.cmd()?
>

Yes,  I'll fix it in the next version.
Thanks for pointing out the low-level mistake I made. :(


>
> > +
> >          if scenario._dirty_limit:
> >              if not hardware._dirty_ring_size:
> >                  raise Exception("dirty ring size must be configured
> when "
> > diff --git a/tests/migration/guestperf/scenario.py
> b/tests/migration/guestperf/scenario.py
> > index 154c4f5d5f..4be7fafebf 100644
> > --- a/tests/migration/guestperf/scenario.py
> > +++ b/tests/migration/guestperf/scenario.py
> > @@ -30,7 +30,7 @@ def __init__(self, name,
> >                   auto_converge=3DFalse, auto_converge_step=3D10,
> >                   compression_mt=3DFalse, compression_mt_threads=3D1,
> >                   compression_xbzrle=3DFalse, compression_xbzrle_cache=
=3D10,
> > -                 multifd=3DFalse, multifd_channels=3D2,
> > +                 multifd=3DFalse, multifd_channels=3D2,
> multifd_compression=3D"",
> >                   dirty_limit=3DFalse, x_vcpu_dirty_limit_period=3D500,
> >                   vcpu_dirty_limit=3D1):
> >
> > @@ -61,6 +61,7 @@ def __init__(self, name,
> >
> >          self._multifd =3D multifd
> >          self._multifd_channels =3D multifd_channels
> > +        self._multifd_compression =3D multifd_compression
> >
> >          self._dirty_limit =3D dirty_limit
> >          self._x_vcpu_dirty_limit_period =3D x_vcpu_dirty_limit_period
> > @@ -85,6 +86,7 @@ def serialize(self):
> >              "compression_xbzrle_cache": self._compression_xbzrle_cache=
,
> >              "multifd": self._multifd,
> >              "multifd_channels": self._multifd_channels,
> > +            "multifd_compression": self._multifd_compression,
> >              "dirty_limit": self._dirty_limit,
> >              "x_vcpu_dirty_limit_period":
> self._x_vcpu_dirty_limit_period,
> >              "vcpu_dirty_limit": self._vcpu_dirty_limit,
> > @@ -109,4 +111,5 @@ def deserialize(cls, data):
> >              data["compression_xbzrle"],
> >              data["compression_xbzrle_cache"],
> >              data["multifd"],
> > -            data["multifd_channels"])
> > +            data["multifd_channels"],
> > +            data["multifd_compression"])
> > diff --git a/tests/migration/guestperf/shell.py
> b/tests/migration/guestperf/shell.py
> > index c85d89efec..1452eb8a33 100644
> > --- a/tests/migration/guestperf/shell.py
> > +++ b/tests/migration/guestperf/shell.py
> > @@ -130,6 +130,8 @@ def __init__(self):
> >                              action=3D"store_true")
> >          parser.add_argument("--multifd-channels",
> dest=3D"multifd_channels",
> >                              default=3D2, type=3Dint)
> > +        parser.add_argument("--multifd-compression",
> dest=3D"multifd_compression",
> > +                            default=3D"")
> >
> >          parser.add_argument("--dirty-limit", dest=3D"dirty_limit",
> default=3DFalse,
> >                              action=3D"store_true")
> > @@ -166,6 +168,7 @@ def get_scenario(self, args):
> >
> >                          multifd=3Dargs.multifd,
> >                          multifd_channels=3Dargs.multifd_channels,
> > +                        multifd_compression=3Dargs.multifd_compression=
,
> >
> >                          dirty_limit=3Dargs.dirty_limit,
> >                          x_vcpu_dirty_limit_period=3D\
>

Yong


--=20
Best regards

--0000000000006e6786061f0e5ad9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 7, 202=
4 at 3:22=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de">f=
arosas@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex"><a href=3D"mailto:y=
ong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> writes:<b=
r>
<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; Guestperf tool does not cover the multifd compression option<br>
&gt; currently, it is worth supporting so that developers can<br>
&gt; analysis the migration performance with different<br>
&gt; compression algorithms.<br>
&gt;<br>
&gt; Multifd support 4 compression algorithms currently:<br>
&gt; zlib, zstd, qpl, uadk<br>
&gt;<br>
&gt; To request that multifd with the specified compression<br>
&gt; algorithm such as zlib:<br>
&gt; $ ./tests/migration/guestperf.py \<br>
&gt;=C2=A0 =C2=A0 =C2=A0--multifd --multifd-channels 4 --multifd-compressio=
n zlib \<br>
&gt;=C2=A0 =C2=A0 =C2=A0--output output.json<br>
<br>
Aren&#39;t you hitting this bug?<br>
<br>
/init (00001): INFO: 1722970659523ms copied 1 GB in 00382ms=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <br>
/init (00001): INFO: 1722970659896ms copied 1 GB in 00372ms=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <br>
/init (00001): INFO: 1722970660279ms copied 1 GB in 00382ms=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <br>
qemu-system-x86_64: multifd_send_pages: channel 0 has already quit!=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
qemu-system-x86_64: Unable to write to socket: Broken pipe=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<br>
<br>
qemu-system-x86_64: check_section_footer: Read section footer failed: -5=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>
qemu-system-x86_64: load of migration failed: Invalid argument<br></blockqu=
ote><div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default">No, I use the older qemu (6.2.0) to do=
 the test since the=C2=A0guestperf</div><div style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif" class=3D"gmail_default">script updates infrequ=
ently. I&#39;ll use the latest version to do the=C2=A0</div></div><div styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defau=
lt">regression testing.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; To run the entire standardized set of multifd compression<br>
&gt; comparisons, with unix migration:<br>
&gt; $ ./tests/migration/guestperf-batch.py \<br>
&gt;=C2=A0 =C2=A0 =C2=A0--dst-host localhost --transport unix \<br>
&gt;=C2=A0 =C2=A0 =C2=A0--filter compr-multifd-compression* --output output=
dir<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/migration/guestperf/comparison.py | 13 +++++++++++++<br>
&gt;=C2=A0 tests/migration/guestperf/engine.py=C2=A0 =C2=A0 =C2=A0| 12 ++++=
++++++++<br>
&gt;=C2=A0 tests/migration/guestperf/scenario.py=C2=A0 =C2=A0|=C2=A0 7 ++++=
+--<br>
&gt;=C2=A0 tests/migration/guestperf/shell.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3=
 +++<br>
<br>
While here, if you&#39;d like to move the whole guestperf into<br>
scripts/migration and make initrd-stress.img built by default I&#39;d<br>
appreciate it.<br></blockquote><div><br></div><div><div style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Of course, =
I&#39;m glad to.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 4 files changed, 33 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/migration/guestperf/comparison.py b/tests/migration=
/guestperf/comparison.py<br>
&gt; index 40e9d2eb1d..71208e8540 100644<br>
&gt; --- a/tests/migration/guestperf/comparison.py<br>
&gt; +++ b/tests/migration/guestperf/comparison.py<br>
&gt; @@ -158,4 +158,17 @@ def __init__(self, name, scenarios):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Scenario(&quot;compr-dirty-limit-50M=
B&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di=
rty_limit=3DTrue, vcpu_dirty_limit=3D50),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ]),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 # Looking at effect of multifd with<br>
&gt; +=C2=A0 =C2=A0 # different compression algorithm<br>
<br>
s/algorithm/algorithms/<br>
<br>
&gt; +=C2=A0 =C2=A0 Comparison(&quot;compr-multifd-compression&quot;, scena=
rios =3D [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scenario(&quot;compr-multifd-compression-=
zlib&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd=
=3DTrue, multifd_channels=3D4, multifd_compression=3D&quot;zlib&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scenario(&quot;compr-multifd-compression-=
zstd&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd=
=3DTrue, multifd_channels=3D4, multifd_compression=3D&quot;zstd&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scenario(&quot;compr-multifd-compression-=
qpl&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd=
=3DTrue, multifd_channels=3D4, multifd_compression=3D&quot;qpl&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scenario(&quot;compr-multifd-compression-=
uadk&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd=
=3DTrue, multifd_channels=3D4, multifd_compression=3D&quot;uadk&quot;),<br>
&gt; +=C2=A0 =C2=A0 ]),<br>
&gt;=C2=A0 ]<br>
&gt; diff --git a/tests/migration/guestperf/engine.py b/tests/migration/gue=
stperf/engine.py<br>
&gt; index 608d7270f6..883a7b8ab6 100644<br>
&gt; --- a/tests/migration/guestperf/engine.py<br>
&gt; +++ b/tests/migration/guestperf/engine.py<br>
&gt; @@ -31,6 +31,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;..&#39;, &#39;..&#39;, &#39;.=
.&#39;, &#39;python&#39;))<br>
&gt;=C2=A0 from qemu.machine import QEMUMachine<br>
&gt;=C2=A0 <br>
&gt; +# multifd supported compressoin algorithms<br>
<br>
compression<br>
<br>
&gt; +MULTIFD_CMP_ALGS =3D (&quot;zlib&quot;, &quot;zstd&quot;, &quot;qpl&q=
uot;, &quot;uadk&quot;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class Engine(object):<br>
&gt;=C2=A0 <br>
&gt; @@ -205,6 +207,16 @@ def _migrate(self, hardware, scenario, src, dst, =
connect_uri):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D dst.cmd(&quot=
;migrate-set-parameters&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd_channels=3Dscenario._multifd_chan=
nels)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if scenario._multifd_compre=
ssion:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if scenario._=
multifd_compression not in MULTIFD_CMP_ALGS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 raise Exception(&quot;unsupported multifd compression &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;algorithm: %=
s&quot; %<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scenario._multifd_=
compression)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D src.=
command(&quot;migrate-set-parameters&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 multifd_compression=3Dscenario._multifd_compression)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D dst.=
command(&quot;migrate-set-parameters&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 multifd_compression=3Dscenario._multifd_compression)<br>
<br>
Should these be src.cmd() and dst.cmd()?<br></blockquote><div><br></div><di=
v><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"=
gmail_default">Yes, =C2=A0I&#39;ll fix it in the next version.</div></div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default">Thanks for pointing out the low-level mistake I made. :(</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if scenario._dirty_limit:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not hardware._dirty=
_ring_size:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Ex=
ception(&quot;dirty ring size must be configured when &quot;<br>
&gt; diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/g=
uestperf/scenario.py<br>
&gt; index 154c4f5d5f..4be7fafebf 100644<br>
&gt; --- a/tests/migration/guestperf/scenario.py<br>
&gt; +++ b/tests/migration/guestperf/scenario.py<br>
&gt; @@ -30,7 +30,7 @@ def __init__(self, name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0au=
to_converge=3DFalse, auto_converge_step=3D10,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
mpression_mt=3DFalse, compression_mt_threads=3D1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
mpression_xbzrle=3DFalse, compression_xbzrle_cache=3D10,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd=
=3DFalse, multifd_channels=3D2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd=
=3DFalse, multifd_channels=3D2, multifd_compression=3D&quot;&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di=
rty_limit=3DFalse, x_vcpu_dirty_limit_period=3D500,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vc=
pu_dirty_limit=3D1):<br>
&gt;=C2=A0 <br>
&gt; @@ -61,6 +61,7 @@ def __init__(self, name,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._multifd =3D multifd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._multifd_channels =3D multifd_c=
hannels<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._multifd_compression =3D multifd_com=
pression<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._dirty_limit =3D dirty_limit<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._x_vcpu_dirty_limit_period =3D =
x_vcpu_dirty_limit_period<br>
&gt; @@ -85,6 +86,7 @@ def serialize(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;compression_xbzr=
le_cache&quot;: self._compression_xbzrle_cache,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;multifd&quot;: s=
elf._multifd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;multifd_channels=
&quot;: self._multifd_channels,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;multifd_compression&q=
uot;: self._multifd_compression,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dirty_limit&quot=
;: self._dirty_limit,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;x_vcpu_dirty_lim=
it_period&quot;: self._x_vcpu_dirty_limit_period,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vcpu_dirty_limit=
&quot;: self._vcpu_dirty_limit,<br>
&gt; @@ -109,4 +111,5 @@ def deserialize(cls, data):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;compression=
_xbzrle&quot;],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;compression=
_xbzrle_cache&quot;],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;multifd&quo=
t;],<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;multifd_channels=
&quot;])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;multifd_channels=
&quot;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;multifd_compress=
ion&quot;])<br>
&gt; diff --git a/tests/migration/guestperf/shell.py b/tests/migration/gues=
tperf/shell.py<br>
&gt; index c85d89efec..1452eb8a33 100644<br>
&gt; --- a/tests/migration/guestperf/shell.py<br>
&gt; +++ b/tests/migration/guestperf/shell.py<br>
&gt; @@ -130,6 +130,8 @@ def __init__(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store_true&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&quot;--multifd-=
channels&quot;, dest=3D&quot;multifd_channels&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D2, type=3Dint)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&quot;--multifd-compr=
ession&quot;, dest=3D&quot;multifd_compression&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D&quot;&quot;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&quot;--dirty-li=
mit&quot;, dest=3D&quot;dirty_limit&quot;, default=3DFalse,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store_true&quot;)<br>
&gt; @@ -166,6 +168,7 @@ def get_scenario(self, args):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 multifd=3Dargs.multifd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 multifd_channels=3Dargs.multifd_channels,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 multifd_compression=3Dargs.multifd_compression,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dirty_limit=3Dargs.dirty_limit,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 x_vcpu_dirty_limit_period=3D\<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default"></div><div style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Y=
ong</div><br></div><div><br></div><span class=3D"gmail_signature_prefix">--=
 </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><fo=
nt face=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--0000000000006e6786061f0e5ad9--

