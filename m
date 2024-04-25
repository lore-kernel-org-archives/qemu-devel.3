Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BD7C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 13:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzyww-0001M7-PK; Thu, 25 Apr 2024 09:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzywt-0001LJ-VL
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzyws-0005ip-53
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714050935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbuUPyRdOe+e1ksvPxBxazf8fNvUc0vVtBOyeSFEDMY=;
 b=HYezwReJLmR5c67z8p7wqQwR9JAXz8LaSZdXakurc1lIn5A+NzvzfefRpbW59tUPxB8tXb
 Q+agrPzWH2ojsU2d7N733Eki2ujycJYeu3vy1SwcxhtjbxsXkCmkCTSb9obaTUtUS3m+uS
 toYP1FKW0faXWc8vGHxW+CxIbYlLZNs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-_41qWbsANjSCgi6cEYTXwA-1; Thu, 25 Apr 2024 09:15:34 -0400
X-MC-Unique: _41qWbsANjSCgi6cEYTXwA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-437972269edso1881101cf.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 06:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714050933; x=1714655733;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbuUPyRdOe+e1ksvPxBxazf8fNvUc0vVtBOyeSFEDMY=;
 b=k2IwLM6IJmxiMm9WSoUvw8bhBG8U8yegCSCv8kFE/ae3jgbw+fbJc1O5tvWmQVtXwA
 jmpdYfv7FBIXryPoVeIr2ujB8A/sRtuSV9SgOmgRqTuo7VMXSgZ+GBXWRhgMg1krhajj
 i/nCfNU3XwxjRm6KpcjGrV6CrjH0EpXezIoXz/ubjeXYLvntv+36OmV8UQ484cUP47HJ
 yVzUEvm2OkknZ5k9sCFMDUc8ZS0z3fsB1dNrB0Kly0NJnBoBylgvwtYXXD0LVIq6cqMK
 AI4pb2k50atFVRCdFlGVMJfS/72j1gRxmMldrPKTmjOk15EDeH21atgEuXSeK+zhlHu3
 aEOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdDHR0Xy0U/PAHGr35IrW9TnBavFQZU+Sbo61EFrM8yUyDa2xI/Xs4Z0rEQxcnCBGefSVfFZJ632l8jUF7CgpFsXjOfT0=
X-Gm-Message-State: AOJu0YzSAOEEeQZ1tWgsgHkw+tNKUwy2RturNkIqUjNtnwjUFDsY4IZA
 ffDG7sI7SzI2oaDjav1awVWv+8qaW7XrBq7YrZoiirpMScEUWSXh0EAuueHSan1stEoGIPW7IzE
 Y9XnbI2wAkCD8f2to6BgHfk1JE+iXNTSd7IQLrlabk/4tHggFx2FR
X-Received: by 2002:a05:620a:b83:b0:790:8c20:e281 with SMTP id
 k3-20020a05620a0b8300b007908c20e281mr4665939qkh.4.1714050933338; 
 Thu, 25 Apr 2024 06:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkN8acxD0Bt79AItYDddaxoXTQUsztc/r1/Qem8w5Fah7p1sjlLFiMJlI5PJwEtFO+KGEj/g==
X-Received: by 2002:a05:620a:b83:b0:790:8c20:e281 with SMTP id
 k3-20020a05620a0b8300b007908c20e281mr4665910qkh.4.1714050932860; 
 Thu, 25 Apr 2024 06:15:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b0078f1bd4f7efsm5882018qki.26.2024.04.25.06.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 06:15:32 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:15:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Vilhelm Gyda <vilhelmgyda@gmail.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de, mjt@tls.msk.ru, laurent@vivier.eu
Subject: Re: [PATCH] migration/ram.c: API Conversion qemu_mutex_lock(), and
 qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro
Message-ID: <ZipXc5njVadiOzCJ@x1n>
References: <20240425114207.54148-1-vilhelmgyda@gmail.com>
 <CADe4k3+GQGSSbbugg-BK6TNp5cJzLSxBTrS0fL3RCfOtV3wx0Q@mail.gmail.com>
 <ZipWSkApNVq2SyS9@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZipWSkApNVq2SyS9@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 25, 2024 at 09:10:34AM -0400, Peter Xu wrote:
> Hi,

And I just noticed you didn't copy the list, please normally keep copying
the list in replies.  So before below links, you can also read this first
just in case you still miss some:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

> 
> On Thu, Apr 25, 2024 at 06:08:58PM +0530, Vilhelm Gyda wrote:
> > Hi, I am new here. This trivial patch is my first contribution. I am
> > not sure who to cc for the review. Checking qemu/MAINTAINERS you guys
> > seemed to be most relevant for this patch. I am looking for what to
> > contribute next, let me know if you guys have any ideas on that.
> > Thanks
> 
> Maybe can start with looking at some bugs (see the end of the page below),
> or todos listed here that you think you have an idea to move on:
> 
> https://wiki.qemu.org/ToDo/LiveMigration
> 
> > 
> > On Thu, Apr 25, 2024 at 5:12 PM Will Gyda <vilhelmgyda@gmail.com> wrote:
> > >
> > > migration/ram.c: API Conversion qemu_mutex_lock(),
> > > and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro
> > >
> > > Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
> 
> The patch looks okay:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks,
> 
> > > ---
> > >  migration/ram.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index a975c5af16..50df1e9cd2 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -1066,14 +1066,14 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
> > >      trace_migration_bitmap_sync_start();
> > >      memory_global_dirty_log_sync(last_stage);
> > >
> > > -    qemu_mutex_lock(&rs->bitmap_mutex);
> > > -    WITH_RCU_READ_LOCK_GUARD() {
> > > -        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > > -            ramblock_sync_dirty_bitmap(rs, block);
> > > +    WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
> > > +        WITH_RCU_READ_LOCK_GUARD() {
> > > +            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > > +                ramblock_sync_dirty_bitmap(rs, block);
> > > +            }
> > > +            stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
> > >          }
> > > -        stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
> > >      }
> > > -    qemu_mutex_unlock(&rs->bitmap_mutex);
> > >
> > >      memory_global_after_dirty_log_sync();
> > >      trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
> > > --
> > > 2.25.1
> > >
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


