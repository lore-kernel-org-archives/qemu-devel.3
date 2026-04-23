Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF9EFDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1KT-0006w7-Dt; Thu, 23 Apr 2026 17:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1KO-0006uC-JR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:11:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1KH-0000p0-80
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:11:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so87685605e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776978667; x=1777583467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xf4e2tPMUiv5P95Z/xnw7mO0jVJQzPQ9bRvycsodzvo=;
 b=tU6uhbFURPYZtMbswAFxLnAI/k8LlLtvndDaryh+V5bQ2h3/X17+hkuVyOshclKm2O
 va8GyyYKjqZC6PkAG+YzdR/L0fgcVuV53vuXQEIVsvNgr9GNiwn5DpKQJB3b0oDmtEqz
 Z4ioCJ/8KPUYZr0j+xLSkUKS/Jj5Z46tIZ1ZrILUHO4/Bl18yRTnxh2fuB42joPN97N5
 7+/+TOKo5bTjq3JwzDfh2Ho4T3C8E5hBqD0dyFl4a23B+/rsusOUbRkTJyb0SqnPPLB/
 S901HB0efbgW5Nlr6Pah1SiBWp322ztvfMQd9xPQzllRYKe+vSzj776nkYAjJDN+hMJ5
 GHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776978667; x=1777583467;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xf4e2tPMUiv5P95Z/xnw7mO0jVJQzPQ9bRvycsodzvo=;
 b=El9a16RZVShKlRUchnoUEFKS4GbT/eF+QyQgZSoZNV2pwTuf7nY5vvTKn63T1uCetj
 +UVo7ulCK9vlxwqP/XilmQjMe4JUXrgO8lTrOjAe3uDjqAg+KISwFm4B1s4l4EkLvFYb
 kEHrzr3/D4i82/OnQlDVthmBIKgP7qQxehpTgmApYE5BdV3RmvHewJMMApXCaxOKWGFp
 0x16Fw1ecCw5Z+citlkNrytxkK6aFu7N8METJp81Jt4RwP5dZcwO5j4lnSylaAu0kXsm
 CtKACLuzCJKl+QMaHiNRAp7bpWwdZYcVYcTQV9HSt4Bk5Fn8cH1UBLJ+q5u/M2msiGUU
 rztw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+//+lkzSjIhJDE4nUPi7YXrc58OV7uTKSGWCQn7f6XQQgnpx3jR5mwiCRoeYjKENpyNUcFF8OubzIr@nongnu.org
X-Gm-Message-State: AOJu0Yx2KvW2gBdcJ8HIWw19Vk8bzZazc/rGvV0cxgaYRBSwXNuhSCDS
 Ll+bXVPwJc+feFzpxrqgwmrjvdBI+opBXMJo4HtsSK68wSAekbvFwMPlv3mxwmPlRaU=
X-Gm-Gg: AeBDiesS+e4iegPhBRVozqQPF3+aE3zwEcZDgiJEtx/dZuE0KHUNV3Xnvu2m6AY1oF4
 dI6H7eDHMddztBugWKVy/8TKzCXNP5mamnaT8dFqyo50RuWFr6TY47StrNDqnq/QdWMxPZWK4gV
 quvMy/KkVgzTyG/w/QPO3f3smDXZKQKLiqPoAP9ztHAfExKvgMZWe1YeqeR/TqpxQLLJHr726QY
 wJ+e6TEjlH8dXRPXqMjD9rX+PJnbuSklnlAQ5MWPAQ/J7T9lJeg8iJcBe20oOCGjweawibUTfv0
 Kr6H3FW5ZWrXsQVPIEd9wEwBB4fhMLW6J0Ilos2YFuAM8v9frFIb5exYpAVLINy20/OkViDXxkM
 6+O72cu8LARItbzbU/pkDK039a7b8Io8CDYJ0b7xi09O2SlJnBxtPdFCTY7omUyrWGRdeTItfZd
 yCD2gB2cqf2V4+9wenDzCCyu0rMKDQP5Mc9EJeY3Az8HmDt5Z0C0JV6JIvjGXoOp/P2OFXj/bq5
 mYq
X-Received: by 2002:a05:600c:4895:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-488ffad67f4mr209453995e9.19.1776978666796; 
 Thu, 23 Apr 2026 14:11:06 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb762f56sm170177185e9.15.2026.04.23.14.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 14:11:06 -0700 (PDT)
Message-ID: <ca138704-a6cc-49eb-be1a-5811784bb8f4@linaro.org>
Date: Thu, 23 Apr 2026 23:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm, hw/ppc: Remove unnecessary audio.h includes from
 board code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>
References: <20260417093805.1076954-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417093805.1076954-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/4/26 11:38, Peter Maydell wrote:
> Some boards (mostly arm, but also ppc/prep) include audio.h, but they
> don't need anything from it.  Drop the unnecessary include lines.
> 
> These seem to have been introduced with commits 2b16397264a8e,
> b8ab0303de, which added the machine-default audiodev handling, but as
> far as I can tell they were unecessary right from the start, as the
> machine_add_audiodev_property() function has always been in boards.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/integratorcp.c | 1 -
>   hw/arm/musicpal.c     | 1 -
>   hw/arm/realview.c     | 1 -
>   hw/arm/versatilepb.c  | 1 -
>   hw/arm/vexpress.c     | 1 -
>   hw/arm/xlnx-zcu102.c  | 1 -
>   hw/ppc/prep.c         | 1 -
>   7 files changed, 7 deletions(-)

Patch queued, thanks.

