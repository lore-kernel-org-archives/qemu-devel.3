Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396CDD3901B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 21:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8Bo-0000Sa-IQ; Wed, 14 Jan 2026 16:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vg8Bm-0000Jn-7w
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:14:02 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vg8Bk-00074d-4U
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=rtGmT3WgCLgg9joCUg6jpgup4t9EbfdfHWaRCyAWx4U=; b=CnU1yISTEQ/wI86O
 H1VdT6vRn67chy6BOGPnib8aFHtHGB7gQPJvhewwHDEFpPOvRrm/AFmsveuNDaR72MySBYj0RVG6F
 XRnJTHLnXwFNH8kpMY1LzVPqXgxeAx8/QlYquoVjXbub8nr4mMx7t6NNsc2hNJr15VIPkhLA8MG4W
 p+yJ+Yfl/mxcDPpAUBIPf5fthlvL4t7yhNwtwduYUzYW+6GTOXlrr9hssdOrNetokPXmu/sQJIJei
 /0vY8t1cY6V2DnI/TR4rQSMJEmtvq/MP+4WzEW8QhkVu6X6zIO0+zYQ5fKjhnDHoBn0GXdLdijqaY
 pb8j54CaFOMLMED5Ew==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vg8Bf-0000000En5g-2m8g;
 Wed, 14 Jan 2026 21:13:55 +0000
Date: Wed, 14 Jan 2026 21:13:55 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWgHE2-UuWKMkUP5@gallifrey>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114195659.2543649-2-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 21:10:47 up 79 days, 20:47,  3 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Peter Xu (peterx@redhat.com) wrote:
> COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  One
> reason might be that we don't have an unit test for COLO (which we
> explicitly require now for any new migration feature).  The other reason
> should be that there are just no more active COLO users, at least based on
> the latest development of QEMU.
> 
> I don't remember seeing anything really active in the past few years in
> COLO development.
> 
> Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
> email to qemu-devel is in Dec 2021 where the patch proposed an email
> change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
> 
> We've discussed this for a while, see latest discussions here (our thoughts
> of deprecating COLO framework might be earlier than that, but still):
> 
> https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de
> 
> Let's make it partly official and put COLO into deprecation list.  If
> anyone cares about COLO and is deploying it, please send an email to
> qemu-devel to discuss.

A shame, but it probably makes sense; it was always quite tricky to get
going.

Dave

> Otherwise, let's try to save some energy for either maintainers or
> developers who is looking after QEMU. Let's save the work if we don't even
> know what the work is for.
> 
> Cc: Lukáš Doktor <ldoktor@redhat.com>
> Cc: Juan Quintela <quintela@trasno.org>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: zhanghailiang@xfusion.com
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst | 6 ++++++
>  qapi/migration.json       | 5 ++---
>  migration/options.c       | 4 ++++
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7abb3dab59..b499b2acb0 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -580,3 +580,9 @@ command documentation for details on the ``fdset`` usage.
>  
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +COLO migration framework (since 11.0)
> +'''''''''''''''''''''''''''''''''''''
> +
> +To be removed with no replacement, as the COLO migration framework doesn't
> +seem to have any active user for a while.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 201dedd982..3c868efe38 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,8 +531,7 @@
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>  #
> -# @deprecated: Member @zero-blocks is deprecated as being part of
> -#     block migration which was already removed.
> +# @deprecated: Member @zero-blocks and @x-colo are deprecated.
>  #
>  # Since: 1.2
>  ##
> @@ -540,7 +539,7 @@
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>             { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
>             'events', 'postcopy-ram',
> -           { 'name': 'x-colo', 'features': [ 'unstable' ] },
> +           { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' ] },
>             'release-ram',
>             'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..318850ba94 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -580,6 +580,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>          warn_report("zero-blocks capability is deprecated");
>      }
>  
> +    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> +        warn_report("COLO migration framework is deprecated");
> +    }
> +
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>          error_setg(errp, "QEMU compiled without replication module"
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

