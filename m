Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D811CC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27j-0002m9-BS; Tue, 10 Jun 2025 12:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOzeL-0004HY-LQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOzeE-0002my-WA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749564495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dIr303QJUW0o2vgHIFICfqu91Hv6YzHVoizhZsQAHBY=;
 b=jEjX98T0ul2TdkyUXtD1S4ksBBlPwqkckDVq6U/GiqmI2gYqpO8aB0pBpwII4Bb7z9+tUk
 IviT3UP7ginyE/OCCS/eBOGNgWqhpo8Dd2IhvStv05bXvgfh7v9sYtI3snI5THiY6Gr0PG
 NgjJimthAJJWNu5ag0DjZIya3xqCui4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-F_Vwh1hrMqCfRqsuT1Ppkg-1; Tue, 10 Jun 2025 10:08:14 -0400
X-MC-Unique: F_Vwh1hrMqCfRqsuT1Ppkg-1
X-Mimecast-MFC-AGG-ID: F_Vwh1hrMqCfRqsuT1Ppkg_1749564494
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7d38fe2eff2so442343085a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 07:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564494; x=1750169294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIr303QJUW0o2vgHIFICfqu91Hv6YzHVoizhZsQAHBY=;
 b=PliA7HWbk2UHvTa+nWHbkRPLv4oA3t99kseZ8JKh7PhO9ZSDePymehvG1XswooXrEg
 sSFZdNroYuEWfCHUXH9U3sMucgoFz8M2N14xa21BAg2Pcp98LHb+em4D07vuVtCOnk+X
 ZFRsX/7nuHAb9+17bllDja9udhTUuKSBfqzFIaefw4hMqsDkEhfHl/cpCTPWanF4KtKR
 fZ0V8GOCKtIN+JNLPR+aVReTtHouPHweLEQbL5DQtLXHcqwvulFwpoXpBwWeBe8n71Zc
 LphK4ZoSNGvlgsGh4n+wDGATMR2d00RaROidU5zyePVdAADvQLmErh2UL1rYiYXmGhZQ
 4tag==
X-Gm-Message-State: AOJu0Yx/nbVSmYq/DJP71YYe7bAErFA6HmnXr1QggPp63UGOLedXTDdO
 tqCOdavP+GqKE1j1CasFCsvL3+bDNx0c+gzoeA1/gH5k3a3R3+VdN+IoYNZP1KJUPHkKQh1ScB4
 eba4LpHTry+2R1AnNrkW1ouIb6oc/qKMHogREdmvL1uWMyVcR5dg5tIs+
X-Gm-Gg: ASbGncuhDcKoGrwuftYzfJhCqTB6i8qDWI1emWrw0DcOP6LBU6YvNS9iYsLI+plvN3F
 7ARK9Qv9juT82E1NoAvqA8WA8kMPa00Yd+g3PRVt3TWSdo3bogoX8N1oggqVpUJk4rvKzE/OPKe
 cCepQT3Afmo6JjcgcC3pD3fF9r630KHqsHeJMtEijitSejmktB+SOylB+HT5AE/knLOP3pZ9nuE
 fDAvzFyQIQeKHGNz3BL3kbg4yWHJPbX8Iaypm9tYE6ZE+0G0qvy5oKKRxiNvRg6kCeLa3mplHDJ
 3iZiaLbXOEVxuw==
X-Received: by 2002:a05:620a:84c4:b0:7d2:15f:f976 with SMTP id
 af79cd13be357-7d39f65b4fbmr413938285a.52.1749564493600; 
 Tue, 10 Jun 2025 07:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHONfdQLSyuS+//Immg8bqzZZWdRf/UXWf50Kwr5hTNv4bS7RFr/JLGXIbT1wG9I7oNVPBfIQ==
X-Received: by 2002:a05:620a:84c4:b0:7d2:15f:f976 with SMTP id
 af79cd13be357-7d39f65b4fbmr413933785a.52.1749564493180; 
 Tue, 10 Jun 2025 07:08:13 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3916294e4sm356748385a.4.2025.06.10.07.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:08:12 -0700 (PDT)
Date: Tue, 10 Jun 2025 10:08:09 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aEg8SbNKY0MzLBr4@x1.local>
References: <20250609191259.9053-1-peterx@redhat.com>
 <20250609191259.9053-9-peterx@redhat.com>
 <aEd3d07hQYXWc4eq@gallifrey> <aEg1iP9iXlYsQP0C@x1.local>
 <aEg45Bptc4QGq5gK@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEg45Bptc4QGq5gK@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 10, 2025 at 01:53:40PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Jun 10, 2025 at 12:08:23AM +0000, Dr. David Alan Gilbert wrote:
> > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > index 4963f6ca12..e95b7402cb 100644
> > > > --- a/qapi/migration.json
> > > > +++ b/qapi/migration.json
> > > > @@ -236,6 +236,17 @@
> > > >  #     This is only present when the postcopy-blocktime migration
> > > >  #     capability is enabled.  (Since 3.0)
> > > >  #
> > > > +# @postcopy-latency: average remote page fault latency (in us).  Note that
> > > > +#     this doesn't include all faults, but only the ones that require a
> > > > +#     remote page request.  So it should be always bigger than the real
> > > > +#     average page fault latency. This is only present when the
> > > > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> > > > +#
> > > > +# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
> > > > +#     us).  It has the same definition of @postcopy-latency, but instead
> > > > +#     this is the per-vCPU statistics.  This is only present when the
> > > > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> > > 
> > > I wonder if even 'us' is too big; given you have 64bits to play with, and your
> > > examples show some samples landing in under 10us, perhaps it's best
> > > to at least define the qapi  fields as ns, even if you keep with the same
> > > buckets for now?
> > 
> > The few <10us ones should pretty much be outliers, I'd expect it happened
> > because some faulted pages got lucky to be migrated (in the background
> > stream rather than the preempt stream) right after sending the request.
> > 
> > But it's still a fair point, especially if there's nothing to lose to
> > switch to nanoseconds here when we have 64bits fields.. I also did a quick
> > check online, looks like RDMA over 100Gbps NIC may actually do a fast
> > round-robin transaction within a few microseconds indeed at least with zero
> > loads..
> > 
> > Let me do the switch in v3.
> > 
> > While at it, when thinking of possible future unit/format changes in the
> > report, maybe I should also mark all of these fields experimental from the
> > start? So we don't necessarily need to maintain the ABI - the expectation
> > is even if a mgmt would like to fetch those they should only fetch and dump
> > it into log so that human can read later only for debugging purposes.
> 
> Yeh I think that's OK, although perhaps another way would be to add
> a field indicating the time of the first bucket; i.e. you could specify
> that all the values are in ns, but have first-bucket=1000 to be exactly
> the same as you have it now.

Right, that should also be better than the current.  Marking experimental
could be slightly more flexible though, e.g. once we want to report in
other formats other than power-of-two buckets.  I'll think about it.

Thanks for the input!

-- 
Peter Xu


