Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1FFE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 18:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSKTI-0002hK-99; Mon, 30 Dec 2024 13:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tSKTF-0002gI-Lf
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 13:26:29 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tSKTD-0004BW-O8
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 13:26:29 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4aff04f17c7so5946289137.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735583186; x=1736187986; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulB+2xUbqetePv9GGwD+m8MdneFMFrHPqEhJ8vFyky4=;
 b=jIofzKmlJ683PI6bqxxE2Yk0qtzpXjHBOpDgR4YGgM36cL9abl+WM3x+tqoR1XuKMo
 bQU0MJtQcoXmmgHnuu7rlbGeZC9KClavFWV/71lJoq22JLxqL3bdAaTngFz2t2TF8doB
 zs7qlVWR3zz8j8vrcxatVBbSawa/F3IQhkGW3jjKFB2ejdx2/aJgkPZaHACdITrK3CxO
 vWKvNZ7kyMc0ECqeMgpp222ryK8lBfv7jdOpZtPgSIYI4Bt+vE4WIRpvNXhiHyaQKlMQ
 qvdoL4brml8Xa3m7OH5Am0Wm3s87VEbG3OlN3a1xVnTwn+0epdOaiQgx+5XU6QmfW/id
 2iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735583186; x=1736187986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulB+2xUbqetePv9GGwD+m8MdneFMFrHPqEhJ8vFyky4=;
 b=sPrcIyXIE1VXWuZnoe2z/SdEpXwoITYDFoQDbH8tozkmm21+X/E9San+ELdYue/J7d
 utUi24Y/t04ILl8ulYE/oXJQBLFtwUk+aO6qeccnm2XhOANehI2kWlTB5uWzz5QQgDil
 j8K0jBdgiXjdNbNoXpOBmpk60JjOgSekKj9gjKpv5VTR44/sdjMgsn6N10CLoamswbnY
 st+2qhWurWVwF+RaRTIS4eXrkGJswOGCfBf+Wa6oGDZBzbczwE3OtrjAyiWo8vIC3Gz9
 bIXlguosYp3JaFSYSA6CqC6oE3ECkgwJlTh0Kqy2x0K3AMMVSc1q4FYubNpQZBtoqMqt
 8BEw==
X-Gm-Message-State: AOJu0YyBIItlnm29QmBLo+0FWCaifvxZ1UwCdB+9GwQun082d/w6pbbM
 Ic7fz6r2q2iv5zTeIXHNQd+I/odJANgKXpyS34nuqXwCCY29gIunBl63f8PweRy4jWON9M0zDRd
 Bj+l83WNvXG41glDxRvK2Eq4GvEA=
X-Gm-Gg: ASbGncutjfJuacseIdLmpEXXbkrZInGiY0T0OJoKmTatmeHeEYQ+AWz0/UbS2fRLTQv
 yPMY4A9YetKmqGxVXlQcgnnTpVNvSV+n0tdruroEK
X-Google-Smtp-Source: AGHT+IFXO86EcZ6J+PTpJQtZ7ebM9GDAKwUw8Asl5y5RKY1vGFZYah3M1BKQg8CHv243pYM4GMRYywXOJJEgVVfUtIo=
X-Received: by 2002:a05:6102:3e84:b0:4af:d48d:5142 with SMTP id
 ada2fe7eead31-4b2bbf935e4mr34188128137.3.1735583186101; Mon, 30 Dec 2024
 10:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20241211222512.95660-1-graf@amazon.com>
 <CAFfO_h6iv=_dae_CdhB9Ggi-Q1ETREQROn22-p6vMN=g=DjrKA@mail.gmail.com>
In-Reply-To: <CAFfO_h6iv=_dae_CdhB9Ggi-Q1ETREQROn22-p6vMN=g=DjrKA@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 31 Dec 2024 00:26:42 +0600
Message-ID: <CAFfO_h4iocyfTPZ_vtGU=ny=pw4hCapP8wQHB3ZoDVE=rAsi5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe35.google.com
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

On Thu, Dec 12, 2024 at 8:14=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> On Thu, Dec 12, 2024 at 4:25=E2=80=AFAM Alexander Graf <graf@amazon.com> =
wrote:
> >
> > The documentation says that Nitro Enclaves are based on Firecracker. AW=
S
> > has never made that statement.
> >
> > This patch nudges the wording to instead say it "looks like a
> > Firecracker microvm".
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > ---
> >  docs/system/i386/nitro-enclave.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
> cc Paolo. This can be picked up for merging along with the 3 other
> nitro-enclave related patches from me.
>

Ping.

It's been a while and this one is just a documentation change, so can
be picked up for merging. Thanks!

Regards,
Dorjoy

