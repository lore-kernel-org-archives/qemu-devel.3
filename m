Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC9AC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRaWt-0000Y9-SC; Wed, 10 Jul 2024 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRaWs-0000W1-1S
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:50:54 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRaWq-0007JZ-Dk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:50:53 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c980b55741so4446a91.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720630250; x=1721235050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rbb6HySRWffGd9za3C4bs9y7igj8yfq6mdUsA0SHPoY=;
 b=d7/kYJ+aM71f+RqBISS843D9fKFpx3/xinYxKH5+bvk8nN/3HnDgHBJiiBceySKk/Z
 R4aHVWriyUo9DE7Cyytd7xBiOYzG5CP9QgFRT6mFQAgJnYezZhVYeMIhmkYnvP9+JvuD
 3isI9fj8AOVKq+rHsYYaD8b1G0VvyF2VoDUhvPQFDSY90nSBUL3vKA3DxOOqbMilkJxU
 T1AZufd1bymSzN/giOWqY94oVAsQABYWvWipFE4PhESXDmfpBS5zF+jCQiD+XIa7xQcI
 n7UMWy8J54jYWx6PNFH3nqgMB/S0hueI6+oo2M60G5NSczI0PioJowHdHzxusVvJhgaM
 32nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720630250; x=1721235050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rbb6HySRWffGd9za3C4bs9y7igj8yfq6mdUsA0SHPoY=;
 b=dbdH/CsanDyiX4pWXHdp0W+sqC+vnWxo0AOYmfjsQr5akex9hCQncwg+4CD06Lgwru
 CZrxCSBgs8FWnZDTvCUWxXc5Zd5MKIdAlxjlnfB1a1ya+2anm/3w9/UcLHvDnW3TCPGk
 rLv/b8dNZYz3F3gL/AdYXm5vEugYlunN8YsiJ9c+7Qfi0HFI4+wuJEeLDKWN/zFH1/Xp
 /iF1N7Y+MZhB+/XFrYZv2dpVyTxtfAM8y3/x5CCAw1IAZBm3v2KOEA9YhzODMOoRRl8C
 kUw+vN2laUrn0K4FfIf/LfEZEhtVsT4YcozPcfR9XzaBrNVGdbpmsSWyrl282U9XVKFb
 F8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUEG2B2Z1TlBAaF7o1S9L+65U1T9fBdJ9kcSG/dPGMJgxjAzfbRS9sZv1QyrAT/XNFLKgjLcsAfHqTxjY60BBwBlZa/i0=
X-Gm-Message-State: AOJu0Yw0x1hpgwz4w7pxgqgYKHUCOl3gaJhmLRcWyjinTXNmjoHGi/+S
 yPAIhq1B9gGC8OXCsb9rQWQdlmOv8sPn6dOslzQZWnyaLq/i5Hr8arFr4hhCsyTLYWbUjryttbW
 Xx5w=
X-Google-Smtp-Source: AGHT+IGoMVYrhYlTHf781miXdITIW3EVbh82IBfUDNLJplR4WDq/yDgXypn62A6MS8mmFG5TjRiv9Q==
X-Received: by 2002:a17:90a:67cf:b0:2c9:81c6:b0e7 with SMTP id
 98e67ed59e1d1-2ca35d3da2dmr4628961a91.30.1720630250214; 
 Wed, 10 Jul 2024 09:50:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ca4fc29c81sm2994386a91.29.2024.07.10.09.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 09:50:49 -0700 (PDT)
Message-ID: <92bc45dd-65cd-4894-a115-29658cee66d7@linaro.org>
Date: Wed, 10 Jul 2024 09:50:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] target/i386/tcg: save current task state before
 loading new one
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> This is how the steps are ordered in the manual.  EFLAGS.NT is
> overwritten after the fact in the saved image.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 85 +++++++++++++++++++-----------------
>   1 file changed, 45 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

