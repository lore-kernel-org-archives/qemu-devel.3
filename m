Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45117CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYGA-0001rP-UF; Thu, 28 May 2026 06:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSYG9-0001r3-AR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:46:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSYG7-0004Ia-JY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:46:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so49512915e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779965198; x=1780569998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eeF0ts7l3YIRkWhAo/1VWjNepW5xyLLyZvF+TU1uk90=;
 b=GmHm6xZBmdJTtUI2CIydg1ruFzF4wo3CYR5ZK/W8yEY/ZnFNDpXa2bH7AQRjBVhqsx
 yRy7m00J/FGHpX3HcREiPdxLEWWRwMsuXijq7ERIh+HVNlF2u5k2tkZg4WWdZce4Bvnu
 cjHhHllk8IOXah7gZnVPG4PRbNaNP+ZPc5MXJeDIdy3aJ5VBvvxNmrZyeF3BHR2x3+Aq
 70BwPRqZzdz23NhsBDbDazHwHK6LiuqMDhHcqUb6jfyisybUMmbjPiDYHID57MCdU6Wc
 w3gZIAmfNqQsJzMh8FCROSR+uQSv6e3CMpgp8yLtmdVnfFCkviSlPeSHswjdZZorHVPT
 zbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779965198; x=1780569998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eeF0ts7l3YIRkWhAo/1VWjNepW5xyLLyZvF+TU1uk90=;
 b=h8755/zj2x5O1Q0W9kVj7cJeqH0X/KHrDBvdloX6Y+o336IARahbt86ZPXKh7Cm6xw
 ignKl6nRnD3LElr+v+72nEuRO1LjcJGOER3RN9O3Hm6mrJjv263F1aRAZ8Z1wDj1Y7Qr
 OC0Q7nBDLDbjOlOiMFW3tmoEWEYm3fkzHwx+AdoZ0MNeSpoByfa3g7KG4Yr6ZIjRQy24
 dYpZwa+4DLHa2E19ocKqtcT+3z5yCLSlg1qGP994vcQ0Qd3l185LTBUiKhs6j6RV8w/P
 1iV3f1YQxbi7xh51zPOVmD9Rl4RXp8S84cUa6sef4Lk46wVNSVItfgAOPm4iBf0lPabE
 nZYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yTApo+aJ9Z0CZCQ+acj+m8eFEQzRDYBRyYU0lmPTLd8uWik7BDdV8cJBDtWauGGDY9kdU3AA7C6xc@nongnu.org
X-Gm-Message-State: AOJu0YzLgKcZb/HY6u6X/PsrUAdfFLZ4+MgYxBs7lrg/I10sd4IQcmEm
 wn4rIkjJ8hcux6E7KuAOEC77GadQyivhpUMwjUEsVe93PGGij0u3bhos2t4ba3C+qsw=
X-Gm-Gg: Acq92OG/MNN9WoSjs5ebShiQjbIEGftXVEXCbFXdZ6Vy6wb5ZzNABoipPf/nxSwU3oL
 CGpJUQUPZdyk4SFTOA39xMLTS1bcZV/IPkYxI22DRwEqKUTIsjeTpoR7SRBkQ/383+54JNJS77x
 UBBr4WTsAgLhvtLKGNSVBzIcJkYDyxENijeND7mh7CVkF54osphtxEKmbbAFeliWHrArZavpmlA
 QClrQBjJsX8u06QeCnyQJAXnW9PzOhyz5d96hQHfOc3yzT9bUGcbv7UyIW8nm5CaeDQCFTFfRmG
 MAom7ZEwYc/MHSmPk8sv361e5Tv9oz4MNnNz5sPs4+qYPImYsi4OYpqcnVH579c93KkSTAMTS4p
 1wRYDfJuxED3S2QwqtiYefXywAF6qmBe7qNQhWeFw15AX1Cvx4DFc+jULtA5HCBTJkIrL2Vl+RV
 o9nchvpvLbiLArmFn6hnaJymdBZhTaqpzN5iryUrC7LdSS81st/cr7Dxt6CNwDBFvWMUKYPWC/q
 lAH
X-Received: by 2002:a05:600c:81c5:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-490428e6ab6mr404722335e9.29.1779965197808; 
 Thu, 28 May 2026 03:46:37 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b5841a7sm21617105e9.2.2026.05.28.03.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 03:46:37 -0700 (PDT)
Message-ID: <6d349d21-bf5a-4d7a-99be-997f205ea2ee@linaro.org>
Date: Thu, 28 May 2026 12:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm_tis_sysbus: defer resource allocation to realizefn
Content-Language: en-US
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org,
 stefanb@linux.vnet.ibm.com, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, peterx@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org
References: <20260528093123.55403-1-mbawa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528093123.55403-1-mbawa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/5/26 11:31, Mohammadfaiz Bawa wrote:
> Calling memory_region_init_ram_device_ptr() and
> memory_region_init_io() from tpm_tis_sysbus_initfn() crashes
> when the device is introspected without being realized, because
> the memory subsystem has not been initialized at that point.
> 
> So running:
>    $ qemu-system-aarch64 -device tpm-tis-device,help
> 
> triggers qdev_device_help() which creates the device object
> to list its properties, calling instance_init, but never
> realizefn. The memory region calls in instance_init then hit
> uninitialized subsystems:
> 
> With CONFIG_DEBUG_TCG:
>    Assertion 'target_page.decided' failed. (physmem.c:2524)
> 
> Without CONFIG_DEBUG_TCG:
>    Assertion 'mutex->initialized' failed. (qemu-thread-posix.c:107)
> 
> Since realizefn is only called when the device is actually
> used in a running VM, moving resource allocation there avoids
> the crash without breaking introspection.
> 
> 
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
> Changes in v2:
> - Also move memory_region_init_io() to realizefn (Philippe)
> - Make host_page_size const (Philippe)
> - Reword commit message to cover both crash variants
> 
>   hw/tpm/tpm_tis_sysbus.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

