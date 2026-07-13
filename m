Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB168C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFqT-0004e4-Kc; Mon, 13 Jul 2026 08:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjFqM-0004bw-Oy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjFqB-0002KB-7h
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783945972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1WbDnrJUzpfk0+WUUr5bmnfTKwB260NgkH4ggoqx0E=;
 b=OZoCin8WdFGG7UcMcMHrRXPS7vuUmBBvzE99eRkdDvc7PIwqCpB0hHD3az82kZenyDV/Pk
 NDY+omUqMLFQRL6QedoNa9nHy6qO9kykXh+Fg+r3S3dMUPzNPbV+2cfgjyP9gYMNYibqfu
 JSRZW6kVmdrIkKFK9dvpf4ByU+ixjGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-thl2ojd2PEG0QAGAFIRPHg-1; Mon,
 13 Jul 2026 08:32:51 -0400
X-MC-Unique: thl2ojd2PEG0QAGAFIRPHg-1
X-Mimecast-MFC-AGG-ID: thl2ojd2PEG0QAGAFIRPHg_1783945970
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C0761955BFE; Mon, 13 Jul 2026 12:32:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF070195604B; Mon, 13 Jul 2026 12:32:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2ACC021E6920; Mon, 13 Jul 2026 14:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] json-parser: fix formatting of comment
In-Reply-To: <20260713114622.1950506-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 13 Jul 2026 13:46:22 +0200")
References: <20260713114622.1950506-1-pbonzini@redhat.com>
Date: Mon, 13 Jul 2026 14:32:47 +0200
Message-ID: <87ik6jgjdc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qobject/json-parser.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 5935730c0c7..6b1b4762bda 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -29,9 +29,10 @@
>   * object, an error, or NULL (if the object is incomplete and no error
>   * happened) after every token.  Therefore it has an explicit
>   * representation of its parser stack; each stack entry consists of a
> - * parser state and a QObject: - a QList, for an array that is being
> - * added to - a QDict, for a dictionary that is being added to - a
> - * QString, for the key of the next pair that will be added to a QDict
> + * parser state and a QObject:
> + * - a QList, for an array that is being added to
> + * - a QDict, for a dictionary that is being added to
> + * - a QString, for the key of the next pair that will be added to a QDict
>   *
>   * The stack represents an arbitrary nesting of arrays and dictionaries
>   * (whose next key has been parsed); it can also have a dictionary whose

I screwed this up.  My apologies!

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued for 11.1.  Thanks!


