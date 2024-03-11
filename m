Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED21C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 16:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjiyQ-00059L-4P; Mon, 11 Mar 2024 12:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjiyO-00058w-95
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:58:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjiyM-00062x-MM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:58:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd5df90170so32517525ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710176276; x=1710781076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qYWv8obsGcii/YA1WqCx1cbeTvrE2xdXuR63R/9gX18=;
 b=dEcAurVBSZsTnlOej9I67LMwbgMcQDx32zH/yiHVIE1EICajDTBC9XklxM8wgJM9fo
 z+AAaxu0LrtqCfxzdLul+vqT8To2SaCNKXcUa3X2IoXyD7beGONXJSkjqBVK+A8E9Sdb
 wHEmNI062JQOI6GkKcDtOPatzcdIk6JX0+70FOcJb/RaMhhUWzM1/hl/qlSEkB1WbzfG
 /O2CNLqKGZ6SJ8FlIm8IM34NiCJldvchf87WKrDrvwnN9CRvo6E6hu1SqqYGwnrtw8PA
 cuaJCgF1oXN7tNKi8OOiADh323fOezQyyMaqVO6cGzs+pPuEnvDPgYeGMhs8QLvUIQvv
 GrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710176276; x=1710781076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qYWv8obsGcii/YA1WqCx1cbeTvrE2xdXuR63R/9gX18=;
 b=roCZhvV0729uYmJ0G33CdgyWXJFotNUIqbh2yZvVdBT1Q2JSKvdHn7SNrw98tRZplS
 /oUBrIarB5HQPHlbfsttqovyPyk0kNw+oYz6EGriYSY8tTxi8vhfF/hpstAECga5fXSw
 qAXk5hW8t8txLHi9cBFn9hPM3vARF8yiFPd9FOe6H8GQzvLs+TmP5tYm4//L9Mjq/qQE
 ojDRb7Tol86MhoGIn/OBkjjQJ0c/uBSNZViVXVGG4TUi3mvSwLiH5UHS0ecqWkA2oyIj
 IiLQlQCLD+/3a6WBmuEnjikAlMzUwqigKlvNC0oC/awOT6qpbgzq2xI8EdewuFHiUFGL
 mfhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX71/F2MOVgln0D4mipqDaRriyhX4FzXAmbi476lPCs13PG/ubyemu0J1rCAMev9Xbeoume8MvSSSHsWGLA+ZKlW0eF49s=
X-Gm-Message-State: AOJu0YwU7iuVpkSB7aSGIkbQvj5xTKeUPKnhBN4ZyMHqf/FJ4a0cmc07
 CwSh85Y/W1m/aCQ16csBd8kltCmzCaHoQRGsoCdoHe4BH8ZNqWbthYKLpZf5Qzo=
X-Google-Smtp-Source: AGHT+IHlGQCxXI4Kd0ZPWBDn3hxnxW0+xMwTt2SkIGMXeWvA7W47TftfeQj5w/rNul0Rbx5UqWt3oA==
X-Received: by 2002:a17:902:f70c:b0:1dc:c8b8:3cb7 with SMTP id
 h12-20020a170902f70c00b001dcc8b83cb7mr10273132plo.13.1710176275715; 
 Mon, 11 Mar 2024 09:57:55 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 v5-20020a170902b7c500b001dcf809f1a9sm4915858plz.46.2024.03.11.09.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 09:57:55 -0700 (PDT)
Message-ID: <09440412-b235-4d31-94f3-f00dbff77319@linaro.org>
Date: Mon, 11 Mar 2024 06:57:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-stable@nongnu.org
References: <20240311075806.668555-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240311075806.668555-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/10/24 21:58, Paolo Bonzini wrote:
> The low bit of MMU indices for x86 TCG indicates whether the processor is
> in 32-bit mode and therefore linear addresses have to be masked to 32 bits.
> However, the index was computed incorrectly, leading to possible conflicts
> in the TLB for any address above 4G.
> 
> Analyzed-by: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> Fixes: b1661801c18 ("target/i386: Fix physical address truncation", 2024-02-28)
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2206
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.h | 2 +-
>   target/i386/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Oopsie.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

