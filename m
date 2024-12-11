Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A567E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPIn-00065h-6e; Wed, 11 Dec 2024 11:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPId-00060w-VH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:10:58 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPIa-00062E-PQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:10:54 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e396c98af22so5480463276.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933452; x=1734538252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ri/rJcY2OsF3Um/lTb90olwlZF8mOOn/4u8PAnArNJo=;
 b=f2KBmxvFNHhzf1/QPew8l3Hw9nWrbIL+3iJoHNapKgAkg1QLrluluFDN0mfpoE9WLt
 bhDV//cHRpHhbQqGUtiYfgTB70hV+q8x3VHjKEBoq8Otfq7sOShyPnh4qfqLXB4dykxF
 k+ksTC4EycNTqBmhVcW5IGf/DbOo8ld2xWq0H2VMZFvmHm2uAsqkj3DPAFO33VThDNd+
 dHCrkgdRnBxcoS6tpneTtdCRG+qIN29N6uBmV8Jv6pfvCfMXD33HJdVZ3u6iHD7+3mYa
 uc9ntlMcrHaJjbq3Jdi5E4CflffosyRh6Zdn3cZbR3goDJ1LtLfiTqsD0VFJS0+JLyjv
 NgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933452; x=1734538252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ri/rJcY2OsF3Um/lTb90olwlZF8mOOn/4u8PAnArNJo=;
 b=kHz+/IGlyZeBJnrYBjpU68KL09zALZ0iGlHPq90Pxs0Wi4sn24Ra305gH90NFXwvk2
 EVbeJ9v947R3wg0SrMe/2MKTVdjqkf3Xx+XCrAHZGpd2JItSCpQAwAJURcwD3jRr+IPC
 mE8+MS+voX0JPf91Suh8wUhbnSGyFw2WQyOzNKSxtw0duoirOJKd/lKskHHcahcPU2rV
 pbEIUmtV7LvqotV8qhRyec6aDDAwKrh0ZGRvV7xhW6dCRPD7m8TNkX6ua6LVMkNzqzxF
 wZ2nJ7zQpR6951ftPLQa/G9TdWCuBKz5sojQSRj8k1LSnbtmxNRPX2Od1+qmaDP/WJk8
 iQwA==
X-Gm-Message-State: AOJu0YxfwDOjjXsazf+FcpDcYYnBRdE+szE97Qm7Xw07FR6RB0FVN8Ha
 NsZAMs2kr/KbTZLoiHPfu6UfQHGo0GM1qpSVQ0GYjjowjbp3IhMIG9zZhqHs8AqeRW0LaYhDjuf
 jE9j7HliMPY/pIPggD39jDRb3onxb5u93WxhQlQ==
X-Gm-Gg: ASbGncuEqusNHbtwoJ8r5Tsu+ZQqlxR83Xj5GlQPrl6p8rsIIjc0C7JQEQ45qX96qiM
 d7nHI9ldS+wWHTYSXoyGX3CeVV00wvUZjjg6Q
X-Google-Smtp-Source: AGHT+IHtspY+hLHo5Yt5oKYPtfb2YISwicz4ZF4c/vjIiE0x04GseQ3+/Pmf6OUso2DlDy0lGT4dCG8xoq9vOLBgIcE=
X-Received: by 2002:a05:6902:20c2:b0:e38:87bf:8e65 with SMTP id
 3f1490d57ef6-e3c8e221f33mr3782069276.0.1733933451704; Wed, 11 Dec 2024
 08:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-69-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-69-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:10:40 +0000
Message-ID: <CAFEAcA9ZvNbFXoYA8nqX2Pd-BxePaF6zxFL2z=4f=w4APsMiXQ@mail.gmail.com>
Subject: Re: [PATCH v2 68/69] target/arm: Convert URECPE and URSQRTE to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Tue, 10 Dec 2024 at 16:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_2misc_reciprocal as these were the last
> insns decoded by that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

