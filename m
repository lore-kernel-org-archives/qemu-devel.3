Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428F5CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkBJ-00071S-IH; Fri, 01 May 2026 05:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkBC-00070W-EI
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:29:07 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkB9-0000YA-AS
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:29:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso634552a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777627736; x=1778232536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=40uCTyk0IHuBsF2dS8Fpr+ixEzoBi+6r0ZJfWphqVMY=;
 b=nh6rXjXrkOSf3rYz/NCHhbuIpb6ExTf6tBnfzHx00CctfsUMwrYjn+PdOa5S8pMXVY
 qGQi2bXK0Bkl+Sv5UyZitXSl0EhuIqnCnHCYp57wN4EtgENq+TjKY54oAZGHTMfv7HcZ
 mvUxhzCWPhdGAobnhJYqJ3owlgdgMM6ejewW3pzirMgW7VJYwXfdq5aN8AYuzXPnsRch
 MbldMTJUu3Inuhf8HR9ZojvgW6ugDoIcKJFPzyeDYeF3uptwpi9Rmyr7h963oP29kCCg
 V4wJFeXcWCSlM0lz1Z6nfuCV7PO1cj8jiDd2B8SPmGJAA7PABREKGlJw4LJpPfSUCyD0
 kL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777627736; x=1778232536;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=40uCTyk0IHuBsF2dS8Fpr+ixEzoBi+6r0ZJfWphqVMY=;
 b=iSDMmEWbsXgxOd4oHemrvBfa8Ku3h4vBovazZT02QV1CDxdbtkiT8ggJ3VSh62O7Ft
 ULVnZhBx1VLCWd6c97jiIyCfKai7ACLmIE4x+DrXEnx0gQK0zY4RXPwQAi5o2z1VLtaW
 mQhFMmJSs2VSkybUsilj32V6dj3DO77c1gi/qmZfF+yI1amgxLbysZ2eImp+O5x4TJoq
 66bz/5+C4RY6T0aT9aNIy+22sIRsqqWP9iU4r9wNhGvTfCAaGb4r07Ov8JEwr82511on
 P6XctjedWIF+cB/FyatUGhH6NfnjuxK/EDr5gyHYJDGaDgTJ7b962juOgolLXPEif2qo
 9KrA==
X-Gm-Message-State: AOJu0YzAstRiTQDlUlCvXWIaMXHJyzEPEGHPM6eeFEpM1sWZbUaJjP+l
 ZBNnaISXkDuY/vpR7g3BHcvJxXpIsB62hg+dl0yJsm8QtK866GAzWWBR3SzDpFcnlhRYZldIh+j
 1tS+P/GM=
X-Gm-Gg: AeBDievKSrBIFRfa7zKfKE0VEo3NYbto+DuXFWSJdAyPP5pcgLApZW5X1H/np6euTi8
 1AXPh59yCVB28meqiJWN3q6vk8/55P95Un+6howvp1rp44xwgBiY3ISRm6CnileMdbBDPMU+gml
 xmI49W09Ok1Kgomn6gbwqCqLqGPmE2hlBJ9VujeIbke7/jsN7Jz8i9lQeWiT/Kmdsp4TCOG6DoA
 bzfceydTq+naAoTBRHrbVUhCPtgnB7CfM7OJFIewn8fEEaOa3/rg5sS6q5R8KxjgtY1eNSq9xNf
 SwHWL1AY/VQ21aYcSVEwN2elLJTltSU8Kuw0kT+t70vHhgx98Ig9rQzwUtUJcuMGKMhVgS8qNvD
 0eRbdOTIhHivkVxCrALs9DZOE1hEevI6pvUMXvtgSRYJx012JkApWoAJb5cX4vzmj93VFOkmEea
 aXrkK73qiEYXWJZwiZiUZNOivweVjthnefyrMpLdnFZ9JKVjLWet6i1vRTVWo1630=
X-Received: by 2002:a05:6a21:32a0:b0:3a2:dc51:44e with SMTP id
 adf61e73a8af0-3a45fa9676emr2903722637.22.1777627735644; 
 Fri, 01 May 2026 02:28:55 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b84aedsm1940776b3a.57.2026.05.01.02.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:28:55 -0700 (PDT)
Message-ID: <6baaef0f-c9cf-4a70-b64b-99c1574c1e48@linaro.org>
Date: Fri, 1 May 2026 19:28:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] target/arm: implements SEV/SEVL for all modes
To: qemu-devel@nongnu.org
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
 <20260430104434.1482407-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430104434.1482407-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/30/26 20:44, Alex Bennée wrote:
> Remove the restrictions that make this a M-profile only operation and
> enable the instructions for all Arm profiles.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - fix alignment in a32.decode
>    - set bool directly, defend with QEMU_BUILD_BUG_ON
>    - s/instructions/profiles/
>    - share get_event_reg between translate/translate-a64
> ---
>   target/arm/tcg/translate.h     | 18 ++++++++++++++++++
>   target/arm/tcg/a32.decode      |  5 ++---
>   target/arm/tcg/a64.decode      |  5 ++---
>   target/arm/tcg/t16.decode      |  4 +---
>   target/arm/tcg/t32.decode      |  4 +---
>   target/arm/tcg/op_helper.c     |  4 +---
>   target/arm/tcg/translate-a64.c | 17 +++++++++++++++++
>   target/arm/tcg/translate.c     | 13 ++++++++-----
>   8 files changed, 50 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

