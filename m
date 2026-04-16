Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20780F8D762
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPyi-0006Ae-4P; Thu, 16 Apr 2026 12:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDPyg-00069u-KL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDPye-0007jI-AX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so20023b3a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776358442; x=1776963242; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LpFrAMn9SzxvH41Ix8JXYbngNaBdtT89ppdy3NnFfl8=;
 b=ABCkoUKUJKnzh4tetSesEB47N6Ti5PekDMpSYfAKBRrk0iOsV8Q2/WE5sD42dtQQIw
 zKE+MdrEIIYzOc94AJP7sQqPRY3nwr1rq+LEb9mljM7FqKaRFe1gphGgQsqTu5hbHXQE
 o9ZuFRlONDpkhL83J0KhHFYlSKffcV7II7fq7Cp/G8wUl2ADmS5RnEDx4y8prw1fPjBn
 6Qdp8nkWbX0HAE5zkMotEkiEyq6n2SO89UQoBWPy94WR69zPsBc2qU7fkXOtLpDbtETP
 Hy7fiDhilUuapsGIN3dmCccp6jaxFpEBQloX2GXmyQJojlwo0/ybjJIRt0jmP+QqrJkX
 djvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358442; x=1776963242;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LpFrAMn9SzxvH41Ix8JXYbngNaBdtT89ppdy3NnFfl8=;
 b=XvndXoRhBFgjNvJFsD7h6qxQUjxrF8OL1u4APYeowHnsAfMaBrdXOrvhLXZ5BYsDN2
 w+QblvZWLUV7OUSX2XLLuY+adrtD1TECR+7rG33W/x+s7q3oUBkrSuoljOutES3nSylD
 X0y5twRkF8wPbF+dLEPE2uONsJFMNuIuuqseA6qwZVlibjcE04wf2Kv8I5Un1n9yRK6D
 CKOtWvrNhh16BqSmXfjSAtvMZkc13ygcnjjeo3OZz4f6I29tSMkm/6Ihi7S7/nn7EYo+
 GE72I5J6vi5VOBvGOA6njMM6DN7R57pi9E+nrwjKiAHXsdtR2xIRfl7g83WdpQEejnQD
 vCxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ88o+BJTcatSujtsfDbxx06i6UWP6VfDwskJ15+2wYFtFcc1XKQS7DgfcgPTEsxrjFZdKHxWUYIgSWz@nongnu.org
X-Gm-Message-State: AOJu0YyR1OzaW0THwg9YpaGQhyl9DJLh+5Sii4diTZD0HY4u4Qmloe+O
 pRpN/RJyn8GWf3L5++uUa+nv/gwGekhOPhPPEAWfHLngcO1KlfzH2s11
X-Gm-Gg: AeBDiesAgf3DblJTUnsCYyYlZpDDVzcPQYIMFwaJAprOwwBPQlrliAYwropEnzZ1Cxn
 +4nyac2bV9Tkm88gj5fmuAuZk9Nb9YHybMn4OAEoOHvZGu63HpR65lWTrUymmWZCQVIvgHefyS3
 W/hySMUEZo9+EP7YbxyOL0rV5yBZwXMGjO18w2/DuKfjO6wKmr26hMGNzNgZVY92vJJ+frpGeH2
 Y6z57lEkaGexTNa9y+TEzqq/qMnHJj9VRSVK+VOORuMWzKWdkWQN1vjYEvkdx3LNqq4EsPENfj9
 befiwl6KBTQLmSKTyKwU6zJei8mWZZA8P/lGekXOO5DFRg+CUND4gx31Z/ll5JgvvFd5b3DPj2O
 lIkYv588+cn4guNoLkOoNMBTludTYa7/8dDKF5Inx8dCUlJtL79KvpHRWH73p9MMl7UkDkFH/rW
 AHos4YI74G5325/FvL2jG2O7hBvHYz5IpJjfBJLEWVIO3AMNk8axdXbhE=
X-Received: by 2002:a05:6a00:3994:b0:82f:3436:42d7 with SMTP id
 d2e1a72fcca58-82f88594842mr117654b3a.2.1776358442066; 
 Thu, 16 Apr 2026 09:54:02 -0700 (PDT)
Received: from localhost ([42.114.219.141]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f67478fd9sm5818990b3a.61.2026.04.16.09.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:54:00 -0700 (PDT)
Date: Thu, 16 Apr 2026 23:53:55 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>, Fabiano Rosas <farosas@suse.de>, 
 qemu-devel@nongnu.org, Jim Fehlig <jfehlig@suse.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
Message-ID: <spjcuqt626vglmkxxal6ntrttaiwlapcbltrix5eslmyr7yirx@cegi5c5lvay2>
References: <20260405152612.93027-1-viking4@gmail.com> <878qb05gq7.fsf@suse.de>
 <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
 <ad1a9GaGQFHS4UHx@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad1a9GaGQFHS4UHx@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x434.google.com
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

On Mon, Apr 13, 2026 at 05:07:00PM -0400, Peter Xu wrote:
> On Thu, Apr 09, 2026 at 12:08:34PM +0200, Claudio Fontana wrote:
> > On 4/8/26 22:04, Peter Xu wrote:
> > > On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
> > >> Trieu Huynh <vikingtc4@gmail.com> writes:
> > >>
> > >>> From: Trieu Huynh <vikingtc4@gmail.com>
> > >>>
> > >>> When query-migrate is called on the *destination* QEMU after a precopy
> > >>> migration completes it returns only {"status": "completed"} — no timing,
> > >>> no RAM statistics.  The source correctly returns total-time, downtime,
> > >>> setup-time, and full ram stats.
> > >>>
> > >>> This series fixes the gap in two commits:
> > >>>
> > >>> * commit 1: Track start/end timestamps and per-page-type counters in
> > >>>   MigrationIncomingState, recorded in the receive path.
> > >>>
> > >>> * commit 2: Make source-only MigrationStats fields optional in the QAPI
> > >>>   schema so the destination can populate info->ram with only the fields
> > >>>   that are meaningful on the receive side.  Fields computed from tracked
> > >>>   counters (transferred, normal, duplicate, mbps, pages-per-second) are
> > >>>   shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) are
> > >>>   absent.
> > >>>
> > >>> The QAPI change (commit 2) is ABI-compatible: optional fields that are
> > >>> not set are simply absent from the output.  Source-side callers are
> > >>> unaffected because populate_ram_info() sets all optional fields via
> > >>> has_* setters, so the source output is identical to before.
> > >>>
> > >>> On dst, {"execute":"query-migrate"}
> > >>> * As-is:
> > >>> {
> > >>>     "return": {
> > >>>         "status": "completed"
> > >>> }
> > >>> * To-be:
> > >>> {
> > >>>     "return": {
> > >>>         "status": "completed",
> > >>>         "total-time": 94,
> > >>>         "ram": {
> > >>>             "total": 554508288,
> > >>>             "pages-per-second": 1440234,
> > >>>             "page-size": 4096,
> > >>>             "remaining": 0,
> > >>>             "mbps": 97.955404255319152,
> > >>>             "transferred": 1150976,
> > >>>             "duplicate": 135101,
> > >>>             "normal-bytes": 1150976,
> > >>>             "normal": 281
> > >>>         }
> > >>>     }
> > >>> }
> > >>>
> > >>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151
> > >>>
> > >>> Trieu Huynh (2):
> > >>>   migration: track timing and received pages in MigrationIncomingState
> > >>>   migration: expose RAM stats and timing on destination via
> > >>>     query-migrate
> > >>>
> > >>>  migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
> > >>>  migration/migration.h | 17 +++++++++++++++++
> > >>>  migration/ram.c       |  3 +++
> > >>>  qapi/migration.json   | 14 +++++++-------
> > >>>  4 files changed, 64 insertions(+), 7 deletions(-)
> > >>
> > >> Hi, remember to copy the interested people in your series. Using
> > >> get_maintainers is correct, but when there's already a discussion about
> > >> the topic it's good to add some CCs manually.
> > >>
> > >> +CC Daniel and Claudio
> > > 
> > > The request is a valid one.  Said that, redo accounting on both sides seem
> > > to be a duplicated work and overkill to me, if src has everything.
> > > 
> > > Is there a way we can make Libvirt always query the results before src dies
> > > and report it somewhere?  I recall these info were captured somewhere, do
> > > we at least dump them into logs?
> > > 
> > > Thanks,
> > > 
> > 
> > I am interested in the outcome, but I think the approach shown here is fine, the amount of duplication seems minimal to me.
> > 
> > That said if we _have_ to keep libvirt in the picture, I think I see a possible alternative, but then the feature is not available to anyone that does not use libvirt. At the same time, if libvirt is not used, one is free to keep source QEMU alive and query the stats, like I think Proxmox does.
> 
> The problem is here from QEMU's perspective we have all the information,
> and "not quit" is the default behavior for src QEMU.  It means by default
> all info is available.. this is true for no matter what upper mgmt is in
> use.
> 
> > 
> > So with libvirt, I think we need a way to tell libvirt to keep the source QEMU alive before the actual switchover and the source QEMU is destroyed,
> > so that we can do everything that needs to be done from the platform layer before the source QEMU is lost.
> > It might go beyond querying for stats using QEMU and libvirt.
> > 
> > Something similar to (and potentially combined with) virDomainMigrateFlags VIR_MIGRATE_PAUSE, for example:
> > 
> > VIR_MIGRATE_NO_SOURCE_SHUTOFF
> > 
> > So one might say:
> > 
> > flags = VIR_MIGRATE_LIVE | VIR_MIGRATE_PERSIST_DEST | VIR_MIGRATE_UNDEFINE_SOURCE | VIR_MIGRATE_PAUSE | VIR_MIGRATE_NO_SOURCE_SHUTOFF
> > new_domain = virDomainMigrate3(old_domain, conn, params, nparams, flags)
> > 
> > and then we could do everything that needs to be done from the platform layer,
> > then issue a virDomainResume to start the domain on destination,
> > and maybe a virDomainDestroyFlags on the original domain to terminate it on the source.
> > 
> > But I would still favor the simplicity and the overall applicability of this series from Trieu Huynh.
> 
> I still think it'll be great we only do accounting once, and above sounds
> like a libvirt question that I don't know the answer. Adding Jiri and
> libvirt list in case we can collect some inputs.
> 
> If you're looking for this feature, IMHO it'll be great if you can have a
> look at least from libvirt side to see if there's any blocker for
> collecting this info from src, then we can evaluate the rest. E.g. there's
> at least another option to forward statistic data from src to dest.  Then
> we don't worry on mismatched accounting, or when fixing / add new
> accounting we don't need to do it both sides, which will be awkward.
Hello Peter,
One specific use case where the source is completely unavailable is loading 
from a migration snapshot (non-live).
In this scenario, there is no active source QEMU to query_for_stats. The 
dst (IMHO) is the only entity that can report how long the loading took 
and how much data was actually processed from the snapshot file.
This use case is a little bit niche but still a valid one though, isn't it?
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > Claudio
> > 
> 
> -- 
> Peter Xu
> 
BRs,
Trieu Huynh

