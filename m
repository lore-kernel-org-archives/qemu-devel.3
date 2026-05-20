Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A34CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf2J-0004tw-T1; Wed, 20 May 2026 07:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPezq-0002e9-AX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:22:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPezf-0001qO-TC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:21:50 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd01481e592so698194966b.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276035; x=1779880835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0A6aXXpeHKaMOwKOd1KEfwXQYsy2Fokvt3t2rQQDvLg=;
 b=d8KeEXAVXq/1af+ugzfx+Rp+9RVevhZjIOZrGOUdFW0sHZgx0ohsVA80jnfdS8Xq5j
 ksOUt0OT6e2Ta0mf10PxShxXiBaBsl+BVZM0D5E8LHi+VdtMrgO8FIj6EvECudi9qY61
 npkMYu+mjIfB61wf+dEKtjh8Z4FCNQyteD+T1zn5N3zB/JQ6Un+JWKUOVkDGizsots1J
 VF+GTQLxpV1cT/MR0SeoGQCr8WtQ6vWu5rKKJJ5gWxBIZnr/Ryo+hHTx5XKz6K7IDtap
 ICUkMH/dD74MaHKWRBfXQuyHwCtjV9ns0WjNpE5UaH9aqI9+V0pftF4O82yhp8FFtG21
 R6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276035; x=1779880835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0A6aXXpeHKaMOwKOd1KEfwXQYsy2Fokvt3t2rQQDvLg=;
 b=YkPOVZ7Xpguom90Z1/Y6AMfv8bhTHQ5JEyGhg0LGyErMvsDhQEBKDRF/mbLqT28uKc
 mG3Mk0yNVRvZBQsOgLUaGQ9MV/9cpUo4BaG3cGqMMqhvs+MXrlxnAQIpeGeqMoLLMffL
 AHV4xGQ8s3Xt7FGJwyL9/klKZRNNKtgG3G5YYJe17Q93AyYhmw9F72l7evTR+7zBtg5x
 o+Yob+lFQhxnSNIEvihxBrz4RVvq+eMzLiXKlSBLbCPfcImdjDWXJN84I8WJ72BioeTc
 /aROSE4ot0wlsKEhJGhbsuRAmwCJ/rrCestZfqvWL6q418jLJF+xoAoK+Olgp34WEGTp
 Ew6g==
X-Gm-Message-State: AOJu0Yw6YZNTZYKdc5QtOzd+uTxAJkI+PLSMDJ+hiaJW+iEFTBTCNW3n
 pG99hGUXp30p46RFThxFBtvjDgYPo+wwcPEY3zJReXkhCIE1BFzeeaLZLW+XNmTuuCUjo13EK0u
 AWpdmdQU=
X-Gm-Gg: Acq92OFc+jpZXQBHpqpihDJA5muiE/tGxCjm+pJegJncWZ1dBXtkYyMRfeHnwbuZ3dY
 Us8xVoN9ItynaAMZ2qhlsk3f1Hr6OcYsaKa18xpSXwuAKiYXriscj7m7ixf9wXIKLifUTS/DUHB
 7N8Xwgu/nRPc4DfB/gX823TU9bEe3K/kHUGyFodbUMUQ8sPIhVgp1tKR3pkWEkuueA7rbUGEhks
 i/K2fEBoTOb48MVLMwbif4/6U8Nk6PHZZNYJc0axXmAvlzFfkLCHAs3v7YA2J0H80PJhOW8MPoG
 GWcYF4GNUPmadFoMFmurwiMutVLzveAKcTAhmRfKTyMbppU2TqKbIVZWtxysl6ESr6lPq09i36H
 4IfCUmys4+UPLsoUw8vBCYowlS7jn6I8cuUTAgiATHwTCBZ/2M/uizyvFa3iACV+Wg7hipjxKvx
 +DHVkGZgy90/s7qc21S34Z8SZlv03nG+dTptZfYtQQvLNm0LSMo7UcOvF0GFN41SkhDx8KI6ynv
 SknZ04g1g==
X-Received: by 2002:a05:6000:2902:b0:45a:e3dd:586b with SMTP id
 ffacd0b85a97d-45e5c59a269mr38455293f8f.18.1779272766604; 
 Wed, 20 May 2026 03:26:06 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm51198932f8f.3.2026.05.20.03.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:26:05 -0700 (PDT)
Message-ID: <8ad9c1a9-aa99-4ee9-ada2-4c3504578b8e@linaro.org>
Date: Wed, 20 May 2026 12:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 16/24] tcg: Introduce tcg_gen_addN_i64
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-17-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 20/5/26 12:17, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Add a helper for multi-limb 64-bit addition. The helper emits native
> carry-chain TCG ops when they are available and falls back to explicit
> carry propagation otherwise.
> 
> This lets target translators build wider integer accumulators inline
> without open-coding the same add-with-carry sequence at each use site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  1 +
>   tcg/tcg-op.c                | 42 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

