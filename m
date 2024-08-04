Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BFAC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiq2-0007m5-DX; Sun, 04 Aug 2024 17:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saipz-0007ZS-09
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:32:23 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saipx-0001qC-KT
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:32:22 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db23a60850so5521402b6e.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722807140; x=1723411940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBxiCak4CqnAbcQBbl+q0W6KErYX/bMty4z5N/WitaU=;
 b=hC+RrvGxFeHy/EW4GVO72VNPuwmCwCbvkpWmcuxeUa2zkkCwBWfsMf8uBbmtfLPSH4
 T4g5/7fWm97kvY7DJuL99f6KBnsY9m/GiaxuPsE6kOJC6rXiKM6dtf4gQ2c2BE/NVTVx
 2Xo0ViwEP+qTNkEvorxXgIH03SGZ36O3Oe9qKoM6D8NklsczjvcfQnU0bpQnVtKUerX/
 7il/jgZ/SpMvIQ4UKLEswnWBHcw4U9fXiHPlGi92HZyJMKtrP4QJPZ06YHyt/6obA0Gk
 ctgmUdKYjyymX84u7NBw5+lrzVFTkYDFvMYfO4pRnkG1YxRBM37ikPhNpxAEY7PPr0hO
 ipXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722807140; x=1723411940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBxiCak4CqnAbcQBbl+q0W6KErYX/bMty4z5N/WitaU=;
 b=VeozuxfBPGPocx0hDSWha/jlLFNRbkm5oO2g4Mg7fjqh/1JBMknYPDnsa23/lri5/h
 5+icjXeT9KriXFCvcruZxUwWAiixlwgOKWRe+9OKy0jPutvaMSs+IICKit+Pxdp7lWVC
 MCkn+0jbNJZMEtejdlqg/NgCAzCys5vaJvOC7FEZU8lQF72TFEdzrX7n0oY1nI7FBmuI
 nbIU26lMGCVcsqeHBw7hJS7QOjjCkIRyuJnx7+hp+Qfzl2p46c34l63XWXf+9jiuDp2N
 A3kzkDp25Ue7cxrBILdJk9K1wB22CNp4sDoItPk5p00CHvzIn4t7qF9WZHeQwg3+GbwR
 8YAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzNwY9jB97Hnwe9BIPhCK/CLQabr2LX6s6opMEIgAvtNOVfLSP2HIFT8SCzyxXY6Xlsy4wL19amkTR40bfaIvMM63ICbg=
X-Gm-Message-State: AOJu0YzBaM66aF9BeTyIkdzaMz7I8E2HJanwMfzIgj/2t1DRjhMzTQVZ
 dUDUkjFb+I9m1BR8AVKMlMQPtIPRIu8ckNIREyBeF/GOVxaTcnYc3RKx9Qj8yKg=
X-Google-Smtp-Source: AGHT+IEPGcy1DOql/mVAOcG7D51hfiAgMvIZx0R4a3in16xJmb+cVdeWPCme/QUELoBmHaf+wxbmUw==
X-Received: by 2002:a05:6870:d107:b0:261:1177:6a62 with SMTP id
 586e51a60fabf-26891f26cc4mr12502323fac.49.1722807140276; 
 Sun, 04 Aug 2024 14:32:20 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ebff76dsm4291390b3a.34.2024.08.04.14.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 14:32:19 -0700 (PDT)
Message-ID: <c7e06f2f-075c-4d12-95da-866029752405@linaro.org>
Date: Mon, 5 Aug 2024 07:32:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] bsd-user: target_mmap*: change prot to target_prot
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-15-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-15-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Adopt the linux-user convention of using target_prot for passed in
> protections. no functional change.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 47 ++++++++++++++++++++++++-----------------------
>   1 file changed, 24 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

