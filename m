Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B897CFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABvA-0004ZL-EC; Tue, 07 Apr 2026 15:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABv1-0004EU-Pq
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:17:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABv0-0003i4-8s
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:16:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so2995031f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589415; x=1776194215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OreLeMDc9RksIFbyX7CRphU/Wu1GOua41TgIzXExXaI=;
 b=DBkSeOeN3GCqgbXnmjL5pyWx+iwL/y8nh7yMZ2SQd4c0PpaeptS11UkQgSlqG1iPNn
 EK0tcLMJMV5qBsBD2m1lB026TzxhIAJ45SZeNII6IeTenMPNKKOSZbuOC1FjkLloqwy7
 rMLhQEmVfwUlkVvcdApoNkCwJVGodSweNOSLNzCKji2jvJ5rtMmGZAYhCsOlLhCzfPks
 pY7YrKIqZ62ibqZV1Fk2BkJ0KWOsp6hC0vE55Zaz0M8sbjZeE+cJb/a+zLWDm3AVFYBQ
 zVmc07lL375+8pDUv4QgIVhMileS3tk7YNlqTULwgWaZG6yFEsOPfNqkpKhBdQBuQawi
 tdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589415; x=1776194215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OreLeMDc9RksIFbyX7CRphU/Wu1GOua41TgIzXExXaI=;
 b=CSQNbKYPPilaPIQCQjwFqPlGbK+79qAFpRDYvCJs3YhFyi3InEFfwsAEfllGlpVFQW
 O8lKrr+Bei9AbdWGzdJOMcGK/Ni83OQKCHRL3IJ9AFxv8ay+stw8J58UfR13uZ1ruNJc
 +QGJW3mXuMciKiy3WEnmoakPzpvK3rWC8Fg+ETXFfuPqZiiUYzMorlvLjzRbjdJjcFTE
 GvAaRVpjgrjMdyITr8yxHEYHa82Q74H5CgRBZ1K5MjbXE4Z/2+BkMAdM0R6hwSFQ1Nka
 FOKOksisZqEiH3ZSvBNFm4nen5kif+PRb9FHOQLGwh1secLR1zVK8mFclgbBHQj7A1M/
 XCag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkUvU4NLa0f7AaFcwXyFqz+40SmkTL1Dl9TcxRm7uvt9yh27l4hUl8oxuB0UKXZ9/euGRegM2GaNAE@nongnu.org
X-Gm-Message-State: AOJu0Yw3uCEMmSte30mrR08V+QwP3v5QkFBBEOSh7Pna95acoD8Fp41M
 iAS3eDhgBJHIAf+W28A4o3OjfNekHgnTohwUYtmRRcVMF5EeYGmNfiMvpmG5Hdcmitt5XsLePGG
 TGy+rVZs=
X-Gm-Gg: AeBDietbsmenGFXvUuvW2+KB7aEYJznl12dQiQMlktgjCmw078uMxcNmaireZ3JLQnG
 ucglQ7mkVx95cM058fkqj5BV4YP7/vvl3xK4oxNAoEUzf2iNLUbMAIvGdppTnzB+ez8WHb7L9PF
 U9vivZZKWA4ZFll3OafkdaBEX3LSdvPZCfJlTyQfzcVYpSdSwLbfz0nrTj3uLbKFHy5SIBPzvkC
 W8e2AIwoNseatP/ZmNcH3FdzD5zGjkUsexNWSYvMQAuhRO7eIJXWG5Rsc/DaYulefFTleNCykZg
 lO0HTwQbySHnCTSfTJSF3ZoB6tqTZo1jZeSvgt/46UFC+mfvkgHRC7r9lgo+lWALzxQkEZSFRPx
 sNv7oISOS7RPHIK7CZ1Y8MRuYKys0NjDsAkfN5hKHGidmpYSEnEsQbsW3sAHEtZiBZgOVXXxJLb
 d/Tga1kaXXFPkJxxqZVsal8rG5HXHj1bywStB/jdkRu181jbMIMvBONcjbiwebufP1sn8BbCdQn
 Y+1
X-Received: by 2002:a05:6000:18a9:b0:43b:8f29:b08f with SMTP id
 ffacd0b85a97d-43d292e15damr25414259f8f.30.1775589414892; 
 Tue, 07 Apr 2026 12:16:54 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c5419sm61621572f8f.11.2026.04.07.12.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:16:54 -0700 (PDT)
Message-ID: <614088dd-edfa-4cef-aef1-b697c8b4aaa2@linaro.org>
Date: Tue, 7 Apr 2026 21:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/20] target/arm/tcg/translate.c: remove target_ulong
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-20-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-20-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> We can replace it with uint32_t, because we know it's limited to 32-bit
> target.

That, or widen to vaddr for consistency and save a "why this uint32_t
type here?", anyway:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


