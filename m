Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3303BC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhyB-00062s-0G; Sat, 25 Jan 2025 10:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhy9-00062Y-7e
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:21:09 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhy7-0003OD-Hl
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:21:08 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2156e078563so43524645ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818466; x=1738423266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n6RZIIDd5yGDts2n1FC/yeLd922tEwNccE9QH9OdlOc=;
 b=kPYJJnudvbHNZoS88c8aHOBwp0uhoaqhTnml0UkkNqrRybBUm3uuJW2NZ5WshwQuOP
 dCfXcYLu50fqh0pM8cfDYo1NhF+puQKfG6Vkn2YP3bnOmuD/wfaJgkDQutkTpo4D0Dnw
 DNjKOYWVf5Z22C+xKLwbWlG61TIJ8KUxpWyAJCV4u1TkQTWG8vSzBm1YXm2zQV8GiTDu
 zH3qGt3JF6n9JJPiqTFSheHE9Gch9hXfF5THpHl8fgciDqGCJEv9STJmX6n7aagi4LeZ
 3Rd5LE6petkIYaFM35qf37vBnUJopZ3HeUr3FYX/CD9mb/IyZwVS67TOkvvwXkekW8XW
 KA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818466; x=1738423266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n6RZIIDd5yGDts2n1FC/yeLd922tEwNccE9QH9OdlOc=;
 b=Tl9z17qkzBfIoAUZPCW6joSQD4y0kUah3QPNx6gF4raW0FuLjsSbPLUo7AWEVeUvFf
 ItNfxM3M73NbOEvVb8d11M44b9LTrVj4ZUVcJTeR39dWlKRHFHAlxCvJmyIbZhS6r5C+
 f6mYP5JeV/OJuodZ9JF14C1rYm3HbfPD3opcv6xHX4/MFbuZMApxILexmqTvdfL4kR3y
 dWlOoX5Y2YPPludk8EOfBBbOQo5MkzEwaKnmMtuYQEzbfdUfYTXLTFcVfpKcvmU3GLMR
 x/Z3Vd7zTuOCR7Q+HeZdxtgwpbHg/hBBl2DjTQ/YfPDo2zYaDfQsaQu8MbD5tfb1lgGc
 07Rw==
X-Gm-Message-State: AOJu0YxYaf6q0Qm+ovT9qs/U2O2NtLXqS9rXvnhrFJjoYUCbb0E9nia/
 KhPO40OR/HFZITVgPgltg4p30Jhvxkqp8Wop8TcGZwYFyJIAYRdBZqUB+As/66HrhN4Zv8VPzg/
 X
X-Gm-Gg: ASbGncu30ig4eqcudTf1CmVdHlgiOvrL0OsispxH+Ln3nrNzQuD/wkRvKfXTGMdVRhu
 Mf4KjMHiyVGR1C9Qdl9iQ6moX5kjqj1xhx5eYilq51BNIK7Ou2QvFf12kh5doB9ftfkPSR7bELk
 ICStotR9MeWEAwjs5/r4BJVqkF9hawQ05v8TKRGRdGzGzOTJMXqDc8xqXtb1DdLmNFcgIW+LqS7
 y/QgdniacqosARjl9NuTm0m10si5CFEjtsv6yXn6uLRNA/UJrVBDw8dp7yyMocWTkf9SbTYET3r
 FQhV54Rrgq/FnJmwi0zB7g==
X-Google-Smtp-Source: AGHT+IFAuJJHNrtVRY4nEcrZ6cxnh1W/HA2FvyIQLWHRaOfWKXLvcSrXZgCa8Cy8vbbp+mGDNghbnQ==
X-Received: by 2002:a05:6a00:9296:b0:72d:4d77:ccc with SMTP id
 d2e1a72fcca58-72daf94857emr45566971b3a.6.1737818466072; 
 Sat, 25 Jan 2025 07:21:06 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a7608bdsm3924477b3a.98.2025.01.25.07.21.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:21:05 -0800 (PST)
Message-ID: <528fe786-b1e7-4587-a902-3071bbea6da4@linaro.org>
Date: Sat, 25 Jan 2025 07:21:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/76] target/arm: Define new fp_status_f16_a32 and
 fp_status_f16_a64
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-14-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> As the first part of splitting the existing fp_status_f16
> into separate float_status fields for AArch32 and AArch64
> (so that we can make FEAT_AFP control bits apply only
> for AArch64), define the two new fp_status_f16_a32 and
> fp_status_f16_a64 fields, but don't use them yet.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h           |  4 ++++
>   target/arm/tcg/translate.h | 12 ++++++++++++
>   target/arm/cpu.c           |  2 ++
>   target/arm/vfp_helper.c    | 14 ++++++++++++++
>   4 files changed, 32 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

