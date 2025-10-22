Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D82CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeBa-0004qk-PZ; Wed, 22 Oct 2025 15:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeBU-0004qU-Kd
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:07:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeBR-0006uH-IJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:07:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so76373635e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160060; x=1761764860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQihOjKu9xRefrG5cJaO4SXazU+5Upz3wUM5T3KPIBs=;
 b=OP8pkgwFIn7W/sLTTuepGUdB0pbCVnNKDBGBKGtSqIHFn6RyiMLZC2x2NsSELK1yi0
 0jHjwiovjUI0yYX2yGaUDRpHTjMtUxj/KdRi68YNwFel1YWqtxkjen1t+9SovQ+f/g6M
 LSltKIq7EL2BpvxorwQac46rJR9uj4qorW25bGoEHhDiTwLb9vsejynGTvjIFeDN1waz
 YqJ289xHm59EjiquPWubUPrVij4GTqQDijh9JuLRLT3RxI3XxyiH58Dh7Wni5tcM2xsj
 z4xognRI1a4SE/XYepYzMg+vYFz7cK2pkm9fHwhi+1RI4SSVPY2Z6ZVunygYDtGoPc0j
 Hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160060; x=1761764860;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MQihOjKu9xRefrG5cJaO4SXazU+5Upz3wUM5T3KPIBs=;
 b=G6K3m4GHOI+E95PEYzCvZ5mg4//y5dphl1094zPqBfXbLDS8zppQlrY6Obh9X3zmih
 nHoGd3AYLwqo0sLzfHcKJVN7d5w4fdAX2098mONH/ualyqD8mdfyBvyEtgQyGvAR4ylc
 y/sLmh7CZA8v34QIM6/6/h2i55FwL0lKbMkxq8orwzWSDBhgPb/LRuUnxt7hRVDcg+MX
 BmirAqt8VWqNZM4XnAHcNoel0dy7x2onJByRmyLGm72cN1ne41brkYQK89zu/BoIeInZ
 iB9SzVz5X/OSA2Bhd3RzkAhPNXzaQp2ec1sd6ikf4zu3ZsYpzV1sSYvvJn/7/9MTKlPR
 oXIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSecE3fE/6tVUaT4RyCCCzUa4LgVsyqcRPGqlH7alAvgwU+jS95OVDLlSCuYWyiDPYZCTkh/Ur63PV@nongnu.org
X-Gm-Message-State: AOJu0YxIq0SScE6cj7Vo9sp0MtjJok2/Cx4qBs9n814G++dwJty3nR4w
 X8YPgdhArWXQRW+bomlwIZ/zayJw9zHU6q2kHRGmFN80PUKX/8ABdj3jKk+sBfZK4bs=
X-Gm-Gg: ASbGnctshIRg9Ah1OkH2HakKV+S/9VhBD3q8y8hFtd1s0asRx1+XZ6uolXbTUv/jOiK
 lEhh/OUzrRRFbjqGyoHLpsTAHMEqERG1lr64yh4MltXW4OxsNhQQhn2o1N7yACxYo/BfSmZPdlm
 G5IPzE2v2qvYtgOYObNmJT8Mt4tno5LHoGyLJPJKnD5zWuvoptrf3sE6JZkjxxa7NSgzLCNqpFN
 2kRy9HYVCAY+VnG8ejfs61lemZnqc1wBW28WxGQ7zAjN51wc2hOReFwbpYIf6OfrouB9V44eu9J
 2mft63n6QFWmPQH2n6ZJZ6cw/8eRLilOSRzi3Y/TdLtWiyksmEZO4U3UbHULxbLRmIWLvvpKb3S
 R/dOL5I7/z41FLukGnnCH5szPVXX8jDgRY0s/WK1iBezQd9/qrlmIC5FSD4wS+eVz4OKHsG2/VP
 3w81rjeUIzwVuuU+nRJszEDZaedxt8Fvus9eCWMYWwH6MAuASuIFcHkw==
X-Google-Smtp-Source: AGHT+IHnkXF04Sf0yvuaHv/Fg2ZONU4/1deyIeCq+5EyJ2bkOAQ8neQnprW+HmrQqUHxs+NCDgVT8w==
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4711787a2cdmr152086285e9.12.1761160059607; 
 Wed, 22 Oct 2025 12:07:39 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428a534sm67789895e9.6.2025.10.22.12.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:07:39 -0700 (PDT)
Message-ID: <ebc4d7c1-44ed-4d6b-bb89-cc88814f7ea0@linaro.org>
Date: Wed, 22 Oct 2025 21:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional: Fix problems in utils.py reported
 by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-7-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015095454.1575318-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/10/25 11:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> - put the doc strings in the right locations (after the "def" line)
> - use the right indentation (4 spaces)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/utils.py | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


