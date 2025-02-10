Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA8C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQqq-0000KD-Vr; Mon, 10 Feb 2025 05:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thQqk-0000Hz-3n
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:17:11 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thQqh-0007uI-R1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:17:09 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e5b4d615362so2182546276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739182626; x=1739787426; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LOdDJ1XUCosfqzEQ3Grv+frQu/IdenLgHcIrw3bTq4U=;
 b=UnzjkRc0nVOPGm84gv+HiE7mYcxriN399F8fR53ebRtfIx2zr4Y/sEUQjtR6QGzKYK
 1rJ4j94QFvcQJyWXWeYg7adCxgSvsvt7et54Bb+tVpxi0MN5QJJlN6zzavmoerkLa1fp
 YXs+TN+zVKC2dqMYxv+LDS0AoDxe5/HN8Mdi6MyAUW3PTcao60C5jWAwPl2s3ECiiDrB
 NGVs6WvYMsbAzoVvywTT/4R1Pw/BdxMhUB3qEkSNGg4y2GQDfjZv7qiohW+HWMUtYEJf
 dnDukeEDyNpp6j4Qf/bAdILzXYKpzlLRvJhppnGRAwHVPcWxWDn9+4rwm1IZUqVCAu7T
 P7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182626; x=1739787426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOdDJ1XUCosfqzEQ3Grv+frQu/IdenLgHcIrw3bTq4U=;
 b=dJ+Q2NdJ8mtN0q9w0W/Re+CkQqO9Ds3A2wzA90nSSIIW4o75WKcLFucCcWL/CDYX9t
 7BUJGrEP8lHFLR/rLZoIfZ3kjOCKH4048XgW2rtk9DXl6XJDjO67O/Rmzw6ru8AROilD
 arOOnIuA/d+sBF7Pb2uPXpRq4/5OW8J5WJg2YAgbhTQ5aSCCQqKBqst1CCHqhOx7H4Y/
 c1sKd8F6yD9MzRwmWCFNnKpULurjMD1MomRAb4fmcdAmDuBfdBsIUD0hczLcKQdSi5eX
 97vNi6S107eVOyPcnsLoZ0k8SrfTDqfUbEDbjqPAYrMCpLFPYrUj1k7H4PXgB9l++mQV
 bcGQ==
X-Gm-Message-State: AOJu0YwmpinsmO42UDFNH8TW6UArJybfKfAndwK94tbo06mwjlQ5aEvq
 Lvwm9nonuYbNlg+NxUPu1lpEgsjKe1fyyq6e4RSryTK8xvnTamyURlF3yDdor+JtsxF/FCNVqva
 VADYjVJhrTJlu4CQX/ZQJqmn61kzJGADoJcnea2Jx4I6dm3AT
X-Gm-Gg: ASbGnctTkP5rM0DpDLi6ZH40WJwOkwxHCrtpLeDfQo2hRn7aX6vxjf+7vEfcwfQGVCV
 ebYsY5g+UvIvrHavULRShQnOJp2C3+OwRsie0dOeinDxcqQfcnS334GLO90y4q/08YQLGOmAleg
 ==
X-Google-Smtp-Source: AGHT+IF4YukAcLNH1i4lqfiQg9jyxRHpIncBUaNsGIptu60d9oXzCIKJrBLDjCuWX4FXw5aue3EplYbXJA+nMSN4+58=
X-Received: by 2002:a05:6902:2608:b0:e5b:225b:19ab with SMTP id
 3f1490d57ef6-e5b460690fbmr10396039276.0.1739182626066; Mon, 10 Feb 2025
 02:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20250209033233.53853-1-j@getutm.app>
In-Reply-To: <20250209033233.53853-1-j@getutm.app>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 10:16:54 +0000
X-Gm-Features: AWEUYZkHMjX4B_dfPZHQ7zIIT1H580AgbPbDPGVC2Iq3FF1HVhF5OfeuiI0BeqI
Message-ID: <CAFEAcA80MeTfHEV-y5by3SHO2bDdGAXPSKhg6LQ_NDdYOodhgA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] hvf: use TCG emulation to handle data aborts
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Sun, 9 Feb 2025 at 03:33, Joelle van Dyne <j@getutm.app> wrote:
>
> When the VM exits with an data abort, we check the ISV field in the ESR and when
> ISV=1, that means the processor has filled the remaining fields with information
> needed to determine the access that caused the abort: address, access width, and
> the register operand. However, only a limited set of instructions which can
> cause a data abort is nice enough for the processor to decode this way. Many
> instructions such as LDP/STP and SIMD can cause an data abort with ISV=0 and for
> that the hypervisor needs to manually decode the instruction, find the operands,
> and emulate the access.
>
> QEMU already ships with the ability to do this: TCG. However, TCG currently
> operates as a stand-alone accelerator. This patch set enables HVF to call into
> TCG when needed in order to perform a memory access that caused the abort.

So one problem with this is that it immediately puts all of TCG onto
the security boundary with the VM. We don't claim any kind of security
or can't-escape guarantees for TCG, and it's a lot of code, some of
which is old and some of which wasn't written with security as
a top-of-mind concern.

Our approach to these instructions with KVM on Arm is to say "don't
do those in the guest to MMIO regions". Most sensible guest code
doesn't do weird instruction forms for device accesses, and the
performance is going to be bad anyway if you need to fully emulate them.
(This includes in the past that Windows got fixed to not do this
kind of insn to a device in at least one case.)

> One thing this enables is the ability to use virtio-vga with Windows for ARM64.
> Currently, graphics support for Windows is flakey because you must first boot
> with ramfb to get to the desktop where you can then install the virtio-gpu
> drivers and then start up with virtio-gpu. Even then, there is a known issue
> where Windows mistakingly thinks there are two monitors connected because the
> boot display does not share a framebuffer with the GPU. This results in
> sometimes a black screen when updating Windows.

It's not really a good idea to use virtio-vga in an Arm VM,
because it requires FEAT_S2FWB in the host CPU to make it
work properly, and not every CPU has that, at least in the
KVM world. So you need to use virtio-gpu anyhow.

thanks
-- PMM

