Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52235D31761
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MKc-0002Cw-67; Tue, 05 Nov 2024 11:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8MKV-0002CY-PU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:22:55 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8MKT-0001bW-Rh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:22:55 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e600add5dcso2616494b6e.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730823772; x=1731428572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QtqsxmQ/iB9fLdvTciWAB6nYPWVdRwnELFFf3uQeW4=;
 b=mZiWJd1V6hHeah4r+5ICRGD8qrMe2OoJZbsh0MpnR21h9es541UhwdWKnkBsM2ycb+
 kjgWkmPoctAuf5qtSOdjpOq53UbO1dm0sJE7EemTMo6I8Golme2FPlmS9fWeMvjvYYTE
 BaZuXLCUKtp6owBntuB425xSALih0Xh3yBxsA8mwXrI8UhisHNu9NGslbjdsKE2lHue0
 E83I7pvFybcFZMtwbO/ZMmrpngHoBwsDIiJLcwEWEagif7GPb35e6+4zKxdeCpKAPIhQ
 B1iypx67ugLOkAEGQbNOfJS+gDg7le0PVkipfhvV02KB95xjRVH07df9HdbRYPmcUXcs
 im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730823772; x=1731428572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QtqsxmQ/iB9fLdvTciWAB6nYPWVdRwnELFFf3uQeW4=;
 b=VSuCXadvcEgfVB7MPSwIG2YqmvLA1fRVZrAEtn1hEYSvwmmESCfBIIVPwBwrwI5p7m
 rEq0RwEy1vqSVb9FPs917XmsWEVzmPVbH6lfiNZ02MHLYhO4fWOhYy0XAzgjY6y7ODDi
 CydlguEZk7Aa8WrPi79l3WWkTeepjlVNNpYifXp/lC7tjGIs4eAHdXdxvIJ1MuOzoBiP
 xNTQF0MNQzJh8+dS4EpZqbmrzTTy97ZoXkcyCNGslcPMI2fHOVBoqqzJ1gCu35rNPbMH
 XvGmshsVxl9qucOlHEP3bUsnLbQmVOpZd+3rQFXTA4rfAmtXkotwHVFaBml615Ls+Fs5
 /KWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0OnzWf7KlmNQql/5vZ0qyMl0cXG3oWJDepX8IMa9ffma0Oh/y4wZ8JUByW2nYIwDBiSpWzaI4oc7N@nongnu.org
X-Gm-Message-State: AOJu0YzauinQkZIpc9rKUq7H5g3pyEZipt3GZVwrLD/N1nkTY9c8QKJJ
 NNWVeJXIGUutqv+2QJCbuDG+0WDV2YOq2tbFXX0C0xhQjYzCCGmW9MYOQy9gUubgO01fO9hYNot
 efdQbuFgcAEJTDBr8rL6YthJkAPY=
X-Google-Smtp-Source: AGHT+IFrGWHIk0fpv20FeOvMtSiGGEi/0VyZE5SoJBkW9TUHPxgdh64KXaOExF7GTtpz2g3DtcogsBgLep36GasM9lQ=
X-Received: by 2002:a05:6359:270a:b0:1c3:7bd1:d39b with SMTP id
 e5c5f4694b2df-1c5f9a4aaf1mr779346155d.26.1730823771902; Tue, 05 Nov 2024
 08:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-24-pbonzini@redhat.com>
 <CAFEAcA_mJtsuqSOnDfBLuX+cTuAmDHksRhGA3jq=5tUS5RKn4A@mail.gmail.com>
 <CABgObfbYzNMQDmEwYpXBgsUJ2V+br5QMHh4B9vWSdFxxg6wvNA@mail.gmail.com>
 <CAFfO_h4kkpJXaM5if01jWPGXdmdveE9VPNhxU=j_OVF3bu_LhA@mail.gmail.com>
 <4d1b7a92-dd01-42ca-9342-5c845d8b67da@amazon.com>
In-Reply-To: <4d1b7a92-dd01-42ca-9342-5c845d8b67da@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 5 Nov 2024 22:22:53 +0600
Message-ID: <CAFfO_h5qGOcxY=BvxO5C7ZMPw6YTBeNHL6SAOtxgy-PY=NYTvA@mail.gmail.com>
Subject: Re: [PULL 23/49] hw/core: Add Enclave Image Format (EIF) related
 helpers
To: Alexander Graf <graf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Alex,

On Tue, Nov 5, 2024 at 9:37=E2=80=AFPM Alexander Graf <graf@amazon.com> wro=
te:
>
> Hi Dorjoy,
>
>
> On 05.11.24 14:56, Dorjoy Chowdhury wrote:
> > On Tue, Nov 5, 2024 at 6:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >> On Tue, Nov 5, 2024 at 12:44=E2=80=AFPM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
> >>> Hi; Coverity raises a couple of potential issues with the
> >>> read_eif_file() function in this commit, which are both
> >>> "Coverity assumes the file we're reading is untrusted and is
> >>> unsure that we're correctly sanitizing data from it before use".
> >>> Could somebody who understands the use case here check whether
> >>> these need addressing?
> >> Both are reasonable to fix, even if the use case would not make them
> >> security sensitive. I'll prepare and send a patch.
> >>
> > Agree that it makes sense to fix. Thanks Paolo for looking into it. I
> > can review when the patch is ready.
> >
> > BTW I see there is some formatting issue in the documentation of
> > nitro-enclave in the QEMU website:
> > https://www.qemu.org/docs/master/system/i386/nitro-enclave.html
> > I think it's a simple fix where we need to put two colons (::) in a
> > line before the QEMU commands lines. Maybe it would make sense to
> > include it in the patches as well.
>
>
> Feel free to just send a patch to fix them on top of Paolo's pull
> request to the mailing list :).
>

Yes, I can do that too with a patch on top of the master branch.

Regards,
Dorjoy

