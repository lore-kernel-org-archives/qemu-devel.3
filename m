Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44268CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZY9o-0002x0-8l; Tue, 16 Jun 2026 14:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZY9m-0002wm-MJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:05:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZY9k-0006ZH-8Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:05:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH8x2U1210400
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UL5mhEPD3YA44YAlvCn907khtWrS45vl5LdOiDWFwfA=; b=Y43jleiI7VoObe9n
 vlTVDBGt9Rh1V+FHARPW0EMultEDkNOKF+MtZkJUDMwLVT9CJzQV8jIf7CXut8VL
 tqZDEGX2QvzHvGd5zmtfAlwHJY0Cpu0cWK5inVmhNZX+IrkQPWnFkNokhZM+WPkb
 tlM+PnkD5lBGlPn+pF89SmsJgzfrEO8TsC1CuP0l4KarUV9t8Tq4dPfDw3WkGn8b
 YnfbPPwIxdMNVMClt+YnTwSNQc7QnyS74KheO2X91Hzv6DRdxMcbLIOMKmgLwWCV
 h0x8iAd++rBHDW5cneGz8By4tKABEd9z4uogTLTbXx46T3vgF57O3qRzR9XR559M
 pwfDew==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu2xsaqrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:04:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91931144870so626300485a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781633096; x=1782237896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UL5mhEPD3YA44YAlvCn907khtWrS45vl5LdOiDWFwfA=;
 b=F0SfxVSn4dGNPtmPIRcLIwJXS1wyDnL9kDEqJb6Y/whGw8QDs4sBOHpJatOp12yZ5S
 6saLTBZPBtwhM4TQlXFTQWcVxaOR+cm2aH2FAoigKn76nNl0tuTMfzbyUZvswdFRgQqC
 diDB5rq1oub8rt/zlFu69s2jThQMhAQRF6MUmKqCzNKxcK9cEk/1W5F0rPGYquo5fVou
 JpbBV+Pn2u1m42g909yKy8EvSNVkQpw/F0tp8Qq2CvRFUVS72cc4Dgyqsczgfdu40KIf
 gvGKeXCDQ0ewrUUIQbljolwC+BQTmBxLb25+/BwmpiqNO1sq9WQgXdLFDZR8h5TYpjFg
 uXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781633096; x=1782237896;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UL5mhEPD3YA44YAlvCn907khtWrS45vl5LdOiDWFwfA=;
 b=ma+WSk4YCBMQP8zXWUpTH7w96xQMk8jAcoNIdmQMANJLaMEgkslL4xO/G/IS7MHsjW
 Dk2m5PKFyG7YwHxfBDkz9Lezag3rno5GF9388pde3jd0miqUhmqc4NoufHBh8gCEoQFo
 mXXHIt1n2CWgIVY3JUGueQV9g9nnmBhB5IeSrspoEGymgZvh/HIt87zR/h0vIM56zUzz
 5ffW2YusQplGwtGaxx17HWpoVRBdpgg56/vUmD0C7c+Py9xz/ovbKYnfBO1P6TGFgWOs
 BDn/YWEM5iYD2cctNYa6FRRb4ZWlJwha83Q6ao4AedFZQpWsjP6e5vRTYADNtU4FNuti
 I41w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hYKw5g9sQPTTRjrY3+Ye86zBkwgqkxQjro1DMK0SdYFM4xghFS/VuLYTMSDRcqrZRXIN57hLDdLsm@nongnu.org
X-Gm-Message-State: AOJu0YwbSPdzDDGSinahSCabmInjgHXGi3nRyt0Ovuw644jScPb+To/u
 3NkRk3BPaUO3bOAq8sRVidhfuDGxYFXZXNueFqgN/FCxTGIO72HJEUvnuCTqsWacDnztl8q7EIz
 r/TIVuPTPTN9Bd9f3mUKv5QU8dVNtRyrIriQPqdco8ilt91SD6Lc+pF8jUg==
X-Gm-Gg: Acq92OEMlRAqD4oXhjqvEl5K+AMrJwjYgPyeolfZ73ZDhztX3pW2wE/Zp0aPpCDiqh7
 Xl5Fp3CN1ov8YY6k9LYDhQAZsaZHHMyM5VsSspXSnXuhpGdfKYLqmUv/MZ8ZhSVpkq0HeKld2pf
 0oMQ1NWo+5ITmVlbwFYrx+HHgwZ0a0oY+hrF/y3zivkvYdXCDDROVzjc3NZonIzSmGxW65eVLVn
 ZWNAcGc2NVRfHFJPBKsZ33aVxhSmPd0Lg+54LLqKUwpLkzda8ses7v3sW5tWhAYrv38Y5BCEq4G
 DUyrOPWu3EdcFf71S2HuI3TmXoxc14j8JFOPz2S4QvHnkTCPr3MCexcrMUDVo3DAgcZMQUYsrUY
 V2eqTB6eINnQ4F8IhpqOw/e3LhUfNLPLQ7PsKAJU54AeDB0kOOaSGLWcaMw==
X-Received: by 2002:a05:620a:371a:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-91d8d3a9a27mr131470585a.38.1781633096393; 
 Tue, 16 Jun 2026 11:04:56 -0700 (PDT)
X-Received: by 2002:a05:620a:371a:b0:914:7e9a:2716 with SMTP id
 af79cd13be357-91d8d3a9a27mr131464485a.38.1781633095770; 
 Tue, 16 Jun 2026 11:04:55 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a04f5b7sm1533213585a.38.2026.06.16.11.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:04:54 -0700 (PDT)
Message-ID: <9c47ffd1-e90b-41a1-903f-019d0c78e4c1@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 15:04:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] target/riscv: add riscv-server-ref CPU
To: Matheus Ferst <matheus.ferst@eldorado.org.br>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-3-daniel.barboza@oss.qualcomm.com>
 <fae30540-54df-42c1-bd2e-1c832f69f75b@eldorado.org.br>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fae30540-54df-42c1-bd2e-1c832f69f75b@eldorado.org.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9jySmpZvH85e1KywSHZOUd03dTpVgjrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4NSBTYWx0ZWRfX95Kxrx+1U3Ap
 SgCKoB1QOGqMZPz0mgUQgflOCaRRKelA3VFPkfnxuuW9GOjCWBRIlgmOsOPb7p8f2HrbtTMXfxo
 KVEJ6/U2Ap1M98rteu29uOffGzwyPVmQjont3YZ3k9/fhbgs12EYzsnKQPlG2aF0CVm7d8fNJhV
 RJXG8Cc0+JbeSrXzt2kQNHek+RcCKSofQt9wRCfbvZeopsrqgzqv7RQnCZ45qq5LnYhJZhdjRVY
 oD0X8zxWoFhxxsbrVpoByeFjNPaHuIaKCt4Jok5zIS0T+Wt/nwMrHo1MneZ3Ceh1WKpd0jq1OPe
 23C3lGCXTYN7n9Q9gOEdPd7d9ohqqW1iqu3s+TxgBjxwsE9yQaU1VJsQ1MC38OY8RFGwQi+90jv
 Y7WO2Jj2UZJqqHBagnn5LPB/zW5mczZ3KpZckkf4purWSP/x/2xAOFhWWMUxGO+HFoiUNDVFtIo
 XN23pT+4IOXDNi/WM+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4NSBTYWx0ZWRfX1oJUqRy1dmXF
 daKbPH7JVBJ7gcXqxrZbLziOVTXG7KzvDMvblbAHegoubmFhgnV92ZVn4WBaRbHwkn7UGPrCPsA
 VjqyLVtQcQug+grtJUe1QyAovzMSX5w=
X-Authority-Analysis: v=2.4 cv=MdJcfZ/f c=1 sm=1 tr=0 ts=6a319049 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=PXcuKL70AAAA:8 a=RceVjk-67B5CBUFRr-MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=1qLaeP4TCVy2vqIEy19U:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 9jySmpZvH85e1KywSHZOUd03dTpVgjrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160185
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/16/2026 2:51 PM, Matheus Ferst wrote:
> Hi Daniel,
> 
> On 6/10/26 18:41, Daniel Henrique Barboza wrote:
>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>> profile support and others.
>>
>> We're going for a profile-based implementation, instead of a regular CPU
>> that can inherit RVA23, to allow future CPUs to use it internally as a
>> starting base for their own extension sets.  There's also a new
>> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
>> command line for other CPUs, which can be used for testing/debugging
>> purposes.
>>
>> Note that for all intents and purposes "riscv-server-ref" is a regular
>> CPU and no, we're not trying to set a precedent of calling the riscv
>> server platform spec a profile.
>>
>> [1] defines in rule SEE_020 that we must support at least 11 debug
>> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
>> one for int, one for excp).  We're going for the minimum.  If more
>> triggers are needed users can set any trigger amount with:
>>
>> -cpu riscv-server-ref,trigger-count=N
>>
>> Note that N must be <= 128.
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>
>> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 30dcdcfaae..a150acd151 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -42,6 +42,7 @@
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>>   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>>   #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index e02d53cbba..63fbc4b98e 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2063,11 +2063,35 @@ static RISCVCPUProfile RVA23S64 = {
>>       }
>>   };
>> +/*
>> + * The riscv-server-ref spec isn't a profile per se but its
>> + * CPU definition can be modelled as a profile that extends
>> + * RVA23, with additional things on top of it, and allowing
>> + * future CPUs to derive from it via
>> + * ".profile = &RVServerRef1_0;".
>> + */
>> +static RISCVCPUProfile RVServerRef1_0 = {
>> +    .s_parent = &RVA22S64,
> 
> I guess it should be &RVA23S64 instead of &RVA22S64.
> 
> Other than that,
> 
> Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>

Good catch!  This was weird ... my lame excuse here is that I got this
fixed in my branch before sending and forgot to re-generate the patches :D


It's fixed in v9 now.  Thanks!


Daniel

> 
>> +    .name = "rvserver-ref-1.0",
>> +    .satp_mode = VM_1_10_SV48,
>> +    .ext_offsets = {
>> +        CPU_CFG_OFFSET(ext_zkr),
>> +        CPU_CFG_OFFSET(ext_sdtrig),
>> +        CPU_CFG_OFFSET(ext_ssaia),
>> +        CPU_CFG_OFFSET(ext_ssccfg),
>> +        /* ssstrict is always enabled for PRIV_VER_1_12 */
>> +
>> +        RISCV_PROFILE_EXT_LIST_END
>> +    }
>> +};
>> +
>> +
>>   RISCVCPUProfile *riscv_profiles[] = {
>>       &RVA22U64,
>>       &RVA22S64,
>>       &RVA23U64,
>>       &RVA23S64,
>> +    &RVServerRef1_0,
>>       NULL,
>>   };
>> @@ -3326,6 +3350,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>   #endif
>>       ),
>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
>> +        .profile = &RVServerRef1_0,
>> +        .misa_mxl_max = MXL_RV64,
>> +        .cfg.max_satp_mode = VM_1_10_SV57,
>> +        .num_triggers = 11,
>> +    ),
>> +
>>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>>           .cfg.max_satp_mode = VM_1_10_SV57,
> 


