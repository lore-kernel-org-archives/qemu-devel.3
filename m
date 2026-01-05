Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0708FC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcY3X-00069V-1y; Sun, 04 Jan 2026 19:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY3U-000690-UT
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:02:40 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY3T-0005u1-EW
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:02:40 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so13503459b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571358; x=1768176158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5GcPuvbLyyLDdnnIqPzFvxp2uKUVUvtmkA71U9UWDio=;
 b=vJPvDIguHmXH+64Uk1nes3Ct/KhX5gXDQXoENxwwWWBTrMRST+f8O0zP5tjoaAg8kg
 Lm8EFIluWz6LdDThFw6h/aaglmHW0dgU5m+9URbhFOg+oxuJ4qyeilYYpiSVcjpe7O48
 ehmTROphAQ3KjeUFSxtl8om4fnJ2/j7TWu/7+PYm2E9E9nCCb2f+M85E1mL2/zX7AYN2
 eOlJrdzWjb8WmBwqjqpkIrQrrYxYfCQxYjqMf5rkNyguGWzuKFky5PB0kcmQVmJpfdEq
 eV6cMyTUUiodROencEEpf47V40tmIo/Xq/lwzL/sKL74rWfSJYTUCg/oXpZaBSi0Bpkv
 IgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571358; x=1768176158;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GcPuvbLyyLDdnnIqPzFvxp2uKUVUvtmkA71U9UWDio=;
 b=wpxLe/iyk0LvIxCGDZiZmKB0GgLDnf+cKWxZA7tICjD0RIJfkWUMAnoawDxPAvjznp
 3XZ7QsYugjZramgsE7BqqaoWiuptV5tElbLVb0v97oiZOOUwVhVWXCMFR/2JlpsWdCtP
 /FQeEUuzGqWYtX+2SOZ2KQYX2D7tAga2/xeRcU733n6RpBu63ERQTQvbpZMKb8CpJwi4
 iGyVrwI5QH4pR4U6+WNYGMsQeuuMMVAw+/mHEagbPhgiKMeNZo60NIhsGEzpmI7bGR8a
 MNUXZEB59noIYzR5EeViAASosu1+rLnFp7lKfvKK8woV+8UgSGfWoE+9HcR4bIWSK+Yt
 E3xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUamJ4PC9V41Gvo5Zl2r5bPkLBAHa6CC1CzqV1+ikoXmr0UOceVT06orH/cHqcohmuWKoWCSWV2oWPB@nongnu.org
X-Gm-Message-State: AOJu0YxbWhVeEUs0LCCRz6s9yJSRwElc/sEbb7DK5SSQn7HadfL4umJ/
 2pSaPKINySAZa5spnTPmX9hlLdiLqmT0r3seNxluMk8LRvA4xuXDv61M8sUdQnCePaU=
X-Gm-Gg: AY/fxX7lkXCiJs0Mx/5Z5RNXxup/f5NrjvAR7xytqGqUprEqxG80RAF1jdoyBHDCpDz
 6dQ1ZXK5XfXpoaqLTe2elzv7XANJQx4jK85nbI1Etcs2t2ep7oU7VJMLdhafJwNO+X0LgfAPBe8
 npRGB3YvguVyYbYPxlJGptyXP8ziqb0wg1htUU4wfMGmf0T0j0YH8SpdouYy46qhrGmVQK1Cwxh
 qvJ/cIpZMdb4doZWXs20bGgq8XzDn1MwPzlNHJgXc8b7WbUB0g3r2TBb2wgB2krDOFCXtmlxzr8
 B4XNrR58HT1MgawqDaBHRtBBZS2Bb/R/LvM0hOQd+cATZT/7jqVHB/UjTtUFe9h4noElA4NqzuQ
 ACgW6Nsvsxhkyy3YZDl2Hdx17Y863uEj1KcGIJd5CW7d7ynOiboAbfK5nZfAp3bVoYjgRD6ylzy
 FBMfaGkTXpMq1r8l8W1jhUQa1QUePbW9IFg7HCr9wJ
X-Google-Smtp-Source: AGHT+IEB34iNYYYoRt2EjUEaBacuFsKnkJMqB773TM8GuJgMaaKqY/LDOqUHfN4OIyEapqtOhaLDJA==
X-Received: by 2002:a05:6a00:1d9f:b0:7c2:60c6:8ca0 with SMTP id
 d2e1a72fcca58-7ff6430ccbemr41520985b3a.5.1767571357858; 
 Sun, 04 Jan 2026 16:02:37 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm46545607b3a.51.2026.01.04.16.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:02:37 -0800 (PST)
Message-ID: <871ac700-e0b5-4ff8-ad14-cfc2af72721c@linaro.org>
Date: Mon, 5 Jan 2026 11:02:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] configs/targets: Forbid Hexagon to use legacy
 native endianness API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251224160708.89085-1-philmd@linaro.org>
 <20251224160708.89085-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160708.89085-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/25/25 03:07, Philippe Mathieu-Daudé wrote:
> The qemu-hexagon binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Preliminary commits allowing this final change:
> 
>    - beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
>    - fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/hexagon-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

