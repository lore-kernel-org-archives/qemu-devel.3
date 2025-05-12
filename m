Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FBDC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV5g-00009Q-7F; Mon, 12 May 2025 11:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEV5d-000085-SW
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:29:13 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEV5b-00064F-JX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:29:13 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7082ad1355bso38690847b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747063750; x=1747668550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44XNLlIxFBoAvMqSmevtTi0tPsxuX64qwDKXegiq8IE=;
 b=r4CMRfBp6f4dNyuH6sxV6wyofuwrsgkXT4syjrQ0c8Svc3+0fU0tTroadyZ6EtJhXW
 uqjM+oGp5EruQC7G9ZgeL6lpMWtZG6g0HjfSMrZ2zVZORwbKfU/3RqF6dKkfT/TLTwOl
 Orw++n4D7kt3p0TNmUZG2xTZ6jG2lKzNxGvd6ljk/MPK8+NkmSlpXNpMplbU7YhLWU2G
 lpI6p9wEeD8Z9T4Zci5JYkFfqvbtbOPn+Jfjq9BO9Nfd8bl0G/hue9h5dyXusaaPVvi2
 UWBf0fpNwbVKpUZHYmlse7KXQLkFU/lIniVdTuZItk+G38WIKxZiXnE75HQWxMpdovyr
 7mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747063750; x=1747668550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44XNLlIxFBoAvMqSmevtTi0tPsxuX64qwDKXegiq8IE=;
 b=jf+LrRo0e2sI2a+dgRX1+7Jq/IiU3HEK8fgCDee0HyOJC8o4qZel7+nkOiHwvFLk3z
 wd30M7jguCRD755uENpjJQOzPs7WwKKSh+V7iPqXfr5sNBYUUhB4ihaFOXgFXwyS30bi
 pYaB4987llJPzXteedkankEh/bcUU2P/hCKIL9b47wEEsGn/XpsV96UyfSy3QJ2yt4sn
 +jfHO5RMQyWLp3d8SDKFu5mqrZMEEgrayDwy1WDArNFlUv76bhPO3rmpspaYoMU3xnlQ
 G6sbCMyuRDUn0ZB5pmIBUA1OmIyu8ZLCtp05wJNm4bbP914e6Iidx4SMKLpcliachg38
 Wonw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLbh+M0nUOnQ5Yk/+Zb6ioZ2BmppSAArwmzrko5/9TZ+M9Ne7bNboZcwKhpAdsvgllgHbamaoC+0aX@nongnu.org
X-Gm-Message-State: AOJu0YxUxU6v4eEk3wKUclqpaOIyuAAckTJ7sS8dpFMux3UX5/d/giMR
 qp+nQDmmHbjWk5Ce2S/AiE5A1RD2wKMnXNoyzL/JPMwfJAS929NmavnnhHNT2RvhuQtfkto1C7y
 7dJ0AK5x8SwhW0ZjqUzyEGDsOnvOgjkUG39+U3A==
X-Gm-Gg: ASbGncs0MEniVB8Qk3wlNo85xiAU76KgskAUpO0MQ56m4u4GDkPfPA2WmyhKjNJ4mid
 JelF9TNTiPwUPoj6SenR1jPYAR6LFmLaJGs7PaBfeRrt3Vel9pBVOzPs6HHJyfZst4lFyUXoyHp
 8L2kKe3iWIr3RcLyRbQDA+wA4lIi9oOobmmw==
X-Google-Smtp-Source: AGHT+IEGA5lJR9mR6TP8KGdodwfN1fNJ1/SmVui90fRzS6hkbSJ0q448HbOhujQ9j6hQY902IhtoxuSNDj/78bjUkDk=
X-Received: by 2002:a05:690c:480a:b0:6fe:b88e:4d94 with SMTP id
 00721157ae682-70a3fa411f6mr194578707b3.19.1747063750238; Mon, 12 May 2025
 08:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250228154450.3185564-1-berrange@redhat.com>
 <20250228154450.3185564-2-berrange@redhat.com>
 <CAFEAcA-vd0z_yi3O8EBqaxw2xSZFKmvDj3_npCJ8qjnycLJrcA@mail.gmail.com>
 <18396f87-ef13-4521-a62e-d80d36c3c7dd@kaod.org>
 <1a2786af-ffd4-4f51-ba71-11848fe65898@kaod.org>
In-Reply-To: <1a2786af-ffd4-4f51-ba71-11848fe65898@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 16:28:59 +0100
X-Gm-Features: AX0GCFtc27pnmuaPOozN6caWozV5pFWJrryRtjLMG8ByjQpgrY5tEHUXG_daggs
Message-ID: <CAFEAcA9h0Z_+hc_3zLnFMzOPY4mD4gmGC3YzxbmN1nSJ7_=OOw@mail.gmail.com>
Subject: Re: [PULL 1/3] scripts: mandate that new files have
 SPDX-License-Identifier
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 12 May 2025 at 16:18, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 5/12/25 15:52, C=C3=A9dric Le Goater wrote:
> > On 5/8/25 12:42, Peter Maydell wrote:
> >> The logic goes:
> >>   * when we see a "new file" line, we set expect_spdx to 1
> >>   * when we see an SPDX tag we set expect_spdx to 0
> >>   * at a later point, if we still have expect_spdx 1 we complain
> >>
> >> The problem is that the "later point" here is "we saw another
> >> 'new file' line", not "we got to the end of all the parts of
> >> the patch that touch this file". So if the patch adds two
> >> new files then we'll warn for the first one (when we see the
> >> "new file" line for the secand new file), but we won't warn
> >> for a patch which adds only one new file (there's never a second
> >> "new file" line) or for the last new file added in a patch
> >> that adds multiple files.
> >>
> >> I'm not sure where the "complain if expect_spdx is 1" check
> >> should go, but I don't think it should be here...
> >
> > yes. I just made the same observation on this patch :
> >
> >     https://lore.kernel.org/qemu-devel/20250509163645.33050-7-rreyes@li=
nux.ibm.com/
> >
>
> This seems to work well enough.

Dan sent out a patchset that overhauls the spdx detection
logic last week ("
scripts/checkpatch: fix
SPDX-License-Identifier
detection"):
https://www.mail-archive.com/qemu-devel@nongnu.org/msg1113638.html

(Unfortunately lore.kernel.org seems to be missing it,
and patchew was unsubscribed to qemu-devel emails over the
weekend so it doesn't have it either.)

thanks
-- PMM

