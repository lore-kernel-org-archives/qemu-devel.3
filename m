Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B17C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfW9m-0007bO-Sb; Wed, 28 Feb 2024 21:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfW9l-0007ad-19
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:28:21 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfW9i-00052y-QM
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:28:20 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-365b3bab179so1907145ab.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709173697; x=1709778497;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2OoIiJdN8RItj+2VwRd9j9glyVFBa+ZBDz2pUxxtuCg=;
 b=da3lFWORYzipz/ce+q0zdOXWxu0gJXgCshmrPVHAFISWmyasI51Wp85xF1A1NAi1uH
 0cshBdUxtyjobSekBoQr3b7dzylYFYWstnrFq63EGBeXwTN+S1w8W582w4OK0hTHujf2
 eiCjl3OoiSl8yqlm7UAd7UyuBctw2MzgmiXDioX6wRrCFnaF5qwBNBsv+kS5Bj9B+rJs
 QRTyidpwAJSuT9obKNY5foMqTF9h7NSvp5Vlt4KNfq5VZ5QSBUgcBcGn0NQiomalY6Kz
 nY3QfIaBEqScHtlefGo0xJRQY3zrEGgxCVN1zhZnBzXvSm+LRwkkvaTE95t0AD+cfwLH
 kLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709173697; x=1709778497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2OoIiJdN8RItj+2VwRd9j9glyVFBa+ZBDz2pUxxtuCg=;
 b=RuPhAPp/mt4iLn/s3PLtUDoLCkYHI7uWCtSc1y7ZIMG4M2Mtf+ceVcpZqJRAF2BE07
 a0cQQ9879H4UZdD9uEnc5SmO3GMY06HJIpuThDknqxy0ltvyDKmAPawq99o6bjY3NIQU
 cnOt0N1TjfO8bHw3ytfcVmifKK/lj1JmZO8iJEmJol8+0h+hbht1QEVsZp8aKPmILl5I
 FndSUHNg2yr97AfJ74CSIdNLeUmWkjjlvtiMdFknu78XGbiB/9kF8Wsu0CV5JbN155TR
 IQ/8ygfcEAii277e+YqCtIJPDPQlKQTNvip4W4aM9KCsO0AR9VWONWBXC2VoKY6qrGOS
 19VA==
X-Gm-Message-State: AOJu0YyRzexw8pDQALVtgfy1/8VlorpKOe+eCYweamfsrmR8/3mbAN59
 1j4A7MCLuwjWjkpQT+GekfgPC2AeFLnUEN3KODuhCQr7vqtZrfkCDwFnbqrc5Aw=
X-Google-Smtp-Source: AGHT+IHWsaUK49aRMAvJ3yFGqRNPayqKREYilzeHlR5bMy5cfFcwksXO3PjxHs9/2yqhoM6cCq4eYA==
X-Received: by 2002:a92:d28a:0:b0:363:be58:cdb0 with SMTP id
 p10-20020a92d28a000000b00363be58cdb0mr1098183ilp.6.1709173697491; 
 Wed, 28 Feb 2024 18:28:17 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 n39-20020a056a000d6700b006e57defe737sm137165pfv.76.2024.02.28.18.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 18:28:00 -0800 (PST)
Message-ID: <e6a27d2a-d2d4-4f2f-a8e8-b6def304a9f3@daynix.com>
Date: Thu, 29 Feb 2024 11:27:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/15] pcie_sriov: Reset SR-IOV extended capability
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
 <20240228-reuse-v8-3-282660281e60@daynix.com>
 <AS4PR07MB8412339C60640B86A894664B90582@AS4PR07MB8412.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <AS4PR07MB8412339C60640B86A894664B90582@AS4PR07MB8412.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/29 1:23, Sriram Yagnaraman wrote:
> 
> 
>> -----Original Message-----
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Sent: Wednesday, 28 February 2024 12:33
>> To: Philippe Mathieu-Daudé <philmd@linaro.org>; Michael S. Tsirkin
>> <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>> Alex Williamson <alex.williamson@redhat.com>; Cédric Le Goater
>> <clg@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Daniel P.
>> Berrangé <berrange@redhat.com>; Eduardo Habkost
>> <eduardo@habkost.net>; Sriram Yagnaraman
>> <sriram.yagnaraman@ericsson.com>; Jason Wang <jasowang@redhat.com>;
>> Keith Busch <kbusch@kernel.org>; Klaus Jensen <its@irrelevant.dk>; Markus
>> Armbruster <armbru@redhat.com>
>> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; Akihiko Odaki
>> <akihiko.odaki@daynix.com>
>> Subject: [PATCH v8 03/15] pcie_sriov: Reset SR-IOV extended capability
>>
>> pcie_sriov_pf_disable_vfs() is called when resetting the PF, but it only disables
>> VFs and does not reset SR-IOV extended capability, leaking the state and
>> making the VF Enable register inconsistent with the actual state.
>>
>> Replace pcie_sriov_pf_disable_vfs() with pcie_sriov_pf_reset(), which does
>> not only disable VFs but also resets the capability.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/pci/pcie_sriov.h |  4 ++--
>>   hw/net/igb.c                |  2 +-
>>   hw/nvme/ctrl.c              |  2 +-
>>   hw/pci/pcie_sriov.c         | 26 ++++++++++++++++++--------
>>   4 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h index
>> 095fb0c9edf9..b77eb7bf58ac 100644
>> --- a/include/hw/pci/pcie_sriov.h
>> +++ b/include/hw/pci/pcie_sriov.h
>> @@ -58,8 +58,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev,
>> uint16_t opt_sup_pgsize);  void pcie_sriov_config_write(PCIDevice *dev,
>> uint32_t address,
>>                                uint32_t val, int len);
>>
>> -/* Reset SR/IOV VF Enable bit to unregister all VFs */ -void
>> pcie_sriov_pf_disable_vfs(PCIDevice *dev);
>> +/* Reset SR/IOV */
>> +void pcie_sriov_pf_reset(PCIDevice *dev);
>>
>>   /* Get logical VF number of a VF - only valid for VFs */  uint16_t
>> pcie_sriov_vf_number(PCIDevice *dev); diff --git a/hw/net/igb.c
>> b/hw/net/igb.c index 0b5c31a58bba..9345506f81ec 100644
>> --- a/hw/net/igb.c
>> +++ b/hw/net/igb.c
>> @@ -493,7 +493,7 @@ static void igb_qdev_reset_hold(Object *obj)
>>
>>       trace_e1000e_cb_qdev_reset_hold();
>>
>> -    pcie_sriov_pf_disable_vfs(d);
>> +    pcie_sriov_pf_reset(d);
>>       igb_core_reset(&s->core);
>>   }
>>
>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c index
>> 7a56e7b79b4d..7c0d3f108724 100644
>> --- a/hw/nvme/ctrl.c
>> +++ b/hw/nvme/ctrl.c
>> @@ -7116,7 +7116,7 @@ static void nvme_ctrl_reset(NvmeCtrl *n,
>> NvmeResetType rst)
>>               }
>>
>>               if (rst != NVME_RESET_CONTROLLER) {
>> -                pcie_sriov_pf_disable_vfs(pci_dev);
>> +                pcie_sriov_pf_reset(pci_dev);
>>               }
>>           }
>>
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c index
>> da209b7f47fd..51b66d1bb342 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -249,16 +249,26 @@ void pcie_sriov_config_write(PCIDevice *dev,
>> uint32_t address,  }
>>
>>
>> -/* Reset SR/IOV VF Enable bit to trigger an unregister of all VFs */ -void
>> pcie_sriov_pf_disable_vfs(PCIDevice *dev)
>> +/* Reset SR/IOV */
>> +void pcie_sriov_pf_reset(PCIDevice *dev)
>>   {
>>       uint16_t sriov_cap = dev->exp.sriov_cap;
>> -    if (sriov_cap) {
>> -        uint32_t val = pci_get_byte(dev->config + sriov_cap + PCI_SRIOV_CTRL);
>> -        if (val & PCI_SRIOV_CTRL_VFE) {
>> -            val &= ~PCI_SRIOV_CTRL_VFE;
>> -            pcie_sriov_config_write(dev, sriov_cap + PCI_SRIOV_CTRL, val, 1);
>> -        }
>> +    if (!sriov_cap) {
>> +        return;
>> +    }
>> +
>> +    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
>> +    unregister_vfs(dev);
>> +
>> +    /*
>> +     * Default is to use 4K pages, software can modify it
>> +     * to any of the supported bits
>> +     */
>> +    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
>> +
> 
> Just curious, do we need this?
> On Linux, I thought the PCI subsystem restores the page size after reset.

Perhaps Linux doesn't need it, but the specification requires to reset 
the whole capability.

> 
> Otherwise,
> Assuming change of my mail address from sriram.yagnaraman@est.tech to @ericsson.com is accepted,
> Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> 
>> +    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
>> +        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
>> +                     dev->exp.sriov_pf.vf_bar_type[i]);
>>       }
>>   }
>>
>>
>> --
>> 2.43.2

