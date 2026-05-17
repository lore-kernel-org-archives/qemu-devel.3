Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13481CD4F4B
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdeu-0000Pz-LK; Sun, 17 May 2026 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOder-0000Pc-Rv
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:44:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdeq-0007I5-Ds
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:44:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so9414735e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779032639; x=1779637439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l2iLAEnVwoeW7gmrUNwYC1I2MayXAScXCB9geBA7QOQ=;
 b=cEnqVXBNvvWkDa64k4SdOr5jnjvddX8FdHfUrTuyM0QK4EqgWVSLgLRPtP4y0c2nm4
 +fXbfl3bLarbTmtRJXdYI/lh+AB8gcsyKdUw44BDzOCHmL1Kcv7dASfeaF+FQ8gvNIdK
 3vfxWq4bAERtcwemTbuZXdtP8gHLLn7mIPpgiCbYJcQ9aacgbEgvmaK6XmTU0PTvtgOr
 OCgToONfUf2pKNUdgOQxPHrxJA8GsPrhv8/xKQKP4vleBfeYR3xIpFzv7Klv+WAThuVb
 olrCl4IkrrJjuWsOTCC1rk88gLrjqdp9MjAYrZX0Jyt+gUsBwNXn8nk5ARoOkwgjBkiX
 nrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779032639; x=1779637439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2iLAEnVwoeW7gmrUNwYC1I2MayXAScXCB9geBA7QOQ=;
 b=jCNnZJOQTG/titHV94LTt2SxdBdfa4iMXz/ld59hxwv4BToPaWFYPyxEAN3ls2Go+b
 /VKRqjDKZgr8l6auhOFcft5QGJtGGDqrdeQ8QYHLUS375mQH5kLVmo8zFIeYbe7NjtnE
 9pt1jxdpFeTURTP4BQEzAo2OHYgI4Jh/zzCskHzHkXR4sGhrB39EcPxdWd0j3mfz6I6t
 mOHMnS9Gt3dMbaFOZk9KQ3lo+stKR+Dmpsg5rzoiNwuNz4N/tsK1hypuEvr5xFnpaW7H
 ffmDd990+GOLJnJAMh8rj5JBf8rWQl1/n5dBpHzt36lYQsNPtj7Ld9asVL5HJQhQUki8
 JQiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kbqan1jjf/T755XX1pYfx7AtdxKh/ruy5qhIryNIXDI/6UXjlZxiIxMQs6TY6RIkgKx5oGOnjykfz@nongnu.org
X-Gm-Message-State: AOJu0Yz0Xo9PoDgD+K8uAdOdwXD+VYxyTP2JUXY6CGZX9hTZ7sxdwXId
 nUabFpqwa1dhQ/rVPPUmMjXHEL29w28EMgmFbh6O5oXxoDH8eA5YiwScHa918QGScS8=
X-Gm-Gg: Acq92OFhcVdpGhtJfWnop36rBpVPNEib82iLC/OWPp8lr/4yAEIqT1/xpvXiS6z91fW
 9y6m+qi51P11BCk/wo5UU3CJ9YCT4eNB+7BLka3+EiNt1AIhbVlFObucJ8lJI7pVnK7Mzt0UtK0
 EkNqhGYrTxuBHCnpZ2wvHo5B6C+GqWQh0i+jJuMiBP0W6lijnr/MCefPUzEiUE52N+y/c2VlO9h
 MTBZgA3LQ4oPfmy3UxqrU6LqXkSfStEoeB18MsQr882BlrcYE78XO8ZWm6P9uRS+sBI80iLYgZg
 VEKAoBPOtbeuBekWTFnvSSIFK+zv3iSFgmYvYgHROFZ705yiyZ3XWGT5q2Iy13MU+QLrkHrWqqp
 ll1hLAtGg3f4dHKtG63lhZBe60MwbP3a90eWOCkW0YG3l1uSrv3dFjgFBqBSLRsW/QH8G2Iaas4
 vNEEBGNQCNuKnVmbwr9pF72jBIzLcBJbMFWJGXCRzVCF3VJCu00gEwpDL3LQTHb4NWZUTnf9bFI
 4eJ
X-Received: by 2002:a05:600c:3e11:b0:48f:e230:c3fb with SMTP id
 5b1f17b1804b1-48fe6626a8emr182216615e9.33.1779032638856; 
 Sun, 17 May 2026 08:43:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab882sm201134015e9.13.2026.05.17.08.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:43:58 -0700 (PDT)
Message-ID: <da0b056a-fbfa-4efc-a225-3e51c31154c0@linaro.org>
Date: Sun, 17 May 2026 17:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/27] target/riscv: Fix pmp.h/cpu.h circular inclusion
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-28-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515180437.23620-28-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 15/5/26 20:04, Anton Johansson wrote:
> pmp.h is only needed and included for system mode, however relevant
> macros (MAX_RISCV_PMPS, OLD_MAX_RISCV_PMPS, MIN_RISCV_PMP_GRANULARITY)
> are required unconditionally by cpu.c, and so are defined in cpu.h.
> pmp.h then defines pmp_table_t depending on these macros and so requires
> cpu.h, and cpu.h in turn uses pmp_table_t resulting in circular
> inclusion.
> 
> Move PMP macros to pmp.h and only exose PMP properties in system mode.

Typo "expose"

> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 4 ----
>   target/riscv/pmp.h | 4 +++-
>   target/riscv/cpu.c | 6 ++++++
>   3 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

