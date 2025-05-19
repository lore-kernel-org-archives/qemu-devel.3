Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4074C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzTJ-000520-10; Mon, 19 May 2025 08:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzTC-00051g-K8
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:19:50 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzTA-00050Y-9L
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:19:50 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70cb334de0cso19681567b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747657185; x=1748261985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oD1mS5Y6oFm1l2EUt81Dv+GThRPSUvN8ZBuSowk8ntA=;
 b=d9fvhjqSSnKTdp1GZqEJGxFG1vmHCz2lhnKSgYtLGV3rBY9sfoOPcZ0BOsNycuorsw
 cqowwqhMHkcAy1WwMKfvzTiMLn4HiMuFmGplDvulPORUk8u+RhwYbIN6ftMf0SaXi4ms
 c+DEI8/3lS6c+XkNnb8gSoEuMxBGbOCkRg6gopHk933GsOnoMLnFJlE3Q7a/XY8qV92Q
 yei01C0X1G2L848Mss8ay4nzpYnxOZ/WrJZIOulNLnKVgYz4Zd+DvysG0459YQg1DdVV
 dULa1ANfAvoM8YfgNMy8sYh1NjjDkbsEDQQrVoq+Go7YUlC6w7ACElHTD7bte0BIlose
 CKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657185; x=1748261985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oD1mS5Y6oFm1l2EUt81Dv+GThRPSUvN8ZBuSowk8ntA=;
 b=RWqT7CHd09xMH7CHPHnkqSMJ6d0YlyItCoQIHuxUfdeCDP7ZOb/tShEhYxExP0Zom0
 af3k5EC0Zfb9z5lGbcPVTFXHCtWau9keLspwi1sA85ouM/soXWk6zZAQ/zrySfitdB7A
 fXcyWnbxhISo6z0sxfsoDjUt/MuexHmAfC01ZRkjZFZpm8T1vAFduNfET63eX14Zcdk1
 q1+HS0OGrLdg7WF9yajlp2mKgLmi6ZplnoS9eRlPUAUhsdb+hznxJ/nIVDNurI04sUvX
 DSERlE6RP1ZM5Rpox71/vu0LuYV8l4QeWu4KuNFRk1aeKD8tE8Sl3hLcrbKLIzzNzdvG
 D4lA==
X-Gm-Message-State: AOJu0YymSXhmW7U5hXLnctSoPDJKnVvxo8BgUZueeMFN7rmBBv3AkauA
 C1Rw7PbHAdgBXpkWaYAsj/x72LI7VExYIZPOzyvMbqS9YTgDlRpkcI0zMbD0FQitVnM0+kjYnPn
 q4qM1A51sbqHK/Lr9MDK/WSokKtMPwpltBqCQ3W7Y5nUP3GVCyYg4
X-Gm-Gg: ASbGncs904z5m9ScaqmJQ/nXlZaK7GqgC5Atu+LnGu/f9fF0sSjnzoN2GNSPjCpW2XP
 8H3Iwqe26IVBN/0bRQjGJiOMYnFsL//ofW2haEtNVlTFTHASj04/PmBi7aix56l2F2ZuHUSZ4PK
 uKA5MzGRrzSYciFzWWe/RcIwCmZ07LIiI94g==
X-Google-Smtp-Source: AGHT+IHVVkZ/bVvZu+tBITBzDuu1KzBNLozZHGBPwxu9XFpOOVkyx6R5/8vOOFrKCGFgW7000YPt8Dq28x+RWLcnRYo=
X-Received: by 2002:a05:690c:6f03:b0:70b:7931:f12f with SMTP id
 00721157ae682-70ca79cf6a8mr182016147b3.12.1747657185056; Mon, 19 May 2025
 05:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-6-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-6-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:19:33 +0100
X-Gm-Features: AX0GCFsf5PKo-yzD8OTSa2TwOUz1T3WJ29KgD1fFliSO__qay8b_uoVYxcHNe6Y
Message-ID: <CAFEAcA_JdMEPHYdXj+s0G5AOPH2CMgotFhZuowrLcFc-xsEL_g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] scripts/checkpatch: use new hook for file
 permissions check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 15 May 2025 at 14:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The file permissions check is the kind of check intended to be performed
> in the new start of file hook.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

