Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AD9FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHwK-00073D-Av; Tue, 05 May 2026 11:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wKHvy-0006xh-5u
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:43:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wKHvw-0002Kf-3Z
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:43:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645Do4943475816
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 15:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KoT8LMxue63Xd9ZYi8wpHhIzOIJIl3sK9TKwLUpHN4M=; b=czghVmfHG4UimKsY
 U6sIQnjuwBNHedE4E8+RRB4Coru4jrn/6T8K4BzW7KnSddTazX7Y9fkDbOMGY3Mt
 wu79fejL7gvli040Vi7aWXWaOOWJCS06ZXKuajDsMrfrBtqaD8X5PhoSE2QGNPKZ
 eKRy0DUGXGBiqVyyNrv195fWC7Gllm7JD8nWv1zlkWDjW4gt82aU+njAQ591AzjV
 pjzu2ADQ/AcF1n2tCdU7WoFpqO8suBbLN3fiD2OWFXxpzYTolYYfSH30FLBOIn2l
 fnVBDhRgSyG4/Bf3nu3vCxYGCJ6YiozyhqeIxTmpr9cKd9BAehxgK/EOmK5ywhVG
 G+wgXg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgrfcc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:43:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f485961555so1824994eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777995817; x=1778600617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KoT8LMxue63Xd9ZYi8wpHhIzOIJIl3sK9TKwLUpHN4M=;
 b=RbUriaE1kv3ORScx4giHwhUOudzq4pZdMw8PD/ZhFpDe4F8cB/yrByr40bgpEY7kFE
 E4yfmF5IEpYb8+FvvTIvfqGAgUiKhlu08V3cTOOrI7VjFLBbvjBn/ta73leV+HVsY6+F
 z0Y2xevVMhz61/8hAdBYcynGfaXTccP0PEVHt7CXYud9WPQia2yusJ8yL5nP4hASYRxk
 M56CHH82sRMcP3ENeGP7i1IYtKxjAFJEVgBP0c4Lb+rRi+g42unP0Xm5/kC1K8b1Ps7M
 0FqhgmQqaiAr7rajkIl4uuTdi8osfRwP3GL+m6H0nHVnUGaQBN1WGmVYmZAgBgmhC1FW
 eG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777995817; x=1778600617;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoT8LMxue63Xd9ZYi8wpHhIzOIJIl3sK9TKwLUpHN4M=;
 b=LQjMoqbRBiBCRwCloSmYEOGkzQK53bSY8ODFro/fu/6zM23LmMWlm9tQU7w+a1MYfA
 Kgs/RJBcq8B3fRxggOpzdG/RaDFdpulUCZM0KjVDKfmqK/C1K0PXNbC2SanQR5JnG5BT
 DxNSO52hDtdGCRWU3Cw6TLAsc+q2pa2bLRA+Q1cFa0pMQTcOKwQJXlW3B0vh50KMjxU2
 cR3JJwik5ddHcFVu0bZCO/UAgF4eOZg4VL60Srk1wUu1w1ioD1TvzoojQ5n1oKvFVzOq
 uKfw8A+WnvYQ3JO+PGncYWOc3AeViKPvSEfK7oVy/JtyBZRJu2cbQIppOF32ZdxYKbyN
 kI0w==
X-Gm-Message-State: AOJu0YzZmg9GFcMNbIbxjDlhSrDRtjQvV8A4an632s8+3c/Oa6Dj/ORZ
 hMRWQKeIOgixNv1uRSvSo5Xj1g5GZK+CZtbhjCTudqr3v6VQ7XyuQp/JnLtjlbqx3V8P1kVpNgI
 8P2eidpdecwZyTkp5umpCsziG8OqfOzsz/E0t4URKFfOxx2E7w3e24x/ktQ==
X-Gm-Gg: AeBDiesyLdK0fil6zUzifZeKKg15dw/aZIwY/AKGj6uRKU0KABlv1FyOi9eGORvzSih
 o14ro8/HD/W3bH9v6NsB/9j0wIYvDM9vJLlUAGsAChG9VskBRrS9tuZ1sTIVA7lWWdWTozuNn/O
 /gxyuzCLUdvxf0fdwoOToyEyn0yleeprv49BhAqgMbW6b9G4v2j7EmIUPE7lyve1Q3kx85DeGUI
 lSw+tLOwPogduD994eveNR9dk2MMDrRjuGrkZqJZ6p/j3zyQXXVfgL4kRnMkyhQUZ8MaXEAyme+
 qG7scykwP8pC9iBbdKGsCPFiWepGr+T/37w79Zi31K7Vl7RrMFSJ+Z0d45EjV0UtSrCjPuE93k5
 H+cfw5FdcpDhXYnDJl1TDrmoTl4VCNa/1F5dnNoDPPDPmZzxiSpgUgOreAbxLEoRv1OacnA==
X-Received: by 2002:a05:7300:6d23:b0:2f5:2556:5acd with SMTP id
 5a478bee46e88-2f525565f82mr222605eec.13.1777995816932; 
 Tue, 05 May 2026 08:43:36 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:2f5:2556:5acd with SMTP id
 5a478bee46e88-2f525565f82mr222578eec.13.1777995816330; 
 Tue, 05 May 2026 08:43:36 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3b29b2e0sm21417532eec.16.2026.05.05.08.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 08:43:35 -0700 (PDT)
Message-ID: <f8f5447d-d78e-43ba-8a83-a28840474fe0@oss.qualcomm.com>
Date: Tue, 5 May 2026 12:43:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/41] target/riscv: fix general_user_opts hash table leak
To: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-38-c413f3605311@redhat.com>
 <CAKmqyKPQWSEtpgMSoMuBwa0L_QrjMoKq_mCoCXWSa-z5KaAEuw@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKPQWSEtpgMSoMuBwa0L_QrjMoKq_mCoCXWSa-z5KaAEuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sAGbbmUpeWmlDWza4HEkvhrmEGB_jx5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE1MSBTYWx0ZWRfX0uATsKSlTuN4
 ELLFPfOaf0ar3IPkU6/fALMvMSaP+tvojdh6yq3Blr4YFEIOCmLP0KkvJ9W4LwEXij3ytlBGTz5
 24tZzLnRljkrYRvOC32sFv7OmosjGXTl4LITVYEBX57YWMP2hsMbg6wLceoc25PtGlbKQjyQx2x
 jcPi9vq9CWZGq1FABOW7ysNmA+7/CZDV7+dHeJDwAqhmOqMvAutyo1ziasIv2jZgtS8/bgsX2m6
 FeyzyxZ+lxL4n3wKx3lsvWVIgCxzorCIFKQA9SaaLfYWmE6Zwn2VNBycKWkesic422aBq2wx7y/
 2K0+x5Ma327k1S0qbJmcjzSTkZPvNdEy7AlVm0LKqegh7Kil1nROSuGaXuGDJkvtywsD9gN4A7V
 DzsieR5HT4k6iqkpdv2TDhN8s6CkJwEXWyAPu7NgEPee8gp8Vl9EDLCEF0Tdi+0AyYsN+4Jx90C
 WKOwKoo8+N4qltK0FjQ==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fa1029 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=6SScOXsMgGXdP4_LJm4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: sAGbbmUpeWmlDWza4HEkvhrmEGB_jx5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050151
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/30/2026 10:53 PM, Alistair Francis wrote:
> On Tue, Apr 28, 2026 at 5:50 AM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> The global general_user_opts hash table is recreated on every
>> riscv_cpu_init() call, leaking the previous one. Clear any existing
>> table before creating a new one, and destroy it on CPU finalization.
> 
> @Daniel Henrique Barboza I'm pretty sure there should only ever be one
> instance of general_user_opts and that's the bug

Yeah, ideally we would need a single instance of that since the user options
are global and not per-instance, i.e. all instances would see the same
array.  Not sure where to put that though, or even if we can declare it
another way ... maybe declare it as static, let CPU0 populate it and
the other CPUs just consume it?

I didn't sweat it because we have bigger problems w.r.t memory fingerprint
(e.g. the extension arrays we're carrying), and this hash will be populated
based on user options in the command line that usually aren't many.  But
it's something that we can look at, definitely.


Thanks,
Daniel


> 
> Alistair
> 
>>
>> Fixes: d167a2247ede ("target/riscv: move 'pmu-mask' and 'pmu-num' to riscv_cpu_properties[]")
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   target/riscv/cpu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 8ac935ac06e..15fa03e22a4 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1101,6 +1101,7 @@ static void riscv_cpu_init(Object *obj)
>>                               "riscv.cpu.rnmi", RNMI_MAX);
>>   #endif /* CONFIG_USER_ONLY */
>>
>> +    g_clear_pointer(&general_user_opts, g_hash_table_destroy);
>>       general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
>>
>>       /*
>> @@ -2961,6 +2962,11 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
>>       DEFINE_RISCV_CPU(type_name, parent_type_name,             \
>>           .profile = &(profile_))
>>
>> +static void riscv_cpu_instance_finalize(Object *obj)
>> +{
>> +    g_clear_pointer(&general_user_opts, g_hash_table_destroy);
>> +}
>> +
>>   static const TypeInfo riscv_cpu_type_infos[] = {
>>       {
>>           .name = TYPE_RISCV_CPU,
>> @@ -2968,6 +2974,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>           .instance_size = sizeof(RISCVCPU),
>>           .instance_align = __alignof(RISCVCPU),
>>           .instance_init = riscv_cpu_init,
>> +        .instance_finalize = riscv_cpu_instance_finalize,
>>           .abstract = true,
>>           .class_size = sizeof(RISCVCPUClass),
>>           .class_init = riscv_cpu_common_class_init,
>>
>> --
>> 2.53.0
>>
>>


