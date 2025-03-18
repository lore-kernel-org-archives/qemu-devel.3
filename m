Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE94C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubNg-0000fZ-8U; Tue, 18 Mar 2025 14:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubNd-0000el-Ld
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:09:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubNb-0007nE-Qk
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:09:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso27720235e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742321370; x=1742926170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HCXIhPnNC9DrnJsnEe4+kNgm7n3ySHipHMYrM46pEcI=;
 b=Ewy5/tDcojpxmLX+mQc3DhqSEpgdOZpgaJ17DLlwgeqNSZK0jM1dZObAp+tzWRk9LH
 o9PLfZXJE0q13zSKawFd31zqGpcsENlmnPWmoTs/2+TPANH/EYJptlBPWnqHc98drYFq
 krwQjDu4Kyz+/JpAlvVre492qdz2es0k6QOcPfyDs7I7mfrP0Vinq6BoFEflNcnKRFvg
 n1eNrfjKjHmFSOi1Par7AcKMn7XhESztx8ZIgCd7bcDQzpxbJYIj8nqN9v60oZLaajdG
 6DMekOZTQcecW5qY4dIVCgapUtT4RPUizGQYKdPDnq3LXSFhtFau8C0isMCYeRh8ZOVk
 fzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742321370; x=1742926170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HCXIhPnNC9DrnJsnEe4+kNgm7n3ySHipHMYrM46pEcI=;
 b=in4YCWHR0rUbS7yDuTTO0XPsK9ynR9VWy4ac96zCQqyQX5w41DgQ69BYULOQje4oqS
 XLu/IQfBD0X2a33ZeiSa8WMAaPgjofVX14sWtd7vw1Gdj4skSyZg5T5lmAkEKiNf+4zi
 KqAa2uwigOmuylsqzVaKICJe9vu2yHZEgUrdViMQ8CjYxRRmzzgq5vvAhMxlxTli/u6Y
 ijXezbycfTNupRVi9QCsUILIbz9I9jUMSE9TLxyD6woaxKa8dueZfSSO/XJXcf2T2PMu
 sornYtRXugGqwIgbg4dIUcTlfnQ91arVnMhpI4JXDYNAda4JALvxtSM4REkywC0ACVQe
 4UFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx0gbsbSrOX9fafCOBmjyhpciA1+pVC9DPGskX9Yx+bMNGgWq7t7PwHLOaKHorm6ufMAmB1X9y/0nj@nongnu.org
X-Gm-Message-State: AOJu0Yzp/j2wgNoTX+QGHXoYv2+3a3nIraIPrdwKsSRnmuT21dyDMArZ
 x26k+L3YW2YHzQjGUxHJ4w859syJ47MknWH4MsI+a+w33GCroGnb4VgnDBd4dGM=
X-Gm-Gg: ASbGnctrrQ7blYAqG1e1iVHsslu/ZPwsWlUSycCXzImVf8Fu1LZJmIUXPPwLQxM0ffL
 EYUyR1y5WDVgl/FxLusiY5MsTU/N3wjQG3mYSMhnjZT590CA7Yh7zDh0ip5HySiA76uBh6cbac5
 uOa3CXvK84CGOXRReYxLEzkOIPri5sS4iSf1oR27XKf4zez6nrcsXskxE2iSubn7mFAyCo5CbCj
 KYzw2q6oe8l1xJ0ple0SzFG/TBnMvyPN65gSzH+kFV1yrVKwK2MHVaiZOUFItVAkJiiPh4o7Wyu
 co8J6FBaksHg1b7VJD9FgzvtFFaVhHz/7PobNzECpt0YoisZ8uMYEJMG90IJ61EJsxozfIC187Q
 3Iioqy85DO1ag
X-Google-Smtp-Source: AGHT+IHtxHTCHsUeMi4AexpqmUEanw0pSGxHvq4DzibepCMz6L6eiOHiY1ez0j4jQnN62egiwHrAQg==
X-Received: by 2002:a05:600c:83c8:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d3b9a00ddmr38200375e9.16.1742321370040; 
 Tue, 18 Mar 2025 11:09:30 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm140305335e9.17.2025.03.18.11.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:09:29 -0700 (PDT)
Message-ID: <7b268bd6-d9ac-456e-adc3-991ff786d551@linaro.org>
Date: Tue, 18 Mar 2025 19:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_x86_64_kvm_xen: Remove avocado tags
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250318171530.94966-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318171530.94966-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 18/3/25 18:15, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> They have been forgotten to be removed when converting the
> test to the functional framework. Since they are of no use
> anymore, let's remove them now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_x86_64_kvm_xen.py | 28 -------------------------
>   1 file changed, 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


