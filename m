Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4261AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM82Z-00073a-F2; Mon, 02 Jun 2025 12:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uM82Y-00073E-8h
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uM82W-0000DZ-CZ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748881767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UVkwtE0Hoie33pykd1y4AriAUK2qx+fyrxhY+CR/yIw=;
 b=KMTwF9EM6T9LFaJbS74o1jBIcV54RMEixCnJPwYucmmwFyOhoGKx3B7M2NRfJ+Er0am4BE
 RksE0Cr1+B5oXPmFeu6M3O9UUzsxANfGVY4KumHu6fSFijoLu/r9I2Z0/aML7pNOMov6+r
 IrNzJta7SIC3QYew1vD7KVc4YlcKJNg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-H2qRc5y5O4e6yGhAQ6DIUA-1; Mon, 02 Jun 2025 12:29:23 -0400
X-MC-Unique: H2qRc5y5O4e6yGhAQ6DIUA-1
X-Mimecast-MFC-AGG-ID: H2qRc5y5O4e6yGhAQ6DIUA_1748881763
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fac216872cso90329406d6.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 09:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748881763; x=1749486563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVkwtE0Hoie33pykd1y4AriAUK2qx+fyrxhY+CR/yIw=;
 b=mFUzbLEC1P7cbV4rQTTBoqGKKNpIr0QKJf8kRf4unQZyIov6gzFdPrcjjd0b8D/qZS
 CfmR8OXdWfqJDTCyLZpD+ORyQ6+k/L+Tn1suCfqkS7Hf8aUC9JWXmZd6QHefPuQlfXlG
 0SToU96Qf+tKv7W3SbWhmKZ+wWFyvRfogqRa8k4mVRl6teSFaq5N23IFjUXXNi67fbPR
 3yKt9r9jzjyIwpfNveXaU7xE+QMQs2Ffqcu+TnbDeptA7ES1Qg6vNIQnYyHAeDTPy6GY
 0lb+JwMNFi56AtZtzmG4k2GEL96mCYRBOnP+h1huHS+tuwhwG+UKSUuwEudlOodTOTtJ
 yQqA==
X-Gm-Message-State: AOJu0YxOamrzAiwzHsSoNIQGZcmEZfB/poX3HJjRt2XoTwPK9HcDV1nJ
 uNr64E/6gqtNwI4UPEDCCwOv6cluGiuVBLJLcoJlj9n+LlUdCGfeTe5xM6JH1xKYfJC9HvKYs8S
 Yp57DlzvUOIIX6vbvmsIbgICl4VgB3jJnBGRzZyi69KodJUfkbkFMz/DX
X-Gm-Gg: ASbGncuOsfRmd2xZt+fmhemkW2b/cjj5z/oNjtcdUpUj4WIGwZqGK77tJsQ41uE7Hn0
 V4KTuTfUPY5hwlKzURr8NBX6M8tiEUL8m6jMYF0ofEd6aPgphIHPHZ2PxKyzWSfCJm5fsEv8GHi
 54cOEnsVWQK7VN8FTt21sGJB7Lx0cc9KJMMyJZq+S4exrAxSeQ8l1mPPZPjpkvlwZigv3PKjiGx
 DSzXOIr6980pB/Z81m3NUNUmsPUaW/611oMUiw3dc6Rgw2paSwP47JWd6c9vkxExc6WKAF+N434
 QE4rpI0IejCOaQ==
X-Received: by 2002:a05:6214:cce:b0:6e8:f770:5045 with SMTP id
 6a1803df08f44-6fad1952bbemr231907396d6.28.1748881762686; 
 Mon, 02 Jun 2025 09:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72FlaxPUQvHZMQ+pWQzyAwOgGsJY5EA8NwA/EjXiFajgIzU4XcyZNrp5iwsFDWvi5MD4zLg==
X-Received: by 2002:a05:6214:cce:b0:6e8:f770:5045 with SMTP id
 6a1803df08f44-6fad1952bbemr231907096d6.28.1748881762317; 
 Mon, 02 Jun 2025 09:29:22 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d35186sm62898706d6.11.2025.06.02.09.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:29:21 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:29:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aD3RXsco8yR2mDV2@x1.local>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-9-peterx@redhat.com>
 <8734cilcj7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734cilcj7.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 02, 2025 at 11:26:36AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Blocktime so far only cares about the time one vcpu (or the whole system)
> > got blocked.  It would be also be helpful if it can also report the latency
> > of page requests, which could be very sensitive during postcopy.
> >
> > Blocktime itself is sometimes not very important, especially when one
> > thinks about KVM async PF support, which means vCPUs are literally almost
> > not blocked at all because the guest OS is smart enough to switch to
> > another task when a remote fault is needed.
> >
> > However, latency is still sensitive and important because even if the guest
> > vCPU is running on threads that do not need a remote fault, the workload
> > that accesses some missing page is still affected.
> >
> > Add two entries to the report, showing how long it takes to resolve a
> > remote fault.  Mention in the QAPI doc that this is not the real average
> > fault latency, but only the ones that was requested for a remote fault.
> >
> > Unwrap get_vcpu_blocktime_list() so we don't need to walk the list twice,
> > meanwhile add the entry checks in qtests for all postcopy tests.
> >
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json                   | 13 +++++
> >  migration/migration-hmp-cmds.c        | 70 ++++++++++++++++++---------
> >  migration/postcopy-ram.c              | 48 ++++++++++++------
> >  tests/qtest/migration/migration-qmp.c |  3 ++
> >  4 files changed, 97 insertions(+), 37 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 8b9c53595c..8b13cea169 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -236,6 +236,17 @@
> >  #     This is only present when the postcopy-blocktime migration
> >  #     capability is enabled.  (Since 3.0)
> >  #
> > +# @postcopy-latency: average remote page fault latency (in us).  Note that
> > +#     this doesn't include all faults, but only the ones that require a
> > +#     remote page request.  So it should be always bigger than the real
> > +#     average page fault latency. This is only present when the
> > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> > +#
> > +# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
> > +#     us).  It has the same definition of @postcopy-latency, but instead
> > +#     this is the per-vCPU statistics. This is only present when the
> 
> Two spaces between sentences for consistency, please.

Fixed.  There's another similar occurance in the last patch, I'll fix that
too.

> 
> > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> 
> I figure the the @i-th array element is for vCPU with index @i.  Correct?
> 
> This is also only present when @postcopy-blocktime is enabled.  Correct?

Correct on both.

> 
> Could a QMP client compute @postcopy-latency from
> @postcopy-vcpu-latency?

Not with the current API.

Right now, the reported values are per-vCPU average latencies and global
average latencies, not yet per-vCPU fault counts. Per-vCPU fault counts
will be needed to do the calculation.

I chose to export global average latency only because that should be the
most important one to me as of now.  The per-vCPU results are pretty much
side effect of how blocktime feature does accounting so far (which is based
on per-vCPU), so it's very low hanging fruit.

Thanks,

-- 
Peter Xu


