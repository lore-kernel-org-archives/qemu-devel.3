Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86755D591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5vL-0001cV-Cs; Mon, 18 Nov 2024 12:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD5vI-0001cN-Vj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:52:29 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD5vH-0006bh-Ai
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:52:28 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so203920066b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731952344; x=1732557144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FzB3uG2YzDJYNup3z5b1idalppx7G1F6If9BrKWJBWI=;
 b=n/AeZiBU65fFfIvzNvdKbhfvWPIw+rU6319HHSTGzU5UGDnYYO4eoLg80KEF2KS3ts
 ruodhKMnuhn1x5XnuXZdu/BTD9cGiSowXH+TUoXc2HbuHSB0azAB4ZqMx8o0WdWyrrYr
 M3p9NAtYT4ZyNa46epZdd+27In7vK5fhBjo1f03S5DZocjWo1LUCK6xiY1E+Gs2peXrk
 +t7n5mzlXumCDWonDzwxpEcBLiaZtFPbK0gpRFgTPe/yW4SMwFAdmVucJ115H+RDaDk/
 Rtm/M0xfQton2bY2xzZDvd2DnPAqx1iYoZvH9sTom44v/7hieONzYq0mEWmUJ/VVWMPT
 RtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731952344; x=1732557144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FzB3uG2YzDJYNup3z5b1idalppx7G1F6If9BrKWJBWI=;
 b=YzWTKF+EO2RdTf5sexixvglM6ptljOFp53vqfnXFo9HhMJ5WC7qfZi3t40S/JF0B8u
 YdPMG0TzfAbs8+jZ9bRN6Tbxb79BkeGEgRdTrjZeaLj7Bzr20XuCBTa4xwCJRCl3mpVm
 iy83bhTYJAUXwRYur+WRoHnO5DdXXCD4IBZGt/OfC7rBPTahknA6IU3WU/7JqgFGvMB2
 nfBpZI2fXoREG5+LQNwjKcTvrvwsMtlyS5T1rzl/svg7FFtvM5slzMBE3yftEOwLKNRb
 l/1+4Oa32KQs0p5SI3d4YgE+zqkNkfBalEGQ7jG9DReQWsZUp0LeQ9wKqINFTOkLKxI+
 12Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ju0lXwPUW1MoRqMBxod87SJqZpM9pEu+3NO8LHacgE73ZZPoexNhA92gjDg7cE6NULFilgkt7t3u@nongnu.org
X-Gm-Message-State: AOJu0Ywh441KSi85nLT+oSFYjCH+D969eekRhmCOWFt9idTfukJWxH6+
 D9bJcukt2uijcbRUgrta+VPiq38By2vxdCa87EvrxV+WIjwzI9CyZt3CiBYvVhVXs6fr8ze2d/R
 0XHeLLKlmAX4Kqv5d8HWI5VCVJzNjY/UcZ38pmEorHqB+GCc0
X-Google-Smtp-Source: AGHT+IEL6HjGI+DIjjIeSOtDFiQjqP0npUmgUhHtAW/bzK1gQC9i7ZDe7FDPOu0F4E+iYHfd/1+NAkarfGYHVqtTATk=
X-Received: by 2002:a05:6402:50cb:b0:5cf:c22f:524a with SMTP id
 4fb4d7f45d1cf-5cfc22f524fmr7684102a12.8.1731952344657; Mon, 18 Nov 2024
 09:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20241118152507.45046-1-paskripkin@gmail.com>
In-Reply-To: <20241118152507.45046-1-paskripkin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 17:52:13 +0000
Message-ID: <CAFEAcA_mEmC3M0VP=BGQ5sikroMA_8DXPwXz7QXwgyXQ5vkHYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm/ptw: fix missing sctlr.{u}wxn handling in
 get_phys_addr_v6
To: Pavel Skripkin <paskripkin@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Mon, 18 Nov 2024 at 15:25, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> We observed failing WXN tests in our OS which we tracked down to missing
> WXN handling in qemu.
>
> The problem was in that short descriptor format walker did not respect WXN
> bit. To fix it, make it possible to call get_S1prot() from
> get_phys_addr_v6().
>
> Tested localy that all permission-related tests in our OS passed on
> following platforms:
>
> - arm64-virt
> - arm-vexpress (v7)
> - arm-virt     (v7)
>
> Changes from v2:
>   - Fix naming
>   - Fix too early ap decoding in get_phys_addr_lpae
>   - Refactor a bit security-space related code in get_phys_addr_v6()
>
> Changes from v1:
>   - Fix style errors
>   - Add cover letter
>   - Use get_S1prot() instead of open-coded checks
>
> v2: https://lore.kernel.org/qemu-devel/20241117134931.37249-1-paskripkin@gmail.com/
> v1: https://lore.kernel.org/qemu-devel/20241114165900.6399-1-paskripkin@gmail.com/
>
> Pavel Skripkin (2):
>   arm/ptw: make get_S1prot accept decoded AP
>   arm/ptw: use get_S1prot in get_phys_addr_v6

Applied to target-arm.next, thanks.

-- PMM

