Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215FBCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waE31-0000z7-UX; Thu, 18 Jun 2026 10:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waE2t-0000yn-GJ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:48:45 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waE2r-0001tm-94
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:48:42 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-396bed274b9so11348951fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781794118; x=1782398918; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JylW0ndBs0YdeweZT+xeoVYe9FvKh8ulu50mJ6Un6xs=;
 b=zkakgCysZ1fmRY1CImyry1N+ipNbUo5C3qNG6EyfPZ27evBmiKWqpWW7+/XCciF5KP
 yV3U9pkYsP5x+2TFICXW0TWwNVkBZJQ6x2czV+NyumfWm1YCux7dyf/zusavWhwGwDCq
 fi6IV3ijL11qqtBeYp2kGvg/RwSbOis3JNe+v8T9LXilngBnSG7N7gt+JOr6SBehKNbF
 KLUkGfvIRcGrFg56/4aJXZeJHj9gMyzTUIwnmkMbfpLo6OPkD5v1waBs4k/P3Gth+Ogy
 johYQTzciAFdwDAKy4JmD7f7KXq+SHsJ215ZpG6Al2mwQAJgQcI9+y40ZtoBjjuv5FsC
 IRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794118; x=1782398918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JylW0ndBs0YdeweZT+xeoVYe9FvKh8ulu50mJ6Un6xs=;
 b=M94Ulh10SDYD72HA1pMGLEuYgDwPqwW86wSzatbR096zJQEe1sta2Kky0pZuJx+Cnd
 9wwl9vWTpOoxI+0CeDZafi2LmdToXSaNi6Yahc1tkClZv3MFpXVOrZz7VgSEsdZC3lxH
 fx2jjpjzqFlaIL57EDiTemos5nhTTWKs5ul90s3graA4ZKSvjAdTMrGDH7Ue8kBGpaNS
 +QDCTIpboG3ID+jlZ5aD3uXqEPiOqqqKkE58IrtPJZi7jFVEQdgmwLaPRFbxvfUjQbe6
 g8lKTANuyrCp/rQDJXGg/hRmkKJiFYeKSyMgJWfJQ5p6bS5KtCo6UfAW1lnASLbCvrBT
 jqmg==
X-Gm-Message-State: AOJu0YyW3HP1jpbuygTIsJ1UcHDW+vFttROU+6hjL9ns9R2KaVCzGskG
 5VLMo0wo5/Cvy1/YSXmTIm4k2W3LF8TdrfSEkKdWikP/0Vw731Ed4yi4qF7cPiHvXJw=
X-Gm-Gg: AfdE7cnPWZQl8DAlQJuki8hH6hg7vwK4TtbF4kqE+jZ5LW/GgvsqwV43yEHrVKyIOy2
 aZ5F/RN4t086V7hdCmrpeWVpixANmys4vYItCHVebrHDR8vDs2qTvwfsfJTOVRkxhy+heuXoBsn
 hUVyUH8XRYJwQ7MGvFBz6PT6iPPRWOymEFHWV9uaznad+3RmG/GjV27O81Zu8A2b/J7QK+mf7at
 oi9QMvG9q+tBsPMGsqcBtiqUyAXnu8VnuUopkO+FuHYgvjtTAUEW3M1viSpjli9l4CHq7qbXeeJ
 X2rGSqDxQmWQ/2gF10iS9Y0druXwcWkhqtN7nDPGk4KX+Wgn9URnhADi4HezKiwpwKau91RMu/u
 rF09+FRaGQyoRHR4ewV5/+iBXUAmDGN1h9e3Sc58o7hyb5PqyjQyoXHfAzPnq1kdzfXF5gJfV9g
 +AW9fv/n6hjYI=
X-Received: by 2002:ac2:4f06:0:b0:5aa:b6a:6028 with SMTP id
 2adb3069b0e04-5ad4dac97b2mr1350517e87.45.1781794117808; 
 Thu, 18 Jun 2026 07:48:37 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:b52:6a9:569d:e33e])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad4baab437sm1317173e87.81.2026.06.18.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:48:37 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:48:35 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/6] target/arm/ptw.c: Add Granule Bypass Windows
Message-ID: <ajQFQ1RY_JfYooNH@linaro.org>
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
 <20260603-jmac-gpc3b-v2-3-115c51936962@linaro.org>
 <7615fda1-4052-4696-b477-6eacc057c4a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7615fda1-4052-4696-b477-6eacc057c4a5@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-lj1-x22e.google.com
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

On Wed, Jun 10, 2026 at 09:41:56AM -0700, Richard Henderson wrote:
> On 6/3/26 11:26, Jim MacArthur wrote:
> > +    const uint64_t BW_STRIDE_SHIFT = 40;
> ...
> > +        switch (bw_stride_field) {
> > +        case 0b00000:
> > +        case 0b00010:
> > +        case 0b00100:
> > +        case 0b00110:
> > +        case 0b00111:
> > +        case 0b01000:
> > +        case 0b01001:
> > +        case 0b01010:
> > +        case 0b10000:
> > +            bw_stride = 1ULL << (bw_stride_field + BW_STRIDE_SHIFT);
> 
> BW_STRIDE_SHIFT should be 39 not 40.
> 
> Everything else is correct.
> 

Agree with the simplification, but BW_STRIDE_SHIFT should be 40. As per D24.2.54, a BWSTRIDE field of 0 gives a stride size of 1TB or 1<<40 bytes.
(gpcbwu, the highest bit set in the mask, is indeed 39+BWSTRIDE, but the subtraction of bw_size from bw_stride has the same effect.)
There was an error in a later use of bw_stride which might have made it look like something else was intended.

I'll respin with the simplification suggested; thank you.

Jim

