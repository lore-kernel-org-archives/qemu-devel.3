Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A85C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuEWU-0004rf-F3; Mon, 17 Mar 2025 13:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuEVo-0004VX-BI
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:44:33 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuEVg-0005JA-VD
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:44:28 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c0e135e953so481810585a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742233459; x=1742838259; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LhhIF/fNCPgSPXXaDlf6TA460H+OiZEgNGTB9jMCU0A=;
 b=Skp4ZePLGAxGbwxd/qe25SNAMbWTelHuAodgaj/96NY2G53vekpvQ14wN0bOraFAeD
 tPu52eqj5g/jW5oWmklQcTII2oamNHU1tsa5nM0mFtTXk7WRxYsXu1NEs5s4Vpd7tRdn
 eBUvSwzRpofRyMZ4ZPiBqTMhAsQ1SdmLLwUFp26z7u30AE4rr6+qGHaUFi2Md4nNakUt
 78LRIws68dMyFpIad0FMWkXXmyzV4FrGEkGufKTTOMIU7xIYr5cJOo1ujTI3nHDbxgTe
 SZS6gf+Q8ad4QcGTrKR8G2ZlJy2FPb8DisBoVmfVtUPP8JedJ/H4NRbpmec6B5k0bv3G
 5fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742233459; x=1742838259;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhhIF/fNCPgSPXXaDlf6TA460H+OiZEgNGTB9jMCU0A=;
 b=CEO2DzocVpCwWdfav3TGiDabj7FjLKQsPo4BUpKkjyBw9KWtbhwGI6iVPg4sRy94ve
 N5Rf5PBgzu32IS3rgRx8EdUO04aFVYgLPJj7oLVaQM+WfmGjzzY86wgm1Qrl8BOk0m7u
 STQ9ZoVld9wzuOktB2EGz6c/cBczOVDPJvuQCO4da0rj7Y+SdhzCH7Ok/kcXbQpcxFwy
 UwQc/PdfEeOjswVXNMd6hHY2QbUUE7EU76eMThEwnd1aYvzAPGh3lk80zr/9iol+ZsBk
 19zvw/H3B1Qn2KH92lpeNiiNIadCJm9h5FVJ071XcdUwSukvqHKDltRTaE0ooyH/629I
 8Kkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnJOOb4clebj7za8YzSjie7apFvYfW6zEDUaUd85XCZDqm1eOEGrjsAByySjuoX4JPRR5ISae2QAg9@nongnu.org
X-Gm-Message-State: AOJu0YxHqbJRo/ebnTv7Km+l7hrt7EcH5Ie/7n/GotLqJBwstO42A1zS
 BQeNiLtvlZm5GQFqtkK4NtZQaXLndRVvrbUlFRGSRPwcjJi8kfQA
X-Gm-Gg: ASbGncssWzBruxCGVz8gMrwVH+EUXfeEuan5ZbS39qdzuRY7p7RpDWY89WZte7ei4v8
 RfWF2F+1PsmoItuC3B4Wk2TaIG8Vp7aX1+mjBNZS1kfRn6h2DWt468P+rcgLNqspC1Qv0V7wxMT
 4kw0RFooSt5XkBmjCtlrBaxboKeBBusWD6TpMjm6wmOrsnXuRlh6FETTHYOhhgOTfn2SR+R8b8o
 v7tS6yBXAFX9Tj97rilsAc7z0/8ng6OVnBh9ZamEEn8A/BTtbXxPSdcLQBcMZSthp8Almeeuc3p
 /tVDIhXLlwvso/pJcyI4Kt9I3ytEdW5D8ZnPcUBFqGp4t1cn5ODtbHNzbZpWtG4=
X-Google-Smtp-Source: AGHT+IHDsRwITGiNLHF6ZilqjXpsAjLOfECclDCoabFkYyuaQLuqSL6FONhGQZ8Qn+y/vSsuwwtlMQ==
X-Received: by 2002:a05:620a:d8b:b0:7c5:3b52:517d with SMTP id
 af79cd13be357-7c59b2c436emr80366885a.54.1742233458765; 
 Mon, 17 Mar 2025 10:44:18 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c5205bsm616222985a.3.2025.03.17.10.44.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 10:44:18 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-7-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
Date: Mon, 17 Mar 2025 12:44:16 -0500
Message-ID: <017301db9764$35236f00$9f6a4d00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQIo/XVlsvDY1MA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 9f79b1a20c..83088cfaa3 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1468,12 +1468,39 @@ void HELPER(resume)(CPUHexagonState *env,
> uint32_t mask)
> 
>  uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)  {
> -    g_assert_not_reached();
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
> +        CPUHexagonState *found_env = &found_cpu->env;
> +        if (found_env->threadId == tid) {
> +            target_ulong imask = arch_get_system_reg(found_env,
> HEX_SREG_IMASK);
> +            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask = 0x%x\n",
> +                          __func__, env->threadId,
> +                          (unsigned)GET_FIELD(IMASK_MASK, imask));
> +            return GET_FIELD(IMASK_MASK, imask);
> +        }
> +    }
> +    return 0;
>  }
> 
>  void HELPER(setimask)(CPUHexagonState *env, uint32_t pred, uint32_t
> imask)  {

The name pred sounds like a predicate register.  Use tid instead.

> -    g_assert_not_reached();
> +    CPUState *cs;
> +
> +    BQL_LOCK_GUARD();
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
> +        CPUHexagonState *found_env = &found_cpu->env;
> +
> +        if (pred == found_env->threadId) {
> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_IMASK, IMASK_MASK,
> imask);
> +            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask 0x%x\n",
> +                          __func__, found_env->threadId, imask);
> +            hex_interrupt_update(env);

Shouldn't this be found_env?

> +            return;
> +        }
> +    }
> +    hex_interrupt_update(env);

Do you need to update if the thread wasn't found?

>  }
> 
>  static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
> --
> 2.34.1



