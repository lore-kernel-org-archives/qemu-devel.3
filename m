Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC69606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VZYdlOQ4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BXLDk2DQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWumZ-0003vj-89; Fri, 27 Nov 2026 07:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWulw-0003dh-UB
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:09:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWulu-0006P7-Ct
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:09:48 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARApYqs2058098
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bfCHy1aGwvGQoIT9FaQIWSQLz57DDUsdUsnvI1uV63U=; b=VZYdlOQ47dz8J7cr
 Jy8I/quOoRtLYGSl2X2JMq8NnKvnXB6VM3xUEBeve/qPoddhaH6Oueom24KchKRg
 MK4ybHitMh0KqHqu8C+rIOJvKUGEWYFq8GXgvOQ9HIDy59UxcxZzK0Bg5V+u4YjX
 Gxz6LUd9wScnfkJ1HcZoFToWxSvQgKlzZBoVmbtcpP5S8l9iMHY3CBbPvvQ/vnWd
 JmKlnSUFUu29asOOmdK1BREtTPd/8Cexk4dxf1fYpgD54JoivyN+lp2TPO/9+yZi
 /nQh3u0RbLaLU7b83sLAO1Hg6tqstz4M+p4DFQp5E4t46/8hZsuNdNKVENzXV75T
 8exmmQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gasbtp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:09:45 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-869553205a7so102093107b3.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 04:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795781383; x=1796386183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bfCHy1aGwvGQoIT9FaQIWSQLz57DDUsdUsnvI1uV63U=;
 b=BXLDk2DQTlZBLlPUfWRvttpgbEeKANbT/G4zqMw+ZyLU+/wmvuwASiGF2QJdLzy1tF
 L3nezlyDCG2Z10AkyK7E+RVUs+bFoGoxoUaUIbjiLz4LWBh95G/dB3cs6wRyODq1D2Sa
 NTu334g14pKuPFu7vS1J4uW75D9Um+CRttpSmRm3zhtwdVkTnTbt6xrAAce/7nlbxrpW
 krgg/QixEEsKXSAD4qsjqEMxYoHDI4Tnr1eAkP1pl15OoEmxENSH7q50dlaVGQ7KD437
 o0b1zccH7uODfvis56tqQC3foaMlNwp/WU20B0/Xk4fnlMZWOPkHvUDQEPcMk5y43F2Z
 Wr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781383; x=1796386183;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bfCHy1aGwvGQoIT9FaQIWSQLz57DDUsdUsnvI1uV63U=;
 b=1D/Xiy+YWqsq7ZiqN/clsE2ND+RuC9RUz/vHOylGtE+P+zfeaUZnaVkB6u4FINRpTf
 srHnzEorQrNlpJTLmqn/xwXxaK2GnbmvA12/6bU0hNgvfwK7FHbufAAIBDXYvdi8+hl7
 DSW0S40hJ+2z5H+qt4+y0s5Rds/kLEw2GXRryD0rIEcax0T6qYwiKEGUoSGH9YdTmzmB
 d03pSuNgiEXzNsMillwiQ7oy4x2Rp4NYl+to0W96B29c21swsjiJCWnCNsM6vsFOY6/v
 pwltBKKW6jTJVt1DbwVIfNzXU4QAzFTtfXfmGccg0iZzzrtZK7wEuF6HYqIxwWZTDvY9
 NkoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHkCyHbjgN0bhThbLrx9rEInmi9doXf8+m6v/p9hvkr4j/4QUZslnab4b1FdoWohqH0J8vaCCHVPshk@nongnu.org
X-Gm-Message-State: APuU4Z+fn+EkIrbLOmPFCJkcBFjfnJtlyXJxFN11BaWBLmK1es3CSUv6
 GxiTGXIuilvXHfmzpXLoSs4O2kd84OyA0dTxq0SGQ5MST/W7XaN0VuGxX6Ogn83MPSExkHMr9jE
 LxX/4xVbzhr4T/hwZWmCZIQn0Rwk24sWXRSFSD4KTVYPAlCmWyL7rRJEeHg==
X-Gm-Gg: AZFdTZdQO8YvkNVOiRkZ/f3LRxl3AVHzwaKntYqVUAcUPuvGB1d5Mb6yC2UjkBrYGhc
 izU2G4zpp4uVzwq95jjM+lHilH1kn+PxKCtv+NMOypmKbn4rrsjRENObHmOXA4+O+T0XDaDj0jZ
 b8rtAB3cZu2IBE+YvDhBtcfhyVjPrSsPKREyBa9CdOJjFcaf2akOvG7lblAMxPrFSc6dHoKX1Mt
 CEWU53yh7ODaamuzyoKGHfPiLKwHEKnYrEqH+cvkk0xYSe+jLl9gEzVvOJ3lVlr1RH2w6XivmNv
 rAmXtIrmjW+hF6H40p68W2cle5GahTP5LghATh0kn6g2SKk4E3Rxy5x0FaDx/185J6TKUsSssx3
 +Nqfmz4YU70C48DOdJSp+x5WTq0Ade7bkRVkze35fHSbAUK54kBYeK/cmW1Ng+CYvSK59F5C07b
 bCjFs4mkE=
X-Received: by 2002:a05:690c:6887:b0:8b4:c1ef:a7a6 with SMTP id
 00721157ae682-8b52043f895mr95357067b3.12.1795781383491; 
 Fri, 27 Nov 2026 04:09:43 -0800 (PST)
X-Received: by 2002:a05:690c:6887:b0:8b4:c1ef:a7a6 with SMTP id
 00721157ae682-8b52043f895mr95356897b3.12.1795781383099; 
 Fri, 27 Nov 2026 04:09:43 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm47824160f8f.2.2026.11.27.04.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:09:42 -0800 (PST)
Message-ID: <4ec0f721-e206-4891-8987-87ec298bd81a@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 13:09:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] target/ppc: Use 64-bit TB flags
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-16-philmd@oss.qualcomm.com>
 <60270254-3b7e-4d83-8549-7b8f64845adf@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <60270254-3b7e-4d83-8549-7b8f64845adf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cjYdtmXQsS5qugqJh_UJt4m8JfAaf_Yw
X-Proofpoint-GUID: cjYdtmXQsS5qugqJh_UJt4m8JfAaf_Yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX97PNmWlM7vlm
 cHjT0hbbLdk3xh5+wl4PWuyxZiu0M+lFQ6l0vrWTNFH14/6zqzu8B23ZQgYMrROnBSei69mqBOM
 M9gyEwua8hfZwA5tFNAnfWFRWQmSE0L1g2OLEJr9bVdMSA868luk4Hw8Xm+io8BoDYwThruVG9U
 0eFsKWG/8o9ybdDup4/KOuHAB1zHp4/W4vsc84ZOuEjCSovejWz2wME7MxzCz4ggEoxEDflZlns
 0+/3G5DyAUa+Kgw2/7UbuYC4VRTSuJn6EDTcItOjQ0LYKjrIHwf6X4+S5G7fUTvum7K3oOABohU
 0BpJzA4fevqD4OWr8iY1VTLnJSyXFUVBcTC4bOJKgUgpUa5qgUAyd9PryFe0+VPLADBPbRtCUyG
 rcdhslKvh4tbxYnloE8cHjB+CYe6ZhikVo/F3yfJPSQ5t74YyoOEoSucRvqtYblnYMbcufXquwr
 DCwm6n9kza/tzU1Pavg==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b097309 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=OCz7AubN24_iuOGhtk4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX9GRyy1XjuX6t
 Uw8BsBwIjz5fCSM3unSmPZmtPnZGcILZ7JRcNBCXqIgmp6q8erd+5FLOuQ1flLRH3Ig2QvNFxrW
 xEaDQD6iQ5ASrEwe2f7pOA/b5PJrCJM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 27/11/26 08:57, Chinmay Rath wrote:
> 
> On 11/27/26 05:05, Philippe Mathieu-Daudé wrote:
>> TranslationBlock::flags and TCGTBCPUState::flags are now
>> 64-bit, use matching types for the values derived from them.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Hi Philippe,
> Few months back I was wondering why cs_base was used as an extension 
> instead of extending flags to 64 bits. With this series, now I 
> understand that it was to support 32 bit hosts. Thanks for that!
> 
> I was wondering if PPC env's internal hflags should also be extended to 
> 64 bits with this, but I guess that can wait for when we actually have 
> more than 32 bits needed there.
> With that,
> 
> Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

Thanks!

Easy enough:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Date:   Fri Nov 27 12:59:28 2026 +0100

     target/ppc: Widen CPUPPCState::hflags to 64 bits

     env->hflags uses almost all 32 bits: HFLAGS_DMMU_IDX is
     bit 29, and the composite dmmu_idx occupies bits 29..31.
     Widen CPUPPCState::hflags and the helpers accessing it to
     64 bits (adapting format strings), so more hflags can be
     added.

     Suggested-by: Chinmay Rath <rathc@linux.ibm.com>
     Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0f44096bad77..c8c9578f413f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1436,3 +1436,3 @@ struct CPUArchState {
      /* These resources are used only in TCG */
-    uint32_t hflags;
+    uint64_t hflags;
      target_ulong hflags_compat_nmsr; /* for migration compatibility */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7f3036d903ea..8675a8d772f4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7610,3 +7610,3 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int 
flags)
      qemu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
-                 "%08x iidx %d didx %d\n",
+                 "%016" PRIx64 " iidx %d didx %d\n",
                   env->msr, env->spr[SPR_HID0], env->hflags,
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index acf74c543a17..0ed188c4d70b 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -83,5 +83,5 @@ static bool hreg_check_bhrb_enable(CPUPPCState *env)

-static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
+static uint64_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
  {
-    uint32_t hflags = 0;
+    uint64_t hflags = 0;
  #if defined(TARGET_PPC64)
@@ -116,5 +116,5 @@ static uint32_t 
hreg_compute_pmu_hflags_value(CPUPPCState *env)
  /* Mask of all PMU hflags */
-static uint32_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
+static uint64_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
  {
-    uint32_t hflags_mask = 0;
+    uint64_t hflags_mask = 0;
  #if defined(TARGET_PPC64)
@@ -130,3 +130,3 @@ static uint32_t 
hreg_compute_pmu_hflags_mask(CPUPPCState *env)

-static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
+static uint64_t hreg_compute_hflags_value(CPUPPCState *env)
  {
@@ -134,3 +134,3 @@ static uint32_t 
hreg_compute_hflags_value(CPUPPCState *env)
      uint32_t ppc_flags = env->flags;
-    uint32_t hflags = 0;
+    uint64_t hflags = 0;
      uint32_t msr_mask;
@@ -266,9 +266,10 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
      CPUPPCState *env = cpu_env(cs);
-    uint32_t hflags_current = env->hflags;
+    uint64_t hflags_current = env->hflags;

  #ifdef CONFIG_DEBUG_TCG
-    uint32_t hflags_rebuilt = hreg_compute_hflags_value(env);
+    uint64_t hflags_rebuilt = hreg_compute_hflags_value(env);
      if (unlikely(hflags_current != hflags_rebuilt)) {
          cpu_abort(env_cpu(env),
-                  "TCG hflags mismatch (current:0x%08x rebuilt:0x%08x)\n",
+                  "TCG hflags mismatch "
+                  "(current:0x%016" PRIx64 " rebuilt:0x%016" PRIx64 ")\n",
                    hflags_current, hflags_rebuilt);
---

