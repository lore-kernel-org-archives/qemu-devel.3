Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6400DE63CA4
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 18:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk4fc-0008P3-EP; Sun, 25 Jan 2026 13:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vk4eu-00083f-UW
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 13:16:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vk4er-0000TL-NW
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 13:16:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so29612315e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769364980; x=1769969780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZStcr2PVPuyELGFgMGLWvRxiHTKRugaNvKKK7h6sPJA=;
 b=pbcW+WG102XSWTvuE9DVHDM41WNMrydHBYS8vjsKz681lWWhzU9lANMHFT98HzMznt
 EQD8n+pAKz8HmCgLuyfKxjGlmRHHgXObKeXoZ9qdh0P4xls984IitHUu7H8qB7Ufo8vy
 P/oTt41A64qvmVhAcnnSdJ2m1oNHg/DFJ+3XNHjImQfaauwWtuLesvYIXw+/mrnMP1Wf
 5CY5Dn/F6DJJGnLh48xrHV55Dw3HbWrr3TEFGQA0gs1A5QOfTuHnisXQeK9QmY5dwQDb
 g4cY8hRD3yGq+ZgInr3W2TzHdAcx9M61lKYYAn+ImmcPz8wocWFypU3eZZ/kdAfsXmGH
 L3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769364980; x=1769969780;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZStcr2PVPuyELGFgMGLWvRxiHTKRugaNvKKK7h6sPJA=;
 b=qDLuLkxZi8Tx2iv9mn/iFl8BFDykgC+ifNBwaOBOgBWEjyHTI2B5KVEI/Zneuf7sOr
 g3qt9fhKJxu84SRGGZnUvueSdIrLTYWzBVzWhTOP85dIyt7ECCHhtDdRKTIPpgbroGyi
 qbGJjiGxwJn2cdMy9EcQjBjCc4ljer1P3Hh1Ke+Eop462DolMXYKHdHnsmnEg/c9fgj0
 nYGwQK+IotAAuhSwOF+l1Z7aqclwmUhwgEPaOCP1wJRyv1HBWNNcdBiAcfMnf+QDz7K3
 SyUzY1z0EQCTBMWZH3LFK8C0Jt73IlrtY/ZtVc36yMLfcpzl+7ttIQvQ9MIK+yG7X173
 l//g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqiqZsVIWkEs4ShS6+DfcPFfeUJkLESNnS6BGnCqPOo/IrcMZNqxjAkr0CvQ10a8Imm9AcnvViLJNg@nongnu.org
X-Gm-Message-State: AOJu0Yze0LUe8j70XS15tuE3+vYEnqJ4ur4KK5AnInr1XPbO01lccEoX
 UZbeJXiryd/IVQlwbnKYnDlwyIN31qGnz9amRuEbDdAnYDN3bNQs8aGNmZfq9q6CdGg=
X-Gm-Gg: AZuq6aKuO2uKCra0VZV3DDvlCuTpHpkeCwcBp0ABW9J/MCXJn+DZO9iemslIMDLQ4BV
 iUgUbhXRbbC0WEU9P55gWL8X/7MK35KFoPZpShRLFRpTccR9v2d1WL7MNQ4JLV10HTSBZpBgHG3
 YuPidjBbVsuTdaFpIyddZPnuJ7Yt6+RpaiU6Jowh0PPQwAPvCDsZzidQcBTvHlx2QfBPC3fMWbm
 ZOJol8jSaSUPTDroPs/3OLYLswZuuP0GAjHzOYKwSPATzxjleZrlB/DWCjs9s+yaQpPp6M877pw
 1TFHOT9F4VhePwQ9lxKg39g4fff1tVLQRvY+jvCecM0i/2LWApnaovhEVfSWEQ3GsVetotFVu3i
 Qqz6AlBwd3QSf2TEOTVTyx4ltnCyKLI3xQR59XcYJVDWK1Roe0RYJh9DI5GJs3oe4ALG1WfIeTI
 EOJAD/U8k++/b7sV5S8j2t5ydtuwlsiLqQA+Ji7H66Zt8dR2v2Ttn4Uw==
X-Received: by 2002:a05:600c:1e2a:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-4805ccd1198mr41324215e9.0.1769364979782; 
 Sun, 25 Jan 2026 10:16:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d845fc3sm202353335e9.1.2026.01.25.10.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jan 2026 10:16:19 -0800 (PST)
Message-ID: <e33572fb-0963-41c8-b7d4-34e22b115a8e@linaro.org>
Date: Sun, 25 Jan 2026 19:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hw/nvme: Add properties for PCI vendor/device IDs
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 nikhilks@linux.ibm.com, stefanha@redhat.com, fam@euphon.net
References: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
 <20251127120322.2997269-2-saif.abrar@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20251127120322.2997269-2-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Saif,

On 27/11/25 13:02, Saif Abrar wrote:
> Add properties for user specified PCI vendor, device, subsystem vendor
> and subsystem IDs.
> 
> e.g. PCI IDs to be specified as follows:
> -device nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> ---
> v3 -> v4: Resolve merge commits when moving to the latest repo.
> 
>   hw/nvme/ctrl.c | 28 +++++++++++++++++++++++++---
>   hw/nvme/nvme.h |  5 +++++
>   2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index cc4593cd42..d857be5496 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8877,7 +8877,10 @@ static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
>                               Error **errp)
>   {
>       uint16_t vf_dev_id = n->params.use_intel_id ?
> -                         PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
> +                         PCI_DEVICE_ID_INTEL_NVME :
> +                         (n->params.id_device ?
> +                         n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME);
> +
>       NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
>       uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
>                                         le16_to_cpu(cap->vifrsm),
> @@ -8953,8 +8956,22 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>           pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
>           pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
>       } else {
> -        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
> -        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
> +        uint16_t id_vendor = n->params.id_vendor ?
> +                             n->params.id_vendor : PCI_VENDOR_ID_REDHAT;
> +        pci_config_set_vendor_id(pci_conf, id_vendor);
> +
> +        uint16_t id_device = n->params.id_device ?
> +                             n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME;
> +        pci_config_set_device_id(pci_conf, id_device);
> +
> +        if (n->params.id_subsys_vendor) {

Just set it directly?

> +            pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID,
> +                                                   n->params.id_subsys_vendor);
> +        }
> +
> +        if (n->params.id_subsys) {

Just set it directly?

> +            pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, n->params.id_subsys);
> +        }
>       }
>   
>       pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
> @@ -9409,6 +9426,11 @@ static const Property nvme_props[] = {
>       DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
>       DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
>       DEFINE_PROP_BOOL("ocp", NvmeCtrl, params.ocp, false),
> +    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
> +    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
> +    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
> +                                                    params.id_subsys_vendor, 0),
> +    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),

Just curious (I missed the previous version), why not use the default
value here instead of 0? For example:

   DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device,
                      PCI_DEVICE_ID_REDHAT_NVME),

>   };
>   
>   static void nvme_get_smart_warning(Object *obj, Visitor *v, const char *name,
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 8f8c78c850..65fb168bc9 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -571,6 +571,11 @@ typedef struct NvmeParams {
>       uint16_t atomic_awun;
>       uint16_t atomic_awupf;
>       bool     atomic_dn;
> +
> +    uint16_t id_vendor;
> +    uint16_t id_device;
> +    uint16_t id_subsys_vendor;
> +    uint16_t id_subsys;
>   } NvmeParams;
>   
>   typedef struct NvmeCtrl {


