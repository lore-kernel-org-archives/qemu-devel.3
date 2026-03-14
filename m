Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EFE10854AA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 21:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Ws6-00085g-RV; Sat, 14 Mar 2026 17:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w1Ws5-00085P-92
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 17:50:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w1Ws3-000781-41
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 17:50:09 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62EDq4gJ1908391
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 21:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+63XkoEaA9gLdWdwvb/zxNxF
 GKDQlN+aY47Wfy9Y57k=; b=Dvs/EnmR/tzwSG0Qy82P7/FnLcziNrW0NQm+adLM
 vGidwXIrIU0Gc8h3NIjd3TaKQC1SW1N3uLYXdpY1h0WunO4SYdNphWm6OqyStJqM
 Pu+PGELk6RkvZ4h+v12z58d/lIbUTK6JcnkGLVfI+4ci53/od9++BWfqNzqhVjhO
 sHI4MTHNLKkizuOebQXRrOG+mZ+3KjkkNVMQteQCAiP9TO6A73dfpoUpyctGB7Kq
 +w8JZPV8gocJLXgRQ6DpjzV7KR5Lq6HX95VLF7xzxVDzX9B2aKLFEO20xsFp42Mm
 GdmpxUFl3N20AmkYtK0PpoJLDPNg5hTrXDcvmJcwWvrHgg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xhgsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 21:50:03 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-794c39ea759so11014557b3.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 14:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773525003; cv=none;
 d=google.com; s=arc-20240605;
 b=E8+jXmoBRL4+QhCK1pmmjv/gyBb8F3p/4V9zQMsMLdGCZD6dlVKgvZDlLUvXkoERxI
 XG7FKe6+418Md7fOI4b481ZacXTv9JNnwSX6h69YC9zVUPtqMLlYDcMOJ3JPkkT0MbWP
 9VdwhJYjTTOwilwOVFucCc1W1YM4kCv/bJN7+J+fOEsTJ9crUKg7qdLw0fBC+uSywbqE
 FrbXKYWAAm+JAeigZkcgDvlaPzU/DiG2sdBmFOzt/nQoQLkX5TrUhg//qXBwmVnzUvW0
 0hHxpPPD6g2OjQwzQcAH95KyHyOvyst3UKIbE3QjFJcB6jYIbGHx0/gIMGgS7FSmNPYP
 FJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+63XkoEaA9gLdWdwvb/zxNxFGKDQlN+aY47Wfy9Y57k=;
 fh=uV0EhJYM2i9jJGd+E+t12qwhXF+jC75b45QOXLh37oM=;
 b=FfVf7Z3J3VVmwXF98WnFxrHKFt58zxj3UYy2xxlRWldhF1McsU47g7YASC2yoMl7I/
 F5Gpd8nYhIBOIZQcCIPnPeg1HVn65Xx6mnLDsHtR2+XO81oeGZojK4dobDlj3F5qOshl
 LiW7/S33u9mdzeShQT6x+s9twIqhPKQGIgBlHwoL+Bp6MhGRMjZ1RT6wbHTffJ0oeiRU
 INpmsV9CrcrgPCTSEpM9AsqeC4dOIbTtfCwWiVJUXkWIyanpJn55kmahSVBAoLWQXQog
 9qOIBdxZPMgEPRfS3s1CY+OBKNtv2P6o/y3WdP8SR4s6XkBAgIoAcdYxrJuHI5Thy8eu
 2fkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773525003; x=1774129803; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+63XkoEaA9gLdWdwvb/zxNxFGKDQlN+aY47Wfy9Y57k=;
 b=G2szTrSjAD7giKpeTiCPhPBrwk0GlWW7A+f5iEozJYA2eZnXvRoMIqOtzJKi7hSAdc
 phPqj8ITrDMsyQlj7ABDJTKkQoPOGxaHiiNth1KBrgXvcv0nGTVjZFM3XyeOXPJnnEoZ
 x7IdZ6mLZVOq3RnyHwJTCUZdkqdF4zZ5dN3KAq7aZjX6o1uC6MDTJc/XA9WoEbL1VIv7
 0YXTzzYNEazBxhyWfo4E6/0F3EFmPY0GMcDeRiVNDxsdWjAEHxqV2iP0ISkHp8BUB4ez
 /KfsGcgs/hFtJxGRJ2NQLlz+oxOzGCnH3YZ53FXiZrv6P9XSmngQ2qxBbY9WCEQYCxGK
 2Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773525003; x=1774129803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+63XkoEaA9gLdWdwvb/zxNxFGKDQlN+aY47Wfy9Y57k=;
 b=ae+O4Hk/uEQwaPDe5gWzhQRKGlFJpIJMFkyDpDvTJPOTFKL8A3KJFJ5RbPaVURR7k4
 f0gUWmldmhgiw/4mCk3/OHz4zZpOvnslwt/7n+Xp/KMa2N/pHVtqmzxmAWjkv7kWELSd
 9JFDvlPaJ9j7/r9pxCCEMuQYTqJdPcPTiRe0zX5wZShlZVFBvhtzIbdnuTNd6Fx1lhPr
 O6Eb3nwDDPGxNT+C2H1W1k75NAZ1OWq4v8U2EIEWg3cvNiaEC6bXGK3kjNIDCWQSUW/N
 qopbbOgUundTFQWWOj23GtANNJORjK7cq+W1c+5V6cp2MaMwlWrajVtyt8sGOFtIRNET
 AxcA==
X-Gm-Message-State: AOJu0YzlOao0oyj6Kd8YPMqCdRyAtVyfw9z2XBONiMBNSmTvY0RRZAXI
 qgE8XfLXcBpyd5/hP3mv+5aG+d4Fqaeq/Vexrawek/XXcCyaxbxNyrjgP0xh0kPEwdlZh8FMptR
 PkltmG7lp9nnYCSlpZHj5uScEsR8LQptzITdY7ofVKq3VlNAmVljRfAZTt+bjSJ847LgUiHssLd
 ZI5UGM67SOcOatdeAqQdOQCx96DVVr7o2k
X-Gm-Gg: ATEYQzwHsf7XiiaXUXIlLNvs/WiZSYM/Kd81PYOgX02tRvjuK6tL9Ed0ypoz/COJMq6
 EPrD5SCZR59kRh6ta0wrNj2i9h2LuchkN5sfTIU7pRtT01onk4EygWLp8uFl1IRmKIcU6Uqr4Ej
 /FcqHP3fXVQnWbFCmsLb/6Gi4LMAl1qx1kK1r2Fm0boB6SJpDyuaIFtZmmCdSCXHY/JuVPu+Lvg
 n/qwqE=
X-Received: by 2002:a05:690c:3482:b0:799:182:17bc with SMTP id
 00721157ae682-79a1c0fcfe9mr83333087b3.28.1773525002861; 
 Sat, 14 Mar 2026 14:50:02 -0700 (PDT)
X-Received: by 2002:a05:690c:3482:b0:799:182:17bc with SMTP id
 00721157ae682-79a1c0fcfe9mr83332867b3.28.1773525002458; Sat, 14 Mar 2026
 14:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-4-brian.cain@oss.qualcomm.com>
 <CAATN3NoSdHEuK1LsT4-uGKmFgxFxSYQoRPSfjv7EKX1bVaWSuQ@mail.gmail.com>
In-Reply-To: <CAATN3NoSdHEuK1LsT4-uGKmFgxFxSYQoRPSfjv7EKX1bVaWSuQ@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 16:49:46 -0500
X-Gm-Features: AaiRm53cSoWUETerhs0EWVRxefM240yTMjs40uuRffebtXuCd2UK9MX_ay-IDc4
Message-ID: <CAEqNhNZafqvXkUedDiQ5wweXKftVMruT+iV-dcR8krtQRMRNmQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/32] target/hexagon: Implement start/stop helpers,
 soft reset
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000c5a519064d02f74e"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3MSBTYWx0ZWRfX5vCiqHVqfGmn
 Ke3NC6CEXFRsCH/EdL84dVHHWDP37qXsbnwKyMh3JnnOZPMgje/xjf+P71xqAe3cIrMAGGrOtZ+
 VKppkwwNjup87R8JNplQ9sT9QKNz4OpChSaPy9CR+dD9VWqE54Xum4sKFt5GrUOijZwFv8kT7yr
 5dle4zQxdN3J3re/JHSyqc3HK6gtcPmveOe1ipB1oxD94+4w+l9muP/ABqO2qp5JXriHghnsed6
 BIZD2M0Fa52LldMIMd5R6Dk0+vszScQGHR96RZA4Vlpkn5egYKnBDvxkPevFMAgq7BFSwFY+XnT
 +aHGJBLhCezQOE4RiO5a8WnGdPx9psaPiCCykKb9/wJs3JI+Hl5Jt5Qn6kmt3uLIOuQtUxZlHoO
 cf4QTED5qP1GfVAnqmgWeWHY7y7YnPosFWcDHxibN5HeVa33BalA9zRW2abWxo4HW5UVQ+HQbDV
 QPX5zVUsDLLpmEndbww==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b5d80b cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=Xe-I7zIvwFLMbydv7v8A:9
 a=QEXdDO2ut3YA:10 a=gix-R8Ezx3thgWqUWU4A:9 a=FwCa04tyMUwWuP2j:21
 a=lqcHg5cX4UMA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: __dkXixjoUGjhsvDMhMa5dw4sXm29giH
X-Proofpoint-GUID: __dkXixjoUGjhsvDMhMa5dw4sXm29giH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000c5a519064d02f74e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:37=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

>
>
> On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualc=
omm.com>
> wrote:
>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  target/hexagon/cpu.h        |   7 +++
>>  target/hexagon/cpu_helper.h |   3 ++
>>  target/hexagon/cpu.c        |  26 +++++++++-
>>  target/hexagon/cpu_helper.c | 100 ++++++++++++++++++++++++++++++++++++
>>  target/hexagon/op_helper.c  |   4 +-
>>  5 files changed, 136 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 0017be9dff7..1a3c9014455 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -207,6 +207,13 @@ G_NORETURN void
>> hexagon_raise_exception_err(CPUHexagonState *env,
>>                                              uint32_t exception,
>>                                              uintptr_t pc);
>>
>> +#ifndef CONFIG_USER_ONLY
>> +uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
>> +uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);
>> +void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_=
t
>> val);
>> +void hexagon_cpu_soft_reset(CPUHexagonState *env);
>> +#endif
>> +
>>
>
> The first three above belong in a different patch.
>

I'll fix this.



>
>
>
>> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
>> index 6fbf5fc8e2f..c251790e5a5 100644
>> +static void set_enable_mask(CPUHexagonState *env)
>> +{
>> +    g_assert(bql_locked());
>> +
>> +    HexagonCPU *cpu =3D env_archcpu(env);
>> +    const uint32_t modectl =3D cpu->globalregs ?
>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
>> +                               env->threadId) : 0;
>> +    uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modectl);
>> +    thread_enabled_mask |=3D 0x1 << env->threadId;
>> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E,
>> thread_enabled_mask);
>>
>
> Do you want to set modectl when cpu->globalregs is false?
>

IMO it's near meaningless to consider what it means to be a Hexagon DSP
when globalregs is false.  But since there's tests that exercise the "null"
machine configuration without anything connected, it doesn't always make
sense to assert globalregs either.

So ... sure - I can skip modectl or just early return, because ... *shrug*
what does this thing do without that integral piece?  Who knows?


>
>
>> +}
>> +
>> +static uint32_t clear_enable_mask(CPUHexagonState *env)
>> +{
>> +    g_assert(bql_locked());
>> +
>> +    HexagonCPU *cpu =3D env_archcpu(env);
>> +    const uint32_t modectl =3D cpu->globalregs ?
>> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
>> +                               env->threadId) : 0;
>> +    uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modectl);
>> +    thread_enabled_mask &=3D ~(0x1 << env->threadId);
>> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E,
>> thread_enabled_mask);
>>
>
> Ditto
>
>
>> +    return thread_enabled_mask;
>>
>
> It's strange that set_enable_mask returns void and clear_enable_mask
> returns the new mask.
>
>

I'll rethink the interface and review the callers.



> Thanks,
> Taylor
>
>

--000000000000c5a519064d02f74e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12, 2026 at=
 4:37=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.=
com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cai=
n@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Bria=
n Cain &lt;<a href=3D"mailto:bcain@quicinc.com" target=3D"_blank">bcain@qui=
cinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +++<b=
r>
=C2=A0target/hexagon/cpu_helper.h |=C2=A0 =C2=A03 ++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 26 +++++++++-=
<br>
=C2=A0target/hexagon/cpu_helper.c | 100 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A05 files changed, 136 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 0017be9dff7..1a3c9014455 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -207,6 +207,13 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagon=
State *env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t exception,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uintptr_t pc);<br>
<br>
+#ifndef CONFIG_USER_ONLY<br>
+uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);<br>
+uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);<br>
+void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t v=
al);<br>
+void hexagon_cpu_soft_reset(CPUHexagonState *env);<br>
+#endif<br>
+<br></blockquote><div><br></div><div>The=C2=A0first three above belong in =
a different patch.</div></div></div></blockquote><div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace">I&#39;ll fix this.</=
div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">diff --git a/tar=
get/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c<br>
index 6fbf5fc8e2f..c251790e5a5 100644<br>+static void set_enable_mask(CPUHe=
xagonState *env)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(bql_locked());<br>
+<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 const uint32_t modectl =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_MODECTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modect=
l);<br>
+=C2=A0 =C2=A0 thread_enabled_mask |=3D 0x1 &lt;&lt; env-&gt;threadId;<br>
+=C2=A0 =C2=A0 SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E, thread_en=
abled_mask);<br></blockquote><div><br></div><div>Do you want to set modectl=
=C2=A0when cpu-&gt;globalregs=C2=A0is false?</div></div></div></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-family:monos=
pace">IMO it&#39;s near meaningless to consider what it means to be a Hexag=
on DSP when globalregs is false.=C2=A0 But since there&#39;s tests that exe=
rcise the &quot;null&quot; machine configuration without anything connected=
, it doesn&#39;t always make sense to assert globalregs either.</div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=
=3D"gmail_default" style=3D"font-family:monospace">So ... sure - I can skip=
 modectl or just early return, because ... *shrug* what does this thing do =
without that integral piece?=C2=A0 Who knows?</div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div clas=
s=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+}<br>
+<br>
+static uint32_t clear_enable_mask(CPUHexagonState *env)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(bql_locked());<br>
+<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 const uint32_t modectl =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_MODECTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modect=
l);<br>
+=C2=A0 =C2=A0 thread_enabled_mask &amp;=3D ~(0x1 &lt;&lt; env-&gt;threadId=
);<br>
+=C2=A0 =C2=A0 SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E, thread_en=
abled_mask);<br></blockquote><div><br></div><div>Ditto</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 return thread_enabled_mask;<br></blockquote><div><br></div><=
div>It&#39;s strange that set_enable_mask returns void and clear_enable_mas=
k returns the new mask.</div><div>=C2=A0</div></div></div></blockquote><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-family:monospace=
">I&#39;ll rethink the interface and review the callers.</div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div class=3D"gmail_quote"><div>Thanks,</div><div>Taylor</div><div><b=
r></div></div></div>
</blockquote></div></div>

--000000000000c5a519064d02f74e--

