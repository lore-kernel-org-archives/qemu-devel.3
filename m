Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A053C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublh7-00081V-Ll; Tue, 15 Jul 2025 15:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublIo-0007J7-4A
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:26:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublIm-0007UT-I2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:26:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so17352165e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752607613; x=1753212413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WeNsVc63Dd1tXhVI5WFTRhQLDguuhWPssejM6aIcOn8=;
 b=jOUw1mkUzB8CdzXfwa9cDGO+tuL5wPypRfRmwuogUa7egde7ZX0bvg1KwcQIivecrn
 n15gHolgaqXkBNXvvqgc9/z/noMgpFuRFBaCAd9XCohToY3jQR1NmS3q5ocR2x1467Cr
 3JCEW3j0FgB0uOtP1OzQOiWDMD4c6tC3JRFm8sIVE+NQkrEn3oPdJcbWu9RHoPsy9ic9
 UYySGep6MzeXtjfj6+Xb4nodFNTQCaB4ESZgOCANWT9Fh9JkFNNIwaMPL+YBX7rL7/19
 5PePKL4x2QNEVK3MfIxpRmin3xc6uRxllAZ4bySjYdmDCBOacrDZzMt9fcI/kQ4pm7wN
 7gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752607613; x=1753212413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeNsVc63Dd1tXhVI5WFTRhQLDguuhWPssejM6aIcOn8=;
 b=RD/pmAMzdbQL6m3o874KEvxFNjzd29b2JyrPQKy8wqSbXodltjPLc4jVqHRwgLaXqK
 KAY4hf4Lvp91Oix4jmuINQAJH6Y3Hk/2Mj9zDSyins3YcphvTNb1UzKfYLiHrgmu8/3F
 0ZMyJbdKATrHJnfKkTHE2zGqju3VVLGbfzdG7BQ5Sz/QuA0QVxF98MbclGTisElva2Qt
 50VuKFFlBY6fTW6Pf+VhjNZKsmk8bxt3n6YzW5NeOZ44tluCj4IzLPwZxVmlvuAcU6/X
 bFJWCzIbYnsUxjVZP1kmG97VKpsk6Nboav0m3Mf5HjHlgmBrVU3AR6OIVoopI/qpeoSN
 1oQA==
X-Gm-Message-State: AOJu0YzCgDK9FXvp8FmN/KfO+/hTMo/7rFAa49+kYVuO5V3LlQSwqM7O
 sn00Esb8vpc/79tFC7dkstGIGg3oBHFBpYy+mhk/F1LxekRswa3DhFGVtQHGcRPEbbzlhzGGiwF
 bDBdN
X-Gm-Gg: ASbGncv1vMklRH9eqkjW4YgtAxIJ5JTCwp9LWPX5ozNMmxavHuQ1i5j6DZFCfA9tbka
 wp4zbcbeaGvIUSpFmKTEfplI6W068bKTBaAs0pG0wz49f2zX3hQd7yAmnQ330IMSGxlEttVzcsJ
 ZmDv65f90Mc1oikHwofW58eZ+Qw1XS8bcqNq1h8V7GGW4l/T9Vj71zFP2U999mBsH7ubt2wDcq0
 6+m5seFfKvscuUScmbOKgiAdQSSaawyBYNdoEkcG0Elo0TenugTs6hG31R1tWe55OQRLE0BDfif
 TAjTirRJchP1MRxNZ3I5ynN6fLGMkn1qJ9kI+6cF/P78YNKKyxwSUuW8fAX3PXDlulXHSA33kiE
 ZcC9KCgZhSeyb+lQ77LkYIMIBm1jZJtGQXJQMGQAFmK2dpwoG+069uWAOOKW+19eBuhsqCwc=
X-Google-Smtp-Source: AGHT+IExpto0aNUMX2aPdmzm85uLMAwC4KVgxqpvAqgYUMoH+kw2NP1NJ3YR2pZhtGVyLHuCv6ZjVg==
X-Received: by 2002:adf:9cc7:0:b0:3a6:d93e:5282 with SMTP id
 ffacd0b85a97d-3b60dd8b2d1mr250433f8f.59.1752607613476; 
 Tue, 15 Jul 2025 12:26:53 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5easm15687369f8f.48.2025.07.15.12.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 12:26:52 -0700 (PDT)
Message-ID: <8c75423c-fa7c-4b1d-a6e4-06795003d6cf@linaro.org>
Date: Tue, 15 Jul 2025 21:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] system/runstate: Document
 qemu_add_vm_change_state_handler_prio* in hdr
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20250715171920.89670-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715171920.89670-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/7/25 19:19, Philippe Mathieu-Daudé wrote:
> Generally APIs to the rest of QEMU should be documented in the headers.
> Comments on individual functions or internal details are fine to live
> in the C files. Make qemu_add_vm_change_state_handler_prio[_full]()
> docstrings consistent by moving them from source to header.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250703173248.44995-4-philmd@linaro.org>
> ---
>   include/system/runstate.h | 30 ++++++++++++++++++++++++++++++
>   system/runstate.c         | 30 ------------------------------
>   2 files changed, 30 insertions(+), 30 deletions(-)

Queued, thanks.

