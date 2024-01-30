Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF407C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgK5-0002vK-06; Tue, 30 Jan 2024 00:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUgK2-0002uz-Ho
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUgJj-0000yN-Ge
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706591145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BYGu2q7neRJK9tf6fnZ3aOxfW6mI54L1c1wtvPr8FU=;
 b=DaaCwlMzbMrTRQojKO4nfe6Eg74H2KVDAViAou43WDaOgmWIGWPBULru/fD9dI8nPze+/T
 9u8ESpnTQ2DUDhaAofz46py9XA5xjkG2mhJdBU7CFWNjlDq4IWP7mX/TzylsSb/XyTTQoF
 67LZd4I+ogaUKzm4M/ONyxFADdIAuK8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-61U1wV9-OBSFziW75gBvbg-1; Mon, 29 Jan 2024 23:32:23 -0500
X-MC-Unique: 61U1wV9-OBSFziW75gBvbg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso1190044a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 20:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706589142; x=1707193942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BYGu2q7neRJK9tf6fnZ3aOxfW6mI54L1c1wtvPr8FU=;
 b=d020K1Z0JXkG8tsPdFA3tRPLEXQriQHm1Vg+sL6npe7MS7Z2nlZWjFTOWW9OJFaG+i
 IUAW8POfRDZfYPIaEEDKobbWoTzq2sIqw8TyfHeJlsz0JyJhZ8oE6OQvpw02JA08QPAW
 XvqbhqXG5U9Urr737uiz24K78ZGsExj1zHOYLuVcX0ygRPQR5mJj5+GjiGENZXB5iZoM
 ahnGOYBIvHxtIooqhcM9XtCGpk/J5aKZ4BwozVs7SPeDhj1R0oMG6acw3Qdf0SpTbdGx
 ChMXxrtn1Vj/QA7zWwioUJdKwO46R7E6lHUQx39w6qIjjFD6L1i/POigFphb25V9DJVC
 42uQ==
X-Gm-Message-State: AOJu0YwMADVLBjiwSblwPSIrchf8j63yNxd2NvcvJ9IVqqa64LwnW4CX
 rXhMkOTOGjEdiPUgiDIZlFTdpDdJRremzDmZt+BsrHpMI1RRs6fYSX7abaSWkgqJA14tPUwZV3I
 zS/occErapyTbOCJxKFz9VL7P+b9AFRY9BlufZku21d89y4pr9Z1ZiF5ghurWtOo=
X-Received: by 2002:a17:902:fe83:b0:1d8:cc33:d7b4 with SMTP id
 x3-20020a170902fe8300b001d8cc33d7b4mr7139676plm.5.1706589141876; 
 Mon, 29 Jan 2024 20:32:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8AkhCFQaNXOcO54ZKCMthmt61AIth7OjE18v2cxETsZjycgrSWpHR6RuIq0+q8jgH008yzg==
X-Received: by 2002:a17:902:fe83:b0:1d8:cc33:d7b4 with SMTP id
 x3-20020a170902fe8300b001d8cc33d7b4mr7139664plm.5.1706589141453; 
 Mon, 29 Jan 2024 20:32:21 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s6-20020a170902ea0600b001d73228cd88sm6152624plg.255.2024.01.29.20.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 20:32:21 -0800 (PST)
Date: Tue, 30 Jan 2024 12:32:12 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
Message-ID: <Zbh7zAqS4_9KnATk@x1n>
References: <20240122070600.16681-1-peterx@redhat.com> <87plxtgyxx.fsf@suse.de>
 <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frygdzjl.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 29, 2024 at 10:44:46AM -0300, Fabiano Rosas wrote:
> > Since we're at it, I would also like to know how you think about whether we
> > should still suggest people using VMSD versioning, as we know that it won't
> > work for backward migrations.
> >
> > My current thoughts is it is still fine, as it's easier to use, and it
> > should still be applicable to the cases where a strict migration semantics
> > are not required.  However it's hard to justify which device needs that
> > strictness.
> 
> I'd prefer if we kept things strict. However I don't think we can do
> that without having enough testing and specially, clear recipes on how
> to add compatibility back once it gets lost. Think of that recent thread

If it was broken, IMHO we should just fix it and backport to stable.

I think Juan used to worry on what happens if someone already used an old
version of old release, e.g., someone using 8.2.0 may not be able to
migrate to 8.2.1 if we fix that breakage in 9.0 and backport that to 8.2.1.
My take is that maybe that's overcomplicated, and maybe we should simply
only maintain the latest stable version, rather than all.  In this case,
IMHO it will be less burden if we only guarantee 8.2.1 will be working,
e.g., when migrating from 8.1.z -> 8.2.1.  Then we should just state a
known issue in 8.2.0 that it is broken, and both:

  (1) 8.1.z -> 8.2.0, and
  (2) 8.2.0 -> 8.2.1

will expect to fail.

> were we discussed an old powerpc issue. How come we can see the fix
> today in the code but cannot tell which problem it was trying to solve?
> That's bonkers. Ideally every type of breakage would have a mapping into
> why it breaks and how to fix it.
> 
> So with testing to catch the issue early and a clear step-by-step on how
> to identify and fix compatibility, then we could require strict
> compatibility for every device.

I don't think we can guarantee no bug there, but indeed we can do better on
providing some test framework for device VMSDs.

> 
> >
> > For example, any device to be used in migration-test must be forward +
> > backward migration compatible at least, because you just added the n-1
> > regression tests to cover both directions.  Said that, only a few devices
> > are involved because currently our migration-test qemu cmdline is pretty
> > simple.
> 
> We might want to make a distinction between migration core vs. device
> state testing. I see n-1 testing more like migration core testing. It's
> bad to break migration, but it's really bad to break migration for
> everyone because we refactored something deep within migration/.
> 
> I also wouldn't mind if we had some simple way for device developers to
> add migration tests that cover their code. Currently it's infeasible to
> edit migration-test with new command lines for every device of
> interest. Maybe we could have a little framework that takes a command
> line and spits a migration stream? Something really self-contained,
> behind the device's CONFIG in meson.

I added one more todo:

https://wiki.qemu.org/ToDo/LiveMigration#Device_migration_stream_test_framework

How's that look?  Feel free to modify on your will.

-- 
Peter Xu


