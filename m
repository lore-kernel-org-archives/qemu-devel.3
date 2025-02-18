Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A0DC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLeD-0006fR-Fj; Tue, 18 Feb 2025 06:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkLeA-0006ec-7i
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:20:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkLe8-0005fH-9d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:20:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948021a45so54918365e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739877609; x=1740482409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9/3DjAFxI/v4Ul4XBqPwJ9mqca8bUx0Fi7qKIYKz4c=;
 b=Be6Cl/cDsw4lRakmJNkuRsy97xBpAIkNEi0eNPwfGyDmQb/xhZEPkjJFhttef7V3EI
 IpjkRZkJU7NVmutgpaOapFO1owvdsik3UlmZx7I4lOFMuVAcv4dTf8UVqPl1PgHNxLPx
 WWCt1IC8yxiV72wJPrYsK5Ak7mbHst5NGDortXO+IQT6ILxxmsfCFnlTTrXcNQurLp7h
 kqap9/rfJBB25zhro13eSnCME5Yqq504i+Jm6FMZ+7gZYE8y2uI0azG0fMc48IcSybsf
 fXcmLeoECXe0bDJono7Ex2IdwR9yynF19zO5n7iYNBhgi/m6mzFkCHEVqUwIMcMCQIWR
 UkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739877609; x=1740482409;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9/3DjAFxI/v4Ul4XBqPwJ9mqca8bUx0Fi7qKIYKz4c=;
 b=jgEAzLO0ec0bjeeDqyNhtU5Rmwez66YcVgIVb4xxKf3dOXbbiPDFudxRdmWNm/Xr06
 IvexjSSDpQ2Ve+X6k/RSUapkdrgqrs9kKlLFfKRheCwFjtaKMIQIjwsuxWA4qUGyumZY
 151jy/o/8gYzNA/6ZPAw8A2zQGZBFUGPKZazMC5/DjMLRDdIHiQ/rGbJRbshiGjv+RqC
 rUNgeFEy8AO44+RXR7K9pbx9fYbgBE+hvuQIcVoEZXDYeI72WpYQhnlmARwde0o0IJV9
 FLWCK+s+ErLOZrMNgGTusNnvFJeEjmRVI3QL0r2X4fPm4mWkdh0UREDD05Lpz55fFZ1Y
 vQEA==
X-Gm-Message-State: AOJu0YxPdAmJitCJYV4AdYsMNCc+Oe2dp9zeTxX63hB2zg4G/n54+TgU
 vjhyhIKSMizEKekVr+wifpBca7UeKDvKZrAYvyrmM6Aid+eMA6q2vELZ5qTL0z9ml7fPdW/j0fd
 EYro=
X-Gm-Gg: ASbGncugDbTbnEDZ5Dv7iWyncSwZf9Y3F4QqJj9zoxQT+Lt9AlmnGpqo4Fwhm8MTwCt
 SqhlWIUZcLinNIVVVG8Mwvo/5sEN1CXVBDvFSqbA6w1dRIHFdkCDtGfHnNTMmyBFpBp3u/ny22y
 eUpcT6CXLLr6nv0pdTU6VaQCnn1AvO2eZF2Pl1gfHSFITGGp7TXulmddda8wxDdfBP3clPSdX8h
 GuhVS1KQMa7vqB0egbePG+stCTAkeHPaKKmvzAmeb5tpfPX66PKq6jvDwpMJNxUFDkR0UXXZNKy
 mrqs+3K/Q17NyUQRIdUZMdJ2JFk+Gj/bkyWKeVXjOhPTpNm9OG6+2WcLAMU=
X-Google-Smtp-Source: AGHT+IGQ2Y/CQJvytuSzQ8bn6E1HTuNsvy6h2hib1hr/tIxCj4phhTrfkdFlTDkp4pKM2tI2/ftZfA==
X-Received: by 2002:a05:600c:1c24:b0:439:6304:e28a with SMTP id
 5b1f17b1804b1-4396e5b56e7mr147751645e9.0.1739877609433; 
 Tue, 18 Feb 2025 03:20:09 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25913f5asm14935008f8f.52.2025.02.18.03.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 03:20:08 -0800 (PST)
Message-ID: <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
Date: Tue, 18 Feb 2025 12:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
To: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250208205725.568631-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

Adding Xen community.

On 8/2/25 21:57, Richard Henderson wrote:
> Require a 64-bit host binary to spawn a 64-bit guest.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 1af8aeb194..911955cfa8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -304,9 +304,14 @@ else
>   endif
>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>   
> -if cpu in ['x86', 'x86_64']
> +if cpu == 'x86'
> +  xen_targets = ['i386-softmmu']
> +elif cpu == 'x86_64'
>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']
> -elif cpu in ['arm', 'aarch64']
> +elif cpu == 'arm'
> +  # i386 emulator provides xenpv machine type for multiple architectures
> +  xen_targets = ['i386-softmmu']

Is actually someone *testing* this config? I'm having hard time building
it, so am very suspicious about how it runs, and start to wonder if I'm
not just wasting my time (as could be our CI).

> +elif cpu == 'aarch64'
>     # i386 emulator provides xenpv machine type for multiple architectures
>     xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
>   else

Regards,

Phil.


