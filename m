Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49299C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 07:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiSJ8-000511-VC; Sat, 11 Jul 2026 03:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wiSJ7-00050j-LP
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 03:39:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wiSJ4-000473-IL
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 03:39:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66B6xQmc3005992
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZuPsHCzQplc9+Lf8ENZse7iMbKQjCNjJZ6R6yePhvaQ=; b=jmyspiAXwxGvy7uC
 q5NGeXaZ97BXwHSJL9SCqT3Mz6QEZzBzhZBeGrkTpv+5joW2DOv0DwqxHvZNTNll
 qpoHzqOL/3wuOHjnRe8HKJAyiMKMggQa0PDxMRHp2hkUhbZa5l9ZNzpZoh3djVbe
 qIbwf0VIk13Hlaq92wm4ARRy7ZpSgOJYW3rPfRn6h55tg1SNvurqL04BanGkrZUr
 76W2Rm3+hKZrwDg5uISGXaje855MybYRvb7HNe2lYf7Ccpxn1R2exxidsrTW+RzA
 YDzW2/MIGWP7CoIhN/lAdWA8kPW8/BMcUzX8SrIsc+5L8JFfi7+coQOaEAp5VHCc
 xdPQnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9gbvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 07:39:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so158449585a.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783755563; x=1784360363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZuPsHCzQplc9+Lf8ENZse7iMbKQjCNjJZ6R6yePhvaQ=;
 b=P8T8aJZQ8PD5nyMV0QjOdypWLTWAtQj7cN0Doq7yM98a8l3+TliD3wVnt793zvk7ka
 1Z3pXNhzWc8rWC6hQQGYkWrpDvK5vt2rX85FNk/GaP+uontqvouYlB0wsl6G+M+eYSQ3
 Ob4kaAeRNEM01i8kJwPmozKabeVTUZz0rHlZEh/KFBGjePdixZc0h+vPm5uEwDlfB+Uk
 sLhmvu6biTk3vrTxlBM4EOw6AiCafOmRCuk5GYk940vM1mr7w++R3QEfG5FSWZcJtGyn
 uzwFTFFpYFAdUDe6XKI2PBYwjjzR5TDeCcPlKhr990lJqzaEDJUywNYIzJW6NWPgUWWt
 iheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783755563; x=1784360363;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuPsHCzQplc9+Lf8ENZse7iMbKQjCNjJZ6R6yePhvaQ=;
 b=JQijlJkynTSAtgE0UoO33HRx+fPDA0scKi/uHvVOomHbulAMYy5lo0x6vLYiymlvPO
 2zT9jA1dHhfnuS+DZijN96WEhMA2sCGf8luq+XIWemO/sJju2FUf+Z7AFb5lAsNQmssm
 sZusbH76nSBGE2vIcJptIV5ROV7Wpjg+5Wib4XzQ2X1QPrtRbAihm5ovpJACd3J5H0uO
 JnHJV8fk5e3kviCmAqPPnJKAMuQs/ZdKKO0JfAVkpecgIaTqf60WKsnHYeqmZV6g/J6S
 7k/a4MhSSB+RkW4AeplrXlKI+4+ioyly39Rop8bnpjB9XtUb0EwHGBvyXjqP1V6l2Ham
 hYUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLdalFVvVbBBUxdugGjRg/tOSv7fgh2F2jgmmV7YZElegeaK8E/ReGTwhdlVlkLic4THUAzX5OiFGK@nongnu.org
X-Gm-Message-State: AOJu0YwIIojUl5hyz1tkRQT/qa9D5tOiqkLnIqlByxD/KPwNE6VwSmXY
 mhJmnl0e6SE9L2WW2Hwxd90lEsnxrKYiQ9g2oZImoYsPqwVBcB4HWMjKEITfepGh7DKe9lUGlfE
 jmuFpklxXhnh/iKlnnVAiDZmv3iplTUcJ24pO1s9YbuJKBuh8QVVxlW+dXw==
X-Gm-Gg: AfdE7cn4zZBmwfdr2wNHGg087GjA5bBALLYk2w5f2TAHq56gcMyBnY9Nuirfpv4RVj+
 ci7fYYhT746/hXTVkx5QYCJrVFG0lI6bHdujfLpexXEBBt8ZRYgoNyl2oGgfbInYNXiDUa7KXKm
 rN+afNHxoN3Lptc1GwuZZ4paW9I0XehInIe6Od25xqyJMDw28f9Ky6swipdQEmRA3EnVnCXYxCd
 dMn45Rp7YcgkKo/LFgG5aZY/hlRUcRZ7A0xiFjwxMzbKY6syAYbGIArKXGbpk8G75lDNJcrQTAF
 y8YGkrZY1RlR2BjnrpmwSS23yKWWoAKdY13egxq/49jyuBQVmSCxwY0BsJ6UXWzs/9vJeXCcE7B
 LFq1TK3zd6PlPdVrNbPZZhwiXNwp48nnDSCT+KAQfDAlE
X-Received: by 2002:a05:620a:4609:b0:92e:e5e9:465b with SMTP id
 af79cd13be357-92ef2f60560mr225511485a.81.1783755563339; 
 Sat, 11 Jul 2026 00:39:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4609:b0:92e:e5e9:465b with SMTP id
 af79cd13be357-92ef2f60560mr225510085a.81.1783755562852; 
 Sat, 11 Jul 2026 00:39:22 -0700 (PDT)
Received: from [192.168.68.105] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b4a0cbsm395691385a.5.2026.07.11.00.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 00:39:22 -0700 (PDT)
Message-ID: <3a4d4b5d-e3a2-43cc-abec-ade8fd94cb30@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 04:39:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/40] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>, alistair23@gmail.com,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
 <76408ad0-1950-438f-92ab-62b20f0fa03e@tls.msk.ru>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <76408ad0-1950-438f-92ab-62b20f0fa03e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDA3MiBTYWx0ZWRfX9vEORq6nr95s
 DuiBB9ataZvRwToB3f3oHzOb++MDZH0bwh/aCkKZE/W53AigxrQ645CwLgYqbi/zQbdlB78Ho+t
 odmQw42aW/gYWkbdeiGyZ1uIDEc/NGs=
X-Proofpoint-GUID: 71CPwhXAUj9d2Jx_hi5tJMPSrSIlmGjE
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a51f32c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=9eAZ6OhYZPzkJTKxresA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDA3MiBTYWx0ZWRfXwl7Da7LuEBLn
 ZhOIwLL7Vwus85mPYgTOGzNR5U5TpgS7VrlExG3kHFTO6yZJA+YbpZQZLmHiCVMBRIeUdKgpEjL
 /nHaFLrjy33GZa4gvTN1qaoFILm5zQ3FgbC5JuLED304IIHge6IDmX3PjzdvPwaB8SsH/HMtmz8
 3Do22aIt565zxrox9ETXIZ8pIB5Z5enlB3QwOyPZKgeBiUhJUKteL4yVmDP69gbJYJG+aEWLJ7m
 d7HtujHzh3XUpW5eWNeU5+xKJacmQ5/QfjmtjfYGXxeRICDJqrTIlPaRbXBZyB64YrzdnX3pJFS
 fa8ieM9vMgyvoFDUhPjEbD40qN295iKkhjNRIxqfuDP21HxPNYi/Z62RLWtEeZiD30ALhAOn9BI
 YOlYXK43/OAecynDd9XX0H/ArjuQqTcac/5FKAkSIBpoc1OQMrTxD3Aqtehxxa34+ptTbO0onhW
 juU9ddsv9OodF9ezb+w==
X-Proofpoint-ORIG-GUID: 71CPwhXAUj9d2Jx_hi5tJMPSrSIlmGjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110072
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



On 7/11/2026 3:32 AM, Michael Tokarev wrote:
> On 7/10/26 05:54, alistair23@gmail.com wrote:
>> From: Alistair Francis <alistair.francis@wdc.com>
> 
>> RISC-V PR for 11.1
>>
>> * Fix IOMMU fault type for spa_fetch() faults
>> * Check IOMMU for reserved PTE bits
>> * Fault when IOMMU !PTE_U and no priv access
>> * Fault IOMMU for non-user PTE in G_STAGE
>> * Check IOMMU reserved MSI PTE basic bits
>> * Record fault on IOMMU-generated MSI write
>> * Move RISC-V TCG files and fix --disable-tcg
>> * Check for misaligned IOMMU IOHGATP_PPN
>> * Update IOMMU ioval2 when faulting in spa_fetch()
>> * Forbid IOMMU GATE/SADE if caps.AMO_HWADD is zero
>> * Set IOMMU ftype and iova in riscv_iommu_ctx()
>> * Check PCIe DOE mailbox length for overflows
>> * Add extensions after v7.1-rc4 update
>> * Remove job building OpenSBI firmware binaries
>> * Correct ACPI field sequence in SPCR table
> 
> Is it the same as usual for riscv pull requests, -- everything with
> Fixes: or Resolves: tag should be picked up for the current qemu stable
> releases?
> 
> (Cc'ing Daniel too since he has largest share of contributions here).


Yes sir.  All "Fixes" and "Resolves" from this batch fixes bugs that
are also applicable for qemu-stable.

Cheers,
Daniel


> 
> Thanks,
> 
> /mjt
> 
>> ----------------------------------------------------------------
>> Alistair Francis (1):
>>        hw/pci/pcie_doe: Check mailbox length for overflows
>>
>> Bin Meng (1):
>>        gitlab-ci: Remove job building OpenSBI firmware binaries
>>
>> Daniel Henrique Barboza (32):
>>        hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults
>>        hw/riscv/riscv-iommu.c: check for reserved PTE bits
>>        hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
>>        hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE
>>        hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
>>        hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated MSI write
>>        target/riscv: move valid_vm_* satp arrays to cpu.c
>>        hw/riscv, target/riscv: move pmu fdt function to fdt-common.c
>>        target/riscv: move TCG only files to tcg subdir
>>        target/riscv/machine.c: do not migrate pmp state with kvm
>>        target/riscv: move pmp files to tcg subdir
>>        target/riscv: tidy up riscv_sysemu_ops
>>        target/riscv: move debug.h to tcg subdir
>>        target/riscv: remove csr.h from kvm-cpu.c
>>        target/riscv: move csr.h to tcg subdir
>>        target/riscv: move custom_csrs logic to tcg-cpu.c
>>        target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
>>        target/riscv: move some irq helpers to cpu.c
>>        target/riscv: move riscv_cpu_claim_interrupts to cpu.c
>>        target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
>>        target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
>>        target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
>>        hw/riscv/riscv_hart.c isolate tcg only bits
>>        target/riscv/gdbstub.c: isolate TCG only checks
>>        target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
>>        target/riscv/tcg: remove unused riscv_cpu_get_geilen()
>>        target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
>>        target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
>>        hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
>>        hw/riscv/riscv-iommu.c: update ioval2 when faulting in spa_fetch()
>>        hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is zero
>>        hw/riscv/riscv-iommu.c: set ftype and iova in riscv_iommu_ctx()
>>
>> Heinrich Schuchardt (3):
>>        tests: allow differences in SPCR
>>        hw/acpi: correct field sequence in SPCR table
>>        tests: update SPCR loongarch64 and riscv64 test data
>>
>> Wang Yechao (1):
>>        target/riscv/kvm: add extensions after v7.1-rc4 update
>>
>> Zephyr Li (2):
>>        target/riscv: Remove unused tcg/tcg.h include
>>        gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
> 


