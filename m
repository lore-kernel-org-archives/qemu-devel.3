Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A324ECA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDq3T-0004xa-Hr; Mon, 05 Oct 2026 17:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDq3K-0004wp-FY
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:16:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDq3G-0000V1-Q9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:16:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KMkqc1535308
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m8JjuJh/ZvZqZEs0TeCHaxW01GTrIJ9y1bAGshYwyqU=; b=MwxAeCaLowRQU3ky
 JvOT5jon9WBJjB3BYKu7C6e1gxmY6eGmjQkOSn0aquEjtugpJYk7GtMY7FXnFOju
 ImnHkrG15WFOyv3Q8zje9Iiq6b7VLT5NkG2gr0t24bGOUyQGFryC1Rx/OBC6ATDw
 2Ev8ha9GI6gZOWl5xtA+MitUesLhPCoHpOnT48oq2eux2yR1dapss+8VBpiYEsZt
 lhpYi+iXV3kXz+9u+XcRYvmVrZ9TUz784IY619/3rwebzVPYg82ydXHLYttpE88B
 /JB+LQocyMHLK/SGfSujcmekVGr7pK716MWEGqfCXM2B/xT9fd48LM1K4APrmpcI
 xP1K6A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dnchj7p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:16:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso3454397c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235001; x=1791839801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8JjuJh/ZvZqZEs0TeCHaxW01GTrIJ9y1bAGshYwyqU=;
 b=PI56isNGwDHqN92KueasJLNnMNVhrJV4Uy7M/XVuIx5or/84NjVueTA04+uUBwQ+I0
 ryaspUpcfvhQSO7gGTyTSAlyHC1kYVS8tjk+eWqx9AZ4miU4iJYv8rZ9cblvAPULVU/y
 Sg5F63nbj/PBTHQSs9OOlzyHm6/ej8/IC4MlwxGSNXDPv02pKVn1K236GfCsD/Y2/nCd
 GNxlr6/hY/0tGlr/jlTisnbghkcmhUdqne3OV+ByHJh8Mwyu5StBU0YbN9HLUym+LhhF
 S1uOFSxEjo/L1kmRwBY1ViIaHAQBsYvGnojerOdwYVhgxJLcbRxcCKMUVfcI8GOfPNQw
 pBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235001; x=1791839801;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m8JjuJh/ZvZqZEs0TeCHaxW01GTrIJ9y1bAGshYwyqU=;
 b=etUF9/kgEK7p7jwiNCCtCyxGFyIKow4yolWBJceL2K+pndRdwjAC/EmXUkKwEz5EhJ
 8/fCgfE1eQ5LMXbM+oYuGntRrLwYYl1OGw3jDhxrv5lWKTz7DwM7mlEXlXQZdh2hVDUt
 BiicTQ13MEncX5U/1tPtA13yqvwWIzS0H59RuHawGLxs4ge4hn9984M0H9YTthMUk3NA
 CTmn9vlrvuOxQCiViobsVOhgHfgr8RNkzsgWVDOFBTeamSbkZD1gYob0K2nusRfVmsj2
 55SuN8id/My1mizHrUxOFX45Ppq+IFcJ3NdFGSV9o31vZo+CH0e4/apFJH/g+jildgTu
 wwaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4O2M83iIy5bl3ZCaIeYf0XBZnWJdLv7tkTJm3nP0cU8DTREmvZ90tp+Mq4tvlwIsjflT3tcpJ/EGl@nongnu.org
X-Gm-Message-State: AFuF++mcTYXGU9jwtbMLEBPdkH/zfWsaH0UXQPJsgHvsAi0EYZXAs7AA
 qv6oKFl6N5LXaqNXaUg9zMX7wf4IYqMVNqHOzDpKIxVW7QK9in2ZMLS82YLQRp7m5k0CMzegRIV
 55n7Uht7M1tf6xtCDzOAxSk+ugOop0txrwm/h/xgCuv9Nk5eMVYX+bNu0TA==
X-Gm-Gg: AYBFou2mPBGkWA4sAdCUXcq0Md0/zcK1FKxWZz69zc8vTWX8ZWceLyojZStQVpZqAe0
 pRlm/2wOVBxmyxU7xyte6mvY9v3eYCC5c5mTpNZ+8bsP6rWfe+JSqmTRP5e5pqI2dFkXc3IqaEa
 df0Af29fZklfpqXxl3cYshtS9lGVfEYzB3JVRokeGw344HAbse1oYi868RTpnt04SlouVcvOi7L
 G/co4FTIp6qgcLCgCWzo7JbVSrAWRIMKq2/nksKUm5RILTI+TC9iXYrqlfPbMYWv6cPjAR0PFCN
 z0Zma5r4wJ1DC7R6SQ7J8KvfZ3AUHcZi4CeMi2qqrhu86mV963fS3v6UgMpBtnBIKvmy856mEJZ
 9XrPxMUF77GMuIWr8eqUeG6JuGNmHmbBlSa1zRvb0EREZ1xBY9/GtN6N62h3pJybU2gp7gg==
X-Received: by 2002:a05:7022:3b84:b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-151c2b17393mr14193030c88.8.1791235001118; 
 Mon, 05 Oct 2026 14:16:41 -0700 (PDT)
X-Received: by 2002:a05:7022:3b84:b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-151c2b17393mr14192994c88.8.1791235000484; 
 Mon, 05 Oct 2026 14:16:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm1766280c88.0.2026.10.05.14.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:16:40 -0700 (PDT)
Message-ID: <3d95afca-4a68-472e-810d-cd4e780579c6@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:16:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: implement nmi
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
 <20261005194519.2945862-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005194519.2945862-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MyBTYWx0ZWRfX2xJfMaV5MLjF
 SHKKpOyVxpF03+t6P3bNRHppWpM0+sVlgnatvBDoGBHw0inzAt6mBTuwj4tb8ki7B+AHXwDGwjH
 4dNYgE9lMGsZPzIXmBnzwFgoxMgXyfY=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac413be cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=0ivkkPkMuMaDLqESOK0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: tg27fe3WHqMjlP6Tpfx7CSHAKNO6jJex
X-Proofpoint-ORIG-GUID: tg27fe3WHqMjlP6Tpfx7CSHAKNO6jJex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MyBTYWx0ZWRfX8OGkTsmF1vrj
 o1MljMFdiNe4IhfD7jbPvpehpKnQucXqfkeaVgZfVtpiYqW0UDnSaPtM1XKx8QpZyCTwWSjzawi
 jPcXZqukUo3fBdhbG3JJzTmJS/4MOYvvNlppo9++2SJQzg1cvazUn21Z/HlaErD3tDcayUHDL7I
 16eT8jEJQvsVuATNsTBXTAS7NSfltWcF/Ka/day9CZzaG36N3N+HODzFJvq51I6/umDnU9Y4AS2
 raDBS5e52SZ+WRGOfrhmq9tj9YFQWozWt+KpDPI9qiYDPIXsLGIbSBy6ZsCCYFvT3EWY1AebGC7
 p8ba8g7cMc09nm4cUKiE8mTj+5DJKbbcsRPcE9bT3/Eh0wcQQPi1jQZU+CSgnEW40z7gXgUabM2
 hlzap3sLVrHNeEaDKHYpo3CWfc+RYj9prZx8mEWEt7S5U1SdBPRWFEhdMY225TDsCEB4L7hpL/3
 YioUztCbX9ehz6pg9Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050083
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

On 10/5/2026 12:45 PM, Brian Cain wrote:
> Y4_nmi was a no-op, let's fill in the missing implementation.
> 
> We'll raise CPU_INTERRUPT_NMI on each running thread in the mask.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        |  1 +
>  target/hexagon/cpu_helper.h |  1 +
>  target/hexagon/sys_macros.h |  3 +--
>  target/hexagon/cpu.c        | 11 ++++++++++-
>  target/hexagon/cpu_helper.c | 17 +++++++++++++++++
>  5 files changed, 30 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

