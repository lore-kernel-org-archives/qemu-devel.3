Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A621C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qeC-0001tm-Ti; Thu, 24 Apr 2025 03:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qeB-0001ta-LA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:05:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qeA-00021u-4C
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:05:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so4033585e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745478319; x=1746083119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ey7ojlqiQRP+lqSWMendVLzLTDsM04BnHC1zzIAnTV0=;
 b=RCb9ZAMX5v97faWfNy5khC7Y9g4W2atNKFCzTKrHp23z9rTVxnJDXrgba1fdSETga6
 X+dMwq2C8+Tawt3W9a0wQdq/W8BsGJdAe2kM4ygbMjzo+x6TwmXIj/SYQ3mzYyLOKJCp
 Pothl9Dov3zn6pA0uPVjPj7BjkKflHeeyLuNqYQnF+lKuL9Fhtwh59JNIuAC0O420IWB
 56XjToMYDAchKs/iuYsn+VF/mq5bY1crh7M9zVaQtAx5Q9cuk5V6HgqrteI657a69K9N
 Ybc8gc9CJtUGGbhC3o2z3f9pZvFNECf4fupTlKaecSuYY2wLHf+wPpbz/CGoSLWr5pQt
 ekuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745478319; x=1746083119;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ey7ojlqiQRP+lqSWMendVLzLTDsM04BnHC1zzIAnTV0=;
 b=rGGxkLA5b5nVTG954BvKm5gIMVmSwH2KLwYueLgCuAxZ+DCOowTCWFKX1RejdWhokj
 219L32wgmMNotPEu/1B//s78xPyE/54/oDDC6S2b0fw969MF6CambF9I2Oi4piDV0aIb
 D983ubAqrCBSJXkLnoFXjhAc/hjb/nlra7sA0RPhjGKMTU3SfPjgPdBVsgG3VtI00BoW
 SDqZ+/sPoS6qHPjcMoBbR2yxJIWmgeIx09ndazZO7+aC60rxkRcQbtn34v088q2IUQyC
 J6h52FmhCgyKMMdrCH7/ttf28xZ2bdNc+1tsR37snyvjlnLyTwAyRlxvsPSW0lvj0l5n
 swmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTEj/R4LLAW5uSEW9voMVTN0g2WMIhz+w9ngI61HgRJILQRF0mYMngMUCKmhbbp2ZAYKK0EM/n6ShB@nongnu.org
X-Gm-Message-State: AOJu0YyQLOqhGGMRumsapbqgBX+fDSpsTmsBw7wj4+1ih8TRTIiMUsl0
 4WTfGhWmPVz3SmOyH7o9skUuhwe83qiqPX8XKWfsrba8xTiEULj9s7ralqDJXG8=
X-Gm-Gg: ASbGncu8psOh6ANmxrhkTLBjeH5uFlMXYkwqYQUFGkCXPSjNSkVv8i0AF+rgLVeY967
 cMYF1pyHy8/8l7Kda0vknv+ZTT4Id5WQsaLnLFb8KFW5skF/Qba/JHF7+zRgTFg9ekt7oCAnRJZ
 VSqBehut/+QT0u4DFCCx4+PlAABdfG8z7XDhrpMd/DYMLe6ula/uxaFdbHHsxLtkl1J79eCnFHh
 r8WJjdFpCW94qcupkgoDiQSjh/IhrABpidku9AkrQ+d34mhH1m+PlMk6O7LAw5XvHHnhEVgmXRx
 NHWg6QME7fbTsIdY2BcsI0YgUqfkcFkTGcU6FrUYV/3dglPy6ZES49Rl7jbisenSf0bFAXDvrJg
 /gfsoj2zGlKzdEQ==
X-Google-Smtp-Source: AGHT+IEVxlkpLobry2OgL0ab2GFiU5iTVOu/UNGV+aXRVS/oiVt5W+iUxsR7urs98igF25+PUqUIOw==
X-Received: by 2002:a05:600c:3b09:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-4409bd22d04mr12578695e9.16.1745478319332; 
 Thu, 24 Apr 2025 00:05:19 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54f00dsm1051029f8f.95.2025.04.24.00.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:05:18 -0700 (PDT)
Message-ID: <e07ad1ba-b534-46dd-ab8e-93c2fccd8b20@linaro.org>
Date: Thu, 24 Apr 2025 09:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] accel/tcg: Use vaddr for walk_memory_regions
 callback
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-13-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Anton Johansson <anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Use vaddr instead of target_ulong.  At the same time,
> use int instead of unsigned long for flags, to match
> page_set_flags().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h |  4 +---
>   accel/tcg/user-exec.c          | 10 +++++-----
>   linux-user/elfload.c           | 19 +++++++++----------
>   linux-user/syscall.c           |  8 ++++----
>   4 files changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


