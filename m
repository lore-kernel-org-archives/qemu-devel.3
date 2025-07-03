Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A629CC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXH8q-0002hf-9K; Thu, 03 Jul 2025 06:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH8o-0002hP-Dt
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:26:06 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH8l-0006IH-VJ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:26:05 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70e75f30452so59621837b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538362; x=1752143162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nr9MwXDaB1FFBDR9dbh+36PwM0OL03M49X5U6t/O3Ek=;
 b=rGem46PDFV3Wa8ZUUKCqQzUEOssHiOswj7trR7LizIWa3oXnwg6wc6g9KFdvzeMKtL
 nt2Yw1RF0APK0NVPBFvGWSB5xllYyiiYPzMmWdg7yjeGTjGb95wsY/y2NrG5q9i3uwsu
 NFZVihY3U1NhwEYcZW9OSgRQ5Z6khwObSYfuCdFaAaswER9F7HqhrA3eDoDOWuWan456
 ZF5BNPZUrSTxN0h+nuFKp9+Tz6hj/uAQXeZlTGJ6pnDZXAfSTq4ppH56OZUnH1NB1qM8
 eAOkl1RiXp3BBoofQ3yUcro/KTGodSgXx5a8yVhPCy2DBdBlFMyzfPB3vLdJ8kYxnWbQ
 IYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538362; x=1752143162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nr9MwXDaB1FFBDR9dbh+36PwM0OL03M49X5U6t/O3Ek=;
 b=RyAJ3FrL1jjbHkq2jcxD56hJY6dLoeinc79W0cFYRVQbaFiakupxy7uwLZYdPxMWf7
 /WYGkmLMNdP7w00DxFBtADFSaKo4KBPURfQX0mK1mNXE2zJuQSWAjQKcegeUCwFgtCxq
 Plml3TSNu0HFtR+UHOnwLznWw2uqxklb3Bg1lw8iw0mmvztYBBrgSfYlIHg1S01KoyVj
 GnpqKyYk6IF/LWAHU1JWR2wbblIrip2ZScgikfbmolF3cpEnvT2k2hnXbmwR+Brxq6AF
 pRuEosY90VsRdN+6glT3vRTmaAXpUug5HXGAKe9CNbKm/PdclR/lY0NEm76Bxp6spaE+
 VTgg==
X-Gm-Message-State: AOJu0YzeqT+kEFWYCz6cc5e8qpmc5qlTuPoxtoFBtuEloe+6Th5eH2yJ
 KgvqBvOs0pj+7wyF4fRR2uT1IyiGcZKsBJZ2HohBaLMbCb26hv3SsLmBPlWQAUVAOfoOcHYgtVG
 6cfBdJR6DFnJBL9DdF6Y7ECI7QVSPd0bfrnabyD0O1n4SKYxypYHl
X-Gm-Gg: ASbGnctuDO6RpHYcqApkS5sVAsrt4bTDOy/FVHCsEx3U65vPy2EfsOIFbMvEziOTrkY
 9OyoIWi7r5Mk1OmB4QgPlhJue2xhbWiS2PbYzsZmkKYhwh3FkgpMXY39IzKlhJxbX1tGoOAX8z+
 DCMbkT870E52gZ/x2MykS9N2CscsX+U6ArKc6VsOche2HZ
X-Google-Smtp-Source: AGHT+IGuUHpGds5DuJAuOxC6Edl8XA8kVjZmTg1O6Jk2rnSIm2d+W8/GHuT0zPaJHCYO9Hngcpy8B/2d9LfbP+pDVlE=
X-Received: by 2002:a05:690c:46c9:b0:70f:6ec6:62b3 with SMTP id
 00721157ae682-7164d52355emr86088067b3.26.1751538362460; Thu, 03 Jul 2025
 03:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-54-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:25:49 +0100
X-Gm-Features: Ac12FXyIezCZUJMjbQXPpcgHGBFoS2LmTzBzlvtq05eIk03ZZnevuc4FQ4xIrBE
Message-ID: <CAFEAcA9nJfiYGxDjuSBKAn2qmV_OiVyJn5NgnUFMGm1eXyJqFA@mail.gmail.com>
Subject: Re: [PATCH v3 53/97] target/arm: Move do_urshr,
 do_srshr to vec_internal.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Unify two copies of these inline functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

