Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25645C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx804-0004Bc-AM; Thu, 20 Aug 2026 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx801-00049J-8r
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:00:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx7zw-0003p0-RI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:00:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIIuNo571519
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hs5N8gzTB69XOxxfOaRjeM/EKjW0QgBxBPKk1hN2nFE=; b=buvL1LjB4cZSWkfo
 1CEERRyhJ3k4Gz9xxz7B6Upgdfjv8LpG2bhZyIiD9857KqAPM02OU1vr0Rcw5+39
 lUoH5n8nMG5hfAGtfGPhkmrQ/J3EK0VwLjUeSDTbwcPyUQ6DusdE7AkAZLUsXwDT
 tbw/e8djghe/ITjhLUQZiyZzMswpBOx9+UU8lnO7tRJYVeux0qWF26vPNpeIg+bs
 uvlAiI5oOkBRHjPThHapwY5tWypVELyp9M6SygBqKH7SuVdXV3RYMIRQRONUcK1t
 C2fvqczf7uPEVT2a8x4K2ZT6ZNvaE0MtpuGGcioE73ERTuYun/sC3K50iZFg6X4n
 rscVZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgcarnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:00:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934979ee9f1so18354685a.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787252416; x=1787857216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hs5N8gzTB69XOxxfOaRjeM/EKjW0QgBxBPKk1hN2nFE=;
 b=ICgqHvv/a3ky0TiENzbsb4sgReyX/ItNY+fCngOcAP0ODaqUnAAwu2iY09dQaJUl/8
 eKGZSpSX2pPASJ/6eQS+cl9EXANw6GjGxrHSLS8XwzanomN3Rzck26SeklvwT/iQEjWj
 +v4PKZzo+M4Ip0Yk7UBjaRMvUZHdPKkiW+Jlo2HR1jXDmbQdH38MrNx2BmLfEByXXcK2
 EHSbAAM/8YCFmjlyWgBHvnki2DJI4slNOzuvEygDYoGh0Yvr5fZelusHYh4l6AqhQYyZ
 6Sys+E8s0WVvB/krNeApfoqpcFog1paghxGUfBLtIJPjX33JlOv/My+yj1rdZTRIwAB/
 5M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252416; x=1787857216;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hs5N8gzTB69XOxxfOaRjeM/EKjW0QgBxBPKk1hN2nFE=;
 b=sNTRd4R8AjKWKQCYqJ1TZjM06ImlAYIPIswQMm1tnMMmEY+Mr9wJ7TC59/y05ACNU0
 3i0hqLpATMVVAWF30lLee69Hinw6ftLcr5u7s3JMu41pOx0VQ1JwPFMjaJ+MnhbKIi3z
 ahULyk3NMG+/4tVgKYgQuvzFTfgMrVkURGobjD1+XSQ+O10quvRYTYTtfSrJsUyH3PCv
 lGva4gbkKitnoz3mYty3pkEkHYV8ASaSmCYuJQrPToA8jcWvSzJzaS1pSWJKWaRrow28
 eX1uznBMZQFCUTQ/EPrlG/Q+/fcMd8/1hueZWX0b7u7E+oZfYgctXSG0TzAHIyvLRC4Z
 Pwog==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCZj7tMYwG5obNG24Q/10lfJkDFOVC2rc+Pbbw2S5+4XRBxek26h+jty3l25zxnXxsoD9sbA32JZ0E@nongnu.org
X-Gm-Message-State: AOJu0YyQD8bxKtsyRNdlfphv92oFbLU5xU8BTscJLjOmgVgEnWnfX5dg
 t0NpjpFuIMVUCr0sv6ZuBfq/0fUZDTlJuROyA4pD0dwXUcLjJGv5gT/U/wbMWEwWc5IflsmQe4W
 hQjZZY6+9n50918swDahBc4SF126fAFbtq+gX3VF1KoNfHPwyQTTdAT6IXjxKA2kiPg==
X-Gm-Gg: AR+sD126N5Emr6o1RYbtqx7vGkJW2wbdfdhZG+bkF2EpRDSAmqqFGDBA+UG1aAtSDa4
 RJACalwfc7g9m800S2K76bUBq9PpNlXDUNxcpugOoc3WZtIqAfMl+tM4LBf86VABR3fuPGfjPPg
 JKTcvkveAh8Ii4/D5hq8SDlp2Tu3cTov5/gh8uUoxzj0XaqZXTB3yITeAvR1YjMeL4BXxSC5ltO
 AcNpR2w3OolhGnYrpFVKg4rm/JSRi2OdEtN7i60+c3WS27pRMtd4SIFEao5//3r1TOSHEY38fLZ
 DCoiAjz3g6uV3sz/iGRkjEaHd05aPQTGddgY2jzeejxic3wJPhbnHmbuhoHEysRfMS/veHfOt2P
 h5tok6V2VMHIXmfA8lc4FYAEpCsnrBHOZz2stKAEMuZHqXpYtsE+RBX2FNPtXAMJe
X-Received: by 2002:a05:620a:4bc1:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-93739576960mr14029685a.36.1787252414889; 
 Thu, 20 Aug 2026 12:00:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4bc1:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-93739576960mr14011185a.36.1787252413348; 
 Thu, 20 Aug 2026 12:00:13 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720493f1dsm424103885a.7.2026.08.20.12.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:00:12 -0700 (PDT)
Message-ID: <00d99c24-0cda-47e1-adb0-e3a836509ba0@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 14:00:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: invalidate translated code for user
 icinva
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
 <20260819045339.3661773-2-brian.cain@oss.qualcomm.com>
 <39d5f3bf-4f04-4e90-8c32-8132ced0b4cb@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <39d5f3bf-4f04-4e90-8c32-8132ced0b4cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a874ec0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kpON_1s-VsO4AfR6lZoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: yHCv5tGf9T_RflQgRH43RinANe6HUv41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfX9Otl6RZLhNND
 5G9RIRvFdFfC869D0Hum9nKkkgBeGEXuAwgvq+Qk6CeK0qyo95ziY+9zBlBQwgOzP5QZqI3e7jT
 5wSW4JAjtweepMUScPwazNW6u1epu0HUR0kFrhUfLMFIc7TJ71II3AlSCZ3bWPdRMKWBIPUGLFv
 LLlYmrW8uEa8/cdXgf7yVwj6a8+i60I1nS1I9VWzm7kHb0OTjssBlz4lEq3qfz0GZawT/Lg7WlS
 oMZl+UXd7ICtQM890Vo++qqebnRQ3Yhcwf++0KH+E1Fx3jLxDJYdnJvKQO2w8ajxxDJukJ2DB9w
 BDu5qA/vssAPRfuvzQL5Qa8sN9Uanafe9ZTM/syJ0M78otGzGjjLkuBAS49QuageWzGAeAHtMoR
 R18v3o+4EXP6pTYkCvweYh426WDjDDXtptLwzv+bjCRC1uzsjlXI7kfQeuSvF2DfKgF2fve689w
 OTlBpr5VP1T2f0uyvNg==
X-Proofpoint-GUID: yHCv5tGf9T_RflQgRH43RinANe6HUv41
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfX68BCBOE2uv3M
 JrF0v9ZTnavfrqKAnNr6C6LGEt2Q0gRv94F0aJ9v4a4i+U2OYLXT0KPAEX1ULtHnzY7n36K2Jpg
 ud+P9SvToEWP4JBqYFUoKMrbwRpHuUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 8/20/2026 1:37 PM, Pierrick Bouvier wrote:
> On 8/18/2026 9:53 PM, Brian Cain wrote:
>> Route linux-user icinva through a helper that invalidates the addressed
>> icache line under mmap_lock
>>
>> For system mode icinva has nothing left to do, so it stays a nop.
>>
> Why does system mode icinva is a nop?
> Shouldn't we invalidate translated code also?

The normal behavior of instruction translation in QEMU is conservative 
relative to the ISA constraint.  QEMU will invalidate translated blocks 
that become dirty/stale from a store instruction, so icinva can't flush 
anything: it's already flushed.

>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg.h   |  9 +++++++++
>>   target/hexagon/helper.h    |  4 ++++
>>   target/hexagon/op_helper.c | 15 +++++++++++++++
>>   target/hexagon/translate.c |  3 +++
>>   4 files changed, 31 insertions(+)
>>
>> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
>> index 40e03781d36..1d25391282a 100644
>> --- a/target/hexagon/gen_tcg.h
>> +++ b/target/hexagon/gen_tcg.h
>> @@ -497,8 +497,17 @@
>>       do { RsV = RsV; } while (0)
>>   #define fGEN_TCG_Y2_dccleana(SHORTCODE) \
>>       do { RsV = RsV; } while (0)
>> +
>> +#ifdef CONFIG_USER_ONLY
>> +#define fGEN_TCG_Y2_icinva(SHORTCODE) \
>> +    gen_helper_insn_cache_op(tcg_env, RsV, \
>> +                             tcg_constant_tl(insn->slot), \
>> +                             tcg_constant_tl(ctx->mem_idx), \
>> +                             tcg_constant_tl(ctx->pkt.pc))
>> +#else
>>   #define fGEN_TCG_Y2_icinva(SHORTCODE) \
>>       do { RsV = RsV; } while (0)
>> +#endif
>>   
>>   /*
>>    * allocframe(#uiV)
>> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
>> index 78dc28ca9e5..a5a5c123533 100644
>> --- a/target/hexagon/helper.h
>> +++ b/target/hexagon/helper.h
>> @@ -113,6 +113,10 @@ DEF_HELPER_FLAGS_4(gvec_sabsdiff_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>>   DEF_HELPER_FLAGS_4(gvec_uabsdiff_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>>   DEF_HELPER_FLAGS_4(gvec_uabsdiff_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>>   
>> +#if defined(CONFIG_USER_ONLY)
>> +DEF_HELPER_5(insn_cache_op, void, env, i32, int, int, i32)
>> +#endif
>> +
>>   #if !defined(CONFIG_USER_ONLY)
>>   DEF_HELPER_3(raise_stack_overflow, void, env, i32, i32)
>>   DEF_HELPER_2(swi, void, env, i32)
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 23894ff3d28..84f5564b1e6 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -23,6 +23,9 @@
>>   #include "qemu/main-loop.h"
>>   #include "cpu.h"
>>   #include "exec/helper-proto.h"
>> +#include "exec/mmap-lock.h"
>> +#include "exec/target_page.h"
>> +#include "exec/translation-block.h"
>>   #include "fpu/softfloat.h"
>>   #include "exec/cpu-interrupt.h"
>>   #include "internal.h"
>> @@ -311,6 +314,18 @@ int32_t HELPER(vacsh_pred)(CPUHexagonState *env,
>>       return PeV;
>>   }
>>   
>> +#ifdef CONFIG_USER_ONLY
>> +void HELPER(insn_cache_op)(CPUHexagonState *env, target_ulong RsV,
>> +                           int slot, int mmu_idx, target_ulong PC)
>> +{
>> +    target_ulong start = RsV & ~31;
>> +
>> +    mmap_lock();
>> +    tb_invalidate_phys_range(env_cpu(env), start, start + 31);
>> +    mmap_unlock();
>> +}
>> +#endif
>> +
>>   int64_t HELPER(cabacdecbin_val)(int64_t RssV, int64_t RttV)
>>   {
>>       int64_t RddV = 0;
>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>> index 06a8159d283..1560c412732 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -354,6 +354,9 @@ static bool pkt_ends_tb(Packet *pkt)
>>       if (pkt->pkt_has_cof) {
>>           return true;
>>       }
>> +    if (check_for_attrib(pkt, A_ICFLUSHOP)) {
>> +        return true;
>> +    }
>>   #ifndef CONFIG_USER_ONLY
>>       /* System mode instructions that end TLB */
>>       if (check_for_opcode(pkt, Y2_swi) ||

