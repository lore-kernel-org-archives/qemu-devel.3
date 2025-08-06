Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94286C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujkjf-0006BI-1o; Wed, 06 Aug 2025 16:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujkjb-00067t-FZ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:27:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujkjZ-00019k-8V
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:27:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76bd6e84eddso447046b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754512056; x=1755116856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kbNyqtmH8n7aTv4wwwHsf9VgpoAq5/6IbOMwxesrAH0=;
 b=M6kuFODyE4KIZXniKaDbvYomrVpb0oP6P7chEn6TsbHa0gB/0iR5g+QKofypDlQk5F
 okcs8e1MC8177saOa2APxycHqfgFAsurym9HD95w2VlqKSb0Y+5a+o9DR9nGP+eivEQR
 QcnS5O9dxx8EfBk29ZfFuHh2+ZndECpve0L0EovUb+A5+oXFdYtqmgtsjsVkp+M+ilni
 wOrtkLQEZfYFESEqsYDRM/RO3M+fidIie77tn++j9dByJo6W1RTRmx9iGIXbCGpfyBsL
 9wgSWlF3/ZkRnjpWa+pNUR8iPXb9vtktah0ru+2wQ0/M4s3U5bSso8WOeQeF8GfmP7ML
 dgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754512056; x=1755116856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbNyqtmH8n7aTv4wwwHsf9VgpoAq5/6IbOMwxesrAH0=;
 b=oqQ3EOA/Tvw6QrUSwKyHYfR5Y+jNQ70rR/HruK8nu23ZnlOBJeQ8c3EXkP8JkKADvw
 Wb9iDUgKfhEgkD1SAB9Ig7mN4aGtq7ydukUB2pGr8ehxNP9z4tyBSi1IB+lBxjSYxWu2
 52n0XjStfonSEJN3QG+QeTQk/AhK2vHs0PYJUcNGjH9d5O+oENpbwQE7/JHNd7dllAuA
 yk8ZqsN2EsHFi+5GneK5zFs6IrpRjWz4KFcRbMIH/tknxXLuJm3eUN1VevvsJNrUldSS
 88Gf4RumNkiK8ypFhzRuQ6737VvmjAnITRtjET4HhIjrT6IJj6sQ16Kw4uTaGZLu7MSX
 OLIQ==
X-Gm-Message-State: AOJu0YwQ0lnq21+VMSgme9EGH12cZo0MtN1odKAc6xulQTBV8PeZPtf9
 SmbrYkEO96dJ2SAXg0eoAHiECEFhkzMlxm1TN758O5F4oETcVup9JXVDrviSrC0Yd1k=
X-Gm-Gg: ASbGncvY9DgFBlBXXapBfTQL0QsQZs5GS5YG+/+KE5wCcub9MHeaNkwntQGaBWRviZF
 m/LfAg687tF7zBN/1cT4pU+o2yM29gPB3ZpBjkl2knlm29tDmlYxKLlnpChYFPcKnY9QQoXTl7T
 7JIHMz6b4irpp6sGmAsZGRkY7cX7ikYqLLuuKHMjoi240IZxh32DXBtZnBo1OjT6IVVoBT+8kVA
 xHIHxHg25hzZNHlIz1j7of3+bOZ9patZYaoGgVel3wggABj+FW8UTUWRz6fQ3mRJZCFy1kIsV8n
 W/6/ipXqkiB3f4MsX/XYySX+U92oBHQsnlmb0CN3Q3+xsPeJc9gOt0SNTcrPtImMo0qrAVPUpoB
 hStZXzL2dcC218Fy/41GS18Oqhq3uZNx38Sg=
X-Google-Smtp-Source: AGHT+IGdMRp4SKXf7AO+T1o9wSIxLQpLv4gLyPlXT1IJP8omCfK6JFDjADfyfsgjku/BuWoFCO5spw==
X-Received: by 2002:a05:6a00:2445:b0:76b:d8c8:2533 with SMTP id
 d2e1a72fcca58-76c2aa43fddmr5680004b3a.24.1754512055578; 
 Wed, 06 Aug 2025 13:27:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c2078afd8sm4295361b3a.117.2025.08.06.13.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 13:27:35 -0700 (PDT)
Message-ID: <bc751ba6-db01-4278-834f-ea7b61025917@linaro.org>
Date: Wed, 6 Aug 2025 13:27:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] CI: Use mingw-w64-x86_64-curl-winssl instead of
 mingw-w64-x86_64-curl for Windows build
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250806200909.507803-1-sw@weilnetz.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250806200909.507803-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/6/25 1:09 PM, Stefan Weil via wrote:
> mingw-w64-x86_64-curl-winssl is required for https connections.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   .gitlab-ci.d/windows.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 45ed0c96fe..beac39e5bd 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -77,7 +77,7 @@ msys2-64bit:
>         git grep make sed
>         mingw-w64-x86_64-binutils
>         mingw-w64-x86_64-ccache
> -      mingw-w64-x86_64-curl
> +      mingw-w64-x86_64-curl-winssl
>         mingw-w64-x86_64-gcc
>         mingw-w64-x86_64-glib2
>         mingw-w64-x86_64-libnfs

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


