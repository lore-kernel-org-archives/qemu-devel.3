Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AED9C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 09:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTf4S-0000Yv-Mu; Sat, 27 Jan 2024 04:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTf4Q-0000Ym-Uo
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 04:33:50 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTf4P-0004ki-Bx
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 04:33:50 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cf450eba00so1307505a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706348027; x=1706952827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1U+AikTeKOfKwNRuJWJPl/mVmkfaMHfsAQzei8wDlV8=;
 b=EcLeau0EKvJEDt49J5zlJig4YzUUEwgmsKhHHsIcyqG/TdIiSilbrGj/ZzswPLZcW+
 /GyphL1BGSgab5P6tccApO1MFSRgQi+ZyXH/BmbORZf25cm5ZGFdtNzb8pzMaFrm9YBj
 9g8cXkKj2hzwScNJbLUjfQHQSerskHTL4W4DKdPDl2DgwlhKgvjvJjTkZBT9lgsXTlQO
 tP9KkuHANyhHmn3SGTSRylKmOlcIj7JifgtDG7usJx6ftUSkq89CGWevHGsGrdOec/y8
 U4QW1M4pOBFPc68e7YllNe9/Ttnph/6Cv2uaHb/SKhbkZtLwGsYK/Ukb1NkqPIc85Hn7
 xkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706348027; x=1706952827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1U+AikTeKOfKwNRuJWJPl/mVmkfaMHfsAQzei8wDlV8=;
 b=DR2zfUXa33c0lLOk34GtwGh2o1zhwSZkNMG/3ZHaQqXI2ICbH1N1iBUxGk3GfGa8m8
 FEZ2dZZ6nqRaeIcWkmj1UHm6BUdrDYcOXaK6RABaXjAuFlTs5GVxjuWfCIemdqMY+VPv
 HI6HQ+6Bc2aza/u27hFymZkbWbr6+m671A3gvGwMM7LeTtauts1Kze2Udt/NHNb/bBWg
 mWrN8hYsL5kynnrTbRXJbideG1ocWB4QTKHBjAlGiPfmsfq54XJkPyeb5KF/YaV0hUDi
 OBEkPJuca2vPVX1ATt2lgDCdFdz8MDBAfQYtR8IrX//vrV4PQG4JS709tCL3URl75Rak
 WbeQ==
X-Gm-Message-State: AOJu0YwUtBKs3LKCpozf3hKgF8tMHpwIqkcDffvpj2FyQz4nJT0LLau8
 ryu20dcUERCxYvGIZhZO+eleSaSLgy43qNhdjY2ojHICiIU7DENSjd5f4KeMCuM=
X-Google-Smtp-Source: AGHT+IE+H98rDMdeR439/G11TSLELMe4dz4MdZlEgkqu8qDiAJa3y8Vy2TFn3w+Bp37Sv0aKo6rhLQ==
X-Received: by 2002:a05:6a20:d818:b0:19c:9bae:9fba with SMTP id
 iv24-20020a056a20d81800b0019c9bae9fbamr772195pzb.75.1706348027562; 
 Sat, 27 Jan 2024 01:33:47 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a056a00219500b006dd8985e7c6sm2379519pfi.1.2024.01.27.01.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 01:33:46 -0800 (PST)
Message-ID: <67f47069-7831-4a7c-91f4-c8d456f813d1@linaro.org>
Date: Sat, 27 Jan 2024 19:33:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/34] exec: [VADDR] Use vaddr in DisasContextBase for
 virtual addresses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-10-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-10-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> Updates target/ QEMU_LOG macros to use VADDR_PRIx for printing updated
> DisasContextBase fields.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/exec/translator.h   |  6 +++---
>   target/mips/tcg/translate.h |  3 ++-
>   target/hexagon/translate.c  |  3 ++-
>   target/m68k/translate.c     |  2 +-
>   target/mips/tcg/translate.c | 12 ++++++------
>   5 files changed, 14 insertions(+), 12 deletions(-)

Queued, thanks.

r~

