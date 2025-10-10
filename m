Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD31CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GTR-0003w1-UV; Fri, 10 Oct 2025 13:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GTQ-0003vT-90
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:00:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GTJ-0002UU-2S
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:00:07 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7841da939deso2102310b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115593; x=1760720393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z+HiRAnbdYlOBfnEX9/uvUT7/FqTlN3IZPjOuCXMtdw=;
 b=fJhWh+4/lNCAsfXAXmyiHeG0mx2KXoX6Ajeo57jbSPu5p8Om0eupNN5h3k8MlDNOP2
 Wg6L6T286JlUneO4FnZ+mu6kFHbsg1YfdH0JKi9L+br81tOhbEnev0kRuwl3ZyzjiLXT
 j6i73R9ovaZ3ANp5bMjAcQXqUhl8IAOXNMOB4zrkOVq1G6enC+GDTjmk2+FURruM/5CM
 P1Xk6jouDKBQetCOeX9LGONOP5Qik25IJhZ9EDfv7bQD3c5LEjTwgFY0fqqCslwCkwaS
 9c33M+SZZecFVdm8xUZTQIoYA+l4v3FLku1xy7TGcYGFHUljq8QLiU4TpBrXruHMkAsH
 Yo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115593; x=1760720393;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+HiRAnbdYlOBfnEX9/uvUT7/FqTlN3IZPjOuCXMtdw=;
 b=bTaq1GLKT/Vz5CUhtV4zMoxCTF13gB6smQYZWrTsdR850QetZIH2S/H88XOEu1bKFv
 1YSDpGMQNwjYU3CAIjPtPCs0YXjDLCaG984N5YZcLEbQYsele2KCSmkN9ZphrbkXMiWL
 KdjP9JhoVn8O7LJpv4eK9jRaeDbmCoKfDic8ZGTn5DZ7JrRLbOgEzjuZ1oDE5f/iC3YS
 lrVLKT/xYnBAAvkmI4KjU7fIJi0Rl2hvGnrH7f3dLZQBqeOs0RWLR9vmOA5kWem4/U3+
 Dyz+nXm3hbCfwPRUSjlnc5LPSJkRpr7hPIWtqWRbatCAVtoPsIirQD1Wh2nkFVZx8/gi
 pyJg==
X-Gm-Message-State: AOJu0YxQ75AgztnkHaJOPyZRxfn1A6Z3MdI5bDHZN86cvmsCs1+QLnKo
 5sxSTGgt35JYz5ZG/4aUEXt4xkipq2KmlQ80KKEmTIZDgcGwY16/PoaavwyO8PYb1zZe4VzT2tV
 UtuLgfxI=
X-Gm-Gg: ASbGncuSil0m9qwHNiEsldSWBsB9qpwYwQ/NyyunYinDzN4ocUd28/IDP3AvsLSiJ1T
 oco1PpatxgCNUtZRMF6GAZPhqkuMU08U44DSBf2uQlxf0daJMb+DP4AmN3Yf9BKo6xM6QxELa1x
 Bd23EggrJ5R97HOx1budJoOaf2tuf40fw7gnDoKCiaJCBIUaKgYB/WoDXa7qCFQfyS6zFx5my2b
 yyQDdIqRFTP5SBb3IdoKOWagrUzgVJ2u7TcBZz5R8Y3bm05A3q9rFHZ9Bkvn/W16MEsfg6iR9Qk
 xJTmcODNkVUBgfs0dAwkQvxt0EDBwaw1XsRkzWXsgH08U/4KwLCaHycNiqYIGda+qEYoQSb5MBV
 r4povE7dEotafFMcIjmBqkTH1yrtRxW2sRBjo7M2E9yCIj9oDzBiTPx+5qIE=
X-Google-Smtp-Source: AGHT+IFilFt57Dv7IyiGZ7WwLjaq+51mY2rVMyZnxKHq53+XbihFw5NJUGeIesZIhHiFiGz/0dzvnA==
X-Received: by 2002:a05:6a20:6a08:b0:2b2:c2c0:583f with SMTP id
 adf61e73a8af0-32da81344d2mr13384016637.9.1760115593259; 
 Fri, 10 Oct 2025 09:59:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678dcbfc5esm2812068a12.1.2025.10.10.09.59.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:59:52 -0700 (PDT)
Message-ID: <27208e24-2eb4-41fc-89f7-6134c9036506@linaro.org>
Date: Fri, 10 Oct 2025 09:59:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] target/tricore: Remove unnecessary cast to
 target_ulong
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 4f035b6f768..04319e107ba 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -37,7 +37,7 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
>   
>   static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
>   {
> -    cpu_env(cs)->PC = value & ~(target_ulong)1;
> +    cpu_env(cs)->PC = value & ~1;
>   }
>   
>   static vaddr tricore_cpu_get_pc(CPUState *cs)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

