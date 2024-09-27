Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCA2CDD1B1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suB7y-0002YC-01; Fri, 27 Sep 2024 09:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suB7u-0002QJ-P7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:35:18 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suB7s-0007TT-Bc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:35:18 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c718af3354so2573970a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727444114; x=1728048914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UnNmXNcCK2g/wd2kL9SAGbhv3k1AGeDYyNBzjjPwKYs=;
 b=WJ1as8MpI9tEssUYdwfcO+EbEYPB88IjnCuFz1iK9FWexoFB1DyRtyU5UT9TEIeZqP
 qTzKwwXcWuzTljboXqQ+CmxfjGK9obsxCREKeJ2BMvsxg++NkoBgO9GgbXsXAr8aDPNJ
 IfsyJg9SroVTuTppI5zXpOBUelju2cWdkXALO8JXFnC3/EXT6ZavURX1xlggHtH3uBTY
 qal9OyaX0sj5Vko/jcGmL5M0olSUlvi9d7Av/fsAGhgpb3zpt7Ms7Tj/PEjPPusej2U+
 xaX0TtIxTR5sbHwh2E6l0gJY+2TQCQgwyd/PV8hK0YdrYNCK+oDrBej5sjGUHWaKgWE6
 8s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727444114; x=1728048914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UnNmXNcCK2g/wd2kL9SAGbhv3k1AGeDYyNBzjjPwKYs=;
 b=kGuYnLA18/q6jyIQ0bggSeNx/2uj6shnRnzBWFa4KsrRhSSbkI+Y0AE4ZBBuD6kbH3
 rDmvxqUayUgvlAxsZuuURvCJGh33tqrCFjUuPI/1E57V/gThu9n3clRTpKdwxU//4sMW
 KubREnWLrs1w61W3lJrhO5sOlQnNmAXlzVbclMQwbSmq6pdGsYA+XEt/4D7Ohsbnl53+
 QQb0W10EJLibx+PFWsxTmysqk41gxPC8njI/YkcgZioNY+pk450k2KIco//8mHfbuYBT
 sQuPTCKEg/3TWsh0+NV8GH4aX3753QBjMXfSzPqVHP4H21QOZNKI1Ye19QrIWbgEJUSs
 SZig==
X-Gm-Message-State: AOJu0YwD1GHWg1MTYokiq5/sE9hqJmju/fLZIZHyq7SAJBKVyVfAwTPe
 4nsDIyMNj8cHqm/VFz553CYbdl+4y/YpWpSY2bMeGhzRH28LHZOiT2LSDBczmx9kaj7rGzk6paF
 gj6B8WA8yZx/bPwzJaK1ZdrWD3XbEWyvUIS+qjw==
X-Google-Smtp-Source: AGHT+IFCUGdZjjSRDFGcOJHOW1eGthjlT8J/ILX61wxVns6CxTw9WpbdfnzEd5lryz7fz68R7OyUmQ45ytMupBK6oRk=
X-Received: by 2002:a05:6402:1e94:b0:5c5:cbdc:2b2d with SMTP id
 4fb4d7f45d1cf-5c8824ccc48mr3034505a12.1.1727444114159; Fri, 27 Sep 2024
 06:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <PA4PR09MB4864BC65090CB019679B6F9A846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
In-Reply-To: <PA4PR09MB4864BC65090CB019679B6F9A846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 14:35:02 +0100
Message-ID: <CAFEAcA8-=SfT3vV9x7rSvPzQ77mqS=h0j4ymu6pyZgCBbM5mdA@mail.gmail.com>
Subject: Re: [PATCH 4/8] Skip NaN mode check for soft-float
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 27 Sept 2024 at 14:27, Aleksandar Rakic
<aleksandar.rakic@htecgroup.com> wrote:
>
> Skip NaN mode check for soft-float.
>
> Cherry-picked 63492a56485f6b755fccf7ad623f7a189bfc79b6
> from https://github.com/MIPS/gnutools-qemu

Please could you provide proper commit messages that
justify why the change is being made? "We got it from
this other fork" isn't sufficient -- somebody reading the
main QEMU git history should be able to understand the
rationale for a change by looking at the commit message.

thanks
-- PMM

