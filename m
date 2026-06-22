Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD4ACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbesH-0006tS-Fr; Mon, 22 Jun 2026 09:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbesB-0006sP-M4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:39:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbesA-0001kW-1D
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:39:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MDGAmN1261006
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ftUD0ywO6GZfk9QBb/TgWrHziVNm8tIhNJIJNDciOIw=; b=n9Pljepu+vlm9FDK
 FXliGa0V/7nA0SwEtfRH+hzDbZRX49b5zTSVVVA7j8JD9jHGKVma+bvZS5d/HmyC
 gXc8hOFSye4HGz5fKu2X7d6hyrAs+M6yId7ig9pgeWLiVa/Hs9OqdbcDrNBfSyJf
 IMP1PoGc1D15HBJgOGaH2opIcyvVnhVk+N/be3W5lnsIi4B1+ezEMloYPh2RBxYp
 /cuqHBdOgttQecDQY3oUxDsgiAvXDFjopWLiywPWgYsUmsjxojlAziDN6P2APUmz
 1JkThXKD0cBJbMwMcRJaho2/LOi7Q79YJz7MwaqS2DvS7IiE6oMcVu2kniRS2Syd
 lSjbsA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3eb8kmc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:39:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9159c4b210aso852911585a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782135570; x=1782740370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ftUD0ywO6GZfk9QBb/TgWrHziVNm8tIhNJIJNDciOIw=;
 b=EuUPJbfytZZQLMwSTmUhblorIkM13kKWydu8H6zRjfd40+hxt/WV32kubKC8WlVt7z
 FhOKuQBgqvG/77QD8bVX2oIxJpfQckFSsP6PAXL9ueLLeWOfq2LtByCWrSDVQ7vyVXe2
 gFAyjUpq414hxzWSsfI7524g8OnIttB/Ba/8YEVDZELL/yyZDXEDybvFL+73GfYI+s23
 794+vkAPhqhFQPImY2+Q+XgW7OdTHCMHN8q/ZD2nA68a/fjAUygm9ETffzoAuel6fOU2
 qaeqJYWubxsBzwVO+9davsVjc1vccma35OHnCvY5+A7H3jaOrl0VSoyMMDLpkKTFIRIf
 M60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782135570; x=1782740370;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftUD0ywO6GZfk9QBb/TgWrHziVNm8tIhNJIJNDciOIw=;
 b=nJiuKC5yMzR6v7kHX4JGa64QxiM9CMGq/9qq7BpVm//8b/yxc3Vy95en9sC7EkPq9C
 zdhu2ETnqhcJIrWqEqOcLZY/UqBc77GRlTa70P8NQ1mkqBQieIYad/EJW82t+f+3eDT3
 +ROnn7EfXIQyV44L31vFwSPVfpfP24yzLMoECEnG227gqrnxnLWwac2Sooi90DCJdd1j
 jK550Rf0GNB0LqePKbLy+4aYDFrMPOC3PeMXLeDnHXaQKqedo/e8mUBuRzm7LJKLvT6O
 3I+qrnNuRJ4V1wpyzgevHequjiuNJdSZlz/N7CKxrcJgrlzj3rMzJVndbqbRMjOsiBbA
 5OzQ==
X-Gm-Message-State: AOJu0YziKX93fgkNoAubyBIhi58DIA23L1xEkySUs3lvZRYv6C1prUNx
 nCplwMWb5xRN630JeENXc0hAjEQp2eb3dxNOQ5UlpUeBlWUHCout0RJr+2T7Bcuyo+mcSMaoVmc
 eAGBZ5FTlRUGvc9Rh4Ai9IsMq4itWUHf3CV8PaDUhWG6K5pmOD1lUHbusTg==
X-Gm-Gg: AfdE7cnLwtX3s5tIHP8OcLbpT/RrntHzGH+4FrS9FxwImpOkSymm3k2J3dvAe893Wje
 W309zjIye/mUE1e8lHrgW6QLtoUfzmar28Vw3AT//YAsMuUfzfTHeTcfjZJUfG0NDjol5nGqXjA
 WiGL92pGk88zcFw892MaLWjN1q34d2HPnY2079DA9gYWfM0+KC/oBnau6NoqnmXAsy/vW8NkxyT
 wcMaV++Khlf10mfw/kpbTkbWzXScrTGqXjAVIXiAIIHO+7Yu/u39nycZYoeepCJgg1oA1NBDeLY
 JHGehC40jmxcZv4uLhU+BMZpea/zF/IlfFTLvf1kmjguXCCnP6wjNEd0Bf7ZM6mr5+vbzGaM5Zj
 Ph2UbPJ+6zIg9fA8dO41oUuaRtyR6YRe1LWRCZyf9yi6ZSzsVh3XymTsPOmHU5g==
X-Received: by 2002:a05:620a:2b4c:b0:914:e9eb:573e with SMTP id
 af79cd13be357-9208718fbd2mr1757503985a.0.1782135570414; 
 Mon, 22 Jun 2026 06:39:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4c:b0:914:e9eb:573e with SMTP id
 af79cd13be357-9208718fbd2mr1757499785a.0.1782135569877; 
 Mon, 22 Jun 2026 06:39:29 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c60ac7c1bsm360175366b.33.2026.06.22.06.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 06:39:29 -0700 (PDT)
Message-ID: <03156de5-9081-4b32-93ea-eaf363acf8ab@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:39:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>,
 ZhengXiang Qin <qinzhengxiang@foxmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
 <CAKmqyKN09Ut3BAnUpF4Fen=DzMcT=sNpGjTHa8yPeu58H5EpDg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAKmqyKN09Ut3BAnUpF4Fen=DzMcT=sNpGjTHa8yPeu58H5EpDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzNSBTYWx0ZWRfX7Abfu/TztXTY
 3NkFsJw6dCOFTWs2XYslURg10XFfGOmAtv1ATu6V4zOtYjfZjYFX2qyd1dyuiCOfysE1Gpul+dO
 WzQ/j0not5MCtZwjEgqq4Slsl4IgWlI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzNSBTYWx0ZWRfXzFUcN+mfgYw8
 4ok8qF57VnHUC2FhWPoPWQjLoge8innqN+4kY+NmvdhlhGDvEPhyfhwvPEq/Ns05ARFgPQtl5U8
 drmCwwLQmbmSKNxtCDac+wXw38R4La2R4e4ZVlTp44sx6F0KVHRgI5HKiUqagrtpZG48c1eWFG/
 JgFV/djPzqoM1pC/udi3e7eW0v2yMtS1NLx0hOI4GatEOf4hCM8Mo5EQQdzuCau23mX6TX8FAJJ
 6Ahmx7VEczocL7+yDHvybxhMsqR08zJLr6mDqL1pc6PWliiHqHTzoCZ0d9z/t3URwjgDBBtv3P/
 8l7slOQmF2ef3H7u4RY40Easyp5jCIgg8FMqLiKoaZPA3PSrLWIE4/XDoVZgyvugr5wYN7RUsAV
 wnkx0p3jelB0HjX9CpOTNDOWa3sLQtnmOn2xoT9s9rZVHKkyAa4zx+GBt4Mdwm9dzhhjPKOsZcp
 eoyQ0coQAY8nv54DOBw==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a393b13 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=PpR6-8FN4503qITb6qEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-GUID: ktnom3T5Gm0PnONNSP3fKoD8UxvcYZna
X-Proofpoint-ORIG-GUID: ktnom3T5Gm0PnONNSP3fKoD8UxvcYZna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220135
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alistair,

On 22/6/26 05:03, Alistair Francis wrote:
> On Sun, Jun 21, 2026 at 10:48 PM ZhengXiang Qin
> <qinzhengxiang@foxmail.com> wrote:
>>
>> check_zicbom_access() currently treats any probe_access_flags() result
>> other than TLB_INVALID_MASK as a successful access. However, a result
>> with TLB_MMIO means that the target is MMIO-like and should not be
>> treated as a normal cache block management target.
>>
>> Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
>> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
>> non-cacheable/MMIO-like memory.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
> 
> Thanks!
> 
> Applied to riscv-to-apply.next
> 
> Alistair
> 
>> ---
>> Changes since v2:
>> - Add else before the success path for readability.
>> - Keep fault_addr as target_ulong since CPURISCVState::badaddr is target_ulong.

This is not true, the fields is uint64_t since this commit:

  commit f2287c7020f36e2f13622d9635a968d6f6fb507d
  Author: Anton Johansson <anjo@rev.ng>
  Date:   Wed May 20 14:53:43 2026 +0200

      target/riscv: Fix size of badaddr and bins

Could you update the commit, or ask the contributor to repost,
or clean on top, please?

Thanks,

Phil.

>> - Add Philippe's Reviewed-by tag.
>>
>> Changes since v1:
>> - Use a bit test for TLB_MMIO since probe_access_flags() returns a bitmask.
>> - Keep Reviewed-by tags from v1.
>>
>>   target/riscv/op_helper.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> index 81873014cb..50fd1b73ea 100644
>> --- a/target/riscv/op_helper.c
>> +++ b/target/riscv/op_helper.c
>> @@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
>>       void *phost;
>>       int ret;
>>
>> +    target_ulong fault_addr = address;
>>       /* Mask off low-bits to align-down to the cache-block. */
>>       address &= ~(cbomlen - 1);
>>
>> @@ -235,7 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>>        */
>>       ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>>                                mmu_idx, true, &phost, ra);
>> -    if (ret != TLB_INVALID_MASK) {
>> +    if (ret & TLB_MMIO) {
>> +        env->badaddr = fault_addr;
>> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
>> +    } else if (ret != TLB_INVALID_MASK) {
>>           /* Success: readable */
>>           return;
>>       }
>> --
>> 2.43.0
>>
>>


