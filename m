Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B9CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHksr-0003B5-Be; Fri, 16 Oct 2026 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHksp-0003Ad-UV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:34:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHksn-0003Rn-Bp
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:34:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE67Lt2455244
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 24J7vJsaaDGnjnnFjcBSOGYaih9t9/1YxWI1rCNXEr0=; b=ok/oKOQ28GEW/b92
 0T65DRcTaV+sPNcvspvGL4n5PvMrlV3ssaS21tNWRAIMafm0dALWRXkZV2Y99af4
 re3Ov2ibB+kQ01+qa/H9k+Vr638cWxipTivILpCiRkPVbjbh4EZd97AqCQwFRY1O
 w98/7FAdIYmuuNJVFyQUOIhYZIlNNCuJ3Gm/nvCuNJldk3P0jqRmw905xrw9b8Fa
 XZbkZj50uQlu5kI/ve/ukcCFJWUx5WtgPzO447oEar+xQ7YYKlTJT6JjE5Q2oumw
 cZjq1qa3xqdk9HFuGBP7RMkdxLeAAq+c6heVZAwm/s0PC7TRJXsD8Gi9vCgWUFtc
 rkv+cQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yswm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:34:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so51694c88.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792168446; x=1792773246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=24J7vJsaaDGnjnnFjcBSOGYaih9t9/1YxWI1rCNXEr0=;
 b=ESIgaprsKz72mZCJktOIvHcJjCa4wXy39YjID7CjSjnvUeOKYwO5HshIXKXa2rbEZV
 u4iUNR68xk07aTZrVibDZIb0eLMJKLQhvBF+LInPL8FsmiwYHB7hHOoIKRG/C0vAqb/G
 Dg8pfi964DWLgarnP59a8bUpA8GSBzdnsF7uje/AS6lEMfJnKSk7o0tRuPkmUpIsPZAj
 xqW+n/+yGK3E9KeUtiZP8TOh5OQnPGKtRqHO5TS0I84dUSVcADtf8qidmZOoDg+o1UTh
 a7wbNHBng5cau/zByeG99Sdp7v5x55hVF9HJPqyB8zOfS1z01ySP4M6xcYQ+qPXInlDX
 wnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168446; x=1792773246;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=24J7vJsaaDGnjnnFjcBSOGYaih9t9/1YxWI1rCNXEr0=;
 b=W01fdy0PASqIEFssYuB9zCuxpnc+7cgv2OSk/ovpZO7/L8fWtuyyfTBSbbi+e2/03W
 5CrimrQGzjUsfqBcOhYIsA8RuwgrzFiLUHFiVNGZf03flZi0V2DVSJ1StjhTq5iwVqmX
 EUD4VZQvJjDjoioHaD1PpA0q5MCnRtDfJR+ET5oM0kr0o29yNWzQ1hSd8Q8OiiJXydKU
 zQwglgFm66TYx6VtzKJD2sFrHDLUNCX+CLY9YFr3qzx36s2ijpvF30WWn+GE85ZKUJVW
 lkIGRlZw8MP90r4utd4TDlRoL8Gt+slaHYM6IwlYOwEu90FNj+piSG1DsLV5GUh4TVw3
 krWQ==
X-Gm-Message-State: AFq9FYK0yLxwKtvH9sDV0kud0uzjM9r/4Vti/ZUFIuidcIAK2TsI3Puj
 sgkpfvaZ7Qp8dAnHum3gBNdu0xLdDiKZrUjAgnuf5B3On4gHUrUEKJjONPLHqVVveocey7K2Lwo
 OGeSBmwU2xhQUKpx3jv7N+mYtGcwrTjeRcdu1NbyJsJbQCAR+2ltp9Z7srg==
X-Gm-Gg: AYBFou3f9G7lTOQ1PdzQLVl9ju676njlrm7oDklxiw3wGneDKiml0pbdgNaeddXg7wX
 lA9PFSK/LCX0jkz5kx9fwbDtQbtfKzguU9PXVvdgTl0Ls9IlFYAlKxi32AjrRl/CP8DY5dBLebF
 oLXNj6cpFaIqbqx4z3udvrSIQFX7xaQ/4CzVUSkW/PN8+so1tYjO2p6eVqtgCVBCRTKTcYmZtZF
 9FunR2cGjY/4MFkdWTY1RK3cTYtFlJ83zbvpUn3ymHa/fALyJ0poFwvpB+rDVo5lelGeqzJh1QI
 bB+psoTC/QqH+tz/OS2U1JvjNilQWz6TkMSP231fV+p2PVCbDmwVPvdgi+WTXuI3l48WypUrK9Y
 Q8CRtj1HYm60R86EfDu6jBrDuP5ekMaKNCPdHo7Bw564zNEwsz6pg4pGKnzmn83ld8Z3Qow==
X-Received: by 2002:a05:701b:4308:b0:182:6c6c:d876 with SMTP id
 a92af1059eb24-18511ad8401mr485285c88.8.1792168445886; 
 Fri, 16 Oct 2026 09:34:05 -0700 (PDT)
X-Received: by 2002:a05:701b:4308:b0:182:6c6c:d876 with SMTP id
 a92af1059eb24-18511ad8401mr485176c88.8.1792168444272; 
 Fri, 16 Oct 2026 09:34:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ca95700sm6883095c88.23.2026.10.16.09.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:34:03 -0700 (PDT)
Message-ID: <a6f6377c-bae2-488e-9066-665dfb3202d0@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:34:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/19] target/riscv: implement get_dump_info sysemu op
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-7-pierrick.bouvier@oss.qualcomm.com>
 <179214395193.1157317.13842824466744749517.b4-review@b4>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179214395193.1157317.13842824466744749517.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xsHFbOWE7xk-jMb1b5eKhj-2tyyPX8RP
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad25203 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0viEHJbgOdkKQVSH57sA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX1WsKYAe45UYc
 n+JHjyTZtmY3qFa4hoW+CB25EevvUya0KXUGMaBFbNTzwKykAh7NctfD2bUZsmKdnwQ/GIHo5J6
 nIbxAtSUpF3r4pnEKSPHYgjdaSk6RBM=
X-Proofpoint-GUID: xsHFbOWE7xk-jMb1b5eKhj-2tyyPX8RP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX3LgrxR/oaybd
 MCt503K0ykNujcvmdzfTRRlbKjlFI4DePJx7fexphidmWal8anjaDh4ApY7ddr0scEV7yKpyivy
 o2ygafeDRUxjTDB4kiLsSHYeVTBbB99CbtFDA32D9ktoUNemMq+5qrJ5jB6TuzeVko9DVnQ3qno
 ejpNgAYAZxIQMCK1HzQTtmQxRxVJyMowIdhY9F5MNT4x7qX3eVpd33UjNw5ROJZzWr0tqs1dD8r
 h3gsJlv2TAff8SkRQUVM/0qDcr1Fb2QdoRx+XhXkMnubyUltvVOVtaaSiBfHlHQOIcr6qKvvIOq
 j0H2IIBa1pR1Ks5oezYaGkRBYWBJMhBveju56BR2+7w6ggbCIBRbnEDr4ZkbIKxrWzd2aMr2CJv
 XVtLtw0wMkKvNOmy21IO3prpAUTPgaVKDqK/Mn5UK9BEvbMH7AZyeB+WbgGamZ6hRUR7zlFb+Dt
 eco/f5dm+CAJ14ceC9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/16/2026 2:45 AM, marcandre.lureau@redhat.com wrote:
>> For now, we keep the global cpu_get_dump_info symbol defined.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Message-ID: <20261015213236.157767-7-pierrick.bouvier@oss.qualcomm.com>
>>
>> diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
>> index 12b687990702..ac9e49646605 100644
>> --- a/target/riscv/arch_dump.c
>> +++ b/target/riscv/arch_dump.c
>> @@ -20,6 +20,7 @@
>>  #include "cpu.h"
>>  #include "elf.h"
>>  #include "system/dump.h"
>> +#include "internals.h"
>>  
>>  /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
>>  struct riscv64_user_regs {
>> @@ -161,17 +162,11 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>>      return ret;
>>  }
>>  
>> -int cpu_get_dump_info(ArchDumpInfo *info,
>> -                      const GuestPhysBlockList *guest_phys_blocks)
>> +int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>> +                        const GuestPhysBlockList *guest_phys_blocks)
>>  {
>> -    RISCVCPU *cpu;
>> -    CPURISCVState *env;
>> -
>> -    if (first_cpu == NULL) {
>> -        return -1;
>> -    }
>> -    cpu = RISCV_CPU(first_cpu);
>> -    env = &cpu->env;
>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>> +    CPURISCVState *env = &cpu->env;
> 
> can it be const like other archs?
> 

Sure, definitely an oversight on my side.

Regards,
Pierrick

