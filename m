Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NM0eKsZH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3mpIygu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKgc-0001NG-8p; Fri, 23 Oct 2026 15:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKgY-0001MW-Bp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:12:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKgW-0001ar-Gg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:12:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZY934064881
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EgX5xS0Uwf9Zi74wj+cU1i9EJvzf5UHbErqmdcMLpUw=; b=NM0eKsZHLrBu4bpl
 whWuMPtSluhnkbdxKUJeWRfWFsgX2QZwTqIqLwN5BLTQmidyENyx49FwLXNc1kgW
 /ONtK86bb0L+1F+QOuk/bWZB5aZSzWbcKszIeNqICjHY77TJVA6P9BQwWG1P+Srg
 z5lUnJOf/TqjlX6lpLQ3oKhtLxTSK6mMpFPheU7uKDEdJKWcfGgu5/BOzfcKWB8o
 44vDg/1XSp88ifUne55OwSSlqTkzUnuxwQtyHjAEb5CqwDquW3FEyXnQnqHN2Y7n
 HFyyzhRUZpMqhQ/IU1myScXNEwPiZeir4z7OdVhm0eq0Rn4mx+2mjXaD8SX0qUaO
 A0tzfg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarugppw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:12:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so23555176d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792782730; x=1793387530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgX5xS0Uwf9Zi74wj+cU1i9EJvzf5UHbErqmdcMLpUw=;
 b=A3mpIyguEJX8SoWJxAMNNqUfambw/bBqUsjCvp1g74dyczg7xKN6LXHJ/U+0eHs22u
 rhDxZk9qf4AOkL4ppl939m9PdCaPlQTyKCOXFTGBZRe2fqLqtWz4trzxALn7q9AeoA1k
 hr6FJWALJNjbJSCmuOs57zOfgwGAoyVEiBE+7rlUFsIwosdjl4wuuU6L3OnSZEa5yVI9
 ylahO7UYf74gu4xxYKOmyUck5xpmwg7yw0OT5sn9V/Tkb7R7eYEvLQh3apjf4sMxHI8u
 7XrhVo7q9c055WOGasd5OMu9p75W4zncTAGXWiJ9Ltbx5Ayce9ZFYb8QQwGlLqATzMzq
 xnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782730; x=1793387530;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgX5xS0Uwf9Zi74wj+cU1i9EJvzf5UHbErqmdcMLpUw=;
 b=0vRfaeeeRVA8RYLAQIRFYOXwuapjzgTPUfoZLVT5RCkxSU17rddrkmiG/y9hC+Rrwe
 2N0bi0v/FJAbx6nENKDbLRFt0MqhIFC2am5gzPesUTSURo7mCvGFigEWKzT44MGyMSow
 UBuiWJ6K2tDa8S8AJG0c/Hm7Ad8LtoPT6dEhYarvxfpAGpKPHahp0C+QzMdYC+fSGX47
 lbol/5nTqNnCIjKU/7dRkHN0GBQCAe8/g6RcH/RUKayjM9AvgT4Ts8fynEbKX0Yp+5Tf
 a4flK2k797kMD6LLV8jhS5ZJdtPQ69957uQDUfKWsO8e7y6XoZpptI214KMCHYyFnnmW
 l9Pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZeSOWUsuclW9w3g9bwuS0QmPDgFLjqKBgBoTzscivFNKp8hKA2Ko0vmyXswwWXLOs9FcJrEOyN2IT@nongnu.org
X-Gm-Message-State: AFq9FYLkhPnhBI61TY8WYE4Vj36NPEBph9nuXzvf0D9v6ghG+/6FWObQ
 Y/WZ9QAn35mCYfTI//fHA/SacwLBmqBh5iSE3JwrMp1WVpT/nhJF1w7N3BAiN/Ryu618QHyksGr
 uU41cj1yGaQeq/uml3U20s74LnLUsMM6wujuk5R72QMBhy3bd3vMwCNtitQ==
X-Gm-Gg: AYBFou3zWQHWNiYD0f1aUnhuW+Je/WtCmLwXZdiOGS/UaMSIs0z3Pn8XNDTr4ekTKEr
 BtL6j62CcA4IKFXYv/9nJveTDtSLUJ0J0e1LgbFv0j/kVOrQVu5cEqcZpX6dfOj7/ZXtNWdTnBp
 lIYyMhDx9458VO3CKRthXe1Jhj/V2H2dkrzz8s8y1CAgvSfGYw0e8OBzjT4mbooNPtm1+LJu05y
 45j5QwfURKLEjaHcfrGDSZaxQVSxdPrOdJjeAgGHOqLCKAPaK3N8Uv70bReI6ANAg++twF/dW+F
 cWWwnaDMlc84Dmk2I6Tmgai3ljRyNn+q3GyjPlyWf2BB3qhtnckXtazzHU+uircqQlVS+qtqwFj
 fgi9ApGsrOVqs58zd7/fYtW0DBER+KXuAmDba
X-Received: by 2002:a05:6214:da5:b0:91b:90a2:df1f with SMTP id
 6a1803df08f44-91c3aa06c2bmr47222056d6.49.1792782729949; 
 Fri, 23 Oct 2026 12:12:09 -0700 (PDT)
X-Received: by 2002:a05:6214:da5:b0:91b:90a2:df1f with SMTP id
 6a1803df08f44-91c3aa06c2bmr47221496d6.49.1792782729333; 
 Fri, 23 Oct 2026 12:12:09 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47a7cd7esm2521466d6.2.2026.10.23.12.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 12:12:08 -0700 (PDT)
Message-ID: <fa0fb912-d470-42b5-b029-b3b8680dc8fe@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:12:05 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] target/riscv/kvm: create kvm_riscv_aia_access_reg
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
 <20261023021237.486091-2-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023021237.486091-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3NSBTYWx0ZWRfX+HzAJNgCrLZW
 3oy91QKN6Qx9F0BeEa206+ntM3q/Zl+jS9VxlKYC+/93cVBoqUBQFRTZHoKhV55MdN9axygpam9
 74bnFUAscRpR+SvM04k8uAvB7k2UZZs=
X-Proofpoint-GUID: w9i_Rinn2A82BF_vf10aNm9e09QDNu99
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbb18a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=MIYIJ5hYJWVnXa0tc0AA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: w9i_Rinn2A82BF_vf10aNm9e09QDNu99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3NSBTYWx0ZWRfX2LZm3ieTIyz6
 /SnZfsKciVOzhWox+q9ecUucRULVEEm27Xh9XyNm2A+vFlEAXcazef7E0L3Qxq96H583r0nYqsP
 ac/hGXzPfsvBEJuY7qmw7YhfvhIEsSe0LfeGaTdNWItH20Y6y2Ocqlsn/7GjI6UY4MIHQj5Qj3W
 sHVj6H19qAmDL8zrTRIn/z+3Qu8C1pPf66OsnTiWd9zJOB0LqUGDYlZiV4ocraMDGkcFM7uSVOS
 B6ClhGpJvOmjBflR0tSaritOFAG57Hnj25cxkeMSWRPjCdsnYH19a85L+sA4N6qmcOuZRszq329
 A0aiHnRr2hmTcv+3hsJt2EPOKn/DMpV8PUjJwBaFU9D/D+QLvlPGgD/ofMxZLoxZsT9nVAI4h20
 xwN0MRNm+bzCqSVMXSUN9puCfhlhl+LfAGT8A9IzNzJaaClTJ52ga4NNNWMwYis7t1Zg6evcOhN
 FLSCOxdsEne8D9umRcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230075
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



On 10/22/2026 11:12 PM, Wang Yechao wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Create common function kvm_riscv_aia_access_reg to access APLIC
> and IMSIC regs
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
>   target/riscv/kvm/kvm_riscv.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c085b22b23..3ed94f7586 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>   
>   static bool cap_has_mp_state;
>   static bool mp_state_reset;
> +static int aia_fd = -1;
>   
>   #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
>                                            type | idx)
> @@ -1924,13 +1925,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                       "auto");
>   }
>   
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write)
> +{
> +    kvm_device_access(aia_fd, group, addr, val, write, &error_abort);
> +}
> +
>   void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num)
>   {
>       int ret, i;
> -    int aia_fd = -1;
>       uint64_t default_aia_mode;
>       uint64_t socket_count = riscv_socket_count(machine);
>       uint64_t max_hart_per_socket = 0;
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index aef681f0a2..8649219e0e 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -29,6 +29,7 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>    * @level: %0 to clear the interrupt, non-zero to set it.
>    */
>   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write);
>   void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,


