Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21703C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revcK-0004Pv-Nl; Tue, 27 Feb 2024 06:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1revcA-0004LM-6l
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:27:17 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1revc5-0003Hj-Cq
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:27:13 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so7366000a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 03:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709033227; x=1709638027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yH+ysTtQHkZx1mKQLtwZgc/8OT4X9Vo3uEOds0+TbkI=;
 b=szpRvs4uPdtOMxouNbwIO3z4guN9KoBjCtWtIXhhKF+ttfOLtFbi9IIA9VssS0kih0
 vmbtG9mrNiO1eeGPlvWlh4deA4ht5RdWpKNIJf0l/DaVkXTslHoq7+4cNeaX5ky7yLYc
 0HP1hFzNPzJ/AORH2Dd6Lbhyx6o0j050uOnvOLmumA8LzviF87VuBmiQVD/3l5W37ST4
 HmiympUcLH90ktUvCD8vXZDFQwsno9SAuOR5OvgDNOqi6ywJq8XKKsYXZQqzCrqV1hSk
 NBy+wae/deLwBvhoouc1gvGNMgUGdIrMRRATxSS56xYwk71xBLlhVWiGpiEpy+/c2M9U
 ZDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709033227; x=1709638027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yH+ysTtQHkZx1mKQLtwZgc/8OT4X9Vo3uEOds0+TbkI=;
 b=CxyfczTHOumot5XRwCM7upOKQqmjnp3C3O6H76ymhYl/CxZ0r1b3rYb9j6rMAYrPsj
 XR4KnVprg77Ppfozx8s7/z2HRuG178C2N/j6vPpmEy8+0gXQE4+GkPiL3lkGH3PXEMr5
 dKVTOewULvW8u+f4riiwfKH3DK2ARFIS4SUnJErLcaB+wH7RSfVomw2zOI8sze+jg5Cc
 9O7AN1/XoMG2GRR0iS6UatmLK9WL2mVnn3TpKXB5WXvPO5kkHJnDkBZC/R75Dy+EKa3g
 ay/IIoydhFH9IVihNXSOLeIX79vwLvSrZg0aDXmk/kCnaM8VhE7Zo8mOvegYfandozPh
 6rPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQS44I9PnSi6JUSOuaQ/0CcYwShYdo9Y/gZYjG18b3rL4DITwrgyV6EkyKjqPW9bOh+VYV2riYMww7kbBgDxa745BI32Y=
X-Gm-Message-State: AOJu0YxVTtVIWufA+leST0qUH74fP1LIjF3MaB7triCOSEm9UtXjqPWc
 AGjCeLNKriXnqMcPeI1GiNNypQnN1B8iZODiYIf1TX819PUiSs2WnP9vHeKDCSVy36gjbW+Ymor
 AwY6vqmGzDte0doSRTyX/qKqYNRQ6RNkzXACGbQ==
X-Google-Smtp-Source: AGHT+IEP7R4hj9xiJcOII+COLwhvI+PDX2YJPPBrwbMZ5hV+F5KHdiDWEA3s6HIx6VZwC0ADkWl5I3j3ykgfpYm0UzE=
X-Received: by 2002:a05:6402:3126:b0:566:4e7a:fa2b with SMTP id
 dd6-20020a056402312600b005664e7afa2bmr125483edb.36.1709033226883; Tue, 27 Feb
 2024 03:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <CAFEAcA_brkckzDZh_-UJ-KFfBGvjPozPHNmG-bWFO0Xa63R0Gg@mail.gmail.com>
In-Reply-To: <CAFEAcA_brkckzDZh_-UJ-KFfBGvjPozPHNmG-bWFO0Xa63R0Gg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 11:26:55 +0000
Message-ID: <CAFEAcA_An-KUbaKHDGmk7Uiovft-8JDbW9J1s36wccS2sh9vJg@mail.gmail.com>
Subject: Re: [PATCH v6 00/41] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 18:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> I think the one question I have left is the name of the
> board: currently it's "raspi4b-2g", but should we name
> it just "raspi4b"? None of the names we use for the other
> raspi boards we model have a suffix like the "-2g" here.
> Philippe, do you have an opinion here ?

I had a look at what the different raspi4 models are, and
it looks like they're all the same except for the amount
of RAM. For QEMU, if we wanted to allow users to pick
the RAM size we'd do it via the -m option, not by using
different model names. So I think on that basis and to
match the existing raspi machine names, we should call
this simply "raspi4b". So I'll make that name change in the
patches I have in target-arm.next.

thanks
-- PMM

