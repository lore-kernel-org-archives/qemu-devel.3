Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08593C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZf3-0007JT-QE; Fri, 23 Feb 2024 12:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZWo-0002T3-8L
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:40:06 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZWm-0003li-MM
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:40:05 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3fd9063261so90978366b.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710003; x=1709314803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VGGmYKBtGyrEXg7PQosxhJryPY1sVVs+n78Wd0Fnfx4=;
 b=m9r25dsPolGtGjc1YVlLHKbdgudm5fwY0EhMXMM3vq4DX29C9k+O+VSevnO/oA8Znm
 wHZnH6PlTBRRIljsyKS923HViVHIes79ZCeG+TmfwIrtKpAQBhtscAyzT/vdSVIyXyOM
 G5ovj0oV0dIbLz6vrxUd3VRZL1Xhnq9JWDijW0YT7wwORt+NglJ0nXHDyPpAT2cjbMkL
 IuQsErGvLY4jJZBmRDu1Isr1FJsWLmNg557gdQIW6Gif/JoabIwMN8zgWksUaTd4BZkD
 L7qcibHIa1Dkyvr//O5GpGUNWVXuFWxLevtOxoiXfALmhlcHj2W4ZQI7NIBDhzsIl225
 kmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710003; x=1709314803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGGmYKBtGyrEXg7PQosxhJryPY1sVVs+n78Wd0Fnfx4=;
 b=inzmcOwpLuMdDcm34fgEmIAlvrz5/liw0A2mJXvS9hFY9qMfgwpgkHgutNVQe23ksa
 9e0EGW6ESM8PPVaoTwNqiedyMSMaB/NYT69sSKzA+mHcFn+o9KgVIDT5Cusxm+OKBcbj
 h7bqTjotVMzY4hjD8sjDo+xNld/ySge67+qgUbjiPi67IGgQEgKmsZJ7sfmuNIx/RacJ
 icJmkjn3Yjqxfkr4rByIJljl4aHo16KVWokOn03IzFtudXjoJfHBEmeWNudr84NfGIe1
 izNe96HdUwGuLZRWt0haRd8KLKal2/VOSJRhBsQldj9mbgji6JVx8wXD1swnbMcQ5Bf0
 10Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMkktOT0+9CXxnDFNRP9wDl33VRjbkHFCCCmCy5nA9p5zdbiRGcWSvlsiVFf+M1L/kgPgihSqZWntu8tFZrsuomI7oyJM=
X-Gm-Message-State: AOJu0YyZT1n/DViEe+pTQePUDcHr7kBatjy9uCtHgPXpursUv8fP+f+s
 91TT/YOVyztkWFPyqxK2gZFOM4jSACEx9cA0A2H6SbDjIYICAMZo9wN8rJFBxGs=
X-Google-Smtp-Source: AGHT+IHOyXceUiEgsBMwIpnDqX1vObgw0NzrLREYp9trbjW2IJxB9W2tFbbpQ8GiZVVre8T1O3P2Dg==
X-Received: by 2002:a17:906:4749:b0:a3e:4cb3:13d2 with SMTP id
 j9-20020a170906474900b00a3e4cb313d2mr333033ejs.17.1708710002683; 
 Fri, 23 Feb 2024 09:40:02 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 ps10-20020a170906bf4a00b00a3f876b2f67sm1672122ejb.47.2024.02.23.09.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:40:02 -0800 (PST)
Message-ID: <09963d4b-cc83-420c-8c44-dba249bc332e@linaro.org>
Date: Fri, 23 Feb 2024 18:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] usb: remove duplicate file in system_ss
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-11-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 23/2/24 13:44, Paolo Bonzini wrote:
> Because USB_EHCI_SYSBUS selects USB_EHCI, there is no need to include
> hcd-ehci.c explicitly.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/usb/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



