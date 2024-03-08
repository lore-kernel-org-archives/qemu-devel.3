Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6C2C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridO4-0007LO-UE; Fri, 08 Mar 2024 11:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ridO1-0007I2-BB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ridNy-0006PO-I3
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709916470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d37ilDygHcnxIq+f+Uco6ClaOG0NV7691L91/UrctiU=;
 b=hm1HpixUTPcvGq4O33hqMadf3Uz+dN0rhvGQ+aSK7tjZ3WnGv9NOdwIQxDoZ8kgxWLttCR
 +ulqSF86H12FluC5Mu38GUvyTUHghPB8EOBfqYPgJyBdrQZREDLcuzv7uI+CgF7k2NPR/A
 QVPV1ZI9NqucQNRx0f7smvDbxHj1BdU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Crw0rmBWNp-dv_bwiuSCrw-1; Fri, 08 Mar 2024 11:47:47 -0500
X-MC-Unique: Crw0rmBWNp-dv_bwiuSCrw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d19951a9bso301621f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709916466; x=1710521266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d37ilDygHcnxIq+f+Uco6ClaOG0NV7691L91/UrctiU=;
 b=LM+/XcEHeE6CBo4V7rd0tNfP8Ixk7Wq18RpRnZ69aPbGYHp2M1hn3XDGeQAmUqyu7f
 /TcsgGSPIStyGNTtTs0zoyXOOxppvsSg+CJdfIJbeoLQhwNTMDy0uEXx04fBR8HF2Rld
 8qF8JSi6/8ks2ZXBz6c1VAAM7L5t3B75/hWm7cabTvgvh8N3BZof865wy5PXel8klFv5
 dfny1wmVEm1BNzmc1zwIQQCdhxco0HDRduTfm/nS+Uj+uIQw/4VHmgWHf93t7qAJKX+T
 m5uxaZHF3tIK+UWnRx/7xkdmk/F1FE2k/HgFi/RJIKefSUwaW6vyIe4F5A9EsxW50Dp9
 lsFw==
X-Gm-Message-State: AOJu0YzhM4UoQbCm3FoHUmz2XmkEAfyzMWZUlRC/0ucdcULydnFWkr4U
 mFbQrIzXOZS58eUboLAooVDhfNXF+UY3s7T6GAOzSPYW++TvICVwkuGsiMxkZJbfovdthEvgTof
 m1fjVZ6eq6B3B4jTlewTNBj9aH1gWyUJ0+eMa6qFXpXGAhVps+HcK
X-Received: by 2002:a5d:5490:0:b0:33d:6ca1:3058 with SMTP id
 h16-20020a5d5490000000b0033d6ca13058mr14489762wrv.56.1709916466559; 
 Fri, 08 Mar 2024 08:47:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm3/PolLme7+BVs9F/BV+9fkxYL7pbIFYIulh3FjjfZETvnyKRZAk+/lnabQ3AKBlh4H96QQ==
X-Received: by 2002:a5d:5490:0:b0:33d:6ca1:3058 with SMTP id
 h16-20020a5d5490000000b0033d6ca13058mr14489748wrv.56.1709916466169; 
 Fri, 08 Mar 2024 08:47:46 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9000:9100:7442:850e:5af1:aebf?
 ([2a01:cb19:9000:9100:7442:850e:5af1:aebf])
 by smtp.gmail.com with ESMTPSA id
 bo16-20020a056000069000b0033e422d0963sm13068657wrb.41.2024.03.08.08.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:47:45 -0800 (PST)
Message-ID: <12e67a75-0d13-406e-9945-bccc8b179ca2@redhat.com>
Date: Fri, 8 Mar 2024 17:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: Add option to disable device level INTx masking
Content-Language: en-US, fr
To: Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20240307184645.104349-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240307184645.104349-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/7/24 19:46, Alex Williamson wrote:
> The PCI 2.3 spec added definitions of the INTx disable and status bits,
> in the command and status registers respectively.  The command register
> bit, commonly known as DisINTx in lspci, controls whether the device
> can assert the INTx signal.
> 
> Operating systems will often write to this bit to test whether a device
> supports this style of legacy interrupt masking.  When using device
> assignment, such as with vfio-pci, the result of this test dictates
> whether the device can use a shared or exclusive interrupt (ie. generic
> INTx masking at the device via DisINTx or IRQ controller level INTx
> masking).
> 
> Add an experimental option to the base set of properties for PCI
> devices which allows the DisINTx bit to be excluded from wmask, making
> it read-only to the guest for testing purposes related to INTx masking.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>


LGTM,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/pci/pci.c         | 14 ++++++++++----
>   include/hw/pci/pci.h |  2 ++
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 6496d027ca61..8c78326ad67f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -85,6 +85,8 @@ static Property pci_props[] = {
>                       QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>       DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                       QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
> +                    QEMU_PCI_DISINTX_BITNR, true),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> @@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
>   static void pci_init_wmask(PCIDevice *dev)
>   {
>       int config_size = pci_config_size(dev);
> +    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> +                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>   
>       dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
>       dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
> -    pci_set_word(dev->wmask + PCI_COMMAND,
> -                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> -                 PCI_COMMAND_INTX_DISABLE);
> -    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
> +
> +    if (dev->cap_present & QEMU_PCI_DISINTX) {
> +        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
> +    }
> +
> +    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
>   
>       memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
>              config_size - PCI_CONFIG_HEADER_SIZE);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eaa3fc99d884..45f0fac435cc 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -212,6 +212,8 @@ enum {
>       QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
>   #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
>       QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> +#define QEMU_PCI_DISINTX_BITNR 13
> +    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
>   };
>   
>   typedef struct PCIINTxRoute {


