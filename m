Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4422EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB7W-0004ZN-Pt; Wed, 30 Apr 2025 13:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB7W-0004ZE-0B
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:21:18 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB7U-0005iO-4u
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:21:17 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af51596da56so90196a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033674; x=1746638474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o5379wxRTyHBU1utcJv0I1mi8og4i4yWwZvyD3OfOa0=;
 b=Bbn6yjlU4GozBSg8CSYBnhy6bP9EfvkiKRt9SKvB26Cdcx05dSA/HykxgC46Of/WHS
 0qB8qJ3jsSct9K5ddE2n9UUl3DqO0BLHasgCIVp5HlPFkkg8vOMP6v8WDv3zvPLLraSL
 TofuwNFyAzgyowigttT3qkyfKcz2YBXXTNUetZKPBhEzsS6nxYv7jP27/rYCQs/EJ9sI
 qjWsCH0XYxKiJI9hZt1Mw4W/Ic8E2Dzde/lGdwIPq0HmHzjDg7HdBs+dpnFXQTcHmB8H
 AHer8mYUVQmjOXuYaw7DcadgQ45gMSlDBI0Kok+JV2ytygPuGec5H2DrO5tMVHRnERAd
 ylKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033674; x=1746638474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o5379wxRTyHBU1utcJv0I1mi8og4i4yWwZvyD3OfOa0=;
 b=BbSiRX+C2EeFoxVjy85EFZ4cgEIf6t4XaxHEmt/x/J3GEmIFXmynVosaA6B+J+Pz6p
 JEuxSTf53y8AnwSeNGIFFnAHchyKxMg1rTV1L3SrYaje2auNZlbw6nGGk9SR7cW0H94X
 2W+TcthXRtqyOtQ4I+DEMy6asoo4YHV6MkkQcMgyKCMrJTMcgwMvwv6m184RWrsTphk5
 E9XmORpQh0u3YWje1dGGfFNre4pKyfSsMYqMYKsf75l4Ja3+2yEzEzOrRGBf0w2vX2N2
 +KPPoeDHrrukemjWk6sSNealOzpSGAlfET/I2OkcSBdXhkhW+zIuJiNV7f/cHIjIHUU2
 Z2aw==
X-Gm-Message-State: AOJu0YyS9qBui+jpsQdpCcRk0Zv40TeHuaA1RfYmph3LCGcAvTn1uSf1
 ODXK5DBJLl4haBB5U9O+FxZSr6EZHSUXvLMKeYSjHWZkm3Y0jkAg4JL27oazf3/49j2UmzQ0y1u
 J
X-Gm-Gg: ASbGncssl/m6Qlqrk6bYtE377zE5sgSo+8pH2NKcu3jdVp6rYSCcCvO5zycpUR4/ulv
 sGlnrA3jh4L/KhBTUHSgpMh7E8tV0NLOVitCmTObJ6hK0gv2zUBNJVjv4VhL5GCA0Rk7pHKRXWt
 Kz0V5R86M8f4f/vr0FoNWk6rnI1L8CYI+ZrDgZA07Y3SD+JL15dgpFqeYNynYzViX1e4R19umBy
 WdFsVQQaNBSywOeD9GASGlxrJlvroP6dCAi78MkfLACqba2gMoq9/1J/DRyOHZYoD1or/A8PJ4g
 LMWAr7pnd+spwR6RLIdswY/xjzAjQnG/1HkNDo6AdrhzN/7PeT+tQLkdv5+DSRBk+zWYRHrFjhi
 Ropy9Sxg=
X-Google-Smtp-Source: AGHT+IFwrRwqIa1N0h8IupEw/T/ViNB6u+CiQDJ1OWsRuy9d2bxuQFEmHexkjJbHiOtA9fSrjqbiFg==
X-Received: by 2002:a05:6a20:2d1f:b0:1f5:535c:82d6 with SMTP id
 adf61e73a8af0-20a899fc28bmr6522230637.35.1746033674386; 
 Wed, 30 Apr 2025 10:21:14 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039922e9csm1981507b3a.69.2025.04.30.10.21.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:21:13 -0700 (PDT)
Message-ID: <32047eb9-7a65-48e9-bce0-0886f07b5be6@linaro.org>
Date: Wed, 30 Apr 2025 10:21:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/arm: Move aarch64 CPU property code to
 TYPE_ARM_CPU
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/29/25 06:21, Peter Maydell wrote:
> The only thing we have left in the TYPE_AARCH64_CPU class that makes
> it different to TYPE_ARM_CPU is that we register the handling of the
> "aarch64" property there.
> 
> Move the handling of this property to the base class, where we make
> it a property of the object rather than of the class, and add it
> to the CPU if it has the ARM_FEATURE_AARCH64 property present at
> init.  This is in line with how we handle other Arm CPU properties,
> and should not change which CPUs it's visible for.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.c   | 36 ++++++++++++++++++++++++++++++++++++
>   target/arm/cpu64.c | 33 ---------------------------------
>   2 files changed, 36 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

