Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF86CFC51D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 08:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMinA-0004Xu-6B; Sat, 22 Nov 2025 03:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vMhwx-0000qK-O9
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 02:22:40 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vMhwa-0001Ek-RA
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 02:22:25 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.9])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dD3Rs1Xlqz5w9L;
 Sat, 22 Nov 2025 07:21:44 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Sat, 22 Nov
 2025 08:21:43 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S00322e31a61-ac32-4874-9c79-5ca650d85bbf,
 BDE5E08CAA5430CDD034853EEFE7ADF510FDB634) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4a893b67-c457-47a5-87ca-c41c0a4df070@kaod.org>
Date: Sat, 22 Nov 2025 08:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 1/1] hw/pci-host/aspeed_pcie: Update ASPEED PCIe
 Root Port capabilities and enable MSI to support hotplug
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251121050108.3407445-1-jamin_lin@aspeedtech.com>
 <20251121050108.3407445-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251121050108.3407445-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 0ff04f64-22aa-4a0e-aa86-1bf2c87cfa1e
X-Ovh-Tracer-Id: 7244040004386982834
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGH6v95T7keEROrGFMTV1WVXfmCiamPW936P49pNYF8bJmaR+0VgpmSRxNrnZNqEXCLVE46Du0ctieMjfBfwVoFUoIHsW3CGunMY84ykB5AWMmqi7JPcuRDvOEZVQo9dnBpaPFKZGVKk4D7bSIHjPvyL/AoDggzR2jhqIBH3BSQ8YoaAtLXdaZSVTy3l0V1D10aY3dS/WTyIXhZsJ3BRMw7F8OD7O3sJ78fjwTpuPNOg+xEc+0qdEaYq3ZGqH6w76D+4u3gU7jzEU01JztSEm5uuC6AQ2tqmdoFkhCqOkT0uvSOsvgkHrffG+pWhuTiPOs2D3v9QYmWkEl7fSUktoGSsxTpgONqWzRpTNzYP1YYJmy32zB7dlOVYgcWwOxGESerRHq9UKWcok/+mm6ip8PTo7ohtG4nsR3aP3x9XAzWSDwhJRVaACFZkiZ91Tk/zLMnWjVwhupHrbgJMidHtk9/LRQYEfGy1KMf0CgrvysqHv19QHuYTzaNS+mO8iDEhsSPSfLgcX0P6fJmjSE+8/ufQyPyH2SFMNaKcTZYrrlHoAYszLJuianr4Q1eNgq8z9Mku26V1YqNnA4kajPzC/ZZqGh6QNmhsDxOndLBqOHP3PX1IuuAK29BLtyttILh9WbMKCVMc7eCmtcfZpTLHR8iVTA6nbaPdMFC6Rn7Xfjgow
DKIM-Signature: a=rsa-sha256; bh=xZGzjLqXk74K0JYHVocJhDdupdJvlc3jlXUjzNR7uls=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763796106; v=1;
 b=Uz/d9LnTJ7MhmBqKly5E0lb68OE4+wAPQGGPQdefWuIa+RdiB/kw+s5H2VVk8pB0ptYP+Gzy
 oWlfFdR5IPq9+B649S+RyPmNBYdLDhaZmsSN1g2pESgNskp92UyK0IMtwBbuVOXJnwSvvZtUzmj
 L4QfG/2TBJoq7zskoCIpsdyjK4SS5soRkLSlPDJfo37J05N4HPErqnJSCU+PoBF+c22zHVM1sCm
 zyTeeWnttk7gx2/uAQjXk8fRwj1W0QB4BK3QpwklhMhK7Kcgi58+4NClhUiEhIndgIE0Y+H/NZO
 ymTMLBODbtEkz+hGG/IXb8WmtfVJ2z5ZUtTFnDHBfvX9w==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 11/21/25 06:01, Jamin Lin wrote:
> This patch updates the ASPEED PCIe Root Port capability layout and interrupt
> handling to match the hardware-defined capability structure as documented in
> the PCI Express Controller (PCIE) chapter of the ASPEED SoC datasheet.
> 
> The following capability offsets and fields are now aligned with the actual
> hardware implementation (validated using EVB config-space dumps via
> 'lspci -s <bdf> -vvv'):
> 
> - Added MSI capability at offset 0x50 and enabled 1-vector MSI support
> - Added PCI Express Capability structure at offset 0x80
> - Added Secondary Subsystem Vendor ID (SSVID) at offset 0xC0
> - Added AER capability at offset 0x100
> - Implemented aer_vector() callback and MSI init/uninit hooks
> - Updated Root Port SSID to 0x1150 to reflect the platform default
> 
> Enabling MSI is required for proper PCIe Hotplug event signaling. This change
> improves correctness and ensures QEMU Root Port behavior matches the behavior
> of ASPEED hardware and downstream kernel expectations.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Fixes: 2af56518fa91 ("hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make address configurable")


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/pci-host/aspeed_pcie.c | 40 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index f7593444fc..1fc2c61772 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -68,6 +68,38 @@ static const TypeInfo aspeed_pcie_root_device_info = {
>    * PCIe Root Port
>    */
>   
> +#define ASPEED_PCIE_ROOT_PORT_MSI_OFFSET        0x50
> +#define ASPEED_PCIE_ROOT_PORT_MSI_NR_VECTOR     1
> +#define ASPEED_PCIE_ROOT_PORT_SSVID_OFFSET      0xC0
> +#define ASPEED_PCIE_ROOT_PORT_EXP_OFFSET        0x80
> +#define ASPEED_PCIE_ROOT_PORT_AER_OFFSET        0x100
> +
> +static uint8_t aspeed_pcie_root_port_aer_vector(const PCIDevice *d)
> +{
> +    return 0;
> +}
> +
> +static int aspeed_pcie_root_port_interrupts_init(PCIDevice *d, Error **errp)
> +{
> +    int rc;
> +
> +    rc = msi_init(d, ASPEED_PCIE_ROOT_PORT_MSI_OFFSET,
> +                  ASPEED_PCIE_ROOT_PORT_MSI_NR_VECTOR,
> +                  PCI_MSI_FLAGS_MASKBIT & PCI_MSI_FLAGS_64BIT,
> +                  PCI_MSI_FLAGS_MASKBIT & PCI_MSI_FLAGS_MASKBIT,
> +                  errp);
> +    if (rc < 0) {
> +        assert(rc == -ENOTSUP);
> +    }
> +
> +    return rc;
> +}
> +
> +static void aspeed_pcie_root_port_interrupts_uninit(PCIDevice *d)
> +{
> +    msi_uninit(d);
> +}
> +
>   static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
>                                                const void *data)
>   {
> @@ -80,7 +112,13 @@ static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
>       k->device_id = 0x1150;
>       dc->user_creatable = true;
>   
> -    rpc->aer_offset = 0x100;
> +    rpc->aer_vector = aspeed_pcie_root_port_aer_vector;
> +    rpc->interrupts_init = aspeed_pcie_root_port_interrupts_init;
> +    rpc->interrupts_uninit = aspeed_pcie_root_port_interrupts_uninit;
> +    rpc->exp_offset = ASPEED_PCIE_ROOT_PORT_EXP_OFFSET;
> +    rpc->aer_offset = ASPEED_PCIE_ROOT_PORT_AER_OFFSET;
> +    rpc->ssvid_offset = ASPEED_PCIE_ROOT_PORT_SSVID_OFFSET;
> +    rpc->ssid = 0x1150;
>   }
>   
>   static const TypeInfo aspeed_pcie_root_port_info = {


