Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F13C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XeJ-0003h2-PX; Wed, 23 Apr 2025 06:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XeH-0003fx-9w
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:48:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XeE-00075A-OB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:48:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so64433885e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745405289; x=1746010089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0BzvGT4zSMk1PWLJfL1TIGAbt/PN57ZB8d6UY8VRWo=;
 b=W71/rgLk0dFqMb3xYq/S3WwqyoI58cP++SLgoOqBlkm82wKUXFQTit1bQ2ADHzI8dN
 0X8ZdgK6slVqyspr5C3g0Msm3pnbbF+GmBlVxWhEIXVUlx358KRTK5uU5xLKYhxAU8ql
 CnY0+sfW2H+xSIgo30hEOzIprOuwpoIAFgwBWqsG9yiAqPzZ6nD/cOH5D3CnbdFk4gG9
 uJOjm8Ks04STqN+4s9UXNvHR6Ubb0O1n8suvAFxiTXC3sQHO+GY5hfuQXepB+0XpUfoz
 IJfp3X7lL/eku9+Q0QJpqeXePh1wljLaCtMu0PKqm0Z4upMU3apK5OkTDN3zzPSHQTBl
 WzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745405289; x=1746010089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0BzvGT4zSMk1PWLJfL1TIGAbt/PN57ZB8d6UY8VRWo=;
 b=R4H/0FfN0pgr6LMcsPOOKcq7p36RXLw4Ynf2wAYIf5hAhJnoIb7BnyD+AvBViJ2q7B
 bIUI6f0dO+7DgsdjQvt39cf1Wz4JyaCneZylknrJJQhESKImt5P+UeeTyJhNzx2UTJCY
 xLWf6HnkOpKlOrnMODdBjkZSDY1sguYK+BPYgsF/LTvlWe1ZlypJogJ5ICrFCrbZeAIW
 MQ8kvCijbxtK6rsTeuqXG2E05iXH+v4cu7FkYzH0J52WlGBB+v6H+MtDwzZgNToIWhBX
 IOorJD4ctFXXS5kcMKPXrOv65JirjHE3KSnSu1mrmNrrJkj4C0/bC24B+dC0uQPL9+bp
 6xqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlVSQKLCelO00fSyWPr+Nlz5FbFq9rqgew7XikHJT+F0SVH/kaUdvoHJn1kzkSuHveAEMJh9UiRLk2@nongnu.org
X-Gm-Message-State: AOJu0YyXEkQgEVi+jWz0r2H3rzrDYxV8NMmEiaHGkKCHio+obUSzoR/0
 AQZttHp9Fi6qgADHqdl4785up81ABrmn1Db0USwV1yg5AGPXNQ7bE2pr+iA9x8+8ThBA6jT8zN8
 2
X-Gm-Gg: ASbGncuxX08fQE9xuznAAp0lLRlu/zHJ4S15a66jygf8nfYT5WlxT8FBQ05RkNEgrE+
 PUwwaISS3GmVk7NuQB8J4k25PZfAcKVWvqru/BlBieuwwZ0XzzldqUaLSmrRvqeVYXEfqcUZx5s
 90tQ/mVhKae4nDv6Aa3+JGyAfzfENhehrumsfs63v35BOrQQWANLXOxGn8HrHZ20hd/n+CPFGz5
 e9pKp7fip3wTO1mIXOUdv6OYfVWhlzE4yuc2xprMgwACRY3beKiMpISK3KXmcsW6Wc3gwqTF+EI
 PKMXBCtWvsG3Kka5oGLXlGCPVJR97+D+wTVUVSqhXdHiao+VOm44zq8CQBfsD6rCXlUmyMfXu+x
 MYY7CJZsK
X-Google-Smtp-Source: AGHT+IEnXolclQo4PXI5E1aRyALqfXtDpetOBU5yvheYj9TmZ2PxpGP70lBjgTHfcf7WVHF7FkAL+g==
X-Received: by 2002:a05:600c:1ca7:b0:43d:1b95:6d0e with SMTP id
 5b1f17b1804b1-4406abfac0fmr147404495e9.23.1745405289101; 
 Wed, 23 Apr 2025 03:48:09 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207afsm18557711f8f.12.2025.04.23.03.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:48:08 -0700 (PDT)
Message-ID: <7c6f26e8-ea76-465b-8292-d5a2b29451ae@linaro.org>
Date: Wed, 23 Apr 2025 12:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 001/147] exec/tswap: target code can use TARGET_BIG_ENDIAN
 instead of target_words_bigendian()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 22/4/25 21:25, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-2-pierrick.bouvier@linaro.org>
> ---
>   include/exec/tswap.h | 11 ++++++-----
>   cpu-target.c         |  1 +
>   2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


