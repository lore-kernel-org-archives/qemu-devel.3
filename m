Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF6C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokVU-0002Nv-3p; Mon, 25 Mar 2024 09:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokVJ-0002Mt-93; Mon, 25 Mar 2024 09:36:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokVH-0008CB-KM; Mon, 25 Mar 2024 09:36:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V3DVd1tR8z4wnq;
 Tue, 26 Mar 2024 00:36:41 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3DVY0Fnbz4wcq;
 Tue, 26 Mar 2024 00:36:36 +1100 (AEDT)
Message-ID: <785203a7-de49-430c-9494-d8b349920f91@kaod.org>
Date: Mon, 25 Mar 2024 14:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pnv/phb4: Set link speed and width in the DLP
 training control register
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-8-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240321100422.5347-8-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rDMc=K7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/21/24 11:04, Saif Abrar wrote:
> Get the current link-status from PCIE macro.
> Extract link-speed and link-width from the link-status
> and set in the DLP training control (PCIE_DLP_TCR) register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/pci-host/pnv_phb4.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 7b3d75bae6..6823ffab54 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -980,10 +980,27 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>           val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>           break;
>   
> -    /* Link training always appears trained */
>       case PHB_PCIE_DLP_TRAIN_CTL:
> -        /* TODO: Do something sensible with speed ? */
> +        /* Link training always appears trained */
>           val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +
> +        /* Get the current link-status from PCIE */
> +        uint32_t exp_offset = get_exp_offset(phb);
> +        uint32_t lnkstatus = bswap32(pnv_phb4_rc_config_read(phb,
> +                                exp_offset + PCI_EXP_LNKSTA, 4));
> +
> +        /* Extract link-speed from the link-status */
> +        uint32_t v = lnkstatus & PCI_EXP_LNKSTA_CLS;
> +        /* Set the current link-speed at the LINK_SPEED position */
> +        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
> +
> +        /*
> +         * Extract link-width from the link-status,
> +         * after shifting the required bitfields.
> +         */
> +        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> +        /* Set the current link-width at the LINK_WIDTH position */
> +        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
>           return val;
>   
>       /*


