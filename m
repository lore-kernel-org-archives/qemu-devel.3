Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497AEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 13:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzzAA-0006i7-LO; Thu, 25 Apr 2024 09:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1rzzA2-0006fa-JP
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:29:16 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1rzzA0-0003YD-3J
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:29:14 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7d9c2096c29so42198439f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714051750; x=1714656550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTV95bxchv2rnu3Ms1bpUSXXQa+PFjoRCn8nFU0Je14=;
 b=QI2D+tBzWtzT4ndi9+CdlDCfQSUmCrsPlhnMi2hZlaU4kff5ZKxp8w4GDgJkvjsobC
 9fQnIj0mq4bPUIRkF3NdWTrbIyIeWDx40rSdqAEpaydoe1GKVFWbeCfEgOFM/4EI8rIM
 iGRqL/apubSiXLj7ed8b++5I+yQAjUJ9W+xVAWQCTyC5u6q+DoaEDJGg/jVQtfQeBhlO
 OWiESx/t3USuBsRUYLEvMjIeWW3rRDTebNn6yKGLcIbheVgMQI61BxCKTr0OELrBqjh5
 ZEYXBsOXk+z70Rwz26eMS6pog6qLBWYj0pBXi8iQy+kHyLze7O/oRVKujTxxZEBFL4h8
 VBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714051750; x=1714656550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTV95bxchv2rnu3Ms1bpUSXXQa+PFjoRCn8nFU0Je14=;
 b=Fpg0LOleCtNrrI6x6NjPHKgvIyTFlSu26hXRlYEyhgkwa+M0avwsiVDDNKPROsz7vv
 Sl1awsdoXvII21aOVFK5rqGvoOKJ5/04OzPlLD56hNEIMTXxh+/9VZofBhNBI0E0njYG
 UOLRU9O6mJ5r/xRSkQF5YoKDqabJn7I+fXhOFhVN55FzOjGNrmEEfH3qrerIAodcVcGT
 tzGR89MpzYQfNQj2L3GoKtEjiqI+alX/Da7dtqqeGOdX01qNJ0LqHudLq4Pmq6STs7ov
 7gXfLzRZ5junrTPZllyKhg26CmB23LPAUjnOI+k6OmmvNvGHMbrtuzkNxbMyi/Nqmo1q
 di3g==
X-Gm-Message-State: AOJu0Yyxq1CM848l7DDiofk5WKE88PEtqFx6EgQIMvGF3DLOW60kQPqj
 DVw9R5b275/6SY4McyLGWuaslVH+vtaQwDiwBdz1T6ms94dNvPls8YT6k/Bi0zLHV0WfFiu+qee
 WLy1d/HUsJELZqkwjQgWSSblG8Nc=
X-Google-Smtp-Source: AGHT+IE6JC/o/DKcm0IbUb7JkerZWbo7xfJj4OaN8e9AAo6HW1RlSGV30LQ1Lvq5+gWlXAVyJJ+DZpzYV0Uz8r01Tfs=
X-Received: by 2002:a05:6602:3043:b0:7de:944b:5aa8 with SMTP id
 p3-20020a056602304300b007de944b5aa8mr4500792ioy.2.1714051750632; Thu, 25 Apr
 2024 06:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240425114207.54148-1-vilhelmgyda@gmail.com>
 <CADe4k3+GQGSSbbugg-BK6TNp5cJzLSxBTrS0fL3RCfOtV3wx0Q@mail.gmail.com>
 <ZipWSkApNVq2SyS9@x1n> <ZipXc5njVadiOzCJ@x1n>
In-Reply-To: <ZipXc5njVadiOzCJ@x1n>
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Thu, 25 Apr 2024 18:58:59 +0530
Message-ID: <CADe4k3JLZE0SfAcBpPc5dkMCQ1N3pxxaV_bmttAoUP=44fjGCQ@mail.gmail.com>
Subject: Re: [PATCH] migration/ram.c: API Conversion qemu_mutex_lock(), and
 qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, mjt@tls.msk.ru, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Yes, yes. The list will always be cc'd. I found your email after I had
already sent on the list, so I omitted the list when I sent it to you.
Thanks for the suggestion for further contribution. I am looking at them

On Thu, Apr 25, 2024 at 6:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Apr 25, 2024 at 09:10:34AM -0400, Peter Xu wrote:
> > Hi,
>
> And I just noticed you didn't copy the list, please normally keep copying
> the list in replies.  So before below links, you can also read this first
> just in case you still miss some:
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html
>
> >
> > On Thu, Apr 25, 2024 at 06:08:58PM +0530, Vilhelm Gyda wrote:
> > > Hi, I am new here. This trivial patch is my first contribution. I am
> > > not sure who to cc for the review. Checking qemu/MAINTAINERS you guys
> > > seemed to be most relevant for this patch. I am looking for what to
> > > contribute next, let me know if you guys have any ideas on that.
> > > Thanks
> >
> > Maybe can start with looking at some bugs (see the end of the page belo=
w),
> > or todos listed here that you think you have an idea to move on:
> >
> > https://wiki.qemu.org/ToDo/LiveMigration
> >
> > >
> > > On Thu, Apr 25, 2024 at 5:12=E2=80=AFPM Will Gyda <vilhelmgyda@gmail.=
com> wrote:
> > > >
> > > > migration/ram.c: API Conversion qemu_mutex_lock(),
> > > > and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro
> > > >
> > > > Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
> >
> > The patch looks okay:
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > Thanks,
> >
> > > > ---
> > > >  migration/ram.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index a975c5af16..50df1e9cd2 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -1066,14 +1066,14 @@ static void migration_bitmap_sync(RAMState =
*rs, bool last_stage)
> > > >      trace_migration_bitmap_sync_start();
> > > >      memory_global_dirty_log_sync(last_stage);
> > > >
> > > > -    qemu_mutex_lock(&rs->bitmap_mutex);
> > > > -    WITH_RCU_READ_LOCK_GUARD() {
> > > > -        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > > > -            ramblock_sync_dirty_bitmap(rs, block);
> > > > +    WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
> > > > +        WITH_RCU_READ_LOCK_GUARD() {
> > > > +            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > > > +                ramblock_sync_dirty_bitmap(rs, block);
> > > > +            }
> > > > +            stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes=
_remaining());
> > > >          }
> > > > -        stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_rem=
aining());
> > > >      }
> > > > -    qemu_mutex_unlock(&rs->bitmap_mutex);
> > > >
> > > >      memory_global_after_dirty_log_sync();
> > > >      trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
> > > > --
> > > > 2.25.1
> > > >
> > >
> >
> > --
> > Peter Xu
>
> --
> Peter Xu
>

