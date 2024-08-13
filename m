Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49440C531DD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgbs-0005bY-50; Mon, 12 Aug 2024 21:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgbq-0005VM-Lv; Mon, 12 Aug 2024 21:46:02 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgbn-00009j-Hj; Mon, 12 Aug 2024 21:46:00 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AE593614F9;
 Tue, 13 Aug 2024 01:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C6FC4AF09;
 Tue, 13 Aug 2024 01:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723513557;
 bh=c7qNRpyDUtvju/qAk+YMAJaPGvskpjD01S2agnEPCiQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ilrZNn1Te05ZkG2uzeYAKdlwv80dCsj2//lN8yzLyuVj3U/Qyj7iqwjWW4+6Ro42A
 IWzDqc2V3vtHcBfR1AoBMwl3cFrGLVP041j8EVPqhDA2yH+bq7agTFsbxsTqrx42tq
 DG3R1GKtLEIhbFK3vPbIDKPGuC0h3WW7ptTqKMpC/FU1a+bazY2t1lnkzKFQFFAJT9
 9t8u+tgiP3xY+tvMwjuW+BFptD2aFkutHgPHIestZf+yWGiqFAjvHK5wIaH3NWHvl9
 nuvaMGxA33Mh92kR7w62I+He8YnVAtNXACPTIA99bO8tTcbXotSTuuk4pEPTyA+pky
 fcVOQAqxDiLXw==
Date: Mon, 12 Aug 2024 18:45:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v1 03/10] hw/arm: xenpvh: Tweak machine description
In-Reply-To: <20240812130606.90410-4-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408121647440.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-4-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Tweak machine description to better express that this is
> a Xen PVH machine for ARM.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 766a194fa1..5f75cc3779 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -216,7 +216,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>  {
>  
>      MachineClass *mc = MACHINE_CLASS(oc);
> -    mc->desc = "Xen Para-virtualized PC";
> +    mc->desc = "Xen PVH ARM machine";
>      mc->init = xen_arm_init;
>      mc->max_cpus = 1;
>      mc->default_machine_opts = "accel=xen";
> -- 
> 2.43.0
> 

