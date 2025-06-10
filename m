Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BFEC71132
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29C-0006N8-HZ; Tue, 10 Jun 2025 12:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOzCN-0000KY-VU
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOzCJ-0007wP-BO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749562765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fuo/g3L8newfPUamaEA37K/Sd1YQ22XU6IMW+4F8v6c=;
 b=Z36KGY9pfwiPDJlLKyC7IYqjRiV3bJEHA2NQSejXH/M4KwLAAsk/bmW0aRdSjrI7UnV6aF
 tYUm/ssbkq+jZcGdclSAUnLLOqShVS4pUQlLpcEC7kY31H5tb3Nkl96CNIU/dwiCQ+uacz
 lBfBRJ5uOXEuZLHLSW8pb7OmmVTwAI8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-goNoXSiSNjSyv9_6eGUCtQ-1; Tue, 10 Jun 2025 09:39:23 -0400
X-MC-Unique: goNoXSiSNjSyv9_6eGUCtQ-1
X-Mimecast-MFC-AGG-ID: goNoXSiSNjSyv9_6eGUCtQ_1749562763
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fabb9286f9so103768046d6.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 06:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749562763; x=1750167563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fuo/g3L8newfPUamaEA37K/Sd1YQ22XU6IMW+4F8v6c=;
 b=YMC2AhJHNtjhoN+83ZPUF9YklscGhKuZConeCo7k4wuQ23oNPBuEBrK+DIOcHHCkBT
 iWgwEd3oipp7jcZkQZUcRsaJFA61zTifS1wt5X82B/nQizHHArQgcZA87bMRf8QcdZ2v
 S5gcmaew0ES4pwrMONlkjJ0qNFoVV64guy+yDdc455yghzcH9Jh95rloB9wlnCnov6Em
 tGnZ/c+kFrOXKgQiQVdl2PIHxdqqIk8MEHEQL1RlJEuUj7NrdaHUY6K1ICakp07tVyqk
 OR8nG9iUVodO8I21otd/X2oc0ZwXAnjBXeITdouo1Ozcyyp/QMSn8Y5jyFi5hAPla49k
 4Zew==
X-Gm-Message-State: AOJu0Yz3e+WcNo+vKERnWqiO5VpIBmuSuqizgHr1bIq1XXJBEYgHj/CC
 t92DVns8FvHsixtBpUr7MQYfuUtOzgDG7oShjehGVsfvVemKaFrdnkWBu+EnRj4d1xc42UZ+63m
 L+FlmNIyl+Fh6obLQIfFe+2wQ1IJWZR+U/FshcrSQPtJMiIVSOG2itmfY
X-Gm-Gg: ASbGncsvrd0JrZa84sPwD2J/4toR9bkYDmpV/F1Q+LH8nTkBLZjovYWrjhCbG8rnQ7r
 Pw2HwjmICHWU3gH9+xLRT+8KwHG2DKgsvwnabuuoeM3VUW+sZiSXbf3StFpICbslEqREMmHJJdX
 +aJ4aun9l9Qer6cSH+1pTULmXSOKgYVBnGBFlosGj07jkkKlAm8cjzKLzmC2q8UxPgIoFFIBNbQ
 enc9IV2IvXPIulQuDjEWCrbWRE/Pw3an0klossl9kXnFSDKw4MELZNZ9ez1flyORIYo0HhLRapQ
 2CdHXXj0i8bVXg==
X-Received: by 2002:a05:6214:4119:b0:6fa:cdc9:8b04 with SMTP id
 6a1803df08f44-6fb08fdbc50mr264218956d6.13.1749562762998; 
 Tue, 10 Jun 2025 06:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE33yoYFgj4zrNqQbUUTnF2iAejdImcwoMJBx8YLSbMDf/tIiUzznSUiXsJlNz2sSaIOqORHQ==
X-Received: by 2002:a05:6214:4119:b0:6fa:cdc9:8b04 with SMTP id
 6a1803df08f44-6fb08fdbc50mr264218616d6.13.1749562762562; 
 Tue, 10 Jun 2025 06:39:22 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25a609092sm687827785a.65.2025.06.10.06.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 06:39:22 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:39:20 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aEg1iP9iXlYsQP0C@x1.local>
References: <20250609191259.9053-1-peterx@redhat.com>
 <20250609191259.9053-9-peterx@redhat.com>
 <aEd3d07hQYXWc4eq@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEd3d07hQYXWc4eq@gallifrey>
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

On Tue, Jun 10, 2025 at 12:08:23AM +0000, Dr. David Alan Gilbert wrote:
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 4963f6ca12..e95b7402cb 100644
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
> > +#     this is the per-vCPU statistics.  This is only present when the
> > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> 
> I wonder if even 'us' is too big; given you have 64bits to play with, and your
> examples show some samples landing in under 10us, perhaps it's best
> to at least define the qapi  fields as ns, even if you keep with the same
> buckets for now?

The few <10us ones should pretty much be outliers, I'd expect it happened
because some faulted pages got lucky to be migrated (in the background
stream rather than the preempt stream) right after sending the request.

But it's still a fair point, especially if there's nothing to lose to
switch to nanoseconds here when we have 64bits fields.. I also did a quick
check online, looks like RDMA over 100Gbps NIC may actually do a fast
round-robin transaction within a few microseconds indeed at least with zero
loads..

Let me do the switch in v3.

While at it, when thinking of possible future unit/format changes in the
report, maybe I should also mark all of these fields experimental from the
start? So we don't necessarily need to maintain the ABI - the expectation
is even if a mgmt would like to fetch those they should only fetch and dump
it into log so that human can read later only for debugging purposes.

-- 
Peter Xu


