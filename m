Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02D3C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 17:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpVmC-0001md-6E; Tue, 04 Mar 2025 12:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tpVm9-0001mF-UQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 12:09:50 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tpVm7-00005g-Qh
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 12:09:49 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22349bb8605so114839785ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741108186; x=1741712986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cPEpOdIN+PsD1qFMx2R4+lH1tzPvC7S2W4TMJUMHGcU=;
 b=ZY5Vzv6TdSCkdaFOwcQvbmFDgE7jIiK1xD0Hk6+3CiyHwvj7jpV0N0xO/3ABPSjcbh
 g8vjpFMYMFjA0GqfReSd8IfDI0XheFz4bdXEIKTLfE1mNPwWO3lHHFvEjsfNejTCqJoV
 mVKDhSsEPtmavOfLBEIHk6IjHNcuYKi3TcPjq3Ehipw79SZnxj1KgH+n5tUqW3TJPshu
 bpYrCnweg+p0eBX+TU6FTm0KSkFU5B4uOOUE0SG6NzMv+pIQC+8ejDVVfxUKRoISdLnN
 71sFcG3EF8UIePDKrkWUjXaeJ+aUGslctFFMR/qYu4gnBhTH6dU+PAgNOBCZ7bhJE84N
 MmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741108186; x=1741712986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cPEpOdIN+PsD1qFMx2R4+lH1tzPvC7S2W4TMJUMHGcU=;
 b=eQ7hzmA7m6EO0r7ZU+kZPf8K1mEln3Hn53P3g5Zt6LIpsxWyxr0zt2s1Ep6G+6S8LA
 7DHnAzoFlXWia93zm1XfH/C5Szvz1V3KVKlZNb/fg3ruJSKibcTQtIR0x1BHjuGRw/xB
 r/lyStFEFSjtP5o11Uf5ZOyGzqSHEPFop3Lwe64V4SGc9H2Nf37thhFBWx1irwA8yIWc
 E5JL4J0n4GKR92TJsQwQ3HXg3ffRFXl+1xjJ55xLCLu70M6fhtTiLv89sOeBPRxAlNlW
 gWJtos/k5td3Fj8xa80kizPvHhe2glXuDN7n73wY1gtxVLeZhL7OJaDx502ji/Dqeg8J
 BE0w==
X-Gm-Message-State: AOJu0YxEvNedIA/2GiUeZ8i1CmFPmyzvo2dvtTyhCBdLIc+Ni/zNhi8+
 A0JkepB+0PbrNwThdRWB9uIqly2f/M6o4sX6H/4TKgECoFJUsZs=
X-Gm-Gg: ASbGncsl7bDEPzFQCthlYarI4JL1rv1ZmEdJfdkrD3Q4B6zx0J5PuED1sm3sGEXhmXC
 71Y1ciEfTlIdGZZURMB4b5HKo4qAV0GDt3uhDaB1XLqYGS3BntydRZrujc4MFQuP+U/zXP6QKKv
 h3oF1T14PIaPSM5qN4wYokCcUzxas/oy9pU+lb94oGVtK0nYSjh/Dlf05TTAYWxCZP1/4S2ltbA
 4mFOUCtMqWxB5NPosMIwJtXwGLkyAYvhhDLFziXQIPAEjEGnYYl0D8+KGoVOgcMU2OscTOBAxf7
 l7TA4Qh7LdPBREu6sfYMQyPkYYcJ63g1sUxLPAbf8cS09PabwA==
X-Google-Smtp-Source: AGHT+IEIR8RygFaQmrPsKN0OG6RKmJ3oukDE9JLw95+4Y4idwi2yuI6vQKlGeKbuIE6x6pP8mexlTg==
X-Received: by 2002:a17:902:cccc:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-223692605afmr291825045ad.46.1741108186087; 
 Tue, 04 Mar 2025 09:09:46 -0800 (PST)
Received: from [192.168.0.113] ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5c45sm98082665ad.116.2025.03.04.09.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 09:09:45 -0800 (PST)
Message-ID: <0bff4dc3-bbc6-4922-ad3d-081e4a58c125@gmail.com>
Date: Wed, 5 Mar 2025 01:09:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] vfio/igd: Do not include GTT stolen size in
 etc/igd-bdsm-size
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
 <20250303175220.74917-3-tomitamoeko@gmail.com>
 <e8a2be911535f345e8008b0dfccf8cd7a989578f.camel@gmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <e8a2be911535f345e8008b0dfccf8cd7a989578f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

On 3/4/25 15:17, Corvin Köhne wrote:
> On Tue, 2025-03-04 at 01:52 +0800, Tomita Moeko wrote:
>> Though GTT Stolen Memory (GSM) is right below Data Stolen Memory (DSM)
>> in host address space, direct access to GSM is prohibited, and it is
>> not mapped to guest address space. Both host and guest accesses GSM
>> indirectly through the second half of MMIO BAR0 (GTTMMADR).
>>
>> Guest firmware only need to reserve a memory region for DSM and program
>> the BDSM register with the base address of that region, that's actually
>> what both SeaBIOS[1] and OVMF does now.
>>
> 
> When was this merged to OVMF?

It was not merged to upstream OVMF, but how GSM is set up in the widely
used IgdAssignmentDxe is the same as SeaBIOS. Will clearify it in v3.

Background of how it was not merged to OVMF can be found in edk2 mailing
list
https://edk2.groups.io/g/bugs/search?q=%5BBug%20935%5D
 
>> [1]
>> https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 28 +++-------------------------
>>  1 file changed, 3 insertions(+), 25 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index ca3a32f4f2..dda4c7bb5d 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -112,28 +112,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>  
>>  #define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
>>  #define IGD_GMCH_GEN6_GMS_MASK      0x1f
>> -#define IGD_GMCH_GEN6_GGMS_SHIFT    8
>> -#define IGD_GMCH_GEN6_GGMS_MASK     0x3
>>  #define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
>>  #define IGD_GMCH_GEN8_GMS_MASK      0xff
>> -#define IGD_GMCH_GEN8_GGMS_SHIFT    6
>> -#define IGD_GMCH_GEN8_GGMS_MASK     0x3
>> -
>> -static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
>> -{
>> -    uint64_t ggms;
>> -
>> -    if (gen < 8) {
>> -        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
>> -    } else {
>> -        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
>> -        if (ggms != 0) {
>> -            ggms = 1ULL << ggms;
>> -        }
>> -    }
>> -
>> -    return ggms * MiB;
>> -}
>>  
>>  static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>>  {
>> @@ -367,7 +347,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int
>> nr)
>>      g_autofree struct vfio_region_info *lpc = NULL;
>>      PCIDevice *lpc_bridge;
>>      int ret, gen;
>> -    uint64_t ggms_size, gms_size;
>> +    uint64_t gms_size;
>>      uint64_t *bdsm_size;
>>      uint32_t gmch;
>>      Error *err = NULL;
>> @@ -527,7 +507,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int
>> nr)
>>          }
>>      }
>>  
>> -    ggms_size = igd_gtt_memory_size(gen, gmch);
>>      gms_size = igd_stolen_memory_size(gen, gmch);
>>  
>>      /*
>> @@ -539,7 +518,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int
>> nr)
>>       * config offset 0x5C.
>>       */
>>      bdsm_size = g_malloc(sizeof(*bdsm_size));
>> -    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
>> +    *bdsm_size = cpu_to_le64(gms_size);
>>      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
>>                      bdsm_size, sizeof(*bdsm_size));
>>  
>> @@ -559,6 +538,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int
>> nr)
>>          pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
>>      }
>>  
>> -    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
>> -                                    (ggms_size + gms_size) / MiB);
>> +    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
>>  }
> 

