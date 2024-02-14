Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B940C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raIUL-0005iK-In; Wed, 14 Feb 2024 11:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raIUJ-0005hY-Bk
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:51:59 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raIUH-0006Yg-I9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:51:59 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d73066880eso51807205ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707929516; x=1708534316;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6LOv7c2yHuVTEKHjjI1uKZg2LIYzNSWQr2BCQv5eVQs=;
 b=P5CGN5gfLyyCm4AGk2YcfptCPDFIfF/8qkc6mTIAw9ksEInuPPIdG/1IHejaG4OK98
 LakUKJlsu/lqif+aUcuLJ1Nt4ZONEjt3NU5k6mQqcqwSmdchwsWYpZffLMAveBdMx2D2
 cyEYHn4w2SJcvlxsKbcp8Ikq3U3RaGdHKveyOB8CNifVmHb+DJb8jxlCzzETrXIyLE25
 BS6QATfmVsuiP6GkD8t1Fera1EyDyHc8vJZWwXEELC8figIilWdWiVTEAT9ViHDA9Wce
 g3I0Oqt9+Uvn1epAFvR91h/ydbGpCmcUw7CSVVg8Jp9ywV1f+RuY4swo+BjWTS5+EGtq
 ctng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707929516; x=1708534316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6LOv7c2yHuVTEKHjjI1uKZg2LIYzNSWQr2BCQv5eVQs=;
 b=OSNnV8gxPYrK0S47E3D1WhlWHhkVuNoYVHsdHICr42e95HjPRw23L3GVIwVG9eFOHp
 O8Xk89fhiWYQozWGY8T9TSDATFrrvzPMxOC7Tvo3PUcsf0wEyIJ+Vayiqd+B+lLPdzMI
 vCkCqwmScg7o9vdJuLdK6E7i8MGe/zomjp9Prgo5zJw4oYIEf05IXIH4uyq95oyrnZ6z
 nowf7YTKSjkJY6K44SA4LQymCiNxNv00k/u33WY8MDpqQHESuduTXMMWErHrhG6lRGSf
 tAXBjRVAPlwDCTcswqZM7TlEcNL31HRZeiitKMazr+OBoGzd3iJslroBAdfvdm7HLo2g
 JQJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsDPWrMVGI7uRd9D0Q1Rcdh6EAFYd6vt8OQ6ZOKr6p8IS8ctsPcdJ5+bnU17rrhgOoYoAfaVPSahe5Kc3wza4W9t1PGtU=
X-Gm-Message-State: AOJu0YxvDp9KYpVn6hHA53FrkHOq5a1oKjySnRwzpKmPwQwZEIi+1pGF
 E50ILtWMPKsUmmKKno/gZgRrQ0alNcLAvljdx6XL5C5cyM0LWZvlfiLyoJio/Ac=
X-Google-Smtp-Source: AGHT+IHiUMCHu6DEPU0Jacq9U1OLL9n5aUvjH5f4OGEay1XNRi2dHvoD6aGrSQb7XzN/x5tbBniA3g==
X-Received: by 2002:a17:902:82cc:b0:1d9:427a:991 with SMTP id
 u12-20020a17090282cc00b001d9427a0991mr3267963plz.20.1707929516182; 
 Wed, 14 Feb 2024 08:51:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVwZdSlSxZPq9Ax08BUqQJCgLKHNRVYkwN5ES4bYATbUY7Yx2QxbWffYoB8TxazuUqqVQJq84JAtnlaqc6MKc7bo5TO3cvk8YyV1pcTON5ja1k2dCm1Ibc00fJPk7tn0RoQ8oTGPAJj0DfuLCTFt9YYnCiEkxUnl71uvhK9qFXnMWdUfijbzfNZmOYMCNIobQ3MAqP+2RDXkpIxhLXqeGxojCqxMrp/ML5+TP8NYxCH5COpAC1jEYSMQVW19r+NjaXWky6/52L5iR64yJVOs3yHDVideA/eM7OUsVGR00iV+J2ZIhplmd8303q8oKUaGQBPHCVueTuJRymVV65nE+ixZqJGmAEUg8KVQniue0CfYKGVCh9yOEfG3sD6Cfl3xTjIa6B/ndtBUs7kgQFlsGDb73ci6VMqvzJmJw==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 kw5-20020a170902f90500b001d949393c50sm3961194plb.187.2024.02.14.08.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 08:51:55 -0800 (PST)
Message-ID: <7ad59c7d-2de4-4de6-aa6a-0c27f63ca8c3@daynix.com>
Date: Thu, 15 Feb 2024 01:51:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] hw/nvme: Refer to dev->exp.sriov_pf.num_vfs
Content-Language: en-US
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
 <0f7ae8e0-6c59-400a-8fc0-7ab21b7471d2@daynix.com>
 <20240214113312-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214113312-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2024/02/15 1:34, Michael S. Tsirkin wrote:
> On Thu, Feb 15, 2024 at 01:07:29AM +0900, Akihiko Odaki wrote:
>> On 2024/02/15 0:46, Michael S. Tsirkin wrote:
>>> On Wed, Feb 14, 2024 at 11:09:50PM +0900, Akihiko Odaki wrote:
>>>> On 2024/02/14 16:07, Michael S. Tsirkin wrote:
>>>>> On Wed, Feb 14, 2024 at 02:13:47PM +0900, Akihiko Odaki wrote:
>>>>>> NumVFs may not equal to the current effective number of VFs because VF
>>>>>> Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
>>>>>> greater than TotalVFs.
>>>>>>
>>>>>> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> I don't get what this is saying about VF enable.
>>>>> This code will not trigger on numVFs write when VF enable is set.
>>>>> Generally this commit makes no sense on its own, squash it with
>>>>> the pci core change pls.
>>>>
>>>> This code is meant to run when it is clearing VF Enable, and its
>>>> functionality is to change the state of VFs currently enabled so that we can
>>>> disable them.
>>>>
>>>> However, NumVFs does not necessarily represent VFs currently being enabled,
>>>> and have a different value in the case described above.
>>>
>>> Ah so in this case, if numvfs is changed and then VFs are disabled,
>>> we will not call nvme_virt_set_state? OK, it should say this in commit log.
>>> And then, what happens?
>>
>> We will call nvme_virt_set_state() but only for VFs already enabled.
> 
> And? What does it cause? memory leak? some buffer is overrun?
> the guest behaviour is illegal so it does not really
> matter what we do as long as nothing too bad happens.

nvme_sriov_pre_write_ctrl() is intended to free resources allocated to 
VFs. Previously, nvme_sriov_pre_write_ctrl() used NumVFs to iterate VFs 
with resources allocated. If NumVFs is changed and then VFs are 
disabled, this iteration resulted in buffer overrun.

With this patch, the changed value of NumVFs will be ignored, and 
nvme_sriov_pre_write_ctrl() only frees resources allocated to VFs 
actually enabled, thus no buffer overrun happens.

> 
>>>
>>>> Such cases exist
>>>> even before the earlier patches and this fix is independently meaningful.
>>>
>>> yes but the previous patch causes a regression without this one.
>>> squash it.
>>
>> I'll move this patch before the previous patch.
>>
>>>
>>>
>>>>>
>>>>>> ---
>>>>>>     hw/nvme/ctrl.c | 5 ++---
>>>>>>     1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>>>>>> index f8df622fe590..daedda5d326f 100644
>>>>>> --- a/hw/nvme/ctrl.c
>>>>>> +++ b/hw/nvme/ctrl.c
>>>>>> @@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>>>>>         NvmeSecCtrlEntry *sctrl;
>>>>>>         uint16_t sriov_cap = dev->exp.sriov_cap;
>>>>>>         uint32_t off = address - sriov_cap;
>>>>>> -    int i, num_vfs;
>>>>>> +    int i;
>>>>>>         if (!sriov_cap) {
>>>>>>             return;
>>>>>> @@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>>>>>         if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
>>>>>>             if (!(val & PCI_SRIOV_CTRL_VFE)) {
>>>>>> -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>>>>>> -            for (i = 0; i < num_vfs; i++) {
>>>>>> +            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {
>>>
>>> If the assumption you now make is that num_vfs only changes
>>> when VFs are disabled, we should add a comment documenting this.
>>> In fact, I think there's a nicer way to do this:
>>>
>>> static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
>>>                                     uint32_t val, int len)
>>> {
>>>       int old_num_vfs = dev->exp.sriov_pf.num_vfs;
>>>
>>>       pci_default_write_config(dev, address, val, len);
>>>       pcie_cap_flr_write_config(dev, address, val, len);
>>>       nvme_sriov_pre_write_ctrl(dev, address, val, len, old_num_vfs);
>>> }
>>>
>>> and now, nvme_sriov_pre_write_ctrl can compare:
>>>
>>> if (old_num_vfs && !dev->exp.sriov_pf.num_vfs)
>>> 	disable everything
>>>
>>>
>>> this, without bothering with detail of SRIOV capability.
>>> No?
>>
>> It looks better. I'll do so in the next version.
> 

