Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C240606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a56n8DJA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IU4mWMvv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLCX-00047M-Oe; Fri, 23 Oct 2026 15:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKLCR-00046X-Jj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:45:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKLCP-0004qX-0f
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:45:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZVka2075203
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SuwmWMnXo4N9bVPaC/4BMpNKYbKR9miJZFK+o56e7js=; b=a56n8DJARgFPqkyL
 OJri5xv/7WbYN5gIV4nmKMzX7+Ns1tCOMJ/ZWYM1H9eoCOZOSJXT5VRsXkrJ1sjs
 3wa3zKw0YzUQyTV34Gny1JrFqUqg6VhLuNdKaQNyYtng11PcQyNYmASCVZOVl09Z
 u5qWsk8Em3POi9+fdk9UqMzOkY/tJ1d8q+4skdn/rDWFmL867w3kwINvS/4mDc+U
 uoafHMT2BzuJJJ4qLk1CzdmxexVov4uZHZ0AEZkORWQlq9jqFvRAcGjai9+svOjR
 MEIzDbh7RvLTCv5dBBajBNAQ+KUys4H3U477nhzvCe7xZjVePA3gRxIY/5lHIuhT
 2M5/oA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr089q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:45:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b4bf686ceso39835256d6.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792784704; x=1793389504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SuwmWMnXo4N9bVPaC/4BMpNKYbKR9miJZFK+o56e7js=;
 b=IU4mWMvvDTcyhm8rd88gjY+XkotLXI791V5JtEnQUoUdiS1p5REb42dLeuRN6nQiqG
 ZMgtIGvZt807yh1UP7569/MvWyE7Yqx8uyqF41ZHEPDQKSbo6JF/5NJZynJSEn9EpQHP
 eWBzEdPC3lYM09a8KUUg6DT1kQA3Yh351/aDe/irbskTFUgw+I5LB+WCpQlBQChdwiYF
 VVLE8YjOZqoXMhUnxFaCOckICXrsA0f2ALvN7yE1soQ+39Mk2x35UZyh2XfTKg6sbNBe
 u5IzloN3yrzSDVbFINyc+PJQ1TByk3GRGj8MmiR+4LCkN9i586zV2yWo69CtlnE2pune
 S+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792784704; x=1793389504;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SuwmWMnXo4N9bVPaC/4BMpNKYbKR9miJZFK+o56e7js=;
 b=UCp8MNzbKIInRtL2ucwljVM+kEdgsXrJ2q7lIa99OzhpSK+syVmsGEMDvTqCvTCvFj
 n6fasrMc+8XlBYVBWX+/j+n+ds7MIHhZ/Ry5KMKG7tPYxGgS68ctZdqEsIfBFZxO8gxS
 mpbLzu6/UaDtOb7CjuAc0jQZ+heE45gfbHi4StlMEJds0QkLYpm8Fd+Hro2EBC4ZmNoo
 8pEZUS9DkY6QeFXL96niQlLuOQNOBCJRqaWLv5CWGhT9J6SxxDMSheNDjVyGPgF8CH/L
 SilS5nhMSsXAdQnUqMDJdc8suRmjL8VrbC1Rrd8rvUFWxFmCXLRp1Eg/x3ZP9dS68DS3
 rpRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6RTgQbcUxXyQxkJoUyghvzyviB0XBgQzhCHy4aWU/e9FahxQu7qxOSZYh+Fpgcfs6g3HPDTG+u3gG@nongnu.org
X-Gm-Message-State: AFq9FYLrFy2N8AwgDsv1QvJIozJfwofNW83KE9igEeUZ+p3/KqZqACsf
 9A1jxku6Tql1LBgnqjsSzCzDMKhjcilpr+/8wH7KYSm468oSRwsxElpXJ3CjgrkoFyGFOdEey/J
 SqTMwLE4cjLKmtQRXxyVxm2nrGqR4BKSoNwoJTy9H0XssHbCS0JE71bGpYg==
X-Gm-Gg: AYBFou1DyRa77pyzrBjoAcp4MpqXuVrVVsg13KWhkPoGCOK0MQr9as4q3if+Yhy6C/Y
 1I+5VpcmcvxkOqTMUAswZDr1GU2WUUO+wYz0K3BZi+11iaKq/CtMp85ijZdDVwa+/opxwTRSp5W
 ztMmh4ieiysNLPMonPqKVEOX+ZA+kqnmJbVGwkvYVB4dMxbv6MQF3wlae1Pn/ago172Oioxdsy3
 bxX6pc689sbFrL9m0fHbwPbVNyvLQeB9QV7Xg2DUkHJZtK0bdtkywBg/S6bYdjA5VAfN8GDXKv6
 yN74BYWVCljrpMorVs9HzpbxSd3hgPYaYDlzKsIXKnIWVyPJfFLe6VPeJTYGimEOAmF1QW4mKYn
 1Lap/VG7BpkiHUpUZkxP1qbBJAOg3lJW3RV6i
X-Received: by 2002:a05:6214:5293:b0:917:b50e:44ca with SMTP id
 6a1803df08f44-91c48e953b5mr566096d6.19.1792784704148; 
 Fri, 23 Oct 2026 12:45:04 -0700 (PDT)
X-Received: by 2002:a05:6214:5293:b0:917:b50e:44ca with SMTP id
 6a1803df08f44-91c48e953b5mr565326d6.19.1792784703327; 
 Fri, 23 Oct 2026 12:45:03 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c0fd12sm2917976d6.17.2026.10.23.12.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 12:45:02 -0700 (PDT)
Message-ID: <a8eb02f1-19e4-4348-9b19-ae3020888d74@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:44:59 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: encode debug translation ranges
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20261022065647.67150-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022065647.67150-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: D5L-vXhctuUzmctpFg3dTvBBbCRxoci3
X-Authority-Analysis: v=2.4 cv=FM6OVOos c=1 sm=1 tr=0 ts=6adbb941 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sMBeUfZxTR-rhmS3ptcA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: D5L-vXhctuUzmctpFg3dTvBBbCRxoci3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3NyBTYWx0ZWRfXwfwVc5dgta/3
 ze3tLhBkTkQypi0MhOagKh+Xe31GBIYm4qJTwBEE4Eb78rwM91L4ynk3Df/vqPk0rcj32wA+Ugt
 ZtQeNJyj6p0qye57/nq3LIbS9vpCQpk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3NyBTYWx0ZWRfX9gkM1hE5XY2Q
 OQugXjxsw0/yLxY71J+5IsCdGHrr4Jx1IfZwRF3YWQSgtFDujtQ/Dc+h3wlRb9YOGeMJ8jJqMF4
 fvPFj+A0Ygvt8kppTuYu0IOR25a120agqU8X3cabK48M+rGGlfZ/NfpVyhh6ILA/8OCQEqcbWqD
 8yXliYtX5nGxb3zF9VIBb+pZ26qenBuQpW8wwrAueQEp2Wtj0qHXFjZlK4KTAkruqwSB9PmhkAM
 027cXn7QPdw2noZaSQAvF2aawBdhE+fMEiVgLdD7AEOyhNXt4n6ktMi9Zu1XkIQlAsSj79+x9Ak
 TYq3rgH5Mq7gfys+P9ACHX1BfJeiqq6OIlu4xswgMVqH4DknwUS6Y5VmmapLLqOQJ2OrPezaPMS
 ZYyEwhr79EBqiOKlwAEEverfiWG/cScfK7bYh+ZR20PI30opq3jFjHk9MajJXccrE26xPWglZVC
 /XqaKatXpCpBcmIRd3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/22/2026 3:56 AM, Zephyr Li wrote:
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Changes in v2:
> - Regenerate the patch from the source tree to correct malformed hunk metadata.
> - No functional changes.
> 
> ---
>   hw/riscv/riscv-iommu.c         |  14 ++-
>   tests/qtest/iommu-riscv-test.c | 193 +++++++++++++++++++++++++++++++++
>   2 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 323a041b4a..67d8456b9d 100644
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
> index 2638024891..1cd753c4f2 100644
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
> +     * The spec permits reporting a smaller range. These tests check QEMU's
> +     * choice to report the effective range returned by an uncached walk.
> +     * No DMA precedes these requests, and debug requests do not fill the IOTLB.
> +     */
> +    response = riscv_iommu_dbg_translate(&state, iova);
> +    g_assert_cmphex(response, ==, cfg->expected_response);
> +
> +    if (page_size > DBG_PAGE_SIZE) {
> +        /* Check both ends as well as the interior of the reported range. */
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


