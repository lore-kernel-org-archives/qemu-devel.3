Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8794BEED617
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1somty-0007ip-3p; Thu, 12 Sep 2024 12:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1somtv-0007Vq-27
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:42:36 -0400
Received: from fout5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1somts-0006KP-S8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:42:34 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 354D113801D1;
 Thu, 12 Sep 2024 12:42:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Sep 2024 12:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1726159350; x=1726245750; bh=gAGsFojtPc
 /D6PZ6n5BiEj/42ohemE77KDKvlXikntY=; b=AALXgUSDGFZrOZWWcTMhnZ+OY7
 A/MqqgsZOETlvsWQHuWtXueaerXCcwyHXSdo8SOA1yvnbmNToWtm1M57j2EivMTo
 T13ufmRVg8fJKA3K8mkv8G20v3m+Q/N32Ne8Ubl5+mpndMb/gEuSLtccjBaEZ+nr
 UHiMEU2qvvQhd4dvDZurfcejZ/WLeldn0yaEWyH3GrGI5LyF5ZHMrlaajT8xhQfn
 XJ7VYRg8XfBrEOQDaN+ejVVKKi1wqxt2GNnzvgSrN0SLD/pETEdLSyhOqMbf2XWQ
 oCJV2ljv/DwU0VEJYJsa+ab9L4yR0I1FsSazLUBDB0ApKGeS6rJ6HY9lreSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1726159350; x=1726245750; bh=gAGsFojtPc/D6PZ6n5BiEj/42ohe
 mE77KDKvlXikntY=; b=FeG/ywydQWf5hf/fQbfurmKI7e5VNEL15n6egMqN+5PK
 MZE0aYY3wjLNis89YmpRpztmflctlgTA9+DYkadeZ+K4Ua/Qn8vO6VLcgEuCtcPa
 PfV37WI49wAGoMzCeovNiJGN3fpwlPYEiSKyUrfzCyBKZnoDDTdjRKXEIaEHchQa
 piE+m/OUj8KvDiuaLPGRR+qJBsYscduZmvsvs5SoJ983BH0Kj+BK3IumtzL78jO0
 DLEdjGYKFxz1H0WAagUQWDf9q3Kfz5nGTwi6KBhenWbBQPHVXzIaxan+KwpscybA
 grIWSYirSuGnOhbNCJIyONxIObC0JrullBrKagGKGw==
X-ME-Sender: <xms:9RnjZgJW1Y3ZHrZfV-oqcj5LVZxX9dvz6UgdGzvaTkUBGJjdAK3TuA>
 <xme:9RnjZgKH6Vxk6GXCqwFEIwsfm81lQBTzT_K27nypuUaQdaiv8JyVudWtRgZmyy4qM
 ORNFoiqMVmmPBajGA>
X-ME-Received: <xmr:9RnjZgug8ocAf7VdM4k_JMC1ScgM3grKWvEY8zpoPRRWZFammDA4SpDuTTRNrnjsES4_LoHsqC0MOzd4O5EagqlIRag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedguddtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttden
 ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
 ftrfgrthhtvghrnhepieduffeuieelgfetgfdttddtkeekheekgfehkedufeevteegfeei
 ffetvdetueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehsthgvvhgvnhhsugestghhrhhomhhiuhhmrdhorhhgpd
 hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
 pegrvghsthgvvhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhm
 pdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhgrghrii
 grrhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehslhhpsehrvgguhhgrthdrtgho
 mhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:9RnjZtZyHze7saG1demyiA7fHDp9ZlHjuKIadR76VqWXbixliPVocg>
 <xmx:9RnjZnbtG2dEznxvyTnybxEKDr1jcvQLNYJZW3whbTeVcOXWLrhofA>
 <xmx:9RnjZpC76rt74xbWN-W0pnBQrcUEKGUBAIMvPzesUCbapjTva-CvAg>
 <xmx:9RnjZtbN0iKl3spfQh7qCA2KmXEwstJWPXH3iGQARo-q5mVO4TtfqA>
 <xmx:9hnjZhn17qMBUqjIGImRTEA5fTbeJqhHSBGAG791Y7EkLaTiMVIzWWoy>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 12:42:29 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
 id 552E7400DE978; Thu, 12 Sep 2024 18:42:27 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: slp@redhat.com, mst@redhat.com, stefanha@redhat.com, Stefano Garzarella
 <sgarzare@redhat.com>, david@redhat.com, stevensd@chromium.org,
 jasowang@redhat.com, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH 3/3] vhost_user.rst: Add GET_SHMEM_CONFIG message
In-Reply-To: <20240912144432.126717-4-aesteve@redhat.com>
References: <20240912144432.126717-1-aesteve@redhat.com>
 <20240912144432.126717-4-aesteve@redhat.com>
Date: Thu, 12 Sep 2024 18:42:24 +0200
Message-ID: <878qvwygb3.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.148; envelope-from=hi@alyssa.is;
 helo=fout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--=-=-=
Content-Type: text/plain

Albert Esteve <aesteve@redhat.com> writes:

> Add GET_SHMEM_CONFIG vhost-user frontend
> message to the spec documentation.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Alyssa Ross <hi@alyssa.is>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmbjGfAACgkQ+dvtSFmy
ccAweA//VubaARTLVCjSsNvLT4yOQXH6BJOJsyp9Gw/8Z82xFcr03JooIGXS11bR
kKb9sjofEcc0EdFND8qgZgR+9iP2BvkIXNJqZ04p/jdJm0GAtniigiuSObnpyJqi
A65ifvV536jKLLnb8qqd1KaUTHEnDOr4FiiyO72YEzo6d0xOHRIotK8xhOl3J0iM
MxB5arUUp1oO96N5lsQb3cJVqiZ4bHAEGL4pcaqNLKkPWAN9vkLDzQtA6gZWqcof
cEX+A8ro9nmSylDp6ju8hGeC9kh361qoQBUG67DmWL3assJm2AEj14CTmoQFw09V
wTM/sytY+aeew416Xe2k98o2RpbQKn5sZru5zNreN24sgQUX9i4R2u0A6aKb87yO
2GENJ034+ps3ADXOc5rzvQALixXiNm/hst3YAa/5UTjKPSgvo0U/4BTVCzQ5nmmG
5q6qHoxbtt3BPm9nNzboo/eIu0Vj7mSdH08zPvE2RupZX8ODt+niHDcfRve+lF39
U6TrQ7yYFA/V6+W0TAgxCTv9HXtoLdBp5CdNyW0x8kLDwchFLGR/cP2nX6R9JCzW
pbBRcdNCScmXc30ozDsGXlY49/fhkwVdVifnPMYFa3TVwoMVH0FI23NDNHzcrGAE
MvnoEe9zkBBsE1A6p4YQIrDOoYodlrraQlOps2yNIL2Ry+Tztyc=
=uahT
-----END PGP SIGNATURE-----
--=-=-=--

