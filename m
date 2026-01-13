Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AEECF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfT9w-0001Fu-7q; Mon, 12 Jan 2026 20:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT9k-0001D9-Hg
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:25:13 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT9j-0002oy-2v
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:25:12 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81f3c14027cso1262865b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768267510; x=1768872310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XiQK1KwnkUSyuyhtVy+kNGdeCjbZ9iHhdXohnMaXpU0=;
 b=ma1WZFnkhfXL36lqsEveKMzmIdIC12GRYtMOjvMh48uDFGqytgo+H/2JjKPRfgeJOw
 7RyHR1jj4dk/2TkZsm4DMac1NPc2Egz2VdE3fGXWDicij77WYiYxQSEKnPxZ+7w9bGLB
 f1YGxcCPp2X4vaqBqKGzXyFdUjTHOx2+kyZb60bfWxSnszR3s0p6cKQfCccjpgdBAiWK
 tv67tL6nLmjudXVjJtKou668GEV+zHwCAQFIrk4JODLivZzfjRQaIKbnISQmU8B0ybg/
 R1J3YoRuIpXMmnAy270BOCJu6newMZR9Wa/D/wsBrmC4Fj2r+ombhOt7H+z2l4te8PBK
 21pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267510; x=1768872310;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XiQK1KwnkUSyuyhtVy+kNGdeCjbZ9iHhdXohnMaXpU0=;
 b=ApTdxNlweAGEsDjs8ghnFOEozkGUVPLyjPtqlBTh0ISDjm2VnN+H4SF9csEkTcg+R7
 DCLKP95FzuGgrGnpEWoS3b7D8pDaRutt4ntNssxkXuFqRRlPz399MZvaMlBnMDKvS3HO
 SRLQF51PKBJ6Lf5wb69/0oUNfrCcZycts4+Dw5nCzJOYsP0KaTNy6fvzzTu/5FTiNihH
 Pmx9/AVIS8mzLGq7jNW/pikZ3Wi0M/IbL/wILW6fvwqnpGyt0gFXkJr9xpD0UN5pGxmU
 GCjUMmYTSlgvUp9HOZ6/9ry9pw/iGyoE7cK7WFeycb353YxE725WgsOolGUJAG2g4oTD
 Q/lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2V3qBEZcewDR8hJWHVOcMGlBKzuOkogPKPnGeqR64LUyNua6v2SRjCyDLD9d4kchS3OCPaenHLGqi@nongnu.org
X-Gm-Message-State: AOJu0YzhFKrGAW2XtpJvX3xDVEddOps9YQLaeQf3MddWUIfR7UmFSfyq
 RvkcBo0AtPuteuh/zlfBzotnaM5JNbOTQxk4gRCqjl9z+uLRJl9H6yb9wDRudrb8350=
X-Gm-Gg: AY/fxX58I8EgmTyjpHwOjP0zLUsfqZ939RJlCv/8EDpEafEkMx21LNntndxkgV6/AtK
 YkN1HR2NhN1VlFtYpQayXVXas2ZGX1IBZ5thJHG6igo0cPbEtjRPC5SRw4N89khkmOPRm2KXRir
 q/TxyDWvhNZ4xjDlZSzeWffzPsoulc2c+Kd/oKWNiRwgQuUXaMg7pOGpF3eKS7IujAb8p7n7Ghc
 V7l8U+trmNRhbIjHKTXrujqwpqegJ1kmCc990Jf0ZJJVofxFMXlXRHCFwG/ryN1BpUT13rspETJ
 DL6/CGZNwnI0dieiKg/tLJKvN5dPFIpUpiYVpYABgZwcQwfqb2GYGiGVwZx2+BdP6o6vAnzdG2A
 enHWDn6WIOn1JykIaGI57Cbg8HiLv/4AzyTmIhYMxoWoMiBCY6kd2TjdIVgUsbVkSQE+e21QKPw
 q0ccoag0nR+FCpPoWELjyR+TkzabQ=
X-Received: by 2002:aa7:88c6:0:b0:80f:4667:a94a with SMTP id
 d2e1a72fcca58-81f6f74ed6amr907776b3a.10.1768267509494; 
 Mon, 12 Jan 2026 17:25:09 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bafe9b8dsm18571634b3a.22.2026.01.12.17.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 17:25:09 -0800 (PST)
Message-ID: <88d53232-08e1-499b-9b52-b307ec663719@linaro.org>
Date: Tue, 13 Jan 2026 12:24:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/12] include/hw: expand cpu_reset function docs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/26 01:34, Alex Bennée wrote:
> Add a hint to the developer that this should only be called from a
> reset chain.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/hw/core/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

