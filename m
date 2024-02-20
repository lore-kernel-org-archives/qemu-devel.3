Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D2EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP2u-0006Ok-1r; Tue, 20 Feb 2024 07:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP2t-0006OR-1D
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:16:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP2i-0003x5-Dv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:16:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d18931a94so2687026f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431365; x=1709036165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7H0EUGaobq/gktfL3j8gq54UEmx/OaRDF8Dc0h1AGo4=;
 b=xSh3YC1l6wgmmKjQEsRIuMhSL/8z8XTihXTneX9M5AfmKGeiK7nWuhcqliZ6nstF25
 dwLu6/fYUy4WbPNYA6fhDoLBHLoMmv73792jTXbDU8cqajQ4w0kxNOJlTDQOcwtZMbBe
 JSY/H/6QrX4VLPeTahGKuTP4OsWATxvOAuF1DXOsk/KXgVk4N09y73teh6KIpArS6HHM
 kuSpfdK546GBKhO6sHAwV+O8voJue5HEEc0OSyNvv0r5d5q72kSreJOOr70dm1xOF9TD
 LGbY1jRMxjcfzZU3keBmHJN43ebbRgFCuJNI8ikRGpfp95XVi7WnvF41g1Qj3BzB2HzD
 jLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431365; x=1709036165;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7H0EUGaobq/gktfL3j8gq54UEmx/OaRDF8Dc0h1AGo4=;
 b=S2v88jgaZdruWDagca7hUfhhp0ICw5PzMd/NkK/0T/c3/PZX/mmE0s/huezMJnGKyX
 d3LfVimu+lR27hnd6GGEwzU06ItjNJzJlL7ZkTRnHPCGkggHQf6dQVAN5iwBm5tu8ru9
 MQTSDygSVheHkEr9Hd5X1OhBfEUTaYyDgt43uyQzUP/JIWgeou3gTWYbk6awzjKhRbRV
 Fv1RO4gCiiOQ1Q8sWL8ZK8Shu8L3AaSVtuYxS2bSEQ8bl1V8okN2+mgnWWeAEXHSM1ke
 lYaO2owouAhiVkvcUckppEtRrCpQfiXPQ6XUMMKH/AVx0g85MQrVJhk9UO8qdtEZS91D
 bfyw==
X-Gm-Message-State: AOJu0YzhR2hOFqzBX7LFybvEzpUhE3uR8Y0eLZj96BgkiIsfILRzJCPx
 5bSTjFplDCbr9XaHIgfKv73EBM/9Hh5+r7MRBtwuJ556h/ewrUo5YVaUjVw8Y6Y=
X-Google-Smtp-Source: AGHT+IEbfoRaA1cEvFeZNs9p2UQl9Rr544IQ8ynItBoujHmYFKqjDuvF7TEydPobgeFWnDbrR3uj5Q==
X-Received: by 2002:a5d:43c4:0:b0:33d:3566:b5c8 with SMTP id
 v4-20020a5d43c4000000b0033d3566b5c8mr6079943wrr.13.1708431364691; 
 Tue, 20 Feb 2024 04:16:04 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:16:04 -0800 (PST)
Message-ID: <94650315-da1b-4aac-bec7-84911b9780d2@linaro.org>
Date: Tue, 20 Feb 2024 13:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/21] sh4: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <12425416adca441b07f7e3ecd4bb339096a7568b.1708419115.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <12425416adca441b07f7e3ecd4bb339096a7568b.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/2/24 09:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/sh4/sh7750_regs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



