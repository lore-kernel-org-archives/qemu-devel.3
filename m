Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB57606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o8LdwDMu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdBf-0005YN-9G; Wed, 21 Oct 2026 16:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdBc-0005Xq-Hp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:45:24 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdBa-0006zd-Qc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:45:24 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3ab3dd9681fso11194661fa.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615521; cv=none;
 d=google.com; s=arc-20260327;
 b=JjmmF4XXZVlJrnHG4CHXAWJbPEXs6mHB0bMwHxuIosc/dTCsDSgox9Y+0xHM2nYpEe
 mIEYaObE6HPQw2GnMI3Yi+ngAxAtsuN7X28VZ9AgqOiOdNnpkRXxGRBzTQwGbkSvJPV5
 ZB5WkON1hLlNcuK+nmucDANZaP48HO/w4jRu6BTyWdQq00VIyGgs2SgdpdZsiTVITQVT
 kfbQp6umU8/X/9ve4aoCPJCsy2YN7GVn/N3e9/tZ/E3ZTEDry1EGO30MJZEMr5On0h3k
 QyAmBlFqRmXt4RhHYEyFQt+0PneETKzL4sdOS40jNzYZAZJ1pWvcuwrv1VuBMxge/u+M
 GuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 fh=fMfr6U9vqZWyCHK3rqr7ZLaoP9Sdvf4Q6WFrB1e877c=;
 b=BlVn0zhwNWzr+JGNNxNC1/hSLIIH+eNQox0On38gleLjcXZtPqDzM/8gNkF0UO7Cxr
 miyVQ2g4z7WwRiEsSorax7hsQ4sGEaJLXkSgqX/StjL9Wl3iqG5vRqKZfmKl+PoimRrI
 YLV9+psOvI/SogmcOgGoq20VydNdy34y8G1LNXSRaMlQxJojWUUvxWrTzCCGLuV4qvBQ
 vqyCfrjPiZQeRHw60UmFniM6+DAxTD9X8bl6Z1rCC0KfiQRlAXZEkIdekTVxr+aDhmgT
 AJhkNbC0bCKsDbEf665ny4c7U4Og/oGWG8A3igEELEDuRuZuiXaXP7+YfGnt9kfKsQsr
 gFMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615521; x=1793220321; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 b=o8LdwDMu+d91enTCi4dNiG1b7WsxbSb80VGUrCu32WngwdBhBXhHpHBPF7fuZ2PS5b
 YMSZJmpoZmqJDzfsp0FCvBF6zCmMz8hUgdYhEmcv8yI9wNchh200Bntop4rlCe7x8wO0
 wLv61q7A57pWPnqY4S34J4pVDWGz98P5M3I5D4/+AeGM+G4JwX8a7QtDLDjDAGHCla+r
 uTj6WWkIFWWZ7WJRsZn53TIi1UBQIqjNgISdtf6+PofCtQyMFc2cMC85NlFxoMFb+DM6
 FpJSgCKSaTlAwEFPAfmyicFrumaQxj8QGnfefwlyzs37BvfvPfYWNxyxgdOsiXr51KdG
 ruMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615521; x=1793220321;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 b=zcHLQBnnRmoft/dCQhLdAC1Q+dvBHB3M1fX6QGXelYtTrQABskcmOCE/ctbC8HjpmJ
 Epb3+7ckCZI3Gz+g/Oacx8AWhgtSs1ia2aW4kV7fwHX69aR+puTE8JCMHqwAGZol0uNx
 S9FSycLHgJk3ML1GCM3iYgJwUMxa2jN0Yx8PNRDc+/LyDqqqhJdROsrQQb/6RvVQqUhR
 sZPo5eCOXy5ch8QDW/7hWT+FTDAl8VqHJx2+iiYnc97FnTllONQ4207OX7vFmmmJYQnX
 SRdxUud6UHAd34DXJsmA5SU0NtCw1n9LDXYP8Lmd/lqfbm0XOldpyGmXsyJm9pZeti8H
 9bTQ==
X-Gm-Message-State: AFq9FYJo46aUZzlTqy51umwbBns9Fm8gb0FWjYLk7PRoD7cHdb4wISOD
 juYwIVLRC1S7/GJKV7BwsY9K8y49tdGWTQYSaoUUUbt5KoQtN2ByQ01dMnFavHYxNNQ1Zs/agM6
 gY92hzgTtj19TtPs064Lhi0SOz1g6adU=
X-Gm-Gg: AYBFou0ZsgbFq9ET9c4C+SpYYTrM8vsc5LPW07szJ0bCXEpafIuHflGwqr7/fj1Dka3
 bY49cehQZ1djPxg7ww5kAQf72i118/7ZbhPO3cy6Twdo71I48E/Wjt1tPXWhZ+JWmoAiKHcIlyP
 P7LD0wJmGfJGOV+Nk10lEdyj7PROKqzDcf0oqlTOzTA8CSlGfNoqSQavdI/BTpy8tADtDdP4GsC
 DyD54p7ku+8qQSvJbKeD1tyiQUo25+I4qhImXfVHehL3zqvqQ75v5uRZyETakh/7Fj5kexpbhy5
 OAOF1QApJM+mHSWPCwnnum5EnKzToqh54ZtmDbEJWIQZ+MSt/omQwfRWdYRvW0RucAMcLGv4gY6
 hbGlNCq1zxWY0mHR7yNRSfNLSSJb5Y3rbKQUEmjk5wTpsAjaboF82CnQ0A/Hs1zZf0fTyfyzJWt
 EBD73IrjFESb8Zb8bvglnJ+Ty6D97lGIe3e0nQK95TRzKReBgfOeYK
X-Received: by 2002:a2e:9fc2:0:b0:3ab:1d89:4981 with SMTP id
 38308e7fff4ca-3ac4420fd63mr9417711fa.22.1792615520921; Wed, 21 Oct 2026
 13:45:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-4-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-4-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:45:07 -0400
X-Gm-Features: AclHuK8rCsczxDf7sJWWWJveKQq4e35dw9vNxdxG1dt3AqboMERp5E106XrF--U
Message-ID: <CAEdQ38E=r_O=BQeF6A-T7fcPLPEePFXO2mEKSZkXgB6nmzfJFQ@mail.gmail.com>
Subject: Re: [PATCH v6 003/100] tcg: Annontate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

s/Annontate/Annotate/ in the subject.

