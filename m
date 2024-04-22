Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDEBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryw2q-000430-CN; Mon, 22 Apr 2024 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryw2o-00042U-19
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:57:26 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryw2m-0000MK-8m
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:57:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso5721575a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713801442; x=1714406242; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBApjg9WR3qEgc5zMdctfxmtQQQ61WDmYwyqiPU9VyM=;
 b=EP0b1zLJ5Aakp4n03zwg+f64kmd8KrAIWGTYxy2gIhUHMDHh51whdjRKW1NIGUazw6
 /Lx7/pOIAMISv8jop6mmWb28DfeR18aj4OM7cOTI1xRpu/H1grTgshabhCGgIZrrwCqf
 5yFkruvH5zEf1buJBG0dfCFVIJBT7vTC5isrxH2YAqhlQHo/GAjlk5wv9qhMcHFkACT5
 VbQeGiCQt6dNbYpT2KoV+t7CyMDjgIEORP+1KHTbcX00pSFYKhysDMpctHvb8LTvN+L6
 8Fvj0I0SGmF3cPycSbRDXi7GsDz3ZWqDVvL6UU4DHhONohaK6cuckWe65MgPRjHeldyb
 eiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713801442; x=1714406242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBApjg9WR3qEgc5zMdctfxmtQQQ61WDmYwyqiPU9VyM=;
 b=kEATE07pEn/vlAbDlCwmHgkom0TysgpP1w4LCxFRT/p4L77uamfaLNz7K/ND5GwAlL
 +WN+u2UnVcCzifLZW5jUXvUXnPXO+Tia5+ZmNNuaa7qKhkbo9WtjLDEeYDwDvTwn0Tw4
 iHU9VKAew49oK7mePQbPNlc0NsZaTzvEhsbSvKYIOGwqGfG4hMckfk/k7DL5cVhRZcUl
 9RdO4tGGWAtURLeMIZ1zsOxkIPZwzolZynkj9VS9MhJELa+NQVY+EKbcFpJwhO5lPHGD
 Upe3LHrEy5tprfcHoAOJYTsmczDB2pJdrHr4aoE1N1gk5VxjaCarCi3wpUckF4IHjnkx
 wiAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfg8V9TWLDcH0eAUN2rBFwzBSNmKvSvV4W3mq+L4e0dFHyxLsx92WYCgH5Hw5+CAGobTFPI+71De3r3U9y2A88yZjXCII=
X-Gm-Message-State: AOJu0Yyex6cLc7mI5ONNjSjk3y/OUw0IGFFgA3r40hHtuuMmLc+i3VOj
 Qtsby3KAr1WVJLfEc0yRNk/wXJpSl/nG08CUylGgGokOmJfOOSixavodNoLY1T6nHJ38lk1K2xm
 GWwkKt1gvnuB7TBUdvq3XNiCTBU7K/EXBw1A5pg==
X-Google-Smtp-Source: AGHT+IGXkFgKkTdf7fX9D+nge8NSTa9fn/euU90nANC/KaYAVlzYtSxRJt4wCfdzW3UNbRvt793UEgspsAeHrtvYBVI=
X-Received: by 2002:a50:9b51:0:b0:56d:f54a:8765 with SMTP id
 a17-20020a509b51000000b0056df54a8765mr8320828edj.23.1713801441641; Mon, 22
 Apr 2024 08:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
 <c84bfac7-5fb5-4fca-90a3-93adb40bcf3c@linaro.org>
 <CAFEAcA_PWyu=ca-S=qwePDdGqjX95k3oQ+BJUZc541YEyV7i2w@mail.gmail.com>
In-Reply-To: <CAFEAcA_PWyu=ca-S=qwePDdGqjX95k3oQ+BJUZc541YEyV7i2w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 16:57:10 +0100
Message-ID: <CAFEAcA_-97Qi2yk6yx9KLB=pDV15KaF57gfvNJWq2EDzwFLx4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 22 Apr 2024 at 15:18, Peter Maydell <peter.maydell@linaro.org> wrote:
> I imagine that value gets written into CNTFRQ by TF-A somewhere
> along the line (and then read by EDK2 later), though I haven't
> quite found where. Plus I notice that the TF-A sbsa-watchdog-timer
> assumes that the generic-timer frequency and the watchdog
> timer frequency are the same, which is a bit dubious IMHO.

Checking the BSA spec, this is actually correct -- the system
watchdog is supposed to run at the generic counter frequency,
which will be the same as the one the CPU generic timers use.
So we need on the QEMU side to make the sbsa-watchdog device
be runtime configurable for frequency and arrange for it to
be set the same as the CPU.

(We could also arrange this by modelling the memory mapped
system counter properly; I have some slightly half-baked
patches to do that floating around somewhere. But I'm still
not quite sure it's worth the effort needed to try to get
them into a fully baked state :-))

thanks
-- PMM

