Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C11CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApyE-0003BR-Un; Fri, 02 May 2025 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApxQ-0002Vi-Gc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:57:39 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApxO-0001fy-U3
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:57:36 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7082ce1e47cso15932297b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746190654; x=1746795454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jud06qPeZcXPv8io0aY7bnQqJL5aqwCl4h6qzivT1eI=;
 b=sIrFB2enseezVLl67482fV8PQl7ulmrsdrw9V6Usr9vbyU6AlbbpotpY6g6O4bjhRh
 1FmcX4jeXZxO+E7psybyITT2rwCLgJAg7CJeEhR9uOXioVj5cuEufG4meCzHBQn1t4G7
 WJoP03jYz5TrEm86d7f+f1W243gDXAA/OqoNgKhG3KaSL5hDkTw8vypqSDztIK61Gc8f
 cMXNcHaOM8yDl1ht8jBpxBEwHNb4LLkEN3VOQ/yYSZg0/Q4JH03gTXenUy2suwfStvUt
 BeOdhrlptmpSJ2AI8Ztk69I5kp2cVFJd4iSWj/0t+8zdA6RYRFKufBDi2B9O9q2lwfSi
 WeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746190654; x=1746795454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jud06qPeZcXPv8io0aY7bnQqJL5aqwCl4h6qzivT1eI=;
 b=HtXvEheggx5q406pTKymVGTcqwt41yQeqmeBTOvnI512eB10wIHD87qone+puFn0yd
 Js35lhQtaYTTFcEp9cjeCTw+Tr/Ka3EZ/uCbn23b0eACMC2JxB+3PoNKblytOUGCiK+X
 JeJATHN9oOyOLrUzBim6+FvRE7tddRbg7yYOC2MNMCPtRcUxrthXqr8OxWzDAegmDWff
 sC0s5ed8suDLsAvIamqL6M9i0Pwa9Y3jNPWmj7b5MJvPAPUrYp3ahPaCpJcBqpclw/wd
 T5Bnr9pjiUxKqcmT6h074AWmeszHlw9Wk4y6Npcu9Gw9tu/Xwc8Bv+oCcn+z25deuqJL
 fMjw==
X-Gm-Message-State: AOJu0Yy47Rd4QSEr4nLjpSGLoBe8knUx1sJ5Fz6CKq53rAs14+eoyTci
 OGdDKRU+dPbY2xuii9GX3YQarYxs6UdiIvEFZsSBv8vxYRRrMwpPBzJDA3VhvhvIcftXbWbI19m
 GLkjSvlY79C9RV4efWQLhjZZLDSJniqVFPC4IGisgXH1YnRhq
X-Gm-Gg: ASbGncvKlb6aAFA0lgQdfqN4dYo8oBuOdTBMN2alXSdE529X0KqRfZMPvx0IlH1rBYM
 oXKidrVrabYLaERqot2nqLp6+NIGf7Ol/ICR4USEDBHt5LRYsTMS7kT0T5LemHM27KayA8FGPrO
 X2P5Yg/N7XPa/+T/p1hHgmx3c=
X-Google-Smtp-Source: AGHT+IEjiZB1hP2tot5WRx2UlA0+yO8gjQ7B7AsWoNQEnG95xEB8S6YEc3bj2neD9N5X2xMqHuMjNfhpGrTZqk88qrg=
X-Received: by 2002:a05:690c:4a0d:b0:6fd:6589:7957 with SMTP id
 00721157ae682-708cee17dccmr42816337b3.32.1746190653780; Fri, 02 May 2025
 05:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135229.28143-1-mads@ynddal.dk>
In-Reply-To: <20250402135229.28143-1-mads@ynddal.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 13:57:22 +0100
X-Gm-Features: ATxdqUGAf83SQnlNk5H7J17wVTf0-VJZICRohSKvi1cqEXkGHa5YU8P_IJwHp-Y
Message-ID: <CAFEAcA-v11LC=uVXcQuZR07QanDPPZ4zJ6egCk2Y463-2aDk7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix GDB support for macOS hvf
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <m.ynddal@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 2 Apr 2025 at 14:52, Mads Ynddal <mads@ynddal.dk> wrote:
>
> From: Mads Ynddal <m.ynddal@samsung.com>
>
> In (recent versions of?) macOS, calls to hv_vcpu_set_sys_reg were failing if
> they were issued outside of the specific thread that owns the vCPU.
>
> This caused a crash when attaching a debugger through the GDB stub.
>
> This GDB stub has worked before, so it is unclear if Apple changed the
> behavior of the function in a release of macOS.



Applied to target-arm.next, thanks.

-- PMM

