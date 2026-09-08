Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C725AC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x40kW-0007Hl-Rw; Tue, 08 Sep 2026 14:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x40kU-0007H9-IW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 14:40:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x40kS-0003Kd-C0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 14:40:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688IBiEt3955680
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 18:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rOFeW8sZrlHkgD0kRE0EvFxGh0kAAQhw1GwD4MKuFx8=; b=lLt9hpKQWTXwDU5v
 ExcTwboKMC7Mhh4GEyYsrD84VEalHKYMsBxVIeKv5JJT+x7ixMdLYJoZY9i9UqDJ
 FvrhhQIif/GQeAQzvoQWfLgCZ6ZnnZ16o4aa2TUA/5QaRcfREBVCXRv41K+jjwll
 ZBjpr4LB0eznSLUAMIFUi/r/g0NS9gLIcTwwfAEgaMUKOrqzVb7JppNW0HFndmdx
 tU1EAjgZQz67abGv1hF/fp85L4BNnqsPfjHnjO1/fg1JrAoyfQp3G/kd8osFof1P
 +qyBS8T41X22x0zqSXf2WzHZ6KH1ECOCz1M4eCUoAKMCbvHIyMjHp6SEgiavC4/v
 BKoJ9A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqe7g3yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 18:40:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso83234536d6.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788892846; x=1789497646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rOFeW8sZrlHkgD0kRE0EvFxGh0kAAQhw1GwD4MKuFx8=;
 b=jVGwRNfUemN2uSTy/SivU9T4yMILtfZszt4RdAvrEN1kpZye0OP3G3gUS4WsIh9tHa
 caprUIIeDNXAHZs1clL560w5szt+CLQMm5V7h1QhCWzL+3DQyO1/kvFX85v82+oIDFd3
 fWpkUkDLFTEPJW6FaXCu+DIt6Hfa/kV6i/pWER+b4U+HzcnGeK1fDuEMNV7fZI0Lo8/K
 5JALH8wsaPQCxI91my/vbeeVI0pcgKmJxNSdJagTn70L22QRyceyApXStXGhYlgSZlgM
 rkm87kR5gt+mYn3TIy0aCjmzCt5TVNT+nOcybXGoCBwACXoI60km435hnPj3LkkTaMCj
 abdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788892846; x=1789497646;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rOFeW8sZrlHkgD0kRE0EvFxGh0kAAQhw1GwD4MKuFx8=;
 b=smGodGn1DJ0y6KF/d4GSewDlvKYxBco6Rs0xFM7snldyA7vnNHJsQQF1/QVkvhz6OC
 f/DRrc1B/1pNs1jM8hA5nLuroJcwFMIJUE55tKuxs68H388T+6I1VuDMpU1EjdvbAYrh
 PsgV9E8DV0Iiz18Ps+GgfoUToK24EYAX2G9rYJJ5fINz+6Jqftctb0uy+Zk5Wt66G7wU
 sm63gIJ+Sb7yXfedFVL0X1tiIjXQb+YZdMPH9lroRBtjjsTkXcnYRzB2pobrOWNXZP3j
 kzZ16veO+x3NxNxJ/jzKag/uwSCoC3BjsxJaARXXthizvvXRqcHGkH2+1xq03juh6cvP
 qq7Q==
X-Gm-Message-State: AFuF++lRpq3nggZDBG3zlfJ8v+crYgQDtcA6njhjjv9dRYJnkORNFgU5
 cZMkx4oHtt9LyjKjPlirwCfJY8AGiu5NsHPiFDovEArCF3PumCE9Kg2U5ZxGiUyz65+rIWpN+FT
 9VXmoGQb45qvA6IYWYbiMqYy29Q1un/lV0ZXjP3b/hwviIMBgLxkkBz4RQA==
X-Gm-Gg: AYBFou1xwR4gNYWpdVFNsCKW7LkcjXMN87InIpNxEl+QDxS2vk7UAMcEHkpA48f80QW
 465TSp8fP4ymgEkVa0kF3/FOHlaurLcSjBxrXrZFBECqp4aCh3tgUHzWWix0YiiY6Jtt7b2xY5N
 nYp5aqIZDVG/AQbRAZcmqn+sRBPenRdVSzRBvwZlv2l88A8iixbFVH1fz+iQ75sQlHET8jewQjK
 iBJ7dqrG8/FDsnrI9PVzwFSvlCVxahHBbT3sq+dyCskLb2QApAAA+oTv4ShEPdn0Zg0xzUzlwpN
 99ctzRSBz6Xxr81hbDXIZPnYL1bUmL1UTZGf8tUhTZ4+7dqzu3o2NALrs3q7nH2MIF5hGUR+3xD
 Occ9YwX0G3WQlYPlmiNF4v2kPmTegL1xsL3M=
X-Received: by 2002:a05:6214:1313:b0:90e:e1c6:7542 with SMTP id
 6a1803df08f44-9106b40754dmr24365146d6.22.1788892845777; 
 Tue, 08 Sep 2026 11:40:45 -0700 (PDT)
X-Received: by 2002:a05:6214:1313:b0:90e:e1c6:7542 with SMTP id
 6a1803df08f44-9106b40754dmr24364046d6.22.1788892845250; 
 Tue, 08 Sep 2026 11:40:45 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9104067b099sm124099476d6.28.2026.09.08.11.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 11:40:44 -0700 (PDT)
Message-ID: <8b5b9cc2-fa84-4237-b24e-cdd327cda2e0@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:40:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] target/riscv: add riscv-server-ref CPU
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Icenowy Zheng <uwu@icenowy.me>, Matheus Ferst
 <matheus.ferst@eldorado.org.br>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-3-daniel.barboza@oss.qualcomm.com>
 <qe5iku7uldi7ok4tnfmph64mns62uz26vgbokn657rajjblfzr@k4tyenhmhuwb>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <qe5iku7uldi7ok4tnfmph64mns62uz26vgbokn657rajjblfzr@k4tyenhmhuwb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwMSBTYWx0ZWRfX4zcmPYDX0Bp9
 WaGBYO3U6Xx1kPYK5vHGStNevbjKhFQgO7USBomzjICtOmMRzr+gKc27Hqo48Rm+4k+I+1LSZug
 QxnHegP1MdumZ8bW6QMV0WtNc8C2iKk=
X-Proofpoint-ORIG-GUID: o9vXCTuAg8Xa1AjCommOwup2FUY_UwpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwMSBTYWx0ZWRfX5B9mQpPcffut
 VkvXMJXTdl/ea7kNunF/fWxd7ZuhN9DHVSgBMBBOWnUWG/zeLzcps2WH/Bu2jGqT+1/6JfL9LRN
 E1QMxYU5y2S48pfRCVlJ+N1zNjanzLlW5POvOMabqmRgZ69Kh5nhL6MLlxpvZ5ZD7CGsdC/Z6bE
 CFpKCGeKmi8HlTfO6JC0wBWDpJ7Gai/8yHz9jHSBFTMJ6OMveLrkTvaNHbTe7T7JLy3aeRnt8vQ
 TgEf7JMK1sDy3TzvcAIc6SwEkgHGYLdeHEm9XNDQFVZi7Dv07kO9BhAw3jAdDxJToeMutzPuC6a
 6Y9SIlFNofiNc1sCquDPanbB6/eE13EJYOjKhWPy3Do2DlrkgWHPc49Ac8m6zgtvjhUU4N6EdwH
 whjJhCn0IogpJj6OdzkGHSQZMhBfHWpYvP9sn7BKs8Mb/a8/6ByRZCIgh9Nr2TyC78Zh+TuBz6b
 fYTbtclS78NCfoCagvA==
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6aa056ae cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8
 a=FRSEYCzRAAAA:8 a=pTs-M1waXw2_HFRbnroA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: o9vXCTuAg8Xa1AjCommOwup2FUY_UwpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080201
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



On 9/8/2026 6:08 AM, Andrew Jones wrote:
> On Fri, Sep 04, 2026 at 04:56:07PM -0300, Daniel Henrique Barboza wrote:
>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>> profile support and others.
>>
>> We're going for a profile-based implementation, instead of a regular CPU
>> that can inherit RVA23, to allow future CPUs to use it internally as a
>> starting base for their own extension sets.  There's also a new
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
>> one for int, one for excp).  We're going for the minimum.  If more
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
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
>> Reviewed-by: Chao Liu <chao.liu@processmission.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 1a28f1369c..61234842e3 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -42,6 +42,7 @@
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>>   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>>   #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 185474a8cf..b5a75fbc1c 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2417,11 +2417,35 @@ static RISCVCPUProfile RVA23S64 = {
>>       }
>>   };
>>   
>> +/*
>> + * The riscv-server-ref spec isn't a profile per se but its
> 
> spec?

I'll replace this comment with:

"This riscv-server-ref entry isn't a profile per se but ..."

> 
>> + * CPU definition can be modelled as a profile that extends
>> + * RVA23, with additional things on top of it, and allowing
>> + * future CPUs to derive from it via
>> + * ".profile = &RVServerRef1_0;".
>> + */
>> +static RISCVCPUProfile RVServerRef1_0 = {
>> +    .s_parent = &RVA23S64,
>> +    .name = "rvserver-ref-1.0",
> 
> The commit message and comment call this "riscv-server-ref"

The CPU is called riscv-server-ref:

#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")


"rvserver-ref-1.0" is the CPU profile name I came up with as a placeholder.  I
believe we can rename it to  "riscv-server-ref-1.0" to avoid confusion.


> 
>> +    .satp_mode = VM_1_10_SV48,
>> +    .ext_offsets = {
>> +        CPU_CFG_OFFSET(ext_zkr),
>> +        CPU_CFG_OFFSET(ext_sdtrig),
>> +        CPU_CFG_OFFSET(ext_ssaia),
>> +        CPU_CFG_OFFSET(ext_ssccfg),
> 
> The cover letter says that the sdext patches need to be merged first.
> Don't we need to configure it here?

Yeah ... we had a very earlier version where enabling sdtrig implied enabling sdext.
That's not the case for some time now and forgot to manually add 'sdext' here.

I'll do that.  Thanks,
Daniel

> 
>> +        /* ssstrict is always enabled for PRIV_VER_1_12 */
>> +
>> +        RISCV_PROFILE_EXT_LIST_END
>> +    }
>> +};
>> +
>> +
>>   RISCVCPUProfile *riscv_profiles[] = {
>>       &RVA22U64,
>>       &RVA22S64,
>>       &RVA23U64,
>>       &RVA23S64,
>> +    &RVServerRef1_0,
>>       NULL,
>>   };
>>   
>> @@ -3759,6 +3783,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>   #endif
>>       ),
>>   
>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
>> +        .profile = &RVServerRef1_0,
>> +        .misa_mxl_max = MXL_RV64,
>> +        .cfg.max_satp_mode = VM_1_10_SV57,
>> +        .num_triggers = 11,
>> +    ),
>> +
>>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>>           .cfg.max_satp_mode = VM_1_10_SV57,
>> -- 
>> 2.43.0
>>
> 
> Thanks,
> drew


