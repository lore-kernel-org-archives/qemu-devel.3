Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86821CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIJy-00005V-I4; Wed, 27 May 2026 13:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSIJo-00004s-NO
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:45:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSIJk-0005ru-Vr
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:45:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RFJHE2879279
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 17:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wr2ZjJtK5lMWZN8QoDC54/b3h3TAqigryYp7dGPtKg0=; b=o9SPrLdIZkwX1Nxa
 WEQlVEdVIFcuS5dVvPDFBM8s6hmjDyqArPF/mNJbsxiAmoPxJudOT81uH3g/owhc
 dwXrLUf2dFF9ld+NpK9T1piGiIFfoYC4cGfyWCC3V8X4s4NDUJlwkegG9nVB26VJ
 R8trImbXBmsD7/4NywX/uvabtWZQh/9xfKjye8i6qcoTt6g6gHbQP1OLh6gxA+IS
 H8w/yHMgJK7V0rgl5au/ISS76+0yARDEnafJMiLoeJaHG6H0+ycbCtMoieDB6HND
 7ZFXfBAPLjJUXtZLp87fPV0zwDaPEsUyK/+IJvvEmkkmdRudo2delHoiSrTuIEY6
 Q2kkVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edvvqt87d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 17:45:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5104b861649so33464871cf.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779903918; x=1780508718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wr2ZjJtK5lMWZN8QoDC54/b3h3TAqigryYp7dGPtKg0=;
 b=I50eZLMvQ9nMdxAVYSmNxgcjdm+aWCHIsjQOPo5xGTVIl+IdU+Of35+oECZI/Wu8t+
 lfLa+Gcdi/3UvDTgCuAZ1Am74JI6TxpP4hlPePg5Q+2HIwkTWFnN7kaC54WJZX5AgfFC
 yW2Bp2gY/cimZiVPZRTdMFLQRSys94ukNiJlKyWKpgjl2Xx2bDm2Fw6kAdwTM2HCR7/L
 hZ69heqo8c1aQeMZ0hGwOwRpqgJc7O5xEs1O66fb1kUhYXFiauARhJusDibGGid9H52j
 /sqCYeexVblE1GZ+J5XXtaDiQq3rvs+xsLCWIGIn0xL4jmLf0bMtsG8JfLK7CoSwhU7W
 TrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779903918; x=1780508718;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wr2ZjJtK5lMWZN8QoDC54/b3h3TAqigryYp7dGPtKg0=;
 b=SKocKqU0Y22JA0CxW0RfaLwBRgxgnqXI6iyUclKkRNiTLve5i9bIvpo0jYpysQIlUD
 b3KdM/RmJkt/RuLofH3qBG8USc+mjuOueEdySHaCtcBCe800hD9wtrNhn3UvRvBIITkU
 uA2m9ciixxEVE+P8rWi1nZLfoMLBef8CEBxZsSPYY2SoXYGPj3nNOYjqc1BICGDbpRCX
 1d5gRbGwwQjuXlsSUbmtlYyts7Y/rTZaoWjoIKfmfBu6VZa55T7onDtJ6U7U1S5zNBx6
 YXtHHhSerTESzRsuaLRFBWRCqWgkRkNAGxKU+V8whSItl27TUMiiLMTGGAS1K1HLDwSV
 rJqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7eNowX15azfbKnDKnWb511AaatQsDtlAi3g6W4+DUXqwzmCUazdLoYjXTOjgw5Xqg+Z1DsE4oRftg@nongnu.org
X-Gm-Message-State: AOJu0YxUPUTRZ6dtve9OwKqP7PbWiZBrEaYbmLlYNccQDXlOHnFL0IPZ
 2LZnez4sBlblHQZ27+7B/6bu4MfGmifp71TSQz5SibHAMHC2a5Yt6cpPMnvypN3w9uhMeM2RSZU
 W4RzRHAipcOvYFsOHI3BYCl9SGwmzUZTU5UBbK+G/gxAwFq3/qg66Gj0few==
X-Gm-Gg: Acq92OE+/gWXknjY820aK/gBp7sMrI9WC66KWZTPaNUmyJjSMGFVYGVRRBITJ11uiTF
 J1ok+gG6PnX3IhCbyR8UktNIDJZbToI/vtx/MQDbRr2ISZk3Ca7o1+RGZrEYaOTvll4M3Igij5r
 4XiZU/yV8MPlaXgiH2RDa17YqKCg+unzhVNPclvcxFOId/k/H5bhcidfj14F9hqn6d9vBdhppXN
 3Ih1kRZ69zPztCA++ugYAHWfl/XbB016ss2WQKhTjIarUPLEqVbQR+5khcSuSkT0phbQf6pKAGn
 ThQIX0nO3fK9XwZC+f51nopX0qCrFBehpQ701JAwdTx1GJCkreMYvfZmxaT3Xp2ztfGzkcVKDdZ
 gIkLpfgFefV9AFff9VMo5FmSBAmNN3qdN56zUNaA6kG+D8GLeLSYSXuK8ZduuTlI4dxKb
X-Received: by 2002:a05:622a:1302:b0:516:e517:6dd4 with SMTP id
 d75a77b69052e-516e5177088mr241280361cf.6.1779903917755; 
 Wed, 27 May 2026 10:45:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1302:b0:516:e517:6dd4 with SMTP id
 d75a77b69052e-516e5177088mr241279891cf.6.1779903917288; 
 Wed, 27 May 2026 10:45:17 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706a28ddcsm54337161cf.13.2026.05.27.10.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 10:45:16 -0700 (PDT)
Message-ID: <40760834-c2e9-42d9-bf6d-b53cd2444de2@oss.qualcomm.com>
Date: Wed, 27 May 2026 14:45:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 14/17] error: Use error_setg_errno() to improve error
 messages
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, qemu-riscv <qemu-riscv@nongnu.org>
References: <20260108070625.1586474-1-armbru@redhat.com>
 <20260108070625.1586474-15-armbru@redhat.com>
 <ce1ce1bf-c983-4993-9873-11dc3d17b68e@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ce1ce1bf-c983-4993-9873-11dc3d17b68e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3NyBTYWx0ZWRfX80ZnUia4Emfj
 SS+jZKzjhyO0ecCznJdUTdOZvmOTGbvUoilfK0Oke8EDzGy5Mx3ALLQsztW7XJBQkyWwRu9xeB6
 HOgu1+mWmSfn2r77Bg+FonfY2FSrpaOPy7M9OkteYHEOJusxSEUaQPOvUeivTcsgxAGlyJDwwAv
 dV0bdiOZWCMoLjbDPumQSpzNiFpdqH23Azj8w/GRnWyW8VnVpZAhCT+aRmyjclRHY56lcGg8PyB
 LbOVXrWyrCjLKvP6eB+tCcgk3bVCawmxY1Dp29WNVD5LFwRvznQJiELIwABXyT5ZyUXzOSYwnir
 nlJoBNo76D0bgFdXLeriXrPr9i23ZJFuihO7FnY4ER6/+ANtcR1gs4eKMJ60x6DT7rqhI3DTjyV
 qvTHjQmWZLQlA8kjmrijUhnDg1oXC+ma5tqxVYpBeDFuPKNlh1q2q3sxQ0xvE1/IhNKVYYEj/dn
 Ym/5zaF4TQZO83rCeNA==
X-Proofpoint-GUID: xzwX2WjYX8BEnLaI9k8fVpx10EFtZ6oB
X-Proofpoint-ORIG-GUID: xzwX2WjYX8BEnLaI9k8fVpx10EFtZ6oB
X-Authority-Analysis: v=2.4 cv=fLMJG5ae c=1 sm=1 tr=0 ts=6a172dae cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=JF9118EUAAAA:8 a=9qUTvQc-AAAA:8 a=sBiGvwp86dGF7VfcGowA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=DN7SgORnOiO7RqxRx1GC:22
 a=cvBusfyB2V15izCimMoJ:22 a=xVlTc564ipvMDusKsbsT:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270177
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



On 5/27/2026 11:59 AM, Philippe Mathieu-Daudé wrote:
> On 8/1/26 08:06, Markus Armbruster wrote:
>> A few error messages show numeric errno codes.  Use error_setg_errno()
>> to show human-readable text instead.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Message-ID: <20251121121438.1249498-13-armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> [Trivial fixup to riscv_kvm_cpu_finalize_features()]
>> ---
>>   backends/cryptodev-lkcf.c   |  2 +-
>>   hw/ppc/spapr.c              |  6 +++---
>>   hw/vfio/migration-multifd.c |  5 +++--
>>   migration/rdma.c            |  3 +--
>>   net/l2tpv3.c                |  6 ++----
>>   target/riscv/kvm/kvm-cpu.c  | 10 +++++-----
>>   6 files changed, 15 insertions(+), 17 deletions(-)
> 
> 
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 5d792563b9..b047ffa9c0 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1996,8 +1996,8 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>>       if (riscv_has_ext(&cpu->env, RVV)) {
>>           ret = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
>>           if (ret) {
>> -            error_setg(errp, "Error in prctl PR_RISCV_V_SET_CONTROL, code: %s",
>> -                       strerrorname_np(errno));
>> +            error_setg_errno(errp, errno,
>> +                             "Error in prctl PR_RISCV_V_SET_CONTROL");
>>               return false;
>>           }
>>       }
> I thought we had removed this one with ce1992d45c8...
> 
> Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Date:   Wed Apr 24 17:24:25 2024 -0300
> 
>      checkpatch.pl: forbid strerrorname_np()
> 
>      Commit d424db2354 removed an instance of strerrorname_np() because
>      it was breaking building with musl libc. A recent RISC-V patch ended
>      up re-introducing it again by accident.
> 
>      Put this function in the baddies list in checkpatch.pl to avoid this
>      situation again. This is what it will look like next time:
> 
>       $ ./scripts/checkpatch.pl 0001-temp-test.patch
>       ERROR: use strerror() instead of strerrorname_np()
>       #22: FILE: target/riscv/kvm/kvm-cpu.c:1058:
>       +                         strerrorname_np(errno));
> 
>       total: 1 errors, 0 warnings, 10 lines checked
> 
>      Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>      Reviewed-by: Thomas Huth <thuth@redhat.com>
>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>      Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>      Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>      Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Just curious, was https://lore.kernel.org/qemu-devel/20240424094700.453356-2-dbarboza@ventanamicro.com/
> never merged?

Hehe seems like we didn't :D

> 
> Anyway we are good now.


