Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB451C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRdI-0007XD-Kt; Mon, 12 Feb 2024 03:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZRdC-0007Wp-T7
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZRdB-0002jO-39
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707726335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Si8xiq/4KEOYL4JxB0L+QRs1AYEI9TZrK09fuUetg8=;
 b=Hjld3ijJGich+NvFGz4csquRdahtLIuTAUovgT9KA7aMBXCv5KJBowJvCfnCNkUE4yFF1l
 S5+lUkKY7Zt8mJ45FV1HiiAi4F7wJac+AMJLF/uOPAeHjlW5x3SZ7qyTzhmj36eX2TcZ1Y
 HEmktC5vifJQaPK8ZVbb+DxOELYhz+s=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-WK1HZFPLNleHVWhkC2GY-Q-1; Mon, 12 Feb 2024 03:25:33 -0500
X-MC-Unique: WK1HZFPLNleHVWhkC2GY-Q-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bff70e7380so3085366b6e.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707726333; x=1708331133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Si8xiq/4KEOYL4JxB0L+QRs1AYEI9TZrK09fuUetg8=;
 b=tp8ExsKh5qHnH3jjcA3UXzX4h1FV+PsCmXu7cG4M5guGfbiqeDBnChIqN/v7GfzWcs
 Bpo8OvweU2kSLOnFn5iDHw/3QD22enyXinalyopH3zkPQL2nrHUoaL6+L9apRzw7M7yo
 uGwhcwvM/UxoHIPvIDXnsGKE1WSBqcHN4Jy7XpkKiJn2DHO0RIN2spm/k7DPnpJ9K77e
 uxapuqBbA1nyxDNiqpqGwitTrUfE79+3zuECJoAma/b9fV1aK9TUb7TUO2ob9V1ZS6mk
 46AOJ8R65sJot1w/ZgpjfQ6DixMgYEPkUHR9D/2f1dzcPevno16VOE9AjOj5D8USWeaI
 MNvQ==
X-Gm-Message-State: AOJu0YxPNX8VJuKMkpUz8HzwhVyN42/fF2fyAPC80t1GwwxKSjbOY18h
 P96MOUeUYAs2osKplIp87WhiWOy5JjdkYf7wFmgXzGfBR/girzWYwBECzIRjkTKE8MXWlM15Z0V
 n1SzuLM4trM01A38wJxpQ0TWL9VbECv+D88zN38NvDWESXx8rCYMJ
X-Received: by 2002:a05:6808:1988:b0:3c0:3306:a379 with SMTP id
 bj8-20020a056808198800b003c03306a379mr4715688oib.55.1707726332962; 
 Mon, 12 Feb 2024 00:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5MtKqBvZ2G1dwQOUBLh3EjyGvBiZ1k2mGveotq2XU67YGYBBhdP+rTsGX24XPN/bICMBe+w==
X-Received: by 2002:a05:6808:1988:b0:3c0:3306:a379 with SMTP id
 bj8-20020a056808198800b003c03306a379mr4715680oib.55.1707726332658; 
 Mon, 12 Feb 2024 00:25:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVt3fN4KWF+ENqG2X8QVQH2YZAFe+irKemqlmZconFhW6eSaVNuUZXPHQNCCGitCWiFlLmHTSN2BPwvtBiAZr6brRW5OemMSHwGKfSQls0vbiPC7HQJMKHZ9B4tGNQJX9AOnd79dh8wQFt/9XcvTD44DvTzX8LU10lqTV9AbvPsFIQP/0vvT+zhD8rSmKGlGkXcCe6aB0hgI/5Ejpcc+iowOrh6lwMrLbE1zbbtYJLvimrDYHZ9v8cwgTTpRz8TFAoL8R3bxHE9mfism1oo4zgZwdYSg7mYzbxeMWVxhyMbX7LbjrJ3cuPdidL6X6Ls0svSkapMcLY1iQfSfogrs3P3nnI80zGUhIEOZo1mQuVTagsfs2O4EqdHg1q48fD5y9Z8ooTMr/r2CChd5S8TLT1NtPk/3sUrqZ5k/ZT3QQ==
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a05622a005100b0042c58191861sm1579081qtw.53.2024.02.12.00.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:25:32 -0800 (PST)
Message-ID: <10bb153f-8e93-47f6-bfcd-d3c2416f03dc@redhat.com>
Date: Mon, 12 Feb 2024 09:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] vfio: Avoid inspecting option QDict for rombar
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
 <20240210-reuse-v2-2-24ba2a502692@daynix.com>
 <318f6a01-a72e-417e-8017-80a758605e98@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <318f6a01-a72e-417e-8017-80a758605e98@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/12/24 09:04, Philippe Mathieu-Daudé wrote:
> On 10/2/24 11:24, Akihiko Odaki wrote:
>> Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
>> enabled.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/vfio/pci.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index d7fe06715c4b..44178ac9355f 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1010,7 +1010,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>>   {
>>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
>>       off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
>> -    DeviceState *dev = DEVICE(vdev);
>>       char *name;
>>       int fd = vdev->vbasedev.fd;
>> @@ -1044,7 +1043,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>>       }
>>       if (vfio_opt_rom_in_denylist(vdev)) {
>> -        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
>> +        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
> 
> "pdev" is considered internal field, please use the DEVICE() macro
> to access it. 

Yes. I was just looking at  vfio_pci_size_rom(). There is a test at
the beginning of this routine which should be changed to use DEVICE()


     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
         if (vfio_opt_rom_in_denylist(vdev) && vdev->pdev.romfile) {
         ...


Thanks,

C.




