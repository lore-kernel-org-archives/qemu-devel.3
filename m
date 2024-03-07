Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B15C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAp8-00038A-6D; Thu, 07 Mar 2024 05:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAp6-00037p-7b
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:18:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAp4-0005jf-HE
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:17:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41312adc3deso1623195e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709806677; x=1710411477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7g05cVI1ulwpJI3WrzN0gXSiMeRy5J6oImnAcNGKNk=;
 b=YcNsZb9q9Y+lzmDuuWBRMYoa0JBcxhzbs4SKVdABHeJS35TYEG4orXT0k2EC5kNkPW
 a+S3TXU3WnXuLluaoDdoNMfI9TAt+8BHlfTR6WbfM/4L7Oa3hx6R+epM9DjZjEu9gD5w
 kh6iX8pPrIprpALiWAvFd9WBX5sZtFT72cQfGDC3lhYAGi3GnXuVAxbLkiVZucmU2iXW
 X8ZAD6/FTPKBublNri75ZNMWWbZzvg21GDz9zD+524oopCH+qMiBrVQuJwIAn5edhVtm
 IjFQMFN2r/hHF8J/jBQPyKv4CjcoR9y55DyBxtRBQbERJ87HOPg5A/h8rHNp/WfwTCZy
 hTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806677; x=1710411477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7g05cVI1ulwpJI3WrzN0gXSiMeRy5J6oImnAcNGKNk=;
 b=n8kGE8OFxCSu02R+aXtz6fTclyd3zMuX6C9RFTBavPCgZErN/dvGgSzuyfd6GkWQL0
 MOO6Q+wCJY46cAW6v3Z8blv6PxDgDnTWwmjZm3MyCsaxzZaOVgFKP6Z3VMRap/o/qnpU
 pOFphDciEamhZs4G4/Q8Qy0xVBh2dkEO5sdRUZciRPG+DMa9V7goz53MRjsfbhQX0MyB
 RHKXdSI4DbrdLWocegbu2atjHlIwUKQN3n0gC3+FI2k0tCqH9WF/KeL8RlB5XUMOMy7y
 hbqklFIdSd/NLoqxzMHY3kwTxtJMweQOHOfqX52xfSoy2bxWAb3TXRMVuxAnYnD8Gl7f
 lA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqkrXyblPCGVvF4fV5JEZFEit6ZcteMfBA1aQzKRHCS1wxgCd4iEaQjN5kFVZicI8RTAxffl24zB5YOAl8XS2HGCcM0DA=
X-Gm-Message-State: AOJu0YwPIVYlVlNO1aJW64dapsDmk1HQFTjrA8FwqXIA2Qsis12ZlluX
 icRrTyxlTERufgM4friSQwLUPH3jxeIMM5GKTHkfJ7T3QmmJma0iATQEdRbnSNI=
X-Google-Smtp-Source: AGHT+IEnzYVRpMxDEOnav33DVXzECxm9E2gabdFx9I01HcFPg3ozGuneq46hDv50oVZo4zfdVHBqKg==
X-Received: by 2002:a05:600c:1d87:b0:412:e823:7db3 with SMTP id
 p7-20020a05600c1d8700b00412e8237db3mr6427566wms.16.1709806676666; 
 Thu, 07 Mar 2024 02:17:56 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 f15-20020a05600c4e8f00b00412ea52b102sm2199606wmq.34.2024.03.07.02.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:17:56 -0800 (PST)
Message-ID: <d8269102-8431-4b56-84c9-16ef107aaf1d@linaro.org>
Date: Thu, 7 Mar 2024 11:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] hw/nvme: Add SPDM over DOE support
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, marcel.apfelbaum@gmail.com,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, mst@redhat.com,
 hchkuo@avery-design.com.tw, wilfred.mallawa@wdc.com,
 cbrowy@avery-design.com, kbusch@kernel.org, lukas@wunner.de,
 jiewen.yao@intel.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240307005859.356555-1-alistair.francis@wdc.com>
 <20240307005859.356555-4-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307005859.356555-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Alistair, Wilfred,

On 7/3/24 01:58, Alistair Francis wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Setup Data Object Exchance (DOE) as an extended capability for the NVME
> controller and connect SPDM to it (CMA) to it.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   docs/specs/index.rst        |   1 +
>   docs/specs/spdm.rst         | 122 ++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pci_device.h |   5 ++
>   include/hw/pci/pcie_doe.h   |   3 +
>   hw/nvme/ctrl.c              |  53 ++++++++++++++++
>   5 files changed, 184 insertions(+)
>   create mode 100644 docs/specs/spdm.rst


> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..b8379c78f1 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -3,6 +3,7 @@
>   
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_doe.h"
>   
>   #define TYPE_PCI_DEVICE "pci-device"
>   typedef struct PCIDeviceClass PCIDeviceClass;
> @@ -157,6 +158,10 @@ struct PCIDevice {
>       MSIVectorReleaseNotifier msix_vector_release_notifier;
>       MSIVectorPollNotifier msix_vector_poll_notifier;
>   
> +    /* DOE */
> +    DOECap doe_spdm;
> +    uint16_t spdm_port;
> +
>       /* ID of standby device in net_failover pair */
>       char *failover_pair_id;
>       uint32_t acpi_index;
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> index 15d94661f9..eb8f4e393d 100644
> --- a/include/hw/pci/pcie_doe.h
> +++ b/include/hw/pci/pcie_doe.h
> @@ -108,6 +108,9 @@ struct DOECap {
>       /* Protocols and its callback response */
>       DOEProtocol *protocols;
>       uint16_t protocol_num;
> +
> +    /* Used for spdm-socket */
> +    int socket;

Why not name it 'spdm_socket' like 'spdm_port' earlier?

>   };


>   static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -8126,6 +8149,24 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>   
>       nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
>   
> +    pcie_cap_deverr_init(pci_dev);
> +
> +    /* DOE Initialisation */
> +    if (pci_dev->spdm_port) {
> +        uint16_t doe_offset = n->params.sriov_max_vfs ?
> +                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
> +                                  : PCI_CONFIG_SPACE_SIZE;
> +
> +        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset, doe_spdm_prot, true, 0);
> +
> +        pci_dev->doe_spdm.socket = spdm_socket_connect(pci_dev->spdm_port, errp);
> +
> +        if (pci_dev->doe_spdm.socket < 0 ) {
> +            error_setg(errp, "Failed to connect to SPDM socket");

spdm_socket_connect() already sets errp in case of failure.

> +            return -ENOTSUP;

This function returns a boolean, so this return value is casted
to 'true'. IIUC true means success, so this is incorrect.

> +        }
> +    }
> +
>       if (n->params.cmb_size_mb) {
>           nvme_init_cmb(n, pci_dev);
>       }
> @@ -8412,6 +8453,7 @@ static Property nvme_props[] = {
>                         params.sriov_max_vi_per_vf, 0),
>       DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
>                         params.sriov_max_vq_per_vf, 0),
> +    DEFINE_PROP_UINT16("spdm", PCIDevice, spdm_port, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };

Regards,

Phil.

