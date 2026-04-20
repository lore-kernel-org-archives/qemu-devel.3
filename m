Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF95EF5A8B1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEu4v-00029S-NV; Mon, 20 Apr 2026 15:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEu4r-000295-21
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:14:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEu4o-00068V-Rz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:14:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFjhwD785847
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 19:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r6Q5iP8l+VOmEwgdLXY08gPYBdAkIiwYR6tRnou65iw=; b=CIFI/cyv0KFp9goX
 vamOT4UlEwRlVOmthl5cQZ9He2ErgPzPH0cn6EVlcVJZgXgT9lDcDggmGEo3Ajnm
 X4pFmeXFNO7jiKQjnSfp4GiAHK4AgRdZoRpU+4GVqe30wBZZY4oaFGGmH0OryGtE
 jXCVXYomDjHEe3H151XIPN1DhXzScDxVfzVTO5rD3UBl/Sgef5O8/cdDwF0zJ9rR
 sOZ90tNcRz8XIlYaOsjpzLFpPbSMf20l4pnbqaNlkR2c0gjdXOwytaFCFk9JP0Vv
 YRx57AkTjUcj0MXyCOisQOs6dfDirlfA2K/aOy/eeD0rIjayY2yx//4qDgvtZNcg
 MJj0CA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhj5eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 19:14:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c91ef7009so3961124c88.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776712471; x=1777317271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6Q5iP8l+VOmEwgdLXY08gPYBdAkIiwYR6tRnou65iw=;
 b=HpZSwcLgImd2qcMy1dxzA0wj59JTuUPTK3pQ4K/VnSxM2glMy9Iq5QYgJPg/Aodqq8
 plZ8v+fgps1aQi5fXpxFPMB8tQmExr/xqF1By2SMleQkCif/tac455BMKHb8030Owlde
 x8Jd7kWSfcuiE5rmRgX31ap72dFUIzxdhGPM0XA2lvuyLfx7Inkc1j+vveticZ1Ozp+e
 +zhRTxOwo9Ehm2UwfLuU5Gv7K9nIbLRbhYGxCY0KHY7VRfENEyPuvXGZyWRZNaUwqAsz
 PRSmJ4L4utU3XXWL6dLNBJO8DzVd5QGWo74OhG6XLsait+eVnMuo/lUlEpwAf+hZWMaS
 b/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776712471; x=1777317271;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6Q5iP8l+VOmEwgdLXY08gPYBdAkIiwYR6tRnou65iw=;
 b=ChWBpwWN7z0gBerkhka8Kf+hProkIDWSj/ev860aAuGNsKZlC8/8w96ExzuT/iI32y
 tzgghe1Mg8dU9nbnzjqy2b6Gp8d+06WfnnmpbQFQ8DEdc0VnqxznxZFgAsgiQQu7vGbO
 h6GB9mh83G/pbDsIx8P7LF+j1Bd8PGejhmOH0+g+m6Dg4PlTj6vbXO02kzlNOwoEjIx2
 iA795s2DYwNC7ahhrITQ0iNsz2qKPbRMV3y58+sxUtTEQjgUyLMV4bfBDX8Au9GjuQEX
 4uZ8McWi7fN5nqElMTwnACK/0jVyk1ug5HnqB9A8l6F9CWCfDeFLeCdFrLde2581IBVz
 jq/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GpCX2lzwysJvngYGFqs+0ujgxPaLFwESlAzsLC08NNcBAoATOEqxQGeM5Y5p7URMgGVHNYaZ5KkJf@nongnu.org
X-Gm-Message-State: AOJu0Yx/KdUSs0MUlC9NBPMYRQv0kM/hZd/2nPAg1TXzfSo/euS1NbuZ
 TVNwByTIBlveNiuaorJ1cauahofz7b7lNbH/yhSWdss25gW/cHei08jlmquDK6Ks0a24e95gmHP
 MAGuO9YmGfELw6csgpytvRcO6GbAqctui7g0c5ZORB6ui35dYRHSMwC6DVg==
X-Gm-Gg: AeBDieuujMLEr/rj8HQiKT/z/IE8KjfyMHg7hMj+Qhs6ozJdypsSWJCZn5i+vGbVAKI
 RHJAxSDoBE29XTRN1Sx3rfRnwRN3Md5kkM7eNLML8tEV7o9TZr/BWyCdteQnNQDkRwxYC6D19fC
 47kw7At+CwLyE45IfbjURt87ICdK7yBby6+ehpNNgFgwU3maox/+LBYCu6TCawBoLeRaHy2vj+k
 xpUTF31CskEpFeb0ipaVAHeg3PfcRtw2eBtHgLUqlWVBCJqmyKaduBL0KuVVglFLghemtqIRZcR
 KxY7GTujc4eUJSzHm10hc6+dGP1VTpp5NXvxwOIXgr44q6XQJ3eiCAf3Oh14YCJZpNFKFgiKzh4
 7N15TgK6plMxJWnlEq46aSJZxrZFb7/RgKv7AAju598cWcY75xMK4234G3qV+1K+NrbyPePFy9R
 DlxE3+HDSa5+wsqme0UxX32xvS
X-Received: by 2002:a05:7022:f9c:b0:11b:88a7:e1b0 with SMTP id
 a92af1059eb24-12c73fa3ebbmr8814475c88.26.1776712471515; 
 Mon, 20 Apr 2026 12:14:31 -0700 (PDT)
X-Received: by 2002:a05:7022:f9c:b0:11b:88a7:e1b0 with SMTP id
 a92af1059eb24-12c73fa3ebbmr8814429c88.26.1776712470784; 
 Mon, 20 Apr 2026 12:14:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c770516f1sm14669548c88.7.2026.04.20.12.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 12:14:30 -0700 (PDT)
Message-ID: <790916cf-89d4-4b07-90e5-8c29e6f455fc@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 12:14:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/37] target/hexagon: Add hex_interrupts support
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-38-brian.cain@oss.qualcomm.com>
 <ebd8b10e-90d9-4267-b117-9e9a8a564cf5@oss.qualcomm.com>
 <CAEqNhNamfBvyhE4JFp5xDwgB3S6dxN8UnL04-VM2juKoTY2OzQ@mail.gmail.com>
 <67c40737-c5f0-4b4c-afaa-cf466fd7460f@oss.qualcomm.com>
 <CAATN3NqhL8-9tH25jvFz5nRAP_MHh1dfAZREn+9uwqFCLDCttw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAATN3NqhL8-9tH25jvFz5nRAP_MHh1dfAZREn+9uwqFCLDCttw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jfs9m8vlk4oFYuhiE0_ascl2zYSNj9Ip
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e67b18 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=Wv6seG_fQ5iMTRscRQwA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Jfs9m8vlk4oFYuhiE0_ascl2zYSNj9Ip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4NiBTYWx0ZWRfX0kvavAQszu+0
 y1SbdFaG+dR5GFBjFTw06Z5I1q4Wa6PWqsZv9DuisZrScI1QOGFWRa0NAwogA+VomAZ7SYX9jKu
 b2HPXVTOsPpGAZbA10GjpnkNjxdGXp8wg5KVDvVQduhiEB7Nzsv4sudjkwP7XozPNn6nQ46xoWF
 JyJ3gN5D5FFiP2a6g4x+RXvuL7hEsTVftDg/wZixMfDHARu+fVVRHMycSc6T1OE5GXX9gYcTacl
 rlr5l6cPN1gM2r9HgfAx3zC1DuA3+ypa7aRvjASKfzftJg3xvNpQ1pj8jFzD4HsjdHlOrv+iz20
 ZTnQkwjePt4lqhAkTM/+OSDhmqkSjsg5Zcf09n2zpDbVDOJet6rzams7UOBMrnZ5wbKR5+AG527
 70gSBVveaotvLDsPeMI0FTJhvD9voE7rnwU5ib7URh1sOatbJ3beaZzFt2WbgLHAJ/u5DL3r4pd
 1Yi3djELQVaxVHlgmVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200186
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/20/2026 12:05 PM, Taylor Simpson wrote:
> 
> 
> On Mon, Apr 20, 2026 at 12:34 PM Pierrick Bouvier 
> <pierrick.bouvier@oss.qualcomm.com 
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> 
>     On 4/20/2026 11:12 AM, Brian Cain wrote:
>      > On Mon, Apr 20, 2026 at 12:54 PM Pierrick Bouvier
>      > <pierrick.bouvier@oss.qualcomm.com
>     <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>      >>
>      >> On 4/1/2026 8:26 AM, Brian Cain wrote:
>      >>> From: Brian Cain <bcain@quicinc.com <mailto:bcain@quicinc.com>>
>      >>>
>      >>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com
>     <mailto:ltaylorsimpson@gmail.com>>
>      >>> Co-authored-by: Sid Manning <sidneym@quicinc.com
>     <mailto:sidneym@quicinc.com>>
>      >>> Co-authored-by: Michael Lambert <mlambert@quicinc.com
>     <mailto:mlambert@quicinc.com>>
>      >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com
>     <mailto:brian.cain@oss.qualcomm.com>>
>      >>> ---
>      >>>    target/hexagon/cpu.h            |   2 +
>      >>>    target/hexagon/hex_interrupts.h |  15 ++
>      >>>    target/hexagon/cpu.c            |   4 +
>      >>>    target/hexagon/hex_interrupts.c | 379 ++++++++++++++++++++++
>     ++++++++++
>      >>>    4 files changed, 400 insertions(+)
>      >>>    create mode 100644 target/hexagon/hex_interrupts.h
>      >>>    create mode 100644 target/hexagon/hex_interrupts.c
>      >>>
>      >>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>      >>> index 4e9c65f785a..9ae8e104043 100644
>      >>> --- a/target/hexagon/cpu.c
>      >>> +++ b/target/hexagon/cpu.c
>      >>> @@ -59,6 +59,9 @@ static ObjectClass
>     *hexagon_cpu_class_by_name(const char *cpu_model)
>      >>>
>      >>>    static const Property hexagon_cpu_properties[] = {
>      >>>    #if !defined(CONFIG_USER_ONLY)
>      >>> +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU,
>     boot_addr, 0xffffffff),
>      >>> +    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>      >>> +        TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
>      >>>        DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
>      >>>    #endif
>      >> I expect global-regs to always be set, and thus cpu->globalregs to
>      >> always be non NULL.
>      >> Thus why should be check if it's set in all interrupts related
>     functions?
>      >
>      > I did this for `-machine=none` test cases.  It may be overkill, but
>      > there's definitely *some* target/hexagon/ code that gets executed for
>      > those.
>      >
> 
>     I see.
> 
>      > I'll take a closer look and maybe we can omit these.
>      >
> 
>     In this case, we might simply add a wrapper hex_{read/write}
>     _global_regs
>     which has no effect if cpu->globalregs is NULL.
>     For the code that still needs to check if globalregs is really
>     available, `if (cpu->globalregs)` can still be used.
> 
> 
> These functions already exist.  I like the idea of putting the null 
> checks there.
>

Right, check can be directly added in hexagon_globalreg_* functions.

> Taylor


