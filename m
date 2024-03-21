Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB915C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnPsq-0007qc-Cu; Thu, 21 Mar 2024 17:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnPso-0007q4-Co
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:23:30 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnPsZ-0000xE-Eh
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:23:30 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-789f00aba19so108706585a.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711056194; x=1711660994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6P1ZSckkzqtH33i16SK242Wbjxkz1QVRrW5HUDK9ko=;
 b=EratiUnl3PDq9PfmVoDfkl5ZBkHv2v8J+U6FX8sdybpIK0euJiiVYH1q78SFNpblq1
 VTEgi8au30DwudRPgNXs4BqdZLUKke8a0hwPKdiTZbLrBzj+8AXZ57N5kffM2ya5eaq0
 h3P+QNBhcLXTwDjhx8+ONjLUa3Zdg9lCPN7zy8KT5P3bQWLfUTJDYQUhxrTY6HIhaLli
 kwzHaC6oMz99PpVQE0k5lquYcyp17MA6JDxwXL12CnUcei606BfeRX9icl+20+jBWIo1
 fgxw5qJbaJA28S9Z3DHkdJ/dwsq0nun+iCFUfjdjqAq6j9VV2rJUSpgiB8J8PMSGQ/HV
 Z+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711056194; x=1711660994;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6P1ZSckkzqtH33i16SK242Wbjxkz1QVRrW5HUDK9ko=;
 b=HhOAH7kbrBs3LUmx+ymgOhVMXN006cinovMK+QAvc00unIA0rgWqlqPHn9XBR+WIIs
 KBPZOLtbxEb9PFXa4vUC0Xzpdtj+b2eWE81UOSrP7XAs0HWwucfZ1rs43lsD7AvpEm96
 ewhMgKq7QvJFNpLqhUyLMDQX2Jmf3BHuhBM9YPx3Hoj6WI8rbAFA9UfLYKG6DdgbBObf
 jx5KZAj4DLm2nPpYEfThhuc9MmPLoK+b+Ay5XeR7EE9UjMj0totb4qKJk3PCDd/AUGPe
 3cwlMuFjFIJlx+myLAV7LBwXt9EqUO4RMzpi62qjc+jjSJSa+aSgy+Oqfi4BrVcMUF3S
 1jxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqAkgZSoMkEp1ZQ8LcNm4uJWFaw9EHeHqz3uetjE/tmzfW3fKZP4zfaXKq04pFurt9RSt5iyiq0QEIMSoJsdCHHpZGHYc=
X-Gm-Message-State: AOJu0YxYxgfNOEND6o3nNBexszyXKW2aGjuOo1vAPD1LfObwzxbUQnlO
 iVSm4ynNQW1jhp4imv6NRAcEF68wbXfDIKmZPKqxfF/fGBD0w6ytga1EJMCRHd3aTzFOKPUD4fp
 3
X-Google-Smtp-Source: AGHT+IE1k0qnIXz/8BMt2wR3BO8eaFKCWN7NoKVjpwVyjJVDGOY796QpCVDMyx5Sb0hTnfrozSE1yA==
X-Received: by 2002:a05:6a20:431f:b0:1a3:a1c8:96bf with SMTP id
 h31-20020a056a20431f00b001a3a1c896bfmr212948pzk.38.1711055841171; 
 Thu, 21 Mar 2024 14:17:21 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g35-20020a632023000000b005e43cb66a7asm316418pgg.87.2024.03.21.14.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:17:20 -0700 (PDT)
Message-ID: <63b472f4-f98e-40ef-ac42-78365dcca104@linaro.org>
Date: Thu, 21 Mar 2024 11:17:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 02/21] hw/core: Remove check on NEED_CPU_H in
 tcg-cpu-ops.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> Commit fd3f7d24d4 ("include/hw/core: Remove i386 conditional
> on fake_user_interrupt") remove the need to check on NEED_CPU_H.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

