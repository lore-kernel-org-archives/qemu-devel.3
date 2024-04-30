Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7E7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1omK-0006lf-KF; Tue, 30 Apr 2024 10:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1omD-0006kF-R3
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:48:13 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1omC-0004pK-EH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:48:13 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso7410496a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488491; x=1715093291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zslvtlR4SmnG5iJpymh5rbyidbaYiK8CTF1oZEqGzGU=;
 b=Pc0prIRO97cwE/E3JkPpqqZrvn6QkwNJZ4gq8PLCW2I2DM1GPVHg8TINONfjYugDlB
 RrP2cDKZblHtVc04HMukfAVB19migm8OiGXgbcvGR3noYvms8xNxSEa03+eyI1uu5GGx
 2M4imBk2zBpMq9Avnp/8+kssA+pzrzMwh2bbKRgRafkNQd9HRNUhkMfP+Gvfo2bpsW12
 Yl09ktGF6KQFkCSEgV9kEf7XoeCStfxqg3Abhw7L0rpDljS7Yt1MIBsBTsHLn10JAlUK
 zoFNINI5YBM1k0YXMEmK2JB7CBM+Vwp9z549vfApTdvMpWs80svNHoqszye1Plfi/kQA
 CVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488491; x=1715093291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zslvtlR4SmnG5iJpymh5rbyidbaYiK8CTF1oZEqGzGU=;
 b=cubMpTZHhJGHcLIpAb4afj4nMr3xHGIbVhxcaqxKdhtAmGBAYxQj/+I9Gz+BsjVbEQ
 fCeYhDR0Gt+DDoVghedFwr5tGoATdiPj3ztKCdPc1g2Ucbk3k/CvCTmysaaiW0oZSmez
 e0jvTJyNXYW3VK+Ee+b718hzafo+0nLFK9oEmBehsFVGZJVzAOILbQvSqENR54mUD08+
 T+cJJNvV7eQ/ipVF9B1M9xA+Zv3fOIOvp5ukfhjQMW0kbsVHKqgLrwRTNKX5wBzFko+/
 UEHWbos3nMCzhoqXFk8YFOxVXbSeR65CqE5DJB18MiSi/aslF3FJsCvRpDFE9T50jKTm
 C1Ew==
X-Gm-Message-State: AOJu0Yz2lhZFAZNhbsLqzhf11awNhj9yHjJy7Ap4DIEufCBPmNxysDGh
 u5hBPiP6n0WaYV/8USwaE4LnLvZWlhUxOxfkLipqQ8I4MfcTY+dSEmlu+7siy0aYUxIVEQrK/jl
 p3Sgiwvg2/6BtpEnoOtep2je25TTLu5B9D+ANZYHYhQhXR4ih
X-Google-Smtp-Source: AGHT+IFJEPe89t7nbL9vEowcD6G6yNI34fQllVt2+C/5xe6VXQ2czW/FfH5BpoweavqqjwC3N2eGjgZzPsqK2uZE6xA=
X-Received: by 2002:a50:9313:0:b0:572:a723:f1f4 with SMTP id
 m19-20020a509313000000b00572a723f1f4mr38264eda.3.1714488490789; Tue, 30 Apr
 2024 07:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240422125813.1403-1-philmd@linaro.org>
In-Reply-To: <20240422125813.1403-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 15:47:59 +0100
Message-ID: <CAFEAcA-AiyEgpeBqAH4L+qZTHPn9T6EOV3N9sNZB9dn2RvzGXA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm7xx: Store derivative OTP fuse key in little
 endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>, 
 Havard Skinnemoen <hskinnemoen@google.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, 
 qemu-stable@nongnu.org, Avi Fishman <Avi.Fishman@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 22 Apr 2024 at 13:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Use little endian for derivative OTP fuse key.
>
> Cc: qemu-stable@nongnu.org
> Fixes: c752bb079b ("hw/nvram: NPCM7xx OTP device model")
> Suggested-by: Avi Fishman <Avi.Fishman@nuvoton.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

