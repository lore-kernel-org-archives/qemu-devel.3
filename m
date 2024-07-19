Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E747C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUn1F-0000mg-E2; Fri, 19 Jul 2024 08:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUn1C-0000lH-QG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:47:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUn1B-0003Td-4e
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:47:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so13253445e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393242; x=1721998042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QOVaz4Bw6+iiquXfzRFSlJaUUp3cP5kRK6mUCdf7T7s=;
 b=S9obLNfsPu7rrZ0Xy7dGzW0eRr3XxhhyQqaOfhyxOaFnnRBFzqG5pVH7DD5D/x6JR0
 8z9X2oOpKiCzdXbJBjtjTAjK82AWYS8K1eOHf99kfxk/kmfhcKihTz0kGF8zOUno4nKr
 vZ7eCpsaC9d9OBEGYu0+3x7W95RTCX+EvUvYd8rhmywVJgMSzkSSfwo242/mTU5rwkec
 sunThBj119Jzqxo9xCDQkZKX5NNMVKvy16/mJcBvGB1qMvFitCVrmSE/KCGu0tWW4mIf
 dkNjhCYxrOePbszD5/fyiHAVG5WPKnzt68hZMtqVh8xMRZ7zF/y76cpZxCOLEJEI9/Zi
 8ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393242; x=1721998042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOVaz4Bw6+iiquXfzRFSlJaUUp3cP5kRK6mUCdf7T7s=;
 b=Diimj+bdfSoiK3f6mbmK482F0Rqm+fk7p1Y2WnbQhvo5JSYTrW+urplTCfGYYSuIJl
 WimzmIWdgSumyU7apbJJ1xFi7uaGQ2wh/dUJulkii1lYHi+XcE79+oL5E8D9Na63QDXR
 xxVDGn5OfARq15PfWg42IGAl/B2dK9ofBadndOJbXIYt3emCOywai50zkL+k+YrHAovJ
 fx23Glr4zB27VQ78Ah47y6TtibgOCjGJaPu/y8FN9DDEDCwMRWbL55vHJQ1cv1sCgyZY
 KF2HzzwgazAAsOSkwfeynqRyGlIIAjpSLBLTYjXZvhc1uAi/AsbHfWtBIeY5MR3Xo8HA
 vVbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpUYEJ0Z11UWvx+UIqy1nFdfaRn0dt2n/6sbYCDne9b11bTj8n3jZM+EAYf0urW2++XRsxHKp/cs0a2Zbzwep8R2myQok=
X-Gm-Message-State: AOJu0Yy4BBoYtbgmoOMCG50MVJOCZnn32q4cMxglFYtBNOWQwPU960sV
 6VeSRMI4AK7lBkTq5iyRQLqrYi8d6qH5VFM0Ga7yBRPv6IsEPHR4PYxWLOuUz5U=
X-Google-Smtp-Source: AGHT+IHVXLJysIls5jKuc+ButAzpUAaigGb7e3vadN/D72DBDpC8iifHjP1EcrZhllQrfVvxNnxusQ==
X-Received: by 2002:a05:600c:1d8d:b0:426:640a:9de7 with SMTP id
 5b1f17b1804b1-427c2d13b7amr66276795e9.39.1721393242366; 
 Fri, 19 Jul 2024 05:47:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929976sm23555695e9.29.2024.07.19.05.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 05:47:21 -0700 (PDT)
Message-ID: <1a37fd6c-3aed-47b3-ade7-35f2b40f5a3b@linaro.org>
Date: Fri, 19 Jul 2024 14:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/mem-addr-space-check: Remove unused "import
 signal"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-trivial@nongnu.org
References: <20240719095408.33298-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719095408.33298-1-thuth@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/7/24 11:54, Thomas Huth wrote:
> The "signal" module is not used here, so we can remove this import
> statement.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/mem-addr-space-check.py | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



