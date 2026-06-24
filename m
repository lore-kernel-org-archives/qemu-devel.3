Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A19CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHbV-0002P5-N9; Wed, 24 Jun 2026 03:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wcHb2-0002O6-OP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:00:32 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wcHb1-0007dP-3H
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:00:28 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-396775c26e0so4996201fa.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284424; cv=none;
 d=google.com; s=arc-20240605;
 b=Cnzzf7948Tv/Qc2gOBWA7COdI/SwHhWKyQavzJzbLaXDbAQyako5ZoYggEkJw/1fqC
 qVM0/Pv53PtQMs1vv2xlxTAYuJOUct58GR86Qv6CiW/Sf9WLXsDlObWQetBk4aTa1cuc
 TnLCaiEpRKKan+4QmB4LN4iGVWFrVRJFFCjHFyI8drLlfC/yOkvm3uE+QfRpVh3EaNYw
 RMSmovxDbmU05HxZiQoa8Mvtf9BmyLtQuBh9Ihq7k4pRiuH0zuwEdT0MPyBRZ3p7GqYm
 ldNABrHStmTdgaQBNNWojqnpWC3Qo+G+HHh0zOJlMZeTTSmnoH5Wz2CbedlbJ5nKGD0z
 A5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SOMNCpBj2/OB3fkY3Fi14HpqYh7ZZNk+9OdN2fYxJD8=;
 fh=NT0kq7NgLJ0wOp/qMyvn1NIPXsDSAQYGUZFkUZ2OApE=;
 b=ilXNv0lRQ6khh46wC+ELtGI6uIbNeH+nLhUMdnBtK1ZB66crkmCwQCckkTddvoEFPq
 S/yIQtszwR0dMDlNvoLf1IvOiURvEP9BnykEbCTcQM6Qxjv8yZOAwwCWONSeF4JRjTRW
 c1d7uYQ/gRxhRJB9Wq+FitWyVtEc80IqPYj6gUa31eMwbj4XtlQ1P0NbLy+UZrpZ+SNQ
 c7WahEWfA1LBRlLmrAnAnvgzMALE022cvvadlwAvEFaozpK9MtmmNFu7iQFkgAy8qkCb
 ZPeYPBQn4AOXTqg7sqDpoKZ95ENRU5NT4XiGHZJl4OzLG8KsXmBwe4l1/p0NQTfZxhMM
 hF8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284424; x=1782889224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOMNCpBj2/OB3fkY3Fi14HpqYh7ZZNk+9OdN2fYxJD8=;
 b=N3a5beGXd4jyY0l/vuu+uRLQyoekmn5FzuoFVNv6WSkY2JQJq3sTh4KR8ugqm5gEB6
 F9nYbfbe+CgW47AreFtR0wnJmvggO6go9e2AItzOzkYA3yrr9xb3W4QD4gfgyW8dXod/
 CplZHJNTSpfiUalCernBt484dsJJXx5Jxj5Qd/J3yT9ZFPLyccMykQLS0UWauMgFmBNx
 /2HbUQJIheyCtH24tKbHY7Om+OZpCnNriNBYnZdmheWQlCnI/PMcLjivXYSGew5hR1y9
 ejMN9fbP7mc1UDm2sD/FXuRP9EFjlCgoUh28ATmms0hWgq4OusoG+wGfHJnjNv1dRPN1
 IIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284424; x=1782889224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SOMNCpBj2/OB3fkY3Fi14HpqYh7ZZNk+9OdN2fYxJD8=;
 b=iX+l/SqE1dL+DGMLVUmQyyoiXFrwqpmP+KB+WMKP5EmVHnNGOrql5KUHBs2HPYjQEC
 kO4j7AxRimYLHg7jlh7RdKUWKaZk4ew90774hDXZpUtyj6GCb4quzkRkqiRWEMm/h2ay
 6u0qL6BjCBEa7TEJmTJRMV/y0uk8erzuReLKxV9txkVml5mdlZxQmd/tWDjAWSnTTRMC
 VkNH+HNkZdNvfZOOR1hceVc4stt5qqfFPyzGmLy44r0riKbUg589J3Z5s/qcheHIE7tf
 jVXgYOtsm34UEz4qJDgU/WsstAHh+ydmE2vrrkV2uL6RFlYN2zDhLI6NK3hscGTOwaMB
 ypqQ==
X-Gm-Message-State: AOJu0YxmTNN7gYlzdm1DBQBu9o2EPHSrfjrgkHgsN1910LuW4Vvi26nK
 ZlXEyNvkFzdASUreNAbE1Fx8y+aPIV6nKqdZaN9xUxoCX4/UFMmZuzp0yTun1OUJTij2A3bcK72
 rGfdILeSPJnZvcN7ssmqqsemS2qJ9sOA=
X-Gm-Gg: AfdE7ckulKba9U8j63yWSdpexweWDssdb2/N8zCfHThQ/ZWdEf5s6Y/sJprRD2gZuG6
 xEgGUiV0L+HnitmRDSk8AyrqxFqHdMzcp/czqrVhhnaHnn8tu1s3OBBAvXuvXYTPba1qOODPiVQ
 FY2FWU/my4dK6A4w2kPZ4kgiXSKDO8sKFeKaa2LjEgfXW1zBQkFKOIS3qbjks/6TrdKQyCLUkUm
 zXrTQ7YUJO8QECNAubtqcS/Qc9HuZTVxN6/Ue+ps7MzBfnmQFjeUKh1Tp2uilRKlIJ6EU57w9kk
 NZq2CvJ5o3cM6oYMRwA+4P3k5bT7EZa4d8NAQmCXyzrPbGAWV4fRxxJjC4cAm9MTinBcLQc=
X-Received: by 2002:a05:651c:1994:b0:399:83a4:4f0c with SMTP id
 38308e7fff4ca-39a27e24d94mr14792091fa.20.1782284423204; Wed, 24 Jun 2026
 00:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <CA++cPvLSxOLmLDpq4AwYndT1jvu6j17YQLxUexLX1MkxMtCznw@mail.gmail.com>
 <ajmKyRQtzOl7rCIM@x1.local>
In-Reply-To: <ajmKyRQtzOl7rCIM@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 24 Jun 2026 12:30:10 +0530
X-Gm-Features: AVVi8CdkjS55qcb836yL5WpbSZEYFWZvRFtGFq_e7WJHRWpPUsxw29y_ZJ3xLa8
Message-ID: <CA++cPv+PTr50FmcmwKgb8_U4j12f_u_Dets=LifSNL3m9X7XXA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] migration: fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x230.google.com
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

Hi Peter,

Thank you for the detailed review of the RFC.
I agree with the feedback across the series. For v2, I will:
- Squash the blocktime patch directly into Patch 4 as you suggested.
- Apply the QEMU styling fixes (reverse christmas tree,
g_clear_pointer, macro braces).
- Replace the g_assert() calls with standard Error errp propagation to
gracefully handle disk read failures.
- Move the capability conflict test removal to Patch 1.
I have one architectural clarification regarding the bitmap usage on
Patch 1, which I will reply to inline on that specific thread. I will
get to work on v2.

Thank you,
Aadeshveer Singh

On Tue, Jun 23, 2026 at 12:49=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Fri, Jun 19, 2026 at 06:48:57PM +0530, Aadeshveer Singh wrote:
> > From 70ab2949ef99968c2fc16e6a0d9860a993514367 Mon Sep 17 00:00:00 2001
> > From: Aadeshveer Singh <aadeshveer07@gmail.com>
> > Date: Fri, 19 Jun 2026 18:12:36 +0530
> > Subject: [PATCH] migration: postcopy-blocktime support for fast snapsho=
t load
> >
> > Add postcopy-blocktime support to fast snapshot load by calling
> > mark_postcopy_blocktime_begin(), on all page faults intercepted by faul=
t
> > thread.
> >
> > There is no need to call mark_postcopy_blocktime_end(), as
> > postcopy_mapped_ram_load_page() calls postcopy_place_page() and
> > postcopy_place_page_zero() which call the end marking internally.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/postcopy-ram.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 0ee294a381..2f4698fbed 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1436,6 +1436,12 @@ static void *postcopy_ram_fault_thread(void *opa=
que)
> >                                                  msg.arg.pagefault.feat=
.ptid);
> >
> >              if (migrate_fast_snapshot_load()) {
> > +                WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex)
> > +                {
> > +                    mark_postcopy_blocktime_begin(msg.arg.pagefault.ad=
dress,
> > +                                                  msg.arg.pagefault.fe=
at.ptid,
> > +                                                  rb);
> > +                }
> >                  if (postcopy_mapped_ram_load_page(
> >                          mis, rb, rb_offset, msg.arg.pagefault.address,=
 1)) {
> >                      break;
>
> Let's squash this directly to your core patch 4, then mention it in the
> commit log.
>
> Even if I left quite some comments, most of them are small nitpicks. It's
> good to know there're only a few postcopy functions need some touch, and
> most logics can be reused.
>
> The RFC series looks a great start, thank you!
>
> --
> Peter Xu
>

