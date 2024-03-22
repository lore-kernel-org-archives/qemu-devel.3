Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B99C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjZx-0000IX-N3; Fri, 22 Mar 2024 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnjZw-0000IF-AT
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:25:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnjZt-0001o8-UH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:25:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-414689ba80eso19713885e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711131916; x=1711736716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8yG8u7IEzvRxugwGmfAnGJMln7xpuVTlBits2Dm05aY=;
 b=AClKl5HRGODgHr/M5YlJZWvn//wLlofzXpMZp/34NAic/EnmOzvGZDrv9bU9JlE8Rv
 O0fuqLyNMfQUqxm2CGN1WC6f8Cg/5aFiRKfwDx4YaTSZB6duLMcD3MV6hDRh1Gk3Hjc4
 IbseFEjqmdbRGVpg9dIHZliVpz3yi8nhSIpLcUBTiJOsInEOP83G9OPYprlGbMMrKtkQ
 gX/3d+HYIqbzYECvcqU2KlzoVlRlxckXZzRc6Ryuc/eRFiCb/Gh6wILrF08lAqsMUgDc
 4chNpss10bzUshU7xXwyuFPdhbjQbTgqr2AmmncqrnjdUsF4kao/EiUF+ctNggSvPMeD
 xAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131916; x=1711736716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8yG8u7IEzvRxugwGmfAnGJMln7xpuVTlBits2Dm05aY=;
 b=P5g2nfMYiBCZe70IqQzJ8Bk7dwwmc3cR9oiHOKsvEWzvin1ZA1sMeMjZPHLO82bI7K
 xKTdKkuWGjeAri77v+cTjAdClhgPpn0A1d091qjeMy9mTV+fiUFo79r0A2O+WmarndzB
 jThu3EMslTc2eEHZGhIU6fL1p8y4rOFPIR2DIRF0hZr8Fb2LZT25v4GtcaF1MphwoEpr
 fQpT12ffOZm1mWbr7Yi9zUVVdCIbuncuIcE7JD267tkV13G/fWdYyjSU0cj70iZTXIvu
 zwNm3OuXQK3NV9DNioW5bIDsQiIIYPFTeYZrTk2+AEEPswy0yMTsxvoMFphzZCCOTrSs
 9RzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+r7AU2GImNcHnJYxUW63gxEH1xp5OgoZRsorWzfjoDkQL+0bRswXfPHbMfygnGdm7S+DzKu+frFwnM06Sj2XzVW2viNk=
X-Gm-Message-State: AOJu0Yx5NGlc6GwiiohSCNDOYQZnIylFw4kUK42arR/zcKr7L+6DtWAZ
 Nb1ElEae915Leg7K5xdmIgkW+oDwPhxKiZi9wrfZFpaNe2pvW7DPuVGT6OrJTco=
X-Google-Smtp-Source: AGHT+IEH3j0q3hVdSEWE84ziJIh2ori1R/ymLziGGBNGjpkY9Y7NSzZ1iS3BciIzA2r9NYLKKYRCAw==
X-Received: by 2002:a05:600c:1c85:b0:414:1400:9773 with SMTP id
 k5-20020a05600c1c8500b0041414009773mr156590wms.0.1711131916065; 
 Fri, 22 Mar 2024 11:25:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a05600c34c100b004147dd0915dsm227947wmq.21.2024.03.22.11.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 11:25:15 -0700 (PDT)
Message-ID: <e2d12804-c9b4-498b-a3a3-0b0e3900c925@linaro.org>
Date: Fri, 22 Mar 2024 19:25:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: move logging definitions to hw/virtio/virtio.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Hao Chen <chenh@yusur.tech>
Cc: mst@redhat.com
References: <20240322180329.1227880-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322180329.1227880-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 22/3/24 19:03, Paolo Bonzini wrote:
> They are not included in upstream Linux, and therefore should not be
> in standard-headers.  Otherwise, the next update to the headers would
> eliminate them.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/virtio/virtio.h                  | 7 +++++++
>   include/standard-headers/linux/virtio_pci.h | 7 -------
>   2 files changed, 7 insertions(+), 7 deletions(-)

Fixes: cd341fd1ff ("hw/virtio: Add support for VDPA network simulation 
devices")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


