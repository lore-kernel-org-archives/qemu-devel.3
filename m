Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4796606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2w0c5CC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e/1tmCKk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJasQ-0000NC-4b; Wed, 21 Oct 2026 14:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJasD-0000D9-1Q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:17:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJasB-0008PW-9V
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:17:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpfe04039989
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tCmatb9szwmZFl0cegMmwdEcF24WfjGHsE4rsDbT2vU=; b=l2w0c5CCB+4/BXKS
 sy7jmd4dkGJYN1TRXRNeYCt6pQ7o7Tu5qnrZDahlMgshvtL6OxRF94kGOX3YGoqA
 jyR2ONNxU8EW2U/Zd2fMDfiKPG6MoMGcsJc23zTCPr32wQj4lvUj0G89gZ38g+C0
 GCwjBiqlcKCXtdTJtBSi/gEPASp3i+Lb8R0DXcYcB7cYBZQQadyjckU0oaehs15I
 /nldxxHyc6mAMNWMfAArPelMePC4V4Xlibe8bnZrNdqPk7HC2roNkaB8IPDZirKo
 UouQLZoHTEfkSRr3ahTpO91AsRBou+Uos1zcpt7C+0xdZK0unadxYNOZHXt5//0J
 bFFIjw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7aj3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:17:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f568dee56so204548385a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606626; x=1793211426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tCmatb9szwmZFl0cegMmwdEcF24WfjGHsE4rsDbT2vU=;
 b=e/1tmCKknRXibgWknXmYw+h2aH+dtWiA5JnHQJrdlwImtdQv71gpMOmH2YD637tGuU
 GY9tnhl3WiUQN5Z8OGBBiVGenoLfp6tcf63FwuDs0kK4FoPwb7LouR7Se8mQoEbJe/PV
 XCMLa7UOP2a0aD7T8JBMmIPPqutOv50QO4ETA9VIRzHPWAmDfzehMphmlpjBDH5efFDM
 YzjoYlL2Jr6bufhqpRLdfRyLn2fGoVn1ZLi2gTYdGivpVoXBFPov+oRk6zJY0bJpiU39
 LxCYBan3DNfMEUCBxML/kESOjrWTnvKS+Gx9qpcXGZHxw3aD4uAISbkeR/Yjj7AL8bxW
 p7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606626; x=1793211426;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tCmatb9szwmZFl0cegMmwdEcF24WfjGHsE4rsDbT2vU=;
 b=kJthnEYHCtg0jmyfxBPk5hid1jk946wOifRsJ2va+6J3DUXahMQ9Z3VG0JhuT/Ez6r
 f9FIYEJez7OTMxUrh4c9jz6Rp0YrcqHdfC1lrxzhVnh6oQ0aWqKy2BuhrwQEmuH/DB3J
 ZnJYWbiTWdbPrygW9wC+AjkCbEB7zQSfvhKtvBSMuy7tGwQsIk1eIhR44WavRg0rpAdi
 Xz/3VfHjkSuEEszeDytyuhpvIY5h+UTFD7AAt0wsCSmha6IG4CTLX2dKOzjc91NSPSc7
 bhMumveKVfzpcCEJ6JnqLXo0f+yPCUQsr2uPY9NXbCTKqY8QxkemYHynqrZ7jO9gN9rw
 UP9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXRQuHVYQ8UIDUMw5JAJd+O9FTk+FffkUFYErf2wcX4/Fsrtj1Vu7FOK6Q1luPEnyz1mfEqLE50zr0@nongnu.org
X-Gm-Message-State: AFq9FYK5mQMG1vmXQa+asFho7qHslg6LU0c19cwVLe37jrZZWq6ljmxV
 5lFIvq2RINrbXYPlxe0vbP3fTdF7/PFX+0crKYQRssoMMHcwdEySgh0j4NRfRW8kTncWCrJD+Sz
 +ia21i9JnAmTYNFLEFfwlpx/x/C4j0DzWqDZqDVCyk76Ilt2j54M+Pd963g==
X-Gm-Gg: AYBFou2bfYJ3ED65moErlmFo6tGDs4nfg4ioCBSc3hYnpSUATZvzibtQyxisf7uyQ+9
 CczjUNFrp3eluTegZAdWEzkBkc14Dk0PG+nowdjGyR4Lzg6h8EhUKgLaBg6FSIx2XUhr1jlPWno
 nWVNJLs7PcCnGsmi1nSqBMjAOwBvBZje87a1CRUvBhaWes17ZMCnghmbATzwOvJzMBrDKQyGc2P
 VWUaFdv9Ad/Jfu8In9x0INl8dWNrQgcaWKER7zRQ5xpNKhGOzk3FxSIIKUSRiGaCRwaRag5xVCE
 j313r3mgAJLFmtbgSUIfLz0YNgtYAdyXaA8pGljkQYU9IcYu9iH80ob3Ftv8IIfzAZRyd3HoVs7
 BA1++1TUwJh/+hoSw6UpGgXCgYTiMiQVF3TaRRoSkJIrZ9HjicPcPJXkKzinvsJ9/PQv6Stab
X-Received: by 2002:a05:620a:6889:b0:93e:c12c:fbbd with SMTP id
 af79cd13be357-93f57f979b2mr576252985a.74.1792606626549; 
 Wed, 21 Oct 2026 11:17:06 -0700 (PDT)
X-Received: by 2002:a05:620a:6889:b0:93e:c12c:fbbd with SMTP id
 af79cd13be357-93f57f979b2mr576248385a.74.1792606625992; 
 Wed, 21 Oct 2026 11:17:05 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56d9acd3sm318143385a.14.2026.10.21.11.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:17:05 -0700 (PDT)
Message-ID: <004ad2ad-c9ea-4900-8890-7d06ad59bfd4@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:17:01 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/riscv/kvm: Sync SBI STA shmem registers with
 KVM
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261017145211.219258-1-wang.yechao255@zte.com.cn>
 <20261017145211.219258-3-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017145211.219258-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QqYymfhDyMyE-nj8s_TDNH-gUSnARR9K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX7eKE7RltMCI0
 7Okp0WMe5avo3UhPdpsrvKMYMHnWpDHtYjD+4WggXsXuT03H+kXAlg5p5hjEK/ilklcMo2Z6n8o
 mqwX/urSu+Lee3dtxbgg3ncdYh/vGtXjTQivyKwwpAYy/l6BvcvqcelHQcJzWVPHMe2Zw+si2pH
 DvAqt4umesqgzUM7YctWrXYqOj+PCy6K6BeINdtUtcIQq+X4PnaEDnc+z4wfjXG2m4UiffukS9c
 CrsItLN4V2M0ZzEtAgiKWAcl2kzB2ULHKmWa9xRsmbzUjjpu7a+muwe737aRtDfeV3oqSqfr+YB
 8HM6QAqWiPYhJGSLThe8VGNQh8LVHvV/GXhMNcN6ZmbFkDrOiiXLT3E1T4JlQi48UTiv1AVUlFy
 ouSkH/2ULPhomppok+4q2jFhtbXLu9SRfuRFG2UjvE2zOqcb8SvwlnxrzJy3IFMs+92a2X+w2JX
 jPH/m+CAORoARYeJ/4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX6oIj/Y12D85O
 TANUueEnOIkO1GzfpDQzEuIAqhxWTugguyNH6xXo63X56UqmJKAXPXOQ/4cgtQTG1hccGpXBbRk
 E3YDFP4WWy1ueyjcug/qvPAnOqCGu7U=
X-Proofpoint-ORIG-GUID: QqYymfhDyMyE-nj8s_TDNH-gUSnARR9K
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad901a3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=Vh72rk8m_-1sL1oCfmAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/17/2026 11:51 AM, Wang Yechao wrote:
> Now that SBI STA support is detected, synchronize the shared memory
> address (shmem_lo and shmem_hi) between KVM and QEMU using the
> KVM_REG_RISCV_SBI_STA one-reg interface.
> 
> The shmem address is configured by the guest, so QEMU does not
> need to perform put reg operations during reset.
> 
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.h         |  6 +++
>   target/riscv/kvm/kvm-cpu.c | 97 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 103 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b65d631994..4da7963d3d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -34,6 +34,9 @@
>   #include "cpu_cfg.h"
>   #include "qapi/qapi-types-common.h"
>   #include "cpu-qom.h"
> +#ifdef CONFIG_KVM
> +#include <linux/kvm.h>
> +#endif
>   
>   typedef struct CPUArchState CPURISCVState;
>   
> @@ -550,6 +553,9 @@ struct CPUArchState {
>       /* KVM multiprocessor state */
>       uint32_t kvm_mp_state;
>       bool kvm_mp_state_loaded;
> +
> +    /* kvm sbi state */
> +    struct kvm_riscv_sbi_sta kvm_sbi_sta;
>   #endif /* CONFIG_KVM */
>   };
>   
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 8ab43432dd..ba5ba63854 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -123,6 +123,11 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>       KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
>                              KVM_REG_RISCV_VECTOR_CSR_REG(name))
>   
> +#define RISCV_SBI_STA_REG(name) \
> +    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_SBI_STATE, \
> +                           KVM_REG_RISCV_SBI_STA | \
> +                           KVM_REG_RISCV_SBI_STA_REG(name))
> +
>   #define KVM_RISCV_GET_TIMER(cs, name, reg) \
>       do { \
>           int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
> @@ -1010,6 +1015,88 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>       return ret;
>   }
>   
> +static int kvm_riscv_get_regs_sbi_sta(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    target_ulong reg;
> +    int ret = 0;
> +
> +    if (!kvm_sbi_sta.supported) {
> +        return 0;
> +    }
> +
> +    ret = kvm_get_one_reg(cs, RISCV_SBI_STA_REG(shmem_lo), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    env->kvm_sbi_sta.shmem_lo = reg;
> +
> +    ret = kvm_get_one_reg(cs, RISCV_SBI_STA_REG(shmem_hi), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    env->kvm_sbi_sta.shmem_hi = reg;
> +
> +    return ret;
> +}
> +
> +static int kvm_riscv_get_regs_sbi_state(CPUState *cs)
> +{
> +    int ret = 0;
> +
> +    ret = kvm_riscv_get_regs_sbi_sta(cs);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_put_regs_sbi_sta(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    target_ulong reg;
> +    int ret = 0;
> +
> +    if (!kvm_sbi_sta.supported) {
> +        return 0;
> +    }
> +
> +    reg = env->kvm_sbi_sta.shmem_lo;
> +    ret = kvm_set_one_reg(cs, RISCV_SBI_STA_REG(shmem_lo), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    reg = env->kvm_sbi_sta.shmem_hi;
> +    ret = kvm_set_one_reg(cs, RISCV_SBI_STA_REG(shmem_hi), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return ret;
> +}
> +
> +static int kvm_riscv_put_regs_sbi_state(CPUState *cs, KvmPutState level)
> +{
> +    int ret = 0;
> +
> +    /*
> +     * The shmem address of SBI STA is configured by the guest. During reset,
> +     * QEMU does not need to perform put reg operations.
> +     */
> +    if (level != KVM_PUT_RESET_STATE) {
> +        ret = kvm_riscv_put_regs_sbi_sta(cs);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>   typedef struct KVMScratchCPU {
>       int kvmfd;
>       int vmfd;
> @@ -1433,6 +1520,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>           return ret;
>       }
>   
> +    ret = kvm_riscv_get_regs_sbi_state(cs);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       if (cap_has_mp_state) {
>           struct kvm_mp_state mp_state;
>   
> @@ -1520,6 +1612,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>           return ret;
>       }
>   
> +    ret = kvm_riscv_put_regs_sbi_state(cs, level);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       if (KVM_PUT_RESET_STATE == level) {
>           CPURISCVState *env = &RISCV_CPU(cs)->env;
>   


