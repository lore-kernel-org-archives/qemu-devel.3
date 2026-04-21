Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7430DF327A8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4Cr-0007CR-4w; Tue, 21 Apr 2026 02:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wF4Cp-0007CF-NS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wF4Co-0006S7-6Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776751409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjzrciRq/TcwKBPqJXuJKSmOrzYtTKk7Kb4SvLreyuk=;
 b=Qralrnm6a7e03B8ZDe36anUwHn19oC0ZMNVHwurC+YPk0VkEVwd031x4bQ8yDgAXN+FD+3
 EdlbiZzV4Oin1vTuNXCVInOr1YnzMfaR69Xycxuklz/kA0dlbD8jgb1DKuoG+/e45JPT9t
 MXJGkuOf/sy83h9NcAr4fJeka0P6uZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-STgpznYzPyS2jx5CUYt4Dg-1; Tue,
 21 Apr 2026 02:03:27 -0400
X-MC-Unique: STgpznYzPyS2jx5CUYt4Dg-1
X-Mimecast-MFC-AGG-ID: STgpznYzPyS2jx5CUYt4Dg_1776751406
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85D0719560BB; Tue, 21 Apr 2026 06:03:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E18180047F; Tue, 21 Apr 2026 06:03:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B482821E6A28; Tue, 21 Apr 2026 08:03:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v1] checkpatch: Allow spaces after all coroutine
 annotations
In-Reply-To: <20260420191356.4439-1-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 20 Apr 2026 16:13:56 -0300")
References: <20260420191356.4439-1-farosas@suse.de>
Date: Tue, 21 Apr 2026 08:03:23 +0200
Message-ID: <87340oalzo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> The coroutine annotations may be used in the declaration of function
> pointers, which triggers checkpatch due to the space before the
> parentheses. E.g:
>
>   int coroutine_fn (*run)(Job *job, Error **errp);
>                   ^
> The coroutine_fn annotation is already included in the list of terms
> where spaces are allowed. Add the other coroutine annotations:
> coroutine_mixed_fn and no_coroutine_fn.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> the next migration PR will trigger this
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b77bd69328..e1cf2ff23b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2441,6 +2441,7 @@ sub process {
>  			if ($name =~ /^(?:
>  				if|for|while|switch|return|case|
>  				volatile|__volatile__|coroutine_fn|
> +				coroutine_mixed_fn|no_coroutine_fn|
>  				__attribute__|format|__extension__|
>  				asm|__asm__)$/x)
>  			{

Reviewed-by: Markus Armbruster <armbru@redhat.com>


