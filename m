Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95201F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtNu-00060y-KR; Thu, 09 Apr 2026 13:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAtNm-0005yw-5C
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAtNh-0000wy-SG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775756489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0p8aMjfA/pkJTXNKooNCnVbelA3KrsJqJyjArbsCDHg=;
 b=I/Ut1jS4uN/LaSQeUgkUjpTEmPqbRy5+0JEdvBiVkR408BSJG8JnzzMXMG06zugsCrQN3I
 HDLILRarhQ2G+QhZiip1zm4XQCOdMqUUZvChKqdLB1hk7RKJg0HSX+6lga/axJrAUPDaFJ
 8tsUM6X5yeBhM+WFsp6STgNw08ymGWw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-cqpDIFKFNhS35YEM7O9YLw-1; Thu, 09 Apr 2026 13:41:26 -0400
X-MC-Unique: cqpDIFKFNhS35YEM7O9YLw-1
X-Mimecast-MFC-AGG-ID: cqpDIFKFNhS35YEM7O9YLw_1775756485
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43cf5b4dac8so1169309f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775756485; x=1776361285; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0p8aMjfA/pkJTXNKooNCnVbelA3KrsJqJyjArbsCDHg=;
 b=c/WmC2fdzom3qGoh6s1pi2S3CQGrBLzbEkxpzOh429lE18JPwChKOKeTGcjMc37det
 U3NfVVz5y78sAUoyq1MJ+76NiaGvkbJ0IyOMKmcC70IXtrQgl+F+SJXKXZoVBeRJFUJD
 jl6eiLA/C2k/ZHo7iMktzqxrjkzps1SgzBbUdiMWl1f9LPtJRJnVMtRQl0d5uVMJzMWQ
 dV5ExLp6yFCne3cEal2P5q09RKWDP2a5cE+q+3xxNylt04Jtg72BEyGs9ivTmSRswMxU
 A35g2qbL8D6guagXs+Gb5edgmf6U/PE3fyB1LFMrzSOd2Yxyk/sW1zxmWbJqPoQQGrwM
 uGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775756485; x=1776361285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0p8aMjfA/pkJTXNKooNCnVbelA3KrsJqJyjArbsCDHg=;
 b=b0W0gRAzQ1IBcSxsibrYnC/OxJWoIMuI/fHTzFWNjbMhcrYZcj9XdP9JVVLd5MbFL4
 Vomgz3oPaNpwgnw13ecxfOpsexSrEDhZdY+rFmXiGNrbQzsJvijmcHfYGhRnMGwdgrCP
 GI2gonfhCieNkPu0kW3efzJNjCDqt4EzOQBZYPzBRI7dX2QaYZd//7oZuwIEalbtU0Y0
 IgEOoxjQBmIp9+Va9Lhpb99raq3Df/SflwNVY27Hz+y0azE337q7GOK1WEJGBYuzGyZK
 BbEe2hPjIRiPZ/TybEzfr+PQ4chyRRluvh/P5HtT6TjSLcrT7m0T1oJeGqoXkQjDnPRj
 FbBA==
X-Gm-Message-State: AOJu0YxFTNy3hgcZhTq+IWxkxGMpFUo/VRakDYZ4vEs+9RHPWuUYH5jS
 zyrXU+W0jFAskANNwPwMgiLn1XG3UBukhj8bbSMtAVyR6I+7NIbEacIK/DsjEhcE2I6wgaLOoxd
 uSDKI6KgjZ/PXQAoOo7rxM6CjjrdnwyxbzEX39oeJHZFU/T1ycVX+TwCO
X-Gm-Gg: AeBDiesVaDIC5s0MZGJdK9tKKzkEAlLiiQqITn9iXUYNUx6VK7rfNJmpIdSppHDvM6z
 /MdByY5Rrj/gtgVmJdnrzadLq3Xa2U7cgSu+MXopipQa/mZUn2JNOdlxc4emhPbKW7turlqkVkv
 C5CCg5rYfN+UKhJyTpPN0klvXiRc2VKmcg9T1NwrxOou/B+IX+VuDE13JxzT8SiQe0WOEQ0LVwd
 +XBq+eTRONcBfxrUdEvZ+CongYLaxjTPkPNOLtzZRS/JcaTYXtVgkw7drx/4lTU6MJcxXN/ObId
 4a/n4KKGSvS25ru6wJW23Txry440jm8fCBRrvqNRC+Y8GXflwSHcqHbeicFLO6pyE38y+tws7Zl
 cgtX353mbrkPuzUXRT0SHZK3BVMlZrl1VbjWvLhM=
X-Received: by 2002:a05:600c:42d1:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488a62d7745mr142449155e9.1.1775756485284; 
 Thu, 09 Apr 2026 10:41:25 -0700 (PDT)
X-Received: by 2002:a05:600c:42d1:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488a62d7745mr142448955e9.1.1775756484789; 
 Thu, 09 Apr 2026 10:41:24 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d532ed4dsm11300115e9.4.2026.04.09.10.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:41:23 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:41:21 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 13/14] migration/qapi: Introduce system-wise "remaining"
 reports
Message-ID: <adfktmCXsxrX-xRm@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-14-peterx@redhat.com>
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

On 2026-04-08 12:55, Peter Xu wrote:
> Currently, mgmt can only query for remaining RAM, not system-wise remaining
> data.  It was not a problem before, because for a very long time RAM was
> the only part that matters.
> 
> After VFIO migrations landed upstream, it may not be true anymore
> especially considering that there can be GPU devices that contain GBs of
> device states.
> 
> Add a new "remaining" field in query-migrate results, reflecting
> system-wise remaining data, which will include everything (e.g. VFIO).
> 
> This information will be useful for mgmt to implement generic way of stall
> detection that covers all system resources.  Say, when system remaining
> data does not decrease anymore for a relatively long period of time, then
> it may mean that there is a challenge of converging, so mgmt can act based
> on how this value changes over time (especially if sampled after each
> migration iteration).
> 
> Before this patch, "expected_downtime" almost played this role. For
> example, by monitoring "expected_downtime" at the beginning of each
> iteration can in most cases also reflect the progress of migration
> system-wise.  Said that, "expected_downtime" was always calculated based on
> a bandwidth value that can fluctuate a lot if avail-switchover-bandwidth is
> not used. This new "remaining" field will remove that part of uncertainty
> for mgmt.
> 
> With the new field, HMP "info migrate" now reports this:
> 
> (qemu) info migrate
> Status:                 active
> Time (ms):              total=12080, setup=14, exp_down=300
> Remaining (bytes):      1.36 GiB        <------------------- newline
> RAM info:
>   Throughput (Mbps):    840.50
>   Sizes:                pagesize=4 KiB, total=4.02 GiB
>   Transfers:            transferred=1.18 GiB, remain=1.36 GiB
>     Channels:           precopy=1.18 GiB, multifd=0 B, postcopy=0 B
>     Page Types:         normal=307923, zero=388148
>   Page Rates (pps):     transfer=25660
>   Others:               dirty_syncs=1
> 
> It should be the same value as RAM's remaining report when VFIO is not
> involved, and it should report more than that when VFIO is involved.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            |  4 ++++
>  migration/migration-hmp-cmds.c |  5 +++++
>  migration/migration.c          | 11 +++++++++++
>  3 files changed, 20 insertions(+)
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


