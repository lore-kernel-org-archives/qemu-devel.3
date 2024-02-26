Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717FFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redhr-00067v-Sz; Mon, 26 Feb 2024 11:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redhq-00067D-Dl
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:19:54 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redhp-0008PK-2K
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:19:54 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso3263836a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964390; x=1709569190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+tLwqQUXOygN0IToXUe0UPa5F59lxtKfsMeguCfpxiM=;
 b=KubF9kc71w45iEYQDoGbap9Kxzf7C//rMyoyl5Ak2Kv4QYYD6dDsDyUgRYvEq+S9Y8
 G44iFtZyzQOrka2+Inslxh9X31a0ba53JjLmYI7EWOFcKIDSxlFkS4IU2JGKXefjCBBL
 4FHx3HnoCNS/f1/kgerK5A+gz83m3Xn437VKP7b8nrMDgyveKp7jTp7Nyu/92BOm/V5L
 Yjt3A/ufsmB7DvUP1OK6eG8093jTFzckcP4fFlSeCYr0ZHMU3cpCTI6wzE2x2jMDJiTY
 Mo7V3SV+8dOXxWojL0rRd6EvfTygHuqv943lhcxc1PCO2ye4KuuhNX1hAGsZbq+MnNa9
 D52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964390; x=1709569190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tLwqQUXOygN0IToXUe0UPa5F59lxtKfsMeguCfpxiM=;
 b=e629l2nkA+XZu63kKXhf1VKrGvUIN3AwPP7OCZ2lQ9PGDUctm+gL84rsoTv6s1QtwX
 uOpVoajBlnpHPiOojjRxgMGWyk4MUR7Nat9T1vv98RVtaz5dZdc/d7YNlyeTq951e8mA
 f25n4JrMm3DS22AT7K09R8ozHapWhIWa5kD+PFIy4hS0xDW7G5ydTGrqQmCfPJManRh0
 uWd/U80yiZ6ZPKRZyQTeeGXgXTVIRnRu2V4lP64DHGH4QhjhvDCbjGQGqobOEVIIjteu
 gbGKSQteUD/78G73ugXemxS1lB6v4GLG7NvIA1xAhzR+PB8S+ucKC+J6KCY4HGnlZovl
 soVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdnBGnfUbGrTPSI+1WWiT5oSrTYHKw3GfqdZYNqHMoI6DrICkVCxskhnwX+yoYmxbMLmC9RoUN4or83X1NvOGqlEMGi3U=
X-Gm-Message-State: AOJu0YwtaJabNV/sDQ5kTuiPdwBr86jdqiMpq3neUrxd46nchDWEcbNs
 9++FRtcl4KUPHHJyRHkgolmbn/HmhKM3Lr8bdAppdzUwwH5/ga6VBavo1iJdSacqEWeFmCx465l
 vknSs+mgObcFLOkBQNvLEf4cThysGdfHOzra53Q==
X-Google-Smtp-Source: AGHT+IGPvaQLjEOuFn2z5SlKm9A+PgT/ZuOhVaMVJ5MozHISm38sWb/+pTRB1bRqGf54HWMrn6Cag3pio+Mcaa+GdRk=
X-Received: by 2002:a05:6402:643:b0:565:1780:9398 with SMTP id
 u3-20020a056402064300b0056517809398mr5102351edx.39.1708964390291; Mon, 26 Feb
 2024 08:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-19-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-19-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:19:39 +0000
Message-ID: <CAFEAcA_Wkzxx4swxK5aBBNdxfBAE3GtgoCPRMYvtTw5AN6oEMw@mail.gmail.com>
Subject: Re: [PATCH v6 18/41] Add clock_isp stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 26 Feb 2024 at 00:08, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 6 ++++++
>  include/hw/arm/bcm2838_peripherals.h | 1 +
>  2 files changed, 7 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

