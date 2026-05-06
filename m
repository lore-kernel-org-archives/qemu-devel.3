Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098AFCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKeZF-0008Mg-HW; Wed, 06 May 2026 11:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wKeZ7-0008M9-VQ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:53:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wKeZ5-0004Zk-6h
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:53:37 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso7588178a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778082813; cv=none;
 d=google.com; s=arc-20240605;
 b=RLh+5IC5ZO4x0vh03P+CgOJuqnyHsdcTINMiZWGwnsEuA59i+XlEKJ28cGjp6F7krU
 pT0OkdZUdDD7Ba7sogvVyTo8EFqcroomtNPAGZt/Td04YnkEKioJac0GN+x/PqKvTNe3
 yWXAnGOehAUrKWqn8BP8QjYfVSBe2+HX3rZsyWu8sX4ye48h9UPXzrOJTCUe9ewalfxq
 JqyHhTQPGHkNLWunVUlpR/6AbFSEH0n9Mkpfqo7S/oa9hoPEx8xwQeuIgF+uQDxVFH2I
 2tQSo330hMWLihiFe3Z02N0ubTIoRIb/aK9t9vlKUmSBLUz5xVBYi5ghj8NyfLlo7ZGe
 O2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qqanVaOdF2ksl+Gw3q9FpC5+PTIq3WwErd5uymgqOnc=;
 fh=4X2Qtrw6+62I2AHJKmuDuQmMR8U8kKja2fWELBWHSko=;
 b=SYyZITSVA4Zb/e1iTbkWX6+0GfNsZEfQsA3avbnU4Rv6yLsdp4J8AsmAO8aXrxqHPd
 qFA65ayXzReXFuMwF9Wgz+7Bk/q6du8wOsWcXTOM6nFzsdPUlkFtRlpvfYY53tO6xF0K
 HXkBwpgHXBW8PCBbsbX1SCgGV9eDpAqbffL/7HAnoyx9FzgnwtgDP9mvYQRgUikddyJ4
 X0ZLGyFWeXYLYVmUqYVgpsRPFnRKX05W753ALN0Po2oIUUJwK3pepnQb11D4nOBKqgVH
 Hq8ylzGI1d8a5RQgHIxeEE4JElutZNm/4Lko59Z4NpMImJAMflz3hRpytq2zdXAeZxbo
 Vb4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778082813; x=1778687613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqanVaOdF2ksl+Gw3q9FpC5+PTIq3WwErd5uymgqOnc=;
 b=LFqUmtYZAsXqkfQf8IPzHjjBtGY5MX3YLqoODlftYC1ag4S7TyPb7vPSy7GDVGN4Nq
 XCMYi7FD3S+h6G0SqU6cg4Uwuw2YnhsdYqZOBDFQ5PuEuZNZzqDoLY9GqMkU9APvFpkx
 n3gWonxtLf2ccpZOdZ3H8CXdDYDdauzSlVfZem3LxBHPGDdgpNTGJ0g4VlGlioPRsbML
 B4kfMgJE53xTeo+hDpUJCRGiycti75ha2LIQPeFVTz/U8qGD4n8K7pHs8Uf2nWDm/VLv
 jHr1mM927BOjXDw8SupJavqx7Z+kZQ/zAFEaJCCDtak4Dmoi0APHiAgXG65tUwYY3Mn4
 /awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082813; x=1778687613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qqanVaOdF2ksl+Gw3q9FpC5+PTIq3WwErd5uymgqOnc=;
 b=IE0APFEDWeYi5uiMGvBdDaL1StB+18PQmPfO+Ataa4YjIeVVii8M555ldwphgjk2EG
 GhipRoH0VjLVlKGrzHwfRhddRRSJV9cbfMEyfLP27ib0PK7ozIWI95lK4TXtDuDexOfM
 uBgx2r9lwPQekojjwylmmPcm8kMbLsAiVbElsoZGIqjUvdzTGJAyoaO+ttvIamEUJ/cH
 iHyMk8f7TfWVVcdCDIFQ99GaA0j4o5RI71DeevjNskJzvY8ghnVof+FKV3qzDbqtikW2
 J3ZgYcInXmK+dy8G6HaQ0Q3WOHSO+lk6VTAvy5vEUsSXrSdcUCaCcqy6rKz/SNcWW+sg
 oYMg==
X-Gm-Message-State: AOJu0YzwthVZShsMC01Q3Q4irEBst4n0ViYEtTcPjkiIG/uHO5leqZ/3
 +IuR8SjSTi4SpN3uVljrLBoRRu/6qQZuOY0iJaEnBF1T2wygUm2MJwQ2zLv6ZnhA8qTSn8tchjd
 HHdf8bmMypwNHNRhUCyKIlSAB2rzgEI4cZaYVlYI=
X-Gm-Gg: AeBDietg5TZniY1YsWaHpzfMeQvlbBfrHIdyFdTx6Rmy6rW+PB0rB4SFHbr/pqbEQm9
 +STJOhq1EXqq+Dtd1z7PQaQo16+cLqYVIBgi6S8q9/bHoNfiKsV8K9fDw17ZhS2hNDxO1RX9kAX
 l8pC0pzkJmZk/iysavRocCGldbo/NPvm0MXgkzWPzLWkwSbhkS8bsuAYioqexCgNAYUkjxc+HgM
 ZjrFTVZOzoHK0X66pUar5arUhp/5LtGHxHZu1Wt3y9sY8D2cHZO0g5lPdQubb+hK2rKeis4Q4al
 SXEzdVL2mRRHDDomPvM=
X-Received: by 2002:a17:906:518c:10b0:ba2:5226:95f8 with SMTP id
 a640c23a62f3a-bc56c729011mr188026266b.23.1778082346357; Wed, 06 May 2026
 08:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
 <20260506164252.464bd83a@penguin>
In-Reply-To: <20260506164252.464bd83a@penguin>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 6 May 2026 23:44:52 +0800
X-Gm-Features: AVHnY4IbIHAH4qQAGKwHiUfQce7BQpTm__6gxwW9nZqhiCyJUQYu4octh86J-Kg
Message-ID: <CAK3tnvJoc6zF+OV-gy_CDYcwk5GOVyRnC7Vi+_XF72q8_hGtww@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 6, 2026 at 10:43=E2=80=AFPM Lukas Straub <lukasstraub2@web.de> =
wrote:
>
> On Sat, 25 Apr 2026 16:08:21 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>
> > I recently took up maintainership for the orphaned COLO migraion compon=
ent.
> > Here I take over maintainership for replication which is another import=
ant
> > component for COLO.
> >
> > To: qemu-devel@nongnu.org
> > Cc: qemu-block@nongnu.org
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Hanna Reitz <hreitz@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Zhang Chen <zhangckid@gmail.com>
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> > Lukas Straub (2):
> >       MAINTAINERS: Add myself as maintainer for replication
> >       MAINTAINERS: Rename Replication -> COLO block replication
> >
> >  MAINTAINERS | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 4bde339ecb41b16e90810233ba5ee2fa87bd443f
> > change-id: 20260425-replication_maintainer-c5f63ac49ae6
> >
> > Best regards,
>
> Ping.

Block replication is no news for a long time, glad to see this.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

