Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B67EC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 07:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpKS-0002ww-2V; Tue, 25 Feb 2025 02:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tmpKQ-0002wY-I9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tmpKP-00078P-0i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740468363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XntxzrL7Wog5aJLQyJ+wN1SYsgnjFtg9FB+JD4c7LRc=;
 b=SNJsjGS4f8V8AW0zlcU1yaedo7uAY46fSf7mq/4svwRYXu4WLbUzwK/RtXU+fdesi/dtzw
 LDA4MIuqkxR3MVYvhsJKaOTEBmw+SRyfCHRBZVm0Ewv4lvPWSTDK4cWb2ezGc9hL7LXR7R
 fuFwsdVXulg/Qxenr6DFB3btGuJWOE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-dnG2l7WTNfCKYrJ8cVP6SA-1; Tue, 25 Feb 2025 02:26:00 -0500
X-MC-Unique: dnG2l7WTNfCKYrJ8cVP6SA-1
X-Mimecast-MFC-AGG-ID: dnG2l7WTNfCKYrJ8cVP6SA_1740468359
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so38900665e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 23:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740468359; x=1741073159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XntxzrL7Wog5aJLQyJ+wN1SYsgnjFtg9FB+JD4c7LRc=;
 b=YfmB3U5O9jeVHloW/kwMB9YgzNsh4qXDEqSCCsydP0eAJtZC91hXMD3UQKDcT8hv/7
 sn17rywrSLYtJ30PNYqLGjS2xul9o7mRy3dyqjCTlg5WpeBMhLbqe7kYRrn8sTkxP6QI
 Z3CgKhAuW0p5asF+CqOXngMTun/rqrtIJsDED451+5vewcdmDEJqUwOp31lE0ymLTX9e
 qiR0ev3JxIq5Slobu06l+dAVivxspL8yQEbZG9FEIMV9GBvgr49mRCU1+NyHi029nmp6
 GzfcQ1M6s3B9nU36TODfN7RdPaYlPUHSZYTe2X4gTvdAycwWGzp7NdXedeiV/YDfnyO1
 0GHw==
X-Gm-Message-State: AOJu0Yw/FF4/b9wST8JJiDt6gs0KBt5EOGxlueMkJnlSyZQ71UZ1avTO
 xSkYiB0mkOngXYaNaN93KwArIBNH6L0fnz9P2K9vGw6D34D4XAwV8f6IgWWaHIGTjm34jkn34Qn
 oLXmkOh6kw3y0DVHlSWTbreClafHQpKY1laYU806l23rLLCQqQqlTTNZnzBq5fzyQVj7NHCTy92
 OuT1FJ8MJMEW1odSTGnsL8G+N/HTc=
X-Gm-Gg: ASbGncs/pOdvfBCNrfgbL6SP95XJJLpXf2zIUudneiKiwODpCs4FbOU6ixPMuR2Pnid
 z6snCLGXhySo4oNP94LNk4HmYK//p2MuXKoxH65fZ/Zr9TOluLtbPZEgowy+byK2F/xs1LJyobw
 w=
X-Received: by 2002:a05:600c:b9b:b0:439:8ef6:5782 with SMTP id
 5b1f17b1804b1-439ae1e8be4mr144666955e9.10.1740468359506; 
 Mon, 24 Feb 2025 23:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOyi1c6eeLShqo3EbCeZYyU+TJ/tW8LSrGLiIwUNOMSrhuDyOoJWEQjuA4O5kDpPGES3eSCTAEfWVg0G/urdY=
X-Received: by 2002:a05:600c:b9b:b0:439:8ef6:5782 with SMTP id
 5b1f17b1804b1-439ae1e8be4mr144666735e9.10.1740468359155; Mon, 24 Feb 2025
 23:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-5-ppandit@redhat.com>
 <871pvwvb69.fsf@suse.de>
 <CAE8KmOzknFTcKnSp3iQwhV__e0_r-kJnXDy3x3zeyrohH5B6Tg@mail.gmail.com>
 <875xl79vjv.fsf@suse.de>
In-Reply-To: <875xl79vjv.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 25 Feb 2025 12:55:42 +0530
X-Gm-Features: AWEUYZmCX7o9XdZvI9DUGdAbd99nel6upVJlFrKbbqx6BdTX3rpoX85574xqIc0
Message-ID: <CAE8KmOzNoMrpPjvTinVrcQ0VKbgFUyyRWWdHE02_HwU4dpjx=g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] tests/qtest/migration: add postcopy tests with
 multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Fabiano,

On Tue, 18 Feb 2025 at 19:58, Fabiano Rosas <farosas@suse.de> wrote:
> >> > +static void test_multifd_postcopy_tcp_cancel(void)
> >> > +{
> >> > +    postcopy_ram = true;
> >> > +    test_multifd_tcp_cancel();
> >> > +    postcopy_ram = false;
> >>
> >> You could pass this in, there's just one other caller.
>
> To make postcopy_ram be passed in as an argument to
> test_multifd_tcp_cancel(). Having globals tend to get in the way of
> refactoring stuff later. We already had issues with tmpfs being global
> all over the place.

* This looks tricky to do. test_multifd_tcp_cancel() is called via
migration_test_add(), which expects a function pointer of type => void
(*fn)(void). Changing 'migration_test_add' signature would entail
adding a parameter to all functions called by it.

Thank you.
---
  - Prasad


