Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9E2CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 05:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBoAV-0000X8-BX; Thu, 23 Oct 2025 01:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBoAT-0000X0-Pf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBoAR-0003Ol-Es
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761198436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGGqJ0a9xI1phmDPNhzSdwqznxzjRp6AItckTqiqurc=;
 b=O7Kjes7WGd6sDDMBy12Lfg18woc+Wv01AZ9RAeuUJa8zF1QJ5sczZmYPSyZnBPn3ye6g4k
 jv4QupTWhNhOD6BgJ8QnUG79utfALOdKj/doNpTAjjIu5L07kEcKyCdbtq0Qgz6A6A1Wll
 IeqD4ymsxrHQPMzojIK1KvhBo4bdmCU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-l0exl2F4NCeb5-kmH2qF2Q-1; Thu,
 23 Oct 2025 01:47:15 -0400
X-MC-Unique: l0exl2F4NCeb5-kmH2qF2Q-1
X-Mimecast-MFC-AGG-ID: l0exl2F4NCeb5-kmH2qF2Q_1761198435
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE8C195608A; Thu, 23 Oct 2025 05:47:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 631AE180035A; Thu, 23 Oct 2025 05:47:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C81E721E6A27; Thu, 23 Oct 2025 07:47:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH] migration/qmp: Update "resume" flag doc in "migrate"
 command
In-Reply-To: <20251022190425.2730441-1-peterx@redhat.com> (Peter Xu's message
 of "Wed, 22 Oct 2025 15:04:25 -0400")
References: <20251022190425.2730441-1-peterx@redhat.com>
Date: Thu, 23 Oct 2025 07:47:11 +0200
Message-ID: <87cy6eb25c.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> It wasn't obvious how the resume flag should be used when staring at the
> QAPI doc.  Enrich it to be crystal clear.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..48856078db 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1732,7 +1732,10 @@
>  # @detach: this argument exists only for compatibility reasons and is
>  #     ignored by QEMU
>  #
> -# @resume: resume one paused migration, default "off".  (since 3.0)
> +# @resume: when set, resume one paused postcopy migration, using the new

Scratch "one" unless there can be more than one.

> +#     URI/channels specified to replace the old/broken channels.  The user
> +#     should make sure the migration is in "postcopy-paused" state before
> +#     the resume request.  Default "off".  (since 3.0)
>  #
>  # Features:
>  #

What happens when migration is not in state "postcopy-paused"?

Remind me, how can migration get into and out of this state?


