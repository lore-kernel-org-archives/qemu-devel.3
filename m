Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D07C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgA0-0000jy-49; Fri, 21 Jun 2024 11:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKg9z-0000jM-D6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:26:43 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKg9x-00018Y-Kk
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:26:43 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so2502572a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718983600; x=1719588400; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yvEkVzNY7yrQw/krJMG+Ot2KTDEEfd7QbNcyjwOCtmM=;
 b=jQSIxFEnvASFX+thgr3Yl0OU+uFmGcsDbPwW5g3pSAhIBrVOkPhQzW6TAqd2ndInem
 9neL+pLBprJlmBfrOP/VpflTRxZCBX88gNpfYVEPKiWy3/U9EV7uR8q22wypcc4OUo4b
 NUll9qgGZ1ARUh5dieaRbojRGCp2iJ96RRsoyr6Svn7nUDXjijjRde+BWLbSu+vp2hby
 jVJJXK7slXZOg3KO0ebO9nsYyKUCfaPa19146owkk/CkQI0HkSqJbSWxEBRiz7CnI46W
 PhSngxvLtuw7ruWLTlC7iIEI+v0viiXyE+aVpTsnRwWiBs4ddSikL6UH1ObQh01oVwqb
 uYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983600; x=1719588400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yvEkVzNY7yrQw/krJMG+Ot2KTDEEfd7QbNcyjwOCtmM=;
 b=mk+2cMNyeWNTMW7y6xkv0c+kXm4fAWWIyoGUpr0+qNoFW/6GKy5qtmyJkZ8OEYWBFK
 ZTzENuzYofoqggvLyxwJ6UId2ktmfqk1VMwyB6EIvgw5890lhVB/ZmQZ6TEF2ivfqPTM
 OvflOmCHEPoamSXWwrlRhUTa5efNUM95Iaw40oE1Cwv3k7P+VSOq/9zMbiDLLK1i8VNh
 59Aymu9Y4X9eTIWXcb5NBklbj27WJahmXzNdoU9W/HIuzVssoDD6o5YA1/6GpoLv3E+D
 Pr5rLVZZD9ojcE76OilYzQ4jaXSRaMtQcUhc5kEtR82FUdSanpi1JFxQ/gWOqGl9g2wo
 vmtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCZaCxbuod9YuT1nt/oAA7QxU70slqmyYO/Y9vZuBeIhUfl07zQEavlovGWcrNRUJiZA+cs4EAUjW5gVv8ioHBygUnE3E=
X-Gm-Message-State: AOJu0YwZfsGr0YUx2zCFYprFKHaXYsFH6lQ6IfMz0PQMcgPL2E/k0k+X
 1f2mal0VFXLr5cqh4t07azsvc8zVxNG4THwPTORNMn/OgAA/YKgh4HYriJm1rJyGbkiiBg5NTEG
 kJhkybcN2eNBpGx16poIO+IzMaYixkVpoChB3yQ==
X-Google-Smtp-Source: AGHT+IGETigKID4f4FdwBMwC4/+TEJPfB1PBVjA5xXO5t2CZWgX2gd/V1wsQ4jcPBn2HzR++7+qLAKJXCggNPKJqF20=
X-Received: by 2002:a05:6402:1208:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-57d07ed3adcmr5398641a12.26.1718983599869; Fri, 21 Jun 2024
 08:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240607103825.1295328-1-xiongyining1480@phytium.com.cn>
 <20240607103825.1295328-2-xiongyining1480@phytium.com.cn>
In-Reply-To: <20240607103825.1295328-2-xiongyining1480@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 16:26:29 +0100
Message-ID: <CAFEAcA8cUZV8PviBY_wf5Hko74t=cDvgW=as6e-++aVy4kSquQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Xiong Yining <xiongyining1480@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, rad@semihalf.com, 
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 7 Jun 2024 at 11:38, Xiong Yining
<xiongyining1480@phytium.com.cn> wrote:
>
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
> this topology can be passed to the firmware through /cpus/topology
> Device Tree.
>
> Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
> tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Applied to target-arm.next, thanks.

PS: for next time, you don't need a cover letter for a single patch,
only for multi-patch series.

-- PMM

