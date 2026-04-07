Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00AFFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABU7-0005U4-Uf; Tue, 07 Apr 2026 14:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wABSZ-0002o3-IR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wA8Cs-0002Ht-Us
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775575149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taXHR2mcmnCYy3631kEFpdnTVlYfPnUg2+nSy9l8xDQ=;
 b=b4oT+rGbC/Dz/ONqcDnZS1+83820r0eRjYu2kYHORDain8dWbb70PG4dDZAmAXLc586LPk
 b/YyYmAmugNkD156D9C85hMFwIXOjabZ6zLPVzXg6oJx3Wh2PnLBJwrhSd+E5wx2oCiPMA
 iXBWKcGDV5N3QOx7AuIAyOnm40GUz94=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-ScQKdE-DOwKq1UpjPhAqFg-1; Tue, 07 Apr 2026 11:19:08 -0400
X-MC-Unique: ScQKdE-DOwKq1UpjPhAqFg-1
X-Mimecast-MFC-AGG-ID: ScQKdE-DOwKq1UpjPhAqFg_1775575148
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7a5f9d43c48so53888627b3.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775575148; x=1776179948; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=taXHR2mcmnCYy3631kEFpdnTVlYfPnUg2+nSy9l8xDQ=;
 b=PjigDYwv1o87h2JnOBlg4IABr3pxGEyafl8OrwAOqZPsFCa2FO59DGOZnS4ZQIyYaS
 nATpBo7JDStqrBhz7SMcEPHTWFTF9PV08cr2g7hM3uaLtgujM7BImk42JmBitfaA0XXq
 x4W7Z6Q0Pc1zq5XEB00fDFq9Tv2sTRNF/xQWdK92EgPfMGgrXBVvXqaX7DvE0an9r6hg
 PxjKRYL830jzfglzZVYaMfDJv4U8n5cfEbsiAeRlKum2w2U5PFuaMqyg0S/R3nuv5J+y
 3w6Cfam/aqRmAz53JSRgph42ak+Kr9aNVzMhqg9RvUCNrOxeFfN4s2dIWM7Dpi02KTqB
 cDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575148; x=1776179948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taXHR2mcmnCYy3631kEFpdnTVlYfPnUg2+nSy9l8xDQ=;
 b=hPTp10R+LAGrzUa14B/dc8nZpBhwfCL9OUESB0n9zhSL0Q1il+PR5ApS++vAtrEnss
 I62uZio6tW7jMtcdKetw0EvkJYmqeycq7sN5/EIe1i7NCid5Z8SkdwlalbcxskGyxHxk
 sO6m6GUQCgdZrXXXE+Rhu5rY0ofrdsPREp3Qx+PGgrPunjHKMXJAWrwTrrsLJVQApF/L
 cwnQy+xUoHNyXh3/jbMn5aEENQD1BhIkG0qYUD5loOIeYCUTn219MksCY9NVh1KqAZWE
 pJvBhdAPu3eVWcpctKCdLybtqMcc9mIRAbF9Xk+Lp5FeTIgVIilo81DShxgUCi8iiwEA
 Pw3Q==
X-Gm-Message-State: AOJu0YxPoEVNzgPZJ7DwJy2qmCbxbfZ+JzyszmjLz3QG+6x3jc4V+K1p
 Tr/UoHWD8YXw3hVd6E/4n036iYHLRG4WOio1DvWfl3AMJPZZse/CRth2Z2XoSB7sUfzESjG5PZs
 Q7xogFjMvUVMa583D1dGbw8QYytMNm7QKAk6c9mx5QKUB6mQyPjTeHgis
X-Gm-Gg: AeBDieshbEp9a9TnYip8DYM3c2cn7R/Go6YoRb1ITjLOGuQAMz+I0AFFq21bcBYx3xp
 k+sKfaeLhBRHGkCLrZmU7CZ7JipCxPZ1mO1rkKun8U6disZX+6hBgNgb3l5pWxlhAQlrhHTz2hX
 5FRHPvy27Ks3uN9K5prTcBg+DB+u9J6JPhWjCkU9mjklSxpP7XH19XWFETJ3hFmUKFBirJpgIme
 V0ZAaNTqmVUopTDcgG26mORhQhC92ZgWmauLvwUaFKYQc/3vPKb0bL++lhJjYgDgdBTs7uClFca
 54o42M6xGgRTINr8vpa1yrghy89IHpRZ7UNwLGM6c/zFP6bwr1W6CRbQQdUwcyikVCpOSpC5Nhb
 sc2/yDdycCZFHvceI3bLd8jjygY0Zw3veLQ4oYPM=
X-Received: by 2002:a53:dd12:0:b0:64f:fa9a:9016 with SMTP id
 956f58d0204a3-65048821503mr12737074d50.48.1775575147540; 
 Tue, 07 Apr 2026 08:19:07 -0700 (PDT)
X-Received: by 2002:a53:dd12:0:b0:64f:fa9a:9016 with SMTP id
 956f58d0204a3-65048821503mr12737011d50.48.1775575146881; 
 Tue, 07 Apr 2026 08:19:06 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aa70136e87sm60234876d6.22.2026.04.07.08.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:19:06 -0700 (PDT)
Date: Tue, 7 Apr 2026 17:19:01 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <adUfNiig4RptM2sS@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
 <acavsDOsAz0hmfvi@fedora> <ac6IRfYH7UCluuIt@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6IRfYH7UCluuIt@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-04-02 11:16, Peter Xu wrote:
> On Fri, Mar 27, 2026 at 05:43:24PM +0100, Juraj Marcin wrote:
> > On 2026-03-19 19:12, Peter Xu wrote:
> > > Allow modules to report data that can only be migrated after VM is stopped.
> > > 
> > > When this concept is introduced, we will need to account stopcopy size to
> > > be part of pending_size as before.
> > > 
> > > One thing to mention is, when there can be stopcopy size, it means the old
> > > "pending_size" may not always be able to reach low enough to kickoff an
> > > slow version of query sync.  While it used to be almost guaranteed to
> > > happen because if we keep iterating, normally pending_size can go to zero
> > > for precopy-only because we assume everything reported can be migrated in
> > > precopy phase.
> > > 
> > > So we need to make sure QEMU will kickoff a synchronized version of query
> > > pending when all precopy data is migrated too.  This might be important to
> > > VFIO to keep making progress even if the downtime cannot yet be satisfied.
> > > 
> > > So far, this patch should introduce no functional change, as no module yet
> > > report stopcopy size.
> > > 
> > > This will pave way for VFIO to properly report its pending data sizes,
> > > which was actually buggy today.  Will be done in follow up patches.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/migration/register.h | 12 +++++++++
> > >  migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
> > >  migration/savevm.c           |  7 +++--
> > >  migration/trace-events       |  2 +-
> > >  4 files changed, 62 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > index 2320c3a981..3824958ba5 100644
> > > --- a/include/migration/register.h
> > > +++ b/include/migration/register.h
> > > @@ -17,12 +17,24 @@
> > >  #include "hw/core/vmstate-if.h"
> > >  
> > >  typedef struct MigPendingData {
> > > +    /*
> > > +     * Modules can only update these fields in a query request via its
> > > +     * save_query_pending() API.
> > > +     */
> > >      /* How many bytes are pending for precopy / stopcopy? */
> > >      uint64_t precopy_bytes;
> > 
> > The comment suggests precopy_bytes should include iterable precopy and
> > also non-iterable precopy (stopcopy) bytes, however, all 3 are then
> > summed up for total_bytes.
> 
> Yes the current way to categorize dirty info isn't as clear, but it's the
> easiest so far based on the previous definition of must_precopy.  With
> that, it's natural to define must-stopcopy, which is separately accounted
> from "data that can be copied during stop, but also iterable / precopy-able".
> 
> > 
> > >      /* How many bytes are pending that can be transferred in postcopy? */
> > >      uint64_t postcopy_bytes;
> > > +    /* How many bytes that can only be transferred when VM stopped? */
> > > +    uint64_t stopcopy_bytes;
> > 
> > I was also wondering if having precopy_iterable_bytes,
> > precopy_non_iterable_bytes, and postcopy_bytes would be clearer, but
> > given that stopcopy is already a term for this in VFIO it is probably
> > fine.
> 
> Yes, your naming is better in some way.  However it can also be slightly
> confusing on precopy_non_iterable_bytes to represent stopcopy-only bytes.
> 
> IMHO we can leave the "hard problems" (naming..) for later as cleanups and
> fix the problem first.
> 
> > 
> > > +
> > > +    /*
> > > +     * Modules should never update these fields.
> > > +     */
> > 
> > Maybe splitting input and output parameters, or things which modules
> > should touch and output of the overall API into different
> > structures/simple parameters could be better instead of the comment.
> 
> One thing I can immediately do is making both "exact" and "total_bytes" to
> be consts, then force cast them only once when setting it.  Would that be
> slightly better?  Or any suggestions?

I think, moving the fastpath boolean out and passing it as a separate
parameter would help greatly with the input/output separation. Then, if
some modules even validate the condition in the comment, there's no
harm, it'll just get overwritten afterward with the correct value.

> 
> It's always an option to fix the problem first then think about how to make
> it prettier, rather than doing it in one shot.
> 
> So far, the immediate goal is to allow reporting VFIO remaining data and/or
> expected downtime in query-migrate.
> 
...


