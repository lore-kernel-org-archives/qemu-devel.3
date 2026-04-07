Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ADDEDB7D0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wADQW-0000Yr-Ce; Tue, 07 Apr 2026 16:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADQS-0000Wy-8B
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:53:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADQQ-0000Ba-7G
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:53:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so56787305e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775595208; x=1776200008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+umKk6wWHPqSsy4J47zW2yNFfVhQ64yHh0oe/yOICg8=;
 b=OLBj5HQyyHkHDZOEIf/hDJhAxvfOHjF1X27yjz4s4XQ4X83ssqJiCzE02srNxCMjhL
 QFYaL9yr/l2EUMTA89DPyOH/gds7UloHIvxEQxAyzH1UKxQlVvJCC0WYZO9wv1DtO0oG
 OD91F338pbW1YnpO7V583Bn6H3mfNFrQhbSQ0hBonWPb6UmevnQ8ZnZ3qrjmk1oY47nH
 OqheEBPSccghPQwn03Nqp3pmQNE4/4HODzIKGb3XJzxic+dA8DN9TYGxJFD/6f0RofLA
 ZBSVkEVt+hWwy0HVKtkBWIMbY+UwUWjV8cIyv0eCVdkRgRTCKVROPu08cJWlRaL7R3wF
 xa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775595208; x=1776200008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+umKk6wWHPqSsy4J47zW2yNFfVhQ64yHh0oe/yOICg8=;
 b=hvY9gig6r36dQIfJ3zBmXHtrCNvoI2j0Umbe9BRXVHxAJN99aV0kUfKscWr+IWyvtn
 Bxy86oQNVBDkwO/COwArYMvE1H4HCfKiu9uG64nVYYaA8AqZb6JgHQkThENqYy70VYSk
 QHGSMxMFXP7tReVMqlTXffFAyN0flo0YRx/Z8mFtrdMqSNsXFwiClG68ACQQnIGMm3i7
 mJjmol4nyxM4PkAVwWiiYeMxgyZQOi7uaZnGegfyc24cPCko1rnTQXRkEnrtwpL8sNVt
 BzNCUZdMIQO1+C+6WQrwiKe5ba/RpUw4e1YPpsKpMglT9JOvMFDWN+f7MMmiBjJjh9Nl
 XAVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOgGR8Ka9nqIV/6WdhNe6v/XAMslP8+CwoE26PCnNQPzVfI46s0TLGSUk/s8Lpdn/HW88+XuNwKAFU@nongnu.org
X-Gm-Message-State: AOJu0YxyT/VVjdfQmERMcKGbq1BE6rcAMOAK4OwiMYpKLq5MKVZE/GjW
 25/nkXe31AIMWolTNgwK0ZO5qngGk5Xri/mifZ8m71UPD1JJwXJ7KFYJR4rr0p6DNx0=
X-Gm-Gg: AeBDietT8X9nnqYoenS4cCBZaNmp6BM/k3ko2SO0BN/1sosPh38KRwsLV6XW0xmuxfA
 jT4sWyQQTV91NMujgfhWVUNy5fF0VmS9X0cU15+u9WIbadUeGwNazRdi2ClxzmLMKztamWD8U98
 Lsf8qI9p6wW7oeCgx0K8G+gwlds+Lct1iGHdeGN3Qxi02BsPMK14AB+xH06Dw/5c5Doqr5JV+Ep
 vEZ7HwhOl9w+M2tbo6TFdecmHPrNTA3lLyLLljYv7jivsJzfa7i5HU2gxKpP9XLoA3dOuPQZQeO
 Qzv+gavduTAtZ/V3xmexXVXCIVYtVTPIzfRqMV9E1a574ZLaFjj2x/p8trG907yvkUAnD4T18Qn
 XStmqmB/8N8RgdlwAfV/+kLiv7c23vom7jh/oAxCvjbS/FdHnYHddavhej9M2kp+ts1K22nFxTW
 iktvTxfo0tp9IiowQ/LszG4kE11kYEPqK81B2QTOcvMtRNFi+NhzSAcq75+2h5xJqPYg==
X-Received: by 2002:a05:600c:8012:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-4889974a416mr269254155e9.11.1775595208346; 
 Tue, 07 Apr 2026 13:53:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm1074897175e9.2.2026.04.07.13.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 13:53:27 -0700 (PDT)
Message-ID: <10bf66bd-56d0-4030-bcc4-d61a3a756548@linaro.org>
Date: Tue, 7 Apr 2026 22:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/21] target/arm/tcg/translate.c: extract
 aarch64_translate_code()
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-14-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407195922.196410-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/4/26 21:59, Pierrick Bouvier wrote:
> This allows to get rid of TARGET_AARCH64, and helps with next patch
> which will define at runtime tcg address type, by adding a second entry
> point in a different source file.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/internals.h         |  2 ++
>   target/arm/tcg/stubs32.c       |  7 +++++++
>   target/arm/tcg/translate-a64.c |  9 +++++++++
>   target/arm/tcg/translate.c     | 19 +++++++++----------
>   4 files changed, 27 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

