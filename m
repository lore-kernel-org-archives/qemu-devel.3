Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3476C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYS69-000747-WD; Mon, 29 Jul 2024 11:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYS5x-0006tR-3j
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:15:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYS5t-00067W-CG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:15:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428163f7635so16231455e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266123; x=1722870923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=79xu6GwJt2tOSZjRUkS6x2bp/kSXLFMEOLWAaLfoTjo=;
 b=F8mA1Ri7bd4tcCJIvECqdnEJEwNa/JZ6Y40S6TE15PUnl0tHpVsS8YF+IptiyjecIo
 orxJlAvQgUXLtNji5oUEH8XvLbASwljJjy0LCSQ7Vt53qyor3rDJ1VVV/0XkyIcFwu3P
 rawbpAfVM3Pch+57seTREeTBa2XkWNvn8wIk7KQru+n33b0QaKzl7V08vabktgdCs8CS
 GIyPN4jLtdCDAyHl3eEIJ9qm7D1w/onrYKRcE//AwkeT63PO2OfRhlqzpkSYacNu6sbQ
 y9yCrYldCCDnChZE/CsEONkL5DEGGY5Dwjh2gtORuPy6lAfiKp8bu1n0ySbwAyPDfEn5
 9DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266123; x=1722870923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79xu6GwJt2tOSZjRUkS6x2bp/kSXLFMEOLWAaLfoTjo=;
 b=spPxbQR+4EQc5xjBAK2m+7MUukMSndCdYX84Bwa1+6zM876dszia1WAmkzwt7q47G6
 rtVJvRLf3I/en4FLTNaKF1hkVszQyT9nk4rsBWLij+lyN/gUYU1yP3vU/sPZ/f3gElbl
 vOV1dgonjokAhj9jgCw4jIJ2+alfv8uV1k4i1UH2qNlPvQGPHWHk3J3xTyJy/gsjleLP
 adGp4N+5k33UeesgkQjrICTZGeOhRpQriURRkX+LMJt47JLxEaqcW5qCyjLy1XSaM7wj
 ZH2/mg0d4pF7dtuBdjToU9fr8kWYYgBKtGl7JFmQ+jmC3zG8ali84JWJf0YsuEIr9N9Y
 BIUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7aQaYzmvZE4EnwEcjHNDPqzUQ8A3N9d+ROZELjG2Tbnua6stmy7Ujm6nsVelLRvZJ4jYtau9exKPQJFbzdrIVlAka6C0=
X-Gm-Message-State: AOJu0YxyMrO9Woi39t8nszj5jypRMPx2d/gE4MdO2Uzq7we9pkIS2OZJ
 l4ksuTybRoMkimvNPLWhBvse88ZDuQhM979PkZBsbU1VS80pTw8CPQmIDyNz1mQ=
X-Google-Smtp-Source: AGHT+IF6nc5Y+e2eOcabdpkPzuygIXcrytI+wRNmlOTnBDBa1WK+EeAGe2UPQng2y/E8HyELyGQXTQ==
X-Received: by 2002:a05:600c:2143:b0:426:5471:156a with SMTP id
 5b1f17b1804b1-42811d86408mr53805875e9.13.1722266123436; 
 Mon, 29 Jul 2024 08:15:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280a867e7esm136621325e9.27.2024.07.29.08.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 08:15:22 -0700 (PDT)
Message-ID: <15dd571f-e4c2-4eac-a0f2-a056f63843fa@linaro.org>
Date: Mon, 29 Jul 2024 17:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] tests/tcg: move test plugins into tcg subdir
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-10-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240729144414.830369-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/7/24 16:44, Alex Bennée wrote:
> You cannot use plugins without TCG enabled so it doesn't make sense to
> have them separated off in the test directory structure. While we are
> at it rename the directory to plugins to reflect the plural nature of
> the directory and match up with contrib/plugins.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                               | 2 +-
>   tests/{plugin => tcg/plugins}/bb.c        | 0
>   tests/{plugin => tcg/plugins}/empty.c     | 0
>   tests/{plugin => tcg/plugins}/inline.c    | 0
>   tests/{plugin => tcg/plugins}/insn.c      | 0
>   tests/{plugin => tcg/plugins}/mem.c       | 0
>   tests/{plugin => tcg/plugins}/syscall.c   | 0
>   tests/avocado/tcg_plugins.py              | 4 ++--
>   tests/meson.build                         | 2 +-
>   tests/tcg/Makefile.target                 | 4 ++--
>   tests/{plugin => tcg/plugins}/meson.build | 6 +++---
>   11 files changed, 9 insertions(+), 9 deletions(-)
>   rename tests/{plugin => tcg/plugins}/bb.c (100%)
>   rename tests/{plugin => tcg/plugins}/empty.c (100%)
>   rename tests/{plugin => tcg/plugins}/inline.c (100%)
>   rename tests/{plugin => tcg/plugins}/insn.c (100%)
>   rename tests/{plugin => tcg/plugins}/mem.c (100%)
>   rename tests/{plugin => tcg/plugins}/syscall.c (100%)
>   rename tests/{plugin => tcg/plugins}/meson.build (70%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


