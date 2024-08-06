Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D31C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEhM-0004L9-Uu; Tue, 06 Aug 2024 03:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEhA-0003Pj-6w
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:33:26 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEh6-0004FY-TK
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:33:22 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so3455181fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722929599; x=1723534399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQrirKIsu1h7yRBRE4BeL1Y9tux6J2tEp0DQHqMY8EE=;
 b=pL2aYdLeTeZcA+hbC7TTtOvL2T3OtqMKwdXoxSkWFXFbwXQHDtIPJeFBalytVReujv
 jsBcFd8Tm8Nd/lWw16WspeFqlZa06wR8qYQm+c5W9T/fqdyAML7xHRuNMz030HHlOVXk
 VDyqL4eOb/SU19OY/jOI7lDgCLdyPGIiy2WWyAI5C9bD98YIQB4KqhFmsx1Cgveo0L3Z
 Y14ObHzKWKFX+RILC/U9c/4o5J7c1jQAUoEfmny/eRmAE/mBE3FqaUoQKNtjn2wMAmaA
 S3eif6da0maNkoIXSOLgxBmfYQxDs2hfc5Mkdj7asdciRw0UlZN4mtPp4YeEb/jPbT6e
 BcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929599; x=1723534399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQrirKIsu1h7yRBRE4BeL1Y9tux6J2tEp0DQHqMY8EE=;
 b=tmh/vZVYY4ElEsRvVct6cm9aM07nxQ8qMx5/jhWM5f4wnDxN6Gu0UaOQl9WYW96foI
 Wq1zTMJgNVSwYH2s+zq5D+Es4aZmWn+R5UVsYDGLw1a2JhbdkCowKj9OtCxmYo8M9vlo
 Berd97Vo7DOlfs1gLDfpLpqMH+bP2aZqrEzZM4VgElHfQW9zIcKinfe60o+vryehO2X7
 TIV6KscELUikkRBvZ+KgDWKumgGc/fT3aa8WgON8COzOCKiSpuA+SQRAeeHOzXq4tSUm
 o7SYbVihMV/cuHNY1vc7nXnu6JQZUnmSJVQwKEBOffkECWd0X8vHNBgq4kIJH9Ljh3y2
 /PDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr/CcXrL8yx4kPBKSKs6iPWdeG+w317JEf1McSwTRbm3cKNup8mROM5JpCbkR8UAzhht4bsvkllGCUH+0/QsaZmvtFjEQ=
X-Gm-Message-State: AOJu0Yw9oXM0iaBJ7zaSg6uMHKRH7a89hUjGtHKyy1iyJlQBzd6o3TFs
 nGlGIyhjbDP239ElqNOFn/824+4vmJbca8DsN2qHcOgfPaJaEAafeGHb3skeEPs=
X-Google-Smtp-Source: AGHT+IF8yESOckIVJDeGfazLHyz5eHBmH3EuRa5DO/1sefdDzdJDtqRlWUrmu5zpeOwkxcGFM/UAfg==
X-Received: by 2002:a2e:3505:0:b0:2ef:22ed:3818 with SMTP id
 38308e7fff4ca-2f15ab0bf4cmr95870081fa.32.1722929598421; 
 Tue, 06 Aug 2024 00:33:18 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8adc7dsm228931375e9.14.2024.08.06.00.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:33:17 -0700 (PDT)
Message-ID: <eef17fc4-c73e-4926-b67e-fc967fe316a0@linaro.org>
Date: Tue, 6 Aug 2024 09:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/display/virtio-gpu: Improve "opengl is not
 available" error message
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731154136.3494621-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 31/7/24 17:41, Peter Maydell wrote:
> If the user tries to use the virtio-gpu-gl device but the display
> backend doesn't have OpenGL support enabled, we currently print a
> rather uninformative error message:
> 
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl
> qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available
> 
> Since OpenGL is not enabled on display frontends by default, users
> are quite likely to run into this. Improve the error message to
> be more specific and to suggest to the user a path forward.
> 
> Note that the case of "user tried to enable OpenGL but the display
> backend doesn't handle it" is caught elsewhere first, so we can
> assume that isn't the problem:
> 
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
> qemu-system-aarch64: OpenGL is not supported by the display
> 
> (Use of error_append_hint() requires us to add an ERRP_GUARD() to
> the function, as noted in include/qapi/error.h.)
> 
> With this commit we now produce the hopefully more helpful error:
> $ ./build/x86/qemu-system-aarch64 -M virt -device virtio-gpu-gl
> qemu-system-aarch64: -device virtio-gpu-gl: The display backend does not have OpenGL support enabled
> It can be enabled with '-display BACKEND,gl=on' where BACKEND is the name of the display backend to use.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2443
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/virtio-gpu-gl.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


