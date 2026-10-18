Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D28CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIW04-00009S-C9; Sun, 18 Oct 2026 14:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIW02-00008n-JH
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 14:52:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIW00-0003jc-Re
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 14:52:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso16089415e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792349567; x=1792954367; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I463AGvNZ4ZQj9X56jqfci92r4MzE/T+i2kBII7Oth0=;
 b=Rm/WNGXX6LzBq6bwKqkRVtaAX5mKbf320dqYNTmyVyfzJvOg+3NfzAviw98W4Duj/S
 O3+SBr/jRdDp6V7OHf3fU4VXsuX+M1s1nZf/m8w4fsS4fUli00C1ersXuN/ca/bR2dTH
 Zz+Rkrmc1/ZZKdcrqXVpDuqUYfyLFAi6rnxRzbHnVH38aWmQ9aOVkV5++idoAA4XqgSp
 imNmsU1HIt3mH2k0k0iIYT2kFLW+/2X865P4giCfuse5IzZeg5jDCIUASa7nlkqSVxQ2
 IvxSHGAm05DD12Zm684fqvFMxWqRXJS8tUZt3Z70WSkuax/d5NOBbI7QbsPxo52A1lv7
 EFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792349567; x=1792954367;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I463AGvNZ4ZQj9X56jqfci92r4MzE/T+i2kBII7Oth0=;
 b=c4zEQ4nfd7dQAIw8wAcpDOMJSFVZfdQPf5a8mc3ZttA1c9vgLl3XU8ngBwhGdiwbWs
 +sUQ3CpMi7OaEpL7tpb7DZvnfWfj9Sn8JqSM24pNrovRHXs8AJYi1DRUm4DzBVMxglbA
 z+dJSSIfHk8WJc1BZmY8HVrralt/Fmbz6ej/hlFBF3LyN7mSDtnNzB90oi/0MEqfD2f9
 Tv9iiQ6auiebwTli4CqjGLpVjBKlUcL4kPzqDXL7dEnuDMK0alqLRBUertjvkf95JMVE
 lGWgViQLyJ5kADTbfsLskJx/a9bAKfsl8L/bcvqLz+OK+RD05FiOCX0YId010LZCogfA
 B7Bg==
X-Gm-Message-State: AFq9FYL0+33fIk2aNKk5iUfp2B4LsNqzKG82wHkTq79so0+TVmcG3Eae
 4SXd45+w1tunlFnUZEi/xOAEDiK/vGFvcmr5ai4lCi4bLYrT4qQH6t2R
X-Gm-Gg: AYBFou22jex457pzbxmKJ42ANUJUZ7kkLGMfXkYzsbvl+MfKMTTEgrEGibWJEMIyFyY
 Yj5RyncAFybJFzzhB1Zs4kq3rHuxk2giVxEOVvLMo2BNBvabOvZOPzf4MaNU5R7YCyfPydG9Mql
 f1hjKQflOlVnQCj2XcJ89+8GpiaGWj5JFt4YkHG3JJETV5suexwLlsEeBkh0eBf8o30rm+CAoOg
 9QbQp3sVAAVsSglt9uKi7/rrPdFBMACbImheaCe5uNOPJ1C8J9sVouqrckx8Jpe9GAEuaW9LP5H
 BqBPwsuqlTKHJ1RUD45GfRohLgY5bamDkZzI8NCudDlh0mFyPbvddLGhBof0ZRgC/V6JqWlUzLq
 7FH35bEP2oY6N8TtgnM73HUr2MnmkbRY4pvMbxIc8trvpPQNLnFeCT8CqjVvm2QUCdoKT162TTL
 tLK+6DrSE7ch5Adp8h7LPrODKZ8LxXm3TIuK8AdUh+HamUi78ErJ2sDWDYQJQS0Ws=
X-Received: by 2002:a05:600c:8b43:b0:4a1:83f0:7c8a with SMTP id
 5b1f17b1804b1-4a1d75ad072mr114215495e9.1.1792349566716; 
 Sun, 18 Oct 2026 11:52:46 -0700 (PDT)
Received: from localhost ([31.7.57.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a64sm19578529f8f.6.2026.10.18.11.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 11:52:46 -0700 (PDT)
Date: Sun, 18 Oct 2026 21:52:44 +0300
From: Alexander Epaneshnikov <aarnaarn2@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atUU4HpVVI59QcLJ@alex-pc>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atTzTVaSxUy5r95x@end>
User-Agent: NeoMutt/20260616-dirty
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=aarnaarn2@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Samuel,

On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> Ah, that is a requirement of the protocol? Then we need to do that
> indeed. What is the value of the uint8_t protocol field when it
> expects to receive 0x01 and 0x84?

It is 1 (on). For serial displays, NVDA's Baum driver
(source/brailleDisplayDrivers/baum.py) first sends 0x15 with 0 to make
sure the protocol is off, then sends 0x15 with 1 twice, "in case the
display misses the first one". After that it waits for the cell count
and the device identity. According to the comment in that driver, a
real display answers only when the protocol goes from off to on. On
that transition it sends its device identity, its serial number and
its cell count, and it sends nothing if the protocol was already on.
NVDA itself only waits for the cell count and the identity.

> I'm a bit surprised by setting the priority to 0, but maybe that's
> because of your setup, which is not described enough. Are you
> running on the linux console or X, actually?

Sorry, I should have described it. The host runs GNOME on Wayland on
tty 2, with Orca using BrlAPI. BRLTTY drives a HumanWare Brailliant
BI 40X over USB.

The guest is a Windows VM started by libvirt, with a second GPU passed
through to it. My monitor is connected to both GPUs. I switch its input
by hand, or over DDC/CI when I need sighted help. QEMU itself has no
window: the display is "none", and SPICE has no listener. I am blind,
so in practice I use the guest through NVDA's speech, which comes out
through PipeWire on the host, and its braille.

> But then how do you access the VM to get keyboard/mouse access?

Through input-linux (libvirt <input type='evdev'> with grab='all').
QEMU reads the host keyboard and mouse evdev devices directly. Pressing
both Ctrl keys toggles the exclusive grab between the host and the
guest. Because there is no window, nothing gains or loses focus when I
switch, and WINDOWID cannot help.

> What are the two clients you are talking about? Is that two VMs run
> by qemu?

No, there is a single VM. The two BrlAPI clients on tty 2 are Orca on
the host and QEMU's baum chardev, which shows NVDA's output from the
guest.

> My crude guess is that you are using some sort of front-end. In that
> case, one would rather need to teach it to access brlapi itself,
> instead of the qemu backend doing it.

There is no front-end. The grab toggle happens inside QEMU's
input-linux, so QEMU is the only process that knows which side has the
keyboard. libvirt doesn't see it, and neither does anything else on
the host. That is why I thought baum should react to it directly.

About the priority 0: my intent was that, while the host has the
keyboard, the guest's output never appears on the display. That should
hold even when Orca isn't running or isn't using the display, since
BRLTTY's own view of the tty is more useful than NVDA's last content.
A low non-zero value would also work if you think that is cleaner.

> SDL/GTK do not need a grab: provided that the window id is properly
> set, brlapi already switches according to the window focus.

Thanks, that answers my third question. Then only input-linux, which
has no window, needs to report the grab.

--
Sincerely, Alexander

