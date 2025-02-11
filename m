Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945AAC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmw8-0005uN-09; Tue, 11 Feb 2025 04:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thmw2-0005u8-LE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:52:07 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thmw0-0004C3-Lb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:52:06 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5d93dd26daso696030276.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739267521; x=1739872321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BfpsPa9ilzykncCxXSY0EpWpQLvpwmwBrWmdULAbYn0=;
 b=B9ZUy0gwq8trkVMjjEp5fNeE3F2NqFapbDisUWkQqOtJ9AqBYEkMJ9W6QcyET4IUBU
 e1wp00HQNZ+4KOs8PrfmRorhHL25Dqum5PIcJ/k5yLjMXdopNl/bsdWCONtpuFsEEub7
 uMb7Y9Da9GjltBTzHT4NpQg5wtmT59o62PbXxjWFHGcM4KnRWcPlE7g/5qXyYrcKRp9a
 tqfKNLrQ/qtmq4I7aOoUYX6p6c75ZAhRLFTRFn3/McWIN5uBnbN0Pbx/6iCGQjSRpN82
 +KHVmV3Lmmqz9dXernTz9274UTjRYYOn6i236nteQ3xLNdw4ixHGtv1t+P+Snsbuwu0I
 l9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739267521; x=1739872321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfpsPa9ilzykncCxXSY0EpWpQLvpwmwBrWmdULAbYn0=;
 b=Aw2rJWxiMH30ii8ikUWLvFx/8ASibppJyRXCeAPwyJb8i1UZfGhNj4VcMPKyjyr0PI
 L/mztMYpq2nUUHcOWuWo7yAYqY7cdi5X8CXALyFV7aVyYrPsavZPphNzNjNotbPis4+g
 t4z35mLLBiFVHKb843K95AAsHjev2WBsDoyrF8K7eEvVM2VP6hYLq2owB+e4Q5uL8XeR
 nWrW9fLNTakIwAyFH/AiRmGj4WxEpuLn/4Ky4gKypQhHxkSjoGe/SLgbJMnsad54zzHg
 wTxDcbBvubBwr0PBJw/EKJHgKyaTkjmX+klCkMkDqmJwF7qUS7s5y3FXm0H29+i5Pulg
 0dJw==
X-Gm-Message-State: AOJu0Yymwtlx8thBLSg9D/rlON8Q1nK8QpW0Nt6vcbLeAAtK7tb8xGop
 a7soSrgO5hAg5KCFlIAlXoViERCC0249jCJTz8TutlUguolAwfUKwWN+0S9iT2wSh41HZmpbYRh
 AnL31hExBNXa5nczkTzNsBCXw8mQDt3pslcUU+w==
X-Gm-Gg: ASbGncttoNtK8+CRwSlBXgnjou1hjFKuSu+6Ij4gxVDB5pgs5KmNwVTjkAyHDDHK4hr
 CQuOz6kQicGzmhdoxkP+xlrWcIhzmBuvlUdD2IiV5JSd8XwZpwVApIPU4yoCv+tdeezC8FWg4gw
 ==
X-Google-Smtp-Source: AGHT+IEoCoMY0tyYrzbu+9W8nEd9PbReSYjhXXXF3UKKK3JBdGspVjxmUQla2law1AxZdtZrSUpzDsgSc/ZVAV4GeUE=
X-Received: by 2002:a05:6902:1b91:b0:e4d:89e9:6a96 with SMTP id
 3f1490d57ef6-e5b4618d6d9mr13620840276.18.1739267520721; Tue, 11 Feb 2025
 01:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-13-peter.maydell@linaro.org>
 <d8abfef6-36cd-47a4-b05b-e5d3d504683a@linaro.org>
In-Reply-To: <d8abfef6-36cd-47a4-b05b-e5d3d504683a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2025 09:51:49 +0000
X-Gm-Features: AWEUYZkEV3X3XW1F7IeAgbvVXqMdWLwpSSGg5PBJxeKWT74KFdoLfh3yAHkLN4s
Message-ID: <CAFEAcA8d9YNx++MC5ipdj8Pb-zV0w_ANF6B2CQg3+fx4X3Ajzw@mail.gmail.com>
Subject: Re: [PATCH 12/14] target/arm: Remove CP_ACCESS_TRAP handling
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 10 Feb 2025 at 19:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/30/25 10:23, Peter Maydell wrote:
> > There are no longer any uses of CP_ACCESS_TRAP in access functions,
> > because we have converted them all to use either CP_ACCESS_TRAP_EL1
> > or CP_ACCESS_TRAP_UNCATEGORIZED, as appropriate. Remove the handling
> > of bare CP_ACCESS_TRAP from the access_check_cp_reg() helper, so that
> > it now asserts if an access function returns it.
>
> Wording from an in-development patch? How can an access function return CP_ACCESS_TRAP
> when it has been removed?

I think more that my wording wasn't super clear. It's kind of
a two step thing: we make access_check_cp_reg assert() if you
return that value (4), and we also change the constant name
so it's clearer that you shouldn't be returning that value.

> That said, the code is correct.
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

thanks
-- PMM

