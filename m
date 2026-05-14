Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB42CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNTLp-0005dU-Nj; Thu, 14 May 2026 06:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTLk-0005XK-FZ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:31:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTLg-00050D-IC
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:31:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso65109965e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778754682; x=1779359482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ahgo5fTR6W1xsiPAC5zBb+zXIjyB2rsYbCU63KUD+aA=;
 b=DQ3AOY2WMmDCbwTlS7mcU1ajpWTTgHTzo42Nh+90HtSUxKaLw2dPkmCHIwjukizMSd
 YOVzSyVm/wh4ofa2DJm++OcTakOG0yhwuA+DP2fXTd1eQlNS37EWCDg1XHmSa/r4asRC
 bWqVhT2PYM1iKQ35kHn+TVtmQSn5eQoAIr3M3S1GAh1WNH0tvE0dziSMolOYAG3FWZ2c
 7iQOgmYBQFXDo52VvvLurm14QOxlFbAjvY+xrXOvrtW86UaSJ3X7iHxowNiDDCBKG7X4
 a9cmryCGUgLpO56THi1pyc4lY+A5rEdZh45o81CgERS1T/SbXGzxC67dSt2brKg8IHsf
 UNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754682; x=1779359482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahgo5fTR6W1xsiPAC5zBb+zXIjyB2rsYbCU63KUD+aA=;
 b=OrthUleAithcJ4IhgjO7l+LO9r8NSJ2MTnJB5q6TAyfe82Q2Kvx3l1s4yYNAhGzTNA
 gF0S6vhPnvUDrz9Mu9GRqAscQc4cqg+3gzWppDhQkVLLv7NYRD8gagxoalJqNN5/sW4E
 jHdcLH+rqLnw41kSAOcpd4pJFRkR8z8GC0rNiiiE1S3IzFVwL7PDKzPeIHk+WO0ObrZm
 l1XcIyf3YCsZBmPnjDvoaryzTaafuYuf66ZOErxhXEY+lEmZObMbNSJCLT705UIjkUd9
 cFtooH8mMnD2QFC7SkqCP/KtdWYgiHA8K8zAx5tTKzlhAEGzRVUAMCmx3w8kJWt1/+TF
 F6Xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iKO5ZqDPjPTUgRO4uLEHsH9Ck5YTkbWU+DgUFvg7k0TKds7RqXrROtPUDZn/2ggJh2qfq+3zGpNDt@nongnu.org
X-Gm-Message-State: AOJu0Yzdzsw8osKd7Aw0L+3w/XSF6pEh8WUWB7BVd+Tcpu+ayoDLrwYB
 vffXN06RLXoM46LHWywu8H664+jRgILwvblp88r4Uz04Gr9fWkUzejqxBn5YELm/DTE=
X-Gm-Gg: Acq92OFu2mEfydiL6FFcaghiWomJMkelZ6sIU9OFTm9ELk4WaAS7+w/8uQ990MpleY0
 ew86t/LmieABCWqcbLUSAKf711RBpNcvK2n9owRxT57OA9r72vlG8GTc5zT1Td+9NtaJUxjYQZv
 m9OJ/cEtzERi2BLxin836hG2wqib0QRDlRdfx2IaUGId+VD7OwdY6cuiYq88vIaQpNsnz7xFH3f
 DuKzuSRGnNH+wBfz+AIctpUYWFxOtELq43wxRuEpaCVVLoML5Y+RQrvEau0gpDBbyEz3Irw7MLi
 hWUB/Fe20+/WKrgNTDtZqWFK31iNiHvIC25rHrKgmKf/WRa5NGIdyjy+GhdETpNfDsh8riNqsAI
 AkaUNq7BiTcwDz9tUBcTpYoXECOYWSZqMwzlh03vKW1QzEhiaqzXnKRbffaG7A1Bm+xXST7XtNH
 VwJ3/LMPy9e0X0B9lNfdUB0XOdgfKojcwlyuemin5L659akFNGyB0OOGa0re+TDBuqmK/ZcKtYc
 Z7/
X-Received: by 2002:a05:600c:a11b:b0:48e:6f39:f7be with SMTP id
 5b1f17b1804b1-48fdd59a82cmr17585225e9.10.1778754682162; 
 Thu, 14 May 2026 03:31:22 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64ceb45sm52703895e9.9.2026.05.14.03.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:31:21 -0700 (PDT)
Message-ID: <14920471-cbae-464b-a22d-3053c97e56ec@linaro.org>
Date: Thu, 14 May 2026 12:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/35] target/mips: drop Octeon zero-register fast paths
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-6-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-6-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/5/26 20:22, James Hilliard wrote:
> EXTS, CINS, and POP route their destination writes through
> gen_store_gpr(), which already discards writes to $zero. Remove the
> remaining translator fast paths for destination $zero so these Octeon
> instructions follow the same shape as BADDU/DMUL and the generic MIPS
> translator helpers.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Remove the remaining destination $zero fast paths and let
>      gen_store_gpr() discard writes to $zero.  (suggested by Richard
>      Henderson)
> ---
>   target/mips/tcg/octeon_translate.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'd logically expect this patch to follow #4 "fix Octeon arithmetic
destination handling".

