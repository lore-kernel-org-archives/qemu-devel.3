Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08265606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YmfWbAm1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y4tx52/L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKBg-00025N-Dg; Fri, 23 Oct 2026 14:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKBQ-0001wJ-8e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:40:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKBO-00079P-HP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:40:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZrvf3560868
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 18:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R7z0cT5bIIqo/49JO3nou+YQIHlNbtfIEpB5zwgFiRk=; b=YmfWbAm18kXunRfw
 lYGdPLb/Kl1mB3wtwMhTEQM2QFwjaC852E+HFDTDSTf9Xd20lLZ4hNsKOyoDyBJA
 e7cUMC1gNIGWvL2FJjBnTyxMPNl8haO7dCj2YvdvP1LkaMtNx5eWGF5EauqcM40k
 jd8FSifMJnbE8ZeGGDQlJ1WvX3U7BH8/WS2LZz7nr3lrZu9FKluSmzez1GRfqkyJ
 YZ2/NgIRWmphOaF55yWwpJPjq8znJ2C/7H7YhAnbDmACiDbcKOI0TN4Op9uopwL8
 ZIqBYVWIm+9OodjcM6AxL77W53ctgPVV8hL9J1vRIfFOQa+Qa3ZYZQHjNspfes1/
 10wUtw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart0kq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 18:39:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so23964585a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792780799; x=1793385599; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R7z0cT5bIIqo/49JO3nou+YQIHlNbtfIEpB5zwgFiRk=;
 b=Y4tx52/LZ0STDbbiR/k1YhOdTaKTElQT9s6OnIYDn+ZJD32LVQDqX2IbGJoAjiMz/B
 dl4mcu5FrVxawI/J70nmMtcMPUXXJdb5QdvErwFVRphZeCgSZk1kCqcELFbYnRqIQh0g
 hrN34YbFQSl8OHrVBv1OXk13ZLCT59QSReesZShqzgEC6PzbbgaeQjU3DhrUB7t8ZOCv
 maJPoJQvZ6ohB0OUQ8Gs7dU13ePM3yusNANUlOQ8NJhYoDNh/wQgafzuPOv2ckh8aPGf
 /b9Q6FLHXAHl9eq5G52ptpblSmmytDf2WUJltReKbwGX7n6EJxalFe/gJqYM6tFFKNLO
 IS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792780799; x=1793385599;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R7z0cT5bIIqo/49JO3nou+YQIHlNbtfIEpB5zwgFiRk=;
 b=VTIgE9iEufK5S9j4S71ggzxyJiHl9QEXPq1fgrAc9peCUt3m0Q64orPB6DVE9DJ7+4
 lGkczW3Nn6KiBZwq/i6bfDUXg3vpqB6+ExxhhABRTAFFOPUV+BWHNoKZfWmXBKsl+Amn
 u7vXH5ocSxyWrc5Aq3cUPnY/H17slzGtbfIW53+Scd6k9tDJ2clCvvJu2TuUt85taqkd
 VmJ9yUmw4/wtYKB8WFy+uq4/5OHCzNufwR29zz5Ez3VZtcz4nW9RWm4PKAgECt147+Jt
 2tpOKyu1Cu0EkTo36xc57O82Tdkdepdbbq2pcvJHP0Onl7kxQMyVLhqpm0sjX6vpYfAu
 +BZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeRtuT8nqVrwQVFn9kpRORl7oT4Yw1mqwo1Fer4vqjcsCVHBMO47qlaSzAj1xJC2xStcj7LMOqpOCm@nongnu.org
X-Gm-Message-State: AFq9FYJP80+7KsavYt4/W4KWMp/wfqFo4g7hKs1JQbDJ+/TmrgnTMXlA
 6CtpncjMldfvxBjEeVsZ0xid3w+FL2n35DUmNgW4lV0bvkVlQHrxaWzO0dPzQem9veKEb2R+8Qp
 0kg2HWC69oJn2I0z3riVpKaheIK2er/Oq/STQAocY0cd9AgOycFwjK6dLGA==
X-Gm-Gg: AYBFou1c54D4OsVaHmgiZXUZ4D0Wsv7OJVYwK6AnoE5JSAOQvfSmV5z+x1qTt6Yb1Tl
 CsQYjvxiouQKPlq+ARoimD0D6AZbBwzqvrQiiDvkwxQZSLuasCzIZfyajV6jkUy0yKqtjaYwlVv
 n029h+6Lx8K1fZG4ur7RYD+IX/HsKX+QFIeW0qNHW12rbYWaObk4jAWxS4/wuKA1OK2dl61x/DV
 6fVwFXWXB1WRssThSz52/t3V5FX5A3CVd7IiH0vURFO5up1H2j3qJcuY2rTGYKNe06wC+idwKka
 qZ0/8FVoWmE+n3aab8EP9V6qPhcAAjaD1G4Ty7MNop6a4MvGsMt4cGx5HfjNk2FCczRB7ulejd1
 hTd2gFtuUofjDurpCrxPTzdtzSON1GVTJcfaK
X-Received: by 2002:a05:620a:284e:b0:93e:5e2c:8bf2 with SMTP id
 af79cd13be357-93f6f91e7damr492764785a.21.1792780798830; 
 Fri, 23 Oct 2026 11:39:58 -0700 (PDT)
X-Received: by 2002:a05:620a:284e:b0:93e:5e2c:8bf2 with SMTP id
 af79cd13be357-93f6f91e7damr492761185a.21.1792780798339; 
 Fri, 23 Oct 2026 11:39:58 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9402ee282bcsm87003885a.4.2026.10.23.11.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 11:39:57 -0700 (PDT)
Message-ID: <569240ae-b9b4-4318-b588-97585e0fe015@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:39:54 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/riscv: Add SBI STA state to vmstate
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
 <20261022022535.437892-4-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022022535.437892-4-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3MyBTYWx0ZWRfX6Z2TQWQF/6k2
 4S7lakkMeF2KShnhHJnZ2xQ0BTqvXaoo4fEB8xzsxG6e+g/hOIKkgeTIf1MlKg7ve/6p6iSVWPQ
 E7m5reAkBKWfdtUdoVls0j6M1qURCbjGsKhPlxICGwktl8zqTY/MgAQ7RMr/tRvI/uQJ+BCXCCf
 be/3RL8Tf/kr0ni1pbqdHMzu59ZoWLBI9DLkgUjjr8c7sc0cRkDYyCIcMw3OdPP72KB6tAGWKNG
 tVSQFP8eH3MGA72z9HxDAUuUrJGchjSAUJ4dhR1Ixop3q877Kn/qcGb98TUq/eqk2zHF03Ee54k
 ETp27UkB99ZGYXa3qMVbnB6AKDGvCL6x71LzNCqG/9Guw5Fll+2T30A5UupHvVZF8keGavLYiGG
 YS709GQJzltuXYTQiULXX73+XjjrOTKuC71GHrj9lIvM4WU0YnDWLYpcJ0twe2r9FH/UixFjI+V
 kwSy+TL/YdZchOv+/6w==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adba9ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=mOLHsHEe2ig5fxC5vxcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3MyBTYWx0ZWRfX9RaUZT63y0ou
 yf/aSPLvztoRDiXJ0tVhwKaccVkNJLyoAUD6rhuRZQzqr58EdPo3mmSo7zw/B4kzkYn1A2mMRJQ
 e574qOb2IMbOn4PdW+Fg0o2r0PzZX7c=
X-Proofpoint-ORIG-GUID: canDuvT7uQhQ-6wcl9OWq-IHy2_ct-Zb
X-Proofpoint-GUID: canDuvT7uQhQ-6wcl9OWq-IHy2_ct-Zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230073
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/2026 11:25 PM, Wang Yechao wrote:
> Save and restore the KVM SBI state as a vmstate subsection, so that
> a guest using SBI STA keeps working after live migration. Only the
> STA shmem address (shmem_lo and shmem_hi) is saved for now; other
> SBI state can be appended to kvm_sbi_state as it is added.
> 
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c   |  5 +++++
>   target/riscv/kvm/kvm_riscv.h |  1 +
>   target/riscv/machine.c       | 18 ++++++++++++++++++
>   3 files changed, 24 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index ba5ba63854..0586e290dd 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1015,6 +1015,11 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>       return ret;
>   }
>   
> +bool kvm_riscv_has_sbi_sta_state(void)
> +{
> +     return kvm_sbi_sta.supported;
> +}
> +
>   static int kvm_riscv_get_regs_sbi_sta(CPUState *cs)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index aef681f0a2..5e17bacad1 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -35,6 +35,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t guest_num);
>   void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>   bool kvm_riscv_has_mp_state(void);
> +bool kvm_riscv_has_sbi_sta_state(void);
>   int kvm_riscv_check_timer_frequency(RISCVCPU *cpu);
>   void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>   uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0de06e9588..9fc699a482 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -318,6 +318,23 @@ static const VMStateDescription vmstate_kvm_mp_state = {
>           VMSTATE_END_OF_LIST()
>       }
>   };
> +
> +static bool kvm_sbi_state_needed(void *opaque)
> +{
> +    return kvm_enabled() && kvm_riscv_has_sbi_sta_state();
> +}
> +
> +static const VMStateDescription vmstate_kvm_sbi_state = {
> +    .name = "cpu/kvm-sbi-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_sbi_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_lo, RISCVCPU),
> +        VMSTATE_UINT64(env.kvm_sbi_sta.shmem_hi, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
>   #endif
>   
>   static bool debug_needed(void *opaque)
> @@ -645,6 +662,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_kvm_timer_frequency,
>           &vmstate_kvmtimer,
>           &vmstate_kvm_mp_state,
> +        &vmstate_kvm_sbi_state,
>   #endif
>           &vmstate_envcfg,
>           &vmstate_debug,


