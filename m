Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E7DC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raI1n-00034l-Q8; Wed, 14 Feb 2024 11:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raI1m-00034a-PX
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:22:30 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raI1k-0007SN-Tj
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:22:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d72f71f222so45186945ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707927747; x=1708532547;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77PCP/XGqO8F7oIm9pHYQ6ccFfea1n7klOgJvdwc0Jo=;
 b=zlpLHBq6j52bVa6nXkgGQgiUwCHpQV7bVmbOc7PrTZv6ris0j0EPixfTREHwj7IrSq
 Qj3qyIrINe+FnUfYq9/HzHxezE/41VM10+fH6LtMQ65DKwOoFiyIQLJeMVLymuEoIgZk
 /fNbjEEf0D1bu4HgvRW3zJTWX0l0fJTcwqLBZ5qI58+zKMOEtu9k+yirxkO6PZWjpa/k
 tM0lYo4Z4AbxDfjLL5Il+wAJp4aJpB/1Ap4400v30FKxH2PTt1myqWMcsuo9P34YzZHZ
 fqwRJ+Vq0SMJA9p13loPMU3mrOd+Lhla3K2LuFw/LLkSZrSFfLB4VMKlbnGwHfZmyiZr
 GXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707927747; x=1708532547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77PCP/XGqO8F7oIm9pHYQ6ccFfea1n7klOgJvdwc0Jo=;
 b=p8oTlfYN2ukNJFja0R8E7/s2Rka+TxodFit1uJMVgHcFf6mj1L3pGYo7A+N545+JE3
 Chr/ACsifAPpG3TJFljMBCPr4hIk3b2omoovrm/DgEk5I9R/x4qecD0H731C3p5JhPhL
 1bI3jLfC0tKUJMOgrYOIRl6kMphCws1BJBNCciaz39IJ6RdVUXXVK+mJNp2UyeQpj6gm
 CsSk3D5TlqR2UTRN/TtOkw+ZDfecGUIxuKLU5SOYfyQpvlCiPw30K7SLWhHHhABhmkew
 53yn71sq41MUH/uPJL6SW5I8M5mtsHEF0MQnh+Xd1yVcyu2S1em2EvXCMR2gS4XYJuhU
 u8cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcnE5zOp149QvtQlS/3Ti1s5+btXHf2Pfjit9PW1uUIZdqg0R8u2AFosYwjTgRMAzHpLR045lRdFyImKka0+oGp/VPbuQ=
X-Gm-Message-State: AOJu0YzvZLLGZrDAwXPlayAvCGsX8LifIQAFNMkxwUNvcSVN8zl9ToTn
 uPGRcDahmUPACjplVmUOkgfPIcLAq+nQoOmdNYk3jcpLqKZUsJXbL0+K7xkFPoM=
X-Google-Smtp-Source: AGHT+IGWYprZI1aH3QGPjeV4t6Pem2q8eyKf+2MnleBNWP5KziTAQqJim/m2CcDQF31/ScPCPZOutA==
X-Received: by 2002:a17:902:d4c8:b0:1d9:a674:aa77 with SMTP id
 o8-20020a170902d4c800b001d9a674aa77mr3557257plg.24.1707927747352; 
 Wed, 14 Feb 2024 08:22:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUX2ZMgiX5V3hzzskOHsslEay1S/kcjuq7RygRPUVxpHwWNhckxHlthhYGMR5SLldkY9JpChOhSIFpMUveD4U9BsPWdsSFgeIrV3gV/9ileUZZ+yUoBYS1HJ3oRvUHaKy/unzY/1xcRDkxK+u02I2J6KTmgh4r/e63Ri2Ewyk00nIdURpDZ9isdN9L1B1eEckT4F5y/1c4s/i7sEEmumcaZkzTLqLQT2wG48XGDR9RGYXXfcPruPVi8JU0lSkq+dJKBC+4xiR6DPSN/jBXS0Xt9R83xm5SaFnXZjuwIhRG8new2KlRgHwEA2VLovPfX9gSJ0AD5bBc7zS8Dr9AuRRphEkf556HBtj0JMYVBLDQ9/F1k0tJPQ0lYLayiMs7mSTi3/Bi2YXUi/aqjt6XOMywiHH3ceZd5TBJjdg==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 ji4-20020a170903324400b001da27b24a24sm3978135plb.1.2024.02.14.08.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 08:22:27 -0800 (PST)
Message-ID: <ee785cca-76c0-4e27-babe-907e849ef0bb@daynix.com>
Date: Thu, 15 Feb 2024 01:22:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
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
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
 <20240214015107-mutt-send-email-mst@kernel.org>
 <dbb8562b-6532-45af-a6fe-63bbf9b74a1d@daynix.com>
 <20240214105244-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214105244-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

On 2024/02/15 0:54, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 11:49:52PM +0900, Akihiko Odaki wrote:
>> On 2024/02/14 15:52, Michael S. Tsirkin wrote:
>>> On Wed, Feb 14, 2024 at 02:13:43PM +0900, Akihiko Odaki wrote:
>>>> The guest may write NumVFs greater than TotalVFs and that can lead
>>>> to buffer overflow in VF implementations.
>>>>
>>>> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    hw/pci/pcie_sriov.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>>> index a1fe65f5d801..da209b7f47fd 100644
>>>> --- a/hw/pci/pcie_sriov.c
>>>> +++ b/hw/pci/pcie_sriov.c
>>>> @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
>>>>        assert(sriov_cap > 0);
>>>>        num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>>>> +    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
>>>> +        return;
>>>> +    }
>>>
>>>
>>> yes but with your change PCI_SRIOV_NUM_VF no longer reflects the
>>> number of registered VFs and that might lead to uninitialized
>>> data read which is not better :(.
>>>
>>> How about just forcing the PCI_SRIOV_NUM_VF register to be
>>> below PCI_SRIOV_TOTAL_VF at all times?
>>
>> PCI_SRIOV_NUM_VF is already divergent from the number of registered VFs. It
>> may have a number greater than the current registered VFs before setting VF
>> Enable.
>>
>> The guest may also change PCI_SRIOV_NUM_VF while VF Enable is set; the
>> behavior is undefined in such a case but we still accept such a write. A
>> value written in such a case won't be reflected to the actual number of
>> enabled VFs.
> 
> OK then let's add a comment near num_vfs explaining all this and saying
> only to use this value. I also would prefer to have this if
> just where we set num_vfs. And maybe after all do set num_vfs to
> PCI_SRIOV_TOTAL_VF? Less of a chance of breaking something I feel...

I don't think we need a comment for this. In general, it should be the 
last thing to do to read the PCI configuration space, which is writable 
by the guest, without proper validation. And such a validation should 
happen in the internal of the capability implementation.

I think the core of the problem in nvme is that it decided to take a 
look into SR-IOV configurations. It should have never looked at 
PCI_SRIOV_CTRL or PCI_SRIOV_NUM_VF.

