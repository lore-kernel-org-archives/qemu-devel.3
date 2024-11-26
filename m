Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EE3D66B84
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 22:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG414-0007WH-FQ; Tue, 26 Nov 2024 17:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG412-0007Va-3i
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 17:26:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG410-0006aC-G1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 17:26:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so21577165e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 14:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732659996; x=1733264796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PkvNakJc5il9cPX0R+ULDIfQ6am+eYC2GOlwFrHDcXE=;
 b=tNCvOoxbCEW5Kwh7YsCI98gasYg0yiWFnO/+e0R+wwZM5SnFJ3W1IFwvyCkVn0PVOU
 EakJX1H/JSkeWePhIYJRrCZRVHESheBKBVhADcE12+DelvAqTggeuKNRpUJw5YIQCR33
 wUmWDRlLn1pzhyGuduygTbKYFSZ0Z/dSNDHsoUmTXthU44i1ER54pgoHPQZ31IOFLgBn
 j11Glnp75r9/bBAomNesaeX64rb2erVqWFJoPFFtFZaIzJ8g4uUlYbzg5tmA5mihBBhO
 YkoAMAbZWIisVgEb3eg4Mx6nl+2ND2O8RrVGxYavd5UEjOi5taPMAVHqX8i8os6V4izb
 8pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732659996; x=1733264796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PkvNakJc5il9cPX0R+ULDIfQ6am+eYC2GOlwFrHDcXE=;
 b=TICOE0QG1GEt8o7p78mWNzovGeNnQoi4ntdyZpc3M6zNk2H66HiPMnazEtdGlq4CcR
 oj7FwDvsN6hm42HqHGgFAMSLMeXw6NmFQnN8HdhK+DOSoVUlpVx1QfC2VHTu8aNRj6Yu
 2RpYyUWjR7S2WA/luZXOmgMoPMXL2Ttc7cYTiSC44Kk/gUIARv5vi/VsYGi9jgypDt1h
 F9MZ7JqL+FN/wOarknUZxbPj8TxtdSsVmHsgUaVTJ1te4u/fZi+RMZK1Pp+7gKrAAK+H
 ywn95SEnqNnK7ravvPxKHXSvgtrAiicsnd31Shng/JyWrapy2i9WDhdvJmgtVrJ9pN59
 B5Sw==
X-Gm-Message-State: AOJu0YzAMikGLgR8dLdpEuEyIruPn+f0rHzJY/akC4I6DQo66pS4YwvK
 58UKKfM+ERH83WoLTYVNlm9mMbDZsAYPgsRhE430L06KpLGemJ6VISdMrimSGSzc5MDPhlBRGBi
 F8YtB0ibejfPLOGDX2Y3SScIiK8h52NMCcx83cA==
X-Gm-Gg: ASbGnctOij559Hlm8D6/JcbLNoykQMbREAJ4nqCLmUIXTzxcOJ+dGLc69Ji6lrIxd43
 l+EZZMryeE1IC+gMkHWN/wj8/E2vdP6fV
X-Google-Smtp-Source: AGHT+IH/6FitMRGTlcM9n4mm3DRzCnlzqQSIBGWypk2xFU4UTKPyxf7RwZQKF9EUkIla/CCCku9iauwJdGb2R8Lsrn8=
X-Received: by 2002:a05:6000:402a:b0:385:bee7:5c63 with SMTP id
 ffacd0b85a97d-385c6eb916cmr414342f8f.14.1732659996265; Tue, 26 Nov 2024
 14:26:36 -0800 (PST)
MIME-Version: 1.0
References: <20241126171235.362916-1-npiggin@gmail.com>
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 22:26:25 +0000
Message-ID: <CAFEAcA8qVgctPozzYv=DU8kXcg722A5GwAts=ciXbxn=4nMbSQ@mail.gmail.com>
Subject: Re: [PULL 0/6] ppc-for-9.2-2 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

On Tue, 26 Nov 2024 at 17:13, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The following changes since commit ba54a7e6b86884e43bed2d2f5a79c719059652a8:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-26 14:06:40 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.2-2-20241127
>
> for you to fetch changes up to 0805136a44d39adc2467f23ac3c65e680e45d0a2:
>
>   hw/ppc/pegasos2: Fix IRQ routing from pci.0 (2024-11-27 02:49:36 +1000)
>
> ----------------------------------------------------------------
> * Assorted small ppc fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

PS: it's helpful if you can send pullreqs to arrive by lunchtime-ish
UK time on release-candidate day, given how long it takes to get
them through CI. Otherwise they're likely to miss getting tagged
before end of day my time.

-- PMM

