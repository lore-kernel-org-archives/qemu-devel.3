Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C448E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 10:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMOyi-0007ZM-Ee; Sat, 14 Dec 2024 05:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tMOye-0007Z1-Ag
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 05:02:24 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tMOyc-0007LT-N0
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 05:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=avn9XtisuL7tAyPLobM1wxfvnqKObU2fCxD70TgtdJM=; b=B4qV//zwBj/L9zA7a1Z/235vEz
 xpXIKxnczCtJjmm1n/au4mQQZcMjRzVZAln13FeZfjXPmFBrEvGHvsbh3z4fee1Emx1DJL9rQ/R5L
 EaVzORuNgoLv895GVmlPTLrnF5nJPa4UMVtaIl4ghWUvKIU9udo+z/L+QMHfskSebLZFPd+O8cPu2
 sFy8Xns45O9Rq6K7GiPYYXtoJ/2m1GmlfbbSIYffWxY+fX2SPVmPVMRwiy6RGN8ytJQ6bpzDs8WhQ
 Jjgjovyg0CfoQRjdq68HQ83ihZrzdSYE9Vh3bEC/SHuz+Kye5OKsJb3R2uf8p5MKeWJuV3puuG2SL
 mckCnqM5ZWgiW1mKBAa++Ak6T9nPPyNi6fELwp50Y2RndyDXhGFPR/det81mRI4RjTR8UZXH3nk7g
 ungAYkes4He+bX5c+yx3pMucNlh7je0UBmcNe15c04Sv8IQBq5xipRk5vrA1/tps7p9DoXQLcMKx3
 6BpqF8i+NzWiDMG3d/FMTMUpkuByNb459jFvUnXtrKUQ5W7bGeSdGg1lNPGoDeTMhMfdbbhjGLNHU
 uor5MgYkJF1dYrxXlJJG5h65pVytd2C4esaw4XcVG8vl5WNmf2qOhZe+nZd+pM7rcz/bBCDTVKY/u
 cdotGe4l0U98PqsRhvdsG8zwbcDR99slOROUfas5k=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 12/71] hw/9pfs: Constify all Property
Date: Sat, 14 Dec 2024 11:02:14 +0100
Message-ID: <1900893.3AEcekGzlK@silver>
In-Reply-To: <20241213190750.2513964-17-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-17-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Friday, December 13, 2024 8:06:46 PM CET Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  hw/9pfs/virtio-9p-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index efa41cfd73..b764e4cd3d 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -243,7 +243,7 @@ static const VMStateDescription vmstate_virtio_9p = {
>      },
>  };
>  
> -static Property virtio_9p_properties[] = {
> +static const Property virtio_9p_properties[] = {
>      DEFINE_PROP_STRING("mount_tag", V9fsVirtioState, state.fsconf.tag),
>      DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
>      DEFINE_PROP_END_OF_LIST(),
> 




