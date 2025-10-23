Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5A0CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBp5U-0006FN-4a; Thu, 23 Oct 2025 02:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBp5Q-00069A-5X
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:46:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBp5N-0002ap-VS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:46:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1102843f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761201968; x=1761806768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=je6WSncMjTpVDb/U6xATlVvmB79vlcDWY6gH/sVhpzA=;
 b=A1KyW54BLSBXXPLSQimJeutQBj43CrxhYRxcp2PV8tSWREyg4vvtiltgReDzljPbTW
 KqUb500LYuak9WloTI6RqkVnZqh04xArDcwpgOKo92vgV8tbE7jyW0p51Axd3UG452V1
 grtKNAysiaJ+bIiBKj4m/t/6D5ZquUwTOB6TzJ7aq77g296cgVedqepEt40x+v43BwHE
 LN4IdclBWj2sYtZ+aBw/kVjKhZwk06l2n9Wd6NAybe+ar+WRo6H48s7ogxMttPRUEYwj
 h/cY3lhMum2cIGxRwaZzOp3w5sxoqSABTABz8QKPwXM82NcKDnDfmcWdgkB8GnT98qRc
 YymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761201968; x=1761806768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=je6WSncMjTpVDb/U6xATlVvmB79vlcDWY6gH/sVhpzA=;
 b=xHxpDpyknBAO+bh1+QHCujanhbbiWHE6tpKZesKouwCeZmI7vWBDozXAQ1ELYRFvyk
 caxKN/jTyzQ+Vy/8wqmZ85twhLabI+fe5XL+ewMrx5dzwU9pikHcr32y6YiU7+dfZ9jp
 MZDCiP2OSXVSzQz2luBacBYKUjKcSj8+xFfbpH8YVahwF8oPCH+O42Zjw0RVtqtmrDlQ
 gfVcJm/5dcGp1KhEOT+biMgtSHn8Nsbu0vZa6T/hrjxLsdFhVzBeoF/MCE9J3MbqZTEE
 +nGRfwive2FKImnTsVGb0emnwfciyZRF/utCGrqLCTU3UHXAPIR2n/l5WgFkynINk2Su
 fOfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY79MN8TyVPaLwAjTe1FGVdDF6Uw1boZnTQOoEHM9jOKP6jst4uNlOxRg/buqMfFYlagkqJZNUa/Fu@nongnu.org
X-Gm-Message-State: AOJu0YwYh64Z5DcQPYEC+/r39mDfdl9M++mZPSpKAe/WDNs25D9Qpp2v
 3bzhne/rWMKoVmC9rxI0+d8CSlLR9RmKqwZHLb/tdVjMTxblhBI5QZhWp6A6fs84S+o=
X-Gm-Gg: ASbGncvrnS0PLHGe1S5oN+qKfeT3b3ahsvL2vNmYmHVBYKUrtMRsxN+BT2nfcUZndKX
 mw1ceEcRHjD2+5DxPy1FHsYYLx19wkcL43mjTleofWSEjRYZ/exkjrlsL46OV4cTkB+E3pcfl+2
 9QjLa3w4pL54SXm6RRBWaqxUhCbSKWDBLMNR7wn7JDIgXcgz/IDdCET9Brgetk5e8ZCHHpuEK/d
 suZNCIb9h6uMVXiI0wXVg82M3uNG824J8WgNrOb8uXp4veUP0Wl4sWMBeIoYVDrFbteWIh3Dv1L
 LvTvQD1abcRqd+7GhOtmRyvHy4I9Fzn9h8+x9EzaiV4WtzSdACsyp5SsCnFdo0wclBg5dP8SqUv
 1qJOZj74UN3gw3fuPIuiKDufgYKZa/7+JLxV6qm4owDNsX/Tx5iNRuwKmQjZDoJQVK40wJ/myGn
 wKVFKYRSvzz4+hed/28R637vpFS1Ke9oM3XsI97HMM7nACwBkB/VDZCw==
X-Google-Smtp-Source: AGHT+IGhjfOM69NG48aGlf3b1oOgVglT4fva2y4L0CsX4+BP5bbYf5NWDucnx5TcYXdvRbePxOcJzA==
X-Received: by 2002:a05:6000:40dd:b0:427:548:6e3b with SMTP id
 ffacd0b85a97d-42853264540mr4436345f8f.13.1761201967841; 
 Wed, 22 Oct 2025 23:46:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4298b996aaasm579621f8f.3.2025.10.22.23.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:46:07 -0700 (PDT)
Message-ID: <ee9b01ab-fd91-453e-b1d3-1a91d9447a2a@linaro.org>
Date: Thu, 23 Oct 2025 08:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] hw/ppc/pegasos2: Move hardware specific parts
 out of machine reset
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/10/25 02:06, BALATON Zoltan wrote:
> Move the pegasos2 specific chipset reset out from machine reset to a
> separate function and move generic parts that are not pegasos2
> specific from build_fdt to machine reset so now build_fdt only
> contains pegasos2 specific parts and can be renamed accordingly.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
>   1 file changed, 41 insertions(+), 38 deletions(-)


> -#define PCI1_IO_BASE  0xfe000000

Can't we keep such definition?

> @@ -308,23 +307,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
>   
>   static void pegasos2_superio_write(uint8_t addr, uint8_t val)
>   {
> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
> +    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
> +    cpu_physical_memory_write(0xfe0003f1, &val, 1);

Otherwise it is harder to notice we are accessing the MMIO mapped ISA space.

>   }
Consider renaming as pegasos_superio_write() since this method becomes
common to PegasOS I and II.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


