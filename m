Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEEACD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 05:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTvNt-0004B9-Gz; Mon, 01 Jun 2026 01:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wTvNq-00046g-DJ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 01:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wTvNn-0000CR-U9
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 01:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780292413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+6pbvKNzFKYZRJQDkDBsLkAACVOBs1iQoHgxs+InVSg=;
 b=UwwihltXJPWidfxuHhnJIc1bkoiyIv4HNHvmrWE5NNinoCz1SE3Sa0tXrq4wTWlPgJICfM
 ygCWkmoY2/E85FFiyPvbcqqcweafxQnFp+hSm1+YSo0mtoIRPckkkznH+tMYhXG68D7ydi
 3ThrLAA2ovEA5u+7VkVcdt4LP5Tj4wg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-JwITh2fMMFCSKVmK6dw3GQ-1; Mon,
 01 Jun 2026 01:40:12 -0400
X-MC-Unique: JwITh2fMMFCSKVmK6dw3GQ-1
X-Mimecast-MFC-AGG-ID: JwITh2fMMFCSKVmK6dw3GQ_1780292411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0D89195609E; Mon,  1 Jun 2026 05:40:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EAC51800465; Mon,  1 Jun 2026 05:40:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8E8121E6A01; Mon, 01 Jun 2026 07:40:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH] qapi/migration: Remove @cpr-exec-command doc in
 MigrationParameter
In-Reply-To: <20260528201236.359452-1-peterx@redhat.com> (Peter Xu's message
 of "Thu, 28 May 2026 16:12:36 -0400")
References: <20260528201236.359452-1-peterx@redhat.com>
Date: Mon, 01 Jun 2026 07:40:07 +0200
Message-ID: <87pl2ayg20.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> This parameter was developed during similar window when the deduplication
> work was done, hence overlooked.  MigrationParameter is already in
> exception list of doc sanity checker.

Pointing to the exact commit(s) would be nice.  Not worth a respin,
consider amending when you merge.

>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 27a7970556..e8756308cf 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -804,10 +804,6 @@
>  # Migration parameters enumeration.  The enumeration values mirror the
>  # members of @MigrationParameters.
>  #
> -# @cpr-exec-command: Command to start the new QEMU process when @mode
> -#     is @cpr-exec.  The first list element is the program's filename,
> -#     the remainder its arguments.  (Since 10.2)
> -#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and

Reviewed-by: Markus Armbruster <armbru@redhat.com>


