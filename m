Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83285C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgdu-0005Yw-3v; Mon, 12 Aug 2024 21:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgds-0005Qj-85; Mon, 12 Aug 2024 21:48:08 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgdq-0000Rl-Gn; Mon, 12 Aug 2024 21:48:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A5F60CE1153;
 Tue, 13 Aug 2024 01:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CACC4AF09;
 Tue, 13 Aug 2024 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723513682;
 bh=VkK9y3PftMujevNgRvLFeHhq9QPvuE6tdab0J9rfRrQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=uEeLSfLHcLEgcCu0BjrGZDwg1HpxlafoArMgDFX7h2PUDazcstMjFJVFo9gArJXH9
 AwU66a/gXHvf4ey3lfyNuynXq8IXsgRRihLrK4FBpZ/lm3STkUy8W8DU1Hzu2lAq/8
 KCzrRWXk9eS+WizWjlNg6bnW7O4gw9tpWKt6zp6F5OmKS/VK2psZ+01bv2B0d/wo4S
 ZUQ8sKnhyMGvK2hxoH1JvbHT4OxtEmrs7lCqljTelHTep9nEHkPbweg53AlXcl855i
 S3xYjYgQ8qXps0jq+zd8DblXZ7Ashp+HJxnlos8sg+t0l5SBqzys3gtlKKEs5w0tyg
 BEvEv7QJ5tLFw==
Date: Mon, 12 Aug 2024 18:48:00 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v1 06/10] hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
In-Reply-To: <20240812130606.90410-7-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408121812210.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-7-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Rename xen_arm.c -> xen-pvh.c to better express that this
> is a PVH machine and to align with x86 HVM and future PVH
> machine filenames:
> hw/i386/xen/xen-hvm.c
> hw/i386/xen/xen-pvh.c (in preparation)
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/meson.build              | 2 +-
>  hw/arm/{xen_arm.c => xen-pvh.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename hw/arm/{xen_arm.c => xen-pvh.c} (100%)
> 
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 0c07ab522f..769fe9ec1a 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -59,7 +59,7 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
> -arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
> +arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen-pvh.c'))
>  
>  system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
>  system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen-pvh.c
> similarity index 100%
> rename from hw/arm/xen_arm.c
> rename to hw/arm/xen-pvh.c
> -- 
> 2.43.0
> 

