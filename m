Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF326FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcWH-0003XC-EK; Wed, 06 May 2026 09:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcWF-0003WS-9n
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:42:31 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcWD-0000xT-61
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:42:31 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65890a6ca20so6016327d50.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778074948; x=1778679748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bgf0tKyrU/TaQq+fGJgyiCU13s+/MpaMDLyqMyVzsi4=;
 b=cUYmRPOLvvTw0H5lD+F2tsR7JhOm4v+dlVtnGp9zv9cQmJeUju//V02DNLcQm1qVBm
 /11IrrlarM0B7DNbiuFZAE+1U5qfi+toSxZqmRHTh4RuCixiJ8qFNlqkM/vEw+x0Bwpa
 gsmR9MrT4jGltqCNPFJlwsF9OOCC1rzFkVNfAkraP7W5xk2UHx5moukfVke3fk/5q97X
 +nMzD8Lh17EQMYPyC2tLDu4u7whZ2Xwuc4p25W6pt7GiWXZaBRTEiLQUW+dvqCWVRyrF
 nv/IBj3tQ5nHrJPrgqCBlXVoDplH1tWeuGb0Ekq0oZfvBEj7a5LJbOTkgBXqo3Dg1Et+
 xW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778074948; x=1778679748;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bgf0tKyrU/TaQq+fGJgyiCU13s+/MpaMDLyqMyVzsi4=;
 b=Kij3X16yXdoBRYUkN3lJPIIzBODSmAB1d9+fCQxMH3NOLa/95qyscSBOTwABJkxaeJ
 FxGe1j2zzE4AT51G9i2MftOtDb5M0MSZtiUXGZin7qmHjweiQGPSUmi5Dfb8NS58A3/n
 Cbfsg8wTwM5egLkCAdHAmtORFxHe903Ar/6ybbGDDF6Gh+DF8UzZF3ogz6ULLORgUggV
 bKc5Mm8JBxi50aZ5lMRkSIIBF+GBepE0mkshtSRHveBnuHom4tAe4+reKc3LBNq4Dt/V
 OcJ5BGpadIO2U+nPUopkatB7owc2tq5M1g8wMBOSSGUqSDor3XI3wRo05V/G5Sv8hr04
 FOKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4TpI5jEAKvjUAkoNk+uAK10qGput4BqeRnZJPTjPCQJHnUKvHiLG+xywUTz8q+mLuEP/20i6EcwiD@nongnu.org
X-Gm-Message-State: AOJu0YykXUPzeV6/iWvAe58EqU+EqZOEbbeun1NqcxvwG4WMaMAhkdYE
 z7Vmm78wq2EPrBUVB1mNkuEjVP4pdK0zovVui0ajkupFJq2JoDdmsK2Gvw0p8sxpmMo=
X-Gm-Gg: AeBDietsLjlvlSySCqAY9AUlxG5yNq6O7gGSyavfjxrT9L4Q+5t6ZtUQ5r+jBB/9m8T
 p72nDb3VL657L1P1OfJ8vRu1/48yD8Ht20UhKN+shW2HsqGpa3iPYf8EBKXKWrkpJGIU8jmITbb
 ShJ4zCNrvVwAnILnFr7nz80kdvLandG8vOaDD+NlnvoG5GIxaX6UqWeqkacQ1Wc6hRXX6ggxoj7
 4Wef2c36U4o3s/51V476d7PRd4HLV1kYAFrkvo0mweeaE+e/OySRdloFF15Qaa/MUCjhHXElvaW
 52cT1mKOM99O6Z5mDcVfF9H4Bi+JHSPSqX8PaMKmoDQT+oIoe/aEzyhrJVzfh0GsZOcLRkHu8RO
 MkwFsiNv4aj3A3oD3h3ZGtNgboFYNqn0wDQwK4Zy0CDGnCDvhDd0Tgb/gWFqR7Zd05+KmPBNteu
 Vv951LQnlgF/Zw1KyLxNPc9g9q5dHrJ7H78nAkMyt6hzV9ME+CU2dXi0ps834/1bBqKd/fIfahv
 Hgd4QNdqKXa/JTXjwnx
X-Received: by 2002:a05:690e:1403:b0:650:a6d:d6bf with SMTP id
 956f58d0204a3-65c79ee4068mr3545342d50.51.1778074947754; 
 Wed, 06 May 2026 06:42:27 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65c7aff6d80sm1017280d50.18.2026.05.06.06.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:42:27 -0700 (PDT)
Message-ID: <93406cbe-cd86-481c-8357-5178d46e7340@linaro.org>
Date: Wed, 6 May 2026 08:42:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/15] target/arm: add MTX to MTEDESC and DisasContext
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-6-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-6-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/4/26 10:50, Gabriel Brookman wrote:
> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index e753124c4c..40a934a8af 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -460,6 +460,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>           }
>           /* Cache TCMA as well as TBI. */
>           DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
> +        /* Cache MTX. */
> +        if (cpu_isar_feature(aa64_mte_mtx, env_archcpu(env))) {
> +            DP_TBFLAG_A64(flags, MTX, mtx);
> +        }
>       }

Actually, in the previous patch, where you compute mtx, is where you should have the 
feature test.  If the feature is unset, then mtx == 0 throughout the rest of the function 
and the store here.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

