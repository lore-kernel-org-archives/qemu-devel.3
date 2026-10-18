Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF7CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIWWq-0004U9-2O; Sun, 18 Oct 2026 15:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIWWm-0004Tw-M0
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:26:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIWWi-0006Tv-Tu
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:26:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1e2957d7eso4881975e9.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792351594; x=1792956394; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2abR97+UqRh9Y26nJJalXxZHwtl4zUXJvChBaHk/cEk=;
 b=o02aaSMS89IGu5AWc7J5Ih6ma9bChLEPZm2hv85eNrHT6bh1N4pAdnoRgAeOt1vo7r
 bTWjEc6WboyrJJBnrVbPjsvoTItZ018hEpbLgDbW6bdmd1nsMRve+2KScUCFRGTeX7lL
 iJRG8QmF1g6E7vyu3o0qidOxLPgjdObn74oSCB+4u+hkb0T7VtyWuAf4WtWUUP4BX4S9
 l+BTuPyCLTrLLtJrUyE8fhtSlGzFNhi42RtbwotURc954q4SnQSKxIO2vXsJsNo7BdrP
 IJEdC9Orcltxwmq/eud212rxDtf65i2ibW2MCpL+SfAXAcG9X3gCE9M9CncWPlLEc4bH
 FLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792351594; x=1792956394;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2abR97+UqRh9Y26nJJalXxZHwtl4zUXJvChBaHk/cEk=;
 b=AkQaQD3dsOWLdYshgVmj+RKdk9as3BnOuMR4SJgs0gv0f6xegVNgvBvfb+3leIPB2O
 d9VAHphYCFLx1Fq8jGDOSQpzLkPD+deQZ8EkQZGo/eOBTEJ/2vS/rZDkMJexQCbRds9J
 zrUYynsBepn0hn19xZ2gTE43jhsEvEGPYF5izZCiGUMCc1HJsE1lxshKlBy20lnyevlm
 Z922x7TbpnOgp5VZlWcyLTCBS6czheXySUx51finqiBqHFPtg0wFq49OtYNVkH91OD8+
 RF3eKMcXXiilTCmwqRo/Ex2OLZvAwTVbAPt5hBBnnX23MU3V1Jm98AALhwEHb5aSaCiX
 GlMQ==
X-Gm-Message-State: AFq9FYIGuz1jgwDL7NsFs1nWjQ/+VZTwDteOSam+k3u/9uqVeoLmYZuL
 9qKd/tPo2OcUzRtvW5qy6PZ9I9cdWweaMguI9oUvcEYjwzEsiWZUy0kMiyjIeXFi7h4=
X-Gm-Gg: AYBFou1eELtDyMNlcs8dqFsrO7W8Bm6qg74pZQ/QLu95UASE33aDaBW71CehplN0Wd5
 H1v19b0vGkohy1Sf7WldbT/TEO6ejcb0PiIYgXRpDRf6ORMy6vtNZ1RiwV0qfAgdKpu1AHVO2Uk
 kMLDLMhlf3o7T2lFbKS0Hy/m68Xdo3F8Ox6wBeBcruqWX02gU2emrPUqLoZc+IiELN7vMgqBKSC
 jVB76gTEtVk6fMgUu3i3wXiJRb5P59tT0tLyVYMDcb6kUTKx5VuEAkJuzdcJNwsMNx8+tOkVIAr
 ZYHZlaM47waJIqYNBKXTaKUkOF7y7JMi5VDGrf2AMl8FaSGdpxV6YViSxIS3CO+ZByOGf+HwqyK
 Vakrx/QI2A3PHqmh6p+TZsqbj44MflIMLI7tvIiW4vIoIzJtM7TUcHTpOYAdls7S0w2PvpKl9nx
 tbOqpzldEtNQn1gHVPY+w866s7NoHNMJsK0DLCfc7Gxczv37pkyY6bybyqKMvElNLkNdECCjUHr
 g==
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id
 5b1f17b1804b1-4a1d763625emr115791635e9.29.1792351594098; 
 Sun, 18 Oct 2026 12:26:34 -0700 (PDT)
Received: from localhost ([31.7.57.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ddde4esm271183615e9.12.2026.10.18.12.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:26:33 -0700 (PDT)
Date: Sun, 18 Oct 2026 22:26:32 +0300
From: Alexander Epaneshnikov <aarnaarn2@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atUcdQhy2bqOI5cw@alex-pc>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc> <atUbL22N4UounO8L@end>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atUbL22N4UounO8L@end>
User-Agent: NeoMutt/20260616-dirty
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=aarnaarn2@gmail.com; helo=mail-wm1-x32a.google.com
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

On Sun, Oct 18, 2026 at 09:17:03PM +0200, Samuel Thibault wrote:
> Alexander Epaneshnikov, le dim. 18 oct. 2026 21:52:44 +0300, a ecrit:
> > On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> > > I'm a bit surprised by setting the priority to 0, but maybe that's
> > > because of your setup, which is not described enough. Are you
> > > running on the linux console or X, actually?
> >
> > Sorry, I should have described it. The host runs GNOME on Wayland on
> > tty 2, with Orca using BrlAPI.
> >
> > The guest is a Windows VM started by libvirt, with a second GPU passed
> > through to it. My monitor is connected to both GPUs. I switch its input
> > by hand, or over DDC/CI when I need sighted help. QEMU itself has no
> > window: the display is "none", and SPICE has no listener. I am blind,
> > so in practice I use the guest through NVDA's speech, which comes out
> > through PipeWire on the host, and its braille.
> >
> > > But then how do you access the VM to get keyboard/mouse access?
> >
> > Through input-linux (libvirt <input type='evdev'> with grab='all').
> > QEMU reads the host keyboard and mouse evdev devices directly. Pressing
> > both Ctrl keys toggles the exclusive grab between the host and the
> > guest.
>
> So you mean that you make qemu steal keyboard presses from under your
> Wayland session? That is very peculiar... I'm really unclear this way of
> stealing the keyboard will work on the long run.

I am using evdev for it, qemu uses it, and I think evdev isn't going anywhere.

> > There is no front-end. The grab toggle happens inside QEMU's
> > input-linux, so QEMU is the only process that knows which side has the
> > keyboard. libvirt doesn't see it, and neither does anything else on
> > the host. That is why I thought baum should react to it directly.
>
> I now understand your situation, but I don't think it is long-term
> sustainable :/

I am using this setup for I think 4 years already.

>
> > > SDL/GTK do not need a grab: provided that the window id is properly
> > > set, brlapi already switches according to the window focus.
> >
> > Thanks, that answers my third question. Then only input-linux, which
> > has no window, needs to report the grab.
>
> Yes, this is really a situation only for such tinkering.

Should I understand this as that you are not interested in making this feature upstream and I should carry my own downstream patches?

If so, it is totally normal, but in my defense, I think this is a useful feature, and the code is rather small for it.

> Samuel

--
Sincerely, Alexander

