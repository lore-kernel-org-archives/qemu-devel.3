Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9E0C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEDXr-0006AX-1a; Mon, 03 Jun 2024 15:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEDXo-0006AG-LW
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:40:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEDXn-0004J4-3h
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:40:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42121d27861so2337395e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717443633; x=1718048433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73PFY5xWborYI1O3JlhX3yOnbYtZ1/HEH+/R3eKO5fo=;
 b=weXOLAO+sAP8L/WmRFA6YeQ3wnTjjY0rirdhVjqiQib+6WPWvGIoOQFbGeFXGEgXjF
 c8OgJ5k9vl8rDomBSwEZ9Ea2EFSfZN4DRs1DI3PaXOxfxB0+2ZeQbgzgCzksd8wjM+kX
 qv9qBEfdDXzSEGY/byU2075gFpJ4KLy4/RUbi3FKTuLPh3RjPgfxLi02mUPvi86kvoIc
 N5xNHrzlXoaIVVZK7erT/d2zGCMZLvRW2N9ueuz7sTTcEtW9vdUXQzDQcMZls5pG+R9q
 LlsBoiCq5F0ueW+kKnT0iobI9cJ4c0dApV+wnizmhRh/KSwBW7gPFjXOmOyvLnos8eeZ
 14hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717443633; x=1718048433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73PFY5xWborYI1O3JlhX3yOnbYtZ1/HEH+/R3eKO5fo=;
 b=jxkQvJ/rh1YmlHTsDL2qE3ZxtxqhH1ZrZy5jnJg8sLI88Vd2exdBbpH34WNTgpPoCE
 +A2uqpC/S0q86SnoPNQSPWvJwoOevukAXqoVP7XAYISkmwJ7MMs/WUV6O3jy54/iFnJv
 0lgI1ufHvUhi41jMwG8O53rIlW8O266RUqFMpLJj7iy4/zYvxblAvexfhrhrAWxfykfn
 WgJZDEmsZ7SDwQ2UXe9ZU0P3ANI2BBy8SRueLS49AZW5VCMR1S2wzMQEEtaSYMpAs2h7
 bYfcMPBpzg/lbOn0q5LlA2deAnQsGfivbJ3V4tngU+1A7aEOf4SOgqWUk+poznIcvi+H
 trDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJt7JG+CWDjIT8c/pVx6vZjXMsYadL6Sm1dtJWmEsQ4WAN/KEDETU7+p/bLSCZ/ajzvhrZTaUq+s8Oc5IHZlVO1qa8jGw=
X-Gm-Message-State: AOJu0Yzy9/6R2SB2+bW96KPN3dQNAuSJwoyaS1qRVBSLlf8L+mVJKWr3
 UPS8T+xS7eBIMRU5pWdUBloYFosK4VZeg1ALwNYGeBUt8xzzxDT/cf8pPDCVcHY=
X-Google-Smtp-Source: AGHT+IEr41gHAHMPST4HWcu99m4k9PKxhs0+QdnMgKaFdqUzIGAw6aV31xx4cg09B9eBR1R5Vnzt8Q==
X-Received: by 2002:a7b:c449:0:b0:418:fe93:22d0 with SMTP id
 5b1f17b1804b1-4212e09bc0dmr71948795e9.11.1717443632210; 
 Mon, 03 Jun 2024 12:40:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421381c650csm84966745e9.27.2024.06.03.12.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:40:31 -0700 (PDT)
Message-ID: <74f43b2e-889a-4a97-b1c4-b71d6de83a8e@linaro.org>
Date: Mon, 3 Jun 2024 21:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/27] util/hexdump: Remove b parameter from
 qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> Require that the caller output the offset and increment bufptr.
> Use QEMU_HEXDUMP_LINE_BYTES in vhost_vdpa_dump_config instead
> of raw integer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/cutils.h  |  2 +-
>   hw/virtio/vhost-vdpa.c |  4 ++--
>   util/hexdump.c         | 13 ++++++-------
>   hw/virtio/trace-events |  2 +-
>   4 files changed, 10 insertions(+), 11 deletions(-)


> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 96632fd026..d01bc85037 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -50,7 +50,7 @@ vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRI
>   vhost_vdpa_reset_device(void *dev) "dev: %p"
>   vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
>   vhost_vdpa_set_vring_enable_one(void *dev, unsigned i, int enable, int r) "dev: %p, idx: %u, enable: %u, r: %d"
> -vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
> +vhost_vdpa_dump_config(void *dev, unsigned ofs, const char *line) "dev: %p %04x: %s"

Queued squashing "0x" due to:

     ERROR: Hex numbers must be prefixed with '0x'
     #108: FILE: hw/virtio/trace-events:53:
     +vhost_vdpa_dump_config(void *dev, unsigned ofs, const char *line) 
"dev: %p %04x: %s"

     total: 1 errors, 0 warnings, 67 lines checked



