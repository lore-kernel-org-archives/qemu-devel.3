Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAB8E93805
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 20:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC1aR-0007mP-Cg; Sun, 12 Apr 2026 16:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1aP-0007lw-D6
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:39:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1aN-0001xM-Tr
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:39:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso43706385e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776026354; x=1776631154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oA0DLeSnfQ1X+bYFCL2d+Pb52L0Uky4PduQpBdNLBkM=;
 b=qC25amMP4MMGf9zvwnEWHBXu54dPT5LnD0U+EP9v5HgJKocI4APdUB815ivq36y76P
 Pw9RNYoi1OKrCJzzP6FtPRoKIUj/n9L7vX1MgKJ629Xr2LMaDGziK7WTX+QOR+mySiyM
 vOgfH3FKTBsauLqS3sBCovkMCrNa4gZNFnDTrfX9OKP52LtD3E+/RsXPgu9dRzzTvm+A
 qenXXeQHO1XFObnfTRHKgw1ahxKJWQpDipime0VrddmPISaMI8yWM8cjhOIQge92R8Uj
 HcbCoan6yqz59DKQDM+ZjUcJ8LssoJ/rKg02KNC9/FSoRuPU900IY7qCaj0V9fgmeNo3
 2HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776026354; x=1776631154;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oA0DLeSnfQ1X+bYFCL2d+Pb52L0Uky4PduQpBdNLBkM=;
 b=cXju00XCnOnXgDZ3zlSPQ0z50cADBfwI44D2pBcPd0oJbRzUEtl3W3jTCMA8EvtKQU
 VcBGdvagaHpJNE5D36LriWRZuXRMXXiUdauRipOwq0rOw6Hh98WQi9aBG262iqxGmmX1
 GdktpGzweW7qQXYjCcJaUeMxsIdz2o8zn6LFxyGobDncll4hOlpA/5sPzWocrkYVSjLR
 o3sNV5s5EWDLcdDEVom37TQ2s5asYVuuHNCzaZvOequU/MPneJZhNLmp6soxcr84OWWP
 95ZX0Oif0qXcB6vxqHi5vuYXcaPB77ZSymBco5oOvZkgfAStO89MoZJWXojSVQak4Ql4
 vBLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR6wFErtc+q1hrDYN3yfmEb/D87JhIEXWdTMvYWM7hxhpbfG89SsQji2yUqnZIwx9QiII6mdcyo6n8@nongnu.org
X-Gm-Message-State: AOJu0YyEYWNDzyVpgSE/QLutMiUaorkFkv+1PNo8yOiiLUFlZerBor32
 8FbUg1OTHEb3/1JGS09XDd3EyTtk9wV2MCv3WyI8scSiHibQk0Fa8vnT4I+5LjDXqvejbn+DA15
 dv2k4nKc=
X-Gm-Gg: AeBDiesQqa/Thu8MR9agIJQO7kK/ygWsln0QsR8VlMzgOrCAaq6rpnhLrfbm+NnKXfs
 e7QluZsHVniYuOrzlEg/kGfkQ86ZEULUrHdFXesGyy0n7gjC6Y3eJmJWbcBvruPNRDxS7k1/Sb4
 bPLrGMr5fKXgSbqpUN0BZFRAJgsBHF5FkqCEDJkF1lgw7+7NDr3jDm0bPdc4+2AKzBMjj3D2hnH
 ceor5edBmYr9kMFaSD/tp6TOdqx3nbNiUMNs1rpedr1Jtd0CbGCWp+/XrveG9xcEXybKs58fPno
 w/2eGjjlW65BCfDa9UXs8bN23Y4zO2aGBsL9uvLeAml+Azo+Vv6yUhr9fguaAn6gd08pq5WOEgk
 dAY3R7xY4QQCCW2eninfNnlz0mLbaAVyzk1NiTu4YzYGs0xX94SnhecLx/5nDo/pMEhBLYc412r
 lu606VnO0Gn2+/rhCQTRq5GmulfOQs2h9xZTZVsS2xCTnTkjVXATLKtQ34r5VPgVn9hg==
X-Received: by 2002:a05:600c:34cc:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488d67d882cmr156080645e9.8.1776026353943; 
 Sun, 12 Apr 2026 13:39:13 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d592d606sm239789575e9.9.2026.04.12.13.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 13:39:13 -0700 (PDT)
Message-ID: <ed479279-fbf0-46af-96a9-93aec25c0ecf@linaro.org>
Date: Sun, 12 Apr 2026 22:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/13] hw/usb/trace-events: Print EHCI queue and
 transfer addresses as 64-bit
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260311072614.1095587-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/3/26 08:26, Jamin Lin wrote:
> Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
> use uint64_t for the address argument and print it with PRIx64. This
> ensures full 64-bit addresses are shown in trace output and improves
> debugging of queue heads and transfer descriptors.
> 
> This change only affects trace formatting and does not modify the EHCI
> data structure layout or behavior.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/trace-events | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

This patch should come before the previous one. Bonus if you convert
the legacy DPRINTF() calls.

