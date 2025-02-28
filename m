Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50E1C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3p9-0003Ma-AK; Fri, 28 Feb 2025 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3oj-0003Es-DA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:06:31 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3oe-0008LJ-NL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:06:29 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2230c74c8b6so70051395ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740762380; x=1741367180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BLDXQI3B841zPaUAVHiagUAciGUWDUzyQV0h5hS2yKY=;
 b=RV2PWm7pbp3lCihOExUUr+Pf9EAaf5s9K1vCLMzC683BLhZJbBLcJoWqVNML9TeKrw
 gdZHcIO19VRfRptSNAxbVlsob3HsP+QbssLmqlOEm1sVIKe9XqsI1q3uCzXUrdavTmDI
 Zn3Rca5RH/fzlHgpmNflezewb5tEiJ0PtAvxTW//7r0ha/QVPqynfTprlSU+qa6wyD6b
 LGW9q/CzC6t+ik6f+QM94qRmHCjXBtMwUUkJgERoD/+/POfsevhWbIUAanO/ZkOs3L+E
 rGyDDT9tbcFpRlFMHjEgxtY+q1O2UZfbvUSplh0gYhGU+QpSank+Zqx5btZW7QutthxN
 fxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740762380; x=1741367180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BLDXQI3B841zPaUAVHiagUAciGUWDUzyQV0h5hS2yKY=;
 b=WkFHppmku2yYMCwrsF9OBiltMk3h9D5lWEs8ZOgGX/7zXduCATiOejmqBIJ4qK4GNW
 gTzf42KZAN9fmHxkMpzPPDO6KWn3RdphGfHGEAoPHoGwSrDRYjojj3OlDtfdPxFZTOrL
 hYeml+4MndnbGXo2c4WxLc8uMUUU3e+6Tn46brohfpJjk5lW8VLSEQU8TPmqGz7Lfb6S
 dHVtu/waHGHxm/hrreH8TAc9iQ2B22tTDC8CAGojRrek3Yy9Rehn97t2guWwsLPvz96n
 6btaCdsWFW8huLAoyZ9WBnj+SnCcO/GWlgcLQEAvkFrKPLAGhqQ/Sqmk2td7GHrTghj6
 eCpQ==
X-Gm-Message-State: AOJu0Yx+fSZGwybyT9VSP+UGYLe2a1S0jQ/Y7BlRl9ryZc+PQ6jaf+S7
 A/oilIcqDgoW5oR/E3ZmkTEXpG2nH3h0xNSrrkdBVZBzeMNTUZzRSq56t950CKe7eVIKbY1XsSG
 u
X-Gm-Gg: ASbGncvFX81ExZ3wKkFOlMfejx0pPjgN/m0oxdvvlvvA9MPAdNy/l1SNaJZWnbMNG4m
 kClu0VGAsxXU5X4NAVXWRz67A85SuEHd3+/T/bTXNywAhY4bj1JxMGfwW49n4/mW9rNVYEgWmGG
 2zKR7zD03UdlKS6eqHFEk7yEjd9huwYgBWtAJv/Y1pwvzojakTyuqLdo5z6JkhHEqMTOENk7m2f
 /qIkg+FsGLCTUI4ER9icWnh3/FSsou1k57sWgJ5Yk0v/T1FSlfiA6IBQM8f1o+iaRmketCLxbwm
 x+G5hI7VJSiZtN5tK9B/4D2FYgKHidUcUSZypQZ5zkGAwZFIZd5iQt/I6xmoFCUx4nskp1wz2bi
 5kToVK+w=
X-Google-Smtp-Source: AGHT+IHhInRqxSGImZmTfTU3t/zEZM5SmIO4JNQJcFalIO2hxgEnd7v6V7qHEg5x3rxMke0+0qsCHQ==
X-Received: by 2002:a05:6a20:3d85:b0:1f1:b6a:65cd with SMTP id
 adf61e73a8af0-1f2f4e0189dmr7404553637.37.1740762380442; 
 Fri, 28 Feb 2025 09:06:20 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024c81sm3965570b3a.118.2025.02.28.09.06.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 09:06:19 -0800 (PST)
Message-ID: <6a95b83a-907d-4e87-9676-9bc90a2f66bd@linaro.org>
Date: Fri, 28 Feb 2025 09:06:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] tests/functional: skip memaddr tests on 32-bit
 builds
To: qemu-devel@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-6-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228102738.3064045-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/28/25 02:27, Daniel P. Berrangé wrote:
> If the QEMU binary was built for a 32-bit ELF target we cannot run the
> memory address space tests as they all require ability to address more
> RAM that can be represented on 32-bit.
> 
> We can't use a decorator to skip the tests as we need setUp() to run to
> pick the QEMU binary, thus we must call a method at the start of each
> test to check and skip it. The functional result is effectively the
> same as using a decorator, just less pretty. This code will go away when
> 32-bit hosts are full dropped from QEMU.
> 
> The code allows any non-ELF target since all macOS versions supported
> at 64-bit only and we already dropped support for 32-bit Windows.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/test_mem_addr_space.py | 34 +++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

