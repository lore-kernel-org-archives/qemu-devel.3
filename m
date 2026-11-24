Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED20606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FCXTLStI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S/Q6DRpI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpLq-0008TV-VO; Tue, 24 Nov 2026 07:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVpLp-0008RM-Hk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:10:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVpLn-00053h-F6
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:10:21 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuiLY1291471
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pL6ECdXWGWJyQUR7NU2K8YN5X0twR4g3xpI5ONBMkf0=; b=FCXTLStIWws/6qGy
 aey8wtTEHsNtgM8F48G8LVrCeXMu1gnMUvh08uFw4J+ZiaA0+2fJA8cbI0LVAZpw
 TxYnFAeTtKadZtxS47kS6aEyehw0JsUKk7kgN3xEZO3zO4gmSLfCaKCyGGiETGOm
 aa4oefybTEws4JNRjUQ7946w5nN2AhDZnPwafSktTpc8hAzW4diHh8ZvWzcG4VY5
 xSEVFqH4GLtptx5uK7IW+361UqkCQAS1B4hQo847/YcJklpUHHsi5MZFvFn/UKjw
 5M/uZcB6ED1V2OkRfFwb93NVISaeiGlsMfOkw+rsdGTf/hOG4rMBr8c2Gg2vxG45
 1W/ohw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukrbkjp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:10:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94961ed97d6so785101785a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795522216; x=1796127016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pL6ECdXWGWJyQUR7NU2K8YN5X0twR4g3xpI5ONBMkf0=;
 b=S/Q6DRpISE75wSRhcry1kXdUz061vb1C17KJfl0kmjx+Np8D2ZLeSj32Frh9wIHIgM
 qPDqLuEzRkcK0+c16+a2OBicawLpTJpRcyX/0YZWbIeROrsCDiUeKQxatBQ/hjVgwDqB
 h50hRlVTvJzX3wsquiwZoigIyVWUeOQo0vAgS6K82XOp+Xne5xcjgfkTjQKYOGVykzK8
 8C66gC1OrpJm971h/0YWByRZ2Q8iT/8QKGL8OyUOrb2VWjMnvY4Ht0lcHaIOv6JvytjG
 hDssULMT4oVVpFpucLfepZHgdjGKrtiuNSobBzzAng9adGtmvuVDOYGLJh2o2Sp2+Nm+
 PoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522216; x=1796127016;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pL6ECdXWGWJyQUR7NU2K8YN5X0twR4g3xpI5ONBMkf0=;
 b=zI7gyoVsOpwnozBA84Uizyc/CsyITkiBJve8mI3PCxf8n7vCZO/7MwRAbHfjr7JGc9
 GsNrqAcXSgOPyX+zSQ971AZRS+vVFGoUk0kLAPGSIZE/HE2MqIsHvvYro+0aity5uYok
 ZNhBn0Z15Oh+pUB3QqmhLNEZ4jkwTdWG5BKMgMibRB6C1vTW6/PLCFXN5HVzZ3ERmadB
 UmeMRaELK+vYz0phZl5euX46LNpFYgfDkNUVOQwcHQxAFLRp/Pz2ccRJWCNuzv5a7zqg
 75rgAbcAdwzsuxTgscXzTXcFIcfgiVlGJgMWFIdWlOeFpk4CHfd7SZyTdSL/AlEiwjQa
 X7aA==
X-Forwarded-Encrypted: i=1;
 AL+hErGt0yZflHUgE78ZR04Rfb9On6VHE/2LahAW530N0RRRiP9QHP/5EmgXBLc0+am+Qn17M9Wq/GdN/APn@nongnu.org
X-Gm-Message-State: APuU4Z87NkWLI4q++D1+1WfLUZAIYeGan395YbVuXaUYDHKXNHwy7rjb
 hvzQRjlSw764ng8pNLAt6gwcO2PmV/IB2l+xQDCrWv0NZHtPu99Qs4rMEUhJMBgpPGHuXAFYGv/
 sW1hGKg7eyt9p3p/0JTZJB4O/jOwYGOgJlcyv30Om0sAOcXr1fOJG09O8Mw==
X-Gm-Gg: AZFdTZdXofxvgO6FGR+OSDMspuIHZiPOeXouIjA8AmgPr2e7N93FPFty8xwJprEV4zS
 DtoDughbe/ou8SV9irIqVoFRwElzGS+YRDwduUEml6sO/y3tJlp2UGOVHMh2F2k68mDySm4B+oh
 yNRcEeBWm0/f1bZdVin8nhdEuftSqtyR7knME3KFM3VDOOMoyxnLNPDsE8L7Cj8A+bVoF+AwEsP
 oxIPNg7U+Z+WlGE7jQ4SmAQeF3k6V+8eYG2K5RxBzs+6Jtcq0PS/gqVzbdxo6dV/JMcg/Ue8xcB
 FuCJaurQZPHHarUwvC4iZDM0exXPs+7dYtGQanTZwssJ3YVP53acfXtfM4dNkNDnOpmzZQkK3+Q
 ixvQupY+tX+DvbL6V4Bzh2TvOzsi2v8HaK3jzyHwaHj5eKrqx60O6henI3MOY8zyzdN85OIU6h2
 DZfLOtPvMw
X-Received: by 2002:a05:620a:2852:b0:949:8014:70e1 with SMTP id
 af79cd13be357-949ba95ad91mr2349567585a.6.1795522216071; 
 Tue, 24 Nov 2026 04:10:16 -0800 (PST)
X-Received: by 2002:a05:620a:2852:b0:949:8014:70e1 with SMTP id
 af79cd13be357-949ba95ad91mr2349560685a.6.1795522215541; 
 Tue, 24 Nov 2026 04:10:15 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb41c105sm1037498885a.39.2026.11.24.04.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 04:10:14 -0800 (PST)
Message-ID: <9433586e-b0be-45b9-ac8d-731e9150a1df@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:10:11 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/riscv/riscv-iommu: Fix MSI fault PV reporting for
 process ID zero
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20261116075141.167317-1-fritchleybohrer@gmail.com>
 <20261116075141.167317-3-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261116075141.167317-3-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfXxjaJOHDO0B15
 Pyr96w0Hc6XotKrl7hK9XwWStF6S2pQhxjQ5WP8BLggFohq0vx2zsGKATaSrk5z3CdkceRooANw
 k66oZkXXY22M45eqBOERY8PYrW+ELbs=
X-Proofpoint-ORIG-GUID: rOciaYbuQ7DiaPglvvHaXrpwlrB96iX2
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b057ea9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uJ3uQbJpOyNGPb6jDGQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfXx0q37TL77VuF
 KVtpcWULrHf4dS4PBdnIeEeLi7dyz9r8fkobaA0e2irCGgOM1J2eHXDUo9U7NCnkvOjsi3mXI9V
 652x2tiM61R4FfVivgVBenFYJul0bHdCP5JZsJa8Z3krXvRoxQyDmEhpCxi+1cwEEGMtk0ejNMH
 fAgYjSRwsw+cBUj5zYWCkOcLxhcekAXvmNewvwBEc0Fw6kJgnOtGEAtHKY5i2PmT++u8bRCBf8F
 RGeZVIvF223Dvd8On+aFQ3l1yRY7DDnpwFL81/mZyHH0drUOzN8Byd0FevhNztrIWhGmSB3O0vn
 w36Alu8PQkh6XZtdVP0zkxyonxXHeJP/qrqqbOkRtwYSe6JC3tJzK5vuEb7nYWWqDJI/gUbzD4K
 cSUVnHW6rkIqkpZwU/CJxXKT7U/EnJIkru/ctnWVQ0y+xn1XRn736wOS3rzq2S8122fyzburoZn
 H69LpBvQuWNDTRTiy6Q==
X-Proofpoint-GUID: rOciaYbuQ7DiaPglvvHaXrpwlrB96iX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/2026 4:51 AM, Zephyr Li wrote:
> MSI fault reporting derives PV from the numeric process ID, so process
> zero always produces PV=0. Ordinary translation faults and recovery
> faults instead use the device context's PDTV bit.
> 
> Use the same PDTV policy for MSI faults. Add a qtest with a real PD8
> process directory and DPE-selected default process zero, reaching an
> invalid MSI PTE after nonidentity nested translation. Check PV=1, PID=0,
> and the original IOVA. Also check PV=0 in the existing fault cases
> without PDTV.
> 
> This aligns QEMU's current context-based reporting policy. Preserving
> the validity of an explicitly supplied request PID separately from its
> value is outside this change.
> 
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c         |  2 +-
>   tests/qtest/iommu-riscv-test.c | 36 ++++++++++++++++++++++++++++++----
>   2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 016e95fce7..5752a4776b 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -831,7 +831,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>   
>   err:
>       riscv_iommu_report_fault(s, ctx, fault_type, cause,
> -                             !!ctx->process_id, iova, 0);
> +                             !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV), iova, 0);
>       return res;
>   }
>   
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> index 3678d8a0d4..28af06d770 100644
> --- a/tests/qtest/iommu-riscv-test.c
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -27,6 +27,7 @@
>   
>   #define MSI_TABLE_PA            0x80030000ull
>   #define MSI_TARGET_PA           0x80040000ull
> +#define MSI_PROCESS_GPA         0x00050000ull
>   #define MSI_DATA                0x37
>   #define EDU_DEVICE_ID           0x11e8
>   #define EDU_IRQ_RAISE           0x60
> @@ -62,13 +63,15 @@ typedef struct RiscvIommuMsiTest {
>       bool valid_pte;
>       uint64_t s_walks;
>       uint64_t g_walks;
> +    bool default_process;
>   } RiscvIommuMsiTest;
>   
>   static const RiscvIommuMsiTest msi_tests[] = {
> -    { "first-stage-bare-fault", QRIOMMU_TM_G_STAGE_ONLY, false, 0, 0 },
> -    { "nested-fault", QRIOMMU_TM_NESTED, false, 3, 9 },
> -    { "first-stage-bare-basic", QRIOMMU_TM_G_STAGE_ONLY, true, 0, 0 },
> -    { "nested-basic", QRIOMMU_TM_NESTED, true, 3, 9 },
> +    { "first-stage-bare-fault", QRIOMMU_TM_G_STAGE_ONLY, false, 0, 0, false },
> +    { "nested-fault", QRIOMMU_TM_NESTED, false, 3, 9, false },
> +    { "first-stage-bare-basic", QRIOMMU_TM_G_STAGE_ONLY, true, 0, 0, false },
> +    { "nested-basic", QRIOMMU_TM_NESTED, true, 3, 9, false },
> +    { "nested-pdtv-pid0-fault", QRIOMMU_TM_NESTED, false, 3, 9, true },
>   };
>   
>   static const RiscvIommuDbgTest debug_tests[] = {
> @@ -389,6 +392,27 @@ static void test_riscv_iommu_msi(gconstpointer data)
>       /* Match one GPA page; interrupt-file number zero selects the first PTE. */
>       dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DC_BASE +
>                 state.testdev->devfn * sizeof(struct riscv_iommu_dc);
> +    if (cfg->default_process) {
> +        uint64_t process_pa = QRIOMMU_SPACE_OFFS + MSI_PROCESS_GPA;
> +        uint64_t g_leaf_pa = QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL;
> +        uint64_t fsc = qtest_readq(state.qts, dc_addr + 24);
> +
> +        g_assert_cmpuint(cfg->mode, ==, QRIOMMU_TM_NESTED);
> +        g_assert_cmphex(cap & RISCV_IOMMU_CAP_PD8, !=, 0);
> +        /* Map the PD8 table through G-stage; PID zero selects its first PC. */
> +        qtest_writeq(state.qts,
> +            g_leaf_pa + ((MSI_PROCESS_GPA >> 12) & 0x1ff) * sizeof(uint64_t),
> +            ((process_pa >> 12) << 10) | QRIOMMU_LEAF_PTE_RW_MASK);
> +        qtest_memset(state.qts, process_pa, 0, 0x1000);
> +        qtest_writeq(state.qts, process_pa, RISCV_IOMMU_PC_TA_V);
> +        qtest_writeq(state.qts, process_pa + 8, fsc);
> +        qtest_writeq(state.qts, dc_addr,
> +            RISCV_IOMMU_DC_TC_V | RISCV_IOMMU_DC_TC_PDTV |
> +            RISCV_IOMMU_DC_TC_DPE);
> +        qtest_writeq(state.qts, dc_addr + 24,
> +            (MSI_PROCESS_GPA >> 12) |
> +            ((uint64_t)RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 << 60));
> +    }
>       qtest_writeq(state.qts, dc_addr + 32,
>                    (MSI_TABLE_PA >> 12) | (1ull << 60));
>       qtest_writeq(state.qts, dc_addr + 40, 0);
> @@ -437,6 +461,10 @@ static void test_riscv_iommu_msi(gconstpointer data)
>                            RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
>           g_assert_cmpuint((hdr & RISCV_IOMMU_FQ_HDR_DID) >> 40, ==,
>                            state.testdev->devfn);
> +        /* Check QEMU's PDTV policy using DPE, without an EDU PASID. */
> +        g_assert_cmpuint(!!(hdr & RISCV_IOMMU_FQ_HDR_PV), ==,
> +                         cfg->default_process);
> +        g_assert_cmphex(hdr & RISCV_IOMMU_FQ_HDR_PID, ==, 0);
>           g_assert_cmphex(qtest_readq(state.qts, fq_addr + 16), ==, iova);
>           g_assert_cmphex(qtest_readq(state.qts, fq_addr + 24), ==, 0);
>       }


