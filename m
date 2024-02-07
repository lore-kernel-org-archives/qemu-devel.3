Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10890C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoV4-0001Xk-Af; Wed, 07 Feb 2024 15:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoV3-0001Xb-Eh
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:26:29 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoV2-0000R1-5o
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:26:29 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-68c431c6c91so4404176d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337587; x=1707942387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UgJUWGCUarrtEPimddgkaMvfR2WMOKtuuoX0sL06ZG4=;
 b=SoPHSvyVlpRRSkRlPnYPrR+fX4Avnxd7YRtjXfRuYKcqJJRYG9ZeLyzO9v4c+AaFxb
 rRBT1GZBWtTBun5OMdg57FRVjAs697MhTH8bsVs8GFBGacPDuaJE8eups3whTD/AlnBc
 Sl6B41ode3enLtSpcycue9bwIfrUUcEIONACuwraxqQ0SEGCyZdXld7SVP2tnd+q5aJI
 xHzM/Ev5UnvZiJSfRIjSOtcGzGl86fu+hGmHbVkxHOXKbgDIBARDbQcNdJnneGGjew5o
 K1/gylhQqd/y8ZtH7bBmh9XOKtSJHHzMVZ1BlvB7jGIXjuJPQa/8zwtDurlHcAB77Sw1
 /y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337587; x=1707942387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UgJUWGCUarrtEPimddgkaMvfR2WMOKtuuoX0sL06ZG4=;
 b=jFbCFRW8/HXexa64MfeTZQZUE37HIvsYNvNErGAi0HZ5UJ3FWRNxkCnU1/GAFGs6wI
 1lK52JnnOlpoXRgARmEjhINVToR+zOqn/wm0H6DYId9fAfJsme3WHcZxSM/6OiOQrAD3
 uOni1swFH6OKhh20Cwf8A+POSENc0q6aR1JRrAJ1EIWEVudis3wEKrNV1WPxgusQ9l4M
 6hh8nDUpZ4IY1oPLoWt+niveJAU9dftECujOPhudscNowYipwhHoEsNoQTiomABPOLPf
 /1jL7/0f3/mpBBGHlbukA5IQykBr+/6rM7yYdbedQdszrK1WGgjTW3NlarJ/N+vz6tTd
 gprQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRp/wy9zC+qY9RQkDWFUO/Ksss7DW3i0K5Glm/MOtDA41shWv5QbJ/bN/nEr31VBHBiC0IG9BFx4ajduneaWVm5336E6E=
X-Gm-Message-State: AOJu0Yzl/+3u8xxz1R6u3J/Dkq2oGxGYcxQ9hRfk+7nvyTKMV0kUZU3e
 Qps7YGcY13zK/vJ+m0GM3C+tYKhBCl6slQQ4WroafVkNbJJSlcn13XFDuvm05QM=
X-Google-Smtp-Source: AGHT+IGbIJQV+nUS45j1FmEo+NE4g2WJp7T8C5BwfWcFtMc7b3DIH6JQZzkVJwWBp9TIBnXNiMWUaA==
X-Received: by 2002:a05:6214:301e:b0:68c:8a1c:53fa with SMTP id
 ke30-20020a056214301e00b0068c8a1c53famr8106476qvb.46.1707337586881; 
 Wed, 07 Feb 2024 12:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVfKORN6uOc87GAEsBhl7t6Ai1nWrieewWvPNeiyjdex6AzDtr48U3JMZ344nSp8PdGjOexL6V0RomndD2r67z2EZqx0sCS4/8OBY3dVzibHPLtUvuV8J4em1w9UyeojObfic/XXFgQkGVp7BskTIvx3Tk=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 kr4-20020a0562142b8400b0068cc67a4070sm80801qvb.94.2024.02.07.12.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:26:26 -0800 (PST)
Message-ID: <7d900cea-53ef-4224-aded-1d8dc93aacb8@linaro.org>
Date: Wed, 7 Feb 2024 21:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] migration: Report error when shutdown fails
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-13-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-13-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf32.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> This will help detect issues regarding I/O channels usage.

English isn't my native language but I'd expect "detecting" here.

> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   migration/qemu-file.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



