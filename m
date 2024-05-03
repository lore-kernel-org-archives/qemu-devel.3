Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1997FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uZE-0004GM-0W; Fri, 03 May 2024 11:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uZB-00047F-HP
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:11:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uZ9-0006ss-Mo
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:11:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34e0d47bd98so1259314f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749073; x=1715353873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iWQu0vn7bWg8b4EBgJzp9H8e2CETaI73TY3LETBvTBA=;
 b=HKTHszbnyOKqdMETAwNwf6OJQowYyC8I74R4QMVKZXpYmbQ+w7uz1su9Bb0iJyH9IR
 UdyT3plaC+eKquTngjEVCeWgc/Atji/TYsyoosY7U9wclFgT7uojYVAndoa86HHuFXCQ
 zKQcPPqqCh5RraskU1ddEvyGNgSUfYjK2R6pHlNz18wMjyyEnXRrZUebKnMpqxfdYpzT
 ts9sFDN6nskJz4tc8sk5DpjiRQ3y24GQmfgTBmM8bXFr8xcaZgqV4id73IsscBmD0FI3
 bI1JVuNFy9A4csfMLkWUpN0bVB5agsKAkxjQU4YWN9jY8bhP9VhEOG9TDkH056oMOBAU
 Tv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749073; x=1715353873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iWQu0vn7bWg8b4EBgJzp9H8e2CETaI73TY3LETBvTBA=;
 b=TP896KtsJfVSA3Mc8bj8VJ2Mg7GtswGM2hn9apJCunQYKTX81hxDB/nmDHpWiNJpqs
 lIvTe48yzdhYykc3exozdfHZItDJwmAK9l5qN1bbOJLY620U0laPF0KoS93pU5W9XRsK
 WFlLweMIzOsyHwDW5jOdByQw5FOchAw9qyz102ip4BTh7Ks1d1Se4oi7t0dC0RkIQSMK
 a2UIj+yf9lpVLmIoNthg5xqs0Ma2paBrIy5JNBJCsvZRdv3Tq3FentKkw5GcJno8C3Uv
 bugy8sGg2n7TJsfWOB+TuzOs2giQ9buEgEc1cotjXnQGY6J/2HLNuJLmdZRCUjYWwFK3
 o9DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU28TjWtQmnv1G4jmP0LDuNM7/1WwPov71tWcbK6E6CeCUHiHPbELqFGNW514zqd3EPelK5kX9/6tWmMzA8msR2bwRNX4k=
X-Gm-Message-State: AOJu0YzOeYk2uV4nvn619hf485SPSrHQewWXJYOS7krFeLHTE/xPgO0I
 NNeMbOiySFFZr5bY1orGGLu+mPB8RVW9ldcM9fcUbJkzGjiGtbIrdqlRdLR71gDaHKntjMA1fsM
 C
X-Google-Smtp-Source: AGHT+IEgavh8L2OVH7JtIYhrrJlaYDqGDpSw+2dbtb1W4j67rnU4dtBFMJOmmDmlTD9fEtnqAcvRcA==
X-Received: by 2002:a5d:6d82:0:b0:346:47a6:e77e with SMTP id
 l2-20020a5d6d82000000b0034647a6e77emr6800133wrs.27.1714749073636; 
 Fri, 03 May 2024 08:11:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 s14-20020adfe00e000000b0034e553f6174sm2456415wrh.98.2024.05.03.08.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:11:13 -0700 (PDT)
Message-ID: <1fb3b93a-0d5d-4a7e-9246-8d46c0caf249@linaro.org>
Date: Fri, 3 May 2024 17:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/33] accel/tcg: Record DisasContextBase in tcg_ctx
 for plugins
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h      | 1 +
>   accel/tcg/plugin-gen.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


