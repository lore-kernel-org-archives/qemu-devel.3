Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F4CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEZlX-0005a4-Ky; Wed, 07 Oct 2026 18:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEZlU-0005ZY-KA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:05:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEZlR-00033M-Hj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:05:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LuQxU128124
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 22:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=T/inq0ct7zbleLV0BfruSoQC
 Rb4eLVpeD4pW786XTjs=; b=c4wkO+7FNSja4wp+vQSen1zD81ekxNfaWnXxNZdI
 Y58cj6dfZLJ2W9VPPLwNVQv00s0mQbhyLpwXMOrlZE1elROgs2KoqUcJwIBwDZvF
 ClFj2T6J278wlZZIrP3KN/oH5PzG7j/5Snd8ir1TQ1pDgmjKFHx0J4fTwpUumHSp
 lVk2MoMi1aZkj2HCJzb6O6ubN0djo4PXVQ7JqHQuNkR3jAp2Fgedjb5Rv0EilBdU
 ko9LNAVM7gJWmlQVMfIkqKPwd6kW1M96ftpqIcOJYh9yteuD/rUskK1Hjc1JliUL
 NlRP4kK1O/FCBahDgvljGHSRzMYw9pASJuv/YJsod24RIw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2r23s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 22:05:25 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c93c294214so1208827e0c.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791410724; x=1792015524; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:content-language:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T/inq0ct7zbleLV0BfruSoQCRb4eLVpeD4pW786XTjs=;
 b=JDtep03JQPBsh6KigjpGde4NQWAEDRDM6yb+QjiJgNeV4rN0/kp9Z9BWPFa3pudPRH
 S0BtkOsc5JYfsjQnVL1DXOiW9oUmYUBjSFbWoUY38zKuOFiopIsPIex6E+a5Z4zV7ZSn
 rZmt5CGz6t4j7ZBDVMmMd3oJ9yNOFCFJfe+ULTFvCR1syD5FoZQIFjBAoas5MC8Fjdjr
 bS0O2Zv/Em4sI9LnC9NFQMCfCwNXeNe0z+C+drEBRdILo/a+3S8iw/OAhMabvt9DSMxl
 Ti4onZkAVfi0zHDP3ZMSYP8T2zjG/2ixJxRro1dP0W6YzAVri+2e9iAUKqeuvP8vOZ+A
 Ljyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791410724; x=1792015524;
 h=in-reply-to:references:cc:to:from:content-language:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/inq0ct7zbleLV0BfruSoQCRb4eLVpeD4pW786XTjs=;
 b=TBGIN7V4Xnzxuu1bNtfHOz+uYawx/G81Qt3HV3S/Ighcxsk1rqOGwFC+GbFShCJZy9
 1A3jtoZGcwrN1ur6epj0HSZ8c8QXRBATRmPHNN/ERtCXmVGHH3FpzT1X8IVTph9OW0qT
 f3KVUtbBeJ7/rozB6KEcrlivjb9k3UWUW0t1RnT/Gf5EptkwFxwuiR8AKyDPXdbbY7tI
 Ig//k2UmDU5zu1yWYZxs+gmYYa2Qo9ZWlxeXG2blxX2QHKagLE8S55w5/7AcYOaDVIai
 qqszTn94YOEBGFYaIWmIsY0Owagf88ZfRUMWYuW19U15jRFImjvkZrHBkI40MQqjzcgV
 agFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUmlrnYhm0383GfcM+TksJwuSqbFwcyXjnt4EOAkwLK2P/T173VM4bOEINzLqAEyx+q+aaWWbF84Gq@nongnu.org
X-Gm-Message-State: AFq9FYLZ0Y0dsbziFoSWwkh8k14s2I7ESHaEnOerpZb2KCaOkMXu8loI
 +Ag1QVH9ovUAOtdP80D7eCkDKyuMjipuLR+2W6x7YfCZzMlPj+zJuWANVGlvGxx/5vPSc3+eAjo
 S7Jhco5qjAk3vAG26OXiP+bLvYEaatnyOc9dwmMk/QY4dU+4XE8+Y80CNeA==
X-Gm-Gg: AYBFou3WtcrcvU4k0Zh4Jo6VVt9YOP+eZB6WUrTW3jhRwVVIhbEQ4mix6KFy2a7xfhs
 IVFTuGnB7g8vY0q4e49ceNADM5H0yXI8s8YRBlpa8Pu9q2VpbIWOhdx1py8PAAcHJW23DOMX+/s
 91AH5zj/6HMP03iLlkwAskx1uQkNAx2B62+OOCicsdTZL/IRX2qzDdoHF63qH3kGLGRzKMlwhRr
 fW9hnzjd+kGDR4iWBgVmGAHTXPiw5NOMYagA002QhtbKT7AdVqX/DQsMhn1fy+iyqhols9TcQJr
 O6OdaGieXKniEoYHDv6wbahu82kKJg5qtU78HjHv9leaQLRbiMG0zqYbNIFC9jzyMjEBFWtx8k2
 DEU37hWIziNqEFmzB8FiEh//AG09rUoYR4Q==
X-Received: by 2002:a05:6102:50a7:b0:7b6:46f5:918f with SMTP id
 ada2fe7eead31-7ca38800915mr844582137.13.1791410723824; 
 Wed, 07 Oct 2026 15:05:23 -0700 (PDT)
X-Received: by 2002:a05:6102:50a7:b0:7b6:46f5:918f with SMTP id
 ada2fe7eead31-7ca38800915mr844571137.13.1791410723111; 
 Wed, 07 Oct 2026 15:05:23 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b860sm6788426f8f.11.2026.10.07.15.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 15:05:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------SuCawNJPPA1DCASeYQyZSMyS"
Message-ID: <6f694401-3cc9-4c76-aa2d-3625773823c7@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 00:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty
 logging
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261007093001.74476-1-philmd@oss.qualcomm.com>
 <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
 <478c0311-b31e-4d38-af65-79508fca3021@oss.qualcomm.com>
In-Reply-To: <478c0311-b31e-4d38-af65-79508fca3021@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4OCBTYWx0ZWRfX5RA+I1OaLJ9N
 0ynES6oGmCLlLAXW4SGZ6+N9aX+WWQxYTq3AdgsOnwFdCW/jnA+81US+9cPnjVw0Z1VuW4grlPG
 FcIuxWx9pbJ6EGvPJ/Gz3VFeE53O5Uk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4OCBTYWx0ZWRfXyVDEomNkUH2Y
 jkLXpyevv4R0DaTvx50RmjyhF2yQEhz9bfaugD5v6D59FIOD8Jr28oikWQElTvnnn/oGHE4KWQ9
 oT0RCSOLJl2JAWfC3CuvvkplKmE9xk+GOwxyrWOxgf/e0DCL4uaCjcGmTGnFSYLAMIGIs0Q2Tpi
 XcVGv7f8NxP31mOPHLfiq1jvIYAHYZW3fHvXCtKn+R54S+gd8CjyiSwQCAP4xsw9jU7gpj28mQ7
 phIjEzfjq3EDnBsqTayBPQva+XTtCPoU4GLcHvGl+B22f2a/onKdc5CKJV3Yb8U4TmainguS9Ku
 5s5jAXknsxQmIwVB/Rir4+e0A8Tba7yH069BHXTGA2p5y5amtTJ2JNlYldKOKG2mVhBvxXU7ATv
 jKkkAIa4tfa4uzreS2I919VXgQb+wqyAlbuD7S4v3Y+ARehBsXAAe4hixCjU8XZ9AJx6UprZ6RD
 bEEvYBYWCVx9DiU8o+w==
X-Proofpoint-ORIG-GUID: NDG7OSNIgvAriPWmxwxqmfjW6zhcgK_w
X-Proofpoint-GUID: NDG7OSNIgvAriPWmxwxqmfjW6zhcgK_w
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac6c226 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=r77TgQKjGQsHNAKrUKIA:9 a=EUspDBNiAAAA:8 a=Ty-P0fXYr5gAzqgR2TwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5mdJpvdji3gLl6Vxc0YA:9
 a=pD6Z0FI6r1wA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

This is a multi-part message in MIME format.
--------------SuCawNJPPA1DCASeYQyZSMyS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/26 21:50, Philippe Mathieu-DaudÃ© wrote:
> On 2026-10-07 16:50, Akihiko Odaki wrote:
>> On 2026/10/07 18:30, Philippe Mathieu-Daudé wrote:
>>> From: Mark Burton <mburton@qti.qualcomm.com>
>>>
>>> Dirty-page logging handles a RAM write fault by marking the page dirty,
>>> restoring write permission, and retrying the guest instruction.
>>>
>>> The handler also retried when the resolved RAM region had no dirty-log
>>> client.  This path neither restores permission nor advances the PC, so
>>> the instruction can repeatedly exit to QEMU.
>>>
>>> Retry only after marking the page dirty and restoring write permission.
>>> Otherwise, use the existing emulation path to complete the access and
>>> advance the guest PC.
>>
>> I can identify three cases of RAM write faults. The existing code
>> handles all three, but this patch breaks the third:
>>
>> 1. The RAM is read-only. assert(!mr->readonly) trips in this case.
>>
>> 2. Dirty logging is enabled. The vCPU marks the page dirty, restores
>>     write permission, and retries the write.
>>
>> 3. Dirty logging is enabled when the fault occurs, but another thread
>>     disables it before the vCPU acquires the BQL. The vCPU then observes
>>     a zero dirty-log mask. The write still needs to be retried because
>>     write permission has already been restored. The existing code does
>>     this correctly, but this patch falls through to emulation instead.
>>
>> This patch is useful only if there is another case that the existing
>> code does not handle correctly. Please describe that case and preserve
>> the retry behavior in case 3.
> Thanks for the deep review.
> 
> The reporter said:
> 
>    We reproduced is a level-2 translation fault, DFSC 0x06, on a
>    dynamic DMI RAM leaf that has no corresponding HVF mapping.
>    address_space_translate() resolves the leaf as RAM, but the dirty-log
>    mask is zero, no page is marked or unprotected, and the unconditional
>    retry makes no progress.
> 
> That would be another case:
> 
>    4. FlatView says RAM, but HVF has no mapping (nothing has changed
>       to make retry succeed).
> 
> So to prevent retrying a known translation miss that cannot make any
> progress checking DFSC could be sufficient:
> 
> -- >8 --
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b00a7e1a84..4faa21caa1 100644
>       case EC_DATAABORT: {
>           bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
>           bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
>           bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
>           bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
>           uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
>           uint32_t len = 1 << sas;
>           uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
>           uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
> +        uint32_t fsc = FIELD_EX32(syndrome, DABORT_ISS, DFSC);
> +        bool l2_translation_fault = fsc == 0b000110;
>           uint64_t val = 0;
>           uint64_t ipa = excp->physical_address;
>           AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
> 
>           trace_hvf_data_abort(excp->virtual_address, ipa, isv,
>                                iswrite, s1ptw, len, srt);
> 
>           if (cm) {
>               /* We don't cache MMIO regions */
>               advance_pc = true;
>               break;
>           }
> 
>           /* Handle dirty page logging for ram. */
>           if (iswrite) {
>               hwaddr xlat;
>               MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
>                                                          NULL, true,
> 
> MEMTXATTRS_UNSPECIFIED);
> -            if (memory_region_is_ram(mr)) {
> +            if (memory_region_is_ram(mr) && !s1ptw && ! 
> l2_translation_fault) {
>                   uintptr_t page_size = qemu_real_host_page_size();
>                   intptr_t page_mask = -(intptr_t)page_size;
>                   uint64_t ipa_page = ipa & page_mask;
> 
>                   /* TODO: Inject exception to the guest. */
>                   assert(!mr->readonly);
> 
>                   if (memory_region_get_dirty_log_mask(mr)) {
>                       memory_region_set_dirty(mr, xlat, page_size);
>                       hvf_unprotect_dirty_range(ipa_page, page_size);
>                   }
> 
>                   /* Retry with page writes enabled. */
>                   break;
>               }
>           }
> 
>           /*
>            * TODO: If s1ptw, this is an error in the guest os page tables.
>            * Inject the exception into the guest.
>            */
>           assert(!s1ptw);
> ---
> (the !s1ptw guard is independent of the zero-mask race,
>   this is to ensure we cannot accidentally take the dirty-log retry
>   path when the page-table memory is RAM).
> 
> But be wary because I'm way out of area of understanding here...
> 
> Anyway I asked the reporter for more info and possible reproducer;
> and might add comments to the code to better follow the 1/2/3/4 paths.
> But after some sleep :)
Still here... Asked AI for reproducer:

-- >8 --
AI-used-for: tests
diff --git a/tests/tcg/aarch64/system/hvf-unmapped-ram.c 
b/tests/tcg/aarch64/system/hvf-unmapped-ram.c
new file mode 100644
index 00000000000..45721134710
--- /dev/null
+++ b/tests/tcg/aarch64/system/hvf-unmapped-ram.c
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Reproducer for an HVF data abort on a RAM FlatView leaf without an HVF
+ * mapping.  Run manually on Apple Silicon (whose host page size is 16 
KiB):
+ *
+ *   qemu-system-aarch64 -accel hvf -cpu host -nodefaults -M 
virt,highmem-ecam=off -m 128M \
+ *     -display none -serial stdio -kernel 
aarch64-softmmu-hvf-unmapped-ram.test \
+ *     -device pci-testdev,bus=pcie.0,addr=0x1,membar=4K,membar-backed=on
+ *
+ * The 4 KiB pci-testdev BAR2 is RAM, but its size and programmed 
address are not
+ * host-page aligned.  HVF therefore leaves it unmapped.  A write to 
the BAR
+ * takes a level-2 translation fault (DFSC 0x06); the handler must 
emulate the
+ * access and advance PC instead of retrying it forever.
+ */
+
+#include <stdint.h>
+
+#define ECAM_BASE           UINT64_C(0x3f000000)
+#define TESTDEV_CONFIG      (ECAM_BASE + UINT64_C(0x8000))
+#define PCI_COMMAND         UINT64_C(0x04)
+#define PCI_COMMAND_MEMORY  UINT16_C(0x0002)
+#define PCI_BAR2_LO         UINT64_C(0x18)
+#define PCI_BAR2_HI         UINT64_C(0x1c)
+
+#define RAM_BAR             UINT64_C(0x10001000)
+#define BAR_ADDRESS_MASK    UINT32_C(0xfffffff0)
+#define SENTINEL            UINT32_C(0x1badb002)
+
+#define PL011_DR            UINT64_C(0x09000000)
+#define PL011_FR            (PL011_DR + UINT64_C(0x18))
+#define PL011_FR_TXFF       UINT32_C(0x20)
+
+#define PSCI_SYSTEM_OFF     UINT64_C(0x84000008)
+
+static inline uint16_t mmio_read16(uint64_t addr)
+{
+    return *(volatile uint16_t *)(uintptr_t)addr;
+}
+
+static inline uint32_t mmio_read32(uint64_t addr)
+{
+    return *(volatile uint32_t *)(uintptr_t)addr;
+}
+
+static inline void mmio_write16(uint64_t addr, uint16_t value)
+{
+    *(volatile uint16_t *)(uintptr_t)addr = value;
+}
+
+static inline void mmio_write32(uint64_t addr, uint32_t value)
+{
+    *(volatile uint32_t *)(uintptr_t)addr = value;
+}
+
+static inline void dsb_sy(void)
+{
+    asm volatile("dsb sy" : : : "memory");
+}
+
+static void uart_puts(const char *str)
+{
+    while (*str) {
+        while (mmio_read32(PL011_FR) & PL011_FR_TXFF) {
+        }
+        mmio_write32(PL011_DR, *str++);
+    }
+}
+
+static __attribute__((noreturn)) void system_off(void)
+{
+    register uint64_t x0 asm("x0") = PSCI_SYSTEM_OFF;
+
+    asm volatile("hvc #0" : "+r"(x0) : : "memory");
+    for (;;) {
+        asm volatile("wfi");
+    }
+}
+
+static __attribute__((noreturn)) void finish(int passed)
+{
+    uart_puts(passed ? "PASS\n" : "FAIL\n");
+    system_off();
+}
+
+int main(void)
+{
+    uint32_t bar;
+
+    /* Verify the fixed BDF exists before programming its 64-bit BAR2. */
+    if (mmio_read16(TESTDEV_CONFIG) == UINT16_MAX) {
+        finish(0);
+    }
+
+    mmio_write32(TESTDEV_CONFIG + PCI_BAR2_HI, 0);
+    mmio_write32(TESTDEV_CONFIG + PCI_BAR2_LO, RAM_BAR);
+    mmio_write16(TESTDEV_CONFIG + PCI_COMMAND,
+                 mmio_read16(TESTDEV_CONFIG + PCI_COMMAND) |
+                 PCI_COMMAND_MEMORY);
+    dsb_sy();
+
+    bar = mmio_read32(TESTDEV_CONFIG + PCI_BAR2_LO);
+    if ((bar & BAR_ADDRESS_MASK) != RAM_BAR) {
+        finish(0);
+    }
+
+    mmio_write32(RAM_BAR, SENTINEL);
+    dsb_sy();
+    finish(mmio_read32(RAM_BAR) == SENTINEL);
+}
diff --git a/tests/tcg/aarch64/system/hvf-boot.S 
b/tests/tcg/aarch64/system/hvf-boot.S
new file mode 100644
index 00000000000..bf9be89ee6d
--- /dev/null
+++ b/tests/tcg/aarch64/system/hvf-boot.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Minimal bootstrap for hvf-unmapped-ram.c.
+ *
+ * Unlike boot.S, this must not issue a semihosting call before entering C:
+ * HVF does not handle the semihosting HLT exception.  Direct -kernel 
boot on
+ * the non-virtualized virt machine starts this ELF at EL1 with the MMU 
off.
+ */
+
+    .text
+    .align  4
+    .global __start
+    .type   __start, %function
+__start:
+    /* Use SP_EL1 and provide the C code a private stack. */
+    msr     spsel, #1
+    ldr     x0, =stack_end
+    mov     sp, x0
+    bl      main
+
+1:  wfi
+    b       1b
+    .size   __start, . - __start
+
+    .bss
+    .align  12
+stack:
+    .space  4096
+stack_end:
diff --git a/tests/tcg/aarch64/system/hvf-unmapped-ram.out 
b/tests/tcg/aarch64/system/hvf-unmapped-ram.out
new file mode 100644
index 00000000000..7ef22e9a431
--- /dev/null
+++ b/tests/tcg/aarch64/system/hvf-unmapped-ram.out
@@ -0,0 +1 @@
+PASS
diff --git a/tests/tcg/aarch64/system/meson.build 
b/tests/tcg/aarch64/system/meson.build
index f51feb253f9..0ee6ffeb527 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -14,6 +14,14 @@ qemu_base_args = ['-display', 'none',
                    '-kernel']
  qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]

+# This payload must not use boot.S: that bootstrap invokes semihosting 
before
+# main(), while the manual HVF run needs to start without any 
semihosting exits.
+hvf_unmapped_ram_cflags = ['-nostdlib',
+                           '-ffreestanding',
+                           '-Wa,--noexecstack',
+                           files('hvf-boot.S')[0],
+                           '-Wl,-T', link_script]
+
  # Multi arch tests - add cflags only once per src
  multi_src = []
  foreach t: tcg_tests['multiarch-softmmu']['tests']
@@ -42,6 +50,14 @@ tests += {
  tests += {
    'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
    'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'hvf-unmapped-ram.c': {
+    'cflags': hvf_unmapped_ram_cflags,
+    'qemu_args': ['-nodefaults', '-M', 'virt,highmem-ecam=off', '-cpu', 
'max', '-m', '128M',
+                  '-serial', 'stdio',
+                  '-device', 
'pci-testdev,bus=pcie.0,addr=0x1,membar=4K,membar-backed=on',
+                  qemu_base_args],
+    'expected_output': 'hvf-unmapped-ram.out',
+  },
    'gpc-test.c': {
      'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
                 '-Wno-main', '-Wno-unused-but-set-variable'],
---

./qemu-system-aarch64 -accel hvf -cpu host -nodefaults \
   -M virt,highmem-ecam=off -m 128M -display none -serial stdio \
   -kernel ~/hvf-unmapped-mem-repro \
   -device pci-testdev,bus=pcie.0,addr=0x1,membar=4K,membar-backed=on \
   -trace hvf\*
hvf_vm_map paddr:0x0000000000000000 size:0x04000000 vaddr:0x118000000 
flags:0x05/R-X
hvf_vm_map paddr:0x0000000004000000 size:0x04000000 vaddr:0x129904000 
flags:0x05/R-X
hvf_vm_map paddr:0x0000000040000000 size:0x08000000 vaddr:0x121900000 
flags:0x07/RWX
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_data_abort data abort: [va=0x000000003f008000 pa=0x000000003f008000 
isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
hvf_data_abort data abort: [va=0x000000003f00801c pa=0x000000003f00801c 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x000000003f008018 pa=0x000000003f008018 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
isv=1 iswrite=1 s1ptw=0 len=2 srt=1]
hvf_data_abort data abort: [va=0x000000003f008018 pa=0x000000003f008018 
isv=1 iswrite=0 s1ptw=0 len=4 srt=0]
hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x0Quit: 3
(looping)

However I had to do this change in hvf_set_phys_mem():

-- >8 --
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8bd9154a50b..7b34a5f586d 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -113,8 +113,14 @@ static void hvf_set_phys_mem(MemoryRegionSection 
*section, bool add)

      if (!QEMU_IS_ALIGNED(size, page_size) ||
          !QEMU_IS_ALIGNED(gpa, page_size)) {
-        /* Not page aligned, so we can not map as RAM */
-        add = false;
+        return;
      }

      if (!add) {
---

because otherwise I was getting:

hvf_vm_map paddr:0x0000000000000000 size:0x04000000 vaddr:0x114b80000 
flags:0x05/R-X
hvf_vm_map paddr:0x0000000004000000 size:0x04000000 vaddr:0x118b84000 
flags:0x05/R-X
hvf_vm_map paddr:0x0000000040000000 size:0x08000000 vaddr:0x10cb7c000 
flags:0x07/RWX
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_kick_vcpu_thread cpu:0 stop:0
hvf_data_abort data abort: [va=0x000000003f008000 pa=0x000000003f008000 
isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
hvf_data_abort data abort: [va=0x000000003f00801c pa=0x000000003f00801c 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x000000003f008018 pa=0x000000003f008018 
isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
isv=1 iswrite=1 s1ptw=0 len=2 srt=1]
hvf_vm_unmap paddr:0x0000000010001000 size:0x00001000
qemu-system-aarch64: Error: ret = HV_BAD_ARGUMENT (0xfae94003, at 
../../accel/hvf/hvf-all.c:123)
Abort trap: 6

(I'll look at that hvf_set_phys_mem change after some rest).
--------------SuCawNJPPA1DCASeYQyZSMyS
Content-Type: application/x-xz; name="hvf-unmapped-mem-repro.xz"
Content-Disposition: attachment; filename="hvf-unmapped-mem-repro.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGBMC4CfirCCEBFgAAAAAAAATpu/7iFfcEsF0AP5FFhGg9iabaisyW0qLC
1nP4jECRpMeMMYZGnSbxRVnkHwV1qIP/e9fvkWKVt9xHzhyLwgGPmqqMAH8zyy+88jV0KVdC
VrcxXl63b25jMyGj+82r9FnMyy4hDFLHB/CrT1EQiZ0t5/aVqxLRYA9k3XbM6Orzd5ITbXnV
nuPBATi+RNk9M6YkCoF1eYdONiZcVyID8KRLHsCH/eeD/mmWND6qpsGbO+tqRWV0ls/a2mNn
cGSd6vKbwLVZyIB8DtvxQeLREuoXNmYklF8LeOIEWmRte3DDf13r08pXvBOwYBm+pHTQ8SRV
LRFXjpMfsNz1PO0oFdf8gE0CuImvKZafRu/j+3Gs8uPFvgXJIN9mpWiXS2zqF31pz2AUWMqz
ZjswVXWMYZw4DjzKk7HMr+Kq8jmwbjz8avgzuHvygUODiry9E8yNbtXspL+a9qUn0uRSneUd
oJx1rm/ulb0VnxKRMMZdZKUMNQ+H6aRiJdei9f0GlM9raXQmrZlwXMcumBaH2eCxT5wJRg6b
BopTaaGaNAD15TdPtt+/YmOPC3YSCvU+IZc4N6ynOE7PAidiPq717dCKPhS5ZzpQ1Y8re1NG
fTobEHZbFJDpNk009Um0GUMU52KCJL8l2bwhbzLAO5k3A+tqlxreii1dcpn8PBtXD+SgMW/E
GHnMZLNyNh4AlFRnimFQmI8vrBfWPvvYwuYPgptCw4x/G7JN3U1OfPAvVJ3LpNBKFxrGTgAp
DgEWEqAf3rTnK5dcJdc7lBHLWyOaKnrvl9SgQpDtXvYrGA19mXkJn9ezL3Qej4lkvhOcBBMU
ukjx8uqZ2gSsyK/w31ei1UtzdYeL1Vu2BTdNuNGOYwMCeZ2hHn2xhmUQ1liWw0uYea4sbS2B
Yqvq3ODvOKWlk0mev3YqzAPQNGfPDk+zbh0O5XIrEMYmZ90urvBGVg8o7pcOwoMnMMDx1ufq
oeE+xxTlKdiETZdWZTyUo/vNWZ/7oM9QjxliStel45gpAWuPjydBMz5TkweP8mBd8UFWUGZn
aA1i90jwT3SnnFdF5Kvo7IR/Ru4wKdMhAvDC36p/FcSrNoVU9kb+sTi9KQXml0SzUOTvd6Qt
39cS/gMkZVUEIwCJOFt7NWHLEhiDRMr5xb/2JEvL+rC8JYep2w7WNYECFGJgjOIDpJv9dcHd
AiEnNYkBuMkW9I4tuRxtNTu+Fq4DVA1+HCgcPxwJawppIf9DdctX4p3uzhXI1K/U5BfNcCyt
keRns/xr8+OSpnzGoW9K/AdtprwYpOXS7M7Wc+x9B2y7PI8wfdecXGCBFndRPNFCLrAEnB8D
LlVl55VctofSZyMWUVBMZ5kM4bl6oOFZW8nePiRplxUWg9WL96IojShk3v0G6c3b2u2mG2KE
NyGc8CYhbdOraWeapT9Qp+qIBZel72PqZ20TA6UKC0FK0fePRD27q1S52lW5Dg66lkOgsLoj
T8NbLpJGL9y/VBhVkD5TpXJBwatSxt5GE3vcFECvuTR2uCrZDUTR5UXRYHtz0griltINgmfx
0HBtc7vYLzl3rGsHXfDkCm1/K3VJlNRC8Ge0q4w+3zT40U+0MYgQVlbd0yiuAOfonxoAAJKf
3novjk8NAAHUCfirCABU7swZscRn+wIAAAAABFla

--------------SuCawNJPPA1DCASeYQyZSMyS--

