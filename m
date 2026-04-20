Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C88F5A8A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErwl-0004kZ-9o; Mon, 20 Apr 2026 12:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErwj-0004kA-Ew
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:58:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErwh-0003wx-Pa
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:58:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KAvYKr3015375
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 efCJJ1CYyU7LnnnVOM3l/OUM0go681cI51T3+cnHC2A=; b=F3BIZDek/XBQrXY7
 j7ASnKt6uHmkdz3zeJ5nN1CwBOsZAElHy/LmKg89boF+XJsefpKVX4HqBvTXHfGX
 AHLciiJFZMKHFYbLV9CK8mElRuRxJPjb9/gMNM1uRuUXUrnsq2aG8cGbV4AoN8S6
 6pIcRy5vYi/9HwrNo3tsOj7Pze8ob6B2qy1fU4IY6V03oxumy+yLmta6/1/uFzbN
 5I3BpNYY3f4Q/9Fpua8I25v3Fe4Fox2lt8XlRYNIyZNtlSc2lQNwdWoGZ3CjXSj8
 c+Er1K+34CGryqVS+s+7RmGea7SE2CQN7qIrqjaX7GVKDebEOgA3x4w6xMC18T+2
 /x39iw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnjuksaky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:58:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso4091145eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776704281; x=1777309081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=efCJJ1CYyU7LnnnVOM3l/OUM0go681cI51T3+cnHC2A=;
 b=QUfS+SuUHr/rvQDVs3GFzz8AbA9bpP3fDQj4PvOCoVhd5QB3mXskWTUiDxUinhJsO/
 Rl8WKtCLXHbTXwEn9SgxPQfrWileihgh1eYFRW03wElzR3BHL0cSG61Tg7c1mBZ/0INp
 ge3IFJ6NU8PIANwKqkGin0O9Aptzl51QvoGRGUGcTvqI4SaL8NqsjdWlCZfPbfM64Sa/
 okOkRiH1RUUOyQ2iOxAq0XHlIFV4XJ9ln8E/NjxgovSputnNiQGOIiIgPCGpcz4hftSs
 0LBF7lfViyBZnS81xK/ynkSPI/qHyrlEM5blzKPjXs+CgLpgc6rz15Ko8OEqDm79SVY2
 sXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776704281; x=1777309081;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efCJJ1CYyU7LnnnVOM3l/OUM0go681cI51T3+cnHC2A=;
 b=pe+A+EA9vCx8peNB9AKJRY32xqJPOGqSui8sCZZHBHXvqAB/rcrYbMjkyK9y3SBY9m
 jJGK2uSysPSH+hlUr6VtDuv1Uzs5+6dgz8mrZLkyikwRNX67TLxEdDD1JpSj5L24UYNp
 lPtVrN8QKi62sr+4aAVLZZYBLap3yLt64cMqmYlX9lakwFhZ86Kpr4ZjgmF/4O2oa5Jl
 lf5Uk1dLHmUMrx9VagVdIyYnxWVzO2hKQ5pSFRsxkmLDKsPTaF0xik+JeuKpNuHWXcI7
 e7H8KWqYFUkg4FxVrhSbxAIl9s7IHYM9xy7sRIFftePZ5EPNwwhetxu9/fgzwjNPrR0z
 lR2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pKpacdihveQi+5trbKSewbmDZ86zAxGCP7HjDZt9aOvURAsRkpSF/0fkGLItUHD70sXrSdpi9eJKL@nongnu.org
X-Gm-Message-State: AOJu0YxIrXEkyAcQMPsXRX9i00IT9bWTncTkKM+cr54Kvfnqpgk1w06i
 v4fdBf/dulRL50YL7LZ3r8+K76OfdXaMwNgtHJMF0oFjxgRDwu6d2nDTam9/Nad21UaMKahio6C
 JGfbsL/w26SrtA4HsaSJxp/XLkVSYTrGws40//PnYZh10ZgN7Oz4jWPpIrA==
X-Gm-Gg: AeBDieu7woQiSDyk8er8Y3pXvtY7t3gJkeHaZOwZ8D3Tt0MHJdRGzX/mwhKmvWc1LDg
 U7XOUaXi/23MiRm9tH8AwXPBlf7vMbtw4NdEet0NbbsaMZYu+tGeApUphoYvQU74lLC1ciqoyyT
 3VoyPqNYTZ2fMc/gyt4AjL+eRXuyZ5r3AKVDlTBVlK+EQiT1fW5FJMpWvTDDnyB+cM8Ic5zNYJR
 aK1d8vtKqllM91gAWUlgZ96zg744pxSEtoYoZxiBH0cuAVgM0GABYmAU0Vwg5mUi+OxSgNgWl2q
 FuxGryTCFStWBDyeGHWlzNenzyYsj3w42N+lMr0gG4bTv5Hg3KgmXm1T+H+xpK/5U5X0IAwUwOj
 iJSqsvxX2uxg5tS9/fOvVGjv2gab1os7b3zWARGTmLngiQ/WbDzRELcQluxW6gk+5ZJM+fYgSvp
 lJq3a/X/2OK852aIutx2V8HSQC
X-Received: by 2002:a05:7022:3d87:b0:124:9fd8:4ba9 with SMTP id
 a92af1059eb24-12c73f6cd01mr7549097c88.12.1776704281418; 
 Mon, 20 Apr 2026 09:58:01 -0700 (PDT)
X-Received: by 2002:a05:7022:3d87:b0:124:9fd8:4ba9 with SMTP id
 a92af1059eb24-12c73f6cd01mr7549061c88.12.1776704280792; 
 Mon, 20 Apr 2026 09:58:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c831d5b29sm12722153c88.8.2026.04.20.09.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:58:00 -0700 (PDT)
Message-ID: <4e02874b-214b-406f-97b2-af7b78368a7e@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:57:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] hw/hexagon: Add machine configs for sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mike Lambert <mlambert@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xXJz2kdgWz6-Xe1kpnkmZnay_B0PYQ2u
X-Proofpoint-ORIG-GUID: xXJz2kdgWz6-Xe1kpnkmZnay_B0PYQ2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2NCBTYWx0ZWRfXwExSDBKBA8+4
 W6fIwu8Np+ik705l/s33bt/5LyOnmwVUZwMfOhlHUknmJndl3biCQgVLao5es6T35ALZn+fjSzK
 s+ZbxOuw+a9tmndZm27C+SLG2kCW7C6Qp0iHx24U+9KK4dN69VuJNt9qg9UnYBn3r1QtWYlqcd2
 5BpxQzszCMgGy05leuW9nm8tNgb7AdGtMU0Mjberiv21fPZmXQ8kapHarZHPqSwU5bYQmd/+iCX
 GfHqSJUoGcLECYeTzvZA3F0NMxNJsD4ogRiaB4wTK8lLOWvuA0xpVZ7/Esr7z5j1+CJcD4qUxJD
 KUCJOH0wjJoy0/79Z2t+IHY1s3wFWhppY2MjY+o6BHIMxZHE+/+mKQweWVb8yMyzBLMvI79yIIo
 hzly+G+zwH2tDRJnQLfyqok5OOryI9mKSixC8LAnsJ6dbZWs9wjiTjeyvGD0IkBHkox/5YiLpZ+
 30ZUrnlbInHW5VLLrYw==
X-Authority-Analysis: v=2.4 cv=WuUb99fv c=1 sm=1 tr=0 ts=69e65b1a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_VBVod5Mx91-bRSl_JMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200164
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

On 4/16/2026 2:02 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Some header includes are modified here: these are uniquely required for
> basic system emulation functionality and had not been required for linux-user.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                            |   2 +
>   include/hw/hexagon/hexagon.h           | 150 +++++++++++++++++++++++
>   hw/hexagon/machine_cfg_v66g_1024.h.inc |  64 ++++++++++
>   hw/hexagon/hexagon_dsp.c               | 161 +++++++++++++++++++++++++
>   system/qdev-monitor.c                  |   2 +-
>   target/hexagon/translate.c             |   1 +
>   hw/Kconfig                             |   1 +
>   hw/hexagon/Kconfig                     |   4 +
>   hw/hexagon/meson.build                 |   6 +
>   hw/meson.build                         |   1 +
>   10 files changed, 391 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/hexagon/hexagon.h
>   create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
>   create mode 100644 hw/hexagon/hexagon_dsp.c
>   create mode 100644 hw/hexagon/Kconfig
>   create mode 100644 hw/hexagon/meson.build
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

