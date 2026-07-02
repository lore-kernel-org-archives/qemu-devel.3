Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AACC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHLZ-00057V-JG; Thu, 02 Jul 2026 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHLX-000560-T3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:20:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHLW-000132-EL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:20:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0e2x522301
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t3eQonbLAUPNtE1hwItDmiJdUU97dhYLcEYI7zT3DPM=; b=eJpmycZeqd5VtKUo
 p9NBceZogelQzbZRX1sukHxIRgcJAByJPnjsgqd/dvW5cMU/IMZO8QI6Yas5JwNw
 kQzHDdqjpfEnvm4R5IFJz3PRVdV0EJW20AQnOrs1zRWAzmio9Z0PMbmAt72Vaw3W
 A0p/nLB9cmq5ymxTLsTpVevhIeiOlDPWauGZCb/Ey3pdi5piJml7kiNLHBnbffmL
 mObDIBgryLcGnbHnFF8QBUIGBCXUhDVatUFq4pT2wUfhJpVWSNqv+Y6U0XEU0Qh8
 Ob8Bg/cmWUI++ADz5lptFJgWr5GOSju2G2DGH4A9HbGtIPT77vfheMEZ0Ma7LVYP
 sCioNA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1c92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:20:49 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-738b76cfe03so1931500137.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998449; x=1783603249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3eQonbLAUPNtE1hwItDmiJdUU97dhYLcEYI7zT3DPM=;
 b=IR4PHgfc0WGWsLcZnyZ3foP8lhJhujl8e5EQg/UpeGLdXSCRZ+kpAxzYiA7+GgzqYJ
 vr44h9IKnvnaGdSWiQYWGZaUu2Diho1JsLOVJoWsIalL5IylJIQmkJUw92lY/KdskSfZ
 sRdu/S49u+AgzIqMHe5eVMsSRasuLyLhcbSgeCUX7CVUHXCakO/wftl6S8f/7revC/5G
 ysp7DXdkbwieG1LcYDfM8wKaN8PL5zwJGIe5uFoqEY0iWMHFzJqxnsxNyqNiQxHlHxyW
 C1uTOQMvud3kCuq+ifTrmkp4EM3ygsK37cf+JRDE+2WAv20IPu8rrUAy4+Uh+HD+/wUN
 hZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998449; x=1783603249;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t3eQonbLAUPNtE1hwItDmiJdUU97dhYLcEYI7zT3DPM=;
 b=PwusngxVtiD/eFUslxJjJKvxxT2QBvdoPyGAMxOSYi9jSDg6vJAiAq6rpWfDJgwfca
 QoSrvRd4Ykmbeig2y2PF4Pw6NVnp+yeAsBil3NweN/X3s++6EnN7m6WYu+ySNFmu/z4p
 0qO4xzpkjQbKUq3o7ptSwiC8Ko41MCgGiL5KxEIRH6Uvlzsn3blT0Dzqp5+Su8gTdfRi
 iF1GcgLCW+jwiSV5Qh6YydhgVNHvG4sZJI0+PKvB37HS8fP7YqBTtdeh/7WVKcJ339Ww
 PUmbDAOWv4BgS3HVAlyMVm8I3kj9dZige6nTYuJ5XzwhqQ5fsOBhzde9Fv0SRqF5SlLm
 xWew==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOsP1MkQI9kdnBafxbR0HHXRgt2le+d8JU91HmutDMpw62sFP7qHebEsG6/YqktFlgU9Ed7HUF5w5g@nongnu.org
X-Gm-Message-State: AOJu0YyNP29hrdPCxZwgqslPpXzTOYWlDrRzAMB57uHTnfAALwj2sOyl
 ZNeh7AYf2P7aNZHY0ilvQ+SDEBZuLsutvB/FaeB5fnLcvhEQcX+td/DVLo4TPPnrdbMLP6aYdvo
 J/GAiC7zsCqMTaf3fbKjCFnlAmX/bNPGVvJzTMnAMfSXziX2poD6zSL0TmA==
X-Gm-Gg: AfdE7cm6uZ0ci06RIvUlQT0M/bdhVVTUut6loQVAtmAF/zDpyElwZTPOB+6ykLkm4mm
 3aUU7VtUd6dFeHrWzwEUeoR4cfnkL6CTeUYN/pdI05cBbIpGP1zRa7qAon2fbu+1jcb2Xmdwh3s
 RlWwuiRiLwmgvhRAGKtVSl+iLjdjoildK8M+O/vRdbCXUSD9amUt3ZuBbciEQgeUBiL5ypRrJs7
 DAXODBcX+/p5ZHRkiZlWNeR5QyeBxOiiGr/8AXuBnl23yacPJq5LJE34ExC8mJlqPBXbFOsGlHx
 yAvuX562gAwvpCPT7Z4oMI5jNhbk0sRA6lobTIWYqxTv3bsow/GwvYUaa7S3ls/qMm39TKeA33N
 eGZCLQY0/QKofFTpLNfYicgaCoxfCz7GbXS+v0U9G388j
X-Received: by 2002:a05:6102:f82:b0:739:38fb:f4e5 with SMTP id
 ada2fe7eead31-73daaac7196mr2846458137.22.1782998447379; 
 Thu, 02 Jul 2026 06:20:47 -0700 (PDT)
X-Received: by 2002:a05:6102:f82:b0:739:38fb:f4e5 with SMTP id
 ada2fe7eead31-73daaac7196mr2846100137.22.1782998442431; 
 Thu, 02 Jul 2026 06:20:42 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96983a1ba13sm876152241.13.2026.07.02.06.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:20:41 -0700 (PDT)
Message-ID: <68bc3902-0ee4-4958-9941-9cd0627d12e5@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:20:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] gdbstub: Store @can_reverse in GDBState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-12-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zNNYij-h3QRgLvV5_Carf-lGgZl8-hZ7
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4665b1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-Gn-N_3N14VAyuSf37IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX85fAT9LTxu0s
 MQHWG46RyvGqgAJRpobQKcc4sZoZ5Ef/iMkoMS2FBU7ev97cJG2dyhKILgeHgqH+r/SDjB46ec7
 SV+P4SlzUr5Yez3mF/gF17X5tsVoy49ixDHGXMx1w89Lmj64kc2ZozT8NeZPvI0uyVhv7/sciny
 TdmV2OPzR0PD4Vu2is6cMCqj/0OW/oMaNwdhEewaj/Qh+lGPZ3pb5iqwu//vRXvNkL10w9YbSlo
 lkhSmCrSbKC1C4rM+pZ4fBMDZPplEjFbsI8PGS8Anm1dKZnGaomwbXADMk0cXxKRvhqe/tIZVE8
 oFKLygut2tFBQAqX2A5Kn/j+vd+bqtqHQ5SzvfyCWItqxk8cqwxLkXM2ro4KYPyfubZdbNZ5/6L
 h2M4tb89gov3KXZ7OW9KyhV8ZMUO8gMpMF2X1T3jIXdYDk3nzpnSfouZ8h0VSqVA0/KnrlIEVsl
 BH84rXVVKjzp3AJZl+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX1jRgtiD+8I5R
 rY/5KVhLBbeRl9/4b1c80q4b1MYFXGfx6fjngZ5YMNQqGLU+uOgS1+fcU2fjxsYhJWz7Hq76hK5
 uJt0GSfyD2kIe4ntkwcufQx1qRLd47U=
X-Proofpoint-GUID: zNNYij-h3QRgLvV5_Carf-lGgZl8-hZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Call gdb_can_reverse() once in gdb_init_gdbserver_state() and
> store the result in GDBState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   gdbstub/internals.h | 1 +
>   gdbstub/gdbstub.c   | 5 +++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 9b25bf58b8e..9a1b8d9dd8a 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -85,6 +85,7 @@ typedef struct GDBState {
>       GByteArray *mem_buf;
>       int sstep_flags;
>       int supported_sstep_flags;
> +    bool can_reverse;
>       /*
>        * Whether we are allowed to send a stop reply packet at this moment.
>        * Must be set off after sending the stop reply itself.
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 1e0a6638bff..0037704d522 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -75,6 +75,7 @@ void gdb_init_gdbserver_state(void)
>       accel_get_gdbstub_config(&gdbserver_state.supported_sstep_flags);
>       gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
>       gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
> +    gdbserver_state.can_reverse = gdb_can_reverse();
>   }
>   
>   /* writes 2*len+1 bytes in buf */
> @@ -1376,7 +1377,7 @@ static void handle_step(GArray *params, void *user_ctx)
>   
>   static void handle_backward(GArray *params, void *user_ctx)
>   {
> -    if (!gdb_can_reverse()) {
> +    if (!gdbserver_state.can_reverse) {
>           gdb_put_packet("E22");
>           return;
>       }
> @@ -1684,7 +1685,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
>           g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
>       }
>   
> -    if (gdb_can_reverse()) {
> +    if (gdbserver_state.can_reverse) {
>           g_string_append(gdbserver_state.str_buf,
>               ";ReverseStep+;ReverseContinue+");
>       }


