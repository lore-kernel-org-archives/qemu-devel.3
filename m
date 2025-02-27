Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D31C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfd2-00049x-7a; Thu, 27 Feb 2025 10:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@xora.org.uk>)
 id 1tnfcp-00046s-9A; Thu, 27 Feb 2025 10:16:35 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@xora.org.uk>)
 id 1tnfcm-0006pB-M9; Thu, 27 Feb 2025 10:16:35 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 24C371140A73;
 Thu, 27 Feb 2025 10:16:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 27 Feb 2025 10:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xora.org.uk; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740669390;
 x=1740755790; bh=PtnNgLu0FNKnBTCvhwRKLa8jAjsPZB+NeFT2Nv1vGjs=; b=
 2U+LXQqqDjnp/7zs6Pmkcb490o2rTN1dT4bL1yHV4ZN7RWpA0E8Galf/sizvACpo
 TnOXOBbZIp3tGjlBJpSJTnOjS5yXrG01sB3S2CRbxkPDVmt7Z1ezMQ7Qp1v5997K
 IHztMZWSlopZVk0RNeAFABvqoyxb4mrSq1zOvGEb1sOB3yhqHNNYDVOfUB2FRuxO
 AS/n7vN2ydwXN7GyadfEMhEHNUWWK9gCKfFfKjOZ3cVUqELewHfNsr7RFcmDoef/
 KvW6U26nFiP1ACQhpK4j1zrqgTgYWS7II/yWDwKGVWrO2hjYg4t0+kj5/frSAPcf
 jvZATdva95kRXavvo3UxAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740669390; x=
 1740755790; bh=PtnNgLu0FNKnBTCvhwRKLa8jAjsPZB+NeFT2Nv1vGjs=; b=S
 8x96h9J93niXqv5zGBuCCK/ysOMvT8/wCJAgrJNtkEQIB8GSfWW5ywoPCUvnF0H1
 T4NDJ9Ekdo8bWGi3KNt4q5UMZKbzpE5kwd0il3C0ajWJ/BIRZ074kfHLp5S64ab9
 vUrX246qBVeWApvHpPssBfvYujNTipZMBaGSnPv383Qq3EWjxU02ykEU1QGJnwt4
 BqmdQUfSXxsdsblB37mE/yRxnMTJKZCfGbqPJe5lRSnqgeXQhq/m4mshLsSPbtpq
 yk3pWjiQMIJXe6NX1DHfcNLMpYY+IKbUqlzzV24s7aE40/Iuo5QF6Du6yIfJ5rhk
 nK/CHF5uxTba6SVd5Puog==
X-ME-Sender: <xms:zYHAZwHqA0YP7YLTnUifFr5r2BOE3pH-UlILSNpO_8I2L4LC3F3MQQ>
 <xme:zYHAZ5WkyTJzFDSyhDMjF_T93iA7_hPk3e3h5KeQtuGraYgdaJYFPw6OCp9CwX13G
 aeP-JCNosjhNPM0Eg>
X-ME-Received: <xmr:zYHAZ6JJdbDPMIkmRv7qI-LrOZi8bTzyue7wMC_TaSlwo6am0g8hEPzLWJxBlseghlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeejlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttder
 jeenucfhrhhomhepifhrrggvmhgvucfirhgvghhorhihuceoghhrrggvmhgvseigohhrrg
 drohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetgeffieevgfffteegjeeliedvfeei
 udeljefhkeehtdetfeekhefhieehjefhieenucffohhmrghinhepghhithhlrggsrdgtoh
 hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
 rggvmhgvseigohhrrgdrohhrghdruhhkpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopehkuhhqihhnuddvsehgmhgrihhlrdgtohhmpdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvg
 htvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehrrggusehs
 vghmihhhrghlfhdrtghomhdprhgtphhtthhopehlvghifhdrlhhinhguhhholhhmsehosh
 hsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepkhhuqhhinhesmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:zYHAZyFSUyR3JmFvdr71KiAxlQgiauIUdcT454e4UiENss9LLXOtOw>
 <xmx:zYHAZ2Vi8-OFHipV_e8r6S7tYnDDtSL4FYkSNNgUDTtRfNVF6Kcclw>
 <xmx:zYHAZ1M_CoVINPZt1y7oufqf3cKUXXw452X8Of5s0oElCFPzGzheOA>
 <xmx:zYHAZ90ZY6dQSCEwIBr8zshrSviQM43l7fMhYhEsVCIpVODK0vvDRQ>
 <xmx:zoHAZxF-ad5wK7T2F2QQbaH_WT10UVTvPnwjnUkY9v1VofsqJMSmZCh5>
Feedback-ID: i62f7400e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 10:16:28 -0500 (EST)
Message-ID: <f9400b1e-e36d-486c-bea7-115a742befd4@xora.org.uk>
Date: Thu, 27 Feb 2025 15:17:01 +0000
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref
 machine
To: Kun Qin <kuqin12@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Kun Qin <kuqin@microsoft.com>
References: <20250225074133.6827-1-kuqin12@gmail.com>
 <20250225074133.6827-2-kuqin12@gmail.com>
Content-Language: en-US
From: Graeme Gregory <graeme@xora.org.uk>
In-Reply-To: <20250225074133.6827-2-kuqin12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.155; envelope-from=graeme@xora.org.uk;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 25/02/2025 07:41, Kun Qin wrote:
> From: Kun Qin <kuqin@microsoft.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625
>
> This change aims to add a TPM device for SBSA ref machine.
>
> The implementation adds a TPM create routine during machine
> initialization.
>
> The backend can be the same as the rest of TPM support, by using swtpm.

This looks sensible to me.

Reviewed-by: Graeme Gregory <graeme@xora.org.uk>

> Signed-off-by: Kun Qin <kuqin12@gmail.com>
> ---
>   hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e720de306419..93eb3d1e363b 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -28,6 +28,8 @@
>   #include "system/numa.h"
>   #include "system/runstate.h"
>   #include "system/system.h"
> +#include "system/tpm.h"
> +#include "system/tpm_backend.h"
>   #include "exec/hwaddr.h"
>   #include "kvm_arm.h"
>   #include "hw/arm/boot.h"
> @@ -94,6 +96,7 @@ enum {
>       SBSA_SECURE_MEM,
>       SBSA_AHCI,
>       SBSA_XHCI,
> +    SBSA_TPM,
>   };
>   
>   struct SBSAMachineState {
> @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>       /* Space here reserved for more SMMUs */
>       [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
>       [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
> +    [SBSA_TPM] =                { 0x60120000, 0x00010000 },
>       /* Space here reserved for other devices */
>       [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
>       /* 32-bit address PCIE MMIO space */
> @@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>       }
>   }
>   
> +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)
> +{
> +    Error *errp = NULL;
> +    DeviceState *dev;
> +
> +    TPMBackend *be = qemu_find_tpm_be("tpm0");
> +    if (be == NULL) {
> +        error_report("Couldn't find tmp0 backend");
> +        return;
> +    }
> +
> +    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
> +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
> +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_memmap[SBSA_TPM].base);
> +}
> +
>   static void create_pcie(SBSAMachineState *sms)
>   {
>       hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)
>       pci_create_simple(pci->bus, -1, "bochs-display");
>   
>       create_smmu(sms, pci->bus);
> +
> +    create_tpm(sms, pci->bus);
>   }
>   
>   static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)

