Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CC7C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRIo-0007j2-Lj; Mon, 12 Feb 2024 03:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRIj-0007i4-0g
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:04:29 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRIh-0007TD-Cy
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:04:28 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso3975210a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707725066; x=1708329866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CYoNKroLrH3noiNzewbGvblc9Y3/bwU8lA4ABt+GSe0=;
 b=O0TEGQfd7eM+AqhhSkn/VWuQXRrU9IQczC6CNhHxa18gAJCKj62E9FWHGmXweZzdeK
 fwgJMTVPnOm9mCGq6Qe4B/hRfADhIoSwNolfQtm0hdW7LRXK/ybm5Za4wJBHISX+KHkJ
 x2YY307Jz5kbH7Yzx0rj4HeJJ+p1UunVF+83wbys5qP1CcDtPKLJTjgT9fKZISBrr/tq
 WJMF4umXN8UvLmPFpkikhjz3Er1jtNtRywZqmDKHybG122Z71du/4ysru3WJWDzrbyIi
 no0AIPs6aDSTaalSF9rvKf7sO4m/Anwe/412D/BJc0VZdoacpa0fWoO3uQF0iqMzDOM4
 7T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725066; x=1708329866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYoNKroLrH3noiNzewbGvblc9Y3/bwU8lA4ABt+GSe0=;
 b=wxSOxAnnlJN1UbgT7QUifxudqUpnkxH+uBVk3QCrjoYOVQQtMay8KAM9IVtt2VJHG3
 FjrdGUTsPfb1O/AwS3cOr3HgeCj2PKkD9Rn0MYg1Wzk9zfA4tsy4U1p0Ut9uxu4/JrVZ
 5DkcFv059xRHtv9ClMV6Vlmq8B79qRaDRx3XSmAucEKfNTLNwyxXiOUI6N+VROXRaMij
 P9bSrceEzPJ0RqA6QbqZ1g6US2Bmf7z1LyStT+FN7Hfk8C8jO+OW3HzspIWJE33UGNBv
 rxI3dWp2TET+kZs5mk13BXlUaAkqo9PKUyyXNo2+9eXz+JRWWdLaa3/FG03SeCbqxF1w
 V2fA==
X-Gm-Message-State: AOJu0YyJY8ovgYTPtitO09hmefM+kwA65OSRSUxb4/kfjPPjbiURAkdj
 helO8y7NhIAwlM6nosX65gARKBYPHD2zqR0NyvEjRx1anCC15Y7XOnFqDIbXa1A=
X-Google-Smtp-Source: AGHT+IFrUxcn+gfn6m1rRgFV7IudMKYJSDqu3dlTr19JvHsxwuSq+bzofT5gHhyUZYB67t9uMlxBPA==
X-Received: by 2002:aa7:c496:0:b0:561:206:4995 with SMTP id
 m22-20020aa7c496000000b0056102064995mr3962954edq.38.1707725065756; 
 Mon, 12 Feb 2024 00:04:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVirHNrCZ/WJhdMJr8V8HN2VlvbIiyPHDpG0jjfRt9XReUNNEX9N2iwAy6FAyg0GgkMQvY33J18GCpu2DR9Szur6jN1KEEea5SmzGfANutQ/a0xndEcJ41iDki1creSrVhnVfAMbiC+ZLJ++PsZQEV68574QPsvQ3EYbB3dARupR/S0uC1vyixXsS4emd4DaokAjz3XGU4CrtxBVcLyBTG6jJ11+nvOCLYQ+yumYATpLtWOBBZQZux81zCCkVbsPV98n5bGjucprF9JWh70+vct9qwlrnFr3baNeESQVsk1UZSNP3Thog5Ff3EJMO4MkUyJxpyfhko7FygmwPna165DGbo53sUvNQ+Qr8C0ztXzdlxEeNqpKCDEvsd1x1v2qj1DwRienS33Ick3yMDGCstKDkaq
Received: from [192.168.69.100] (vau06-h02-176-184-43-97.dsl.sta.abo.bbox.fr.
 [176.184.43.97]) by smtp.gmail.com with ESMTPSA id
 et13-20020a056402378d00b0055d19c9daf2sm2490156edb.15.2024.02.12.00.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:04:25 -0800 (PST)
Message-ID: <318f6a01-a72e-417e-8017-80a758605e98@linaro.org>
Date: Mon, 12 Feb 2024 09:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] vfio: Avoid inspecting option QDict for rombar
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
 <20240210-reuse-v2-2-24ba2a502692@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240210-reuse-v2-2-24ba2a502692@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/2/24 11:24, Akihiko Odaki wrote:
> Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
> enabled.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/vfio/pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7fe06715c4b..44178ac9355f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1010,7 +1010,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>   {
>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
>       off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
> -    DeviceState *dev = DEVICE(vdev);
>       char *name;
>       int fd = vdev->vbasedev.fd;
>   
> @@ -1044,7 +1043,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>       }
>   
>       if (vfio_opt_rom_in_denylist(vdev)) {
> -        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
> +        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {

"pdev" is considered internal field, please use the DEVICE() macro
to access it. With that:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


