Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A2AC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcih-00046Y-Qg; Mon, 29 Jul 2024 22:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcic-00043U-Me
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:36:06 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcib-00011S-5Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:36:06 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-70b2421471aso2386223a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306964; x=1722911764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GTFXRx8zLvkJSk0m31ASalcCFZQK0FaxevTik1+mM5I=;
 b=sGS1E7qAZgt2u2OBffiQ1A4OWQsqTRZV2QbuWfjcfy3dUf53XEF8ceLJtctpj6856k
 BvGLVkBa79Xox5Xqp57Wmu+vSgviNabbsIgjgg6qauFrBtEP5rMyOIg2U6Ir/0RiVVhM
 G4qrhnZXvsIXb9LpPl55GHcmUU/6IbtIb7EMr+p2iUUKKp0i/whtBCo8aDVtmkI/lb+/
 O0XB3eb52jjNDKSm3R19gKYZlHR/RHGjgcM56sv2oDl4dQ3TOs0qqdqwJvx0a1GvrOwJ
 qDL//5zL6GwAJkpvTPPSAmnQIBHU4vKOLJBa5r6Zr8iWKsS2vCv78BRvDvWL5uA72gqH
 kHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306964; x=1722911764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTFXRx8zLvkJSk0m31ASalcCFZQK0FaxevTik1+mM5I=;
 b=X1vc+uHCmhCrVrTNW790l7N7GmOTBwV53ZaMXq+M1qnsX7ciVRhQynurDr7YgsbmRy
 tWs40BdzZziXLZfQfx8QHojpHWpiOK38ekAmn1ZJxxun9ehEvmiGs9AaLVcHrC2o68j7
 11yoyZzBIqXvb0WpsnmybHZV31lryDoDmAY6j82vm1G9tMcPINqfF8tfd7R9Eh5hzPuP
 Xb43nLfjaD2i4wmhdnNFhTizs+FcJGGwEldk7lMmb02Co5fVXyH1lHQtx+X1QQKuiq2/
 YVPr8GR4MCAp6S0PtDJD60RzXxAut3otjhv4aPaMOnktc0QvCpPfu92UPa5Rpz7ZrCyw
 fJ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn4IxVEFGhD+7FQXYITJDQKOyzuFKjN9sj8S5UnFpSXI5F1L2LQK+1eQjGUrMWEuawEh3gwSSwT8g0QkcLdK2o4wQjXkI=
X-Gm-Message-State: AOJu0YxMcAA8pBR+Sg+6O+CzjBddPW3RM89/YYxJpdBM7xg6CCJpJ5OU
 s9vfYLlgWxvCbm9W7DiUd5pJ2AmSobswbRB/r9XaoMsJbCZyxmHaQn7nZJJX+REUH4CC2CgTtRw
 SRPw=
X-Google-Smtp-Source: AGHT+IFz5Rc9rUoKb0PxQLRzrlv+pg+N42EOp4fRBfeawcYFk/EBBD2PDi5qBK1TsgcK7gL8AohJYw==
X-Received: by 2002:a05:6602:1407:b0:7f9:62f1:4e12 with SMTP id
 ca18e2360f4ac-81f95c4583fmr1262998039f.13.1722291739155; 
 Mon, 29 Jul 2024 15:22:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c73cffsm6625053a12.8.2024.07.29.15.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:22:18 -0700 (PDT)
Message-ID: <fadd74a2-60c0-4000-8c22-1ab60d2d8bed@linaro.org>
Date: Tue, 30 Jul 2024 08:22:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] gitlab: display /packages.txt in build jobs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> From: Daniel P. Berrangé<berrange@redhat.com>
> 
> The lcitool created containers save the full distro package list
> details into /packages.txt. The idea is that build jobs will 'cat'
> this file, so that the build log has a record of what packages
> were used. This is important info, because when it comes to debug
> failures, the original container is often lost.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> Message-Id:<20240724095505.33544-3-berrange@redhat.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest-template.yml  | 1 +
>   .gitlab-ci.d/crossbuild-template.yml | 2 ++
>   2 files changed, 3 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

