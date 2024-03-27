Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300DCD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpHqo-0003AN-D8; Tue, 26 Mar 2024 21:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rpHqn-00039v-3H
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:13:09 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rpHql-0000sk-5I
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:13:08 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 1315D11400F5;
 Tue, 26 Mar 2024 21:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 26 Mar 2024 21:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1711501986;
 x=1711588386; bh=duPM4l7vESI6W2wpgUYG6yFDLRrQw0j3QbzzhqkGPoI=; b=
 XUMS7BfJqc1oRqz15fu7rAlbhGdaGgYiIB/JyZRGJCsA/fCdYy2xLCGKHw4WHi3p
 5abMFAq+Ztstn7j1G3hfI4d06Me4Gqshv0M4d8MAkOJzCmLMCyqLnrSj1+5S1nis
 r4mIKk/q9HAEIz3I6lWgbSiWuZ+Dh1pOSphUL1fnE2ZagS8n6ZwoDOXydPCVcOVv
 A08Q7UpzIrTBi+QnYK20IkG2YIJhHYcVKr8IkYet6hWKVcEE/TLzzx4Y1D4SwtuN
 pYWbUBOkOcvVj17EqkZDtrsbiNw0POofGB/VH8BmlA79Wlg8thLxs3QxvkZBJjq4
 eX+aROXwf7wAJOzhHX4jcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1711501986; x=1711588386; bh=duPM4l7vESI6W2wpgUYG6yFDLRrQ
 w0j3QbzzhqkGPoI=; b=rNV+BPWovfV2TSrKVM0JPoIY3AdEdAEUBOnw434PCKG8
 hF2R4TnNDJXZ8qgqsCXOqMychXD0VZ/ZCsMRTwGngjBPY1N9b7EjPioZaZrU4vM8
 VOKXQgT8P12SSLysjy4BWXoYlXtKRIthjDJhXPN5I0Km8KC9GVBBDYYf4WfnJ4rl
 feW5DjbiwA3LCvIJGXp0FCPuhmMbK78JX3lResk3anZI0mL7XtqVHqX8wdWxYRzC
 aI5lY8qHkHwmD1V8RGtS1XFlBfoAV+MkV3C19okIMAG0lCf7gzEVWobUQnai4T/Z
 oGEdZ8gyvOnjdAR4Fx7bc909mThk4BRZuucHTNHVFg==
X-ME-Sender: <xms:oXIDZgatEUoV61h3-u018HcyIEzG_ZmOll4ij3m4oDvc_mgp7gKrKQ>
 <xme:oXIDZrYreGi78Adqr8rNNaz2kLY8kBuzfj7YTL_tDCJutM7REQBPXndx8pGibgBHp
 Jdzu8maCQLnqA>
X-ME-Received: <xmr:oXIDZq94mIn3YI-U6iJLJZ0n_GEc2HIh_7khCgIogPxwbiuJx9nN7vtOFEV77-FZkuJRxoWwkNfOgx_Bi8T5jtZeGN6ZhrUExw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
 khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
 hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfdu
 leetfeevhfefheeiteeliefhjefhleduveetteekveettddvgeeuteefjedunecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
 sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:oXIDZqoIkNqMIvbnSF-p6uZ204bNYJjxVREhCSf4cYx16_wzXN3sHQ>
 <xmx:oXIDZrowGBwHXlwODyHLjRpSMxFD10CWA0vtB3Q_GSmrh2_G04qGaw>
 <xmx:oXIDZoR3cmpnX-u5o4ALpmwcbpbNKkaHJdjLvzHnfyHlKcnn1Y3Kbg>
 <xmx:oXIDZroMa0Kqhs5oxoYxuLtDcSlsuuTYdVl31UNzWLTnVnSsD3FoZw>
 <xmx:onIDZsdf_ENd3LGlxPLKhdn50VAIrSBClrGhXlYGEqyMCGysHii6CQ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 21:13:04 -0400 (EDT)
Date: Wed, 27 Mar 2024 02:13:02 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Anthony PERARD <anthony.perard@cloud.com>
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 1/2] hw/xen: detect when running inside stubdomain
Message-ID: <ZgNynlHAAuFA1vTy@mail-itl>
References: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
 <a6345b81-5c67-4c05-acff-f73ceea904ad@perard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L+9mmUR3Q4Dfquvs"
Content-Disposition: inline
In-Reply-To: <a6345b81-5c67-4c05-acff-f73ceea904ad@perard>
Received-SPF: none client-ip=103.168.172.156;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--L+9mmUR3Q4Dfquvs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2024 02:13:02 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Anthony PERARD <anthony.perard@cloud.com>
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Paul Durrant <paul@xen.org>,
	"open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 1/2] hw/xen: detect when running inside stubdomain

On Tue, Mar 26, 2024 at 05:06:50PM +0000, Anthony PERARD wrote:
> On Tue, Mar 05, 2024 at 08:12:29PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> > index 124dd5f3d6..6bd4e6eb2f 100644
> > --- a/hw/xen/xen-legacy-backend.c
> > +++ b/hw/xen/xen-legacy-backend.c
> > @@ -603,6 +603,20 @@ static void xen_set_dynamic_sysbus(void)
> >      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
> >  }
> > =20
> > +static bool xen_check_stubdomain(void)
> > +{
> > +    char *dm_path =3D g_strdup_printf("/local/domain/%d/image", xen_do=
mid);
> > +    int32_t dm_domid;
> > +    bool is_stubdom =3D false;
> > +
> > +    if (!xenstore_read_int(dm_path, "device-model-domid", &dm_domid)) {
> > +        is_stubdom =3D dm_domid !=3D 0;
> > +    }
> > +
> > +    g_free(dm_path);
> > +    return is_stubdom;
> > +}
> > +
> >  void xen_be_init(void)
> >  {
> >      xenstore =3D qemu_xen_xs_open();
> > @@ -616,6 +630,8 @@ void xen_be_init(void)
> >          exit(1);
> >      }
> > =20
> > +    xen_is_stubdomain =3D xen_check_stubdomain();
>=20
> This isn't really a backend specific information, and xen_be_init() is
> all about old backend implementation support. (qdisk which have been the
> first to be rewritten doesn't need xen_be_init(), or shouldn't). Could
> we move the initialisation elsewhere?

I can try to move it, sure.

> Is this relevant PV guests? If not, we could move the initialisation to
> xen_hvm_init_pc().
>=20
> Also, avoid having xen_check_stubdomain() depending on
> "xen-legacy-backend", if possible.
>=20
> (In xen_hvm_init_pc(), a call to xen_register_ioreq() opens another
> xenstore, as `state->xenstore`.)

And xen_register_ioreq() calls xen_be_init() anyway, so it wouldn't
change much in practice (at least for now)...

> (There's already been effort to build QEMU without legacy backends, that
> stubdom check would break in this scenario.)

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--L+9mmUR3Q4Dfquvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmYDcp4ACgkQ24/THMrX
1yxUTwf9GlCojUIfNlirgs+bpCQz7TgUrggQ4b7Pspee9vb/Eer1+K6qseZ9wyNj
s15Pjnp+BjHBeisOJ1a5QP0JZ/eqzm1ygdRDzkNgLjLUn0SwT+v1BqWSgGLGDIFg
l28LFGFWaWwauzehqi8v8uoQxJrlGksAEpHZaKumd2DniCw1TJHX832oz5Nlxhhx
ND1OkAQYDyf6VpW8VpJP7R+eM/A6sMGCkDRaoQGmRNeszAsEaM5vXYb9I1A5mKAR
S+Hjp4GF4mSshXfKQozp92CCjIF+rOFaDeaMUsyuNQybtHWVxVFFAmPSW0xpecDq
Jz49s+i/TPT79jUnVWmkMfpng6x4dg==
=kQYH
-----END PGP SIGNATURE-----

--L+9mmUR3Q4Dfquvs--

