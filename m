Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80198D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9bq-0001Lo-Ri; Mon, 02 Dec 2024 11:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9bo-0001LW-Rq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:49:16 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9bm-00061J-Hf
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:49:16 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-7fc2dbee20fso3230697a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733158152; x=1733762952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GoDWQ5BGb9hrWu8HLLsfCdNn51qPwK7te6OS1LouJp8=;
 b=MQTml+IWW6EPNVkiTGRzGoolrl3rwVvbYRER7KiPx9DT18wixpzyXsELqvwfmcUBe+
 IwkINPrvSBgyMuJLdE1xXW67/8HGqkzsNIIEvkJ0cUSRgYjg0OGMAtfkwnh0z3o7j+SK
 BrWGMqDiYlLW8LPcCPXrP8swEQBIyyDpITPxuYmrTW+dvYKNKUnCUjuth3gVYOEjlV8e
 fUjz/HEgO8Si7V7p87aOYiVsjRXhZnWGYi04AY3q4GdONZUjlgBb7HJcu/EmO+qJWukl
 V+OwN2TgfcpLKsrH7UKgRs9yNa9rf9rlXdk03vu88hKVCjOYFLjTBh/SnrrL0FA6/GUG
 Rcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733158152; x=1733762952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GoDWQ5BGb9hrWu8HLLsfCdNn51qPwK7te6OS1LouJp8=;
 b=F6Uho7i0XzCSaaSGXeuRi5lgnILmuOtbMOU3SbVvA1cvyr6DQZJpopGZ7FQOmeT/g/
 itQx6DV7QPILi7UCd+ZiZ1ym5JSydX6VKn1kU7Yjs1vVOKLaRBseH7fhjWX8kOaYJfhI
 E40eDPwIvS7jI/hVAcCasvY+r5szwZTBuQXft1aBKNvWMohiDh9UMI5lgH2tvx18+/+f
 ZiXk7yhjeJoS+TTTbAZf2fOGExX27vddKJiMMbXCGx3J41lTs8rL0jj23bRQYr5vnMG7
 XMD9dSe+47Fp/ny3x7GCuqSuQZoEL9pifetOTUVrq4b9y8Qj/Ui+fGb+WPBDNU4NFgLT
 gUag==
X-Gm-Message-State: AOJu0YyTd7QXn2zGwF43LQ+T3DYQxt5Tlg/UqSn+AEmhayeMN/VxA1KY
 8vpt7BROtrR+jxR2jV0H28WkqMg7InzeEdL+Db8zAWd3Y2B7i6/9TqFTirXjNQ==
X-Gm-Gg: ASbGncsnAN5btcXW+4PiKAyKFsrd1/5amlf+hAdXjvLrNoDSRsDgtn968ddMTt9+OQq
 COhiNTsvnnkxeqM69HKhbjZFtbyEPVfeCfNGh36TuXJk6woQAaisJzE8leBKyCFToUp36M05pMw
 9MyWpLIsHTjw6YinRqH+NRChSgCrhQ5oeWEc+xJkH4hdBKoRRp+XGQZcyGBYRdy5HoJbkFdxjkL
 v5cqTheQKWuRdJsSUObOUBk01+Aam+Au70d44j/yJ+CxGCCVYmnKyc=
X-Google-Smtp-Source: AGHT+IHs6nJn7nYpYZXsZ5ApNdynySn3Jh6BrXt7XWtFd4NpK0A7oV5GPaCtsihzOA/dUIEkARM4Fg==
X-Received: by 2002:a05:6a21:9998:b0:1db:ef2f:d6f0 with SMTP id
 adf61e73a8af0-1e0e0b5027bmr35660693637.19.1733158152354; 
 Mon, 02 Dec 2024 08:49:12 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254181479dsm8707169b3a.159.2024.12.02.08.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 08:49:12 -0800 (PST)
Message-ID: <40dec4d0-e2d3-4d4f-bbc0-1a9e94dd8b63@gmail.com>
Date: Tue, 3 Dec 2024 00:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] vfio/igd: canonicalize memory size calculations
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-3-tomitamoeko@gmail.com>
 <20241201222843.6f415e29.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20241201222843.6f415e29.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x542.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 12/2/24 13:28, Alex Williamson wrote:
> On Mon,  2 Dec 2024 00:09:32 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
>> calculating GTT stolen memory and Data stolen memory size in bytes,
>> and use macros to replace the hardware-related magic numbers for
>> better readability.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++----------------------
>>  1 file changed, 57 insertions(+), 44 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index e40e601026..b449316ec0 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -116,6 +116,54 @@ typedef struct VFIOIGDQuirk {
>>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>>  
>> +#define IGD_GMCH_GEN6_GMS_SHIFT     3
>> +#define IGD_GMCH_GEN6_GMS_MASK      0x1f
>> +#define IGD_GMCH_GEN6_GGMS_SHIFT    8
>> +#define IGD_GMCH_GEN6_GGMS_MASK     0x3
>> +#define IGD_GMCH_GEN8_GMS_SHIFT     8
>> +#define IGD_GMCH_GEN8_GMS_MASK      0xff
>> +#define IGD_GMCH_GEN8_GGMS_SHIFT    6
>> +#define IGD_GMCH_GEN8_GGMS_MASK     0x3
>> +
>> +static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
>> +{
>> +    uint64_t ggms;
>> +
>> +    if (gen < 8) {
>> +        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
>> +    } else {
>> +        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
>> +        ggms *= 2;
>> +    }
>> +
>> +    return ggms * MiB;
>> +}
>> +
>> +static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>> +{
>> +    uint64_t gms;
>> +
>> +    if (gen < 8) {
>> +        gms = (gmch >> IGD_GMCH_GEN6_GMS_SHIFT) & IGD_GMCH_GEN6_GMS_MASK;
>> +    } else {
>> +        gms = (gmch >> IGD_GMCH_GEN8_GMS_SHIFT) & IGD_GMCH_GEN8_GMS_MASK;
>> +    }
>> +
>> +    if (gen < 9) {
>> +        if (gms < 0x10) {
>> +            return gms * 32 * MiB;
>> +        }
> 
> igd_get_stolen_mb() used:
> 
>         if (gms > 0x10) {
>             error_report("Unsupported IGD GMS value 0x%x", gms);
>             return 0;
>         }
>         return gms * 32;
> 
> Therefore this should use <= to be equivalent.

Got it, will fix in v2

>> +    } else {
>> +        if (gms < 0xf0) {
>> +            return gms * 32 * MiB;
>> +        } else {
>> +            return (gms - 0xf0 + 1) * 4 * MiB;
> 
> This does not match the line from igd_get_stolen_mb():
> 
>             return (gms - 0xf0) * 4 + 4;
> 
> Explain.

It was changed to return size in bytes, instead of size in MB, to make
the behavior of 2 size calculation functions consistent. Original one
should be changed to.
	return ((gms - 0xf0) * 4 + 4) * MiB;
Then I changed it to
	return (gms - 0xf0 + 1) * 4 * MiB;
to make it easier to read. gms is uint64, the masked value is 0xff at
most, +1 won't cause overflow here.

>> +        }
>> +    }
>> +
>> +    error_report("Unsupported IGD GMS value 0x%lx", gms);
>> +    return 0;
>> +}
>>  
>>  /*
>>   * The rather short list of registers that we copy from the host devices.
>> @@ -264,17 +312,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>>  static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>>  {
>>      uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>> -    int ggms, gen = igd_gen(vdev);
>> -
>> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>> -    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen > 7) {
>> -        ggms = 1 << ggms;
>> -    }
>> -
>> -    ggms *= MiB;
>> +    int gen = igd_gen(vdev);
>> +    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
>>  
>> -    return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
>> +    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
>>  }
>>  
>>  /*
>> @@ -481,30 +522,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>  }
>>  
>> -static int igd_get_stolen_mb(int gen, uint32_t gmch)
>> -{
>> -    int gms;
>> -
>> -    if (gen < 8) {
>> -        gms = (gmch >> 3) & 0x1f;
>> -    } else {
>> -        gms = (gmch >> 8) & 0xff;
>> -    }
>> -
>> -    if (gen < 9) {
>> -        if (gms > 0x10) {
>> -            error_report("Unsupported IGD GMS value 0x%x", gms);
>> -            return 0;
>> -        }
>> -        return gms * 32;
>> -    } else {
>> -        if (gms < 0xf0)
>> -            return gms * 32;
>> -        else
>> -            return (gms - 0xf0) * 4 + 4;
>> -    }
>> -}
>> -
>>  void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>  {
>>      g_autofree struct vfio_region_info *rom = NULL;
>> @@ -514,7 +531,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>      VFIOQuirk *quirk;
>>      VFIOIGDQuirk *igd;
>>      PCIDevice *lpc_bridge;
>> -    int i, ret, ggms_mb, gms_mb = 0, gen;
>> +    int i, ret, gen;
>> +    uint64_t ggms_size, gms_size;
>>      uint64_t *bdsm_size;
>>      uint32_t gmch;
>>      uint16_t cmd_orig, cmd;
>> @@ -676,13 +694,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>  
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>  
>> -    /* Determine the size of stolen memory needed for GTT */
>> -    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen > 7) {
>> -        ggms_mb = 1 << ggms_mb;
>> -    }
>> -
>> -    gms_mb = igd_get_stolen_mb(gen, gmch);
>> +    ggms_size = igd_gtt_memory_size(gen, gmch);
>> +    gms_size = igd_stolen_memory_size(gen, gmch);
>>  
>>      /*
>>       * Request reserved memory for stolen memory via fw_cfg.  VM firmware
>> @@ -693,7 +706,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       * config offset 0x5C.
>>       */
>>      bdsm_size = g_malloc(sizeof(*bdsm_size));
>> -    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
>> +    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
>>      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
>>                      bdsm_size, sizeof(*bdsm_size));
>>  
>> @@ -744,5 +757,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>                       vdev->vbasedev.name);
>>      }
>>  
>> -    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
>> +    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, *bdsm_size / MiB);
> 
> Technically this should use le64_to_cpu(*bdsm_size), or retain the
> addition logic.  Thanks,

Got it.

> Alex
> 


