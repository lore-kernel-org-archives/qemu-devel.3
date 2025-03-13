Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0928C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfef-0003w1-2B; Thu, 13 Mar 2025 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfeb-0003rr-4f
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:19:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfeY-00022Y-8V
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:19:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-394780e98easo485952f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741861140; x=1742465940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hx6MqJ3btGl36b4s7zi883a5mZwZge6PQP1GVxxuQNU=;
 b=S1aGk46CH6Dov20D3s73d8d4wZivZGbKVFFNHMwW2U1ceNqqBl6aYUnCZa2OkX0Fpd
 94xM085LvsjdY23AtL9z6de2ovkiNkKlta1NloSCqESg2sFMZZmR1XAi9Wns/rbS6lHn
 8gmA/zRAK9hmArjkXIHRneCDlUDKKCuMkvTEnkaUhXSwv8RznejFw/8SylvO7Paz2Elj
 3nWRZo6F3uqVusz73W+gPkyLaThdVv5G7EvnTIXvsXBoix2z2z2ZRSJIx1T2aI0LYLm5
 2C74qfCQu6H1NpAiIOevbuLaGySlYuFO7w1h9U0ecmejWrsSXIT6i6h22BcuJ4y1AUil
 wABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741861140; x=1742465940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hx6MqJ3btGl36b4s7zi883a5mZwZge6PQP1GVxxuQNU=;
 b=GOVg6/tP8EUIUi30PG/4plMThZ4OwzEMWkkTLBvHTtWA8EJ9XaDFkME7HMm2muEjDN
 vFJJuTZbuiAdzFM1CrVSF3CujLDwYCDLqV6J7tCY7926VVrdGrbZdeK0pVMeWQwxC8VO
 DpvDUlARhxeRCtUfri/tsS0OjTFgL8Sw80bG+0w7YbqBs/8VKYHaSagldDUOO22VUVHy
 km9egxHpGYYfo+94ONnWjmNgNbkiDSw6plpvNW+AQKcCWNDfHb96xoL39sWsrMZNvFx6
 Y3T6rNtHe7wjwkkgN6NvzvO1KKPodkHqHGCW0750+VsWye4mayNjJajr5qjCX9VQRanK
 ZnEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYENN32B7qa5W9SCSfNTl2hT8rOJzAFCpgLFKXFRn+vZb/7R71GlcY3IQ2EAMMqnlXcV43lQOezIQd@nongnu.org
X-Gm-Message-State: AOJu0YybRFqB83wVxN1u+JmJyuhlR82m0Ep6xBC4tB0uonTpEtOufCRO
 XiFvPy+ie3+OZDFsHHGuDTm9Z/il2Wfc4bmIsBsGU6xrkbKve6Phwwu6Hd34P/w=
X-Gm-Gg: ASbGncuSLKV2AwozM2KanJiXAmtz7k8eEZmP4rIOxbE5KtNgyWzJ2vRwR4nlRgZjSaa
 4W7s2gecneXuHU3aanO+ilVLzGd9REgoXAhtVMbAG0mrf4jW8X2yhAclFdwMyJ6YSPOA2CFdQSz
 o9PmA20WaOIAN/gznl2ggp4EI00F2NcFV7A2LW6kp5EjKj7EEdJREx4hm1QB1HGOUL7OJSdabZg
 SZJeSBeQse6iMEllYkqKUZwTc3FaQpbepeSog/ZvYXiKbaTyp9hTOavkQ13QvnKxfEsqMiMUgw2
 YWbmYpjLf/ONmzUqPGObV2M/ybsTur8bUZu7ke/DrDI8CCdf7VV6Jb1N381s3N93+O1V19RcPCM
 ks3FYSxGqSlMxm8A=
X-Google-Smtp-Source: AGHT+IF22CZmaLPy76KNIB4g+pQlHNvQ5HdmtoXlk0Cc3kbrz40/vfTw4si4Lo/bdPzaT6nvp+5BiQ==
X-Received: by 2002:a05:6000:402a:b0:390:f6be:9a3d with SMTP id
 ffacd0b85a97d-39132dc5627mr25407001f8f.35.1741861140180; 
 Thu, 13 Mar 2025 03:19:00 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8d0af7sm48360445e9.35.2025.03.13.03.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:18:59 -0700 (PDT)
Message-ID: <238909b1-ea51-4a09-876a-2d8f47a706f6@linaro.org>
Date: Thu, 13 Mar 2025 11:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/37] include/system: Remove ifndef CONFIG_USER_ONLY
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-35-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 13/3/25 04:45, Richard Henderson wrote:
> This is include/system, so CONFIG_USER_ONLY will never be true.

Ideally yes. I started moving headers in include/system/ to clarify
APIs, but that doesn't mean some of these APIs aren't being
(incorrectly) used in user emulation.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/cpu-timers.h | 2 +-
>   include/system/qtest.h      | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/system/cpu-timers.h b/include/system/cpu-timers.h
> index 64ae54f6d6..f10cb5e7d4 100644
> --- a/include/system/cpu-timers.h
> +++ b/include/system/cpu-timers.h
> @@ -30,7 +30,7 @@ typedef enum {
>       ICOUNT_ADAPTATIVE,
>   } ICountMode;
>   
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +#ifdef CONFIG_TCG
>   extern ICountMode use_icount;
>   #define icount_enabled() (use_icount)
>   #else
 >   #define icount_enabled() ICOUNT_DISABLED
 >   #endif

For example accel/tcg/tcg-all.c include this header in user and
gets icount_enabled() = 0.

So first we'd need preparatory changes in to form of:

-- >8 --
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c1a30b01219..daa629e5b72 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -74,4 +74,7 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
  static bool default_mttcg_enabled(void)
  {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
      if (icount_enabled()) {
          return false;
@@ -85,4 +88,5 @@ static bool default_mttcg_enabled(void)
      return false;
  #endif
+#endif
  }
---


