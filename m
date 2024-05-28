Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54674C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0rq-0002KW-3t; Tue, 28 May 2024 13:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC0ro-0002KA-LL
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC0rm-0005Ma-WC
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716918246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUI28UB0DAWVzOUljo+ktM/xeEOi+XHQL/rtwRaa4v0=;
 b=QuY/9gBJeJhxywKGTa0bwDvpJiuGZRzOX9VnR8dgf/xhYumkb9jni5vPBhjIOwH1ljLIcR
 kj+V0bGMQ8yfINuau+hKuZqFau6gkTC7A74pos0pVMC1io4SvZrmxvCsKFU9ghB22S18wy
 CDMGa6GwckW8JN1Nv7kOoMJkeIGnYPI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-O7fcety2MPCbAwO0XuIviQ-1; Tue, 28 May 2024 13:44:04 -0400
X-MC-Unique: O7fcety2MPCbAwO0XuIviQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab894d8211so3139966d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716918244; x=1717523044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUI28UB0DAWVzOUljo+ktM/xeEOi+XHQL/rtwRaa4v0=;
 b=Cu6G2ApyrAGftgMbkyUOr2FTIuuX7+vLSgs0xhrT6sCQHAk/yXj+FTgtynbh3bbNTc
 j8qmAWe8HrBjUn9M2+BZ5U/F0eG4lFVJLAXAWlAqkneW9kfQp4XrI+PyUAic4u1NEqxL
 5FrMcA9g/fNZeXojo5ojBTBZ9iMO7fbNBygXKeoIqiiAW5b8rGl9C5Am0EC+uNaTD0MW
 OuZwV1ZMVumMx6bwwVQzSybkZP2uA3bwQ3qnpR8Acy3GGXHcXpRDBKlk7t9ODMCb6pnC
 Ts45WI4oa/NGMiOtr/IKzROvrMP6fRQN1IPKB+uuZsdIZy3PRWFCKKPt42OlsINUsXuL
 r98Q==
X-Gm-Message-State: AOJu0YxBH0JYs0LH/3MKor2uf+vI9vmkJ6olNn+KMpFV01UX0hUkYl5G
 g+XldlroS6/8RB74vz+lcGbsy9py/V4e/Y7o8poEuYDEPqVU5YpfnTnf1cbh6eM96CLFo+PE9DX
 W9V7/DEmhoZReVJwzmyq5/qU+hnXaPv7iJ2RNYSfUH439zf9P4WHw
X-Received: by 2002:a05:6214:d6c:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6abcd0b4fbbmr145938496d6.2.1716918243673; 
 Tue, 28 May 2024 10:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYtXa+p5DbOA5pOD8KYk+ekxMJYUsa5qQES6ACjr7S9bj8HMVuySnh7V1NzjmE2vsEEGrXHQ==
X-Received: by 2002:a05:6214:d6c:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6abcd0b4fbbmr145938136d6.2.1716918242933; 
 Tue, 28 May 2024 10:44:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad60d9fb71sm41398946d6.13.2024.05.28.10.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:44:02 -0700 (PDT)
Date: Tue, 28 May 2024 13:44:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 07/26] migration: VMStateId
Message-ID: <ZlYX4BWLU19f1vaI@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
 <ZlTO9fVYG50r3XL9@x1n>
 <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Tue, May 28, 2024 at 11:10:03AM -0400, Steven Sistare via wrote:
> On 5/27/2024 2:20 PM, Peter Xu wrote:
> > On Mon, Apr 29, 2024 at 08:55:16AM -0700, Steve Sistare wrote:
> > > Define a type for the 256 byte id string to guarantee the same length is
> > > used and enforced everywhere.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/exec/ramblock.h     | 3 ++-
> > >   include/migration/vmstate.h | 2 ++
> > >   migration/savevm.c          | 8 ++++----
> > >   migration/vmstate.c         | 3 ++-
> > >   4 files changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> > > index 0babd10..61deefe 100644
> > > --- a/include/exec/ramblock.h
> > > +++ b/include/exec/ramblock.h
> > > @@ -23,6 +23,7 @@
> > >   #include "cpu-common.h"
> > >   #include "qemu/rcu.h"
> > >   #include "exec/ramlist.h"
> > > +#include "migration/vmstate.h"
> > >   struct RAMBlock {
> > >       struct rcu_head rcu;
> > > @@ -35,7 +36,7 @@ struct RAMBlock {
> > >       void (*resized)(const char*, uint64_t length, void *host);
> > >       uint32_t flags;
> > >       /* Protected by the BQL.  */
> > > -    char idstr[256];
> > > +    VMStateId idstr;
> > >       /* RCU-enabled, writes protected by the ramlist lock */
> > >       QLIST_ENTRY(RAMBlock) next;
> > >       QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> > 
> > Hmm.. Don't look like a good idea to include a migration header in
> > ramblock.h?  Is this ramblock change needed for this work?
> 
> Well, entities that are migrated include migration headers, and now that
> includes RAMBlock.  There is precedent:
> 
> 0 include/exec/ramblock.h   26 #include "migration/vmstate.h"
> 1 include/hw/acpi/ich9_tco. 14 #include "migration/vmstate.h"
> 2 include/hw/display/ramfb.  4 #include "migration/vmstate.h"
> 3 include/hw/hyperv/vmbus.h 16 #include "migration/vmstate.h"
> 4 include/hw/input/pl050.h  14 #include "migration/vmstate.h"
> 5 include/hw/pci/shpc.h      7 #include "migration/vmstate.h"
> 6 include/hw/virtio/virtio. 20 #include "migration/vmstate.h"
> 7 include/migration/cpu.h    8 #include "migration/vmstate.h"
> 
> Granted, only some of the C files that include ramblock.h need all of vmstate.h.
> I could define VMStateId in a smaller file such as migration/misc.h, or a
> new file migration/vmstateid.h, and include that in ramblock.h.
> Any preference?

One issue here is currently the idstr[] of ramblock is a verbose name of
the ramblock, and logically it doesn't need to have anything to do with
vmstate.

I'll continue to read to see why we need VMStateID here for a ramblock.  So
if it is necessary, maybe the name VMStateID to be used here is misleading?
It'll also be nice to separate the changes, as ramblock.h doesn't belong to
migration subsystem but memory api.

Thanks,

-- 
Peter Xu


