Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F54FC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHnR-0004zF-Ir; Wed, 14 Feb 2024 11:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raHnP-0004yL-I2
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:07:39 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raHnN-00040O-94
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:07:39 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e0d085cf59so2703718b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707926855; x=1708531655;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyA3rEdsMvHoyAic2Pv3FvyV3oIbKDpoZ1rZ3IwPYBI=;
 b=psQCgPZ5OSXpurMMwnJjTpJ4xpVtPEQaHJHzh5MkatnylY/33Zks47w1VyuGiMRYc7
 qVccbRVPCkGv6LJTneUEuvno/tt85tC3s56/rGg17VW/moIDtZC0H1k4Px+dNHigY9SG
 2KHaQo70AiHa86cYYGTp4WGilAHoL6Nfv33Ko3BAppnL90FWqAfUvukCUUGTaNuPpNKK
 1lSmOeEhiK1c8brrhNts9WCUhWH+bTw7kEwmPMnF72nE0iIs9799C5VN4JrAojF5qogx
 Klp59Q82lZYk82SmJigwo2NXdSLChrYj9LRYQcPqmEt2xYbyqCOz+PMulcX145okJqOg
 bptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707926855; x=1708531655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyA3rEdsMvHoyAic2Pv3FvyV3oIbKDpoZ1rZ3IwPYBI=;
 b=UxNlrwHZGphjy4goNB4ymjf7O3ndAoY5eAXa52pJLnkDBXgAZj3f80BbY+5uhot34g
 t+68Ntrue+TelnZQRzHgDABJAinyeSYCIdY8xOE0IrAIL+mZEEG6d3H0JRNtPEo8Yhyq
 myuKL2IxfNJPKX9zd6O02YU7o8dgfivkJOqF0lthFjvu1FcX6i8Egazhpl/qgyhP+20a
 c9mhTfzVRMEUODknziVgrmmPd71xk0ClzqsKv15rt2PxAmoMas5YmPGQKwgWqxaLav2+
 1TWVB+oDTfnecHWsSQQpvhpKTxfJdb/+d1awUprebF2tz2PvksotkzGLWtY/zuraLBt6
 jeJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEiHprFp70ey7ywq65qP276P0zw/IC8vxAhEYpvQb34WSu05AbsTxyVPVAkHzJCgLFolKTRf0tFS1UP6cdp8d82h5RcOc=
X-Gm-Message-State: AOJu0YyWC2BY3TVzzb0/wuCL9H2TP7ff6N5IhwRPWA596rKnWkZjRL9S
 lzG3znnpRzrshoJgulG1J/ZzjLD7LvVlrHOL9bNc07XwZp5sWS1kCzg/4viq9ng=
X-Google-Smtp-Source: AGHT+IGvD44RSfzfZH20Yt/cr+i8baiIEn+NBqe7vMgRm37eSh4cxBNI2FZLKjwzCv0LQq8kgJikNQ==
X-Received: by 2002:a05:6a00:1782:b0:6e0:9914:86b8 with SMTP id
 s2-20020a056a00178200b006e0991486b8mr3573568pfg.33.1707926854613; 
 Wed, 14 Feb 2024 08:07:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXht+86POr3ErK+qo7AVqjd7vO+tz4Fxxkrp0+ZGwlPlFt7FxRZFaOWm81VT3z4L9Q8SvttWkCBSJVYpj6tFUGvfjMW1FLHL6PUTLL/0XXcM6ZLDyG/ZGagydfKbVfjfePvK7mgCnTXdChqjOU6PgjziA8RNBE1fMBzwhV+B4Vey4UK/japejzzBdOkrPcowSC6zGAzgsfbfAvix3M8b4+8RIvDf3UHqrZTgxMhZfqihoSLYMcxSoZNARnAaVCVU+a8U2EsCLfjSRyQlVOm1AACnACSI6p3pTucjZMnYI7+7p/AKmwmg/ZcNNwD6YuzeKiEIbwENfGoKg9oDQREAnMWsDJ4+cDfgAtsaxpsrbLGChvTQC0x7OTexXAr+yYm/fwERZA89/p7op2kLWOFWKnT2mjRJ+khkdxwWA==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 fn7-20020a056a002fc700b006e09140e686sm9433270pfb.60.2024.02.14.08.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 08:07:34 -0800 (PST)
Message-ID: <0f7ae8e0-6c59-400a-8fc0-7ab21b7471d2@daynix.com>
Date: Thu, 15 Feb 2024 01:07:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] hw/nvme: Refer to dev->exp.sriov_pf.num_vfs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-9-89ad093a07f4@daynix.com>
 <20240214015457-mutt-send-email-mst@kernel.org>
 <c7369ada-96b1-41ad-b141-ff7f1e1dc291@daynix.com>
 <20240214103705-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214103705-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/15 0:46, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 11:09:50PM +0900, Akihiko Odaki wrote:
>> On 2024/02/14 16:07, Michael S. Tsirkin wrote:
>>> On Wed, Feb 14, 2024 at 02:13:47PM +0900, Akihiko Odaki wrote:
>>>> NumVFs may not equal to the current effective number of VFs because VF
>>>> Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
>>>> greater than TotalVFs.
>>>>
>>>> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> I don't get what this is saying about VF enable.
>>> This code will not trigger on numVFs write when VF enable is set.
>>> Generally this commit makes no sense on its own, squash it with
>>> the pci core change pls.
>>
>> This code is meant to run when it is clearing VF Enable, and its
>> functionality is to change the state of VFs currently enabled so that we can
>> disable them.
>>
>> However, NumVFs does not necessarily represent VFs currently being enabled,
>> and have a different value in the case described above.
> 
> Ah so in this case, if numvfs is changed and then VFs are disabled,
> we will not call nvme_virt_set_state? OK, it should say this in commit log.
> And then, what happens?

We will call nvme_virt_set_state() but only for VFs already enabled.

> 
>> Such cases exist
>> even before the earlier patches and this fix is independently meaningful.
> 
> yes but the previous patch causes a regression without this one.
> squash it.

I'll move this patch before the previous patch.

> 
> 
>>>
>>>> ---
>>>>    hw/nvme/ctrl.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>>>> index f8df622fe590..daedda5d326f 100644
>>>> --- a/hw/nvme/ctrl.c
>>>> +++ b/hw/nvme/ctrl.c
>>>> @@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>>>        NvmeSecCtrlEntry *sctrl;
>>>>        uint16_t sriov_cap = dev->exp.sriov_cap;
>>>>        uint32_t off = address - sriov_cap;
>>>> -    int i, num_vfs;
>>>> +    int i;
>>>>        if (!sriov_cap) {
>>>>            return;
>>>> @@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>>>        if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
>>>>            if (!(val & PCI_SRIOV_CTRL_VFE)) {
>>>> -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>>>> -            for (i = 0; i < num_vfs; i++) {
>>>> +            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {
> 
> If the assumption you now make is that num_vfs only changes
> when VFs are disabled, we should add a comment documenting this.
> In fact, I think there's a nicer way to do this:
> 
> static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
>                                    uint32_t val, int len)
> {
>      int old_num_vfs = dev->exp.sriov_pf.num_vfs;
> 
>      pci_default_write_config(dev, address, val, len);
>      pcie_cap_flr_write_config(dev, address, val, len);
>      nvme_sriov_pre_write_ctrl(dev, address, val, len, old_num_vfs);
> }
> 
> and now, nvme_sriov_pre_write_ctrl can compare:
> 
> if (old_num_vfs && !dev->exp.sriov_pf.num_vfs)
> 	disable everything
> 
> 
> this, without bothering with detail of SRIOV capability.
> No?

It looks better. I'll do so in the next version.

