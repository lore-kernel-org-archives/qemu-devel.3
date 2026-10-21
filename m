Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zyu5nSCU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EJJc/1Ny
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUwt-0007Px-Ei; Wed, 21 Oct 2026 07:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJUws-0007PT-9O
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:57:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJUwp-00043B-Ge
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:57:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg87x325138
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VAoSdLS2PjLdfT0kjsrUuUCu6r/aVALEcGboy2qOb0s=; b=Zyu5nSCUQhoDi98I
 +w2x8OX2uaFG+zQKh2pY6m5tqoZb/EA/1rHXil1SGT2ORcAH9QlSgkj5dQlMtBx2
 x6ExJsnB23kE3Z8yW43ZBLm/ECqcaTEO0zWoUiu7e3P2AXgZ/BwpXa69souBk3MW
 Or1fVegOaYy1Dsm9/9n1v/9m5U2Th4Wr2SnMo05nCFAtpEv2Crz9U7eCSWHeEjp0
 s2gb+JX+py1onxfy8SRaVg03OD4Dbq5Wdx7lGpVHpiFL1tjjlO9raWpoR40BZcnI
 vRYXkhZ2akyLleuS24b1CHSIAb/H6wO58lw6FL+POjZs8tXQ2zyproMRP68ASb3X
 TgvVeg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v3t95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:57:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363763b556so12657761cf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792583853; x=1793188653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VAoSdLS2PjLdfT0kjsrUuUCu6r/aVALEcGboy2qOb0s=;
 b=EJJc/1NyP3JhZDoCZT9Okfd76P/Sxpiz59TJlnPpM5VgwOxfHve3LjZX+2HPzotl9D
 9e6uqgywygYH0JdAwylDaP5bMIUe7mMzVjeZWKP0TvWvByB7liAsxuTMkNQLhzOxkviZ
 d0b9N+7lJQ/h3aVqPcUZ/6fBR2+Ho7f9rMK+7vEiVIOZX6LErEy2TDSnnC7cN/OPFEz0
 oY2JA+aCxT6vp0gptUNQqyK/Qvj79tTvKGOHlCYKBPMD2gm2Fox1p7p8JowG8KCgu9Az
 A6l9cv0tB4HS2ch359mzoN1DeADhXF88zbLJ0/KzRpzT8yrd4xT5QZBa5G8qllebfysA
 RfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792583853; x=1793188653;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VAoSdLS2PjLdfT0kjsrUuUCu6r/aVALEcGboy2qOb0s=;
 b=ZgXmLTPITlzQSTkEd3dVSnaA8HlxwRkpIRMs/U6SY0ZSe5Myzi9a3mMxZw097ATUY1
 8Tgq162IzWIa/I77659eBZWdkAfj+N0GuBjt25NNHMY+rgJ2i+uEtzkePQWAaBLivfHR
 kDSbw9LS+sYG0XT9LBzBb29fPbq/Rfzvev/x7TVWPHj1TBF7jTZN8xJIjoQNGo5wWrJf
 qBXnm4y6e7w2vwN2L1JQBuczOy4hWH6pNYWOEVrrzgg9dwA/8DemZjWyKGUOh0gNmwPe
 o0IhqjlSdN70kOJIOPQuI5+Pe5DOKqAI3OzActr7dCLSms+D4Za9Prb2PV3TH3XZptKW
 6x7Q==
X-Gm-Message-State: AFq9FYI63SvnbJhy6v3KXoCPNrsqQ5+6yGRwxJITzlW+rZRuuCJjzSvb
 dHJuox2rcww5oACqE4wiAkIcdEwKpJzt/Kipx+FHKr1y4CIrKUcqTjppxw7Kv71qxik2RtBMGSH
 tWfYEeTFFUVTGsv6iqiJ9aHJmqOtf3Mcb+2r73Pw0lyaS4tzXtoJ31fu8lA==
X-Gm-Gg: AYBFou1wGx/0He/bxHiWWYuhqt4ckyY5VrxIc5QvXR0HMfWnQFGp57YwDIAT/QXH9tW
 /eWc9cGPUuOf5H75rE0e8r61Sqk0QUMsObhphtxCJD62BcbvD1qg2EBsx/MQyzZKmyOXzl3RhPk
 kh8Nq6AkkH3GYYQESXdFy3TVX3zJg0N3AnA0gm8JuPOj0fQapJZ1F5rjN+TZBxNk/uRaCYxIx0s
 vzfwia6etoa5zJg9UwRx9/NeTbh8AliwUr8zhqBIAPD93g4s6lGYXyWb4K0z0C89TMXCB7nJc00
 pZPvOwlES9oCwvHiquuP4Si2OY2frhDFkCRVp7+nNIblh9rHAE2oc/GQIGQ2eBFg71GAWvJZrOc
 LU+BUSDkWYw+xDCtphwa0iHmw9g2t+bsAvleBUN2Cy3Q402z79FdwwjlugNZep8V5ybACtagV
X-Received: by 2002:a05:622a:1101:b0:536:6c4e:13f8 with SMTP id
 d75a77b69052e-5369b7d184bmr25573261cf.55.1792583852542; 
 Wed, 21 Oct 2026 04:57:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1101:b0:536:6c4e:13f8 with SMTP id
 d75a77b69052e-5369b7d184bmr25572961cf.55.1792583851955; 
 Wed, 21 Oct 2026 04:57:31 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53698babeebsm17469271cf.22.2026.10.21.04.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 04:57:31 -0700 (PDT)
Message-ID: <1b6f2ec9-2918-46c7-bbfd-6c7b0269f71c@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 08:57:27 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: encode debug translation ranges
To: Zephyr Li <fritchleybohrer@gmail.com>, alistair.francis@wdc.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20261016090832.38530-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016090832.38530-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NyBTYWx0ZWRfX9OuEBJr2vKhw
 w65HMaF0m7qpSR8CuLHxwhlEeI6/jJfM5AAQiXY6vFVs6CS9sxasqQdII5q1N0Q2ZFvtPqPHSwX
 efh6p6oct2S4aRJNu6Nws3iKIiCgFUU=
X-Proofpoint-ORIG-GUID: Ya_b_nL2usY8kMQNaFeGzvYGOO380cxB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NyBTYWx0ZWRfX5obmocJUlpRN
 KEeKNc5+UbpwP8JCRjIMRE3dKwXCigiqcyErJkWkcmDb+JA6bVdsd+5uhkFiNk/YM9qef8B7BMh
 uiuj3R0+KngW3w3WWtJ5TEwDjg4JAfUiCYP7utQ7sHJA4umq8NuwIv30Ls5Wf0cJyICl9wgMhix
 fhAeP3yBlLHqiPRtRmNCvJGts9ix7wtpKVM1KsCZPIsSE81jiutTF5KJxGI31C4UGIGweA26sYi
 kZq7gPkm1vjdyjmCcygc5ewzsRcRZdNrIyi2VYgMT/Z4YVOk/bYJfYBCiMErXpLmPRETbNmaWBg
 9tuzGA+DzyZ3px/aH072Avt3DYVLn9F4LV+yThmkt5PZ85d9o2XAmwaltu07R7bGAfu5jLfWcHJ
 173+UG6UTi1u7jg9Pa3wrNpVoE91kQl0IhpzEFpJHnnAXDT0jSI6lsTg7klUeA+QEPptbfRqO+P
 IVteTkh37t4ImqnqskQ==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad8a8ad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=0ga4OFgzPCZqrNQkQjYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Ya_b_nL2usY8kMQNaFeGzvYGOO380cxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210047
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zephyr,

I am unable to apply this patch because git got nervous with a "corrupt
file error":

$ git am \[PATCH\]\ hw_riscv_riscv-iommu_\ encode\ debug\ translation\ ranges\ -\ Zephyr\ Li\ \(fritchleybohrer@gmail.com\)\ -\ 2026-10-16\ 0608.eml
Applying: hw/riscv/riscv-iommu: encode debug translation ranges
error: corrupt patch at line 243
Patch failed at 0001 hw/riscv/riscv-iommu: encode debug translation ranges
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Tried the usual stuff with 'dos2unix', redownloading the patch and so on but
still the same error.


Can you please re-send?  Thanks,
Daniel

On 10/16/2026 6:08 AM, Zephyr Li wrote:
> The debug translation response aligns the translated physical address to
> the effective translation range, but always reports S=0. For a request
> inside a superpage, the response therefore identifies the wrong 4 KiB
> physical page.
> 
> For effective ranges larger than 4 KiB, set S and encode the range size
> using trailing ones in the PPN field. Keep the existing response format
> for 4 KiB translations.
> 
> The RISC-V IOMMU specification permits reporting a 4 KiB translation even
> when the page tables use superpages. Reporting the effective range is an
> implementation choice; this change does not claim that S=1 is mandatory
> for every translation through a superpage mapping.
> 
> Add debug-response tests for S-stage-only 4 KiB, 64 KiB NAPOT, and 2 MiB
> translations, G-stage-only 2 MiB translations, and nested S4K/G2M,
> S2M/G4K, and S2M/G2M mappings. Check requests inside large ranges and at
> both ends. The mixed nested cases verify that the response uses the
> smaller effective translation granularity.
> 
> Fixes: a7aa525b93c3 ("hw/riscv/riscv-iommu: add DBG support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3552
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---
>   hw/riscv/riscv-iommu.c         |  14 ++-
>   tests/qtest/iommu-riscv-test.c | 193 +++++++++++++++++++++++++++++++++
>   2 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 323a041b4a558136819b1cd41452e96481ba164a..67d8456b9d3ed34308ca794e8d700664ebacce0f 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2281,8 +2281,20 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
>           if (fault) {
>               iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
>           } else {
> +            uint64_t ppn;
> +
>               iova = iotlb.translated_addr & ~iotlb.addr_mask;
> -            iova = set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));
> +            ppn = PPN_DOWN(iova);
> +
> +            if (iotlb.addr_mask > TARGET_PAGE_SIZE - 1) {
> +                /* Encode the translation range as trailing ones in the PPN. */
> +                ppn |= PPN_DOWN(iotlb.addr_mask) >> 1;
> +                iova = RISCV_IOMMU_TR_RESPONSE_S;
> +            } else {
> +                iova = 0;
> +            }
> +
> +            iova = set_field(iova, RISCV_IOMMU_TR_RESPONSE_PPN, ppn);
>           }
>           riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
>       }
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> index 26380248912cc281e313e20a3daf1831be1eded3..1cd753c4f243f207dc34b7acbe41ef0d55772cba 100644
> --- a/tests/qtest/iommu-riscv-test.c
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -19,6 +19,12 @@
>   
>   #define DMA_LEN           4
>   
> +#define DBG_PAGE_SIZE           0x1000ull
> +#define DBG_NAPOT_SIZE          0x10000ull
> +#define DBG_SUPERPAGE_SIZE      0x200000ull
> +#define DBG_TRANSLATED_PA       0x90000000ull
> +#define DBG_NESTED_GPA          0x200000ull
> +
>   /* RISC-V virt machine PCI configuration */
>   #define RISCV_GPEX_PIO_BASE        0x3000000
>   #define RISCV_BUS_PIO_LIMIT        0x10000
> @@ -35,6 +41,64 @@ typedef struct RiscvIommuTestState {
>       uint64_t iommu_base;
>   } RiscvIommuTestState;
>   
> +typedef struct RiscvIommuDbgTest {
> +    const char *name;
> +    QRIOMMUTransMode mode;
> +    uint64_t s_page_size;
> +    uint64_t g_page_size;
> +    uint64_t pa;
> +    uint64_t expected_response;
> +} RiscvIommuDbgTest;
> +
> +static const RiscvIommuDbgTest debug_tests[] = {
> +    {
> +        .name = "page-4k",
> +        .mode = QRIOMMU_TM_S_STAGE_ONLY,
> +        .s_page_size = DBG_PAGE_SIZE,
> +        .pa = DBG_TRANSLATED_PA + DBG_PAGE_SIZE,
> +        .expected_response = 0x24000400ull,
> +    }, {
> +        .name = "napot-64k",
> +        .mode = QRIOMMU_TM_S_STAGE_ONLY,
> +        .s_page_size = DBG_NAPOT_SIZE,
> +        .pa = DBG_TRANSLATED_PA,
> +        .expected_response = 0x24001e00ull,
> +    }, {
> +        .name = "superpage",
> +        .mode = QRIOMMU_TM_S_STAGE_ONLY,
> +        .s_page_size = DBG_SUPERPAGE_SIZE,
> +        .pa = DBG_TRANSLATED_PA,
> +        .expected_response = 0x2403fe00ull,
> +    }, {
> +        .name = "g-stage-superpage",
> +        .mode = QRIOMMU_TM_G_STAGE_ONLY,
> +        .g_page_size = DBG_SUPERPAGE_SIZE,
> +        .pa = DBG_TRANSLATED_PA,
> +        .expected_response = 0x2403fe00ull,
> +    }, {
> +        .name = "nested-s4k-g2m",
> +        .mode = QRIOMMU_TM_NESTED,
> +        .s_page_size = DBG_PAGE_SIZE,
> +        .g_page_size = DBG_SUPERPAGE_SIZE,
> +        .pa = DBG_TRANSLATED_PA,
> +        .expected_response = 0x24001000ull,
> +    }, {
> +        .name = "nested-s2m-g4k",
> +        .mode = QRIOMMU_TM_NESTED,
> +        .s_page_size = DBG_SUPERPAGE_SIZE,
> +        .g_page_size = DBG_PAGE_SIZE,
> +        .pa = DBG_TRANSLATED_PA,
> +        .expected_response = 0x24001000ull,
> +    }, {
> +        .name = "nested-s2m-g2m",
> +        .mode = QRIOMMU_TM_NESTED,
> +        .s_page_size = DBG_SUPERPAGE_SIZE,
> +        .g_page_size = DBG_SUPERPAGE_SIZE,
> +        .pa = DBG_TRANSLATED_PA,
> +        .expected_response = 0x2403fe00ull,
> +    },
> +};
> +
>   static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
>   {
>       qpci->gpex_pio_base = RISCV_GPEX_PIO_BASE;
> @@ -264,6 +328,129 @@ static void test_riscv_iommu_nested(void)
>       run_riscv_iommu_translation(&cfg);
>   }
>   
> +static void riscv_iommu_dbg_map_leaf(QTestState *qts, uint64_t l1_pa,
> +                                    uint64_t l2_pa, uint64_t va, uint64_t pa,
> +                                    uint64_t page_size)
> +{
> +    uint64_t pte = ((pa >> 12) << 10) | QRIOMMU_LEAF_PTE_RW_MASK;
> +    uint64_t pte_addr;
> +
> +    g_assert_cmphex(pa & (page_size - 1), ==, 0);
> +
> +    if (page_size == DBG_SUPERPAGE_SIZE) {
> +        pte_addr = l1_pa + (((va >> 21) & 0x1ff) * sizeof(uint64_t));
> +        qtest_writeq(qts, pte_addr, pte);
> +    } else if (page_size == DBG_NAPOT_SIZE) {
> +        /* A 64 KiB NAPOT PTE has N=1 and PPN[3:0]=1000. */
> +        pte |= BIT_ULL(63) | (8ull << 10);
> +        va &= ~(DBG_NAPOT_SIZE - 1);
> +        for (unsigned i = 0; i < DBG_NAPOT_SIZE / DBG_PAGE_SIZE; i++) {
> +            pte_addr = l2_pa + ((((va >> 12) + i) & 0x1ff) *
> +                                sizeof(uint64_t));
> +            qtest_writeq(qts, pte_addr, pte);
> +        }
> +    } else {
> +        g_assert_cmphex(page_size, ==, DBG_PAGE_SIZE);
> +        pte_addr = l2_pa + (((va >> 12) & 0x1ff) * sizeof(uint64_t));
> +        qtest_writeq(qts, pte_addr, pte);
> +    }
> +}
> +
> +static uint64_t riscv_iommu_dbg_translate(RiscvIommuTestState *state,
> +                                         uint64_t iova)
> +{
> +    uint64_t request;
> +
> +    qtest_writeq(state->qts,
> +                 state->iommu_base + RISCV_IOMMU_REG_TR_REQ_IOVA, iova);
> +    request = ((uint64_t)state->testdev->devfn << 40) |
> +              RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
> +    qtest_writeq(state->qts,
> +                 state->iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL, request);
> +
> +    request = qtest_readq(state->qts,
> +                          state->iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL);
> +    g_assert_cmpuint(request & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY, ==, 0);
> +
> +    return qtest_readq(state->qts,
> +                       state->iommu_base + RISCV_IOMMU_REG_TR_RESPONSE);
> +}
> +
> +static void test_riscv_iommu_dbg(gconstpointer data)
> +{
> +    const RiscvIommuDbgTest *cfg = data;
> +    RiscvIommuTestState state = { 0 };
> +    uint64_t iova = QRIOMMU_IOVA & ~(DBG_PAGE_SIZE - 1);
> +    uint64_t s_pa = cfg->pa;
> +    uint64_t page_size = cfg->mode == QRIOMMU_TM_G_STAGE_ONLY ?
> +                         cfg->g_page_size : cfg->s_page_size;
> +    uint64_t response;
> +
> +    if (!riscv_iommu_test_setup(&state)) {
> +        return;
> +    }
> +
> +    riscv_iommu_check(state.qts, state.iommu_base, cfg->mode);
> +    qriommu_build_translation(state.qts, cfg->mode, state.testdev->devfn);
> +
> +    if (cfg->mode == QRIOMMU_TM_NESTED) {
> +        uint64_t g_l1_pa = QRIOMMU_SPACE_OFFS + QRIOMMU_G_L0_PTE_VAL;
> +        uint64_t g_l2_pa = QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL;
> +        uint64_t offset = iova & (DBG_SUPERPAGE_SIZE - 1);
> +        uint64_t gpa = DBG_NESTED_GPA + offset;
> +        uint64_t pte_addr;
> +        uint64_t pte;
> +
> +        /* Map all S-stage page tables through one 2 MiB G-stage leaf. */
> +        riscv_iommu_dbg_map_leaf(state.qts, g_l1_pa, g_l2_pa, 0,
> +                                 QRIOMMU_SPACE_OFFS, DBG_SUPERPAGE_SIZE);
> +
> +        if (cfg->g_page_size == DBG_PAGE_SIZE) {
> +            pte_addr = g_l1_pa + (((gpa >> 21) & 0x1ff) * sizeof(uint64_t));
> +            pte = ((g_l2_pa >> 12) << 10) | QRIOMMU_NON_LEAF_PTE_MASK;
> +            qtest_writeq(state.qts, pte_addr, pte);
> +        }
> +        riscv_iommu_dbg_map_leaf(state.qts, g_l1_pa, g_l2_pa, gpa,
> +                                 cfg->pa + (offset & ~(cfg->g_page_size - 1)),
> +                                 cfg->g_page_size);
> +        s_pa = gpa & ~(cfg->s_page_size - 1);
> +        page_size = MIN(page_size, cfg->g_page_size);
> +    }
> +
> +    if (cfg->mode == QRIOMMU_TM_G_STAGE_ONLY) {
> +        riscv_iommu_dbg_map_leaf(state.qts,
> +                                 QRIOMMU_SPACE_OFFS + QRIOMMU_G_L0_PTE_VAL,
> +                                 QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL,
> +                                 iova, cfg->pa, cfg->g_page_size);
> +    } else {
> +        riscv_iommu_dbg_map_leaf(state.qts,
> +                                 QRIOMMU_SPACE_OFFS + QRIOMMU_L0_PTE_VAL,
> +                                 QRIOMMU_SPACE_OFFS + QRIOMMU_L1_PTE_VAL,
> +                                 iova, s_pa, cfg->s_page_size);
> +    }
> +    qriommu_program_regs(state.qts, state.iommu_base);
> +
> +    /*
> +     * The specification permits reporting a smaller range. These tests
> +     * verify QEMU's choice to report the effective translation range.
> +     */
> +    response = riscv_iommu_dbg_translate(&state, iova);
> +    g_assert_cmphex(response, ==, cfg->expected_response);
> +
> +    if (page_size > DBG_PAGE_SIZE) {
> +        /* Check the first and last pages, in addition to the interior. */
> +        iova &= ~(page_size - 1);
> +        response = riscv_iommu_dbg_translate(&state, iova);
> +        g_assert_cmphex(response, ==, cfg->expected_response);
> +        response = riscv_iommu_dbg_translate(&state,
> +                                            iova + page_size - DBG_PAGE_SIZE);
> +        g_assert_cmphex(response, ==, cfg->expected_response);
> +    }
> +
> +    riscv_iommu_test_teardown(&state);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> @@ -275,5 +462,11 @@ int main(int argc, char **argv)
>                      test_riscv_iommu_g_stage_only);
>       qtest_add_func("/iommu-testdev/translation/ns-nested",
>                      test_riscv_iommu_nested);
> +    for (unsigned i = 0; i < G_N_ELEMENTS(debug_tests); i++) {
> +        g_autofree char *path = g_strdup_printf("/iommu-testdev/debug/%s",
> +                                               debug_tests[i].name);
> +
> +        qtest_add_data_func(path, &debug_tests[i], test_riscv_iommu_dbg);
> +    }
>       return g_test_run();
>   }


