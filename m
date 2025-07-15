Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD35C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYkw-0005dV-Q9; Tue, 15 Jul 2025 02:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYkr-0005bH-Kr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:03:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYkp-00016H-3m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:03:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a522224582so2537371f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752559367; x=1753164167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/KbdVEGVhlArdmGaFpd7noZRBuOguuur2eaUTHaHIk=;
 b=gTnm6A2piC/Sj2Y4aUcaKlCm6DD9edD4KGIxMJTBN0V+Z59BTQQI/aGMw0q/fHHYs4
 T3QXtY6lkWTSI+sLTlCSss1li+MH5gFRhG5Bryd02+vtuTQHewhShbUgH7/1/l1Gr8WY
 0KJvNi4v5PbU9SQByqHem+UxMGeu7f/zoGjAqAjTT8yeUckqerSJ6NHz1lToMezbaq7S
 wKDl/JHIpUz4dmANcSZrJBZLzMPRcN9QLXgt5TgJtV3Cy58ZK8tbZjpu3tfe30eRF/90
 ehale22uBOyMa3XfWFYAvvOrXEaRkqn/53thTfjmMtwOU92JVraVysL896eU5cWB7KSU
 /Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559367; x=1753164167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/KbdVEGVhlArdmGaFpd7noZRBuOguuur2eaUTHaHIk=;
 b=lFMaOe5ws6x1UW0hfEYGnLViBRdzCPOwlSENnPY81O/3iJLUl6BoYkrF63iAg9kGdG
 uUQ4xdR33XFzzVXRKdenepjlH0Wu9q6phaQKB8BI17AKGtEivh4OB6/UlkhFYc+lBw4s
 iuNjJkWV6YRL1EQkwLzyogUVTSc3KYqO0e5aNNayW2nowsazuCARzsZ4vKI+prYH0JY4
 ynywX4ik91ovXeUC3kHjPeZtRo8pqRdWu7XmLW6+iaZajcTCdn4Ee6yoOFIDCx+36E9N
 eu502iywiT76YQvXSWlByLgyzGWshBHej/ATPGEUr4snv7a3K7Ww634eMC/VkIMPs5R/
 5Hiw==
X-Gm-Message-State: AOJu0YxTLmxNBL6eKtMVP5H3qkGjYYWqob3F89Uyg6j1qi0Vlb10VSia
 6e4DkaRwhpThURxyeXRRupkPKqIzTGB+Kk1WYxm1qErYsR4o9PXCnS1M0x09lJflU4yEnaHenGw
 nFmXI
X-Gm-Gg: ASbGnctmAZ6kOnVNIUzU+W/1gfqjr7zeTbHMVjUAcyKpF0tV2lcuHVhKlhOInSqa+IN
 keOA7LWb+wfxeTaL1xnury9eoNT2oumuDYHidDVGQKPTUY8ZEXgIEITb1sjPgPCRiFzMS2dCw9H
 gekJlVVZxetP6ZYD+KbROIHCArH8Iy+jOaVnMmcvbXDbLnHHlASl7KuHbvKyHHRVoPCtNaftbIR
 zBBHpHMbsRWOwt56siMhIuM7WIIUDOrSFleR4CBmDY95fQqHkYAqZ362QoXfY6B/9C+zfwsgdIP
 Ro0Py+OKBsOH2m1Nop9DXmzmdqtHCzrhrccKuUjh2HAfWLo2uXBnPySC+efp+KwwZbrS5YZDjUA
 QiECMCcp0blrtzAf6vgSAEvUPkN8CtMY5IVBcHk87ldD5PDsFnlG3bt23ZfhHTp1NmA==
X-Google-Smtp-Source: AGHT+IFQxIPdBaFpoYguLPHytHcFOSZe4ZrViKzTOpBwCS6XHi9K8sl+O3rdlDlXRvw/wlkH3K+mlg==
X-Received: by 2002:a05:6000:230f:b0:3a6:cfca:efee with SMTP id
 ffacd0b85a97d-3b5f35305c9mr12464910f8f.17.1752559367113; 
 Mon, 14 Jul 2025 23:02:47 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26daasm14519875f8f.91.2025.07.14.23.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:02:46 -0700 (PDT)
Message-ID: <623d9b63-27c2-4f37-87e7-de0b54bdfef9@linaro.org>
Date: Tue, 15 Jul 2025 08:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] target/mips: Convert nanoMIPS LSA opcode to
 decodetree
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 26/11/24 14:59, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Fix translator_ld() calls
> - Add support for 48-bit nanoMIPS opcodes
> - Convert Load Immediate opcode
> ---
> 
> Prepare buildsys to decode micro/nanoMIPS opcodes using
> the decodetree script.
> Simplify gen_lsa/dsa() and convert micro/nanoMIPS LSA
> opcode to decodetree.
> 
> Philippe Mathieu-Daudé (16):
>    target/mips: Extract gen_base_index_addr() helper
>    target/mips: Extract generic gen_lx() helper
>    target/mips: Convert Octeon LX instructions to decodetree

>    target/mips: Have gen_[d]lsa() callers add 1 to shift amount argument

Patches 1-3 & 5 queued.

