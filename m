Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40430C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 06:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2mtH-0008UX-7G; Fri, 03 May 2024 02:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2mtF-0008UI-Bi
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2mtD-0005ih-Rp
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714719567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GktZvf0zWeykJzrZ74i3CPU4uxKKcwv6MHsiyt9tFWU=;
 b=NA7GEscTNOE6t0coK7nSKLqskslzZ5+QYN9dh2vRUgnpBXQIq7FUKEkf3NGZ1gnGUMrO/v
 TFyMJ5MufyObfEL2nLn+N9i3x09MAa95obspjivBSC+Z9ihRzpuL4Bgcy36PYNmRXWsFrh
 lhcWIq+ib3TnBUWzKxfQf5TPeJj7ilU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-HlefVUrwMpeK0r159a202g-1; Fri,
 03 May 2024 02:59:25 -0400
X-MC-Unique: HlefVUrwMpeK0r159a202g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99A0B3820EA1;
 Fri,  3 May 2024 06:59:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1D320296D3;
 Fri,  3 May 2024 06:59:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8847021E66E5; Fri,  3 May 2024 08:59:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Peter Xu <peterx@redhat.com>,  "Dr .
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PULL 13/13] hmp/migration: Fix documents for "migrate" command
In-Reply-To: <20240502202316.29924-14-farosas@suse.de> (Fabiano Rosas's
 message of "Thu, 2 May 2024 17:23:16 -0300")
References: <20240502202316.29924-1-farosas@suse.de>
 <20240502202316.29924-14-farosas@suse.de>
Date: Fri, 03 May 2024 08:59:23 +0200
Message-ID: <87bk5n1ius.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> From: Peter Xu <peterx@redhat.com>
>
> Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
> 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
> adding a Fixes to make life easier for the stable maintainer.
>
> When at it, slightly cleanup the lines, move "detach/-d" to a separate
> section rather than appending it at the end of the command description.
>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  hmp-commands.hx | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index ebca2cdced..484a8a1c3a 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -918,8 +918,13 @@ ERST
>  
>  
>  SRST
> -``migrate [-d]`` *uri*
> -  Migrate to *uri* (using -d to not wait for completion).
> +``migrate [-d] [-r]`` *uri*
> +  Migrate the current VM to *uri*.
> +
> +  ``-d``
> +    Run this command asynchronously, so that the command doesn't wait for completion.
> +  ``-r``
> +    Resume a paused postcopy migration.
>  ERST
>  
>      {

I have questions on this one.


