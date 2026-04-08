Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D8610F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYjC-0000Cb-4u; Wed, 08 Apr 2026 15:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wAYj6-0008UI-98
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:38:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wAYj3-0004rS-S3
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:38:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so1020805ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775677088; x=1776281888; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v/iOnVEpUbJ2Xa/AuI1nXW6dHMkDeesO7bdUNjEpXfM=;
 b=J31DMq50z3k87C9PzMtu2HOUZY4IVXLwIf81TTAut0xmj6jIvGw4R1loKp40WPKmOb
 EjtNBeh4Del4VBalOIciykEc6gDw9GYPFJD+WfVr/rHO0lRhcVEclOgM7KDH5kdwMbJn
 SwIucRuiCod/+m5O6/eyOXBQyBlG+D317RpetRbaU58ShilKR7xO5UM4nj99xpllMJK+
 tPA8JhxstI+UuKq14b54LFxuFH0Vyg7JaMNi1vgk0rmAnO6cWpZcxYTicY8JNbZ9ykhV
 3kr2h+P2h4vJ4CNLMt2rMaCT8rNdwnCEreRtfwvxY1YpRj9YtNCBJ9madJfp8Q0RAQQN
 tp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775677088; x=1776281888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/iOnVEpUbJ2Xa/AuI1nXW6dHMkDeesO7bdUNjEpXfM=;
 b=qlbYdpiaLpN28Dhv7g1q4ub/8ORgbvjGUT0/zMojp9A46gS3jsqIqBYh1jbU0JFk4X
 b7GkvHNyMAwG6AV3sIvVEEItIMTpZQBKHAfgw+R76FqoX/TDN1mspL67cbHIxkosk7Ho
 JFWA6b5VaGc4txflJ8XLMD9XCwg63mcALNceLTMdbvG7CAmY8dJwoOga7IergvIFDNLQ
 QH1NmpdA9aMbRK/pP1JG+CMIMsuTS0+rwEyi2ufax/YTjgdMb2JOKKVdbBotgCcRGU8J
 up7Mwn4oCIHTCwfp9R3+JMJbNS330W6kjrJKrtWsHv61K96FSngtDZlxnpVsIgDQ5diZ
 Yruw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiI4UShjybDEW1h/r19MnnmWYhAK04ETltjmF3DFDCYVzB4jy3CKXQov5OYg6AqJBq4tOiUm28bfqn@nongnu.org
X-Gm-Message-State: AOJu0Yyr0Tlb8ukvyj5ijWH+YCJXfbwUlv85dmr03dbHN5dbbaFSyDwj
 yGbhAdiS4Lx04OA6NG837hNSxyeauKmsBu+BnbAOvM0FBNZpv7fUQXmY
X-Gm-Gg: AeBDieuuX1xnUtyPMFXH0N67fo7dvZZ+BmEOtUIUpl065fUX1OJJDAIjGamJ3Exoba/
 Oa3oZGRyzDNA8JpwPUd2zBu3WYmsFM6tBbwjNuRRQNWNSYML1nsp54k5sQRG9vgCHtES5CbPanP
 mSN2x9jmOxo3aOdId7spOgaZawoqSnzPUDn8lkJeXatv9nFhIxILT9/3GlmCRaDPdacdCP2X1sE
 yNd47TaHdNXsuxeSt1/Pb3s91os8ZyHSjkQtYDDo3q4Ue4Ui5oesOkqVfv5Vu54yhjkBEqk6eeO
 trPEPIAJvu73NHtVderGl9Cb6NyEU6kA6HO2/VrsLu8XqmmyUMVngx4LCEoZj82qw/x8b8hYx95
 dFvQS6fArb76RzZJpEWTAemHYjSBB9wYaQ+wMyXkrDRHSHj3Ost6U7XDf4NVW7Sus247hx749c7
 RO1TduFYi4bS2oV3NQ/aMASEiWCT+ItGY=
X-Received: by 2002:a17:903:2282:b0:2b2:489a:f46a with SMTP id
 d9443c01a7336-2b2819361a1mr225341895ad.36.1775677087536; 
 Wed, 08 Apr 2026 12:38:07 -0700 (PDT)
Received: from localhost ([42.118.191.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbcafsm212689855ad.77.2026.04.08.12.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 12:38:06 -0700 (PDT)
Date: Thu, 9 Apr 2026 02:38:03 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] migration: expose RAM stats and timing on
 destination via query-migrate
Message-ID: <wslqvheay2ipt37tnm6q474nmfd3goelcvzubvho5ci7jnneuf@egb65cc7vyga>
References: <20260405152612.93027-1-viking4@gmail.com>
 <20260405152612.93027-3-viking4@gmail.com>
 <d1654771-8f7a-4331-969f-2d7bf038113b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1654771-8f7a-4331-969f-2d7bf038113b@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x631.google.com
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

On Wed, Apr 08, 2026 at 06:14:41PM +0200, Claudio Fontana wrote:
> Hello Trieu,
> 
> makes sense to me in general, but maintainers can give you a more proper review on this,
> I can only point out a few sources of confusion from my side, which likely stem from lack of knowledge from my side:
> 
> On 4/5/26 17:26, Trieu Huynh wrote:
> > From: Trieu Huynh <vikingtc4@gmail.com>
> > 
> > MigrationStats had all-required QAPI fields, so partially populating
> > info->ram on the destination would force display of source-only metrics
> > (dirty-sync-count, precopy-bytes, etc.) as misleading zeros.
> > 
> > Make those source-only fields optional with '*' in the QAPI schema.
> > Update populate_ram_info() to set them via has_* setters so source
> > output is unchanged.
> > 
> > As per schema's changes, fill_destination_migration_info() can now
> > populate info->ram for the COMPLETED case with the fields that are
> > meaningful on the receive side:
> > 
> >   * total, remaining, page-size         (RAM layout)
> 
> Does 'remaining' make sense if the migration is completed? Don't we just assume 0?
> But maybe it makes sense to keep it for simplicity/consistency.
> 
Indeed, it set to 0 when migration status is completed, just to be
consistent.
> >   * transferred, normal, normal-bytes   (bytes/pages received)
> >   * duplicate                           (zero pages received)
> 
> it is interesting that zero pages are called "duplicate".
> 
Yes, it is. IIUC, in migration stats, duplicate = "pages we didn't
need to send because dest's memory is zero-initialized on startup,
so any all-zero src page is already "duplicate" of what the dst has.
> >   * mbps                                (throughput: transferred*8
> >                                          /time_ms/1000)
> >   * pages-per-second                    (total pages / duration in
> >                                          seconds)
> > 
> > Others optional fields (dirty-sync-count, precopy-bytes,
> > downtime-bytes, postcopy-bytes, multifd-bytes, postcopy-requests,
> > dirty-sync-missed-zero-copy, dirty-pages-rate) are left unset and
> > are absent from the destination output.
> > 
> > On dst, {"execute":"query-migrate"}
> > * As-is:
> > {
> >     "return": {
> >         "status": "completed"
> > }
> > * To-be:
> > {
> >     "return": {
> >         "status": "completed",
> >         "total-time": 94,
> >         "ram": {
> >             "total": 554508288,
> >             "pages-per-second": 1440234,
> >             "page-size": 4096,
> >             "remaining": 0,
> >             "mbps": 97.955404255319152,
> >             "transferred": 1150976,
> >             "duplicate": 135101,
> >             "normal-bytes": 1150976,
> >             "normal": 281
> >         }
> >     }
> > }
> > 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  migration/migration.c | 35 +++++++++++++++++++++++++++++++++++
> >  qapi/migration.json   | 14 +++++++-------
> >  2 files changed, 42 insertions(+), 7 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 17c9a8b344..925d29890d 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1063,17 +1063,24 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >      info->ram->normal = qatomic_read(&mig_stats.normal_pages);
> >      info->ram->normal_bytes = info->ram->normal * page_size;
> >      info->ram->mbps = s->mbps;
> > +    info->ram->has_dirty_sync_count = true;
> >      info->ram->dirty_sync_count =
> >          qatomic_read(&mig_stats.dirty_sync_count);
> > +    info->ram->has_dirty_sync_missed_zero_copy = true;
> >      info->ram->dirty_sync_missed_zero_copy =
> >          qatomic_read(&mig_stats.dirty_sync_missed_zero_copy);
> > +    info->ram->has_postcopy_requests = true;
> >      info->ram->postcopy_requests =
> >          qatomic_read(&mig_stats.postcopy_requests);
> >      info->ram->page_size = page_size;
> > +    info->ram->has_multifd_bytes = true;
> >      info->ram->multifd_bytes = qatomic_read(&mig_stats.multifd_bytes);
> >      info->ram->pages_per_second = s->pages_per_second;
> > +    info->ram->has_precopy_bytes = true;
> >      info->ram->precopy_bytes = qatomic_read(&mig_stats.precopy_bytes);
> > +    info->ram->has_downtime_bytes = true;
> >      info->ram->downtime_bytes = qatomic_read(&mig_stats.downtime_bytes);
> > +    info->ram->has_postcopy_bytes = true;
> >      info->ram->postcopy_bytes = qatomic_read(&mig_stats.postcopy_bytes);
> >  
> >      if (migrate_xbzrle()) {
> > @@ -1094,6 +1101,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >  
> >      if (s->state != MIGRATION_STATUS_COMPLETED) {
> >          info->ram->remaining = ram_bytes_remaining();
> > +        info->ram->has_dirty_pages_rate = true;
> >          info->ram->dirty_pages_rate =
> >             qatomic_read(&mig_stats.dirty_pages_rate);
> >      }
> > @@ -1209,6 +1217,33 @@ static void fill_destination_migration_info(MigrationInfo *info)
> >      case MIGRATION_STATUS_COMPLETED:
> >          info->has_status = true;
> >          fill_destination_postcopy_migration_info(info);
> > +        if (mis->total_time > 0) {
> > +            info->has_total_time = true;
> > +            info->total_time = mis->total_time;
> > +        }
> > +        {
> > +            size_t page_size = qemu_target_page_size();
> > +            uint64_t normal  = mis->received_normal_pages;
> > +            uint64_t zero    = mis->received_zero_pages;
> > +            uint64_t xbzrle  = mis->received_xbzrle_pages;
> > +
> > +            info->ram = g_malloc0(sizeof(*info->ram));
> > +            info->ram->total        = ram_bytes_total();
> > +            info->ram->remaining    = 0;
> > +            info->ram->normal       = normal + xbzrle;
> > +            info->ram->normal_bytes = (normal + xbzrle) * page_size;
> > +            info->ram->duplicate    = zero;
> > +            info->ram->transferred  = (normal + xbzrle) * page_size;
> > +            info->ram->page_size    = page_size;
> > +
> > +            if (info->has_total_time) {
> > +                info->ram->mbps = info->ram->transferred * 8.0
> > +                                  / info->total_time / 1000.0;
> > +                info->ram->pages_per_second = (normal + xbzrle + zero)
> > +                                              * 1000.0 / info->total_time;
> > +            }
> > +            /* source-only optional omitted from output */
> > +        }
> >          break;
> >      default:
> >          return;
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 7134d4ce47..a695d04a22 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -68,13 +68,13 @@
> >    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
> >             'duplicate': 'int',
> >             'normal': 'int',
> > -           'normal-bytes': 'int', 'dirty-pages-rate': 'int',
> > -           'mbps': 'number', 'dirty-sync-count': 'int',
> > -           'postcopy-requests': 'int', 'page-size': 'int',
> > -           'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
> > -           'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
> > -           'postcopy-bytes': 'uint64',
> > -           'dirty-sync-missed-zero-copy': 'uint64' } }
> > +           'normal-bytes': 'int', '*dirty-pages-rate': 'int',
> > +           'mbps': 'number', '*dirty-sync-count': 'int',
> > +           '*postcopy-requests': 'int', 'page-size': 'int',
> > +           '*multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
> > +           '*precopy-bytes': 'uint64', '*downtime-bytes': 'uint64',
> > +           '*postcopy-bytes': 'uint64',
> > +           '*dirty-sync-missed-zero-copy': 'uint64' } }
> >  
> >  ##
> >  # @XBZRLECacheStats:
> 
> This looks good and makes sense to me,
> but looking forward to more authoritative voices.
> 
Thanks, let's waiting.
> Does this work build ok on all archs? Any tests that could be extended to cover these new stats,
Actually, I have tested x86_64 but not other archs. The patch are
arch-independent IIUC, so I expected it will work without impact any
existing callers on other archs. Anw, I will check it. 
> maybe tests/qtest/migration/ ?
> 
Thanks for the point. I think can reuse existing test_precopy_tcp_plain.
Will try to add it in v2. 
> Thank you!
> 
> Claudio
> 
BRs,
Trieu Huynh

