Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227C4D3C93F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 05:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2l9D-0001Gu-9P; Mon, 21 Oct 2024 01:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2l9A-0001Eb-4g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:40:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2l98-0003aL-35
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 01:40:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso2572994b3a.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 22:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729489200; x=1730094000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCMOiAsCaIJN6JDTXZb5kk3OFS8Zqbi1tZYwenC0w2U=;
 b=xTqq83ta/ndraxydbCnxaE5l0N9g5vlaBPrcDT54XzEpehkkLCVtjfS//B2uFMC4E9
 cPsGvvsmhGdPVMGRhfYN3s1d+4F+u2J7A241PoX4BUxBb/+j2alCOkr7FFO0ENRAMtNO
 j27e3i6vbKA13kTAPBIkITimcWScbEnCF063pWwvk4Fet2h77zzOBcsFAYUzDGQjgV2C
 180w1+krlzsJPAnIq5bayBtWebQ79nO7osM8BV4d+UrIpgmmfM9Sb7Xo5i7zPfpeHioC
 d4NknZa9ZQHkFWpVZzR0DyWl1bNzUB7e6wy5mxm7SufqF33GMVZ+WZuAIVq8ZT7Jynxn
 txHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729489200; x=1730094000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCMOiAsCaIJN6JDTXZb5kk3OFS8Zqbi1tZYwenC0w2U=;
 b=REXpUQPeHyy2JFhkNE3Q4M7ME79t2EHYaNnTI66wTqspsQLsc4u6KnMy9dQv//DKnN
 0A2SFOJp3ixobwvm6MhxzVPdu3YUqBcBFv+Z5pDl1by0QDh6h3m+RGCNmPUxsFiZrZgO
 oq1ElrqtbtP5VWWb4uRfNyyUuFJDkHeRXgeCinqNccb2JLt+gZGK8/LPvILn6cY0nHds
 eWx4RLLiqJXQIV9eLZ/FRGrevpkqVPI/QE722T9opmUaxsdS0Tbywr/2vG9DdSOYDEr0
 aLJkbCbNKMjk6piTbxCm4ZajNW3mNvaJ7EGrj4u5i8XW3Pz3ZjJNX+Lf22BxBdcsgolN
 oZ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYGHFDEtJnoznvpsrfAIM8+jyYtgQK9t+zjr+aiXuslLQNK4FcrOXXMSOulZncVv5j3RllwSLFzjHE@nongnu.org
X-Gm-Message-State: AOJu0YwLq689pmrRjz30EvvPe9VV4BS4TDRsa39Msx8qmeYaT9uMmCzV
 hWTtydaAaL11VvNJCNDhMESMDaMMLKNDCPS/o+M4CdN2cWpycZemtLmPLVwm7qk=
X-Google-Smtp-Source: AGHT+IFJhAlyjzL3a+t08QVhqKdp07ZUATgZhETcaVH3e1BJotkqHKHwBb3QMEVBGWLygtriQCnj1w==
X-Received: by 2002:a62:f250:0:b0:71e:374c:b9aa with SMTP id
 d2e1a72fcca58-71ea323c111mr10882252b3a.27.1729489199617; 
 Sun, 20 Oct 2024 22:39:59 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1313a10sm2037355b3a.38.2024.10.20.22.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 22:39:59 -0700 (PDT)
Message-ID: <246ae221-1695-41e2-b916-402eceda630d@linaro.org>
Date: Mon, 21 Oct 2024 02:39:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dockerfiles: fix default targets for
 debian-loongarch-cross
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>, WANG Xuerui <git@xen0n.name>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

On 20/10/24 18:37, Pierrick Bouvier wrote:
> fix system target name, and remove --disable-system (which deactivates
> system target).
> 
> Found using: make docker-test-build@debian-loongarch-cross V=1
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-loongarch-cross.docker | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
> index 79eab5621ef..538ab534902 100644
> --- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
> +++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
> @@ -43,8 +43,8 @@ RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.
>   ENV PATH $PATH:/opt/cross-tools/bin
>   ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
>   
> -ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
> -ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
> +ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
> +ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
>   ENV MAKE /usr/bin/make
>   
>   # As a final step configure the user (if env is defined)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


