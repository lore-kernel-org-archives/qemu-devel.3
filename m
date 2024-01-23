Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A6C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQOD-0006hZ-Bz; Tue, 23 Jan 2024 18:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQOC-0006hD-4H
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:41:08 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQO9-00045q-4p
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:41:07 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-361bcabedd7so18450815ab.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706053264; x=1706658064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MgNCusKbwCSAk487zkzf/vbtul5RWRiHhv/6fGNEvWY=;
 b=oCwuUfe+gzaAhlwrw955vX2lz3fqx924h4xJJSxbNqSjzpXkGWPzp2WHkmHm1BuoWf
 1hQRTx8ovlB0d7+EuvMSih9/sj9pCMeh+viCvqc9c7WHEQrQoWEkp+AQcQhyvm3jsjbJ
 AawLOAGS4w3MjetriIMd8X/NaPJJBUOHaUqU3b17nOAOnW8S7HHYitrUQV3gDQG5DRF7
 rMii7DIHtHCizLLyp3dUwDIzBNYtcHb612wuxZg35CB5EKz0cl+KJsCMAcuPnS6AJHUM
 01SBFDXNKFqXbN4KnJK8pMrF4IoeM7Hci6rsGWGnZEoWHU9ceStVV0mhNrpuvbf5ukfx
 ggGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706053264; x=1706658064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MgNCusKbwCSAk487zkzf/vbtul5RWRiHhv/6fGNEvWY=;
 b=g1/sihb0ElVfbcqfbOk2fmCF1vsLuJCUoigiUPdOYx0ly8SmP0OkRZqq88km1W0RI5
 yeYJ07Q66Y28MXzNs5sVo8adA1kOlpJvOr7rU+1bWk5eKKVeQReN2sOqzBkpSRXPoX9x
 agn+D4lAxT1IhZdyV56SNqyr5hr/qwPPse0Q8wReiwuXNekN0dtHcC7anImbU9IQoM0A
 pULvvkT+jVoRmzjoRNU0lWi8VuiOw5NimptOyiDxddFYfhPEo/VQ1ljrRvhG2Qf1Fu2i
 +J0iAxX0i4/fheJmlvsN0ZzSv2ORXfD96g8l8MaxDJapty7oDWsfw0tO0iH5xlKF8uuU
 yEWw==
X-Gm-Message-State: AOJu0YwD31LIrdpNkWWFRsMo9cEXBwNXnXT3hmvOFdl+GijY9gZL648K
 4xz4vJ8fQ7V4rcN1dJ+zDN/7vkJW94LFtjM1XXDlxMGaIZaDHp2bMLc9ssdRy2o=
X-Google-Smtp-Source: AGHT+IFmblhwdl/G+TTysxTvomAPUzTj12FROs4DahdMzFp1yg65rb7JYQyLOZ/OSwZWkn5TCdbP4g==
X-Received: by 2002:a05:6e02:219b:b0:35f:eec4:ed55 with SMTP id
 j27-20020a056e02219b00b0035feec4ed55mr704560ila.62.1706053262937; 
 Tue, 23 Jan 2024 15:41:02 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001d76f1fa24dsm1587044plg.46.2024.01.23.15.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:41:02 -0800 (PST)
Message-ID: <b013ddb1-a80e-410d-9b04-95ba74fd2288@linaro.org>
Date: Wed, 24 Jan 2024 09:40:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/34] target: Uninline cpu_mmu_index()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-13-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-13-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1233,19 +1233,7 @@ uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
>    */
>   #define MMU_USER_IDX 2
>   
> -static inline int hflags_mmu_index(uint32_t hflags)
> -{
> -    if (hflags & MIPS_HFLAG_ERL) {
> -        return 3; /* ERL */
> -    } else {
> -        return hflags & MIPS_HFLAG_KSU;
> -    }
> -}

Unrelated.  All you need to move is...

> -
> -static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
> -{
> -    return hflags_mmu_index(env->hflags);
> -}

... this.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

