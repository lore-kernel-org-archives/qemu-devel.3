Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC8AE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 22:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsq28-00088j-36; Wed, 18 Feb 2026 17:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsq26-00087u-3J
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:28:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsq24-0000NN-KB
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:28:33 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a91215c158so1908015ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 14:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771453711; x=1772058511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6IFdcTrp9aJ9TfIYRuLMYS6d7a5qf5O6BB+ILdoBHIw=;
 b=yw4BKPTVZeHzpiHGxXC2uhnzTU9lermaVV9xUX8Yruv8s6kMK9SVA5xroIy72RVHuK
 3kw6peJNQWiZsy+H8an2HtN6LB5FSkAmUN9XLwU+XobODS/InWchOQpEoh4CNFmKd0Kv
 OKO0QPlUWcUghjNlFbV2y/SeJv0fBc5QaPBIuyPH5NSxNWLwitNFLUmQffZRxZUkdykD
 9vwOWzWELD3vjTw9hzE7LeOHvrhOwJ6cOVmzQE+urX3isFo/dEjTFhG4kj0M8kJWnGYy
 9s+G7pgbcujg2bQllqsQzhybXEUEX+VwmkDiAaUs8EvEK0yZBkeXmHMT7HzIXagr2+nz
 vrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771453711; x=1772058511;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6IFdcTrp9aJ9TfIYRuLMYS6d7a5qf5O6BB+ILdoBHIw=;
 b=T5o010itsCJ027noH6PeQusVK38uamT+jSLFDT+nnmNdUjYVYzSZMYnrB2aF12zphr
 j0AgxpO0DOShIEKztwXaibF0r5qvlyT2pnY1O4OgoTXcSlMz/hIfSbDO3hi81atb+WbI
 HQVB9/hyT7BPvR+yOL78JVUSWtJqKe017E/jNgwFCKmgPyA6/3hMfTFgM0BXfrRgwSuu
 8jflQf2hkqPjOmA+m34fm6kx2LNJ4Bc/th/Sn2geZO2IWzCRZeS30KL3geCoA/uqwUOe
 gFlN/a79ehJE9Erp/sbPIJgBGmr+CwIY+70nhn9btca5LEwdg7AsfEfXfImZSL8EKhR8
 BIeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGVJ4HpXibptoKpuKJj1WCwxXi4eSMdof8zOXD9tluEUvlG+pdYb+SH4sTk6gWVxppm27wQOMuZbqr@nongnu.org
X-Gm-Message-State: AOJu0Yz5hZdvPMPU3pdamLem3bx2uOhzT+aYyXzvlBBjJdr1ulhoSc34
 Ec1o08dGBD38Ukd4MmaYymrR6A59KujvBHHjkOsjAKrf9DAArT9BHjwR+0SKXkjt9ig=
X-Gm-Gg: AZuq6aI+iP7LbG9XoNCPujcEyUmgbxx/fc3I7EBEtgQq+8BBgTzZUSBsiMvzNuFOj4T
 7gkrn4u9xRTUY+GlgdCbxVxDnZFtatwDp/RQ3y2orIbAisZkxl7/DFFCv1GN5zi3shUDYo1/tqd
 oREn1lAu6xB8s5bod3hxNhPBXY+MIHPPtZvCCe5i/izXja1EGypYwM48XDRgxWOkB5gqHDbW//Y
 C9klYs43IN7S1t+ZfgV9KuB2/N0BabaBY2b+CEFkH4T308KrmoGJ0FXoJZ7R+1BQQOq+yBcpmgX
 YQoJVciv6d3VPs1aCVzK9aJq3HtjPtlnkTtwOj4yec2cecYdtZWtV5olACa4/7RgIvEG5cejFta
 eOAv5VucNUZaXKznp9CgrHR1aF8SKva3/jF1KB9FO1D2CBzwmAEooM+M/tiwhSZZUiXJHE7rNpg
 KkgF4oa0OI7Ub5YCUWClV19pPcaCurYVrrICYHxgC12oiOwVZ2VViW/MUpttUGNV+2P+Pu
X-Received: by 2002:a17:902:ec8d:b0:2a9:5b28:94c0 with SMTP id
 d9443c01a7336-2ad50ed845bmr30790345ad.27.1771453711096; 
 Wed, 18 Feb 2026 14:28:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1adef6e2sm139501965ad.2.2026.02.18.14.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 14:28:30 -0800 (PST)
Message-ID: <e7467958-6593-48ab-bca2-2f9b4701b328@linaro.org>
Date: Wed, 18 Feb 2026 14:28:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Don't require helper prototypes in
 helper.c
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260216160349.3079657-1-peter.maydell@linaro.org>
 <20260216160349.3079657-3-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260216160349.3079657-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/16/26 8:03 AM, Peter Maydell wrote:
> In arm_cpu_do_interrupt_aarch64() we call the TCG helper function
> helper_rebuild_hflags_a64(), which requires helper.c to include the
> TCG helper function prototypes even when this file is being compiled
> with TCG disabled.
> 
> We don't actually need to do this -- because we have already written
> the new EL into pstate and updated env->aarch64, we can call
> aarch64_rebuild_hflags() to achieve the same effect. This is the
> function we use everywhere else in this file to update hflags.
> 
> Switch to aarch64_rebuild_hflags() and drop the include of the
> TCG helper headers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

