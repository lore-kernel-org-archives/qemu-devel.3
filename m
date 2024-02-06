Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03132C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTIG-00072a-MA; Tue, 06 Feb 2024 16:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTIC-00070c-3k
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:47:50 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTI7-0007R1-D7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:47:47 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso63155ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707256062; x=1707860862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kiK++jBGLDa1a8zX6shw5bWxNOTq00UVzWc3Tp1TsKo=;
 b=VmQ/+O9w587DGpvNYjvQGy1rcA0aU+HBqdgbqk6wm18jQzDIWocOJeLmtt+QY40Ccd
 r998T6NrlocXsoHdY1PrpMJ0zWEZIx9epB8KvwGlmqAk+fSzUxksJMm8v31c6qR3IfxZ
 GN1z1AMYqMM5++YmhxWNcWQ7ZjJp9e+dUOYyeY47cTQ03v+Jq4xTp/6fGqouHD/hJu9b
 7fKVro9CLJcOQX0+cpVAbSTQ7cjmV6/JJTnTF7bblntSQhhUH7imo18F3d85ckn/OvI5
 glvzuDDW/n6hStbqygyUUPtxeOJHEn1ouobCRC0ltUvxyKQ7LPfoZzzLU5LpE8xLTCl4
 xENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707256062; x=1707860862;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kiK++jBGLDa1a8zX6shw5bWxNOTq00UVzWc3Tp1TsKo=;
 b=BzS5HE59/Q9mRHDPgb3ij1G+qYtah7jfGSCKhU/Zr+CiCY7rvJnohuShpUAOsFUDXk
 /vpNfojmM0w56crBlMnjMvhkO67b1HpMWa9MwkFhtIyLI1chVv0HL68R62SKh3vaQECx
 elJX5VGhCAso/D22Ujk9z54MGhQhd/ajSBr7ZyC5IOvP3E0FpQu8mYaZwyFF10qLkWnV
 GKx9ZlMJE3JHBhhfB27R6W/ekR/iJxMgCwOtYEUEwxQMYAUzxh0O6xzP1Sy7m4phZWrM
 oQZKqkMcm3jiWLX66FQ3bx0hKHNgfSlQuosL6Ruf9Ty2vdrBXtjvuD3nVtxphiNchFqs
 5pcQ==
X-Gm-Message-State: AOJu0YzdHImjazRuzeAe8xMfbdj8Iy5o9DLU59OSaHACWAhbUKwyEi2C
 ImlpgvU2HyltDmp/fwXpWm9FzurD9gCGNEr8P3qxsRchtFtfX/7WjqLtTDWy6pBOmzl3HYPjPsQ
 rLB0=
X-Google-Smtp-Source: AGHT+IEQEPeXgo4lfPUdA973hS1l/T5WuiWBCzLCxOTVvASNBPtwc8q5QXdNsFerXIk371SIPa02lg==
X-Received: by 2002:a17:902:7847:b0:1d9:af81:8b2b with SMTP id
 e7-20020a170902784700b001d9af818b2bmr2685619pln.67.1707256062201; 
 Tue, 06 Feb 2024 13:47:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWfTmOg4fn+HQMO9+MwAsF8YV8sgy2oAzydkUwBrkIWhhJKR5+3QaZ/SRF9cj6xx4qBywPVmYQ78DIt2YwmHTrEMXIRj/o9Q7UIthylzDl3r+ee1Gb9trXO48U=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170902ed8b00b001d940ae8ffasm2382196plj.6.2024.02.06.13.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 13:47:41 -0800 (PST)
Message-ID: <949bdebc-86b3-4714-8dba-59a3a0b1b920@linaro.org>
Date: Wed, 7 Feb 2024 07:47:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/misc/mps2-scc: Factor out which-board
 conditionals
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/6/24 23:29, Peter Maydell wrote:
> The MPS SCC device has a lot of different flavours for the various
> different MPS FPGA images, which look mostly similar but have
> differences in how particular registers are handled.  Currently we
> deal with this with a lot of open-coded checks on scc_partno(), but
> as we add more board types this is getting a bit hard to read.
> 
> Factor out the conditions into some functions which we can
> give more descriptive names to.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/misc/mps2-scc.c | 45 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

