Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE630606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LysYkfzr;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WOlNEioj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxSU-0001cr-4v; Fri, 27 Nov 2026 10:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWxSN-0001cV-DP
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWxSK-0000IX-Fs
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795791702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82lE46GIeZ6wWndupPZaPdt/6yYbQZ4TFyPpxJjDeWA=;
 b=LysYkfzrCMZ5muP49fuuPeOu0Ir1ddAep13DXXNat1BNPRJqcXMsu7H7DayMNRqTOxjFA4
 nMwHt04KFXZe2IOkYabm/t5iymZGfKkxrP8icOBitSMVvxLm6A7s81j1CwHgUK3Myvm2nP
 +INc2ffZwDO7FwXdGm0d1qPkOpZDYvI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-6tH91LATNcOwf5QlpstkZw-1; Fri, 27 Nov 2026 15:01:40 +0000
X-MC-Unique: 6tH91LATNcOwf5QlpstkZw-1
X-Mimecast-MFC-AGG-ID: 6tH91LATNcOwf5QlpstkZw_1795791700
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99e09f506e8so1279693241.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795791700; x=1796396500; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=82lE46GIeZ6wWndupPZaPdt/6yYbQZ4TFyPpxJjDeWA=;
 b=WOlNEioj/EBg/Ffg+ga4nkuQ2EUKkv3+zqKKby3fCjpdZSSv5mxRdvQhR6pjQYSbxj
 PVeB/00mBbpE2Jux9Zoqnu0O7iB8W7gmYEzeCWvo00bHUSOegNgDsNi1p/AKFqFyHHdf
 9B5s8+QVMrZtPu9X6BIIZ6WoxaLvq+P5zPYp9/uyZn/smegqUFODYRLlpyPSqkwyoUSe
 1rtM6YfLvh2qRHQC+dL9upywBqyn3SeyB2LS6TAwd65ukkcdgGu26pGc9xynJj098uWO
 Y5vpX2yD74wXtmYA8Uema0UwOfIsUJxEEUG3ouF3NiRr0HnAv+ccoKkUIli7y50UyXg7
 g+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791700; x=1796396500;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=82lE46GIeZ6wWndupPZaPdt/6yYbQZ4TFyPpxJjDeWA=;
 b=cpdN43Zmf53KeiU4FJYF+iPNROWwxodbp63TC7jtnp63T03DgA4wg17cUA8KxW40NK
 kQmCzEpYHe3HDp4UM8WGRjNefq5+Uneh5WRdTtfMouLe+O8gv6vzAKK3hhl7x9ThqTGA
 B1ABO3Sh97S6wdqLz0N5AmyMON9kdyJcwq0oFqLa9gQmqURF3nvpGCDtduNR9wS+cjZR
 u8J5QCq5/Gcjw2IbLgM2yroA72gJQDn+wmCQGPVsIMZ5/xHdw43IUSqqX+lP6wJz9Df5
 AVnCtIPjVHoMS9Sgj0N68cpV5PA7+7Tpb6PPqVDfoBdnlzEc06ATHxbKisE3Mr0evDv1
 qpFg==
X-Forwarded-Encrypted: i=1;
 AL+hErHbU+WREPFTeqvfeagw1Em6TYVQYa+moQzc95NoubOdq27+52kacWyN0H+Moz2trl4y4/CPzMZGg88d@nongnu.org
X-Gm-Message-State: APuU4Z+E6HF1PNECkUavps4k5bm3lgrYxshN7v/VZeyD3lgmubIhluAs
 VsuQp6U5nSoRrbWI2C7YF2M4oXwjd+Kocpfne6YFrcUB9G4HjpPZd1epx1NcqYZHvj3T2Ud25uJ
 ApFQYzB7SL3/+lf7j0/v2PzmjqqR6/YQxRdZSs86fa7nHmceEAFYEb2cq
X-Gm-Gg: AZFdTZeENw8SJJkqFNAGGOXSjrKazo81ZfqM+voCQ4crGJOI+HLIUuCWW9bxs/FjRAB
 0OhePmSVhBq8kXKmYAVscM7DktaGRimJwWEAdLfdtc56/LSvi2tUownFOEYUX4F8e6Sdwzilh1U
 RqZyepzxx1CzYwtltW6/DiGgMbXJhu5w7KtXIhlsxLGzsAYBwu5x4LdbbkF9s9+gSwYzWPaRfl/
 /Mu8nfZgd5OUnJOhU72uJV7EngVm6GzBRT3QZojFz1E68qLCG0C7SYy334Z4aPwBtOKNQd2noHN
 GVlVa7DrKrP7lh1LtMoDFboLUCI3W4wlxnxF2kS4bPHVWXqIiuJlU5RFCdBBRyMSqXQjX0wZ8RM
 dAn0/b5n32xde2TJ0aUcUcvUxu2rcoe6kbAYJeJ+6wt4BWg==
X-Received: by 2002:a05:6102:374a:b0:7a5:7282:1994 with SMTP id
 ada2fe7eead31-7d7393a45bamr12148631137.7.1795791699748; 
 Fri, 27 Nov 2026 07:01:39 -0800 (PST)
X-Received: by 2002:a05:6102:374a:b0:7a5:7282:1994 with SMTP id
 ada2fe7eead31-7d7393a45bamr12148511137.7.1795791699083; 
 Fri, 27 Nov 2026 07:01:39 -0800 (PST)
Received: from localhost ([2605:8d80:6cc7:75f8:8c4a:4476:f571:f0d6])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a0c33fsm215825126d6.36.2026.11.27.07.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 07:01:37 -0800 (PST)
Date: Fri, 27 Nov 2026 10:01:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration-test: Support running a real kernel
Message-ID: <awmbT3VAyPdCYkdO@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261126214704.3108327-1-farosas@suse.de>
 <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <awmNKb0WevtA0L_L@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awmNKb0WevtA0L_L@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 02:01:13PM +0000, Daniel P. Berrangé wrote:
> On Fri, Nov 27, 2026 at 08:45:04AM -0500, Peter Xu wrote:
> > On Thu, Nov 26, 2026 at 06:46:59PM -0300, Fabiano Rosas wrote:
> > > There's a class of migration performance bugs that are very specific
> > > to the internals of QEMU and most likely require work on our side, but
> > > are currently invisible to our testing because migration-test runs a
> > > simple guest workload (not even that, really). The more important ones
> > > are BQL contention issues that result in vcpu starvation.
> > > 
> > > My plan is to incrementally add some pieces to migration-test to
> > > reduce that testing gap.
> > > 
> > > The first piece is adding support for running a kernel + initrd inside
> > > the guest which gives us an easy way to start exercising migration of
> > > a more loaded guest that can already cause VM exits.
> > > 
> > > This series adds support for -kernel and -initrd arguments to
> > > migration-test and runs the same set of tests we currently have, but
> > > with the kernel instead of the custom loop. By default it uses the
> > > initrd from tests/migration-stress/ which runs a read-write loop over
> > > all memory and has customizable vcpu and memory size.
> > 
> > The whole thing sounds useful, I'll read into details after I flush more of
> > the older patches.. which will take some time (it also depends on if next
> > week I got some more urgent task "injected"..).
> > 
> > One high level question: this will grow qtest closer to what the functional
> > test is doing.  Have you thought of the relationship between the two, after
> > we move qtest more over there?  I assumed not, based on what you mentioned
> > in the rest part of cover letter that you planned to have it only for dev
> > debug purpose.  But still, we'll start to ask the question to ourselves at
> > some point, IIUC.  So I ask first. :)
> 
> In terms of the boundary between functional tests and qtests, I
> think the guidance is in the names.
> 
> If it is a "qtest" test then it should be primarily making use
> of QTest to interrogate the QEMU internalprocess state.
> 
> If it is a "functional"  test, then it is interested in running
> real kernels & real accelerators and validating the behaviour of
> QEMU via its external mgmt interfaces.
> 
> By this definition, IMHO, the migration-test would be a functional
> test, if it were created from scratch to.

True.

> 
> It only uses libqtest.h APIs for the purpose of sending QMP
> commands, not examining internal device state. Essentially it is a
> historical accident that it is written as a qtest instead of a
> functional test, as that was the best choice at the time.

Yes, I didn't try to measure functional tests, but I think qtest is good
choice even for now being very fast.

Then the question is similar, where we will have two functional tests for
migration, and we'll at some point think about what we do when they start
to overlap (perhaps, already).

-- 
Peter Xu

