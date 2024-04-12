Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDF8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJXY-0007n7-Rg; Fri, 12 Apr 2024 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJXX-0007mV-3J
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:14:11 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJXJ-00062k-LE
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:14:10 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso1097048a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938436; x=1713543236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k+bQ4iKIkyDjUP8KtZJusSD+PohDP3Qwhz0TnpzrNv0=;
 b=CMX+uPoO9cKJuS5yNRX96R24cL+beJWvP+x9kBqVIq2eEtZk8CO/HMMJgkchad3S22
 NV5sCMNWsIE2UmULVEhx61SoxNY6voIE/iTRQvbjheUpl0Juyw+HN9jbaKjk36ycuzbT
 hY4YVymORLdBgCnMeIVdI43PiUlmGCaTHWZekW1a4xOdWKl1BDXIszqg0noiKlmzCyd/
 GRPc6QZcdtDzgsVdSUygZULA4xk/TePDJ4JYWmYhbR8gKXpKXg+n39ZXvAw02vFwjcie
 WBo0oBg1CHubC8HBUhrDhuLfF+Q8CprLr4EQsM36c+25hx/am8dHQt67ZwMrtNK1fxs2
 7WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938436; x=1713543236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k+bQ4iKIkyDjUP8KtZJusSD+PohDP3Qwhz0TnpzrNv0=;
 b=OqAUWoZYG2zzWHjmt2uCrzwkyC4mdgDb/sRFvitQ6RDSf469Od0Momaxs34j/YIq+k
 YvVSd0kSA0lYrkbh93ngtjFPkYgJJClR0VnwW6qcnYBapK4TBRqYheCLD+sj/GIz+5FV
 UoRS83GZgNmSpJEdvnFzXu/MwcYqOU97ILPVWRXJK8qUIA3cLGxzgjI7IzsCKiQQy00R
 JGgiIR04Gx5o/0TUDGBgQK+vOQ/+CoI5jNEJhidW0IR6rDrk5lETnJxwvc1bXhldRdBR
 oU494MRP6MzmXVsdORTW8PVq1gPYiS4KMP5g9hQhxx0Vf360tXWqXygOaLdWU8RWV/Dz
 xD8w==
X-Gm-Message-State: AOJu0YzVL5+uSDppZ3BDKudyqM4ATgeg4Za5x/CZagJo4XxsTVAKtmvh
 pbTPJJ4cCZIaM1kk/CuxC8FyUScJI9q79p9To7Re1UgEnXLmOc9fCyoyg493pRPr25Yl3jzTtwX
 0yJK/1XEgvkPg7ZX9vZU64Lj8SSf+6jsWYCx7MA==
X-Google-Smtp-Source: AGHT+IH/bVB1UJNaOr2Y9oPWlKwaWdzTJezKChnt9tsreS5L5sy9Ol06U6myLVU68DGkvziBvhuVz3wDjRI13pvYaSY=
X-Received: by 2002:a50:d49c:0:b0:56e:5b2:2d2a with SMTP id
 s28-20020a50d49c000000b0056e05b22d2amr2769574edi.3.1712938435920; Fri, 12 Apr
 2024 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240412100401.20047-1-pbonzini@redhat.com>
In-Reply-To: <20240412100401.20047-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 17:13:45 +0100
Message-ID: <CAFEAcA_qKTPHCy0mfshPrkXxqokfhh=yojnxtwXm8dPN5P-LEg@mail.gmail.com>
Subject: Re: [PULL 0/2] Final build system fixes for 9.0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 12 Apr 2024 at 11:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 02e16ab9f4f19c4bdd17c51952d70e2ded74c6bf:
>
>   Update version for v9.0.0-rc3 release (2024-04-10 18:05:18 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2d6d995709482cc8b6a76dbb5334a28001a14a9a:
>
>   meson.build: Disable -fzero-call-used-regs on OpenBSD (2024-04-12 12:02:12 +0200)
>
> ----------------------------------------------------------------
> build system fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

