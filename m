Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8DACCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 05:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBnW9-0001Tw-2i; Thu, 23 Oct 2025 01:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vBnW7-0001Tl-I3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:05:39 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vBnW4-0005FA-6l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1761195923; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lr7Eq0CN7STGVAT45Y6enwq1Q/aqTm8T8nSm0repgOOAtSwKHO/AHlgu+PvritZwBip168C1RU6bHmjJrU4Zq8igS6lryKYdJ5w+F2VMz+14Af/FzjECRQMh0dl1X8FanNCQzQmjVonGzfXXyZNtJAR4ux6qj20PkVk5f3AaOaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1761195923;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1orQPnKGbaNiBF/2I7mZ1emyF8LWwTslZaCnp025zJ8=; 
 b=iDGe2O866wuHlj1VhSynSG49QXBpipMQNW1xxdbjWkviZcxkJT7s9fiQn7B3I6G095X9v3z/5V+W6E41CovyGx4ilBvGxS9UvYUH3MM1mwBvslpS7wYLqYsD4ImoAoMmt8NbkYc7PNe5zSNFB3Blnj9/Z3LkbULu2c48E4QaumM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761195923; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1orQPnKGbaNiBF/2I7mZ1emyF8LWwTslZaCnp025zJ8=;
 b=VBFIkjcM8e2Nv7H8D5DE+gTv2JzeO9VWAZxkSyqwMrnW/PJC5B2sMR4sPX3WfFNO
 l4RTSyZgRWGZ3ZorOWfjF93ec1JiN8TywnPejwzCgaLgoHfAiItfnuAaTRSunaBq2fd
 CjRAErwzg8nwcQhCdxH2plu43u2FQ3P7Kz3DtlQY=
Received: by mx.zohomail.com with SMTPS id 17611959206571015.0268801890813;
 Wed, 22 Oct 2025 22:05:20 -0700 (PDT)
Message-ID: <2fdbe402-6f0d-417d-ab38-e7103fd759e2@collabora.com>
Date: Thu, 23 Oct 2025 08:05:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system: update rutabaga_gfx and gfxstream locations
To: Gurchetan Singh <gurchetan.singh.foss@gmail.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, aodaki@rsg.ci.i.u-tokyo.ac.j, hi@alyssa.is,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org
References: <20251023022611.11495-1-gurchetan.singh.foss@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20251023022611.11495-1-gurchetan.singh.foss@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/23/25 05:26, Gurchetan Singh wrote:
> Both rutabaga_gfx and gfxstream have moved to Github to facilitate
> faster iteration and greater open-source collaboration.
> 
> gfxstream requires a corporate CLA so it can use Google's CI/CD
> $$$.  rutabaga_gfx does not require a CLA, preferring to remove
> any possible barriers to a first-class FOSS solution.
> 
> Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
> ---
>  docs/system/devices/virtio/virtio-gpu.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
> index 0f4bb304a9..ff9d5a7103 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -119,7 +119,7 @@ Surfaceless is the default if ``wsi`` is not specified.
>         hostmem=8G,wayland-socket-path=/tmp/nonstandard/mock_wayland.sock,
>         wsi=headless
>  
> -.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
> +.. _gfxstream: https://github.com/google/gfxstream
>  .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
> -.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
> +.. _gfxstream-enabled rutabaga: https://github.com/magma-gpu/rutabaga_gfx
>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

