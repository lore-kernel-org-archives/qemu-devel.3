Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03ACC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdKc-00018m-Rp; Fri, 21 Mar 2025 10:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvdKV-00017V-H6
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:26:36 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvdKT-0002bd-Pq
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:26:35 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6405e4ab4dso2736023276.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742567192; x=1743171992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EWojg+r5/UQDRAlld+v2Q3zypIFV3jNoUvRME6g8sFE=;
 b=WUV1Ce6Q5fsrQ0LvfyESHBrkMg7MbHIyrwYT8tFzc4xyYC4uZ7COtYSG1T0/1425Wt
 JZ2JTkxH9e3OB4QxRboIruMN6O42sNwL87o1KPUM1FPPNRwx1Dk+N9N9L0oISXpA3vmk
 Mw5Z3iRpYFZT/U1AYA9K4VGomKe3/UKBK0kXPSyMzrHNZCSyQ6SO6ZM3WIPPDfBkv8ox
 ExJ3bVSxgCU5N0HL54kSWI8CML1z+KB4qR74z+5QY2m89F222UVUP/E6JpFlINXr4WRi
 JvQfUiUcscpTwi+vefZDgGDbkDAOpcd2q+tBJohdCsrFdSJIX9z4xfVcbwRbcXEUhVuQ
 bTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742567192; x=1743171992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWojg+r5/UQDRAlld+v2Q3zypIFV3jNoUvRME6g8sFE=;
 b=SslQpivGJ11WybfyGfLt77pjDeJTgkcPZ6IrXsxdWjXr7aYxOpzTkNBPCk1dVFEoDp
 gepiAaQKGtyc2yUniySKs9XzqMnW6V//oXCIbSR8wTDlcGttlSThI1C4s566ou1JJvJg
 4rv8saBbEk7stB4C8+rBvq/i5rfDJy3iT5rLs9R7yDpO8eAzAoG4NdB1CmcwcCAdvVGX
 78+JMK1Buleq+aBUyO+cDE74IRYhweBNds7EGmXNMipAdRoF7+brjmix4i0fF929xcat
 EoxniIYOq1FLlWbquqz/RloSFsXQfKyFT2UpTfiAPruV/1KVt87NkvFHxBCxe4ayU8iL
 5o/w==
X-Gm-Message-State: AOJu0YzAPKNh90+cYN9JbhSagMbn8afkBt23mPFy0LFJezA2w8WDLAK3
 gIY4G3lVypHwVKtaA09vLXXkzVGT59LzP3/qc5J5HeCqnLKMC1KeRxHs159Buutpkq8FBTIeG19
 4Euv8jEwEhVX4byzXmGM3b6dSoaRgZKVbPpGPBA==
X-Gm-Gg: ASbGnctOhwpkd/DPuyDfRY1scV8k/WXApcjHaj2sXGx/v0UYfeUScw/tIQUwN8x+As5
 GeKHRuNkgfsskS3ntuhvE9QVWIJkQB9sDUlfoJ+DE8Fygvo0H7QaPHlq3BPMNgckNWuyQg+gm8h
 CLs5tRsdyt4zOorJ2Fam4/qsE5PEI=
X-Google-Smtp-Source: AGHT+IFNHf1utZe/MoKT6Y8goCeqROL6oxf8NWYDOZOlSo02DG0yo7ViAeU9Mwc8v18ht2YcOWmd53Jpdpf7FSe6/6c=
X-Received: by 2002:a05:6902:2808:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e66a32a8dbemr4813151276.16.1742567191904; Fri, 21 Mar 2025
 07:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250321133339.116081-1-pbonzini@redhat.com>
In-Reply-To: <20250321133339.116081-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Mar 2025 14:26:19 +0000
X-Gm-Features: AQ5f1JoKU4GNsKrANCZl6HJ5aOfeS1z8HlaTG2DRFgBUhI40noZok5wKrTFKw0o
Message-ID: <CAFEAcA_h6VDA6E1=DHN5LyuekhmXcD8JpEUEjsHboPSDK-VdAg@mail.gmail.com>
Subject: Re: [PATCH] rust: hpet: fix decoding of timer registers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
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

On Fri, 21 Mar 2025 at 13:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Due to a missing "& 0x18", timer registers are not decoded correctly.
> This breaks the tests/functional/test_x86_64_tuxrun.py functional
> test.
>
> Fixes: 519088b7cf6 ("rust: hpet: decode HPET registers into enums", 2025-03-06)
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/hpet.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
> index 63c1971f0b5..3ae3ec25f17 100644
> --- a/rust/hw/timer/hpet/src/hpet.rs
> +++ b/rust/hw/timer/hpet/src/hpet.rs
> @@ -776,7 +776,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
>              let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
>              if timer_id <= self.num_timers.get() {
>                  // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
> -                TimerRegister::try_from(addr)
> +                TimerRegister::try_from(addr & 0x18)
>                      .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
>              } else {
>                  // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
> --

Tested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

If I understand the code correctly I think you could also
write this as "addr & 0x1f" which might be a little nicer
as it then lines up with the "/ 0x20".

thanks
-- PMM

