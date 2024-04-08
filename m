Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14AACD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrLD-0004QF-H4; Mon, 08 Apr 2024 11:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrL7-0004DX-Lc
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:55:21 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrL5-00026N-5U
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:55:20 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d4360ab3daso53817061fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712591717; x=1713196517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOxiTqJ7VdfGcmdxVDAvJWC19Po+WGBi2iDkcGilA9A=;
 b=mGonVaSq1VZSghoYKxwlao5LC6CnWHC6QQLzLtwGvEjdX9jBMNU0EElGJHX28HkVpF
 jx2nVwqvNx0XRev0Q/mXGKzNTm42ck5ImO0fXhLf2aXWlNKZNjf9JQ3MQgaXTMSWYQFd
 x5iWGZlec06s1xYCfXyF3SkTl8icmMu7ZuG3AQCwLib2VufdpB9ft1MGc3lv0xhv3m7R
 fDkdqZ8/3tzA8w4ksH6oc6YnAhvRbtOstGBwxs7CXCVTdf7gtaZdP7r17+4HbxsYNzJL
 Bslg/l9fEv++0voPu3aEnMdXKc4XcaX3KNiJbhO8u3/x3QBFLX0UrL9UaX0Qj5hooaXr
 YSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591717; x=1713196517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sOxiTqJ7VdfGcmdxVDAvJWC19Po+WGBi2iDkcGilA9A=;
 b=H7UzT9zkz88H0qxRfOYPu7zSBjPQk0bHJ42l0VCxLJHNc/ef9ylDIlJzuYbK6T6Hoe
 uwzD0SNceTsQofOowU4nzoA7Oneb9aVUAiUlWX3MpjxrnysxjjYEIZSKaOZBgOryktKZ
 sytNxdnm5K09xc2auseZ9qgQlwBseJ75BaC/W0RV75r+dZpZiq6jW3Ym7cZ+WeWVRZoA
 gCkRuF4uCFWCuQzRGeM4J0yiLW5kaPINgqU95KDWSsVEVx6LS5J/UDFjs0YG6pt4L5DL
 fE+bool4ee3k8FLR7GrfkNlSI6um7H9Kt9pkL3s2qRgydaMbKYW7REI96oTjNsItC6/n
 INYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVv7WMZowtk+VMzCrvhGZnyXoCEfA4uz1QaedEzOzvMilUwGHDTWDqzvUsb7NQpYtfCcxYzpGoQGpf7u4ZdKge1IZhrIs=
X-Gm-Message-State: AOJu0Yzy+pUtImWo9hIVyo9AjeAE2D5qyMzE6CDX09made8CAMfKIBMh
 M6EnUDetneIhRoc6cAi/AUbfql4AaumXOjcd2gIf0V48B5s2Y3BvYj9LkVx8/1nxR8kMM0eIo4t
 n
X-Google-Smtp-Source: AGHT+IHIy1E36zOCBLlxRnzK87XRzfRLHHC4SL4u1TMzCMQUWWxZmIrkMleTx3QlINTLNzqF9YSPYg==
X-Received: by 2002:a2e:9887:0:b0:2d8:180d:a62a with SMTP id
 b7-20020a2e9887000000b002d8180da62amr5703439ljj.25.1712591717265; 
 Mon, 08 Apr 2024 08:55:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 o13-20020aa7d3cd000000b0056e67aa7118sm775748edr.52.2024.04.08.08.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 08:55:16 -0700 (PDT)
Message-ID: <4f2cc775-3738-4506-953f-dfd1e3a68326@linaro.org>
Date: Mon, 8 Apr 2024 17:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] yank: only build if needed
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-6-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408155330.522792-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 8/4/24 17:53, Paolo Bonzini wrote:
> The yank feature is not used in user emulation.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   util/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/meson.build b/util/meson.build
> index 0ef9886be04..2ad57b10ba2 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -60,7 +60,6 @@ util_ss.add(files('stats64.c'))
>   util_ss.add(files('systemd.c'))
>   util_ss.add(files('transactions.c'))
>   util_ss.add(files('guest-random.c'))
> -util_ss.add(files('yank.c'))
>   util_ss.add(files('int128.c'))
>   util_ss.add(files('memalign.c'))
>   util_ss.add(files('interval-tree.c'))
> @@ -117,6 +116,7 @@ if have_block

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       util_ss.add(files('vfio-helpers.c'))
>       util_ss.add(files('chardev_open.c'))
>     endif
> +  util_ss.add(files('yank.c'))
>   endif
>   
>   if cpu == 'aarch64'


