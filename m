Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287660A2618
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KUHovhfy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d8PeHtsi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8zC-0008B2-R7; Wed, 28 Oct 2026 15:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8z3-00089q-FH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:06:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xM8z1-0004J5-KM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:06:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIkA9P2546652
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 guHAVwe04KeT4IVaHQCoWACYVPLVhXO727jLFKVDgT8=; b=KUHovhfyG+yugCAS
 snA++VlCECnI9eQKWxRZ1jya8JAs1c3ID3ELwbtNmyLbvW9BGix1eKlBUKEknxBL
 b9xY7RNVfjh4EA3XxFyYFc+x0PtuQ5zbFdJxaBBqdbySagRbp2ziPrZX14tCerzK
 MwCDlauG6sMp0DY+wORgBwVy/HLR3AdhAgfDcJr1ijIY/ppfEJN0oo2jqcVaW4Gk
 a4vUmOoBxFeOLpGQagAQbhpX/gKVux7ZD3A076r5+o6Toj9mu/bJaOHR5loBmYGx
 qN610HMMXMNlASsyKhb9Yi7aGd4D1iDslMz8d/BA1U17buKjvWZU8tObe0ufCF/p
 cqkbXA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc02wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:06:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a223755e4so4155929eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793214405; x=1793819205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=guHAVwe04KeT4IVaHQCoWACYVPLVhXO727jLFKVDgT8=;
 b=d8PeHtsidE/7PUtZiSpFuWur/IxK8yxYf7ZU4wjFk7/GP5hTZWOIPfhjogRm549Ark
 0798lARuBlaKAJbFd2EnNQtfDr0yYW8sQkxg+tQp509CXonJm66UlunDq10FE3NMfCsr
 ljbqIb7/j6I9ghKLQ7NLEkLJ1TMwEZoMmQsV1rwlPHLSRBfRDF/ZKROoBS4PalnNrBy1
 aaAU3snKA8OYBmpqG0eTEllcyjDXn8rEP50gClkzJba5+tWs/u2/WWETyIHIwtCPTZM/
 0ByZePwaqd3lt5lruRWD5OXE/X1KoUmcm3Mus8k3YDWJone2GByOZegCe9Gn86rWwgUm
 lXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793214405; x=1793819205;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guHAVwe04KeT4IVaHQCoWACYVPLVhXO727jLFKVDgT8=;
 b=rHhOGsUWNjrHX3IUWptbi8VtDnXH/QX+5x/M9R9kpG4fsqSVoYvmYKbha5xB41LJP4
 Xmpe6t9Dx63JgEFxaDZvrPSunjdu6qSmpMEhc62PQ7CfsAxmWKfwNqTUE33l0FG1Jx0u
 DCEQAWJ+OFmuMga/K/Y++6TJHLULvLQeKSasG26mdooXPvU7OT/tDIIC23dU7yH8vhsG
 rkdTuZLwukDp0mf1d3XkME/MJ4kFVtFtsROzEy53l919bpUhLx4/AC1FT+vuGJ6EfQ5w
 JeKJmHGdcHYwRQKEp1jBYYWv/DmtGjTFetxDGv0vyGT8aboNghRWmvFRtHtajkxZvJPT
 5LuQ==
X-Gm-Message-State: AFq9FYKeTAKWiQM+mrNAkh6y1XVSLx7ejHoHSBMCF/dj/tsdFhX8Yklc
 VX1PY4qMByVFpO/ZdtdaFL5o9N8zeYyOH5CpbNy0UR4v0eX6+g9FBVJMIkVu4ZSWAvxnwCJvzMo
 AZPi3mrdtun9WYoYYRX2Fm8IfWfBIdM+g7WVsg5f4lx5fOp77dIGYV96z5A==
X-Gm-Gg: AYBFou38axXS21WsnuoHmCKwN9xTMPoxTPWGa3UcHTYSOArw6OBFSsjWtjIvHsr+tkr
 eERo4eBwPEsOz5QcMAL5c8eyLAHrobwaTFrjcfI/XZq3CcQAwnTCp1ATvrGNAZ1ho6I2gdxMVYD
 PuQqBOqr+kakIovNOqBDGNn14BzbzOyFp8KhDVj6NQdrNTKk6toIY7p5a9jI8bmB7jgrO77SMLy
 PVmlE8OePjNx5RD8D4858EmZJLM9Xwqvtcx6YIRitpaorhvGypBvl22DmUMm4lQlud82aq9IHIk
 Wi/uQ9ZPQQiZDvKGI8XBbtzOxdNhKcB8sxL9D9MaWVmPaO+SvnPw1Oe5PvoGppE7rVqPYbxtbHt
 jJQTszbr3oA1ZxrsDaeF1Wb1JMm2pU1gXv137R0mGK9z6okq+Ek6ocML/ErhPfhdqFOZDbi4Uef
 7a4EjrP/VmPBGn1QWEqGr5ZEh7rYfj6RG05ZdejhH7U+I=
X-Received: by 2002:a05:693c:4010:b0:36a:eee:bb41 with SMTP id
 5a478bee46e88-36a202bc3ccmr4740963eec.1.1793214404734; 
 Wed, 28 Oct 2026 12:06:44 -0700 (PDT)
X-Received: by 2002:a05:693c:4010:b0:36a:eee:bb41 with SMTP id
 5a478bee46e88-36a202bc3ccmr4740917eec.1.1793214404010; 
 Wed, 28 Oct 2026 12:06:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2395bee6sm8813926eec.21.2026.10.28.12.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 12:06:43 -0700 (PDT)
Message-ID: <7bd5d577-63db-4356-a19e-4b7e030d58d9@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 11:06:42 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel: register CPU parent for each target
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
References: <20261028063049.2530-1-luoyonggang@gmail.com>
 <20261028063049.2530-2-luoyonggang@gmail.com>
 <bc5bad6e-fbc2-44e1-a4b4-41bdfd41d33a@oss.qualcomm.com>
 <CAE2XoE_r3gZXzS+TFUd+GRs-8ZtCTajsJK0wJpTHNoXx_Cf3dA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_r3gZXzS+TFUd+GRs-8ZtCTajsJK0wJpTHNoXx_Cf3dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae247c5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=8y7-PkDap2zE0UGPBckA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: Wa_368MhTSQT_wJ2L6cbpmwmFZWv_Xct
X-Proofpoint-ORIG-GUID: Wa_368MhTSQT_wJ2L6cbpmwmFZWv_Xct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NiBTYWx0ZWRfX4e4+ovyOR3bh
 gS4MJkfL8prUeT2cGsCLeIeK9EHEi3PElol3ZBsR4r9qYVAWn0DLNPxjDn8RqSbqLvi1yeTMJUK
 4EFcZYTFD0MlF1TfY9xdP27rebK3zHNx5H55UtZpNC78FjAuDvn5i91Gm2776DDlcXa2iIz2HZ6
 QWhbsvH8Pz4rMAVrsfGCJJJOThgBGDFLVRRzIVhyKROwwAGaDz04oyapM/C++jSple3mRHxJ+zW
 6YLN7PqD2LbY1Y9belL3xJtARZXBfDrxblkAv6eo1LkYGcHPBuEwlqpf78lX4WOqo1+lLxU9QLw
 7dXK/yiMxLDvuIsgomGyeQ/i36DTuRq0qpaAPYFyIqo6P2lBFc99M6Mt2BsylLTi2C6lKDEMTeb
 rJ6UttAO7dH17LsyWg4atfjRtdEa55TExPwmo6QfA0xLwz7Qb4+XWaYmxzpdWdvWl4/UwY86jaf
 YKFwT/cvRGtGNQJaf0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NiBTYWx0ZWRfX3uhYZWVtiaSF
 Hgn6uiO2JYszFqAZG2+5dv6E3wtUws+B+CDwBWIQYnaAtEKNYAuAdtvn0OP8GIwmmm7NtYUD1qh
 L5DzxwFCqj6U7cNO+g61WxVOqcN7qmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280076
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 11:02 AM, Yonggang Luo wrote:
> On Thu, Oct 29, 2026 at 2:25 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/27/2026 10:30 PM, Yonggang Luo wrote:
>>> A multi-target binary registers one accel-$cpu_type parent per linked
>>> target. accel-target.c is compiled once per target and calls
>>> accel_register_cpu_type() with that target's target_arch and
>>> CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which
>>> arch already registered. Targets that share one CPU_RESOLVING_TYPE
>>> reuse the parent from the earlier arch.
>>>
>>> test-multi-target checks that each target's accel parent exists after
>>> QOM init.
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>  accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
>>>  accel/accel-internal.h         |  2 ++
>>>  accel/accel-target.c           | 21 +++++++++++++++++++++
>>>  accel/meson.build              |  1 +
>>>  tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
>>>  5 files changed, 74 insertions(+), 3 deletions(-)
>>>  create mode 100644 accel/accel-target.c
>>>
>>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>>> index 00a400243f0..0d04b8c5749 100644
>>> --- a/accel/accel-common.c
>>> +++ b/accel/accel-common.c
>>> @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
>>>
>>>  DEFINE_TYPES(accel_types)
>>>
>>> -static void register_accel_target_type(void)
>>> +static void register_accel_target_type(const char *cpu_type)
>>>  {
>>> -    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
>>> +    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
>>>      const TypeInfo accel_cpu_type = {
>>>          .name = name,
>>>          .parent = TYPE_OBJECT,
>>> @@ -143,4 +143,29 @@ static void register_accel_target_type(void)
>>>      type_register_static(&accel_cpu_type);
>>>  }
>>>
>>> -type_init(register_accel_target_type);
>>> +void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type)
>>> +{
>>> +    static bool accel_cpu_registered[SYS_EMU_TARGET__MAX];
>>> +    static const char *accel_cpu_types[SYS_EMU_TARGET__MAX];
>>> +
>>> +    if (accel_cpu_registered[arch]) {
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * Keyed by target_arch. Targets that share CPU_RESOLVING_TYPE already
>>> +     * have a parent from an earlier target_arch.
>>> +     */
>>> +    for (int i = 0; i < SYS_EMU_TARGET__MAX; i++) {
>>> +        if (accel_cpu_registered[i] &&
>>> +            g_str_equal(accel_cpu_types[i], cpu_type)) {
>>> +            accel_cpu_registered[arch] = true;
>>> +            accel_cpu_types[arch] = cpu_type;
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    accel_cpu_registered[arch] = true;
>>> +    accel_cpu_types[arch] = cpu_type;
>>> +    register_accel_target_type(cpu_type);
>>> +}
>>
>> No need to do this, just move the whole type registration in
>> accel-target.c and type will be present at runtime for all present targets.
> 
> The issue is that CPU_RESOLVING_TYPE is not unique for each
> target_arch, you may not realize it.
> for example:
> arm/aarch64 sharing same
> ```
> #define TYPE_ARM_CPU "arm-cpu"
> #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
> ```
> 

Oh right. In this case, the accel-target has to be added once per base
architecture (in each target/*/).

> And the same name can not be registered twice, that's why this
> accel_register_cpu_type should be
> in a global shared place. We need accel_cpu_registered/accel_cpu_types
> for deduplication.
> 
>>
>> Regards,
>> Pierrick
> 
> 
> 


