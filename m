Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F200C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8AM-0003eI-4l; Thu, 20 Aug 2026 15:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8AK-0003dY-BT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:11:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8AI-0008PS-Gb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:11:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJNKq3796370
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ru2EQi8vFClgW4g5qPAptRRscQcRhYkFJXZrPykOheE=; b=YEtGA87NMtYFy5Em
 RECwsL0irLy2gx0QsfofT6G3LvHXx/7L9mEZr5XIFFK9Knheb6JscQmXs+Isi8ep
 XFiAR+XfgQmVS84AufsL5MiuC//StJ2Qwd+3cSj9r2Smm8/bunW67zcdsKFs2Y+J
 kjlqJYfLMXUZUBq1AdaQNKvP0qz42ikclUC0cd2GANUosmBGB2RTEZN3IUtRyewr
 ds56AyX7On7jFCySohGF06a1pP5U0Uput4kML8j820i3e6mKJ3nt8pEgrhrbYhzG
 r01Rm51fZY9ewxxgBM3LJFxUyfP7ISinIhNyWWE0zoF3136qfxBQR9FILZRFa7ZK
 7lkayw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbvasgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:11:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d5d00fd19bso3835565ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787253053; x=1787857853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ru2EQi8vFClgW4g5qPAptRRscQcRhYkFJXZrPykOheE=;
 b=aYpi2nVR8mbtWnl+CdLCoYspd6U4ea1fZa04sX1oO88jnLWRzk7K0QJlLO+GzIeWyy
 QAJnQoGiEoZuk+aapnJOWCIUCA4B7WD8x7nuAjmQ4gsSd6fLi9dYeaHfI7GyFSki/0U6
 72kE9laKHeJf1uQc1tVXRdDpM71BEd8OndL1M1/T6NeI0i/xQGUUHU6ogtEY0DFstqzo
 fa+q9BZjb1q78MTM8GmrPW4oNGj7zc0swbEkT9q2o5cdu8J2ZOGwF4dlDBIqGjrQfuZN
 pXQIUp6+uInqE6t63ky7MXQtM5Kz7lfyyzHzqCc75/dGlVB+T4sV/cULfGCfBRs3SihG
 7NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253053; x=1787857853;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ru2EQi8vFClgW4g5qPAptRRscQcRhYkFJXZrPykOheE=;
 b=PegIrkiDkaSa0b7FbJClXvFXUKMjBkHL0HIqgfHUsZnLR6I0O8aaoEdbfpiEinOPba
 +mM3tLseUtOOO5zxcw19gbJGhsVlhNcdhJEVzWXbmC2RKi+foX5enjUKOktG2t7jmXN3
 2YBmEJUf9VtoKE+3sgvzXhAbU/Hz61PYI6+yidPK/0a8WmlZm4JZGVxN7zqBDqLrDsZ2
 KOEoQu65mnwa5Pcf1slTrRpjdcMMAsObhxrcw8tOyAX8X2ez18ksaEgMOpjCdCnRYxx1
 inRfkaOa71xEscbINcaA0vftuRYuUU4NN+jO5jj2uShCZrv2wEogZus7jh1AaKOJ82Yd
 S5Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpP5U7+z7/CE/PaP8muy4WVG7MOZLeTWWw2KTF3aqW2ZKnhvXAZBvWkp0DOaZSrHkg1WJJu3qRu+hrQ@nongnu.org
X-Gm-Message-State: AFuF++k7donMPWGmlLVEyf+ZkjjFJz4R7VzSrO7Qa9+Eo/ICt4+jI9Vv
 kG2Q/OZ18bTOa/CukaZxbFDDeqD5dvxY6d0Wry4Qho/Dlo4vJJi2BtjEPzNbi6ONsxPUPKdtenC
 vm1b7evMwij/Q4i9//nCfL7L8nIf+9XgbvHlG9QY7cl+I50uk1o8IHTQ7Xw==
X-Gm-Gg: AR+sD12E2lEh0GBuE8KLzn74UWPn9RVcmXyuGqzNs5kAGzE5ypA/1dVSYgQTHX6IWre
 PAzpH6EPJAhgJnSGS3d3Dl013BaTsiQjrk64HHyCXJvjqABLS/XAmhz8zwwkN4wryHdDN9Z5gno
 NHFpr4Oe9zK7Sa6bS3Bl4IEnN/rFuJWVYDcWAsKmLygHfg2AhWVo6zr1Omif9c4p5DBwxmQDT0P
 uxXCECNA0UXy82vhSkw6BFiRAH7HU67FJhZzGlcgI3uxHJhD5jWflNZwRdgbRLAffADUCkxkYbL
 8hbqxiE0q5rzwVd1qqGNzN1JHSOABUJd4E8JxWXoHSZJUF6v6TTEDH6b3Nu5AmZLEnYJP2DZ3px
 n8KsilQfBHGLTMO7/FmglB40VGypQsUjqJ5GIJMjA5ziBi+y2Nhpp/bBj5UZvrCpRWmYR
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-395c33d786amr1487780a91.2.1787253053016; 
 Thu, 20 Aug 2026 12:10:53 -0700 (PDT)
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-395c33d786amr1487674a91.2.1787253052413; 
 Thu, 20 Aug 2026 12:10:52 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae89189sm18998936c88.14.2026.08.20.12.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:10:51 -0700 (PDT)
Message-ID: <facdfb69-cca5-4360-9bc5-5ae3d5d03457@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:10:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: invalidate translated code for user
 icinva
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
 <20260819045339.3661773-2-brian.cain@oss.qualcomm.com>
 <39d5f3bf-4f04-4e90-8c32-8132ced0b4cb@oss.qualcomm.com>
 <00d99c24-0cda-47e1-adb0-e3a836509ba0@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <00d99c24-0cda-47e1-adb0-e3a836509ba0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a875144 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Jt6A8CZtxJxN9MoPh4wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NCBTYWx0ZWRfX3DiQUsyyEmzz
 iWOL3u/GNE+7WNm/a3k8XCyfEeNrj87uQVTKEH8czCW2E1v1idp8eUvEheFp34h61mDjkceIfB9
 xTC3DR0wiKBEMfv19gt4vIxwhGt7jfBI+4wXx6eFS+9AlmMX4+KOq4UxatPdLF6Lh2jdN8qHa8G
 G6yNem26LJ5TfDOwkZBrRXn/Xt7bs9hNnK87pmFsJyIAapQCwmcxGgbFu/rNV4PaasBQVPlsuvf
 SSjxJ4iQfVKZLB5qmisfBpc+Tfh0UcR4W9YWJG2URPEVI1+Y3DtiieiDc1hQmuTBzFxFGqYlPOf
 A1K2sC7jihLN08SCIFC9aBU0rLQj1vmAoAuouH610aLmwY0eLWX1eqXPNCoSTCU7X82jzjXnhYX
 oG1yK46FRz57AdV/0+AyvnCXuwBIro4uOmju3/ZIftrofEkFiu2tY+9H9W05C9cRDWYA48/REFp
 aFe92eglhQiP5f3YqPA==
X-Proofpoint-GUID: 2NdRojYvx5ePs9w5_U42u3qGH4CEUMWz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NCBTYWx0ZWRfX8y0hPxD9+sKA
 B9jnRkUclXGO5YJYjvFtQ9v42S8L+lzX6liJJKbFtAszqbxq/ygwFvRLGqKi8m/oUfdjNv4BbG4
 I/rf0U0uZk2EfRg9zAP6V0AD2NWJU8k=
X-Proofpoint-ORIG-GUID: 2NdRojYvx5ePs9w5_U42u3qGH4CEUMWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/20/2026 12:00 PM, Brian Cain wrote:
> 
> On 8/20/2026 1:37 PM, Pierrick Bouvier wrote:
>> On 8/18/2026 9:53 PM, Brian Cain wrote:
>>> Route linux-user icinva through a helper that invalidates the addressed
>>> icache line under mmap_lock
>>>
>>> For system mode icinva has nothing left to do, so it stays a nop.
>>>
>> Why does system mode icinva is a nop?
>> Shouldn't we invalidate translated code also?
> 
> The normal behavior of instruction translation in QEMU is conservative
> relative to the ISA constraint.  QEMU will invalidate translated blocks
> that become dirty/stale from a store instruction, so icinva can't flush
> anything: it's already flushed.
>

I see, it's related to the fact we emulate mmu in system mode.

>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/gen_tcg.h   |  9 +++++++++
>>>   target/hexagon/helper.h    |  4 ++++
>>>   target/hexagon/op_helper.c | 15 +++++++++++++++
>>>   target/hexagon/translate.c |  3 +++
>>>   4 files changed, 31 insertions(+)
>>>
>>> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
>>> index 40e03781d36..1d25391282a 100644
>>> --- a/target/hexagon/gen_tcg.h
>>> +++ b/target/hexagon/gen_tcg.h
>>> @@ -497,8 +497,17 @@
>>>       do { RsV = RsV; } while (0)
>>>   #define fGEN_TCG_Y2_dccleana(SHORTCODE) \
>>>       do { RsV = RsV; } while (0)
>>> +
>>> +#ifdef CONFIG_USER_ONLY
>>> +#define fGEN_TCG_Y2_icinva(SHORTCODE) \
>>> +    gen_helper_insn_cache_op(tcg_env, RsV, \
>>> +                             tcg_constant_tl(insn->slot), \
>>> +                             tcg_constant_tl(ctx->mem_idx), \
>>> +                             tcg_constant_tl(ctx->pkt.pc))
>>> +#else
>>>   #define fGEN_TCG_Y2_icinva(SHORTCODE) \
>>>       do { RsV = RsV; } while (0)
>>> +#endif
>>>     /*
>>>    * allocframe(#uiV)
>>> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
>>> index 78dc28ca9e5..a5a5c123533 100644
>>> --- a/target/hexagon/helper.h
>>> +++ b/target/hexagon/helper.h
>>> @@ -113,6 +113,10 @@ DEF_HELPER_FLAGS_4(gvec_sabsdiff_w,
>>> TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>>>   DEF_HELPER_FLAGS_4(gvec_uabsdiff_b, TCG_CALL_NO_RWG, void, ptr,
>>> ptr, ptr, i32)
>>>   DEF_HELPER_FLAGS_4(gvec_uabsdiff_h, TCG_CALL_NO_RWG, void, ptr,
>>> ptr, ptr, i32)
>>>   +#if defined(CONFIG_USER_ONLY)
>>> +DEF_HELPER_5(insn_cache_op, void, env, i32, int, int, i32)
>>> +#endif
>>> +
>>>   #if !defined(CONFIG_USER_ONLY)
>>>   DEF_HELPER_3(raise_stack_overflow, void, env, i32, i32)
>>>   DEF_HELPER_2(swi, void, env, i32)
>>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>>> index 23894ff3d28..84f5564b1e6 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -23,6 +23,9 @@
>>>   #include "qemu/main-loop.h"
>>>   #include "cpu.h"
>>>   #include "exec/helper-proto.h"
>>> +#include "exec/mmap-lock.h"
>>> +#include "exec/target_page.h"
>>> +#include "exec/translation-block.h"
>>>   #include "fpu/softfloat.h"
>>>   #include "exec/cpu-interrupt.h"
>>>   #include "internal.h"
>>> @@ -311,6 +314,18 @@ int32_t HELPER(vacsh_pred)(CPUHexagonState *env,
>>>       return PeV;
>>>   }
>>>   +#ifdef CONFIG_USER_ONLY
>>> +void HELPER(insn_cache_op)(CPUHexagonState *env, target_ulong RsV,
>>> +                           int slot, int mmu_idx, target_ulong PC)
>>> +{
>>> +    target_ulong start = RsV & ~31;
>>> +
>>> +    mmap_lock();
>>> +    tb_invalidate_phys_range(env_cpu(env), start, start + 31);
>>> +    mmap_unlock();
>>> +}
>>> +#endif
>>> +
>>>   int64_t HELPER(cabacdecbin_val)(int64_t RssV, int64_t RttV)
>>>   {
>>>       int64_t RddV = 0;
>>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>>> index 06a8159d283..1560c412732 100644
>>> --- a/target/hexagon/translate.c
>>> +++ b/target/hexagon/translate.c
>>> @@ -354,6 +354,9 @@ static bool pkt_ends_tb(Packet *pkt)
>>>       if (pkt->pkt_has_cof) {
>>>           return true;
>>>       }
>>> +    if (check_for_attrib(pkt, A_ICFLUSHOP)) {
>>> +        return true;
>>> +    }
>>>   #ifndef CONFIG_USER_ONLY
>>>       /* System mode instructions that end TLB */
>>>       if (check_for_opcode(pkt, Y2_swi) ||


Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

