Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B26EC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhdl-0000yz-5f; Thu, 27 Feb 2025 12:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhdj-0000xt-Kj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:25:39 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhdh-00078J-KQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:25:39 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so1020437276.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740677136; x=1741281936; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=umCqtJHNDiaN2Msvs96YELjwtlZ9CI4JgKPBd8MXQpI=;
 b=l9z6xayNxwt3PSE8u42SHkQAycQtbRG5EuSvX744B6W9EI+k9CwlAi7A0GCgHhrjmJ
 2xpIoFRL+wj22r1jheckA4RsYOi+li/aGiVwdjNdBY1zFvWQVOo90szFtp2jHba9jCCn
 IEeYIMwyHVuKTI5yjsnYQs+okw97AF/gHw6H5gMr3RvdCNt/Dyvh2RLs9eRJKa2brVJU
 Oif3UjbR2zkSoWPPjmDTsljQqJXDtp4VUMaCUp0jQqwM3WXyJnxTX29kNLHIPl+oC3Kj
 YoL5usBW6NeQ4qCWJtBhG1fMl+fuyGTUw4lzaRavYIbJx3bbOdyd6WMOu2vM3P6qiRSz
 s8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740677136; x=1741281936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=umCqtJHNDiaN2Msvs96YELjwtlZ9CI4JgKPBd8MXQpI=;
 b=gnC4PGdfyGnRkFHxJU/9bCp7t+wZQeM83bg+Yg0ugL47BOnpcgfWdjJcRpxvpitQm1
 HAUBIqVzJhHflFlUSERB50B6RNo18tVvs5ACRxJJLDrykdwcC3lgdkuMjnKK999pVZ/W
 Yj+ehaFkS92PuP1ZtX/TBmXHZmu0vClw+XAHWs7RJ1eBlQaCox40bv+Lv30N05KU8xFg
 RNtSr6acRDHCwPMz/8RLBKT89W4nJAIWOxG5rK1fEdD3yEJ8NrXV8m/EB3JFl+AYymix
 NlvVHytIPJ9YkS0aHpUCZWv/xI3EqfFVUVFEidG2kNKjUPX9rZvfnDeXlt9pXco/PcNL
 V/Xw==
X-Gm-Message-State: AOJu0Yz7tLmCLlJIRibISWOxEWqqV0ACsGfdwWWCwa2jsDu1W803NlFL
 SHXTQ66gXZlRFzcHi6jT+7fkW02gc0PufZBFn+PKvt1yDzr9WNiACnm523IBjauTX/wMy8ZBd96
 wPzlShP74s40A938I/ea+WGp4xgiOnrAGyBYyMw==
X-Gm-Gg: ASbGncsCsiFDfkta1QhWMPsKkqjDScHInq8WSa2keSPVzneWJry3LSTkrOA31CbXIsx
 rdMPWiKx5I4tVbC7q2LXNuQGphlCOnh3IbsgF7gneSArZ5oFNJZE2X4+RS6mS/WB1SbgMR0N2eI
 1EZmM8cjhL
X-Google-Smtp-Source: AGHT+IF0W32cuy7ZDA8CxbceP6kpxGyh33+dQaztyWaRxElC4ocyR767P0NtpU5FdqNgkqpBbMQAs+T2eRyFvLzdHCo=
X-Received: by 2002:a05:6902:2886:b0:e5b:38df:b44e with SMTP id
 3f1490d57ef6-e60b235f810mr449858276.2.1740677135953; Thu, 27 Feb 2025
 09:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20250227164538.814576-1-pbonzini@redhat.com>
 <20250227164538.814576-5-pbonzini@redhat.com>
In-Reply-To: <20250227164538.814576-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 17:25:22 +0000
X-Gm-Features: AQ5f1JrVGk5CpLqk-fU_y6UXl174Hyz7KS77ROG2TrN2tjBvbJlPvyFos3F9nJ0
Message-ID: <CAFEAcA_WOxLvWnp8Tp-Q5xj3_cEs2OGhAbVFtymGwXYKxUePYg@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: pl011: switch to safe chardev operation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Feb 2025 at 16:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Switch bindings::CharBackend with chardev::CharBackend.  This removes
> occurrences of "unsafe" due to FFI and switches the wrappers for receive,
> can_receive and event callbacks to the common ones implemented by
> chardev::CharBackend.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


> @@ -567,21 +552,16 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {

> -            update_irq = self.regs.borrow_mut().write(
> -                field,
> -                value as u32,
> -                addr_of!(self.char_backend) as *mut _,
> -            );
> +            update_irq = self
> +                .regs
> +                .borrow_mut()
> +                .write(field, value as u32, &self.char_backend);
>          } else {
>              eprintln!("write bad offset {offset} value {value}");
>          }

Entirely unrelated to this patch, but seeing this go past
reminded me that I had a question I didn't get round to
asking in the community call the other day. In this
PL011State::write function, we delegate the job of
updating the register state to PL011Registers::write,
which returns a bool to tell us whether to call update().

I guess the underlying design idea here is "the register
object updates itself and tells the device object what
kinds of updates to the outside world it needs to do" ?
But then, why is the irq output something that PL011State
needs to handle itself whereas the chardev backend is
something we can pass into PL011Registers ?

In the C version, we just call pl011_update() where we
need to; we could validly call it unconditionally for any
write, we're just being (possibly prematurely) efficient
by avoiding a call when we happen to know that the register
write didn't touch any of the state that pl011_update()
cares about. So it feels a bit odd to me that in the Rust
version this "we happen to know that sometimes it would be
unnecessary to call the update function" has been kind of
promoted to being part of an interface between the two
different types PL011Registers and PL011State.

Thinking about other devices, presumably for more complex
devices we might need to pass more than just a single 'bool'
back from PL011Registers::write. What other kinds of thing
might we need to do in the FooState function, and (since
the pl011 code is presumably going to be used as a template
for those other devices) is it worth having something that
expresses that better than just a raw 'bool' return ?

thanks
-- PMM

