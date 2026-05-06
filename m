Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35AFCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKccC-0005Z4-2E; Wed, 06 May 2026 09:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcc8-0005Xi-M2
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:48:37 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcc7-0004XD-1R
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:48:36 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7bd5c582c47so57878707b3.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075313; x=1778680113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aAG+KvUEewg8B86niHrQB7Jf/yP/IUSg2UD6qboiwVM=;
 b=fWhuk1ABFZVbbcuLbt+EI8HB9ZfVa5cW3O5CVFaLccHObv4HW+zrosn+s3OIMMYsuM
 PQKhmGaU6T4hYa7di2CPn/UEeIfMLByuYIHITBKxmhLEj1kYxIBEDZXZJi0eezMvV5VB
 6RViJi3hYDvUG6jnYJVB+FHd3S7RxeeoMmFR+Iza8Di/z0aTgGNE5DzmOTUk8W/6f00f
 i16y4rY7EtPmQI0p7F7xefQ82Lo8JmaBURt1nP6vr5vJO7HfX2yeZ/qBBPIdgmqYIVQH
 EXPlwiSxKyaqyLWOH736S2x1wymsWoNr6j3jvSvXXHD/ZM9ZdtS6WneKSUeAl4HSMPhg
 I0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075313; x=1778680113;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aAG+KvUEewg8B86niHrQB7Jf/yP/IUSg2UD6qboiwVM=;
 b=bFqVI+YPmukK8Uzfrr4CVjA8Smws3Fmezohm6IRasSqJgN4TxhDfPs0VlbfMEvYjZn
 QED3zolrtLHWcy/EEtOxkAMCUrqorjbvL4tFD+8TXCRcLm23kr74OOXAUG+qbO3/tQPi
 Jtfst4e13BVKWe6xEQNnTL+X0xKsNm3pJUYWoT6OjMo8INLAtz1LlcqCLgWZPWrlIXEi
 r+oeCOcqPDju78CDI0naULqJvzmef33RnbweNcPyl+eN6xB6Y5zFe15KaQihKZxoBjom
 Tcz2mfng2v77qYJZrv1nos0Iz6W36V82/1CciyBwye//46oScH2HSKpuEhNkzspAc9CY
 uIFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/T7ok8NdMFeltnKWcNm5sr6fvtS+E9TeXXEl44p7Wkye9SnHMGa5lXe8yjIyisDTR/tmupPQVOfQVv@nongnu.org
X-Gm-Message-State: AOJu0YzIzsZhGwntfNK/Gxpr5v3Msl0704g5TU3H9BHS2HHcCGVyyYgx
 LKZDWJNcQlOfxZhnaU6LVJL4zPU7LwKnkfzlUXVyqFlBBehgw2Q4l/HigztRNSKXpGw=
X-Gm-Gg: AeBDiet962ZcJnKUXrtdqQzapcKNe0FrFe8qzG6TZamZ3wf2NB9Js7CaEiVuzpgWenD
 cHEdSt8evts2zBvON5oWxia/620E+CUHoFMoh15k5OL0AgN8Qk1hpZGotO1Nfq235pGFWTLCOPn
 wj6iT+pz0c7g63w7NzXAJJEH26H89rgHUYcg2E+rePXKU0HRpKJejx+glfVl0wYMD3kamD2qXO0
 vJxZUQzajOk4X810SvkRU4YTRbeL+Tu2mx+A6yOQwCraJT1MDz1+63ZZglhmoHcKb8ersxaIpVK
 6btXuPrcW9pCgS2OrvTqjvuZNsqj4249xPeC6GCYClnGJUTqKj8NpZ2rCLogVR+Aw8J4zvYw3In
 Ash3mygCXjafBVcg4Vodo4WZ/hmPb9Gsi4iOBfB9ldkmOeiuJTiUu1V2qK7AYCO96ZndpvBVhIC
 V7oyPSza4l6DD6y/iDotZiQxo/LBDVlbMcEVMuoLRyK81jCNFr8vteIl9Fv1WWBzDqUv8ooXRBq
 bl1lELzEuzJThjA7qJ0
X-Received: by 2002:a05:690c:81:b0:7ba:f3a2:553c with SMTP id
 00721157ae682-7bdf5dc7b67mr39581007b3.11.1778075313437; 
 Wed, 06 May 2026 06:48:33 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd66896b35sm77571417b3.47.2026.05.06.06.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:48:33 -0700 (PDT)
Message-ID: <ecd55b46-2536-407d-b3e9-da74a5f02c7d@linaro.org>
Date: Wed, 6 May 2026 08:48:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] target/arm: add canonical MTE check logic
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-8-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-8-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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
> With MTX active, address tag bits are checked for canonicity if the
> corresponding memory regions are not allocation tagged. See
> AArch64_CheckTag.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/mte_helper.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

