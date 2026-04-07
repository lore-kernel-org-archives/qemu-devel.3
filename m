Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2DFFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQd-0002Sa-Bj; Tue, 07 Apr 2026 14:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wABQb-0002LR-IO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:33 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wABA2-0000Gp-Se
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:28:31 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c76c067bc51so1939027a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775586504; x=1776191304; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ucacrYdATvpDDyHShVSORWTav61hlaXKeMO9wJeuNYs=;
 b=OgZE7005S5Rrxti9q9fqZXnGRZIQIItrpsarg3VpsIeOj4vpRr3mGgA7qpLHWzJKsE
 VhnqIz0UIAyKQz/Wk5XKRBFFFmOT8NtZSKqWDFInmGEVgx7W42tHJEr4w0fED8On/MSL
 JJdM49m0AujcGdUJP0gvyNxk7hpi0GRDAEBI9grLdJrOdhBNrHR7yfP3UAUTBQZAAxI4
 XjGhACzxDIuzSm9DUb4wY2ibam8R2rUA2XNMJ/I9LoYyx0AGyBIs7hoHtC9sT64RmmSk
 m2FvFudYzdacEKLCBx/Uz5unDhwFo2DmNUH6b5c8EpT7AoARV15h/EE9N0mE9fNR1J97
 IxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775586504; x=1776191304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucacrYdATvpDDyHShVSORWTav61hlaXKeMO9wJeuNYs=;
 b=kcNuFVxicJMhrQunYcWL3qRQrAGuELTW+HZdj8ybXVRvvER9PwMHEmptQRm0/jM42O
 vobuccIgQo17J1mvom7uQ1q+j4BGQJiu3UL7dDSJ28j3/STSbM8xst5rPaJByHStrhH4
 41DhddYRNrY5rN7JOGbwNcEbEPXuWFJQts+5KrY63oyChIWPK/RtfjSnBIZxtYKFtjnD
 k54QOaLFOp2Y/UTgHrtjZUL8G56cpXSUWzNHr5cKbrGTbgBI3de3yxX5K+AeHalQ57mO
 8V4DgnETNu2wdZX0vIp02qJEle93NVoRyPqHIsIGF2NHlWfovyUpbtEU3MeFRYWOWq0q
 mPHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJnziBuDKoczSuYQ5MFk49/9Tfh4e+vlSou4S7gQLXTlNazAGmRmlnUIBA6ikahOphZkPOqr7rCgL2@nongnu.org
X-Gm-Message-State: AOJu0Yx1PUeyCUabQ+e+W65+DYGQMPEWcRCSB9bPErStrSJzCSNNyrr8
 E3f7/mSnNeyPaZxeFuDYEdsLfcd0pMs9kY9pxtq7W2IM6ATPzfWPrhCj
X-Gm-Gg: AeBDietNv0OYljc+Yra4tJoXL4NEG8U5f2+QbapTHSzderGsnXXt8FRxPX+MBZRDTsW
 NCoseJ1o3GS8Jyj2TVVeLSadVsXsYyvxfH3vyni97KJMbsdzWSJVIOXEHgyxZ8XVNJXVwogJYzW
 CP7ON+pU2uezAmDGeIcoWQhGeJVZt49rqovFbURPmTrzDq23n3Bwt53raoU/jHD4Cu0x/zasYyv
 d82pw9ieJRw9M06WvHIKfW1E6Q3KhBjyagvsH9En4bU97GLtj69ln+5pW/mFWZjmbx6MJxLyNyk
 XutBn8dXzXv9GCG64urYIaEXlxy+G9HFU8rSsqDpIxsCW/n/t56PqiVMuYsXjPvM+9x0Ulacmwz
 Hpq2vXqBS1vcxp9DLCReyAqziFfohmbpCQVD624n3MLG66EomN4qbrPRwGBRD+THmaP61RirknJ
 eHi1DGbGEcVVEHly9OkXgU2hbnZ6u5Tt0=
X-Received: by 2002:a05:6a20:2da8:b0:39f:4d08:7555 with SMTP id
 adf61e73a8af0-39f4d08798dmr10140818637.5.1775586503706; 
 Tue, 07 Apr 2026 11:28:23 -0700 (PDT)
Received: from localhost ([42.118.191.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c657e5f3sm15522860a12.23.2026.04.07.11.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 11:28:23 -0700 (PDT)
Date: Wed, 8 Apr 2026 01:28:19 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] migration: track timing and received pages in
 MigrationIncomingState
Message-ID: <xjqd7rzon5lqztkvjpdeyih24hmiiidjcikzv3azgvgdja6zcx@bj2l6aqqoh6o>
References: <20260405152612.93027-1-viking4@gmail.com>
 <20260405152612.93027-2-viking4@gmail.com>
 <043e3410-9a58-4102-86a2-177579b63add@suse.de>
 <afc6a092-9441-4335-bd00-0c613180f152@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc6a092-9441-4335-bd00-0c613180f152@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=vikingtc4@gmail.com; helo=mail-pg1-x534.google.com
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

On Tue, Apr 07, 2026 at 02:11:54PM +0200, Claudio Fontana wrote:
> On 4/7/26 14:02, Claudio Fontana wrote:
> > Hello,
> > 
> > On 4/5/26 17:26, Trieu Huynh wrote:
> >> From: Trieu Huynh <vikingtc4@gmail.com>
> >>
> >> Add start_time, total_time, received_normal_pages,
> >> received_zero_pages, and received_xbzrle_pages to
> >> MigrationIncomingState.
> >>
> >> start_time is recorded when the incoming state transitions to ACTIVE;
> >> total_time is recorded when it transitions to COMPLETED. The page
> >> counters are incremented in ram_load_precopy() as each page type is
> >> received from the source.
> >>
> >> These fields will be used by a subsequent patch to populate
> >> fill_destination_migration_info() for the migration COMPLETED case.
> >>
> >> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> >> ---
> >>  migration/migration.c |  2 ++
> >>  migration/migration.h | 17 +++++++++++++++++
> >>  migration/ram.c       |  3 +++
> >>  3 files changed, 22 insertions(+)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 5c9aaa6e58..17c9a8b344 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -726,6 +726,7 @@ static void process_incoming_migration_bh(void *opaque)
> >>       */
> >>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >>                        MIGRATION_STATUS_COMPLETED);
> >> +    mis->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - mis->start_time;
> >>      migration_incoming_state_destroy();
> >>  }
> >>  
> >> @@ -758,6 +759,7 @@ process_incoming_migration_co(void *opaque)
> >>      migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> >>                        MIGRATION_STATUS_ACTIVE);
> >>  
> >> +    mis->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >>      mis->loadvm_co = qemu_coroutine_self();
> >>      ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> >>      mis->loadvm_co = NULL;
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index b6888daced..cd51ae452c 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -176,6 +176,23 @@ struct MigrationIncomingState {
> >>      /* PostCopyFD's for external userfaultfds & handlers of shared memory */
> >>      GArray   *postcopy_remote_fds;
> >>  
> >> +    /*
> >> +     * Timestamps for reporting migration duration via query-migrate on the
> >> +     * destination. start_time is recorded when the state moves to ACTIVE;
> >> +     * total_time is recorded when it moves to COMPLETED.
> >> +     */
> >> +    int64_t start_time;
> >> +    int64_t total_time;
> > 
> > nit: since this is a timestamp and these are directly linked to state changes,
> > why not call these:
> > 
> > int64_t migration_active_ts;
> > int64_t migration_completed_ts;
> 
> I got the second one wrong, it is not a timestamp, that is indeed a time.
> So clarity in the name seems to be more than a nit. What about:
> 
> int64_t migration_active_ts;      /* ms */
> int64_t migration_completed_time; /* ms */
> 
make sense to me. will update in v2. thank you.
> Thanks,
> 
> Claudio
> 
> > 
> >> +
> >> +    /*
> >> +     * Page counters for reporting RAM statistics via query-migrate on the
> >> +     * destination.  Incremented in ram_load_precopy() as each page type
> >> +     * is received.
> >> +     */
> >> +    uint64_t received_normal_pages;
> >> +    uint64_t received_zero_pages;
> >> +    uint64_t received_xbzrle_pages;
> >> +
> >>      MigrationStatus state;
> >>  
> >>      /*
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 979751f61b..6646e5daad 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -4417,10 +4417,12 @@ static int ram_load_precopy(QEMUFile *f)
> >>                  break;
> >>              }
> >>              ram_handle_zero(host, TARGET_PAGE_SIZE);
> >> +            mis->received_zero_pages++;
> >>              break;
> >>  
> >>          case RAM_SAVE_FLAG_PAGE:
> >>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> >> +            mis->received_normal_pages++;
> >>              break;
> >>  
> >>          case RAM_SAVE_FLAG_XBZRLE:
> >> @@ -4430,6 +4432,7 @@ static int ram_load_precopy(QEMUFile *f)
> >>                  ret = -EINVAL;
> >>                  break;
> >>              }
> >> +            mis->received_xbzrle_pages++;
> >>              break;
> >>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
> >>              multifd_recv_sync_main();
> > 
> 
BRs,
Trieu Huynh

