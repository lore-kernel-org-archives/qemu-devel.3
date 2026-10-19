Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18031606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OvwGE2Te;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V5lyZakt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqje-0003Pk-In; Mon, 19 Oct 2026 13:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqja-0003PR-C9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:01:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqjY-0006B2-4X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:01:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPON11645966
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NEL7KtdG6fB+4VKHUilO5LbIet1hDdltvTlq70V8tO8=; b=OvwGE2Te/X6rPPe/
 L/lhSxsX6HgvfMgCzx2c7J7l4WNUQBbKksQyM3Z/C7SmctP/78R0V2q3ZjV9ZJxI
 +MV5ddV8lQVozYPFjQUdm8dYE9hFxOqrwXGFcICGptId2+HaoCNm5JupVbELIfD8
 dIOW+KzfvpFkfKiDzXbGky6smAEIIIubuuTVz0bb0ozU83Nr5tsBPcexHSOE6cpb
 TNPtFb5t/jcWODI9OVNMeUeG59gMdJC2RgYGf73jYrzmQsazU69H03bJy56r8VTM
 dUB7qcLdXWe3uV+MJXph0or+uECc6gVaD12dhPKx8+GpOUa4+aix3hZ40Jlz9eVX
 lWa8SQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65ja27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:01:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so3279323c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792429269; x=1793034069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NEL7KtdG6fB+4VKHUilO5LbIet1hDdltvTlq70V8tO8=;
 b=V5lyZaktPp9cWTzujAruqjrii7j0DEF7FAOeag/2E74F90Gp++hbo4ZVLc97LXl/Zj
 FsPGh7pQbnvfShlLNza5I5sOzko+ac0zug50cAPCjMeX4z4+7ZPwadcQtjz2xujKBP9M
 3fj6uhq0H+gk17r03fpqT0vGYvFkkdErtHgxmBvaE4kadsWgPIFsd8GPgTZH24ueTilF
 JwbrsPEuFr3IqzfPuKkp6kx9xNaMtt/4Y4LBnKXQKaKdck7xnVa+XDIvYDkgkT2mL1G6
 ++5e74mocq3sXF7Cs6LepP0RA0Nn2pFg9986azUEOfJ1LmXsjX86Y86+01cfEctxXc+O
 ux4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429269; x=1793034069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NEL7KtdG6fB+4VKHUilO5LbIet1hDdltvTlq70V8tO8=;
 b=EUqoHx5AAo2Xg6VBx/n2tSG3o+4bXNWMv8wRvztdPzG/HHl99pOsEA6X/C1o5dR/bH
 tewz6dIvkfcoz3DzZv4lpJSXpaBJ+/dcAZ5NklqQPGVIfqarN+nj7kaZ7YJrP6vylwW9
 UPkRwxshcD0B7qrP865qDy5spBkGBvLqlgTPITNFlsqq3JTlMeXhEEcNodvcGQa2tQ6/
 LEiGYlvfXzmxjfPyYO53gJgIWhtCyw4tsvZ+fenJH0Ds/i/ATZU6f+7n0KrGDuzaRuIJ
 MwnARmsHxxBeENwpcU6U6gISKja6ixiqUwWsDaXje0LMoaBl29zLpFHlUfYqffjPK6ET
 jvdQ==
X-Gm-Message-State: AFq9FYKpAIqydTAZ+GNYb8R1/oaeh0k2sNNZvUAC09aeLOiC/sq/qkaW
 4onjZI/YZkiKsQHzsnESwzmhO5cQRxYOa2xDaC7mmpe9RCKofImMGoEOGN73deA9dzu//ebR1Ug
 z5WbkeSRi7C0oTCe8iELj2t9tYWs1ix/zJW2oFI34+nC8SvKrln+uMdegxw==
X-Gm-Gg: AYBFou3kDnIi3Utkv8jwHtbhHxuV/YlGLDQ4aCWbjSKlAIDlWvGKoeYIw6103BuLgcI
 NCuLsrLLOGv/cz76zNJfyfxkTSKDXXBOLnP/B56yvTiBsvXVihlBzHggLFTMJBCOdxqoij9bLuC
 +Gt8PC3hJxgeOjpsJ+My32INeNGD77trSe/brfB/tZaZ3ZTNqwTiLb9/hMMNX5Mn2CgpjcGCiJE
 gQsq3pJkgGhUEEl1LgOGN4EJSsXpdyDMZl7kcJvBCrmq91jStY7vX6GcFzZe+f12JmRySGfclft
 A+vd2x1Df3/AbQNiRGjPar8BQs7mNBmoGaBAPUDfeSRn+c8l+2v/anA9ExdoEQBTIYu7Se/EzbF
 vrNq1xkAu+7nmOBL3mNrB1o9SD9tJvQK9tyeRE5YfP2+OH8PufnUGXuUxcMlAAHRaKtLlXA==
X-Received: by 2002:a05:7023:a56:20b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-18512296a15mr11238753c88.18.1792429268324; 
 Mon, 19 Oct 2026 10:01:08 -0700 (PDT)
X-Received: by 2002:a05:7023:a56:20b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-18512296a15mr11238589c88.18.1792429267475; 
 Mon, 19 Oct 2026 10:01:07 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm46236510c88.11.2026.10.19.10.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 10:01:06 -0700 (PDT)
Message-ID: <c0e7c1e5-4674-492d-baf3-c04547600a5f@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 10:01:04 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/23] dump: use get_dump_info sysemu op
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-14-pierrick.bouvier@oss.qualcomm.com>
 <179222656904.1619676.8797747178657746975.b4-review@b4>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179222656904.1619676.8797747178657746975.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NyBTYWx0ZWRfX9alwHkJKHV73
 yK70Xl7XFEmVtdC7rn2KDnP2Xb8xNAF/nWG553EGUYW4WRkxb75clqmix1l/YFCrGnidHAlTIwM
 0AhS2Ms1o+NvoqHxg2J+fqe6rlsJcaY=
X-Proofpoint-ORIG-GUID: RZ2LMtIinIFb4pHGO0xKvv7uWS4MjTyk
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad64cd5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_pI6GGVXlOell2Ai0WwA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NyBTYWx0ZWRfX826AyJoji2f8
 y4FLUIP819csoBAz1iZq+ESgZRVt31lmS6qs8uMK4rnirZCquadQgZmzVD3eh7qxRHePAm/F+Xq
 9JrjDbf13VghW7LL6814NNuabch3DZH+TwjzrmESpIbPy2RtHJbfxq0ULC1u0sjJYgpMbn87rS9
 RKnyehepb5v5WTGvaVK6hcG2+U46ChkScFf9ybTNDp7hSgI4cQFi+v4cuBo1A8KBWOPIPu+cvu7
 p56LlJUzx696Yn8GLCSxZN+yGHvHKT29hVEq2E9g9l3bOTFLcHfuvLZO3wQDsS3sCMfCbmkz68p
 XRKcGP+Ahe6fIFbzXayIsq5mUHqaPJ3/zExv8NUscYxogVsJwCrajrXHEs2+9YpaxVp8sgn5cMP
 Jh2gvKVzmIhkCwLQWfQZfGMzwud6glSi85p0plwbhRCZNGOtgqFMaJgJZb3nzIQNO+oU6vhCH7v
 HaajgQfqKEbnzH7PTWg==
X-Proofpoint-GUID: RZ2LMtIinIFb4pHGO0xKvv7uWS4MjTyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/17/2026 1:42 AM, marcandre.lureau@redhat.com wrote:
>> Now that all targets implement this interface, we can replace the
>> cpu_get_dump_info() call with the new interface.
>>
>> We always check if there is at least one cpu available. For instance,
>> machine null has no cpu present. Heterogeneous emulation is
>> already handled by the check above which disable dump.
>>
>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Message-ID: <20261016181410.191743-14-pierrick.bouvier@oss.qualcomm.com>
>>
>> diff --git a/dump/dump.c b/dump/dump.c
>> index 0ecff682dd4e..e0a7dfd58785 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -32,6 +32,7 @@
>>  #include "migration/blocker.h"
>>  #include "migration/misc.h"
>>  #include "hw/core/cpu.h"
>> +#include "hw/core/sysemu-cpu-ops.h"
>>  #include "win_dump.h"
>>  #include "qemu/range.h"
>>  
>> @@ -1793,7 +1794,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>>      VMCoreInfoState *vmci = vmcoreinfo_find();
>>      CPUState *cpu;
>>      int nr_cpus;
>> -    int ret;
>>  
>>      if (target_heterogeneous()) {
>>          error_setg(errp,
>> @@ -1858,12 +1858,16 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>>          goto cleanup;
>>      }
>>  
>> -    /* get dump info: endian, class and architecture.
>> -     * If the target architecture is not supported, cpu_get_dump_info() will
>> -     * return -1.
>> +    /*
>> +     * get dump info: endian, class and architecture.
>> +     * If the cpu does not support dumping this information, get_dump_info
>> +     * returns -1.
>>       */
>> -    ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
>> -    if (ret < 0) {
>> +    const SysemuCPUOps *sysemu_ops =
>> +        first_cpu ? CPU_GET_CLASS(first_cpu)->sysemu_ops : NULL;
> 
> Per style, avoid mixed declarations, please declare it at the top of dump_init().
> 
>> +    if (!sysemu_ops || !sysemu_ops->get_dump_info ||
>> +        sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
>> +                                  &s->guest_phys_blocks) < 0) {
>>          error_setg(errp,
>>                     "dumping guest memory is not supported on this target");
>>          goto cleanup;
> 
> Something like this would be clearer:
> 
>      if (!first_cpu) {
>          error_setg(errp, "dump: no CPU to dump");
>          goto cleanup;
>      }
>      sysemu_ops = first_cpu->cc->sysemu_ops;
>      if (!sysemu_ops->get_dump_info ||
>          sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
>                                    &s->guest_phys_blocks) < 0) {
> 
> Another option is a cpu_get_dump_info(CPUState *, ...) wrapper in
> hw/core/cpu-system.c, next to cpu_write_elf64_note() and friends. That would
> match how the other dump-related sysemu ops are called and keep dump.c from
> dereferencing SysemuCPUOps directly.
> 

Works for me, and it follows other ones indeed.
I'll do the change for next version.

Thanks,
Pierrick

