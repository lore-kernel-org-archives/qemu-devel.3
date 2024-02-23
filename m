Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6963EC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVue-0001zK-MD; Fri, 23 Feb 2024 08:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdVsM-0007o7-9c
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:46:06 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdVsH-0007Vl-4W
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:46:06 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5643ae47cd3so1002392a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708695958; x=1709300758; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sJk7csTCqjXdjH4hGqlv98RKvqueNLyFlM6+zsyWkog=;
 b=pe6kYM8se6a7KoqcmgrrpIerjNyDP8pcvxxerXB8IWneAa9qvxgyzVWBf1S15jHior
 rwDH/EuY3E/EIYvQ9/izLjZB4jIm5WsCeK3nTFGuClDkT9565UsnxQnWtNNiSgj7ErtS
 IOXZFLKzFv6styuz7jti05+4zXoMGajnpdwvJv7Z0MddZ+RiZQK6UpVIWuyRI/pYoKXB
 ebZcgmedNoEStq24M8eN1LTBwNeSCg9GVdqSP/KdkNgysLDVtqa+uYGBi0VEOa3Zsv4P
 UlEg7aLElA9FF6eDOTz4/QQZoBgIfPtxuoC+bAgS6YIxHzbrCgZyrV3RHspiUjMnjmnQ
 OP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708695958; x=1709300758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sJk7csTCqjXdjH4hGqlv98RKvqueNLyFlM6+zsyWkog=;
 b=BN7N5xsUn2YQ7K9uAYPGoHp8LwPUiZtgyVw1E2a6At2eqZCJgbhtsQeoQzGf5EXlyx
 GNOo2f4JhZFi4vnhpZJWipMIaUM9I2i2BJHIq8elYnnEjEWyARfk/95nhXCrn4U9W6OU
 G/uoF2wZXD1ki1yuuhuSCLAwlgCCZyro50Y5sMLTMfiGlPED+sm9keBMbs46BacxyG6g
 unbAx2gheutKIknHOk4t/OxiePqO66+RzXm/l2/piC9Ln727kOOsbwHkJsGhPY8GpNE6
 9LAfjFaZcU+Lr3/gG7EqKhwr8W/Jigp4T6aMtPENrj6oLX4/s4EqL4e8DuSyVLC+DqwU
 dZ/A==
X-Gm-Message-State: AOJu0YwjBlbaIghrH9on2vfgql/JmApP1ylOnMRIvpkZNvbdWKzGWpgC
 BDN7ZGPR/o1Fh+iiVajT31k504iVr4Q83fsNeDM8qMllhb00QPYncnmveNPAc2OOKzYc15Esdex
 DMOmzO4qQvxdtkar8rqaaVpj4n0rAvJOPkKGMgw==
X-Google-Smtp-Source: AGHT+IFpC2geouvZG5vinc64bb2KOlrM5zb3AoMyn8matytSFIADt9K5UAjUSWxwH/gDoTnPHbhHTecfiIzJZpSJx7I=
X-Received: by 2002:aa7:d958:0:b0:565:4ff4:56bd with SMTP id
 l24-20020aa7d958000000b005654ff456bdmr1403885eds.15.1708695957590; Fri, 23
 Feb 2024 05:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20240222204323.268539-1-richard.henderson@linaro.org>
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 13:45:46 +0000
Message-ID: <CAFEAcA8jChwScfQikL+0wxHJgdnLz8_Ed-RKmZ4-UFMhWShkqA@mail.gmail.com>
Subject: Re: [PULL 00/39] tcg and linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 22 Feb 2024 at 20:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 6630bc04bccadcf868165ad6bca5a964bb69b067:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-02-22 12:42:52 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240222
>
> for you to fetch changes up to a06efc2615a1283e139e35ae8a8875925766268f:
>
>   linux-user: Remove pgb_dynamic alignment assertion (2024-02-22 09:04:05 -1000)
>
> ----------------------------------------------------------------
> tcg/aarch64: Apple does not align __int128_t in even registers
> accel/tcg: Fixes for page tables in mmio memory
> linux-user: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
> migration: Remove qemu_host_page_size
> hw/tpm: Remove qemu_host_page_size
> softmmu: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
> linux-user: Split and reorganize target_mmap.
> *-user: Deprecate and disable -p pagesize
> linux-user: Allow TARGET_PAGE_BITS_VARY
> target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
> target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
> target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
> linux-user: Remove pgb_dynamic alignment assertion
>
> ----------------------------------------------------------------

bsd-user fails to compile:
https://gitlab.com/qemu-project/qemu/-/jobs/6241616724

../bsd-user/main.c:379:30: error: use of undeclared identifier 'arg';
did you mean 'argv'?
if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
                 ^~~



thanks
-- PMM

