Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E3606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PlVsf5zH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCPP-0003lb-Rj; Tue, 20 Oct 2026 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCPH-0003ib-Nd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:09:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCPG-0002AI-Cc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:09:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso736231f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792512581; x=1793117381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vcFW2QXuBzPGxbq2YCIkrN4k+WsOrVrMrSO/N/425Wc=;
 b=PlVsf5zHQ+xK7zwiMsV9M6AgIl/lPHDkWMxZjVZX+OdJGSkUmd5UFW822kn17OVPB4
 7OzoFzJatbyk7knXNxpESZ/U/LlSSovmZ4tTUaSBnAt5g7yH+CynDSVKBx8dLzOg9X+l
 YMmF4rtx/wNqMJRh5miX8SXzMm986t30kYw0rWFPEwrY4esXGvoOq92aJXrj/GM/PEAz
 uXq8uV36ghjGOeukgwMRaQ9LHC7oeVDk3NhiOyo1ofvo7DhJCIWAJkcvT7opxgJA+a51
 b5UMDa+KYLk7CAI0GpML3VAJQApyg+9ODxQaTlJT0aDPZRI8V5juvpdhstxc2Erkxeyu
 T7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512581; x=1793117381;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vcFW2QXuBzPGxbq2YCIkrN4k+WsOrVrMrSO/N/425Wc=;
 b=sMY/QxlDFl/JIbELfLZIQQjjKFviq4uvGSAKjgM8kHEcMR3LLPWoAX/lzZZ6WDxvrS
 ThUZF0i9835AnK6AZXTdx9F4NWUDTR+a4OjB6mrM0aAbYPYiiMwtQRWk87D9EQpyKVPk
 QwrmaqloONHkt0mjQ3ULVDY8IEy1LS7MK1Fqt0eMKxnf7FM6fsrE4lEisEzz7h5EZ200
 yJsaoiikMlOoeb5ed8K9MrRtOSqqLFOx12/VH7LapMsRtfdzRrBrCtLTIw52CsUraJBF
 K4h0GIZPH/2B2KOcLnPcti/BJFbL8RiEYcmHPCfdQDvBj7QDVg87yllK68e6WW3qvSQ1
 C19A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxErP62+8FKs5XOVcT8sGj7wQaUWhPHU7GVOTX5EYuMCnLra1ZOXt6i2Tvet3mPJiM8w/YJ99FL7IcT@nongnu.org
X-Gm-Message-State: AFq9FYJl+hlNUyT5A9SywNZIyZbWz3WxGauEre31b9R2RoMD0MiDexqd
 GH4+aXt6s5odhoiXdkXmHsUzh6/82qh5JGkXN40loA/35w5ZIdqN/yvN5OyAXQazcPs=
X-Gm-Gg: AYBFou1IvfsnB90QIqC3EU3P1z6gu6AfW4JlzVLyr5Eb/AfU/UXvwTT17JMrJ8HeTWZ
 vd5WRY23QsAzYCRxdiW7ZMF3ZRVXyK0WYdobrFO5B4a53VIEBeTkq8V7emKjbUIaKLltV1KYrY3
 CK7ZkWZD/BmFx1F3ltLhPcUvQFAQAfgnhjalg72oKx+PP4gyAm9Fq2nEy8+9XaWkvxMRmJh2e0F
 VT/gvGNbDrlS2G7PjUekbGdb/XQ5wYoB9EU7yP4AbeeEAV74IEUM8xtLOV2jrfh4SmIvE11es1X
 EJRYz6GAY5nG0niUKbyOGDqaoftSG0YrHm6cUMl6aWO/oD859eDtlkvnlOwkEtsW2ay5RMjpeA+
 h5A9V21HENevh3hq6Bh5AKwI3Mlol4IACnatnKQrldKZuLYHnm9xlHNrvcTT5mGs2pEsWurULA1
 3ylsCD/8i9syJnumEg1WU8SxbXla9aMeEHCVWjxEOinnCBym042yPpGb7dQoz6nAIzGvCveCDR0
 p1dqGGsTRs7tRbaYdeUozm6iTkQjoD9EuhovoakMcw9IMEuAGCGLg==
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a1d7615cb9mr245877475e9.17.1792512580842; 
 Tue, 20 Oct 2026 09:09:40 -0700 (PDT)
Received: from [192.168.2.121] (p5b3b6184.dip0.t-ipconnect.de. [91.59.97.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f69d9b1esm58834195e9.7.2026.10.20.09.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 09:09:40 -0700 (PDT)
Message-ID: <96998fd1-7062-4eeb-9173-8d199fbfbb0a@linaro.org>
Date: Tue, 20 Oct 2026 18:09:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/tricore: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261020122752.3651914-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 14:27, Peter Maydell wrote:
> Convert tricore to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/tricore/cpu.h    |  3 ++-
>   target/tricore/cpu.c    |  2 +-
>   target/tricore/helper.c | 13 ++++++++++---
>   3 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

