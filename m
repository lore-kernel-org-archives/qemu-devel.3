Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C40C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Xe-00022Z-VL; Mon, 03 Mar 2025 09:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6Xc-0001vu-3k
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:13:08 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6XZ-0006Od-U3
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:13:07 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e60b81c29c5so1899198276.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741011184; x=1741615984; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CQ5LNDtrTVZtscB38FVZhs83Lafd0D7KGFLr5lI3DEI=;
 b=rCwvgQRX2saM3bXHViW3S1FTJZhVxWUWrMuXnjkcZgC7kEoy9MigBs7UkffQ8rulIO
 VuIf4AdvsskEwAuD3xCYeI9tue2xUU1zAirXQocOmqzFVbh24V6ASJtnk0reg8Ga4arp
 Waw0Q/09yP11mItRMEPlgvmoQ5CB8Tr7hphrFK9S+cdneiYrGcBNxuyShkM4ZG+dR9Lc
 hU5fKq/XwBgcqGynxqHu+Eaa8G1xPaHfx3tlNHDmUMNlgINEQeQ6U+ZwICELOClXsisG
 rGSjoe4OwTUa0OXjfODPFLWH2kvum/lMDe2xtXZpho4yWluVRqPUp8KfcRFAhZMylUtf
 hG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011184; x=1741615984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQ5LNDtrTVZtscB38FVZhs83Lafd0D7KGFLr5lI3DEI=;
 b=YvmgosqOuTbKY7qpOPed110d3VEaBTE4rSRdgqGmdRGLtcLkl2Ye6EdUsh4djDScJQ
 2JT38thqIUZX3wTaTp/rxGwAxUKknInCCMm6b4lUNN41GML72CZZblMzx4Y3iULqqtBm
 DVMlhOCQ8kqp4BAdPfPWCrtfQuRJtDdRtMOH6iqK4W6GKaEeKrESJMziRep4JTQ354Ic
 8CnrHtJxicnqY1neCbcpquwoyw9cB/lCCsVFko043QemETdIxT1HZ7diyZc01GzcyCLJ
 XoOKhyECz8wcrQrrj7JQ7zBr4iamyzkX65MgTBcNahYPu5B1RzMM2nlHLI1PoFvtDwHA
 ctWw==
X-Gm-Message-State: AOJu0YxHNftOsT4CkPeJ6Jq4PoVQBracxZyOqwJCP0vHHRjOqeaI2Eqd
 S+bfDoXDiTDBQkrY0S6x4Y/2acu9p6w58iRICziPFyfY5PDW1UEaDZhJCE27rgDuxKJNmKfhOL9
 uCvYzqovh4bFMJgGZZtmBZs6L+MeUAtp+nUOyIQBxArKOVGFC
X-Gm-Gg: ASbGncuTkeNPG+LkND+6SOct4dF7/DjMGfNGqTOEs8jLAGJqQY6LFnn5jZSdAqCJZRD
 9kU6NVtHfuRYT8SSilt5MaYVF7c02GpKbFL5OoYlMssnq7sRREcSPyGvaVwNm/1i74Qs/omzI5N
 XNgRdC1lk+d50J+h+paTkEQWkVAP4=
X-Google-Smtp-Source: AGHT+IF7uGXVYNaC/CdTiF3T15tEeJI5qzs9HDEMWWTPtoHPD7QEPazpaveO30JQ/LvwArsFXvpoq19Wd8HK++Soj2w=
X-Received: by 2002:a05:690c:3505:b0:6fb:b38e:2076 with SMTP id
 00721157ae682-6fd395b5f8cmr261300127b3.11.1741011184434; Mon, 03 Mar 2025
 06:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20250226104833.1176253-1-thuth@redhat.com>
In-Reply-To: <20250226104833.1176253-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Mar 2025 14:12:52 +0000
X-Gm-Features: AQ5f1Jre2SoyWwFZ_Xe_pA30D8nA68q6UJ7ETPltEmbXGw5cATHZcXzBTdqG04Q
Message-ID: <CAFEAcA8A7FGPbw6sJF1qG1Hk3eWLtSLRY85gAWPJMqfjoq0J1g@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/test_arm_sx1: Check whether the serial
 console is working
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Wed, 26 Feb 2025 at 10:48, Thomas Huth <thuth@redhat.com> wrote:
>
> The kernel that is used in the sx1 test prints the usual Linux log
> onto the serial console, but this test currently ignores it. To
> make sure that the serial device is working properly, let's check
> for some strings in the output here.
>
> While we're at it, also add the test to the corresponding section
> in the MAINTAINERS file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Based-on: <20250221140640.786341-1-peter.maydell@linaro.org>

Applied to target-arm.next, thanks. (If you'd rather take
this via your own test tree let me know and I'll drop it
on my end.)

-- PMM

