Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8ACC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E9H-0003Wy-Bq; Wed, 15 May 2024 08:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E9D-0003WZ-OS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:54:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E9C-0000nn-7u
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:54:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so22744575e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777656; x=1716382456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/+377RyfzSiY4pArYCYtBJvnk6YyLxdbJVypWY7Z+Aw=;
 b=m95K0s3Ga/U77ZnG8wIktjQNCLTtfXbAUz53Ru/QmMtn6KtBSsGQqWON0m7gsELe+l
 nWkTjIUMfawtLp+vXAw7/XBDbMfuQlXmuRclIk+p+B5WuvI4gDnLJIF2iZabTdVsqFOH
 BwwqaUdT8y5oAE6cqywEM+36DXG8dF2/cl6SQeaYlkv1JVinnq4urqWycUw+ZH3nX/fh
 tEWBCyFr9jGYNn7zc94VDEafuAOoyqwSqxaUC9byF3d7oaJ/S8jn++MUPo5JPQUBcTzR
 QNXn/TIOeARaGWsz93W8egcyjjL5MfujCp5s5jJCakjMY+X+DDVIrRudQmVIgFg5par/
 sOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777656; x=1716382456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+377RyfzSiY4pArYCYtBJvnk6YyLxdbJVypWY7Z+Aw=;
 b=jyqDhRcFfrEeJw2nmrC90XrHuulHnqbWHMqtBMW43/0daMO2OQCAFUAnpmKfR06aln
 TrEIW2z8bSZVUwXZ1zPC8HbZ86IaUDxwP2Qazy2W8H/85p/clMdgxXsPYy8ExW3M26uF
 meiDgzMvMj44bHp4qpZgK5cKkRn51X2gDwZyZN7dOSnslaZFLIWcNzCTP+FM+At1BtsT
 DqsX7dbuiloub2esbgk0IZwl8WbRpc7Z/Nnnp0iwZHrfIo1X15ye4VFCB/uhedzEl5l2
 mtnHSq2vqKUQdNSi5useES16dIVPokN4NMd1ggfSE51/6QDMgyi5q1AE3ZZmtW19UQLK
 hkNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ymABTg2s6/ztM/TDSAt4zJ6cLbnEzZMg7D+yraVRurxDRjnhxvtw+P51acqyasN6UR1/LcWlgQpGh6wEJTSu2LQudEU=
X-Gm-Message-State: AOJu0Yw6PrD0rqxIsVmkfCLBEjQeNmqjnGiKmmIxYi51a/WHoLAvLa4u
 bNwPYVpo9l+885DwW4gI5rI9V1jBASUnp5rT24LHkE7m7VnBAbQ4hBwLPP9llICbtmSBXUIVscT
 M
X-Google-Smtp-Source: AGHT+IFOty28Qvox3vGfQhMIpJJSEQJs0pm/rodDJ0Uh8NMPNjEMO0E81vil/GHIurP9NtO4C4HjaQ==
X-Received: by 2002:a05:600c:198a:b0:41b:fc3a:f1ef with SMTP id
 5b1f17b1804b1-41feac5a3damr105642185e9.33.1715777656591; 
 Wed, 15 May 2024 05:54:16 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce25d5sm233724725e9.14.2024.05.15.05.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:54:16 -0700 (PDT)
Message-ID: <0a3678ae-7676-4b05-b3b9-c67824735c82@linaro.org>
Date: Wed, 15 May 2024 14:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] ppc64: Compare all bits of CCR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> There are 32 bits in this register, and they are all valid
> comparision destinations.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu_reginfo_ppc64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



