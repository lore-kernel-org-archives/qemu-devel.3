Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F523D767E9
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6YY2-0007AC-7h; Thu, 31 Oct 2024 13:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6YXz-00079k-Ue
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:01:23 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6YXy-0008Og-Bk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:01:23 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so1572456a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730394080; x=1730998880; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DuAHEty5rg9pA/YP2ghwa7l7fMKVlChLDJn4tSrnwBw=;
 b=nPkjtbX2p2ezG5VfLG/rav9k681NCa46i0czVOoTwqfyTL6k3SmE2Jw1ebl9YqyzBB
 Tgv0i03cEU3VBkV9shDnytVL/8aoWUCm3fFXkGYoY+iI6UJzMAl7BMPikjHLlsboQBAh
 /bOCshf3G9z7HBnA/iS9TpVW7F+izAX6VqyQAb3YemAQOVhKB9R+evwrg/5+dbNEw7Lu
 d2Qidi4yii836+0rKFNg7fjn3axZi1Guo/kBV+jlfa+PN9FURA4HB/NzubjvlMhdp8Y4
 u3mHMmm5CrrUlYbQi88inh31JIK84AFrlZpmT/VIuQJPgNxqJVzKD0E/XBD1je0az6Wb
 tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730394080; x=1730998880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DuAHEty5rg9pA/YP2ghwa7l7fMKVlChLDJn4tSrnwBw=;
 b=RusCvHpcPrIz0V5kmTXYwtRlebCVDDUv5HrXW13VBBxytZlc0/kZx59z5enUdPQDkq
 SJz3kahWk/gEgkSav0rz49uwwUDlnIrVRyH1pntYJjbhIJo+4NkKB1dhnCFjeaQ5c+Zy
 /UW6zOojXGPnlHxi8fmzaVOHjg16UkAEa0cBSSYkOW61HGfTUz98wGg4iSHFVjyT78PI
 GoH/qG34JC0vucLHEeFkjgxamUFTL7nSYLnD3IJY8J6tHKwQ6DfoIygiu04lZksL9Oaz
 TPHqpQAC63PpQhwitPftS0N1dCzGXksuzKSodkwf7zIK1IUaHml7zRfpsTHi6w9lo6gT
 9ZTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqnwI2WdUd0osvzHXvUNneRNP3C/J0OXow+Rqfr1c0jZ/KeL8y2oapgKxXu8NRjq7ab3HCnLtNxQW1@nongnu.org
X-Gm-Message-State: AOJu0Yw62r7SMZR3TMFDQ342C0msPWU6bzhr8Os/IkbZTyLUx8gTXMdj
 kIZbAJwvl5aVBx+yuIRt7aUjH+UfjUHhh8KqDDBQhfJOkzo1PY3deNNZF6nOCK8y9bFgRPRyAwf
 LdCblOgTxjUmQM2AJrZamKE5I0irUNkggwKziog==
X-Google-Smtp-Source: AGHT+IH3aLL49nJ8/nrP1BtiBn2V73JrYnRxSS5GJJLk0wtFCNOviaa8qnpHDhqYpv/gh7L78a+G8xN9QQofFpCnubo=
X-Received: by 2002:a05:6402:234b:b0:5c9:36c4:cead with SMTP id
 4fb4d7f45d1cf-5ceb938be03mr307119a12.34.1730394080168; Thu, 31 Oct 2024
 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
 <20241029151048.1047247-4-peter.maydell@linaro.org>
 <95086c66-9e1c-4013-86d6-373d68d55441@tls.msk.ru>
In-Reply-To: <95086c66-9e1c-4013-86d6-373d68d55441@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 17:01:08 +0000
Message-ID: <CAFEAcA_xoSkhk-dGUXw3-0hQyb1NF+6qRP-+6TpoQkFPOBs8Jg@mail.gmail.com>
Subject: Re: [PULL 03/18] target/arm: Store FPSR cumulative exception bits in
 env->vfp.fpsr
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 31 Oct 2024 at 16:55, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 29.10.2024 18:10, Peter Maydell wrote:
> ...
> > (Note for stable backports: the bug goes back to 4a15527c9fee but
> > this code was refactored in commits ea8618382aba..a8ab8706d4cc461, so
> > fixing it in branches without those refactorings will mean either
> > backporting the refactor or else implementing a conceptually similar
> > fix for the old code.)
>
> What do you think is the better way here -- pick up the refactoring
> changes (to 9.0 and earlier), do a backport of this single fix, or
> do nothing?  Note for 7.2 branch it probably requires quite a bit
> more work.

The bug being fixed here is a bit niche (I don't think many
people build with KVM support only) so I would not worry
about backporting it all the way to 7.2. I'm not sure about
the best approach for 9.0 (which is why I left that note rather
than actively suggestion one or the other) -- it depends whether
you value more "backport the change that's actually been tested
by being in mainline" or "make the minimal set of changes in the
stable branch"...

-- PMM

