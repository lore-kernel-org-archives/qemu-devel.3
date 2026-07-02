Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E79C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfFqe-0001hS-Eb; Thu, 02 Jul 2026 07:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfFqd-0001hJ-Fa
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 07:44:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfFqb-00032a-I0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 07:44:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662AFVxs3460566
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 11:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 asCPuNecIEhhyleojB14Jv4MElxuIHDuF3lm/xzKAzI=; b=Fxg5erjXTRkvVVvk
 8VsJJsHIba+h//CPFcymynJk/Z6Ckvcg1sQkRnKXwEcLSAMwAlfNUZy55XugPx7M
 tmuwqIMPWIUTMy3SYDeXBV4DmKEemyoidATSrETfT/RhRbkBE07mRWo1gTh91bq+
 /DhDMmSEvzjqrUXKyHKluFnFfAFGloiqrt6EhF2SJ/lGIZKGby360tWiqDq5EXSk
 +ku9Q2o8TVJBxq++Gn7tnMs9ysqb5WC5Pg3GaEGAbMINkRDbdSN9zAxf1Je3PNU/
 MKHSb+dwVY4kIVhm8+fVkpWjSm2FXpt1Z3YwInMTnzk4b86qF71li0yVnPq5n9/I
 5rT4BQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5gmb1nm3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:44:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eb8914e651so35396296d6.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782992686; x=1783597486; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=asCPuNecIEhhyleojB14Jv4MElxuIHDuF3lm/xzKAzI=;
 b=I0ac6acX4FbY5xlNinjIPQzwg3pLFzwgujn50Ask6qem9xv0ljVKBtSlPfANfBoE2v
 FZVD6a9eRXCVii4j88ZCYVUg/L6zb7fpYVWtqZaM/70iD7RFTHUQk15BWOGkCCIYN16l
 2ReBYX5quGpREEGGyTCCAEnzO7EYN8CjoHNuhYSp7yZN2F0ndaNDq9VwYcvu7O4P4F08
 Ph1BFb2TAVSkSLBtaPm3FTpWuDQr//gXRVMSYFlzbZlhLLhzpecEFYsY89Lxgx3zmhwk
 M/dRYG4bF1Fl6CFXBveHZFQ7esgyF174jNzBKeITvdOxZwuOv9HPiSovi/NrXlqTAzAQ
 9GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782992686; x=1783597486;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asCPuNecIEhhyleojB14Jv4MElxuIHDuF3lm/xzKAzI=;
 b=AqeCuIll6mAx7PYUjOlF0xNqluV5TMDdIbTqlFLkrr2zB0SfkZjr04q3DvQm6uVcTe
 A7d8wWDuSq84fANDysWg/BGjApSHyU2a6oQ2Si+llJKAF+bLVcBrlTU0eKuBXmkwvFN6
 H3L+HWaYbWynWuLNZvlrzuI5ShLbm/jHy5w/8a8VvWnwM+jRISV2PTvT8PE4a4mEGJJJ
 d8DLggDjoIHUGi7PFMEzBqzUUVO5tDvXRZOjRhJ4Ec/j9UDvQ6YKFUDy89n0fFIq0Zvp
 6tOIpIWmzK1wlyUadID7kOD2oNgWuDcqwshQxibYDJt2jgNwP2aADrx8v4pc4Ian5BWi
 xkag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrS1oW9L+8/y+yUH6lnKUdXlq8QAbqazwplLMHeAw1wPHQUGVanLTNj2fPJ4HYQ5ytVD1j9VZzzdW7J@nongnu.org
X-Gm-Message-State: AOJu0YxaeN6KQ2ReHNmKagKDg0KcdhLfgXtmvKcO6BC0jAYZc0guV9ME
 ZACgAki0e3fFTCF5iTnIfiPlmMKAqJFZLtJAjPBudFaVjCZg9CzuY/wwJmGup5NIp+sUhn3RmUI
 5PYXZhfVC8QyixrxoRL4dE8DOaE2BHrJy9NfimEUm+J8aQQgMGGJBbnHMdQ==
X-Gm-Gg: AfdE7clmox7vmCv3LOnPxRFjFIdu2gAA/G8ER5eMr0GMAptpi0dKMKCuP1mcbW4kQHV
 9sQV9WirIJUfoFzRzjG61MCoguc+2is3d9TBswtUGDlmnvNcUzhacKX0sI0QxdwoyZs+EVq7whv
 k4QR0l8nVzffCw1kP5ooZCjtL+f7VYzjmDbZw+KyxpE8L4vtQwGTsbrWAaoMPPpbq2THa44sK9v
 Zp+2cbGnyG4tIPZOc9Zp/1pQntqXKRiZKWEDQ5B6MUU1m0sRKgbrq0t+vsYuFN3mgHXCgA3vB95
 vhA7it7eRq12lL2uUA2VJyB/Z0rcgMFvPnnvpyIuXJIQO7iRdPJUBkRH9TKag4FXao+6LNvsw7p
 fqU8RKISxTE/1YWzhBqmPGUBBPSJ++3jSqet75Fznujyv
X-Received: by 2002:ad4:4ea9:0:b0:8ce:f1b:74ec with SMTP id
 6a1803df08f44-8f422b689efmr64190696d6.25.1782992685657; 
 Thu, 02 Jul 2026 04:44:45 -0700 (PDT)
X-Received: by 2002:ad4:4ea9:0:b0:8ce:f1b:74ec with SMTP id
 6a1803df08f44-8f422b689efmr64190386d6.25.1782992685043; 
 Thu, 02 Jul 2026 04:44:45 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46aecc908sm25714596d6.0.2026.07.02.04.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 04:44:44 -0700 (PDT)
Message-ID: <bd0fced4-9099-42f1-a7f5-0e192f7c490d@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 08:44:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/39] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>, alistair23@gmail.com,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
 <edd19559-f4ba-46eb-b979-700f5491981f@tls.msk.ru>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <edd19559-f4ba-46eb-b979-700f5491981f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: klEtR9me6v94KZTRL0km6GqMcjImeBWF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMSBTYWx0ZWRfX3ga1XTeLZLEJ
 sA8ikG2RIWlH3NOdv5KGp5ffFd/3RbWwgOATx+IMk8oZBIHpclTdPv7xg0SNpEjSaQRY5LJY4ha
 yCXJ/oc8/8mjaQ0i/TgEqCFn7GA4Q30=
X-Authority-Analysis: v=2.4 cv=aJ7Ab79m c=1 sm=1 tr=0 ts=6a464f2e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=J1SvRnXkda_BMJuSyvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMSBTYWx0ZWRfXyCjscgeFKNH7
 18sYOTDlQEU2iMfm7BX72jF18VRYLGWFzvpdEEaNBuuqk2k6FAmVJSb9odYjIs2mH/uVDljmzs9
 w/5fphfQW7jqct0MJjL30AgeXRvz254mzQEuPOqxKJJWtSoUhAydyYheUQ4Ue3flNPgKtgsX+yB
 t/x6By88RrYk01lRKxff7Wi3hOcTT5M2vJM6v7BgFrbmCttoLza/UEeO7A+NMl7XXsMVVtIQY/g
 dqe2odSwQoBULM1aXa0c191yAunUGVVqYuGEXJ21JWok9M/PQnX5nFTtuWGPrmyoGH7M01SD4UC
 miPhnaZleUAa4z5zR1GV5kCYJl7a9c+BCqqBNYmseQZhsbol+TBVM/jrYhMAbTv3EfyjtstPHNr
 HAza8bzUAoudjx2DEo8vtwL0b52DYQVRPUr9lneD34ipawlsOdG+co8IT0HUyh31EfKXoMhdH04
 0oFP1TOduv6eq/vVyNQ==
X-Proofpoint-ORIG-GUID: klEtR9me6v94KZTRL0km6GqMcjImeBWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020121
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Michael,

On 7/2/2026 7:54 AM, Michael Tokarev wrote:
> On 01.07.2026 13:17, alistair23@gmail.com wrote:
> ...
>> RISC-V PR for 11.1
>>
>> * Fix IMSIC CSR write and add tests
>> * Parametrise debug trigger number
>> * Add 'svbare' satp-mode
>> * Fix RINTC PLIC context ID for KVM
>> * Avoid abort when reading vtype before env->xl is set
>> * Skip reset for KVM irqchip
>> * Skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
>> * More FDT cleanups (PLIC)
>> * Make FCTL.BE in IOMMU read only 0
>> * Check DC.TC reserved bits in IOMMU
>> * Apply UXL WARL handling to vsstatus
>> * Set cmd_ill IOFENCE.C if rsvp bits are set in IOMMU
>> * Set RISCV_IOMMU_FQ_HDR_PV appropriately
>> * Fix MSI MRIF IOMMU interrupt-pending offset
>> * Report QEMU CPU archid as 42
>> * Check PMP before updating PTE
>> * Add the Tenstorrent Atlantis machine
>>
>> ----------------------------------------------------------------
>> Alistair Francis (1):
>>        hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr
>>
>> Charlie Jenkins (1):
>>        target/riscv: Report QEMU CPU archid as 42
>>
>> Chris Rauer (1):
>>        hw/i2c: Add DesignWare I2C Controller
>>
>> Daniel Henrique Barboza (16):
>>        target/riscv/cpu: add CPU unrealize callback
>>        target/riscv: dynamic alloc of debug trigger arrays
>>        target/riscv: add 'num-triggers' debug property
>>        target/riscv/cpu.c: add 'svbare' satp-mode
>>        hw/riscv/sifive_u.c: remove unneeded qemu_fdt_get_phandle() call
>>        hw/riscv/sifive_u.c: use intc_phandle in plic creation
>>        hw/riscv/sifive_u: add #address-cells in PLIC FDT
>>        hw/riscv/virt.c: change 'plic' nodename to 'interrupt-controller'
>>        hw/riscv: add create_fdt_plic() helper
>>        hw/riscv/riscv-iommu: rename regs_rw to regs
>>        hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
>>        hw/riscv/riscv-iommu: check DC.TC reserved bits
>>        hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
>>        hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriately
>>        hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
>>        hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
>>
>> Inochi Amaoto (1):
>>        target/riscv: Check PMP before updating PTE
>>
>> Joel Stanley (9):
>>        target/riscv: Avoid NULL deref in IMSIC CSR write
>>        tests/functional/riscv64: Use newer kernel for tuxrun boot
>>        tests/functional/riscv64: Add virt machine AIA boot test
>>        hw/riscv/virt: Move AIA initialisation to helper file
>>        hw/riscv/aia: Provide number of irq sources
>>        hw/riscv/aia: Configure stride for the M-mode IMSIC
>>        hw/riscv: Add Tenstorrent Atlantis machine
>>        hw/riscv/atlantis: Integrate i2c controllers
>>        hw/riscv/atlantis: Add some i2c peripherals
>>
>> Meng Zhuo (1):
>>        target/riscv/kvm: skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
>>
>> Nicholas Piggin (4):
>>        hw/riscv/boot: Describe discontiguous memory in boot_info
>>        hw/riscv/boot: Account for discontiguous memory when loading firmware
>>        target/riscv: tt-ascalon: Enable Zkr extension
>>        tests/functional/riscv64: Add tt-atlantis tests
>>
>> Qingwei Hu (3):
>>        hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
>>        hw/intc: riscv_aplic: Skip reset for KVM irqchip
>>        hw/intc: riscv_imsic: Skip reset for KVM irqchip
>>
>> SeungJu Cheon (1):
>>        target/riscv: Apply UXL WARL handling to vsstatus
>>
>> ZhengXiang Qin (1):
>>        target/riscv: avoid abort when reading vtype before env->xl is set
> 
> 
> Hi!
> 
> Is there anything here worth picking up for the stable series
> (besides "target/riscv: Check PMP before updating PTE")?
> 
> For example,
> 
>   46d96da130 target/riscv: avoid abort when reading vtype before env->xl is set
>   5a3fd18f4f hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
>   13c2fc34f1 hw/riscv/riscv-iommu: check DC.TC reserved bits
>   6ed77682d5 hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
>   887d2d75b1 hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriately
>   3cee183ff9 hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
>   64ce9ac187 hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
> 
> resolves various bugs from the qemu issue/work-items tracker.

All riscv-iommu stuff is worth getting. They are all fixes for code that is
around since QEMU 9.x or something.

In fact there's more to come in future PRs (I'm actively hunting riscv-iommu
stuff in gitlab) so same thing applies for those future cases too.


Cheers,
Daniel

> 
> Thanks,
> 
> /mjt


