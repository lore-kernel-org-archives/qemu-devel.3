Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C450C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Oki-0004EZ-LE; Fri, 25 Apr 2025 15:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OkR-00048x-NO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:30:08 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OkQ-0005jT-5M
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:30:07 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so2322734a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745609404; x=1746214204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9/pHZiL7KgAJL1LDCd0M15cII/sHW7SuSCDppxUoEA=;
 b=cOJ5/I7TH5BjfhugcaYw0lqhr3FaLxkeI1bTLbn5M5dtOCifbbZRXYz3VZX7n/etQw
 bb+07wasDOKhmj09l0cAk2Nc2khiOAjlIeEZM4gjFo7Xs4s1eR+iDo2qQzCAKDrbKY3B
 D0n3dr/bRl0NA6a1uDIcIJWTk8dflwv1JNby1ph15+shMBN9i4MCz2RUzMVc5Tk1beD+
 l0s/Mu+m3ohbLPrF9DFdfaCy+i0dLiIHxQdGlrPI8S8TDC8EWbWpV5ADNhmqfbnDBlm5
 sWT8EUZsRFUrLnoRztvZurEZPNmonkMtKUsuvstOGY7EWQxLeJhcSMUkqVclydmMVfdB
 14MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745609404; x=1746214204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9/pHZiL7KgAJL1LDCd0M15cII/sHW7SuSCDppxUoEA=;
 b=H+h3EbEbScGA06zwprE65+VaBnYSZBNAt6kBs9293P7+pM4qliFH1o3mXVoPjiKGk5
 kEA1SOKdy6SWflzSUSfpwt6d0v2ccn08oWaXQypj3ZjCyr7/JV8qKxg64SgRbQcdWE8A
 CrN3jcZFsKMg8a6tT+nXWjszI31FEel3y26CamG4VjB56twogjoSyU5s/mgcFdPqemJi
 fV4dACmv/b6Y0/MUc9chjRVPSbpq+M6MMWkFBEGUMLWw1tL/Z7H+1LY10Ymk2+OKVskz
 bEufFx5H7aiKH4Yhov4FsjbLq1jk5cpizU8EBzg8dOOQn3zB7La0laSbKaPBsA7LFEct
 DKVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDI2oXbmksGnqm7xhvZxbEIk8cPazztm4GDmaJDMY3d3rWhfNvGXaZepHgjy/HHqrERpTKk0Z94St6@nongnu.org
X-Gm-Message-State: AOJu0YxW8sVIyng7yuOeWF4IhYM1leeexIarTGgcYYvnXI1xgI+RTjAb
 Pvup+cfPO3zbqrLC/fm0ZCuS8UkjrT0kx57nYI+0Mes5UBJtnboH37kQikgP8Po=
X-Gm-Gg: ASbGnctjFPhI1pSMHaB+QeqQvlfYTEVKuDOTEHX4/IJ79vygco61klB8X/Jmox1GWKa
 QFz/PTixf1Z/8Y50GUtHBGj7f22trRHsGALDhje9TyXlSfhYLlXRnb5xoxCUwmrf5Osh2+skgDn
 hZ0F9AeXYZ2lXfpF09VjrBzbNDc/4O3o0f0BJeleLOzYpTwNcxoZYB7pz9sR4y/V87GN2uZrG/t
 GLMGdrIe7ZsHH8DSreHojR4w7HMrnBqGGCJ8u4zhJdxbLLGw14YuB1KxSIv1eHLzJyyU8XABCIJ
 Lz20JnWFt6mTAPL88VFo77lUPStWHqTZ8mu40QwJwAiiQyOyGnzAXw==
X-Google-Smtp-Source: AGHT+IGqDd6ag7mfS9xGSArE+qcyOxWAaGFneAIiCk7/dlgXMfk7/YA67imE9R7h4ZVDAzm7wNEqLA==
X-Received: by 2002:a17:90b:4a:b0:2fe:d766:ad95 with SMTP id
 98e67ed59e1d1-309f8d9a8edmr5560110a91.9.1745609404704; 
 Fri, 25 Apr 2025 12:30:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef1385d2sm3885846a91.41.2025.04.25.12.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:30:04 -0700 (PDT)
Message-ID: <bdbd5b82-f038-4dfe-898d-a2598ce09032@linaro.org>
Date: Fri, 25 Apr 2025 12:30:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] accel/tcg: Add CPUState argument to
 tb_invalidate_phys_page_unwind
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Replace existing usage of current_cpu.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 3 ++-
>   accel/tcg/tb-maint.c    | 8 ++++----
>   accel/tcg/user-exec.c   | 5 +++--
>   3 files changed, 9 insertions(+), 7 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


