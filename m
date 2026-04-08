Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE410F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYR0-0006z9-2X; Wed, 08 Apr 2026 15:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wAY0O-0005Nw-Er; Wed, 08 Apr 2026 14:52:00 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wAMT0-0002v4-OD; Wed, 08 Apr 2026 02:32:48 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 3C3ACEC00A7;
 Wed,  8 Apr 2026 02:32:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 02:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1775629963; x=
 1775716363; bh=6sgWx8YzUsHjBd1/s/nvSSHgBxfyDiPlpUjgjITEFrY=; b=a
 DPN4tSl68lERFVB8W0BqJdzJ1/9EpWLu1QDkcsYTskANY9FesbQVYz4jFysxCw+y
 02uNfQEmztZgas83iCrjZ2il6b88uqNhr8TwyQ4IAsxAPW5YdgkhdXK873rRzOrU
 UF3s7e9tlRS36zp7I/c+A9EblEUSwxW4j0UNktJ/1djN+kIfFjQeh/HBJNAs+8Ks
 COivPIULzwKMotVd3/ndrCJGmrlUjRJrBkutqsbTGl7Z39ccN2bBtBE07y6itjw7
 Bo8MOpoimvdfth8VLAmXDbOgWFW8HfZ5rA4BNEvbpumHONlbBXPo2jB/s9WDfplu
 b6QLf2DCEw6YHFroYnW4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1775629963; x=1775716363; bh=6sgWx8YzUsHjBd1/s/nvSSHgBxfyDiPlpUj
 gjITEFrY=; b=QOjwt3BqGjuZK8tWuJFe2mQNPECfCaZztaVx9wPG5e+g07r2kHl
 PlJDwcyVCWSks9OgaAMJwByIuvLUIQbL8BAlLUKML/E13PuIE7KnjQ3iH8P99/Bn
 Z2w4rtgycDUTTrWRjLz7urpxyzI09prMcHwDkuzdZq9H6WJVbEzhQK/kA03iNaFg
 Dao9YWDliWTpn9IlvgW+YSGKsQ/guZEfewNE+A4z6AagoXbSssQLv4uADw2O87I3
 W1imoNmgdn52YTS0taz/ls0qquf0aPA6uZD/tsYKTrMfdPNBhEZ4YfDlFbxrcbd5
 h3ibnJ1AROLuygiQndyAI+4BqTh55AKqBRA==
X-ME-Sender: <xms:ifbVabV-ANH4koEJ7bG1z--v1o0u00IQBQyHJrXsYlQyD8lWOw4oew>
 <xme:ifbVaZLwm-cn_QXxtUZC_ioUhMIOIZLJYpFFoMFOo7qIU2p9fqdcQLrandHW1y9LA
 wlIka69stU5sZKff_wEJKv87oz9Cfwi635XI5MYz9OEwMdNQLwFosk>
X-ME-Received: <xmr:ifbVaQ8ici6TcVzCG_NIt58h3-D2Bkf100lZ9Xb2lFDZyDiXDYuHKEC5NXgT_bTOU3N0rdkYK_HyDz_ttH_e2YHdZHrVNrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvdekiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhesmhhihhgrlhhitgihnhdrtghomh
 dprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 qhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrgi
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrrhhoshgrshesshhushgvrdguvgdp
 rhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehsthhgrh
 grsggvrhesshhtghhrrggsvghrrdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghk
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehhrhgvihhtiiesrhgvughhrghtrdgtoh
 hm
X-ME-Proxy: <xmx:ifbVaXM4jJioA24-QLKV2dTRrqbmw90pZVH1-6aEKdik6PDhqWoQTg>
 <xmx:ifbVac12aygcrIAaAXSkanT7SyN6C32BvKLgn8feKRGo3PO2guXSzA>
 <xmx:ifbVaQcP4N5zR3T5itAqF8wkkPUb8rkOwYJlM7vthPCzIbd1fJTBnw>
 <xmx:ifbVadbtWe92kX9okso_0JJO3Ea6XrBbeGweB9DBz5byAoXnNBOLUw>
 <xmx:i_bVaR7P4xbRTTwVTcLoj3yv6YL44bzwkBrSRoxMApRMICTD-v3kltWU>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 02:32:40 -0400 (EDT)
Date: Wed, 8 Apr 2026 08:32:38 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 5/8] hw/nvme: add migration blockers for non-supported
 cases
Message-ID: <adX2hv2WOpt9ZFzJ@AALNPWKJENSEN.aal.scsc.local>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-6-alexander@mihalicyn.com>
 <20260407153426.GA238768@fedora>
 <CAJqdLrpzZjs0Zf52sB0R149D6hCVYEDqAW36BYAaPW+uhK=g6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3S01q7me0hliNLUy"
Content-Disposition: inline
In-Reply-To: <CAJqdLrpzZjs0Zf52sB0R149D6hCVYEDqAW36BYAaPW+uhK=g6A@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--3S01q7me0hliNLUy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  7 20:39, Alexander Mikhalitsyn wrote:
> Am Di., 7. Apr. 2026 um 17:34 Uhr schrieb Stefan Hajnoczi <stefanha@redha=
t.com>:
> >
> > On Tue, Mar 17, 2026 at 11:27:05AM +0100, Alexander Mikhalitsyn wrote:
> > > +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_=
dev, Error **errp)
> > > +{
> > > +    uint64_t unsupported_cap, cap =3D ldq_le_p(&n->bar.cap);
> > > +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] =3D "";
> > > +    bool adm_cmd_security_checked =3D false;
> > > +    bool cmd_io_mgmt_checked =3D false;
> > > +    bool cmd_zone_checked =3D false;
> > > +
> > > +    /*
> > > +     * Idea of this function is simple, we iterate over all Command =
Sets and
> > > +     * for each supported command we provide a special handling logi=
c to
> > > +     * determine if we should block migration or not.
> > > +     *
> > > +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is al=
ways
> > > +     * available to the guest, but if there is only 1 namespace, the=
n it is
> > > +     * safe to allow migration, but if there are more, then we need =
to block
> > > +     * migration because we don't handle this in migration code yet.
> >
>=20
> Hi Stefan,
>=20
> first of all thank you for looking into my patchset.
>=20
> > What would be required to migrate multiple namespaces?
>=20
> It should not be very complex, and starting from v4 I've added
> VMStateDescription for nvme_ns, but I'm trying
> to be extremely careful here, and keep patchset as small as possible
> (and easy to review), because I it is my first
> contribution to QEMU and I'm newbie with NVMe protocol. I wanted to
> avoid any non-absolutely-required features
> on the first approach and then add all extras after and on-demand.
>=20
> My current understanding is that to support multiple namespaces we need:
> - VMStateDescription for nvme_ns [ done ]
> - add logic to handle (NvmeCtrl)->namespaces field and save info about
> attached namespaces
>   to some temporary field (use VMSTATE_WITH_TMP?)
> - on restore we should iterate over namespaces attached and call
> nvme_attach_ns(n, .)
>=20
> Feels like this is it, but I can miss something. Please, let me know
> if you believe that implementing this is absolutely
> required and I'll look closer and add this in v6.
>=20

I do not think multi-ns support is a hard requirement. Multi namespace
support is among the features that are mainly used for driver/host
test and verification purposes.

--3S01q7me0hliNLUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnV9oQACgkQTeGvMW1P
DekRzwf+PTMf6ZJJuEms+detZgmHBwcev9L5Et6V6xyu9MPFzntE+OB+azdWPQiG
KoxKi4snan99i+4Mqu3UHgxTVde+TzA4Yx1I/Mr1wxSBaNlSbN2Y9WqCZtSWECao
dBTrHFt20vmXVmFzKLVipwB2Se+oQWU4D12Hlmz/bVGAIprxQAwYk2S9fATHIgqd
yV9/WL+lfsl0Mgu9ysMpP6tCDSWE4diAHyB3a8SzHE6aFIYmd+S2o3ZT/dF3bHHK
WIHmKEH6YPagzKBiaDqlClwUuKJmJndViQ3vzHsiWkrgrxUZikWEDxqCM3/j9Dsq
UaiKTnL65W44tx4R7im7Um3MWbUGfw==
=sKm1
-----END PGP SIGNATURE-----

--3S01q7me0hliNLUy--

