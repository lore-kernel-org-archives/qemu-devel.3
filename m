Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B67C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thtRs-0000yh-UH; Tue, 11 Feb 2025 11:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thtRr-0000yS-Fb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:49:23 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thtRp-00043e-LT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:49:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f92258aa6so66025895ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739292560; x=1739897360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A/SpX0pZCMH6Nx4aU5binfZTiKllhdOFr9p/c1lzc4Q=;
 b=juIOPoA1IMIvw8qFPjJB9yQT7yIJ3LYeXPaC+wQtjK/RBKx8pDi9UaQ4OBaXB3hc3A
 w1+0kcbTajTQmV5HkmKi5FR/gWW0+qbsdKWIwUsJMf7Qfh7GZLO1Q/vcNe62D/F8n+KV
 OFFetKBfASUOCNbXOOmzxLL3D9yG0uSrSdDDHz0+Crs5x5uoJrdYsdXooK+idqWkdMIF
 1u2K2Ovbc8WgI5/s2SXiHROdb50A6Gs1N7gyfk36jSaM3CRZYfSX0o9mD2fdF9xCH5eV
 v2NvsBCDNqMP4WUgCNqaL6Gr4FlFm4oP/9d4yZwDi5GiroYUuTDM/NsKWjmhYpO/FZsh
 zRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739292560; x=1739897360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A/SpX0pZCMH6Nx4aU5binfZTiKllhdOFr9p/c1lzc4Q=;
 b=TMAdoVm8VSTaPmIVZL2aakr5h1yl84Hxp0VcF8KG9bvCmWoT5cvgc7fbjzUEzub/6m
 s9zZhW1444XWY6lK+nr/SVRn38b5+ijzLf+bk0SFC0mfXFeOPatx8BjjejuuTW3U6jj+
 GGhQxuET8aw1u9fik6tZhc8BAo+Gu3nCh6HCWr0z9o94iwDviAcIT6Qxh4X3x//SuwRV
 0i8/sBJ3jWh+z2+pN3LCqgb3UUBDHKTE+xk5S7b1Yq6JliOeb0dNJEjauSCe+mNcUaah
 n6B8JnuTPsUDLd56V7bqoCuM0nqJLOORD7H2G+j0zbC7E/jTjzlC+Tk5IfP4yjGpaGtJ
 voEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoPa5pN7i/okWyQbdzDUup9RQXgnw3hMg2rTbztCOJfGUWtCAgjvYII8hXVGbH9OotT4SlS9LQqr/Q@nongnu.org
X-Gm-Message-State: AOJu0YyQtq1/9ABYpZkInhTBMpDprfH+O1bCz77ZMcFo1K2bgCfNADCI
 qA1EvtMxyTKbkA2F6X3T8+V10TkKVO86o2aT3Co2fAiQ4LQeAD8HLTMxWVR2KAdsjT6r062ywMH
 a
X-Gm-Gg: ASbGnctsgRnFmsYmb9EU7NYaSp3Aml/K/A+5SQZXxswSl9nOOZtC/aGpsR+e6tNoKcn
 ScuqDScTlhq96iPOPndoQtRpXsTzId12597tvi57wDMfVSiZ6p4HjmgPY6KIiN4aAk3bSrXczaS
 OM5xj0lzjA/0zoNXjd3d43M4NzUtn+pb5R3zPmKzDJJcKFU5R8qMh0ZDkkfuVHtw60t59WmaUCB
 GSPCsaHThujfTg/SmkIV/fTiE4pf2Di8V4TUbhQaNj7DCba2CTUDFyH1kFRcMLKo4DkRxVtF91T
 0ra7xGMvlfmMxTBAp2KHRUu10aiapwqx91wht+i4b9205ay4uZx6Btw=
X-Google-Smtp-Source: AGHT+IFcWyt3H8T7XWr2MaYiSzbJI9/x8x2FLTPkY1ONySpUCFZBbftZKr9oUXaPK0slUMMJm5GvSA==
X-Received: by 2002:a17:903:1c8:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-21f4e7e658dmr294002555ad.53.1739292559890; 
 Tue, 11 Feb 2025 08:49:19 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36896774sm99449835ad.214.2025.02.11.08.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 08:49:19 -0800 (PST)
Message-ID: <52d24c8e-b005-4223-9b26-57885ec3d67d@linaro.org>
Date: Tue, 11 Feb 2025 08:49:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Do not mix exception flags and FPCR bits
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250211162604.83446-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250211162604.83446-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/11/25 08:26, Philippe Mathieu-Daudé wrote:
> get_float_exception_flags() returns exception flags,
> which are distinct from the FPCR bits used as error code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250211130626.3940412-1-peter.maydell@linaro.org>
> ---
>   target/alpha/fpu_helper.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)

Yes, this is clearer.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


