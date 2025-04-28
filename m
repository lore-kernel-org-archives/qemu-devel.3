Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118F8C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9W9j-0006YA-2l; Mon, 28 Apr 2025 17:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9W9h-0006Xz-PC
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:36:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9W9g-0004Ir-74
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:36:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2260c91576aso45271305ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876207; x=1746481007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B3Vf07BKy5joCEEz0qiH8KfTD6w3kGcQ/YA+9tCncTQ=;
 b=Tet3gz9QVx18M3gVgvf/618WGSo6IvZemC5ukTO4IeF0EUwxgMdHpchJZSIFYFovmq
 s1DgJPYmjbZNC7+Hx5OCSOt2mwk0S3KUHfS01hYIPjSuS8dFLKRl5WEMkHYgBJV4h08u
 yVWK29cWZNw3Z/vFQYmKXiTbT5HJ+82SdUTpcbvqFE1NVcopTxKTHRr+oYZjj+oQBP2e
 Y5U8Pjt1MS7GPJLrsv1N95UaFrtUZGOue4mI2I2oYewupyN0mnerWfL09F6ZYI12eq2Q
 EMLFZgue5oFpxQnoYfgVt8kKFDKnGqd7n/lxOyJyI8Ke3fO7nEFPT5YCIAseYxIw3TH+
 KM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876207; x=1746481007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B3Vf07BKy5joCEEz0qiH8KfTD6w3kGcQ/YA+9tCncTQ=;
 b=gKUM0OQ2KGUjdjRYYbJTl/+16aPV9kUbq2mOloVzexJmgQQbDk+UkIoKWhrUsuxalK
 yAklSncHrmNLe44UdumAkgOwopJEsLTblGHKSlNBJBTw3h4E2nR69eb5MlIBkdwYuntY
 bqyAJdPpF51e6yTTHKXbSTIXpSIDo2HuW3N9SueKAnYJlTNsT07WuTYQHMJ7EnAywfbK
 xyVLw+I3dGYKoVmYHeR7mJkuIgD9RzDegJvAkoLk/bk8XUQguCfYUxTs22u5D9ConFXN
 ocQisfJpJovDOqEpeoqCW9XU0cwSJgWuM4QiUpKGd7TputBrPnsjp2GvB+2o+33IF52R
 EYlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQEyX5TNx982qUKRVk4/ycmfmxxC3oYk3OQ9oc/251SS+MO1eCFUkqvQ+h73d5IwlSBYrH5ZXtA5UV@nongnu.org
X-Gm-Message-State: AOJu0YwwkHSKxEfP4e2g8WtVz6xG5SE0cVgZTUjQMcicQCbjlWiwD2JV
 WYA50or1SljhA/AKoZ+aAGTNxdbqTwCO1dkGlqU5byk12sQ5qDY/FKl8OtgGUkQbkMOiRsNIDAJ
 n
X-Gm-Gg: ASbGnctC28TVMcfOc28gsriwT9cL06eF+l9xagm3Ae5Ic8xc1tjZQWy1npK4QdhtYRV
 iwOYfxaH3u+dr/ih2waVL8h36ndoScDA3/ya2jNT7TDz8GED1bg/GEYqT4PzLRDjpbryyvbM5bc
 1cfDo5yC87Xb4FbKCdkGC2BvrlEjx2DGtBYw2qeJiKeDI0Fwtfd6X397l9vbp4YAZOubFP4CzD7
 KHJasPPPVWnAqpSt4pZk6vpQkNSLDuy9KkkWyJ2IWirACIXLFiu9RAv2mgD6a5sIK08VNNVTn+K
 VbpDNr78FK9h3+9WAK2P5QCymcWnQqp4R4mHIsfvFPq+HcsTTYOdeTAY0UaBkOW7
X-Google-Smtp-Source: AGHT+IHG2m0akYIJVAcelOrnu8gu3nI7iHKpjC5kDSKjvYj7ksLFjAynnibJumg9RGUPIFmpR4LTMQ==
X-Received: by 2002:a17:90b:3dcf:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30a013bcf66mr15842893a91.35.1745876206809; 
 Mon, 28 Apr 2025 14:36:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f773725csm8665687a91.3.2025.04.28.14.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:36:46 -0700 (PDT)
Message-ID: <94bb7870-1115-49be-a21a-e1d834e614ba@linaro.org>
Date: Mon, 28 Apr 2025 14:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] accel/tcg: Generalize fake_user_interrupt test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> Test for the hook being present instead of ifdef TARGET_I386.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


