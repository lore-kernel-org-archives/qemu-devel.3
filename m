Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F8B1061B20
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7J1y-0006Fp-JV; Mon, 30 Mar 2026 16:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7J1v-0006Fa-18
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7J1s-0000k4-Dk
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774901766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/wIESYO0he0AQHMRMcq3J6TLmkstJH0T5Ma1DC8QVE=;
 b=ZlCZksayrO7sWw/7uiJ2kWtaEyGEGpPj0kSI+h94e8m1Zb1QI0GEQ1wlTTqAqvrI/lnXQj
 5ZD1qRindb6DiXHfr1LVuDv3nIV3E12pswS0lEYWam4EloRP93aLYFM0oQgClybkw1QHuD
 NGu8qxd1hVUMfXvkjIOOlTH1ia6uJr4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-4HnQAXn4MNyZOv5atsdl3Q-1; Mon, 30 Mar 2026 16:16:05 -0400
X-MC-Unique: 4HnQAXn4MNyZOv5atsdl3Q-1
X-Mimecast-MFC-AGG-ID: 4HnQAXn4MNyZOv5atsdl3Q_1774901765
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfdc479f68so572921885a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774901764; x=1775506564; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g/wIESYO0he0AQHMRMcq3J6TLmkstJH0T5Ma1DC8QVE=;
 b=JFyDaRXYepiGEfkoh+ufaJmwcMMVTACTuQIbRYie5TvgJqgAOY7wa8bREo9urZrUGN
 WhhCPw0eEbrasyRIjMR3mlFa8xrcP4iQ+S/tUUEQ+GaESkKHyUNCoPWoWCmtmOPbZVbE
 wFcAQYVjppvQWsx7LEa1vS+UiEMSVIvM0v0S0hkbjFVEq1cDfTdM2dJhn8gdRbb7d13l
 G6o71XL3kYNXGPcQkLSJq8sc1F47QwhCDcdn58Gk2ROOlgDz5ypa11X3wDSNIu2Bi0ct
 MHm6YNORaxIZC7sj0UA2q9AR7NjE9I+HJmWEneJtxFDmPlFj0Zk/JZJDUzZtLvhCTA3k
 q+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774901765; x=1775506565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/wIESYO0he0AQHMRMcq3J6TLmkstJH0T5Ma1DC8QVE=;
 b=LBZdrsoy88Aiz1yeXiNfXTHf5cErtMwOS9JnGA97GfzEeo1GSdTAbltGqKsIMbFiaK
 uCyz9lYQtFTDDcOPZaKoGyPtbLf0mTPvGNj2Zd8xLr6yB0w6GBx3aEpDsszAuTnxiBet
 btSxgDw/q1hxrBZ/wbxoM14ivbncNUW5prLrTeI7ykeJYywpz+gyHbtAJZRMSuMLAAQL
 uyUMKWTRUI4hjvvf1QgvukYNOI+ezGj/ICZ0fLEw0h0p1wT/VoTVafdw23aIztaZynDj
 9nFZeLcBqpBtuxdeGVqxK6+RE238vyJ2P15NbmuZTZOQX0uzNXvhui9J9mxRURTkWX45
 B/gQ==
X-Gm-Message-State: AOJu0YwALF8neeqFohO1uE9y1kQX0mKMdsFgExpjM6CWkfY4g1i7sCJf
 2mzpgqSJSUpB6MLhPi0sQt/J0x9Sm1dkeIIza0QAEUcvGpYn5g++IfGng2OlHWEuPXBioRIK9Mm
 YXjpw0D8joUH6m1Ttu4gnjwdnK+4f1MCsWXgFRD/RJHMncqUdyg8bx25I
X-Gm-Gg: ATEYQzy7XpG0vOGbUMmJHRDZ15+CNIL5LeVPuiTRVyhHHwwRTh7ZjWLX9ebPgFb8qbE
 14aCgtogb5EpSWpUMgytZiVHtCPwJTTHbhNguPoQonYM2BUzxe7N05pl/HXPB9qslEx4j90tMG2
 Qs2HfIassa93BRatMVvbEjDx4cwBOoYjtg66tmO15RDk3ugtdB0lovyCeY4H5GBWFNysxAqLS+p
 UzxBDHDZgtlN7VyhXvcfLrPriPS4EX1qAapi0niaKQEYY0o18gNUoFfy6dnBjQ1uXJIgaWMwUJ6
 2xiP6o3dS7MsbSr2+VxR4meYFEFmEKbDAtSTyTGVeCxl7AZsGYwv6OUXsirxNwTUGTLj05YxaNY
 gC7BtcKTObedMmQ==
X-Received: by 2002:a05:620a:44d1:b0:8cb:4ba9:cce6 with SMTP id
 af79cd13be357-8d01c83f23emr1830261785a.66.1774901764438; 
 Mon, 30 Mar 2026 13:16:04 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:8cb:4ba9:cce6 with SMTP id
 af79cd13be357-8d01c83f23emr1830255985a.66.1774901763714; 
 Mon, 30 Mar 2026 13:16:03 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d028090f43sm686774485a.45.2026.03.30.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:16:03 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:16:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/3] migration/postcopy: Preparatory refactoring for fast
 snapshot load
Message-ID: <acraAru2XIjMIpXW@x1.local>
References: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Takeru,

On Mon, Mar 30, 2026 at 07:04:40PM +0000, Takeru Hayasaka wrote:
> This series refactors postcopy and mapped-ram code to make the
> userfaultfd infrastructure reusable beyond postcopy live migration.
> The goal is to prepare for fast snapshot load, which will use
> userfaultfd to load guest RAM pages on demand from a snapshot file
> instead of reading all pages before starting the VM.
> 
> All three patches are pure refactoring with no functional change.
> 
> Patch 1 introduces a callback for the fault thread's page request
> handler, so the page supply mechanism can be swapped (network for
> postcopy, local file for snapshot load).
> 
> Patch 2 extracts generic uffd setup (open, register, fault thread,
> temp pages) from postcopy_ram_incoming_setup() into a shared
> uffd_setup_incoming() function.
> 
> Patch 3 splits parse_ramblock_mapped_ram() so that the header and
> bitmap can be read without immediately loading all page data. This
> allows a future caller to read only the metadata and defer page
> loading to a fault handler.

Thanks for your interest and enthusiasm to the QEMU community.  Said that,
please hold off a bit on sending patches that enable fast snapshot load for
now, even for preparations.

The problem is, this topic, as announced, is to be developed by a GSoC
student only later. We want to make sure this topic will be done during the
GSoC period by the selected candidate, and we will also need to evalute the
progress no matter who is doing it.

I'm not sure if it's fair if any of the applicants start sending patches.
I also don't hope to see multiple versions of impl floating around.  IMHO
it's slightly against how collaboration works upstream when we know there
can be work collisions and we should avoid it from happening.

Feel free to send whatever patches that do not have direct involvement with
this specific topic.

> 
> Tested with mapped-ram precopy file migration tests. Postcopy tests
> require userfaultfd, which was not available in my test environment,
> but no postcopy logic was changed.

When postcopy code is changed, I think it needs to be tested.

Could you explain what do you mean by "userfaultfd, which was not available
in my test environment"?  Are you using Linux?

Thanks,

> 
> This work is part of my preparation for the GSoC 2026 "Fast Snapshot
> Load" project.
> 
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> Takeru Hayasaka (3):
>       migration/postcopy: Extract page fault handler callback
>       migration/postcopy: Factor out uffd_setup_incoming() from postcopy setup
>       migration/ram: Split mapped-ram header and page loading
> 
>  migration/migration.h    |  5 +++
>  migration/postcopy-ram.c | 86 +++++++++++++++++++++++++++++++++++-------------
>  migration/postcopy-ram.h | 27 +++++++++++++++
>  migration/ram.c          | 52 +++++++++++++++++++++++++----
>  4 files changed, 142 insertions(+), 28 deletions(-)
> ---
> base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
> change-id: 20260327-fast-snapshot-refactor-3c6bb472b777
> 
> Best regards,
> --  
> Takeru Hayasaka <hayatake396@gmail.com>
> 

-- 
Peter Xu


