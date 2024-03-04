Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A4CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9FZ-0006Li-5e; Mon, 04 Mar 2024 09:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9FX-0006LN-Ui
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:25:04 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9FW-00021C-4b
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:25:03 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so6786293a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 06:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709562300; x=1710167100; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SLFaLbJKTvZVrg6KNlFEGyOYAUZQ3f61dVszsVZcUjc=;
 b=TnGCxu3h9zy90w+KyfFmBlKsiJKRHSSW5tPUq/nDpKgdPpl9jP3JbPddNhDblaNmBB
 +bgzNqW0vnxVsu+FLq6Ec5l+UW+fpi2trxnVYcKH9Pf6/c5x+QmWFdbANRKudMLlaqVc
 1QHv8arqhjU7cHfzCMrpdRoxAGzMW0rvgcyCq91g/5S8VssAC0bH7oB+1YgP8gTKkGVe
 Hayysp00tSWd3AcFOoZXA4XOmz1+6DjjB5PIHYaGm4kZxvKin5dqFRt1LI0NIlVkx4D/
 dimISR7SuXz0Pa/rUfL1VnEJtYFHLKso9c58UtGwlB2jhZWEgW6DEBQZdmZ26mBomXMb
 Eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709562300; x=1710167100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SLFaLbJKTvZVrg6KNlFEGyOYAUZQ3f61dVszsVZcUjc=;
 b=HV4q6tQ2IR6HY3T1vHf+ZbAbOk2Uk4VsNSOruQ2f+HAmPTFLxecokzJyLLY37q1WFV
 MUbyajS0GPbdqHHnxh9iW8F0dZi0nrhgpP4GF+AOlccBqhCm1lFfynKZVe6+CMzxnT6w
 HaID1ZTZF36jO6EJrTuVWuQYUkChphLL/0MEIPu+oCDfUppwrz3H7Oiatsb4V1lmrRLD
 SCEt2x8vnJJv4AHgLiiBL2jAyn6fyiWWY8mVHt45+cXgeZg9ujji79QbwC1Pjtlq4zyl
 uA6OPtoqLuFdRWj/BpJ1ESU7el8PQPHYvFBNILlNZQkmnRQU5AzwyyKGSsWTYqHE/Gms
 slxA==
X-Gm-Message-State: AOJu0YzlBfghsQI2gaAata34o/hx9WjlD4LHFrEf7BPtqAajCQfDslZP
 /cpBRFm5kt0aRs7nrGfn2IpURvv5a1hriGGsLLPiEW+vT0npX7dCO+W5dy3Dx38ji6yFO5sraXy
 NQ+sKE3F3oaAgf1WnUAMUkKAFbbqcuvYVr9knSw==
X-Google-Smtp-Source: AGHT+IExDRkkpaxBi7kjtoZX5IfoUWs5UY3GUJY7p53C4PRS9JQoXkMZq9pmM2IotQIIfh7A1U9yBrIOVJbxMg+oSRE=
X-Received: by 2002:a05:6402:901:b0:565:9fa4:dd59 with SMTP id
 g1-20020a056402090100b005659fa4dd59mr6274481edz.5.1709562299796; Mon, 04 Mar
 2024 06:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20240224191038.2409945-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240224191038.2409945-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 14:24:48 +0000
Message-ID: <CAFEAcA9DUbXi8pectLuHx7c8v8jPbbJ=sqZ9yPYa7M-T7B-mbw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for I2C in BCM2835 boards
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, pbonzini@redhat.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 24 Feb 2024 at 20:31, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> This patch series implements support for the Broadcom Serial Controller used
> by BCM2835 based boards for I2C.
>
> [Changes in v5]
>
> - Improper whitespace again.
>
> [Changes in v4]
>
> - Added IRQ or-gate for common BSC IRQ.
> - Added valid sizes to MemoryRegionOps.
> - Use version tag instead of master
>
> [Changes in v3]
>
> - Add SPDX license identifiers.
> - Fix a few minor whitespace issues.
>
> [Changes in v2]
>
> - Fixed and simplified writing to status register
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/481
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
>
> Rayhan Faizel (3):
>   hw/i2c: Implement Broadcom Serial Controller (BSC)
>   hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
>   tests/qtest: Add testcase for BCM2835 BSC



Applied to target-arm.next, thanks.

-- PMM

