Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC49C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokUH-0007w1-Jw; Mon, 25 Mar 2024 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokUE-0007fM-Ey; Mon, 25 Mar 2024 09:35:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokUA-0007nl-KL; Mon, 25 Mar 2024 09:35:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V3DTC1k1tz4wcq;
 Tue, 26 Mar 2024 00:35:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3DT66mvcz4wyg;
 Tue, 26 Mar 2024 00:35:22 +1100 (AEDT)
Message-ID: <9268c807-27f4-4c50-bb08-8bb97f0d84fe@kaod.org>
Date: Mon, 25 Mar 2024 14:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw/pci: Set write-mask bits for PCIE Link-Control-2
 register
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-10-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240321100422.5347-10-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=rDMc=K7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/21/24 11:04, Saif Abrar wrote:
> PHB updates the register PCIE Link-Control-2.
> Set the write-mask bits for TLS, ENTER_COMP, TX_MARGIN,
> HASD, MOD_COMP, COMP_SOS and COMP_P_DE.


You should resend this patch independently of the PowerNV PHB changes.


Thanks,

C.



> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> ---
>   hw/pci/pcie.c                             | 6 ++++++
>   include/standard-headers/linux/pci_regs.h | 3 +++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6..e3081f6b84 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -212,6 +212,12 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
>   
>       pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
>   
> +    pci_set_word(dev->wmask + pos + PCI_EXP_LNKCTL2,
> +            PCI_EXP_LNKCTL2_TLS | PCI_EXP_LNKCTL2_ENTER_COMP |
> +            PCI_EXP_LNKCTL2_TX_MARGIN | PCI_EXP_LNKCTL2_HASD |
> +            PCI_EXP_LNKCTL2_MOD_COMP | PCI_EXP_LNKCTL2_COMP_SOS |
> +            PCI_EXP_LNKCTL2_COMP_P_DE);
> +
>       if (dev->cap_present & QEMU_PCIE_EXTCAP_INIT) {
>           /* read-only to behave like a 'NULL' Extended Capability Header */
>           pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index a39193213f..f743defe91 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -694,6 +694,9 @@
>   #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
>   #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>   #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
> +#define  PCI_EXP_LNKCTL2_MOD_COMP	0x0400 /* Enter Modified Compliance */
> +#define  PCI_EXP_LNKCTL2_COMP_SOS	0x0800 /* Compliance SOS */
> +#define  PCI_EXP_LNKCTL2_COMP_P_DE	0xF000 /* Compliance Preset/De-emphasis */
>   #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
>   #define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */


