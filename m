Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC7C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1resW3-0001ek-Lm; Tue, 27 Feb 2024 03:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1resW1-0001cw-Ma
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1resW0-00083G-0v
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709021318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=siBLJGC4+B+bIev+aNIJOMOtFeBDcGiqNHIQTqF+QT0=;
 b=iko1nC1pMYD54ADtPaVG1ddKWN+rhYXc4BoBaksLZCImUCabQ7yhI8j2BzlrkN2uykDhEb
 jo+eTdWEKBcXYYuuG/Q6yMwUNzDzDw6jHFyJiD2oA4bpyuUsdcWsIJ/7dR9FWXaiyl4Z8M
 iEFAJQ71w4/EnB+8rseuuy+A6XnpSh8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-PdMIwgudOXOJY-gEhpPOTg-1; Tue, 27 Feb 2024 03:08:36 -0500
X-MC-Unique: PdMIwgudOXOJY-gEhpPOTg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-299180d546bso615936a91.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709021316; x=1709626116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siBLJGC4+B+bIev+aNIJOMOtFeBDcGiqNHIQTqF+QT0=;
 b=m8ul3p4k9TrLcs2uf3WVvtWMrbkVML6G++mvEBHtedo14ISfuCcxrV7dq0KP/PgAbb
 NJuJJdoARPkJdm+4h01GBUj5OsHR0CfMn+oH3dRRR2qrLeMRg2/8XuCCPNDUj2NSj3tU
 bpubcruSIBRhhea2eafCajJwiA77MoOR/EKbwOe/TjSX+yYSgeunwzjUl7WkFYF8kN3u
 mG3jXJvYpT0bdtHJB9Ya0Hz7mYrWSqE5w8n8caInvLSFVhCshfb1GZaw8OeioYqF7vwn
 FI7NFxwqwzsyYWTzGxcrLUmD6muM8O7ZAMC+zbf1EYyoGPTkI8PkOBQuMNr9NbFtpc3V
 RfEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIQwC4toA5lvJeBDyi0caRFbTIPWuLGR3C3YDaDbLtILqM9Rg3jRhWCcDi8UZbJ+xBGLpu+C+dSuD1EEljAq4Hdg99SeM=
X-Gm-Message-State: AOJu0YxMj4Zgmit9g9mPSN9NqGd7lLukKfW1LsYDFaPk6AqSAa/TaJVw
 H6P7q9T3EDYwrTq25lJPbjMA8YSNp5fqQjaKcGYfjCYDAzqF14QOjomPBBLhmoL5CcCJ4VDhMJQ
 vLAU5UknYxUzhGooy+6U6pb2y0IpnXVvDityfqGhlJqpS9zLXFJV2
X-Received: by 2002:a17:90a:15cf:b0:298:bc90:3b69 with SMTP id
 w15-20020a17090a15cf00b00298bc903b69mr7223151pjd.3.1709021315873; 
 Tue, 27 Feb 2024 00:08:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwryGbqQwgtqTtdDQXBfi/Ur75U43mLx/8OCVBZIvg6SB/IsaeC3R1vHDa01xOmjf5GVPyZg==
X-Received: by 2002:a17:90a:15cf:b0:298:bc90:3b69 with SMTP id
 w15-20020a17090a15cf00b00298bc903b69mr7223132pjd.3.1709021315537; 
 Tue, 27 Feb 2024 00:08:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p16-20020a17090a429000b0029967638141sm5806363pjg.37.2024.02.27.00.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 00:08:35 -0800 (PST)
Date: Tue, 27 Feb 2024 16:08:25 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1] migration: export fewer options
Message-ID: <Zd2YeQAXhUCZzYdM@x1n>
References: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
 <87cysjllln.fsf@pond.sub.org>
 <65ec5d47-d27a-4633-ad3c-aec8a7710f8b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65ec5d47-d27a-4633-ad3c-aec8a7710f8b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 26, 2024 at 09:41:15AM -0500, Steven Sistare wrote:
> On 2/26/2024 2:40 AM, Markus Armbruster wrote:
> > Steve Sistare <steven.sistare@oracle.com> writes:
> > 
> >> A small number of migration options are accessed by migration clients,
> >> but to see them clients must include all of options.h, which is mostly
> >> for migration core code.  migrate_mode() in particular will be needed by
> >> multiple clients.
> >>
> >> Refactor the option declarations so clients can see the necessary few via
> >> misc.h, which already exports a portion of the client API.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >> I suggest that eventually we should define a single file migration/client.h
> >> which exports everything needed by the simpler clients: blockers, notifiers,
> >> options, cpr, and state accessors.
> >> ---
> >> ---
> >>  hw/vfio/migration.c             |  1 -
> >>  hw/virtio/virtio-balloon.c      |  1 -
> >>  include/migration/misc.h        |  1 +
> >>  include/migration/options-pub.h | 24 ++++++++++++++++++++++++
> >>  migration/options.h             |  6 +-----
> > 
> > Unusual naming.  We have zero headers named -pub.h or -public.h, and
> > dozens named like -int.h or -internal.h.  Please stick to the existing
> > convention.
> 
> In the spirit of minimizing changes, I went that route to avoid renaming the 
> existing migration/options.h and its references:
> 
> 0 migration/block-dirty-bit 82 #include "options.h"
> 1 migration/block.c         32 #include "options.h"
> 2 migration/colo.c          37 #include "options.h"
> 3 migration/migration-hmp-c 35 #include "options.h"
> 4 migration/migration.c     68 #include "options.h"
> 5 migration/multifd-zlib.c  21 #include "options.h"
> 6 migration/multifd-zstd.c  21 #include "options.h"
> 7 migration/multifd.c       29 #include "options.h"
> 8 migration/options.c       30 #include "options.h"
> 9 migration/postcopy-ram.c  40 #include "options.h"
> a migration/qemu-file.c     33 #include "options.h"
> b migration/ram-compress.c  37 #include "options.h"
> c migration/ram.c           63 #include "options.h"
> d migration/rdma.c          40 #include "options.h"
> e migration/savevm.c        71 #include "options.h"
> f migration/socket.c        30 #include "options.h"
> g migration/tls.c           25 #include "options.h"
> 
> But I take your point.
> 
> Peter, which do you prefer?

From statistics, "-internal.h" wins "-int.h":

$ git grep "\-internal.h" | wc -l
135
$ git grep "\-int.h" | wc -l
3

> 
>   A. rename: migration/options.h -> migration/options-internal.h 
>      rename: include/migration/options-pub.h -> include/migration/options.h
> 
>   B. rename: include/migration/options.h -> include/migration/client-options.h
> 
> I prefer B. If you prefer B, but want a different file name, please choose the
> final name.

Personally I don't have a strong opinion on the name.  I'll see whether
Markus has any comment.

[and of course, I removed this patch from -staging queue to keep the
 discussion going..]

-- 
Peter Xu


