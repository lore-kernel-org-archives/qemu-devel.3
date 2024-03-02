Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C289C5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 14:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgQV1-00083b-9O; Sat, 02 Mar 2024 09:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rgQUz-00083N-Er
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 09:38:01 -0500
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rgQUx-00075J-DA
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 09:38:01 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4A49813800AD;
 Sat,  2 Mar 2024 09:37:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sat, 02 Mar 2024 09:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1709390276; x=1709476676; bh=06ZJduLhoG
 QK20UMHoLZUla5w4XgeIwZJQcFmeWeZWo=; b=aYIxSilEJYiW9VyzuUquM+9gwf
 lLM12Zivj0zj9DckPc/0hYDS3djAVuQ5MVpfMlooeeyRyLrZmISfqwR/kzpLl7+i
 ncq9eNL+g3PEuQuwSn8O0VxBGMBREVXqh4Zp1ar84Ei+8vouNKbTTYaKHD5sN0R7
 TV05NvBbE7cWlJmvNqRz8fNiQeRth1Cr/w1OoutCifc2mSz/mQ6oUCCuGNo7vvj/
 +9bsy1QlpzQQwo0m3oauJfHB+YVc9kjhzZP6xRSW+e4pQRNFq8In58M7fQT85Xv2
 rvmkdXmWKj7EfdfZ0rBcET4YcilOOr0EXLYyn3iPPuTbt/OJxSdzBJVeVaVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1709390276; x=1709476676; bh=06ZJduLhoGQK20UMHoLZUla5w4Xg
 eIwZJQcFmeWeZWo=; b=YVFxZHGCYH7e371gWfEWu6w29Qo6RKkX14+rZM6Vu12w
 6LEbw8tTsZiWx3gc43uf+ZiLaUpUfTqZ2QUW//B80HhX4nHm3ghIifjZYrx3US+j
 F/ZrWMZxj2GeTj9CXo1Z1sIU2nMRu+Kr0SbbS2I4/iFWCrJ/wpqCT9pm2ppRzgqM
 bAHK4VVzz4RbhZpaSUkDGp7A6l8DkRgiu7P90eRdfLtxPntEOUvOcO5V3nEf3URJ
 iD69DFn8x0Z9WvxOI7M2st2OIldeJs85oIlik+ea/8l7PdC/5g3hX9Fri5jSALeu
 BVPzFY+osD2DhusrfsoQbML126un6v0rZuCQCwY9Bg==
X-ME-Sender: <xms:wznjZU0EPLoISSKPaL9O2dg9IWeQ-xLacE7jZaVGE5y9Gbu9gUYMXA>
 <xme:wznjZfEeXTwaFntXk_4dgF0kyxvxkDyiqbpedqjzos8htJJHQzFk7Y8BNnFcZ0Hht
 -nSGDGfTpsTbC6ChA>
X-ME-Received: <xmr:wznjZc4K_9hzrF5Xhf__an3c0-O5hsSS7Ike5_8zr8Q2ojnbrl_JwkErNf8VdkIoSWuxopLkMHyqBaEJW6ca1apy3NoJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheefgdeiiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeetke
 dvteejjeeiudehfeeijefhleffledvieejheekjeefffeuteevffduhfduteenucffohhm
 rghinhepghhoohhglhgvshhouhhrtggvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:wznjZd0ZGGcNYGtIUURdd6pucXGM0uUJyPKE53vjijEGu66RgLY30g>
 <xmx:wznjZXFVf0bhwx_vjUzbdM6CBxHSGcGGq1ffWppvw_PGDahax3HVNw>
 <xmx:wznjZW-DDa4bXQwslhapxQacw925ChfhQonQK4dEa2sODw5BVrATvg>
 <xmx:xDnjZXH_n4G3Rmr7_XkUpzORcFs4P_1_OUmTVHjMbf6mhljEyFrc4g>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Mar 2024 09:37:55 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 1EF25DD6A; Sat,  2 Mar 2024 15:37:53 +0100 (CET)
Date: Sat, 2 Mar 2024 15:37:53 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, 
 thuth@redhat.com, Andrew Walbran <qwandor@google.com>, 
 Frederick Mayle <fmayle@google.com>
Subject: Re: rutabaga 0.1.3
Message-ID: <ufctubdq3cyltmtgwc4ng2dn6akazaybqvz5f5a6pyvgwmsxw2@3kapq5mvvy7l>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
 <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
 <87msssmax4.fsf@alyssa.is>
 <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
 <CAAfnVBkk1QTAo4dT372QNFmWqFFG4TxM0OTv9XHQQf6fm11fag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lob5dt7ynjcoezoe"
Content-Disposition: inline
In-Reply-To: <CAAfnVBkk1QTAo4dT372QNFmWqFFG4TxM0OTv9XHQQf6fm11fag@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=hi@alyssa.is;
 helo=fout8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--lob5dt7ynjcoezoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gurchetan,

> >> > Would this be a suitable commit for the 0.1.3 release of rutabaga?
> >> >
> >> > https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf44138def886f47cb1c7c
> >> >
> >> > The gfxstream/AEMU commits would remain unchanged.
> >>
> >> That combination works for me.
> >
> > Just FYI, still working on it.  Could take 1-2 more weeks.
>
> FYI:
>
> https://android.googlesource.com/platform/hardware/google/gfxstream/+/refs/tags/v0.1.2-gfxstream-release
>
> https://android.googlesource.com/platform/hardware/google/aemu/+/refs/tags/v0.1.2-aemu-release
>
> https://chromium.googlesource.com/crosvm/crosvm/+/refs/tags/v0.1.3-rutabaga-release

Unlike the commit I tested for you, the commit that ended up being
tagged as v0.1.3-rutabaga-release doesn't work for me:

	qemu: The errno is EBADF: Bad file number
	qemu: CHECK failed in rutabaga_cmd_resource_map_blob() ../hw/display/virtio-gpu-rutabaga.c:655
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
	qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob() ../hw/display/virtio-gpu-rutabaga.c:723
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
	qemu: The errno is EBADF: Bad file number
	qemu: CHECK failed in rutabaga_cmd_resource_map_blob() ../hw/display/virtio-gpu-rutabaga.c:655
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
	qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob() ../hw/display/virtio-gpu-rutabaga.c:723
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
	qemu: The errno is EBADF: Bad file number
	qemu: CHECK failed in rutabaga_cmd_resource_map_blob() ../hw/display/virtio-gpu-rutabaga.c:655
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
	qemu: invalid resource id
	qemu: CHECK failed in rutabaga_cmd_submit_3d() ../hw/display/virtio-gpu-rutabaga.c:341
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x207, error 0x1200
	qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob() ../hw/display/virtio-gpu-rutabaga.c:723
	qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200

I bisected it to:

	commit f3dbf20eedadb135e2fd813474fbb9731d465f3a
	Author: Andrew Walbran <qwandor@google.com>
	Date:   Wed Nov 29 17:23:45 2023 +0000

	    rutabaga_gfx: Uprev nix to 0.27.1

	    The new version of nix uses OwnedFd in various places, which allows us
	    to have less unsafe code.

	    TEST=CQ
	    BUG=b:293289578

	    Change-Id: I61aa80c4105eaf1182c5c325109b5aba11cf60de
	    Reviewed-on: https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5072293
	    Auto-Submit: Andrew Walbran <qwandor@google.com>
	    Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
	    Reviewed-by: Frederick Mayle <fmayle@google.com>
	    Commit-Queue: Frederick Mayle <fmayle@google.com>

--lob5dt7ynjcoezoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmXjOb8ACgkQ+dvtSFmy
ccAshA/+Jq7WG6GGA8TTFyzLP6nUs2SvQ6IWqZT/V9FQk1LTL60ibqWkwfDMw3Fj
R9klplnRe+WKLXgdOUMrQI5kLtDp8fIJIw+Fjtxme7mHyty4UGwIhaPYqx1klXq1
SeV7xMiB15ieR1wzd3Vuj7oJ7IwFgV6ChBH6fUrWL+Se6X0ugpUBRScfSH/yIxD8
T0qVCvBbYyXHOe6JoY6nCp3gKPUFvR+SXXvor/Lmz51pCLDqXAC5nSekz6pMKuRq
IzQI4MlI0u9M5Y6/otKZdLfPCiEJEbbiT8gUndhG1K2cNf8Up051yEEY1OtKTPrx
bg6UJQEcGur7SATNHdiKLYkmnpuFPTH+NR1WVpbQiag/drMMPK4HViTVqD7qMxNr
XsLttFzv7woQvwiBadIg0AHfopwEiNMxPybJoXj3zwMvLMZmXx4Im2qp9EsbC9uQ
aEKtVsQmJrSegYVWZnyHlhHOii7LQH/fiRcwD9FFrJKLLXTBavQ+R0xkSTCk43a+
FEUOGwO/sRllergQHCVNffkKVrXf256gkcAI1cTQWyVieU0eOTC+2MKwiXBkFdCF
waWHdxXXcTBkJKW9QZPn7YpCv+8qJFISEAJVUW3YSm/6AemuJG7u2o3TjVAj3vjs
mK76E57RQKvgP8IExaJyAdZcf5srUrmBdYx0B1xi1Jo1x6PEcmw=
=s6nl
-----END PGP SIGNATURE-----

--lob5dt7ynjcoezoe--

