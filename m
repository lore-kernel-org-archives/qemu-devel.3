Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A444C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WE0-00039T-Iy; Mon, 07 Sep 2026 06:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3WDz-00038f-95
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:05:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3WDw-0007s9-EL
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:05:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6879g0Pl2502883
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 10:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3K2i4GH86TLL24kggVR95cChnQkN7yywKo44YwnpuZs=; b=iVUdW5bcRMnsLBkm
 TWwSImwXP/sWM8oQPgONrcqWJTkewI6+SczZpNGqZ7WCrGNVjqCyCeMFM15nrMVM
 06j72iilqENyEqntZF9nCSUxH1oiN2mf6CiyMCHIw0AEFFlKd7nMXSh5KAGqMCtB
 YSHI/JCMQwa7RDithbYDR5neN4hNSCU5Mmbgyb0XbzNmR/qxeH0lcqj+Lt+bJpJI
 zPD4y6wYtISOEPSCXGvfKxZwHJpEseq+jdTtvENOIG+ohfmxvgDVBES1cInuY8SZ
 VQKCi7PDj3QFPFaXdQA81GQJrxHNZL8jA2upSXPzxNtbSCD4sl14Hk6AWT0KYaH1
 kys5og==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty03wk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 10:05:08 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7f4e9fe8b17so3967601a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788775507; x=1789380307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3K2i4GH86TLL24kggVR95cChnQkN7yywKo44YwnpuZs=;
 b=J1dtz+KujgcVjl+KKrhpMQjkRvXNXtbMEr6lGVy7aUMJJ7pyjve2CsW5AG+1sKuIq6
 oSgUTk6hdAS/GZFuHJUljHuJDssLV51YsmfJN5aJ1kCQ7TCW4hC2Xg5SBHQn+ynCpCJ+
 PtODX87zdq0mv8gfZ/yTc34gpW/fGsnyFrfGT9yXAwQGVQAyOArOugo4TNsbhlXp9/z4
 Ms9DezUHouc2AP13eg18prS9my/Z38kVp0ilNXP6ptkbZSxm2hvtQ1WjcjEgN5h8Ejju
 yZ3eGlsf9LkWeGnoHGM2Oifo5HBEJwJv6IeE0jg9In1ueJ9HVYK4MbXrJNqB6kiTAGTs
 UuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788775507; x=1789380307;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3K2i4GH86TLL24kggVR95cChnQkN7yywKo44YwnpuZs=;
 b=CsPiCPHjlLG81Y2mznVO6K8osz2If++Pq4nTpbtPCFWoCFCBOOX03ngZ+A0TXhrMlS
 CIOoSiZ7qllkOr7QlLxipUJ1o+lzujx5bVD07bTNm/ncEghGZQAFdOXiOEIXwYfjEmIn
 6AuW77tIiWf3Cwnt7LfTG7rNbOc2aN7AACsusEE+NpEhQol1yG50qInS5gz88LIxmmh1
 8+XWwZO4/iECE3SuqTAxEgYlhoF/jBTKXbWpcVC7ghrCS8yk3Y2ALp73KvjJ05amOkb3
 PpwMpaujLWd+s8XLD4lZa7VmxPfIsZ9PAO8xnQLAxgqPQzqz3FIQ4i9uSgvQDgoyPwho
 B84g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7dyopIYSs2M5wW7AywI7A3Xw6qc121LQg8ZJLTrmLGI24R5X7dVi97O6IMjka5f45fBqcjwL+uhDP@nongnu.org
X-Gm-Message-State: AFuF++lSs0A7nyS4tKjg0bjTBRAtroRFVKjQG2v23sUHqxDgDEd++2aJ
 J0XKDCAz7KccfIbZDKCPofnYqe0JrN0ooeS2kSWM3g6L4Q+ngMyCSOSpde3JIIpLM9BqRwIq6Xn
 U+MRP3ijaKYxud826C5aryfCTEHo8nfs8eDr53kxiQjWQY7Y91o1mcN2A9w==
X-Gm-Gg: AYBFou2vJarVDa851RcyNah+9mlmMP/YNVIRWhRVRUlY2tYidtd7oxnZw42qwBsaimL
 ZI3MAFyZKhZ+SBiEWSrpFXPeQvwToROb7IqlMjKUZqxFZRA+Jxvfqp4r9CUGHPuxRsm/N7d8DZH
 uDQ1jh5lG5iAFGoLnq76LSjOulC1Pr8/KwbsXjZjf1dHiZWfR3yPce1ZpyvolQBrB0/i5Rj2BYt
 uyjWBZEqHGAK2Zdbs3P1S0hokSzcxvI4UprG0XRvwLX/tWEkKtwEBEQxxHafBxj+yTW2HhkM3MN
 F6JcBMRwf2AGFODpM0XAA/7WOnwqckE3hVS28tF5zoV6s4spVM/eNzSKBtYC3VuTZPZp41dsNUh
 9rt1refl/S7jv4JqnoKTBvMgMLzE5WJGcWfY=
X-Received: by 2002:a05:6830:83b7:b0:7f4:bd7e:1394 with SMTP id
 46e09a7af769-7fa1e1b786bmr15928464a34.1.1788775507339; 
 Mon, 07 Sep 2026 03:05:07 -0700 (PDT)
X-Received: by 2002:a05:6830:83b7:b0:7f4:bd7e:1394 with SMTP id
 46e09a7af769-7fa1e1b786bmr15928431a34.1.1788775506856; 
 Mon, 07 Sep 2026 03:05:06 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7fcef193dc2sm4846573a34.19.2026.09.07.03.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 03:05:06 -0700 (PDT)
Message-ID: <d266c4a4-372a-4a96-bd7e-f9f8cece7e94@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 07:05:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] target/riscv: add sdext debug CSRs state
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "tangtao1634@phytium.com.cn" <tangtao1634@phytium.com.cn>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
 <20260831141007.353854-2-daniel.barboza@oss.qualcomm.com>
 <663b12c47712248b50206dd8c8b5add6812cf91a.camel@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <663b12c47712248b50206dd8c8b5add6812cf91a.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9e8c54 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xvfqbYfxAAAA:20 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8
 a=pbq2bq-YRYBN5HSKhH4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: j2Lt5vGVIeEbHCwXaQGFE_V10NN7Vl-K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMCBTYWx0ZWRfX2iASy89uOVZ0
 M9wLMiBkdOMoeDAM/Up4aaI6/uT4tK5ZIuOMLfXTDeDkTPSmAe7noouz2qqf+wLDjhyRc9tncTJ
 GE51VHrx2n3f2rfIbB3JbWoS+GHSPik=
X-Proofpoint-GUID: j2Lt5vGVIeEbHCwXaQGFE_V10NN7Vl-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMCBTYWx0ZWRfX28qorcyZaai7
 ywWO+x9EOM+Bvr2vA1pC062Vm/BaCdmepb85Rv7MYNyawIIMOBcvDxmBwY5S2Dcfr0XPXY/rGur
 nAhgPbITyrGv7SEqFunv0gzOYg3lCev+vR9REkw2CHXrrZDwrQltreFK/puXdpAhrB6WqVfod9f
 5MUeSZ58hvbzOwZ48lv2G8i3W6/8oGj9oyhAnZ4ppPFWqbgwkYoEMQlkS4nX0TfAvqmef7zrLMK
 kj8P5ocjy4FGTekswDdjZQapHepmZumBGW9N5gx7fXaWvxeO40D8jOcSqWk/JkR1EpcVclrDnj6
 FUndssu6/w30oJX4wGFNp1wRgYIQsVokmeO5Wz6aK6S3dWAomWFx+qnxh45j02KPZe2ZSuSjzX1
 Itx3IIFjTh/2fuo4tQCBgdEBdISe+C8giYINXZhL7lTG5oy5kzq97hcE31JHdjtlOtiXDACu/UM
 a4lFI8jvVS+PMYZxzlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070110
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



On 9/7/2026 1:39 AM, Alistair Francis wrote:
> On Mon, 2026-08-31 at 11:10 -0300, Daniel Henrique Barboza wrote:
>> From: Chao Liu <chao.liu.zevorn@gmail.com>
>>
>> RISC-V Debug Specification:
>> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
>>
>> Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
>> and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
>> them to Debug Mode (or host debugger access).
>>
>> The Sdext is not fully implemented, so it is disabled by default.
>>
>> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> Reviewed-by: Daniel Henrique Barboza
>> <daniel.barboza@oss.qualcomm.com>
>> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> 
> You are missing your Signed-off-by line here (and on the other
> patches).

Ops. I'll re-send it with my s-o-b on patches 1-6.


Thanks,
Daniel

> 
>> ---
>>   target/riscv/cpu.c                |   7 ++
>>   target/riscv/cpu.h                |   4 +
>>   target/riscv/cpu_bits.h           |  33 ++++++++
>>   target/riscv/cpu_cfg_fields.h.inc |   1 +
>>   target/riscv/machine.c            |  20 +++++
>>   target/riscv/tcg/csr.c            | 126
>> ++++++++++++++++++++++++++++++
>>   6 files changed, 191 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 61109672d6..c2078473aa 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
>>       ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>       ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
>>                                   has_priv_1_12),
>> @@ -1091,6 +1092,12 @@ static void riscv_cpu_reset_hold(Object *obj,
>> ResetType type)
>>   
>>   #ifndef CONFIG_USER_ONLY
>>   #ifdef CONFIG_TCG
>> +    env->debug_mode = false;
>> +    env->dcsr = DCSR_DEBUGVER(4);
>> +    env->dpc = 0;
>> +    env->dscratch[0] = 0;
>> +    env->dscratch[1] = 0;
>> +
>>       if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_reset_hold(env);
>>       }
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 718b66487a..74bddc8415 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -507,6 +507,10 @@ struct CPUArchState {
>>   
>>       /* True if in debugger mode.  */
>>       bool debugger;
>> +    bool debug_mode;
>> +    target_ulong dcsr;
>> +    target_ulong dpc;
>> +    target_ulong dscratch[2];
>>   
>>       uint64_t mstateen[SMSTATEEN_MAX_COUNT];
>>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index c01050ce2b..769c945517 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -467,6 +467,39 @@
>>   #define CSR_DCSR            0x7b0
>>   #define CSR_DPC             0x7b1
>>   #define CSR_DSCRATCH        0x7b2
>> +#define CSR_DSCRATCH1       0x7b3
>> +
>> +/* DCSR fields */
>> +#define DCSR_XDEBUGVER_SHIFT    28
>> +#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
>> +#define DCSR_DEBUGVER(val)      ((target_ulong)(val) <<
>> DCSR_XDEBUGVER_SHIFT)
>> +#define DCSR_EXTCAUSE_SHIFT     24
>> +#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
>> +#define DCSR_CETRIG             BIT(19)
>> +#define DCSR_PELP               BIT(18)
>> +#define DCSR_EBREAKVS           BIT(17)
>> +#define DCSR_EBREAKVU           BIT(16)
>> +#define DCSR_EBREAKM            BIT(15)
>> +#define DCSR_EBREAKS            BIT(13)
>> +#define DCSR_EBREAKU            BIT(12)
>> +#define DCSR_STEPIE             BIT(11)
>> +#define DCSR_STOPCOUNT          BIT(10)
>> +#define DCSR_STOPTIME           BIT(9)
>> +#define DCSR_CAUSE_SHIFT        6
>> +#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
>> +#define DCSR_V                  BIT(5)
>> +#define DCSR_MPRVEN             BIT(4)
>> +#define DCSR_NMIP               BIT(3)
>> +#define DCSR_STEP               BIT(2)
>> +#define DCSR_PRV_MASK           0x3u
>> +
>> +#define DCSR_CAUSE_EBREAK       1
>> +#define DCSR_CAUSE_TRIGGER      2
>> +#define DCSR_CAUSE_HALTREQ      3
>> +#define DCSR_CAUSE_STEP         4
>> +#define DCSR_CAUSE_RESET        5
>> +#define DCSR_CAUSE_GROUP        6
>> +#define DCSR_CAUSE_OTHER        7
>>   
>>   /* Performance Counters */
>>   #define CSR_MHPMCOUNTER3    0xb03
>> diff --git a/target/riscv/cpu_cfg_fields.h.inc
>> b/target/riscv/cpu_cfg_fields.h.inc
>> index f91c780299..24f3606f94 100644
>> --- a/target/riscv/cpu_cfg_fields.h.inc
>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>> @@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
>>   BOOL_FIELD(ext_zvfbfwma)
>>   BOOL_FIELD(ext_zvfh)
>>   BOOL_FIELD(ext_zvfhmin)
>> +BOOL_FIELD(ext_sdext)
>>   BOOL_FIELD(ext_sdtrig)
>>   BOOL_FIELD(ext_smaia)
>>   BOOL_FIELD(ext_ssaia)
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index 74edb8c2b5..aba162d0f1 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -302,6 +302,25 @@ static const VMStateDescription vmstate_debug =
>> {
>>           VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
>>                                 env.num_triggers, 0,
>>                                 vmstate_info_uint64, uint64_t),
>> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_sdext = {
>> +    .name = "cpu/sdext",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = debug_needed,
>> +    .post_load = debug_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> @@ -577,6 +596,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           &vmstate_ctr,
>>           &vmstate_sstc,
>>           &vmstate_mseccfg,
>> +        &vmstate_sdext,
>>           NULL
>>       }
>>   };
>> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
>> index bd4b6dc114..988261cccf 100644
>> --- a/target/riscv/tcg/csr.c
>> +++ b/target/riscv/tcg/csr.c
>> @@ -3207,6 +3207,126 @@ static RISCVException
>> write_mtval(CPURISCVState *env, int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>>   
>> +#if !defined(CONFIG_USER_ONLY)
>> +static RISCVException sdext(CPURISCVState *env, int csrno)
>> +{
>> +    if (!riscv_cpu_cfg(env)->ext_sdext) {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +
>> +    if (!env->debug_mode && !env->debugger) {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static target_ulong dcsr_visible_mask(CPURISCVState *env)
>> +{
>> +    target_ulong mask = (target_ulong)-1;
> 
> This should be a 32-bit value, as the register is always 32-bit
> 
> Alistair
> 
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +
>> +    if (!riscv_has_ext(env, RVH)) {
>> +        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
>> +    }
>> +    if (!riscv_has_ext(env, RVS)) {
>> +        mask &= ~DCSR_EBREAKS;
>> +    }
>> +    if (!riscv_has_ext(env, RVU)) {
>> +        mask &= ~DCSR_EBREAKU;
>> +    }
>> +    if (!cpu->cfg.ext_zicfilp) {
>> +        mask &= ~DCSR_PELP;
>> +    }
>> +    if (!cpu->cfg.ext_smdbltrp) {
>> +        mask &= ~DCSR_CETRIG;
>> +    }
>> +
>> +    return mask;
>> +}
>> +
>> +static RISCVException read_dcsr(CPURISCVState *env, int csrno,
>> +                                target_ulong *val)
>> +{
>> +    *val = env->dcsr & dcsr_visible_mask(env);
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static target_ulong dcsr_writable_mask(CPURISCVState *env)
>> +{
>> +    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
>> +                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME
>> |
>> +                        DCSR_STEP | DCSR_PRV_MASK;
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +
>> +    mask |= DCSR_MPRVEN;
>> +
>> +    if (riscv_has_ext(env, RVH)) {
>> +        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
>> +    }
>> +    if (riscv_has_ext(env, RVS)) {
>> +        mask |= DCSR_EBREAKS;
>> +    }
>> +    if (riscv_has_ext(env, RVU)) {
>> +        mask |= DCSR_EBREAKU;
>> +    }
>> +    if (cpu->cfg.ext_zicfilp) {
>> +        mask |= DCSR_PELP;
>> +    }
>> +    if (cpu->cfg.ext_smdbltrp) {
>> +        mask |= DCSR_CETRIG;
>> +    }
>> +
>> +    return mask;
>> +}
>> +
>> +static RISCVException write_dcsr(CPURISCVState *env, int csrno,
>> +                                 target_ulong val, uintptr_t ra)
>> +{
>> +    target_ulong mask = dcsr_writable_mask(env);
>> +    target_ulong new_val = env->dcsr;
>> +
>> +    new_val &= ~mask;
>> +    new_val |= val & mask;
>> +    new_val &= ~DCSR_XDEBUGVER_MASK;
>> +    new_val |= DCSR_DEBUGVER(4);
>> +    env->dcsr = new_val;
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException read_dpc(CPURISCVState *env, int csrno,
>> +                               target_ulong *val)
>> +{
>> +    *val = env->dpc & get_xepc_mask(env);
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException write_dpc(CPURISCVState *env, int csrno,
>> +                                target_ulong val, uintptr_t ra)
>> +{
>> +    env->dpc = val & get_xepc_mask(env);
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException read_dscratch(CPURISCVState *env, int csrno,
>> +                                    target_ulong *val)
>> +{
>> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
>> +
>> +    *val = env->dscratch[index];
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException write_dscratch(CPURISCVState *env, int csrno,
>> +                                     target_ulong val, uintptr_t ra)
>> +{
>> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
>> +
>> +    env->dscratch[index] = val;
>> +    return RISCV_EXCP_NONE;
>> +}
>> +#endif /* !CONFIG_USER_ONLY */
>> +
>>   /* Execution environment configuration setup */
>>   static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>>                                      target_ulong *val)
>> @@ -6435,6 +6555,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
>> {
>>       [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,
>> write_tdata    },
>>       [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,
>> write_ignore   },
>>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext,
>> write_mcontext },
>> +#if !defined(CONFIG_USER_ONLY)
>> +    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,
>> write_dcsr },
>> +    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,
>> write_dpc },
>> +    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch,
>> write_dscratch },
>> +    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch,
>> write_dscratch },
>> +#endif
>>   
>>       [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL,
>> rmw_xctrctl    },
>>       [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL,
>> rmw_xctrctl    },


