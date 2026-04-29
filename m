Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA1FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI34w-0002AY-1U; Wed, 29 Apr 2026 07:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wI34u-0002AB-Tf; Wed, 29 Apr 2026 07:27:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wI34t-0006rp-F7; Wed, 29 Apr 2026 07:27:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 32EC940440;
 Wed, 29 Apr 2026 11:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C339C2BCC4;
 Wed, 29 Apr 2026 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777462056;
 bh=Xq+n2bbiLDEKLGpiOU5SVgpFI+rU//O6b93BK78badw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jjoyoL+z6rpszkKXUzm+eYIPuElFAdq9H3fsZztRGrj2MZM/nXSOrcW0GSOKBHZ4r
 OAQ9rKA9zJwWc4qUnzTWP9MBFFUx2iMwdOMjTqaaeJgbcgA23PMkrfBiCDTtQVRH/h
 SMAi70zmo/4PnN+3bxbpJKCRn6y8cGOp3l79T9rYtcuKpaoJ6+NIkyJR/c01IGXBZ9
 u9gVBzRu0SNXKkh5OF+wm1hyXKdyP9u/tkejQ5D6OAuujSlzxkD/pRfZ8tqqTXFOg7
 Omrl1BjkdYsnoYNHTb9jOBBxvWU+EQ7pyCqEPbXVY8KRF/laVk2FTUKydRDgAMotje
 xOnERJY/hlllA==
Date: Wed, 29 Apr 2026 12:27:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>, Peter
 Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 02/16] hw/cxl: Define cxl_fmws_get_all_sorted() stub
Message-ID: <20260429122727.1c7d31a9@jic23-huawei>
In-Reply-To: <20260423170229.64655-3-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, 23 Apr 2026 19:02:14 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Add a stub for cxl_fmws_get_all_sorted() to fix building
> a QEMU configured with the '--without-default-devices' option:
>=20
>   Undefined symbols for architecture arm64:
>     "_cxl_fmws_get_all_sorted", referenced from:
>         _cxl_build_cedt in hw_acpi_cxl.c.o
>=20
> Note, the CXL <-> ACPI Kconfig relationship is a bit convoluted.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Acked-by: Jonathan Cameron <jic23@kernel.org>

>  hw/cxl/cxl-host-stubs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index c015baac813..9b515913ea4 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -18,3 +18,8 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
>  void cxl_fmws_update_mmio(void) {};
> =20
>  const MemoryRegionOps cfmws_ops;
> +
> +GSList *cxl_fmws_get_all_sorted(void)
> +{
> +    g_assert_not_reached();
> +}


