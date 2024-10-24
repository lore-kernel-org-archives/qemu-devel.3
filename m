Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E5DCE8E9A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41jZ-0000pY-OA; Thu, 24 Oct 2024 13:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t41jW-0000oi-34
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:34:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t41jT-0008FW-UO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:34:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-208cf673b8dso9862125ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729791286; x=1730396086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IghsbRgA5QvaXE95R8hVFjjHLs31Pi10rbpqIG2lUgc=;
 b=f3evdCZ2AZ/nFlnNNxwUkQ4qw1Qo3HxLWNsVvWW07JK0SJ01bLPUUpVMBX1aAqYGOi
 Q+5n7ry+WAAL9BCT2wR8ZgThQ9lUSUfg6n+4RdHPGRz9nhyLctRbqfr+NuSV506wTJTa
 uumlCLs4Z4S5XTPs7zQh+luPRV1+UBbBBXA+VDIiFFcBrO/X5xI7B/RGAHQLE8Yoz0mP
 +o+M/9CxlCojNoainGOy1VRWDrP2MnMvwa6MXKGxf/eYkNiKhUuQe0ssW3sCX9yqyJDz
 NGCGRnchoGdkKyC9Bahj5RKQChlNRA/7loTpZj8EFnNmX0+8yII2udcMLDIwjlVnBq6+
 ry3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729791286; x=1730396086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IghsbRgA5QvaXE95R8hVFjjHLs31Pi10rbpqIG2lUgc=;
 b=NoAwwnoj3J6RjozBgEIGIsQPv8s7ZjKA9dIRKzdx+QplYau3WrkT+dryWmGmv5WEC7
 s9u/Xo27G9ShaAANLT6SkZJa2hLfvTUVFuwHjcSBi8jOTMJRUbz9vYNsySpW4+AkcLWv
 TEXWGHkFPkuOxVYX7essJSVW2Jqnh8cg7c7aNliW9oVg1mcU/AXRSyYstHTZbf5vstL8
 3O37FKr062zA21EfRNFVsDL7pCGY43BVi5wn2b1/45XAYMBWwyyI9iGzntcelDTNOzbo
 bKS3O2Dz+M0KQc4PovFwhX6nAsgYxqqSqYtMpBraV21kIVA2/TQPISVPNxQVI0BeYHBP
 DNdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKd+euFIqpe+BWLyTvF+fPnpChBHr6kQuRdKLV236VQvacLL7dS0JlEUbo5gxv2Mj972mUP4P48uMB@nongnu.org
X-Gm-Message-State: AOJu0YwzSJDLzjH0tIjWRUtjaG/Zc1X3rLz+v44pE+fV/KJsM3u0CpuA
 UsVIRUxEIYPsPe16WlesHaoAuAEeEckkiPaprkEOakwdHOb9XRb4z5N5hCcw2/o=
X-Google-Smtp-Source: AGHT+IFndmbkhEXR0vzVF3NyUsAyiySaBalT8Wk+a/XzEC5Qr8P50Vnrus2uB0cWpI9gFOKNrJBXHw==
X-Received: by 2002:a17:902:c40c:b0:20c:a19d:e73e with SMTP id
 d9443c01a7336-20fb9a81a63mr30256365ad.57.1729791285917; 
 Thu, 24 Oct 2024 10:34:45 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f104ac1sm74887145ad.299.2024.10.24.10.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 10:34:45 -0700 (PDT)
Message-ID: <df6dfd5c-ee36-4bca-8632-f0d2443d06ca@linaro.org>
Date: Thu, 24 Oct 2024 14:34:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stubs: avoid duplicate symbols in libqemuutil.a
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241021163449.136804-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021163449.136804-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 21/10/24 13:34, Paolo Bonzini wrote:
> qapi_event_send_device_deleted is always included (together with the
> rest of QAPI) in libqemuutil.a if either system-mode emulation or tools
> are being built, and in that case the stub causes a duplicate symbol
> to appear in libqemuutil.a.
> 
> Add the symbol only if events are not being requested.
> 
> Supersedes: <20241018143334.949045-1-pbonzini@redhat.com>

strip ^

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>          v1 fails to build with --disable-system --disable-tools, which I
>          have now noticed in CI.
> 
>   stubs/meson.build | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 772a3e817df..e91614a874d 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -55,7 +55,12 @@ endif
>   if have_user
>     # Symbols that are used by hw/core.
>     stub_ss.add(files('cpu-synchronize-state.c'))
> -  stub_ss.add(files('qdev.c'))
> +
> +  # Stubs for QAPI events.  Those can always be included in the build, but
> +  # they are not built at all for --disable-system --disable-tools builds.
> +  if not (have_system or have_tools)
> +    stub_ss.add(files('qdev.c'))
> +  endif
>   endif
>   
>   if have_system


