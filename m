Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C91C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Bci-0002rD-Km; Fri, 11 Apr 2025 06:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Bcg-0002qQ-9L
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:28:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Bce-0006ZR-JQ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:28:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso13530515e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744367311; x=1744972111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJgaJgH1ayGQT4STGlnKfpb19CIyOTbXlUDxlQQFwyI=;
 b=pqy/oRsyeL2Ft6fOXcBPXYNxJgzWlWEnri9rUOD9jhP2OdrUMmK9BwWbtymQbQCkea
 49VQF3TkPX0mHB+RJCY4GdW7DKTeJ2ClfoC6dc47ezY5fm4n81GIxvfR+537HN+8qHd9
 PqvH713V7VD6ZQ947VLf/DdpM6iLimbw7JKaTAPg/TUwDjgbBEC53hu09WKsB18HpIMV
 ui2eBF6tiNNLfoiuw9pU5rq5F7qnuZmxrQFiNYLcmn0WLaJQaMr2h/3k54NOrnwKWjQ2
 mGkwIcrXjlAa7FHO1aw+N8BXHWoGlolDC2mxqdkxHemkgmAUuvZcPXw1FWDmwiHvKsxg
 if1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744367311; x=1744972111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJgaJgH1ayGQT4STGlnKfpb19CIyOTbXlUDxlQQFwyI=;
 b=CwTy7vs/cpiBLwzJZ1/ft5Xl5s7KXjZEyxq7+o4Gh56wX+Djut9jV+69/kiXUfEcRg
 N3cRsSa6Dc0CH9HBFEChxNl4f5ESxmMYMkKTsBajpRwjaODRHLLYoghBMGGTyXLw0YnK
 st3DLRWCfXzx1eClPmxW70+xXRsCOyr3iz/E6SqAVC1abrbn687jfWEKfExURbmDwDiY
 aFak4Vn9M1HWbdg2l51n0SvXeEGmK5Y7C/LbqX8FEck2WI8Rp5jGAMimuOGRhQTXvW/f
 7SW2jS5yGl4b7xuPdoa4JTMs2rpSnEgjIEXYqDHwd4frxXN7yx83RAAOn7enooh/UYbT
 NM6Q==
X-Gm-Message-State: AOJu0YzWMNZ6dIyPtB2F3rLNaDbTdVWGaEOX5tU9T/sWRLL2dN/XXlOG
 CwT6c2cNGlZfZnDC39qswhYK+7pHtTqjyWtTFYskBKFYCCEN59vBw36+aogq0gU05sNXt3KLbHU
 z
X-Gm-Gg: ASbGncsRQKzOlFQWx5kyKVyQd609nTt8rC8EZMIP6dx/OSyox1nXB9y6wJbdLuVFjyn
 rLwuvSN7ClY7NNcPDHVBQE6H2JfLvfiby86G6afF5KhFm+CTV4HlW5LKwfSvEnUNKsQt4dtyk47
 LZa/yMciqTxfNVf8zCbySCgoTGN5d4MTRBny8Dmx0+vNX6PgOvuzhE62N1lU0kIn4UgnzHltWCP
 BiRwGutxqz96wPCpv3dDSlPMEW2Uws6TahawZRrVZc+g24hvn24Co3lToK9DHLmrYf6b9GcyCJn
 mGUm6iVYUMDYAJzXrQnUi805d0xbW3rVPwf608vd/k0fGjp1G5RNg8R5nUS/RJujnFmX3OnN0h+
 au2S2xw3b
X-Google-Smtp-Source: AGHT+IGKEJN57rf68Xx7Cy5uQDx/xXqSsNOZz9AwFEvKQ85IkmRybu0Qo4tQhXIpj+PlK3GEsE0C6Q==
X-Received: by 2002:a05:6000:1865:b0:39c:1424:2827 with SMTP id
 ffacd0b85a97d-39ea5200a08mr1803535f8f.15.1744367310721; 
 Fri, 11 Apr 2025 03:28:30 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5d57sm80408585e9.34.2025.04.11.03.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:28:30 -0700 (PDT)
Message-ID: <ef79789a-c16b-4bf9-8acb-9fdb72711019@linaro.org>
Date: Fri, 11 Apr 2025 12:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] usb/msd: Rename mode to cbw_state, and tweak
 names
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-9-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/4/25 10:04, Nicholas Piggin wrote:
> This reflects a little better what it does, particularly with a
> subsequent change to relax the order packets are seen in. This
> field is not the general state of the MSD state machine, rather
> it follows packets that are completed as part of a CBW command.
> 
> The difference is a bit subtle, so for a concrete example, the
> next change will permit the host to send a CSW packet before it
> sends the associated CBW packet. In that case the CSW packet
> will be tracked and the MSD state machine will move, but this
> mode / cbw_state field would remain unchanged (in the "expecting
> CBW" state), until the CBW packet arrives.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/usb/msd.h | 12 +++++------
>   hw/usb/dev-storage.c | 50 +++++++++++++++++++++++---------------------
>   2 files changed, 32 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


