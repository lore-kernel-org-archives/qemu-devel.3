Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41113C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeJ3-0006tW-GI; Tue, 19 Mar 2024 14:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeJ1-0006sl-IT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:35:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeIy-00050B-TZ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:35:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dee5ef2a7bso40842185ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710873319; x=1711478119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CEiVrSto/0KoHdxl1PNAcbb5vFS8cOaACcli8oxcHx8=;
 b=HIWjbt9k45Gxuiw/sw6zNSkeC/KrpCFGOCMYuidePqAh/kEJV//vQSM1Snx1imLso2
 GlHpEhHmnD64e1p10hRZeAHWZpatrPKH72cdI/aPyxbNPrcnrtdi7tGmt04xBi6x0xZN
 AwkRwlVRzCy9Ujbw+Hfbc6Xy60krC2JLdxMgNf7nzkdhToxQLUwatu8JPhA3Vwpuhy1J
 vfTk41p4v5hxQ7eNya6pPupU+Q+iKLmHWsSJUlQvK5hrMciEqy3ZXSIEivo3UVSEWbMb
 7XcXjG8bmbPJ/m4JurH1U8IFSFX//lXfFV0+lWdUR3tLH9QKobjiL0yPRuYHbaF8Cz80
 xrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710873319; x=1711478119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CEiVrSto/0KoHdxl1PNAcbb5vFS8cOaACcli8oxcHx8=;
 b=rqBc/5Ov4Lkilu9g1nxi2PbyIJIwT1k9qkLqXr/RlpDBqtlGAq+nqqL3VdPG5X2ncr
 hsrMX0MMSrhn1s+tHFjSSuSqxywbD0DNFhRU3d/oWSNTfTO8vlB+cGFzaAwgOUsifXyM
 HRbIFE8rFPEsRa777chjXDR+kEKvGk9IRIric9zOcmoqVC38JcnEkVMIXICf9yAFLf49
 z4kLIfu2i4lhxcg0d9TPnVvUx7ABkpVdQYPBXPnjXwlojqLMvmuNASqNBWYxLZofUqSj
 0xkyQ7rwJw6229Mv41bXPHl68ffGVLLcdcoD800pXFhQpWrrLPfgexJ5PGHufiHLX2zO
 JjmQ==
X-Gm-Message-State: AOJu0Yy+dfhx03wEyXwAUM/Qf4FgyxlssH9W6m6iZhgatdOOj6vpK0yV
 5PxK7tHnSPEwMr58tpHT7+/inRKAfhrcKnM4ZvpzQrfPPC5d7lNAsgrLHRA/j5HXqUYgp+RmqKq
 A
X-Google-Smtp-Source: AGHT+IFVAp7gcJcmGkKGjbWRb7S6FRT+tOTbU4yezFh4JuvVmTvTzr0kso5RijgL5RQNAynAgduluQ==
X-Received: by 2002:a17:902:ce10:b0:1e0:58e:88a8 with SMTP id
 k16-20020a170902ce1000b001e0058e88a8mr12426456plg.52.1710873319335; 
 Tue, 19 Mar 2024 11:35:19 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 u13-20020a170902e80d00b001def0c700e2sm9382524plg.119.2024.03.19.11.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 11:35:18 -0700 (PDT)
Message-ID: <6a363223-384c-4480-8bf3-2cb7160a68b5@linaro.org>
Date: Tue, 19 Mar 2024 08:35:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/hppa: fix access_id check
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240319161921.487080-1-svens@stackframe.org>
 <20240319161921.487080-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240319161921.487080-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/19/24 06:19, Sven Schnelle wrote:
> PA2.0 provides 8 instead of 4 PID registers.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/mem_helper.c | 59 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 49 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +/* Return the set of protections allowed by a PID match. */
> +static int match_prot_id_1(uint32_t access_id, uint32_t prot_id)
> +{
> +    if (((access_id ^ (prot_id >> 1)) & ACCESS_ID_MASK) == 0) {
> +            return (prot_id & 1
> +                    ? PROT_EXEC | PROT_READ
> +                    : PROT_EXEC | PROT_READ | PROT_WRITE);

Tabs?  Anyway, weird indentation...


r~

