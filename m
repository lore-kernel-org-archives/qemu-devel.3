Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE34C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAo7i-0004Un-A3; Fri, 02 May 2025 07:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAo7d-0004SH-U6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:00:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAo7b-0008Px-Qp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:00:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso1308126f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746183598; x=1746788398; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=boH7AIppjrghdlxAs034b0zl0rG1O29gtQppRK5A2vY=;
 b=uIVfp2xYLtdEGD9uQO8Vm7ZERPGhS3M+zTTFlvFVEAod+mJjJmlqL+POEbeeG21wUL
 EbM2vz1FA+6Q446S1F2gBmg6Fjp/0EFFzjU76iC2RvEZn9EJZi5kfYgM5Q4XXrFgwp7k
 bMlL0asiLLkkn7RxsQ2fBdGhI2bncuc7C+Te8h5J1fuGbrf7leKKPPMVY4I/YmnEgLyE
 PPSNF/dYCAZoyE4NRmDJiI0Guw5PlV7V6RQ/f8rn39H7OO7LytvIf+MkUZIXSJ3dXqHK
 Orki0vsvsttnQH+oHrRK9AO4T5k/Ad6yWY1j4uLBbfRn/qVkGRUkfXXlFIXFAQ5UNGU4
 3+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183598; x=1746788398;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boH7AIppjrghdlxAs034b0zl0rG1O29gtQppRK5A2vY=;
 b=S+7wSQH4rJ5tk5HSBqWfBP3iyUE3/iUnWlQLSImNTq5FHwYk8vd6nrxHOIpNz5mpaY
 duhdALmMh8G9nzhuIfshvKJRshpWlstwV4PapSHxAMiQhI9wxLCm+VU0ZM2WaGbGwPcj
 /rGdOOCwXeNblEfmem1+7x4SkW6Z03Mne1b/JZajJGy49FvkmKmsPwb2F86yQdocr9ey
 DFwrhoR9BEO3HqCKqzWUYewGDtzINlTSaTNV9XY9N+5hPm+s/LE1DiI1HdbJbcFHywWO
 qn4jOaOJTxsNbSCS3HWzFeF6WkBSmyb/VZG3rl95rxAcR7yEayVHE/Xhwwzug7j84wqY
 3H3g==
X-Gm-Message-State: AOJu0Yx3B7IRumdqZgmZsLrN8Jc3kOmjiysRZex4acUUcM7n0K4F/l1y
 LGrEfeoeD3wcmgumy0ActGbHf9f1nY8JVm1eR9GpRt78Ipdkt4TMxkLW2hgig7051fZjRNid+Bz
 c8oE=
X-Gm-Gg: ASbGncvOURi3EOi7sn2qHaOa85Ub8XMiWnKDLS+VkcStOVNCIgs3X2sKelJOVCxcHVK
 W2aLNL7G5B/Jrwc5Dpdc5K8amAajttxtDJrkevJK5aA3C6J76CxNnp5XwJK4H+IfTZEbljjzINL
 H73jxJXcG7p/4T2k4TcRjzxSz4z/WY6XvlU1eqoa68bf2a/JGbmGg87gU8Wp8wJpTDDEg3y1Koe
 aksVV3imrsnFWnJcLYRYP4j6eJgVSJEAbgCYmO6WA0wgHzEwi1ZpzuItdg96NuCOP48DlQTC1Ix
 HHCmKeqBipU9m36H5JJNOhMzodJcA3g45kO+iHhCIGTo5bo8lWcn4cBZW8MWa3McLc4EII+Ek43
 70401OBNqKj1psA==
X-Google-Smtp-Source: AGHT+IE5CsmfC7BODIIF7WjOxoo1NJOYEPJuZY0HD8RFjQUsjxB9qhvep5mzw8AwtcTsnm+FguM17g==
X-Received: by 2002:a05:6000:2a6:b0:39e:cc10:3945 with SMTP id
 ffacd0b85a97d-3a099ad2788mr1852261f8f.2.1746183597943; 
 Fri, 02 May 2025 03:59:57 -0700 (PDT)
Received: from meli-email.org (adsl-194.109.242.94.tellas.gr. [109.242.94.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c5esm1807099f8f.1.2025.05.02.03.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:59:57 -0700 (PDT)
Date: Fri, 02 May 2025 13:57:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 2/9] rust: use std::ffi instead of std::os::raw
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-3-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-3-pbonzini@redhat.com>
Message-ID: <svmrvw.3kjuhwophzwbc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>This is allowed since Rust 1.64.0.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> docs/devel/rust.rst                    | 2 --
> rust/hw/char/pl011/src/device_class.rs | 2 +-
> rust/hw/timer/hpet/src/hpet.rs         | 3 +--
> rust/qemu-api/src/chardev.rs           | 3 +--
> rust/qemu-api/src/irq.rs               | 6 +++++-
> rust/qemu-api/src/lib.rs               | 2 +-
> rust/qemu-api/src/memory.rs            | 3 +--
> rust/qemu-api/src/qdev.rs              | 3 +--
> rust/qemu-api/src/qom.rs               | 3 +--
> rust/qemu-api/src/timer.rs             | 2 +-
> rust/qemu-api/src/vmstate.rs           | 2 +-
> rust/qemu-api/tests/vmstate_tests.rs   | 7 ++++++-
> 12 files changed, 20 insertions(+), 18 deletions(-)
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

