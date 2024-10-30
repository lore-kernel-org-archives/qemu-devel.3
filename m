Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3A0D6B6A7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BNM-0003UV-KU; Wed, 30 Oct 2024 12:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6BNK-0003UA-Uu
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:16:50 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6BNJ-0002TR-BX
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:16:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so49334a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730305006; x=1730909806; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9J5Nn2VIDI2g1fVa/d94I87DoPbRGqzG8bhzTdHbqo=;
 b=xk/T5Lu2KTz4tBB+wMH8M4gp0kHkGdXDWr7bhmIHuZ9o90+AnAK0aRyhTVeJqACsLe
 xalEELFKv9K/v4Wt97CrSzoVuN/kEjmJapa5F0Gmb2wwLubwErvxreKK2jbUdm96/Wyo
 Ocqeix27KzjuWX2Rbc9dHkeVFVFekK28/7K9n03+jmgfJeLNanAzhiW0iswA24uszH9C
 0ZlhWOSrBgxXiHEWUiQDy7o388nlT77xffUzAQM6503Xn3ZG9404Ug43/wCqzT6YllLQ
 /eoeaOCarG2NJmQijB5MfwshSO9MoYOuxNMHIV2b8dVjk0+dNoyXHTyGiNPuDAxnjfBm
 qhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730305006; x=1730909806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9J5Nn2VIDI2g1fVa/d94I87DoPbRGqzG8bhzTdHbqo=;
 b=S8AnzR8QKcM205B5BUWh2LIbHPL/u+ZNZIPJhg+Oq8Kg8yPDhFyJYJ6PUj4VQ6T8lP
 zfsVjVF0SfiOoIOM6oN8MOdXWZtYwb1WnPpiWpDoe2JWiYtUKIxyNGZwXF78GBnHbBfF
 mA1o+FIXFaMk6m2UsZUFOsRaRcwQqEouGaedAKSPxgsPrm2zX009tt4dt09hRKzT0vne
 LAFIBVSb+dhiEoKQteI5gQNWD+8gbbpP9EV8EzsoqC70akdZ8KbiWZzOFTMU2N7SaRuw
 XJgBOC+mQH5I5QlvpZvKhqY8obnNiGRH43LuR9kW/mfWQnMFoBXT6mt3Q/Pt7O41KtCF
 8cRQ==
X-Gm-Message-State: AOJu0YxjqPLSJh5GZvi4r0s2oY3Z9oObTDhLP1v9AjYZmMyVVFhRBax7
 H/zMs3ntSHWul48CEl1prZSw2uQz/rT2bxnWF9iCDFFcdyBPLeoBPMlQHMN3eGigYRnzCldvUMU
 60BbNdiKmAz9zT5wsDZOI5lo5TO4upGb4VWkpWQ==
X-Google-Smtp-Source: AGHT+IHHkcxOMOH15PjfMO8hspC7A2XOjT0n4zPDhL8kVkB0JY0ZyhP92lUGYGqCaLDYXicAij3Rfeq436AcprRI0Bc=
X-Received: by 2002:a05:6402:1f44:b0:5cb:68c7:879d with SMTP id
 4fb4d7f45d1cf-5cd564fe471mr2758782a12.19.1730305006076; Wed, 30 Oct 2024
 09:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9JQNJBfk+g8iYcczVcTSqEOJZ5=LGtBupHqreUX-2MkA@mail.gmail.com>
 <605361231.417554090.1730234829057.JavaMail.root@zimbra83-e15.priv.proxad.net>
In-Reply-To: <605361231.417554090.1730234829057.JavaMail.root@zimbra83-e15.priv.proxad.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Oct 2024 16:16:33 +0000
Message-ID: <CAFEAcA-zznZ=_=JtAuLveQevAj7doDyq8-q-Yz7Q2EZaPiy-pA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: Add cortex-m0+ support
To: castet.matthieu@free.fr
Cc: qemu-devel@nongnu.org, "open list:ARM cores" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 29 Oct 2024 at 20:47, <castet.matthieu@free.fr> wrote:
> >Our coding style for multiline comments says
> >/*
> > * they look like this, with the opening and closing markers on
> > * lines of their own
> > */
>
> I will changed that.
>
> It do not seem to be followed in In hw/intc/armv7m_nvic.c, but my new comment should also follow
> this rule in this file ?

Yes, please. We have quite a lot of older code that was written
before we imposed some of the coding style standardisations we
now use, so you'll see stuff that doesn't quite follow the
rules in files already. Our general policy is that we don't
bother to try to tidy up pre-existing code, but where we're
adding new code or if we have to touch the code for some
other reason we'll clean it up in that local area.
(A rough guide is "if the checkpatch script complains about
it consider fixing it", though checkpatch is not always
correct about its suggestions.)

thanks
-- PMM

