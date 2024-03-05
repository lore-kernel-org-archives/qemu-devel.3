Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADE7C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSoH-0002HD-Rv; Tue, 05 Mar 2024 06:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhSoF-0002Fu-OQ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:18:11 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhSoD-00060s-Q4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:18:11 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5672afabb86so2248517a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709637488; x=1710242288; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mfz8ioTCTqKPJskVsegZZCVdkpTisjxgevO5cXAWPAw=;
 b=Gey4Z1K+JHvWGxdIotK38nVYCMIiaiwe8tU+dTRXAmW7QBKGQled2rYEACyPIzR6lk
 RCs5YzkskAsHRMXifiPpMJSkvyPa/Ddf6S+zJ2fdqPobx+kDTmf+rB/es+meXjyYP3vq
 8yVnNPerHx0uLp0tjyu6S1HjgBlfbIRKXZMzc7Y086AZiFAJHvUSAJ2rPWfr8O7xyDJQ
 ruTGIeohWoyigZaotTk62OzWuQwTJyqVU0BM2iFbq2Pbk7LDyBcMk+1ssCl/nz0q9n9c
 iYyfQjxbiadsZ9ln6mKXN8zn1EREBWsTu82AnuVal+dgsfqI3f6eQOidzFTgQzuUMK7y
 u2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709637488; x=1710242288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mfz8ioTCTqKPJskVsegZZCVdkpTisjxgevO5cXAWPAw=;
 b=dKE+j49BUF1KbbtC7wMwlpGuZWffW4bGPq8/+AdGDxSN4ZZD3gdXgRaInF4i1h9eTp
 2GHPEhBkdzP8ZLR9xSMmFFAAoRDoW82pl3reRUHNd1szeD0ClP1fdXKgqfC8czcMIP5R
 VShJMjEaFlFKxQb1g0J7h+GHcWLMSwW7W1V5Q4iJPgDOuchErE27UpLyXoMXTwkHQl+e
 YMvQtXrCJhfzQOtGOLwA04uxCflJ+st+m/qtnyLr3LlcbCESrlg1J0hxN1pxboFkvyD1
 30uqEfxgMyUVhjy9xixK19lbXwFcYRGNJOf622VXKzRAw4ElyzJZ6Q3GcWjyvka8uu8w
 OwfQ==
X-Gm-Message-State: AOJu0YznlJIdXECjsInCT7tDJ3w38VwaDD9h2Wg//QaUo7ca31saijAA
 IXPrtoZV+K2j6CxjBzANCkYo1Bwz4jUjNEbSA1W1lQNhLRvuJefJ+9ODDCPqrU8beB9NdiP1bGf
 l8m21MrZbb8UR3FvuEB3DV0QdmHSBKrafR82UVl+L3pJXceX9
X-Google-Smtp-Source: AGHT+IEseiub8vogp0RHLh57MrUNN//6w5cTM5WmSY8tLxkembn3Jit74xPgY9qJp/aPxXj/OL/C8qNNz++EpR8slN0=
X-Received: by 2002:aa7:dbc1:0:b0:565:bb8f:5f40 with SMTP id
 v1-20020aa7dbc1000000b00565bb8f5f40mr8111984edt.25.1709637488009; Tue, 05 Mar
 2024 03:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20240301230619.661008-1-richard.henderson@linaro.org>
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 11:17:56 +0000
Message-ID: <CAFEAcA_2of8_POuWcuMWj9qL+-5DVbAhawyOBuL54xFG+JYquw@mail.gmail.com>
Subject: Re: [PATCH 00/60] linux-user and tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 1 Mar 2024 at 23:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:
>
>   Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240301
>
> for you to fetch changes up to 04dadd22aed00e5a2955ab078d7edd676812cf41:
>
>   tests/tcg: Check that shmat() does not break /proc/self/maps (2024-03-01 08:09:55 -1000)
>
> ----------------------------------------------------------------
> linux-user: Rewrite elf coredump
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
> tcg/optimize: fix uninitialized variable
> linux-user: Rewrite shmat
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

