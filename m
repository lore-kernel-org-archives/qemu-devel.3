Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B02E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 17:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCxX-0002hG-Px; Tue, 07 Jan 2025 12:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tVCxV-0002dA-5I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 12:01:37 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tVCxT-0007VC-Jq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 12:01:36 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5447fae695so12218959276.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736269294; x=1736874094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NrjLREHgSPizsm/C2hzQsXqvkzcsQy+yMHkCrGc5k4=;
 b=cws86ZhRzXiYajS31T8ZDHkUiIskas/iq1m/Kgo57atIXOxYhm4Icn5HsTMXhBuZi1
 mgs5bP8bW6Txg85pZKM5Vq7qSGyQvUhO8BpAP303raUNTxL/YsB+Z44d7Fcgc//cQ5Wo
 HrZyhS+eTLgD+jjqBJuSvw0TjCkawpW9HsXtfp7uCVemxSnSim2EHEeWHjpyLlJ46sD2
 x9usfu2HkrkdYYTxelZXraI4EbdxsiwFCjYSEkf+92IMuz3dPq8DaHsE4D5Io2f+R91T
 WmjyIMfZo1WpQf+uuYt77gHq78ZhysXuatJnujs6UzUYWsgbhenG/k/kjPdl1ZGovjRS
 mMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736269294; x=1736874094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NrjLREHgSPizsm/C2hzQsXqvkzcsQy+yMHkCrGc5k4=;
 b=eTtGK8Cn6O0SFwFZ7j3h/9JItg3YmpFRY8ElJloBEtMsfBh+g27fw2zsJ0ppieJDEK
 rYyCx2sKo1EK7EH4T8nVaF6JFrxtMRdsUPSd1zx1E7d8OpOtr1jlnqZoKrCzOJa19CY1
 I8s0Vx3qkBhchJUmAath5so+eeTuSKjGLxL2HcdF72E65L/HJOfyAfqgI/GJJbvX8njv
 CeD7+gHnyxI33Lg3ubiFr3r4Ye7IEWaF0BvJOQ/VfATr5+KmlSlX4CIBsvsRB+4W9ARm
 dtc5mUrPUfKOqXdC5v14HqqbhT5W15t6SSH7kQFvoDbvs1aQdi53P23ar02uJzBBz6FH
 w95Q==
X-Gm-Message-State: AOJu0Yx7cKQ0fsbF9RgwpU7R11wyPQoHJYV3J/hAQwSa7opCGtYBssPZ
 GZrjjhejvUgKekY2Wxivd34THe6nufhQhyfklEOtESafJi5iXnq71cUIHLpguKKX8aS5iIb/cDV
 BOCEY/o9kYJdVJa2I/9zKoSX/bnA=
X-Gm-Gg: ASbGnctrBcg6Gdv1IVtYLbYmo2HxHMjgCh86meBn+QrlS7Mo54P4OKD5GYWsEIp387p
 l1MukUyld5BbYQAzdosxCcsgR1P4areCGcYbVGFSt
X-Google-Smtp-Source: AGHT+IGHk4b8JnqQMRuiTzbZVOT045WTX3+7yYkqKhCjPSZdk1Y6eqWYNTIylOBhF0yjKKAfnYXV+Sg2Py643e/1pbA=
X-Received: by 2002:a05:690c:700a:b0:6ee:a70c:8727 with SMTP id
 00721157ae682-6f3f822e5c5mr459629797b3.41.1736269293705; Tue, 07 Jan 2025
 09:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20241211222512.95660-1-graf@amazon.com>
 <CAFfO_h6iv=_dae_CdhB9Ggi-Q1ETREQROn22-p6vMN=g=DjrKA@mail.gmail.com>
 <CAFfO_h4iocyfTPZ_vtGU=ny=pw4hCapP8wQHB3ZoDVE=rAsi5A@mail.gmail.com>
In-Reply-To: <CAFfO_h4iocyfTPZ_vtGU=ny=pw4hCapP8wQHB3ZoDVE=rAsi5A@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 7 Jan 2025 23:01:51 +0600
X-Gm-Features: AbW1kva1hWPJj1INELqMdo9A3ju2cYRoPhIE2Hz4NEY-sqXDgeTuJdfhdx7iX4Q
Message-ID: <CAFfO_h60R79YgTWjZi6hvd4-xMh=qTgsZey5xqr9bzv8u=MyCQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=dorjoychy111@gmail.com; helo=mail-yb1-xb35.google.com
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

On Tue, Dec 31, 2024 at 12:26=E2=80=AFAM Dorjoy Chowdhury
<dorjoychy111@gmail.com> wrote:
>
> On Thu, Dec 12, 2024 at 8:14=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gm=
ail.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 4:25=E2=80=AFAM Alexander Graf <graf@amazon.com=
> wrote:
> > >
> > > The documentation says that Nitro Enclaves are based on Firecracker. =
AWS
> > > has never made that statement.
> > >
> > > This patch nudges the wording to instead say it "looks like a
> > > Firecracker microvm".
> > >
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > ---
> > >  docs/system/i386/nitro-enclave.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >
> > cc Paolo. This can be picked up for merging along with the 3 other
> > nitro-enclave related patches from me.
> >
>
> Ping.
>
> It's been a while and this one is just a documentation change, so can
> be picked up for merging. Thanks!
>

Ping.

This one can be picked up for merging.

Regards,
Dorjoy

