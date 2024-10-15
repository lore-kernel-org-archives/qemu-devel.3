Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9FAD1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jWN-0001we-0z; Tue, 15 Oct 2024 11:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0jWL-0001wQ-2X
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t0jWJ-0005vE-Ep
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729006294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z3rRbIFC+inCYMMG5/O0N+L1uPkWbvKe+Q7zHa+EbiY=;
 b=bKwyEBU4as0Q2A06MAiv8PzuXMPoIrZp7j0KHCNKNoVS++SlBYPqh0uL7Z3NZncsHu8wU2
 Dd1+2u7lyEC71gB/TH8rybMryS5bYutYhk85lf/zOVeYxV/mw+CPrAvlyCTdA2sP2s9pTf
 UBSGxNvpW4q0zVU1lty1epOxOSZQ4Ss=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-tfm_ppsfM7euCw35lpqVXw-1; Tue, 15 Oct 2024 11:31:32 -0400
X-MC-Unique: tfm_ppsfM7euCw35lpqVXw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ac8f684cdaso1022686685a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729006292; x=1729611092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3rRbIFC+inCYMMG5/O0N+L1uPkWbvKe+Q7zHa+EbiY=;
 b=h9evgsbLK3kXOiQxhPbR+oDTUstrEdo8YDPEDNvM1bNwUb1gv38u7F/X4wJt8qLH3k
 FHaVdyxm3GztxtIZJIa/U4q8T2spPVty70IOseguQzyRX24lVB47Lj0DASYA9C1aaQw3
 dAHOMSk0TBsonAYHlCWOarwUfv5prByQnlygUfWQ2ibVvugldxBfuf47txTHAbVtFL0c
 FWflCgozwnDiVni/LkD7LRZdAoUoyFtIQ3Xb7n8kWVMDsjtzSVGpvgrC/UpFGLyymxVv
 y8kB7Jq2Fa9aU2wD2lK+4KJAiTYVn3tpbi2Km3ZzmaVdOZ5eIISYnjwFSP1LHajlHx5k
 qjoA==
X-Gm-Message-State: AOJu0YzQIyskQvYr9Nr6SBrxNP0qi1p9K2Mtkpu/yekzWiPYFaoZFohV
 uGWwvQLdXaCBdoz5Loxf7Kc6wNq/p/4rtllKr3rnxJxf1QHYejxoHQOKSaO9Nk9dgRsrCZXZNsd
 VHszFIn2QyhgRTdLLeZ+0oG3EiYD1kw+9UdooT9ZfrVibZxO20pXJ
X-Received: by 2002:a05:620a:2996:b0:7a2:2cc:83d7 with SMTP id
 af79cd13be357-7b11a35f8b4mr2339527385a.6.1729006291747; 
 Tue, 15 Oct 2024 08:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnXe0Acr5MZJ9EycX45/R41Htt9WJdrH5p0wfszuBz1/jtCt8pUC4279rF4kUaEDFyJrVd/w==
X-Received: by 2002:a05:620a:2996:b0:7a2:2cc:83d7 with SMTP id
 af79cd13be357-7b11a35f8b4mr2339521785a.6.1729006291205; 
 Tue, 15 Oct 2024 08:31:31 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13702f51bsm77492585a.114.2024.10.15.08.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 08:31:30 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:31:28 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: Re: [PATCH] migration: Remove interface query-migrationthreads
Message-ID: <Zw6K0HEYYX49G7X7@x1n>
References: <20241011153417.516715-1-peterx@redhat.com>
 <Zwlklx6232nW6ln5@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zwlklx6232nW6ln5@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 11, 2024 at 05:47:03PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This reverts two commits:
> > 
> > 671326201dac8fe91222ba0045709f04a8ec3af4
> > 1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1
> > 
> > Meanwhile it adds an entry to removed-features.rst for the
> > query-migrationthreads QMP command.
> > 
> > This patch originates from another patchset [1] that wanted to cleanup the
> > interface and add corresponding HMP command, as lots of things are missing
> > in the query report; so far it only reports the main thread and multifd
> > sender threads; all the rest migration threads are not reported, including
> > multifd recv threads.
> > 
> > As pointed out by Dan in the follow up discussions [1], the API is designed
> > in an awkward way where CPU pinning may not cover the whole lifecycle of
> > even the thread being reported.  When asked, we also didn't get chance to
> > hear from the developer who introduced this feature to explain how this API
> > can be properly used.
> 
> One suggestion for replacing it, might be a way for a management interface
> to add threads to a thread-pool, prior to migration; and then have migration
> use threads from that pool rather than creating it's own.

It could work indeed.  Though that may require some pool QMP command to
either specify cpu pinning or making the thread all name-based, so that the
names need to be passed over to migration again with another API, which
might be slightly complicated.

I think if we do want to support this feature seriously, either we bare
with that short window (can still use a hack to make bw=0 prior to that),
or we can add one stage of migration so it SETUPs everything and halt there
just like what -S for QEMU in general, until another command to kick off
the migration process.

I remember CPR had such a discussion, that if we have such a mechanism, CPR
state (which must be sent earlier than migration stream) can be sent during
this SETUP-only peroid too.  Since we don't have that, the latest
CPR-transfer is relying on something else (a HUP event on CPR channel sent
from dest by closing it) to identify that window, so that src will block at
SETUP phase until the HUP event from destination CPR channel arrives,
saying "cpr state is loaded, let's continue the migration process".

Thanks,

-- 
Peter Xu


