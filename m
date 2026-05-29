Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44636CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvw5-0006QM-9f; Fri, 29 May 2026 08:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wSvw3-0006PV-R3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:03:31 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wSvw2-0003MJ-6K
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:03:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F917414FD;
 Fri, 29 May 2026 12:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D751F00893;
 Fri, 29 May 2026 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780056208;
 bh=t32l5At9tpBuTtAd7B3nWvvcLnzUCU5BudMLxyBzFe0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=EuHLns4s4FHNz/YzwI1iSQY2nVUBvttbJPduGPhuo+/LasdM/UVlEc3ImbB1dyCu6
 68tASs0tMCpqabpA9BIHqHylvUOcyRiuaN3LbGtHq0NJ0Ij/Ehp6tusiie19hQ7k8h
 DCW6QxQq49pcug1JuWmeVd7pCjMyda0QpPXJfAAPgmzPSQybzn+ierg7Q7hXkhOo7j
 z/ArOkmDz0CCngW3BM1rj4ANACxluCzS9d83+fbju3kontI1mubtRTzX8yEp9pkI80
 ZHud61xQw8rqrjck9zGe291HP2rpUhEqaM9C7yxaL08wmp+SExvHSQl3i6YSmdC6Ez
 HhmreJUwCd86w==
Date: Fri, 29 May 2026 13:03:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Tao Tang
 <tangtao1634@phytium.com.cn>, Gustavo Romero <gustavo.romero@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/7] MAINTAINERS: Merge PCIe DOE section within SPDM
Message-ID: <20260529130319.1e9b2144@jic23-huawei>
In-Reply-To: <20260417110550.70068-4-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 17 Apr 2026 13:05:45 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> SPDM depends on PCIe DOE, so it makes sense to cover
> these files there. Cover the spdm.rst document. Add
> Tao Tang who volunteered to be designated reviewer:
> https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@p=
hytium.com.cn/

Other things depend on PCIe DOE - for instance the table
access stuff in CXL (that basically retrieves ACPI like tables from
devices) and they have no connection to the security use cases.
So from a logical structure point of view I'm not sure this makes
sense.

Mind you I'm fine with be being Alistair and Tao's problem!

Jonathan



>=20
> Cc: Tao Tang <tangtao1634@phytium.com.cn>
> Cc: Gustavo Romero <gustavo.romero@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 11bf50a9ecf..eccc0d64331 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2150,11 +2150,6 @@ F: docs/pci*
>  F: docs/specs/*pci*
>  F: docs/system/sriov.rst
> =20
> -PCIE DOE
> -S: Orphan
> -F: include/hw/pci/pcie_doe.h
> -F: hw/pci/pcie_doe.c
> -
>  ARM PCI Hotplug
>  M: Gustavo Romero <gustavo.romero@linaro.org>
>  L: qemu-arm@nongnu.org
> @@ -3693,11 +3688,15 @@ F: tests/qtest/*tpm*
>  F: docs/specs/tpm.rst
>  T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
> =20
> -SPDM
> +SPDM, PCIe DOE
>  M: Alistair Francis <alistair.francis@wdc.com>
> +R: Tao Tang <tangtao1634@phytium.com.cn>
>  S: Maintained
>  F: backends/spdm-socket.c
>  F: include/system/spdm-socket.h
> +F: include/hw/pci/pcie_doe.h
> +F: hw/pci/pcie_doe.c
> +F: docs/specs/spdm.rst
> =20
>  Checkpatch
>  S: Odd Fixes


