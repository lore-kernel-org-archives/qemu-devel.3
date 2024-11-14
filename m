Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63064D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcKZ-0000ZZ-EF; Thu, 14 Nov 2024 11:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcKT-0000H2-Ob
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:04:23 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcKR-0002ie-50
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:04:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so6888505e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600257; x=1732205057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xx15cktm0Swu3pN2YH27/w4/Ui/AEI71K03LT+vnX7Y=;
 b=q8xi6LrBhuIjNCaJzvPA0rrpGWLCM++LRyHWfSiyHGRCWqZ4wjP3vLppYyXweLFJCw
 +EyQL4+NLm7KbsBNl+RkTMIBUEvPQEDyJn/2/mDwAAJcPDs09MAk9tw/NyBc18tXadA3
 X/00UPGLLmRPW0MXeM+KP4L4REDV+VYToNOLoLgG/31YQeaiTxJHZStnhkz7od6Jgc4m
 8FZlEDSZUm150KWqUbyKAPvKOZ6Otz/KkrhTtcY7UFt/toM/SlLfzMcG8xSbcMAOsNBE
 vBQepUDNdcOqRX2DLxEiEQqOxjdHH2ZJP1l4Ll5pPb9dBEE2f1Q13WdofcVPGwHrZEmA
 yP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600257; x=1732205057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xx15cktm0Swu3pN2YH27/w4/Ui/AEI71K03LT+vnX7Y=;
 b=V6CasLZNg7zLKbxGzVeDo/7DXL8tykxKOKHV1SYHZUAST7EknklHwG4plU6Ss5i+Xg
 m0Mo3Y/jdTvdL/6JPpi3P5FucKQyq9vdUYAnE+UGCMwOoet3tnovwIujLcW8ha9CqWHu
 Lv738BGiLywTHlGg7X4tnb8/DD/CDzzh75n/JSotlEtHFVM7BEm9zJ3A/+xtnc8jVLgd
 oLhl9e/wmu3tACaUze63PDAstec8eeWQJqNUO53uHb59sgX0XS9bYU8Z9txMkYDdWnWq
 CJENmL7j2sPMo967rkxBu2xc+bihwjTjjOVJazvMwzdXRyiq6EXO2qs4Wh7KBjgVwYMN
 ii8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDV+427MUu91WxwAbFyhK5AZDfxJOG4XYOKUCuONSeuLLS/dcuxaVQUkdRQV6iKcSmLyjQLvq/xTfv@nongnu.org
X-Gm-Message-State: AOJu0Yzcu1Cnn8jlLijbGgBMFZJurwE2rjQdrJWpaWA0AWsy6Av2BpfB
 u6K2v+CZJ7CsV4gR8f+0fW7p+GLIbAksrNeBoty1FDerPhnTbeX+SQ4dozOgf2c=
X-Google-Smtp-Source: AGHT+IFrhERMMzV68wp38SKtV0bSsRbH/yEOqZBAsqVIkMmP5Ow1zLjw2R/G/V7t01yYCNgMT291fA==
X-Received: by 2002:a05:600c:5125:b0:431:588a:4498 with SMTP id
 5b1f17b1804b1-432cce7295cmr98941855e9.14.1731600255773; 
 Thu, 14 Nov 2024 08:04:15 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d478511dsm56723365e9.0.2024.11.14.08.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:04:15 -0800 (PST)
Message-ID: <f4bcc425-5077-42ab-996a-b2940aa566cb@linaro.org>
Date: Thu, 14 Nov 2024 17:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/net/virtio-net.c: Don't assume IP length field
 is aligned
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <ybendito@redhat.com>
References: <20241114141619.806652-1-peter.maydell@linaro.org>
 <20241114141619.806652-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114141619.806652-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 14/11/24 14:16, Peter Maydell wrote:
> In virtio-net.c we assume that the IP length field in the packet is
> aligned, and we copy its address into a uint16_t* in the
> VirtioNetRscUnit struct which we then dereference later.  This isn't
> a safe assumption; it will also result in compilation failures if we
> mark the ip_header struct as QEMU_PACKED because the compiler will
> not let you take the address of an unaligned struct field.
> 
> Make the ip_plen field in VirtioNetRscUnit a void*, and make all the
> places where we read or write through that pointer instead use some
> new accessor functions read_unit_ip_len() and write_unit_ip_len()
> which account for the pointer being potentially unaligned and also do
> the network-byte-order conversion we were previously using htons() to
> perform.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/virtio/virtio-net.h |  2 +-
>   hw/net/virtio-net.c            | 23 +++++++++++++++++++----
>   2 files changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


