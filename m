Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EACEC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFxX-00009m-3X; Wed, 14 Feb 2024 09:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFxV-00009U-HZ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:09:57 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFxT-0008To-RN
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:09:57 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e11596b2e7so193925b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707919794; x=1708524594;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cMBeqTwCC6IF4gbuPZ/OHy0dN2ULPv5y8QaQs6X4vaw=;
 b=fsDVbJpbuv7Hz7M5xUguhfepOd/Ga+gJ6yOasAGO+Z8RNysgwDbe5keAAOM2mQDd+Q
 xm8y+z7Ub4NDZdyPGa6xRhOE8fGX6jSq0hpjC6XTDQ8Mtb+tFEoqjfcocPXEsc7/dPRJ
 ybyFexCxQl59iE/6IPib6P5Lf45KrR11mOiOIKkIGCDqMqCtjD6P5FZWFjaPfznVSPfg
 ngvOJX3pEqTqYGtKYgmYp5Txh4zuZlzCmnhK03327/hh/O4bKH0y2tUaK7VKmgpv8FgU
 NUVfiByKmcG7cX5lcjkgDjshmQMM/d1b1qcZBYrblCPXd30+VAK0HGJ9r4GYlaFBg1Sd
 +rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707919794; x=1708524594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMBeqTwCC6IF4gbuPZ/OHy0dN2ULPv5y8QaQs6X4vaw=;
 b=UFSlhqvXSy+suCKob0kv33/GBZSd0xPcGMrtp8YvUNO9fgeCKcN21sl+/17o5y52hh
 4yVQQ+5FnRxIalgAt6irHxHwTdvKG/mUFxxoTve7eKlgWtSoc9jQxNM//wMn5fGDa/Jq
 6kZiP8HO7Jdhewd2wnvlo5e6nsnoZIAUqAe69Wbqf6w1rs6lK93lH/OxvzNMdp6LauT5
 tFSHzTp3gaK8Xcy5C2q29QxDg3w7zK6SXx87d6Mop6OIiCvqfWBh3OWShXWAXoj/1a2q
 ZXyCpEfAuZLtV57pK1ZIZOfhX7btjqZ1/Y5MJwVUWIWAEpql8Y20hssDzYioeIL7cwzG
 q7lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg8OHHIZJVmSnU/ffk4u6hf91PvXEhLzSfkyjJabX7evCIZCjglISHmBM4R+7JYybGY8dAPz3kdA9thz9xJPdAfaeZQao=
X-Gm-Message-State: AOJu0YzdR6Kzlra0C60d4NMCBp7TRgNiiEFE3cObtiRFydvMzlx5UPNU
 eRJElJqd54qTtLU3JaURPPrLZFuVjMIATum7wt5KplgJvOmhXqdtfbMbdH9b7BE=
X-Google-Smtp-Source: AGHT+IECDc/sbmAZQeCQvIKuYnf73AleB3PHAFBrG8cN9iDrH4plb9MrjzgaFBp9/Hd1apehD0Exvg==
X-Received: by 2002:a05:6a00:420e:b0:6e1:158c:3f9a with SMTP id
 cd14-20020a056a00420e00b006e1158c3f9amr775269pfb.3.1707919794138; 
 Wed, 14 Feb 2024 06:09:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUGHESNdK8gOlGKenJ5BOyp9ZJByZmCeTwK8fCis3ilsxlEV71fDDc+b2OAfVzcO+bdQSJgcMrgrXCqqGWkhRosFNimBCWuIhiNwZ7LOicjYe31QA00SuKKbKLnz34t+oBnanFMemeOsjQDw81NXlF5AMUkfYjLy3ZASlihzNXQzuVq8nMT07vtKx77CO9r12YHNz/4nsueOg1HhBRtDwes3FGuBiEQkGDyR5ZgHgR14h+JRp8il6cn2czTuc9N8EydEjhp0W7KqOnZlbywcsv+D6I2dpSssiyO0j29zOKBTTXgDWoFCbkEhg3Y5XeruXxF17sowjYGLUSZOIOnF3rAi1ZZ322KnYY0adhD/5JxY69Vw+IKHN0bescqKDVE5SghvZRcNCq31AwwGK4XukkpUlRQrk4hrpwh5g==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 b18-20020aa78712000000b006dfbecb5027sm9575103pfo.171.2024.02.14.06.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:09:53 -0800 (PST)
Message-ID: <c7369ada-96b1-41ad-b141-ff7f1e1dc291@daynix.com>
Date: Wed, 14 Feb 2024 23:09:50 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214015457-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2024/02/14 16:07, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 02:13:47PM +0900, Akihiko Odaki wrote:
>> NumVFs may not equal to the current effective number of VFs because VF
>> Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
>> greater than TotalVFs.
>>
>> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> I don't get what this is saying about VF enable.
> This code will not trigger on numVFs write when VF enable is set.
> Generally this commit makes no sense on its own, squash it with
> the pci core change pls.

This code is meant to run when it is clearing VF Enable, and its 
functionality is to change the state of VFs currently enabled so that we 
can disable them.

However, NumVFs does not necessarily represent VFs currently being 
enabled, and have a different value in the case described above. Such 
cases exist even before the earlier patches and this fix is 
independently meaningful.

> 
>> ---
>>   hw/nvme/ctrl.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>> index f8df622fe590..daedda5d326f 100644
>> --- a/hw/nvme/ctrl.c
>> +++ b/hw/nvme/ctrl.c
>> @@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>       NvmeSecCtrlEntry *sctrl;
>>       uint16_t sriov_cap = dev->exp.sriov_cap;
>>       uint32_t off = address - sriov_cap;
>> -    int i, num_vfs;
>> +    int i;
>>   
>>       if (!sriov_cap) {
>>           return;
>> @@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>   
>>       if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
>>           if (!(val & PCI_SRIOV_CTRL_VFE)) {
>> -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>> -            for (i = 0; i < num_vfs; i++) {
>> +            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {
>>                   sctrl = &n->sec_ctrl_list.sec[i];
>>                   nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
>>               }
>>
>> -- 
>> 2.43.0
> 

