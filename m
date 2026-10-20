Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED2606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TU30f5hz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ2t1-0002iD-SC; Tue, 20 Oct 2026 01:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ2t0-0002hX-0r
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ2sy-0005Cu-Ld
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792475984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPi6szoBi8+i8LBn4f9FTTgEhIX4YmQ/jlIYt17lwFc=;
 b=TU30f5hzz+vGIgUiLxgAhP7anxsuC5qcYKLE9kmR75EpPyA3p2HoI9R471dtIs+bBm+A/T
 yxIOqbDyQ3pSd+pbVkbjewqPDhBGHmf2ozk7u3bF3RpN1dA86TjSXftVD4ATzNtBEwSoMQ
 LhFBFOwlO4U5y9pfioKLkeXSD/WtRHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-uPdZCgFRPt-iRCkBchBr1A-1; Tue,
 20 Oct 2026 05:59:41 +0000
X-MC-Unique: uPdZCgFRPt-iRCkBchBr1A-1
X-Mimecast-MFC-AGG-ID: uPdZCgFRPt-iRCkBchBr1A_1792475979
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCCF6180067D; Tue, 20 Oct 2026 05:59:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68ED9195608A; Tue, 20 Oct 2026 05:59:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1628A21E6A04; Tue, 20 Oct 2026 07:59:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/12] qapi/block: Add IoAccountingOperation enum
In-Reply-To: <20261019182028.45305-3-hreitz@redhat.com> (Hanna Czenczek's
 message of "Mon, 19 Oct 2026 20:20:18 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-3-hreitz@redhat.com>
Date: Tue, 20 Oct 2026 07:59:37 +0200
Message-ID: <87y0bssyie.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> This enum gives more information than IoOperationType (which is used for
> the rerror/werror distinction) to identify operation types for block
> accounting.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block.json | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 0a88d405a26..8f4a71733c1 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -629,3 +629,23 @@
>              'command': 'str' },
>    'features': [ 'unstable' ],
>    'allow-preconfig': true }
> +
> +##
> +# @IoAccountingOperation:
> +#
> +# I/O operation types as they are tracked by block accounting.

Can we have a link to suitable docs on block accounting?

> +#
> +# @read: Reading data
> +#
> +# @write: Writing data
> +#
> +# @flush: Flushing data to disk
> +#
> +# @zone-append: Appending data to a zone of a zoned block device
> +#
> +# @unmap: Discarding a block of data
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'IoAccountingOperation',
> +  'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }


