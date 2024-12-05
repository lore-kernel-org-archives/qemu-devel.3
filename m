Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E4AE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIiv-0006Fg-KO; Thu, 05 Dec 2024 15:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIiq-0006EO-9e
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:45:17 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIio-0007Bi-Tn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:45:16 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf80972dso1641487a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733431509; x=1734036309; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/4yk3j8jjYLcO9HU+90ftFIG4v23nGSfNItPEFTNr0=;
 b=xtociYvpcniR/220i5Dx+IBJWfJLWeH5itjsiVZtdP5TnxaxJX8UGGq6uIdwJ6lPjL
 iI2xETxhkErnc95zfjwr+U4vr+snKMdTH9r4MLf1iQfNQZYze1Ctwx8uiy63UjXnpERA
 3jLOck22TbPjjUHjVyY5WX1cBqTTHzKlHB9mcteqUDx8zGl9dZNANMWXUF3UQolYhK8J
 /oZIk3Kt95MW2kAk2nF1wmHEekEuoOPiFbwvANTqXdJFIZxpITHPJoxK5M17ogNynG3E
 5AvVmlnG7MDw2xnh/PFlW0n3qI6CGycDonOE+dN20scuBGkJxvkxRzBXDl2eLJnE4mdT
 iVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733431509; x=1734036309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/4yk3j8jjYLcO9HU+90ftFIG4v23nGSfNItPEFTNr0=;
 b=alaGy2Iy3ehRb/zeJfaRMgZQWpSZigtSIkK7ex4KffL/fnmCWZjEMEL8IoWhDl0I+A
 udt/Q6c5N/TyzCf8ERu7D+wEsr/Az7uTpFPvuCEkljqUfetAB6vQa71HXh2jibgPdtq5
 7xq8LctKEf+9RRia1J51rEY3sXGBcZYtqFCScKAnaAtgXstknrs7AC14wJ7b1UEDUPf+
 VwWAs/rhVUppAXvXo3l7YhqKmkHaYaGOFMGG5f2q0xBjIc3rLQBZlbwWmObDgfWZbV5X
 KCrn64qVCFhpum8/MJA9bmA2KbXV1LmGVxOm6nkdbCP591zRh/2nqsh3DiPhsp1f+hWE
 LLvA==
X-Gm-Message-State: AOJu0YzolfDZwsBeWpOMBmlNWvzYFlJRUS8/ubaCS1SlLPQ/n+mfqi8Z
 WS1+TjfWXHZJBR/B4/fYqtU/40Lqz8pJYRKmuaRypib9777on5wJltdb/qTgdQzmjbNgoxpl5sW
 I5iYSETJC1bCgfr1p9XlN8wbTDOUhhO44ulAijA==
X-Gm-Gg: ASbGncuvm1F65R4EBjBcRuiN7gQgzIOip73NxT1GjaiHNZD98s9qqZL7M8d7cd2nS0D
 qg3GTJXC1yp9GvHqyrYhBwF4LTIDmQiN3
X-Google-Smtp-Source: AGHT+IEVLQKvm5cROokgMzM1hBtY/jotJQl3lERSZ9REdTYLb+4h0XUzGRpRezwtgML9RqfX/Kd/jbcw0H9P42kxHKM=
X-Received: by 2002:a05:6402:1913:b0:5d1:1064:326a with SMTP id
 4fb4d7f45d1cf-5d3be69a19amr1041560a12.15.1733431509183; Thu, 05 Dec 2024
 12:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-25-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 20:44:57 +0000
Message-ID: <CAFEAcA8vrTL6EwQud75H+ZKYN-TE8txyj-8vmeApsB56y6vboQ@mail.gmail.com>
Subject: Re: [PATCH 24/67] target/arm: Pass fpstatus to vfp_sqrt*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sun, 1 Dec 2024 at 15:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pass fpstatus not env, like most other fp helpers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I have a patch pretty similar to this in my work-in-progress
FEAT_AFP series, because there I wanted it as part of splitting
env->vfp.fp_status into separate A32 and A64 fp_status fields...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

