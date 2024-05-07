Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72832C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FRj-0002to-Ki; Tue, 07 May 2024 03:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FRS-0002sn-KW
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:40:53 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FRQ-0006zk-FT
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:40:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59b178b75bso459737566b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715067647; x=1715672447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohQpebxloZmTa5OTDw+eQkur3N3qk+mh/ihiFxbrmD4=;
 b=RKZC5vHHP3rFhdZvZOB6nU7sBgSJwmRlP1kGHjqS4rWpKsJbCtesFaTXwxOpLun0jg
 8vbMaIkPIh623suOFQTeGv50PBxRLtAh74V32BZOt6eT0r8brd52WkiFZTDlhG3FwcPs
 DlH2dRKEFnX0pH0UgN0S30fABBFPiICcObaGNEKV7ueQGVp+NXQ7dqeD5T8j5wyzc8vx
 H0JggMuu0JNGpW/d1xk70x4jVFtvNOs4KbtemvJD7s71uX3YamIixuVJsN1I+Nsc35TO
 I/OKxJJ2VYY//wO8S4DwbfJMa6QVGYJhVz1r6pQPcf5EIEKin8d3rqM7Npc0bvVYj1pr
 qk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067647; x=1715672447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohQpebxloZmTa5OTDw+eQkur3N3qk+mh/ihiFxbrmD4=;
 b=SiC+gumS12w/wxBf194nboyta6wgdL8hi7+DmkG5+L9nO7yVnBdrCrRjIAs2rJdVH/
 AORE44q6NwrgxDoucmgcUBu64rUdqTzAibhL31VPMKys5pTP231d041XQh3IQ9MqJkXt
 3manPipXx59twwU/d0vecldsffMCxewnFTLm3xct/CUOviqihp90q2wJbnLnYwZfEtN6
 5s5uIJDs7y5UXOqB7noWDUArECbwvTm6O98k3s/sqPxECK0mEp7R5Qo6GkLlYBY0pvXR
 eKVPm2DzN4rGq6Wq8tuoj/rpAE7YoGcPOYCvq4OufqGt19ch0xxxB3tl2HjG0rOykJm3
 x8RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe6jp1txR5TtRCWRW6s0RuZ5UJ1jEpBxUc/L4Zc7jMV6QP1WZg/Bv7roMFtMgTMuPCx+emydMRbqIBdEFCEXOtFGwMoOE=
X-Gm-Message-State: AOJu0YyyPmOFAkSpHD5cyvDNAu+GZwoWE+AmxMIk6Bsha+uZiDnZf/BA
 eAu+KL6SNfzul9QnGyO3FeKTiIuLNwU/bbbNWCvUTl+fC84NEvH32dW8YeiPxhm99fSIM0PaOIo
 v
X-Google-Smtp-Source: AGHT+IHdHd3kXUk5XBVxzXCOJrCqKM+sirrVTWDhukEx85Ij9ZLq/zqc9tD3/D/JGPtFyhJy1QG6lQ==
X-Received: by 2002:a50:c304:0:b0:56d:c295:dde3 with SMTP id
 a4-20020a50c304000000b0056dc295dde3mr8840048edb.35.1715067646933; 
 Tue, 07 May 2024 00:40:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 cq27-20020a056402221b00b005727eb1ed6asm6030572edb.68.2024.05.07.00.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:40:46 -0700 (PDT)
Message-ID: <d5e37b1f-fac0-48ff-ae47-59090b5b50c0@linaro.org>
Date: Tue, 7 May 2024 09:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] meson: remove system/internal distinction for libfdt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507071948.105022-1-pbonzini@redhat.com>
 <20240507071948.105022-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507071948.105022-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 7/5/24 09:19, Paolo Bonzini wrote:
> Treat libfdt like slirp and the other dependencies that use --enable-download;
> remove the ability to force usage of the subproject.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build                   | 69 +++++++++++++++--------------------
>   meson_options.txt             |  6 +--
>   scripts/meson-buildoptions.sh |  4 +-
>   3 files changed, 34 insertions(+), 45 deletions(-)


> diff --git a/meson_options.txt b/meson_options.txt
> index adc77bae0cd..90902c19d1c 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -308,9 +308,9 @@ option('vduse_blk_export', type: 'feature', value: 'auto',
>   
>   option('capstone', type: 'feature', value: 'auto',
>          description: 'Whether and how to find the capstone library')
> -option('fdt', type: 'combo', value: 'auto',
> -       choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
> -       description: 'Whether and how to find the libfdt library')
> +option('fdt', type: 'feature', value: 'auto',
> +       deprecated: { 'system': 'enabled' },

TIL deprecated options:
https://mesonbuild.com/Build-options.html#deprecated-options

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



