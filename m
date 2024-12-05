Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFC0E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ8rW-0006HV-MB; Thu, 05 Dec 2024 05:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ8rU-0006H4-Ly
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:13:32 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ8rR-00015W-VZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:13:32 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so527363a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733393608; x=1733998408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ZT4+xyFUGvZMhA4UXXR/YhpkMwmFqrhbVufo0kkNW4=;
 b=gjZUPPwJvToldlFLBQ1eqvaY8BVmgDpApZG4F37CjaW2D5o+ia5SQfnMsyIAiyA4cC
 cyxBUtdvUpCGP/J+q4K5hZyFo7iFktw5WwYxrdd4vkUZDyHjypTZKHoekKlVE+ox3Pys
 +0MMImcUKrtyDh04JtFFK/6+CIxXuOr04iUnRDcuKXBAHf6QKXPejnFUELGAFufozfND
 JrVJETFrHSsMcmciAx3+VtrxV+akrCZ3VlaNmyVaTpE/9oKWFjRlXKeOrGEeljUybL+L
 xPKwPQf2dBfiPp6rzfTtvfHHgLzVzNPc3s9aLIF8aFIFdXkCmouwuGKybhA5hlRvnVD5
 Pkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733393608; x=1733998408;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZT4+xyFUGvZMhA4UXXR/YhpkMwmFqrhbVufo0kkNW4=;
 b=F71c3onUmCWSFrYkubqlJwaIEowtLVNKOmV6o/XjMPmEuB95cDqu/QG5vJbnrPa+Tz
 ODXucv0/z2GzfEu9VqKfkcKvgQJ2D1/tz/VdP5fezG2bTPNcspIwUrFtrF5cg11IokA9
 CZPqoYk4fI5FEBlHl2lE6ZUMOX6/LeT59mUxjMHoI4hEJtBM3n6m+GeTGWp9f0TAAcfV
 V2OkoPkRXXRE2Cga/Ewi33jCD05za13lRcsOjqwt0vrmcgWoJACN0whl6oShRJVVSMBi
 b9EXM7E8N7Arxd80Ddv7ClDh2tmU6FzbWU3TMTom1bSIfXSzbVsMNDBf2B+8acASjqkV
 xr3g==
X-Gm-Message-State: AOJu0YzvJbgRcQj5REZMLFqH+tNKjhxXRw5l0jqT6u6dP4xBeKSnOceU
 Ab19XzJWxyXmsZq7Ztzw1sN8NqedlWnx20cht1/PU4W40c8OBwE=
X-Gm-Gg: ASbGncu/4rNWnWwmETZScFpXGeRHO6HdPiapz6Yp2SjzUeoA+DdTxnHJ2Qwt9yB/a+I
 I8CpHPZeh+bKg8JcjrCmYih13ELDGttrSGusdIXS63poyTVIhtK5gQTTJNtH+7NxmLK5b7qZWLl
 PPdaF/eSFCW/zHlBp2MdTbFB4OdQ4AKuowzHeHBuS48R+X+/LHuoBIFOUy4k6i1N9aiiHdqA0Ln
 wCeF6S/mr8FRycutwX4+5WrnnCD05qTflZvG/FMk+ELcsVvP5aYkA==
X-Google-Smtp-Source: AGHT+IF1XJIcOUx1Xgf/de1XdlXpWe8P+WZjX27G6Zo3zHkhCLq3cmbsKlaTXLSlCaJnZT4Cibo0vQ==
X-Received: by 2002:a17:90b:1643:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2ef012796bdmr14020254a91.33.1733393608144; 
 Thu, 05 Dec 2024 02:13:28 -0800 (PST)
Received: from [192.168.0.163] ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef26ff8457sm2920858a91.7.2024.12.05.02.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 02:13:27 -0800 (PST)
Message-ID: <b160547b-0856-43a4-ae21-3f689fec8840@gmail.com>
Date: Thu, 5 Dec 2024 18:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tomita Moeko <tomitamoeko@gmail.com>
Subject: Re: [PATCH v2 3/9] vfio/igd: canonicalize memory size calculations
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-4-tomitamoeko@gmail.com>
 <20241204153559.18b9847f.alex.williamson@redhat.com>
Content-Language: en-US
In-Reply-To: <20241204153559.18b9847f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1041.google.com
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

On 12/5/24 06:35, Alex Williamson wrote:
> On Tue,  3 Dec 2024 21:35:42 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
>> calculating GTT stolen memory and Data stolen memory size in bytes,
>> and use macros to replace the hardware-related magic numbers for
>> better readability.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 99 ++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 55 insertions(+), 44 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 2ede72d243..b5bfdc6580 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -106,6 +106,51 @@ typedef struct VFIOIGDQuirk {
>>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>>  
>> +#define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
>> +#define IGD_GMCH_GEN6_GMS_MASK      0x1f
>> +#define IGD_GMCH_GEN6_GGMS_SHIFT    8
>> +#define IGD_GMCH_GEN6_GGMS_MASK     0x3
>> +#define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
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
> 
> I tried to ask whether this was a bug fix in the previous iteration,
> but I think it was overlooked.  These are not the same:
> 
> 	ggms *= 2;
> 
> 	ggms = 1 << ggms;
> 
> Comparing the 4th processor generation datasheet[1] to that of the 5th
> generation processor[2], I see:
> 
> 4th:
> 	0x0 = No Preallocated Memory
> 	0x1 = 1MB of Preallocated Memory
> 	0x2 = 2MB of Preallocated Memory
> 	0x3 = Reserved
> 
> 5th:
> 	0x0 = No Preallocated Memory
> 	0x1 = 2MB of Preallocated Memory
> 	0x2 = 4MB of Preallocated Memory
> 	0x3 = 8MB of Preallocated Memory
> 
> In your update, we'd get ggms values of 2, 4, and 6, which is
> incorrect.  The existing code is correct to use the ggms value as the
> exponent, 2^1 = 2, 2^2 = 4, 2^3 = 8.  It does seem there's a bug at
> zero though since 2^0 = 1, so maybe we should pull out the fix to a
> separate patch:
> 
> 	if (ggms) {
> 		ggms = 1 << ggms;
> 	}
> 
> Thanks,
> Alex
> 
> [1]https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf (3.1.13)
> [2]https://www.intel.com/content/www/us/en/content-details/330835/5th-generation-intel-core-processor-family-volume-2-of-2-datasheet.html (3.1.13)

Sorry it was my mistake, the original code `1 << ggms` is correct.

I will create a new patch to fix it at first in v3. Thank you for
pointing out it.

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
>> +            return gms * 32 * MiB;
>> +    } else {
>> +        if (gms < 0xf0) {
>> +            return gms * 32 * MiB;
>> +        } else {
>> +            return (gms - 0xf0 + 1) * 4 * MiB;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>>  
>>  /*
>>   * The rather short list of registers that we copy from the host devices.
>> @@ -254,17 +299,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>>  static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>>  {
>>      uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>> -    int ggms, gen = igd_gen(vdev);
>> -
>> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>> -    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen >= 8) {
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
>> @@ -471,30 +509,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
>> @@ -504,7 +518,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>      VFIOQuirk *quirk;
>>      VFIOIGDQuirk *igd;
>>      PCIDevice *lpc_bridge;
>> -    int i, ret, ggms_mb, gms_mb = 0, gen;
>> +    int i, ret, gen;
>> +    uint64_t ggms_size, gms_size;
>>      uint64_t *bdsm_size;
>>      uint32_t gmch;
>>      uint16_t cmd_orig, cmd;
>> @@ -666,13 +681,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>  
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>  
>> -    /* Determine the size of stolen memory needed for GTT */
>> -    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>> -    if (gen >= 8) {
>> -        ggms_mb = 1 << ggms_mb;
>> -    }
>> -
>> -    gms_mb = igd_get_stolen_mb(gen, gmch);
>> +    ggms_size = igd_gtt_memory_size(gen, gmch);
>> +    gms_size = igd_stolen_memory_size(gen, gmch);
>>  
>>      /*
>>       * Request reserved memory for stolen memory via fw_cfg.  VM firmware
>> @@ -683,7 +693,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       * config offset 0x5C.
>>       */
>>      bdsm_size = g_malloc(sizeof(*bdsm_size));
>> -    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
>> +    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
>>      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
>>                      bdsm_size, sizeof(*bdsm_size));
>>  
>> @@ -734,5 +744,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>                       vdev->vbasedev.name);
>>      }
>>  
>> -    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
>> +    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
>> +                                    (ggms_size + gms_size) / MiB);
>>  }
> 


