Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DE6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnKw-0007Xj-7g; Tue, 28 Jan 2025 10:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcnKo-0007WP-KT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:17:05 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcnKn-0002xp-4n
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:17:02 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso9558949a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 07:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738077419; x=1738682219; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NIxHkklMu16t1TzGiDzdo9IodGSqyhLwoaToFDWQoDQ=;
 b=h7GfHOuztjmBHNn+7MSsH+H5/zdDhNvsfgM8dyeGD3OsirAnrCeYP5n6jC50O3JxDv
 SdCfnNID9xdkGtd7f3Hy5H3bqzDgKE2+EfydRD8Vu7k0fCRCxSbGSn56L7s29qTFaP00
 4lGBt/KOVJq+vLLZiPXeVUSCBYt0kg/ueZIfeZh/WJlkZsVrRq2oqiYule5dfaKt2j3z
 TCYv8SzTwsWSZkFBaGf7rZA2hxl4vOMkPLarnbypcugyzoHGsYYBdxTFw2xl9/Zjp11j
 aOptTLWWJ5DHl171D0JeJ7k6YvYrmLgu6ZzUM7iGYlUapOouHl6qDiVm5ZaZseQZ8XJn
 R7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738077419; x=1738682219;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIxHkklMu16t1TzGiDzdo9IodGSqyhLwoaToFDWQoDQ=;
 b=ErkNubbzOjDstTUW2LaijiRVX92fWwoIy7klZbLlrkeWrJy8tMAORpS3elYPWO97gu
 lRo1RtRb0Xld76Wt2h1Ga8AWOXyFcAjDZEHQHPXcYwDj4O/N1PSUB+x8C8wv3fQoiv5E
 86TPtCPSMmeGOqtweozDBPOyt9a5SdDnYZ0V7Thxn61HGp8BWPTBqyiAz0wG2WgPJN/x
 iPstoA8+pbFfYzclTPoE4JsDmhMXVm6/C5WkbvKHmI+pe1OXmcfb1ohbhv430FWFbaYw
 wXsxHilT5dK55GSnQlj7loCVpxtf3Z/FOblX1mM8Boq5rT0tXfEonlaDqfJtTnaIOBgG
 XHQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG6IXgA78fmM9wr6KO2KNqrt0/4VwJ1gc7Y+y5mbuzHFP3cwfXSXp+L8y5WHkrtG71lCJ1zkFqa/lO@nongnu.org
X-Gm-Message-State: AOJu0Yz+gSVUPxqMrleulo1V0Dx7Eztz8fi4fanQgon9+SaP1pbbJO85
 MEf9fsRZWaRPZWzvf7Lu/apvGPGd5z4V3MjgB/WIsz3F+rjHAwVZYEbtKF6wTUsodspx88PJMjP
 qIJMQzBVsfC33dE7D7ER+l7DVGosHH8SLkmegOg==
X-Gm-Gg: ASbGncvodiqZQsV8s47HEhJNZIPmewW2GpVKfP5qIOqGCPhxdRCjxNKaw+aQ6+vjAjM
 3jCcEYMZ2+49VoQnyKOaigkLumRFQ7MT1q0LU2pqRiRDoWYBe7a1l7NQuYcqLQlYEkbi52rMpFg
 ==
X-Google-Smtp-Source: AGHT+IFMTpQSHsiFA/0vwqVq82j8pjx20YvieEDO6eLAHinScxHWsbQF9WjhnaWiHVAn8BrRU2kGb9oeLQGJ+39Uh+k=
X-Received: by 2002:a05:6402:2791:b0:5db:f5bc:f696 with SMTP id
 4fb4d7f45d1cf-5dbf5bcfab6mr23104870a12.5.1738077419096; Tue, 28 Jan 2025
 07:16:59 -0800 (PST)
MIME-Version: 1.0
References: <Z4TfMOrZz6IQYl_h@Sun> <Z5ebPXTxTbDgGtUl@Sun>
In-Reply-To: <Z5ebPXTxTbDgGtUl@Sun>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 15:16:42 +0000
X-Gm-Features: AWEUYZnULrtPDLXlE-TOeXH-0T0lx6MUcBDaXno0UxmSJlth5o4X6EKgOFxNikI
Message-ID: <CAFEAcA9HMVYQcE5UT7osXxMFHa59H-65N=_v7KNAKpJjx90afw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/canokey: Fix buffer overflow for OUT packet
To: Mauro Matteo Cascella <mcascell@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 contact@canokeys.org, Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 27 Jan 2025 at 14:48, Hongren Zheng <i@zenithal.me> wrote:
>
> On Mon, Jan 13, 2025 at 05:38:56PM +0800, Hongren Zheng wrote:
> > When USBPacket in OUT direction has larger payload
> > than the ep_out_buffer (of size 512), a buffer overflow
> > would occur.
> >
> > It could be fixed by limiting the size of usb_packet_copy
> > to be at most buffer size. Further optimization gets rid
> > of the ep_out_buffer and directly uses ep_out as the target
> > buffer.
> >
> > This is reported by a security researcher who artificially
> > constructed an OUT packet of size 2047. The report has gone
> > through the QEMU security process, and as this device is for
> > testing purpose and no deployment of it in virtualization
> > environment is observed, it is triaged not to be a security bug.
> >
> > Reported-by: Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
> > Signed-off-by: Hongren Zheng <i@zenithal.me>
> > ---
> >  hw/usb/canokey.c | 6 +++---
> >  hw/usb/canokey.h | 4 ----
> >  2 files changed, 3 insertions(+), 7 deletions(-)
>
> Seems that the USB subsystem has been orphaned
> and there is no maintainer now.
>
> I used to ask the USB maintainer to pass the patch
> because I could not send a PULL, which requires
> gpg signature.
>
> I wonder which maintainer I should ask for now.

I can pick this up; I'm not super familiar with either
our USB code or the canokey device, but the change looks
OK to me, and I assume you've tested it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and I'll put it into my upcoming target-arm pullreq.

thanks
-- PMM

