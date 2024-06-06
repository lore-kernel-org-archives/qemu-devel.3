Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C70C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCae-00076a-4C; Thu, 06 Jun 2024 08:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCab-000765-SJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:51:33 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCaZ-0004lz-58
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:51:32 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e6f33150bcso9269361fa.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717678289; x=1718283089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jqgt3DaC768vMjGSCgqa66K+UuNZWnSqEQ96aP1HQ2w=;
 b=ku1LXW6WsoHKy652lSLkB4e5v9n1wjT9S8dTqoV60AUEKfGur2D4PkJyy5k0B9Aj+a
 07X3c7X5hTbWWr86Rm58wd6bmeG5DcNVUmVBqWzN5xQsqRE3bB8Uu6yDpQaBvzYQDN3X
 L+KdEZXE+In6Ob7U4ajT1F6LYqdb3Wvkp6NcJNx7VqoXUOUBrBsLKxXvcozZX98N3Uvy
 L6gqNGXVpvVOkiW07WOBFh9BQIuDWI+0xRmftblYJ8jY6Y0aZbhmN/b9DjxHx/NDJeJW
 0Gt5d7DcRtWirYFoTzXiOco43chaZgRkGnCrpLy7Kt3Jtzi0nrkFlWZrkdE3RiXUECB7
 epuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717678289; x=1718283089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jqgt3DaC768vMjGSCgqa66K+UuNZWnSqEQ96aP1HQ2w=;
 b=lApw4/uuD7HjpFrmkDtwopLReOcpivXGcfbgJAVCOAqPUeers2eOOIg/rHNU5flOqg
 EpIG5zm3ptJ3GsUT/Nfd+TnMbDDFb+aVfuJRRPcqraJwg4AvQnGkYkgbZR4hxPMhGWeM
 oVYMc82/5gnGFI7Tvz5yKUG1xZMV/h0ksisojEjNDZEMQv7Xo33jg7M+WQNn71rOu4dB
 hdnEBk2tJ/0XfLES+8n3SnyrGkJdUq0Wh8N98w48i1OssQvWJllfarL1ycto6MCOtCPr
 kfYBB8Pvfnc+FAHlbYn6QoRa03PiPWBtkPH+8lkDsweqATg8i0PMVgRyXYA+J5qdb6DZ
 Uppw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwFkRckabLLeuc8Idu56L2GZObVb91veUDX8t0giD6NeC4Tem/A8XYr94POXr9UA9hKZ/Xh97PISQluacd+h8yj2DPijk=
X-Gm-Message-State: AOJu0YzNgPmYo7fyC1dukr0zOAEMEYvFgeWc+jioI3K1ETI9ffLgzI1A
 7fBA7+JSqI4qqmcRTkKJSMR+rmC46RkBDenQrD4jqTKiOBbZFlELPExMydg1m11onZ7uJ+kpcRA
 bBGc=
X-Google-Smtp-Source: AGHT+IFVGptctOcHpsBQ6t6cNMoWbNv2JyN2ojePnC7v9GnzZRZxHCOX2GXsSqjbafmrNYQUkJA/ag==
X-Received: by 2002:a2e:8816:0:b0:2e9:53c5:2b5c with SMTP id
 38308e7fff4ca-2eac79f0d43mr24773781fa.16.1717678288840; 
 Thu, 06 Jun 2024 05:51:28 -0700 (PDT)
Received: from [192.168.183.175] (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158149057sm55689325e9.36.2024.06.06.05.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:51:28 -0700 (PDT)
Message-ID: <d4df84dd-9e8f-4e8e-b627-64fe7a8aecde@linaro.org>
Date: Thu, 6 Jun 2024 14:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] meson: move shared_module() calls where
 modules are already walked
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
References: <20240527104937.30443-1-pbonzini@redhat.com>
 <20240527104937.30443-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527104937.30443-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/5/24 12:49, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 34 +++++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 15 deletions(-)


> +  if emulator_modules.length() > 0
> +    alias_target('modules', emulator_modules)
> +  endif
>   endif
>   
>   nm = find_program('nm')
> @@ -3745,19 +3762,6 @@ common_ss.add(hwcore)
>   # Targets #
>   ###########
>   
> -emulator_modules = []
> -foreach m : block_mods + system_mods
> -  emulator_modules += shared_module(m.name(),
> -                build_by_default: true,
> -                name_prefix: '',
> -                link_whole: m,
> -                install: true,
> -                install_dir: qemu_moddir)
> -endforeach
> -if emulator_modules.length() > 0
> -  alias_target('modules', emulator_modules)
> -endif

In my experiment I moved this later after the qemu-system-FOO
meson targets, because I append libqemu-TARGET-softmmu objects;
but I guess this isn't a good start, and this patch LGTM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


