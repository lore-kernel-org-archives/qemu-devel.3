Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F32F34C76
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKv1-00011h-8C; Mon, 13 Apr 2026 13:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wCKuw-00010R-Ow; Mon, 13 Apr 2026 13:17:46 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wCKuu-0004na-Hq; Mon, 13 Apr 2026 13:17:46 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id BFA56EC046A;
 Mon, 13 Apr 2026 13:17:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 13 Apr 2026 13:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1776100660; x=
 1776187060; bh=+v6r/Y+AI78jDBnyf+yWhBKEBztHpvqNMpgMzFSCets=; b=e
 pugcTyjWNqhRV9ZiN5XkfeAt/Bl46Cc+KgPh0m3IBVhKZFHlZ+28avhKqw2j8uat
 ZoKbUly7U8tIUQhL4r2jqlLMYbHbZgf+eEskKPi9nIINxlAzfkwpBqFSOahWlF04
 e2H4dD7cvu1mw+ndX1/YGZ904tlwMp9m8iH8mkFRrbcu6zYLU+tSBxVD7ClubhXS
 MRH1ghb+g3vWE6b+EosQDVraye7tADDhiYoFnHj0MQa/+lULDfWxFt8TeFdND5qG
 +zzJRj2JbWSlsm8IGbFxoXf3ARaq5M7aLr5WwDXtWC1VjWJbFBBVZZlmHp51rUeD
 DB2QN1KhS40u1dJGOicqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1776100660; x=1776187060; bh=+v6r/Y+AI78jDBnyf+yWhBKEBztHpvqNMpg
 MzFSCets=; b=pkWHKU0P/q6rPGaamP8jglvZwQ9bTZHeWR0Gx/HQ2OmxeZyC+Wo
 8ZfKjNHQE2Zj0GlE1/2k7p+T5HYb5RLZaa1hqltp4dH79I4gLpYuTcnyH7Qcnc3f
 89W2eT/zWWTbmvjRWV1uczmdxUORH4gTvvMnmYyVLMN5LlepakHibm/gUMmc5+Yx
 zYznealq+9txvHfc0+91LNx+h5/XDChIboGEiqnotMbWNDugglmJhugH8nGng2An
 mybtMMVNPQo/7Eqi5F/HU3Edo1PirV4EImEs9PTNfK9EWnHcW2+z4u66yELcrLiF
 jBpbe8heh9gnFuGsk18g2HM5XAsdRZnT5GA==
X-ME-Sender: <xms:MyXdaZySJSzWj-m6uWWmTvtw0QiUhwj0UTQ9wCE86e_fbHLJG4rMXw>
 <xme:MyXdaUOzt4xORLtTaV9V5r-tcXPRGSHgsfFDgabtgkp8PdE5r0hfebyZK75Dbrrgs
 Re6P3U9erCyljbyNQOJ0hgeQWpTHdpoh1dk1jwI65GvRZQvpqrvzvY>
X-ME-Received: <xmr:MyXdaSX8EV8uqBW2Z-_fctMyNSWH6w78KMKLdIj2DD8aAFWqVBgnRWqghBncbAi36stTbaUNvH45Fv1zHAkCEBIUoLEmxdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtreertd
 dtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgr
 nhhtrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehud
 ekveejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
 rghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtg
 hpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhthhhivghu
 sehmihhnihhordhiohdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghfrg
 hnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghtthhhihgvuhesmhhinhdr
 ihhopdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:MyXdaQ2eGyqbDExjunOd2IZjws7esSCL_ZAPe8VWYnzyVkWzCTHeJg>
 <xmx:MyXdaYrVAaOsv8XpqC15mcDvOAF6-18ej-EaISO3zaWBhyF2v6Yzig>
 <xmx:MyXdafVViSOcqWQ1s_kthZnZXXKmL3mzN-5Rvux6ai4XtbANIss-pQ>
 <xmx:MyXdabaLRIDApzjLu_h4BCzroWuo-XLC0MPDVgLz7GO9rxjLC6isMg>
 <xmx:NCXdaW8JyoMBy8OzNh6-XN6gMrniTAJjZoe-QWEFyA-fxY9GVh_fj6y8>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:17:39 -0400 (EDT)
Date: Mon, 13 Apr 2026 19:17:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org,
 stefanha@redhat.com, mr-083 <matthieu@min.io>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
References: <20260409060155.94704-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+LtPI+/KR3dtQlq"
Content-Disposition: inline
In-Reply-To: <20260409060155.94704-1-matthieu@min.io>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--d+LtPI+/KR3dtQlq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  9 08:01, mr-083 wrote:
> This series adds two features that together enable transparent NVMe disk
> hot-swap simulation in QEMU, matching the behavior of physical NVMe
> drives being pulled and reinserted in the same PCIe slot.
>=20

I don't understand this. From an NVMe perspective you can't hotplug a
namespace. You can hotplug a PCIe-based NVM Subsystem.

--d+LtPI+/KR3dtQlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmndJS4ACgkQTeGvMW1P
Dek9mQgAn8gS00VBPUBtna+HrfvjrI5+Z9UA04tLqFKFiPW2qm/VABMVL7pOxgb7
tz6iPhqEy0xF6puJzaGreSHZlGeNnb5chVApdwsadbb1k3eP4auYK6MpLwZpOkKv
I16x07d0p6IUjozeZ04UAw2h3fxGkpNVUsLx/67xPD3SDI+T/kTELz+P9MvmoPPz
bMPKIuBo25ljnSTsYiR35CHyGnYVTp2TtCu//WqAN9blQw1J6ZpHQkUfMlTFiHxM
uSa4N7yaDLApREcMGHNgvcNN5p6VshBF4FbItl7BkJ8m72V0h4PBblrFUSQzW1dy
Nr4kbiabBk26gIf4F7xEX8urPyQAXg==
=fLW2
-----END PGP SIGNATURE-----

--d+LtPI+/KR3dtQlq--

