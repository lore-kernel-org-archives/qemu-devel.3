Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AABACCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 06:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHzFa-0002AU-DQ; Sun, 09 Nov 2025 01:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leon@kernel.org>) id 1vHzFU-00029V-EX
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 01:50:04 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leon@kernel.org>) id 1vHzFR-0001tI-9h
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 01:50:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D8DD56013A;
 Sun,  9 Nov 2025 06:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D66C19421;
 Sun,  9 Nov 2025 06:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762670991;
 bh=KWjKsL/t4/pDdbL8K9CoHcg7VrrtMz6hNTfd9pwfdm4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=LmHdnSTlNgvhM9RI7zoQROm41vfWyAILI/RNlQmgb4h/qgA95Z0lt4kZoOsEu3nmU
 h4PQRcPZ+AQcVISm3vz5zPx9G7jndAzBljrl48ClqNLip+2Zz7I1YuKftgwLjLvusp
 TX7hsfhZdYTLSl9Km/WknW1CPO+hBMhbA3KtE47pr25/3kDf/ei9dB/p/FKolZfc5f
 hXk/aC9EC7Fe13JQTawmVXcJUZ56P0bEtT6rx/P+sJy8Nrk0dI8u5AqJqhqjy8A12F
 2rtVjE2DhWANHCBrq3AoOXnmicJ8yiS9H9bNiEAJabYe0Ku6dtJ1MzCn/fvydxZ25o
 IjOA+hVWffgkA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfauth.phl.internal (Postfix) with ESMTP id 46693F40068;
 Sun,  9 Nov 2025 01:49:50 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-04.internal (MEProxy); Sun, 09 Nov 2025 01:49:50 -0500
X-ME-Sender: <xms:jjkQaa8vgXVK01NT_JNzdf_aT_09RdzfF84dODaZ83HqFf02vxYqYQ>
 <xme:jjkQaVhbu6u1pgHeGsKtXLTYZV6BuPDeV8sy9eYXpYBOscZI26C5lZDCA1bvXi5Sy
 LPDwnv9BYEIK_NqcaD7_kuQ1BTGOi6y2o34COhQ64-9e2aaNv8hZBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleegjeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfnfgvohhn
 ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
 grthhtvghrnhepffegjefgueegffffjeevheektdekgeevheelvdekieehvdejvdejjefh
 hfelhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhh
 phgvrhhsohhnrghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonh
 eppehkvghrnhgvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhivhgvkhdrkhgrshhirhgvugguhiesih
 hnthgvlhdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtoheptghlghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:jjkQaWAOLfM3p8-chjZ-ZGjLeCAmYFBLSN124DLedXtZbe0y7KJmJA>
 <xmx:jjkQaXgfyOhSk0vFA1CzRJhV-zxULxczAAgOA-HXqJSGdFPWDaFtAA>
 <xmx:jjkQaelDBWp287IHBtpStzPvp0HwKwYIj3ro6PvRSCaR1o8yDPvw2Q>
 <xmx:jjkQaTpOLWGw_HWHHswpWJ1gpOYzDHYyID9kodeu_V_pQPEJ5YV8Pg>
 <xmx:jjkQaXGgSyu2mFX1tCuTiWZ2uFK7FtHE_iQX4yMC53uNzsj1A3asVBr6>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 104CD2CE0067; Sun,  9 Nov 2025 01:49:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AdR09-0D09f3
Date: Sun, 09 Nov 2025 08:49:28 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Vivek Kasireddy" <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: "Alex Williamson" <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Message-Id: <e546604c-d4fe-49f7-af50-faff53cde07b@app.fastmail.com>
In-Reply-To: <20251109053801.2267149-7-vivek.kasireddy@intel.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-7-vivek.kasireddy@intel.com>
Subject: Re: [PATCH v2 06/10] linux-headers: Update vfio.h to include
 VFIO_DEVICE_FEATURE_DMA_BUF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254; envelope-from=leon@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On Sun, Nov 9, 2025, at 07:33, Vivek Kasireddy wrote:
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  linux-headers/linux/vfio.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4d96d1fc12..bc11ca3663 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -1478,6 +1478,31 @@ struct vfio_device_feature_bus_master {
>  };
>  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>=20
> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
> + * regions selected.
> + *
> + * open_flags are the typical flags passed to open(2), eg O_RDWR, O_C=
LOEXEC,
> + * etc. offset/length specify a slice of the region to create the dma=
buf from.
> + * nr_ranges is the total number of (P2P DMA) ranges that comprise th=
e dmabuf.
> + *
> + * Return: The fd number on success, -1 and errno is set on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF 11
> +
> +struct vfio_region_dma_range {
> +	__u64 offset;
> +	__u64 length;
> +};
> +
> +struct vfio_device_feature_dma_buf {
> +	__u32	region_index;
> +	__u32	open_flags;
> +	__u32   flags;
> +	__u32   nr_ranges;
> +	struct vfio_region_dma_range dma_ranges[];

Not important comment at all, but in last versions of UAPI, this line is
struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
https://lore.kernel.org/kvm/20251106-dmabuf-vfio-v7-10-2503bf390699@nvid=
ia.com/T/#Z2e.:..:20251106-dmabuf-vfio-v7-10-2503bf390699::40nvidia.com:=
1include:uapi:linux:vfio.h

> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>=20
>  /**
> --=20
> 2.50.1

