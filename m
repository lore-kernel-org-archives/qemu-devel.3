Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DFFC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 11:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roii4-0005cE-2n; Mon, 25 Mar 2024 07:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1roii1-0005bP-Gs
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1roihz-00031K-MK
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 07:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711366902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Be9ZqRKJrAN435G9s8Qnc2WcheUNHnjNPs0LtW+0N8=;
 b=P359qGUoKdWbQlywweT0jGx+qSQtFiXd7DRg407Brf3jjI70fKdadSDflmczHBfoSxnNEB
 2veptwrXbO+865fSjU2QsOXp1aj/oyKJ76TEBJM0+qXd774CrRHfh9YscQH2p6DthnkGlV
 QWxX2LjYxYfn9tKVHmn5LzTL4zEAXo4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-7pDvEKkDPpyKe4FRMM9Ltg-1; Mon,
 25 Mar 2024 07:41:40 -0400
X-MC-Unique: 7pDvEKkDPpyKe4FRMM9Ltg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9388F3815EF5
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 740F4492BD3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:41:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74C1421E669D; Mon, 25 Mar 2024 12:41:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi: document leftover members in qapi/stats.json
In-Reply-To: <20240325104504.1358734-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 25 Mar 2024 11:45:04 +0100")
References: <20240325104504.1358734-1-pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 12:41:35 +0100
Message-ID: <87il1amtcg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qapi/stats.json | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/stats.json b/qapi/stats.json
> index ce9d8161ecb..578b52c7ef7 100644
> --- a/qapi/stats.json
> +++ b/qapi/stats.json
> @@ -114,13 +114,13 @@
>  #
>  # The arguments to the query-stats command; specifies a target for
>  # which to request statistics and optionally the required subset of
> -# information for that target:
> +# information for that target.
>  #
> -# - which vCPUs to request statistics for
> -# - which providers to request statistics from
> -# - which named values to return within each provider
> +# @target: the kind of objects to query.  Note that each possible
> +#          target may enable additional filtering options
>  #
> -# @target: the kind of objects to query
> +# @providers: which providers to request statistics from, and optionally
> +#             which named values to return within each provider
>  #
>  # Since: 7.1
>  ##
> @@ -136,6 +136,8 @@
>  #
>  # @scalar: single unsigned 64-bit integers.
>  #
> +# @boolean: single boolean value.
> +#
>  # @list: list of unsigned 64-bit integers (used for histograms).
>  #
>  # Since: 7.1
> @@ -254,6 +256,8 @@
>  #
>  # Return the schema for all available runtime-collected statistics.
>  #
> +# @provider: a provider to restrict the query to.
> +#
>  # Note: runtime-collected statistics and their names fall outside
>  #     QEMU's usual deprecation policies.  QEMU will try to keep the
>  #     set of available data stable, together with their names, but

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued, thanks!


