Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82CCC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfNA-0000JC-0R; Fri, 21 Mar 2025 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfN5-0000HM-56
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:37:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfN3-00055b-Is
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:37:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2241053582dso10792555ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742575025; x=1743179825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wd8JQPF6330iFbrfqEOHPqzvf3WyiSqrdPORWZKD/hg=;
 b=BCTq03S+55MGgQI+swj4SfHrugmejvrpz3vcIxuDpvMl1aMAZ0SZz7UDzhWJBkbK9k
 nWlfiCeKCwxl3xyGeDiRzmVNqKRbe8Z7fC5lNIBeAXUNsj+u6QRTASuzxIBFvZEHRXCw
 ZHAI8qS7BFrgynZLq/n4eG665tyF+xa3a+vlPDoge+qYG3QjtUkxmC9zVjcmuNHGDy+1
 F/lTCqRRCcryJaCNozqds+0BP7rZm5lOycghNBPCx3d7m8Tpk7uR9pRWaUKVyV/oQYVy
 lCssxdtTRS1FYGIbQVCcNGjk/Ioz9/OpcZlR0GloBHdXwBoLPZhkjTomyBEZYCl8PTb+
 9j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742575025; x=1743179825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wd8JQPF6330iFbrfqEOHPqzvf3WyiSqrdPORWZKD/hg=;
 b=wTn4s3s0492y19ZF5Fg2y/DIIDH3PiYIH3QNL6BXO/VfKyPqRsyB3KO5Xr8BrluX9W
 MXgqJMX0dB9vUC7mWeJLfmuFhQJ6ucT/JfqZdVQ79VvkfaZIEjDdI69glUmjssOyJhp/
 4eIMZSeOnvJv5H2nmbmo1xrFuZcAQbc2uwbcEiPDRVXfg0bxC9Vzi5jEpaxeEECUtAhj
 P+4plmlNK9IF3nuS7eEaYPVuo2ewPQvg7298aWlldqcRY/PgL/EZCxU+1bL3eekMJVgH
 p1TlBuhQzg5WH8peQeRCFu3qTF4A5b9hR0GUPZXvzCZuAEnihFIk7AEkqsuzIDD0iaaZ
 5cPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE3RqV8O5rJ6w3QfpKt22gFjC+xr7dipR0F1gw61zpTxRH2YnDmtxlbpLCVl6oPOQdaXBoDYRJp+sh@nongnu.org
X-Gm-Message-State: AOJu0YyNs+QpTVffGrTTXf1gFN83N5ezc4QOQ+CRWCQ1e8cLScpJ3hQQ
 LhlqMD3A7YEtNhyT1Syu0LYZxZ1XaXRDo5NO8X5VeZ3xE7Rd5o0Z9WCJ6M47BoI=
X-Gm-Gg: ASbGnctsbP9sK6zvLC9D0lvtU5wUfx7Twwf5chke/BORdbF3uFHeXeuRD2kx6QQsmiC
 jBy3dcPxx1/0XqylvUuDkyfpQOvlcVIT/4IOxYu9k4c89y6DEfTQmrR9Xh7IffYj/9wVwWj2gDq
 IrMvbT8AQKh35b+EKfbWP0kyu5R1Ojxpakzbg5Ed3StMgWWC7Z+qG5i86m3P0x7hN/tVLXq3p1s
 0SeR/FmNeafPTQzes86JkYsu9omJj42x2Ode/bfY5P6RRiC9PwLIFdp76cYGT3d1wVwEUxaOJ1P
 h7b0mvenP0as1c+AXWfTmM08x8CfHHv0cw6QoXhzIiWXEmk9a5aCJ1zRgr+0P73YZR8qho/0BQh
 jZrvENP2p
X-Google-Smtp-Source: AGHT+IH312/S8AbQMYSlnowN41JPgfjb2YW1tfawXIKSwpgCXNTMnxdSiRZRFkLJzTfeH40cXjqH8Q==
X-Received: by 2002:a05:6a00:22cf:b0:736:a638:7f9e with SMTP id
 d2e1a72fcca58-739059667f0mr7619951b3a.8.1742575025097; 
 Fri, 21 Mar 2025 09:37:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158066sm2143401b3a.150.2025.03.21.09.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:37:04 -0700 (PDT)
Message-ID: <ebeaab45-ea1b-479e-8250-b263acb05cf2@linaro.org>
Date: Fri, 21 Mar 2025 09:37:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/30] exec/cpu-all: remove exec/page-protection include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

