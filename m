Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B62C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNE8I-0001uI-Cc; Fri, 28 Jun 2024 12:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE8F-0001qU-Gb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:07:27 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNE8C-0007P2-6s
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:07:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-706aab1b7ffso704968b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719590843; x=1720195643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujDxA/RukhAIPc4v54vTeVTjoZ5pFSlafjqAMJ1sNJU=;
 b=TpLNjU91eboBjrLf/lBS6hr/oZhcbkYhfrigsVdq4svomO1SGHdO5Xz9KzpIfHEUZ6
 yXsl5Q53ZERxMXqfI0ly8YEf3Ii0sEPOS3YdNOy7aI1YjNv6wIqdDPqZfrCBWBpOCEfp
 t8pRATDaQXvqgPhXJ3nVTGBfR0DtlB8sGLzc7LlrbzWkGTCyXO377NLSGLMDku9vU6qf
 5VwAxYFor2mRw+6tyDTT7ZX/lWO1bVPNaEUljseKVZPl2QakiL7UEABFRh3U9tr6Px46
 sXyZ+k5xZX9uE9AtS/2c8n9q3c/xy72lLXMJzqc1gewDlA8WoGc6lRVQkPKEPX0Lsc/A
 vBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719590843; x=1720195643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujDxA/RukhAIPc4v54vTeVTjoZ5pFSlafjqAMJ1sNJU=;
 b=RfusmLwDyWshdkzu37Tw5Q8MDdyEJP5YVIsxjUGEzqwKrfB02OY3JqkvRfXFMsdfIy
 s7SgiedBCBym+i/pzCDrx+YsJd+OAwPqrP6gdrCWrcwfC8QZobJPApjOE/tGUNrX5rSq
 M0NZnKulBBhk8tuUQGTgEQHtukRZDmzeWVdAUr6qM8NNOhyhUMG6UpCTAkho0RlimLDv
 lueKTnWC0UAAKlxGD0+n0thMNiI+q0kLC5WP0eKr9hg0eRpfh/gFB3hq1nSSQfKjK4mV
 Eo2Rnwm8mvpMbHE7/Rk+DZ0BdyWWme7wVHF08WgpTiAeKVc3lBLa3z0wh2zhKbN4dE/Z
 TQWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQFNFJwYY582UeVoO0S9MtQKcPthgMF34P3FFZQFUuPIpnQcYwO+sZThbDUM1FqJUF1YebLg3S2+wm9x9uS+7YlEeEvEU=
X-Gm-Message-State: AOJu0YwJPJ4VQDMtY5IaCF7mP6uilg7FQpnmqGE7AKtDtZyJ29h08Nwh
 8bz2qFNQ2nEb0JuhHGn9lNIpR3lF0LP7hzk2FyNbqVS2muCKPTpMfhs1DSOKsHo=
X-Google-Smtp-Source: AGHT+IFXhIjzYr3DGR8jKfrakxXUePeHkcjvCrd5RQ7l+is2fuucUaqk41yOn0F4J2IwHNJqzGe73g==
X-Received: by 2002:a05:6a21:3282:b0:1be:d7b1:2869 with SMTP id
 adf61e73a8af0-1bed7b12b8emr5815742637.56.1719590842660; 
 Fri, 28 Jun 2024 09:07:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246a92asm1782563b3a.47.2024.06.28.09.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:07:21 -0700 (PDT)
Message-ID: <3384e8a4-bd60-4d66-9c45-bd04de45af2c@linaro.org>
Date: Fri, 28 Jun 2024 09:07:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/arm: Rename FPCR_ QC, NZCV macros to FPSR_
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/28/24 07:23, Peter Maydell wrote:
> The QC, N, Z, C, V bits live in the FPSR, not the FPCR. Rename the
> macros that define these bits accordingly.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h                  | 17 ++++++++++-------
>   target/arm/tcg/mve_helper.c       |  8 ++++----
>   target/arm/tcg/translate-m-nocp.c | 16 ++++++++--------
>   target/arm/tcg/translate-vfp.c    |  2 +-
>   target/arm/vfp_helper.c           |  8 ++++----
>   5 files changed, 27 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

