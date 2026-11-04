Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402C606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpTRlLVO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXn6-0008Jj-T6; Wed, 04 Nov 2026 05:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1xOXn2-0008J5-TC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:00:21 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1xOXn0-0003ma-6m
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:00:20 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37E904122B;
 Wed,  4 Nov 2026 10:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00B71F0093A;
 Wed,  4 Nov 2026 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793786412;
 bh=aF4COJtrQLQKNdG7Snaa2/jd7uhD0qQJRhaLuDlQTTs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=NpTRlLVOyvX5934vFBbtXEMTlkCIQ+sJoUSkBchhCJXWlw0LN+g2+J9gG1KnoBfZt
 mDWe5ilFaONYdrTtFOmltuDxVHeFSMup051D6R3osbtxs2zrUIOUIWP9oMkbzFNk7E
 OAGVib2SfDJcdontT/fe4u21LJJCP/cXW7ECuSAszDrfIxW3Qv4J8w4RzZrygowCpN
 OD2uHA8e2X7sp/I0QBAP6CPuq1fghCe08hvDrdpcIN13ct9cwBAxVdr8bADev2UAPY
 /qv0XdF/xWbXgrZgc3OVfGh/HVVS4DDi0y4pR1Y/zHzC446H8D58GXVK/zp0O2/4zj
 s58HzGts5WJxA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id DC6DD198003A;
 Wed,  4 Nov 2026 05:00:09 -0500 (EST)
Received: from ams-imap-11 ([10.64.2.31])
 by ams-compute-02.internal (MEProxy); Wed, 04 Nov 2026 05:00:09 -0500
X-ME-Sender: <xms:JwLralufdWYrKR5oxMcdFriGXBydS2eZuTqynNBXLxyV4uHOMNclxQ>
 <xme:JwLrapRvs_p-NplHZZMALbQwtAzdLyu_Q_lp7pBzN5lTcWBqE_jEi2quOpr65MA6F
 F-j0UQBVsPYiTHJhGVmaUgEVNLvM5nPNHlu60Ccx6q4yM145n5g9Q>
X-ME-Proxy-Cause: dmFkZTF6qZA+ncsIoxVC7ekEU5FVBWnpmpwDeeq+KF2AMKeLA7XIViqLbq+03dRzsqV1qH
 hK0xkQwWHTCkWFfo/GIwQ8S7mxFm28QyKTKb75Jt0/b3fv+J+tCt96ldIB7SbtShQrnIWh
 WhEMwef1996p9HdecmWH30LPv49/p7bVAbtfaGmCjNg3yfhporjEfnx55fi+0gOTtojLIz
 4+Z/e/NVcrPyt2aDE9PMweb/kazkMgZdhr5UXfK40PX6ntS7XaPYUGYvlCfRAfDhoN57ax
 6EulbXHUw+J5qQGV5sW4wetpkaqyj0s8YtgZdctJhcerwaEycCEzqKvZE6I2b0CD4ONnWn
 8NlQ/MBPJ3SvR6blbqjW3U6ECE0vEk5BD1cwbCwXrzW+EOUt89ZWs4LyJZP5Nfn5BWwpWJ
 uQ3Z9q08Y0IxyIMNsPGaKtYFU1To3vG9BVTpCDB+2oqFeL9+AGay5LNZzH0/a2f38okzXk
 BFcD/BplbYHzF+Tt9CyRqh0tjC+j7G+bQQzWqkSEtPDstqzXUzKg31uTYkBqIJXJyXvVUG
 HXAgePO7jSvOFSQLs5i5XDsrdCUU4wZjaLA+Cuix2/9o9yaKCxBdnxdvw5DzYN3Fp9880E
 iZKszKHNSbbIJHVhZGFPIyADUy2bvec4512fzBlV+ai7UDRUc7nhnTlVZ8Dg
X-ME-Proxy: <xmx:KQLratalmWCvpBJ8hgIxC2qe_P0cOiOOEFJ8atm-SRPQ_RlmvKXr0g>
 <xmx:KQLraipmKgRqGvkI5xuXWkCHDeQ7FZyLmmY5D88D_qgXH9dL7XaJ5w>
 <xmx:KQLrapR_3W9SwsdQ4lAG-YQGl2AQSlec51c_Eg2YiHzjFnf4QMkdfA>
 <xmx:KQLrauocQ40Rx2e5f9Wg-jrvq63tYEsjbIGimdT2WyzeMKJweEuhzg>
 <xmx:KQLrar2mENVY0ExqroWnY_NfWkl8YEzM8DqYtGxvOgHRhIvWFtKtGco->
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 6ED6EF80096; Wed,  4 Nov 2026 05:00:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 10:59:47 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Tushar Dave" <tdave@nvidia.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, alwilliamson@nvidia.com,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Shameer Kolothum Thodi" <skolothumtho@nvidia.com>,
 "Gerd Hoffmann" <kraxel@redhat.com>
Message-Id: <f46e21c2-a0f3-460a-a7a3-eabf19b7d9cb@app.fastmail.com>
In-Reply-To: <20261102181241.3077981-4-tdave@nvidia.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
 <20261102181241.3077981-4-tdave@nvidia.com>
Subject: Re: [PATCH v2 3/5] hw/pci: add fixed BAR fw_cfg blob export
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31; envelope-from=ardb@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, 2 Nov 2026, at 19:12, Tushar Dave wrote:
> Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
> device and BAR information into the "etc/fixed-bars" fw_cfg file.
>
> The blob contains an entry for every PCI function with memory BARs.
> Each entry carries the device's vendor and device ID, whether it
> has a fixed BAR configuration, and its firmware device path. Fixed
> BAR entries also include the configured BAR address, size, and type
> information for each BAR.
>
> Document the format in docs/specs/pci-fixed-bars.rst.
>
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  docs/specs/index.rst           |   1 +
>  docs/specs/pci-fixed-bars.rst  |  75 ++++++++
>  hw/pci/meson.build             |   1 +
>  hw/pci/pci-fixed-bar-blob.c    | 308 +++++++++++++++++++++++++++++++++
>  include/hw/pci/pci-fixed-bar.h |  63 +++++++
>  5 files changed, 448 insertions(+)
>  create mode 100644 docs/specs/pci-fixed-bars.rst
>  create mode 100644 hw/pci/pci-fixed-bar-blob.c
>  create mode 100644 include/hw/pci/pci-fixed-bar.h
>
...
> diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
> new file mode 100644
> index 0000000000..dc94debfad
> --- /dev/null
> +++ b/hw/pci/pci-fixed-bar-blob.c
...
> +/*
> + * EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL's CheckDevice interfa=
ce
> + * (UEFI PI Spec 1.2 Vol 5) only passes VendorId/DeviceId/RevisionId/
> + * SubsystemVendorId/SubsystemDeviceId, no BDF =E2=80=94 so in EDK2 w=
e can't
> + * match a blob entry to a specific device directly using BDF. To work
> + * around that, we prepare the blob entries in the same order PciBusD=
xe
> + * discovers devices, so matching by VID:DID inherently works.

This sounds rather fragile.

Could you elaborate on what order this is, and why it is reasonable to
rely on that approach being stable?




