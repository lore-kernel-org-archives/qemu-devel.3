Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12948C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 00:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgZee-0004tJ-DE; Tue, 20 Aug 2024 20:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sgZec-0004qE-GV; Tue, 20 Aug 2024 20:56:50 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sgZeZ-00036K-WC; Tue, 20 Aug 2024 20:56:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5A97A60F81;
 Wed, 21 Aug 2024 00:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC82C4AF0F;
 Wed, 21 Aug 2024 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724201806;
 bh=iP+o8FjrkW5d8IANhD6wo3Kazu6e02UnaUSXg3Ib1MY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=OoEY54OXyjObjVuSMgqtFJw+/EIe5484piVfBINT8oGtG27p2BR0tx9cSSwJQJ2vq
 1ZHDBUW+tC5wVL5ZApWW7YiXtT5EyAeUgKppKLh/8CJhfuLpXmOoTkFdGybIy11GmQ
 aZtNPVAga6FFaaUZwUuoxrCAaOQ+NmqkRjI9ibuVdPMIVhQ0qCjjL1/k8TzVIy1KBA
 rD2Zsk+iE/B8oD+g41hGq8GTEVpyCSYTQy3z0v+Vo9GxsDxlZVs9rHNZGyJ31JrRxL
 RBvP+AM+6pks3qAbPC0iwRUBKVdc1irT2h7wZ5/7EEoNer6HjoBFQmAxXsuNiVcynY
 9TcTTIu9iWp8g==
Date: Tue, 20 Aug 2024 17:56:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 05/12] hw/arm: xenpvh: Remove double-negation in warning
In-Reply-To: <20240820142949.533381-6-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408201756360.298534@ubuntu-linux-20-04-desktop>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
 <20240820142949.533381-6-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, 20 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index fda65d0d8d..16b3f00992 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -165,7 +165,7 @@ static void xen_arm_init(MachineState *machine)
>      xam->state =  g_new0(XenIOState, 1);
>  
>      if (machine->ram_size == 0) {
> -        warn_report("%s non-zero ram size not specified. QEMU machine started"
> +        warn_report("%s: ram size not specified. QEMU machine started"
>                      " without IOREQ (no emulated devices including virtio)",
>                      MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
>          return;
> -- 
> 2.43.0
> 

