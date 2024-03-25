Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C02C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 05:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rodDE-0007hw-S6; Mon, 25 Mar 2024 01:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rodD8-0007hj-8l
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 01:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rodD6-0002f4-Hj
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 01:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711345767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yFQ8bMrfnBKkFGPAcg0ai7ox/Ax6NgxhnBnwTHlirRg=;
 b=K4VyHs5ayq3EPFL9auo5bLRKkj+Mt5+uQlJ6pi/PC2w721/GcXNfixe88zEYeSkmEUu3gc
 r0T8GN+HTdts138Nq2HUN7cOaIzSQUAF6fq9KB4I51mTORsygEKrGmgTOfVgIg77ASgR2b
 0NbPro8R0fmhMFwtwyi7Y20VGhC/S7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-TdnpkG_1Phy-B-lT1PSZ7g-1; Mon, 25 Mar 2024 01:49:24 -0400
X-MC-Unique: TdnpkG_1Phy-B-lT1PSZ7g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED9A101A552;
 Mon, 25 Mar 2024 05:49:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1106492BC4;
 Mon, 25 Mar 2024 05:49:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECABB21E668C; Mon, 25 Mar 2024 06:49:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,  michael.roth@amd.com,  kkostiuk@redhat.com
Subject: Re: [PATCH 04/12] qapi: Tidy up indentation of add_client's example
In-Reply-To: <20240322140910.328840-5-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 22 Mar 2024 15:09:02 +0100")
References: <20240322140910.328840-1-armbru@redhat.com>
 <20240322140910.328840-5-armbru@redhat.com>
Date: Mon, 25 Mar 2024 06:49:18 +0100
Message-ID: <8734sesvxd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Markus Armbruster <armbru@redhat.com> writes:

> Commit d23055b8db8 (qapi: Require descriptions and tagged sections to
> be indented) indented add_client's example too much.  Revert that.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/misc.json | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 1b0c5dad88..ec30e5c570 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -32,9 +32,9 @@
>  #
>  # Example:
>  #
> -#         -> { "execute": "add_client", "arguments": { "protocol": "vnc",
> -#                                                      "fdname": "myclient" } }
> -#         <- { "return": {} }
> +#     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
> +#                                                  "fdname": "myclient" } }
> +#     <- { "return": {} }
>  ##
>  { 'command': 'add_client',
>    'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
> @@ -142,7 +142,7 @@
>  #     option was passed on the command line.
>  #
>  #     In the "suspended" state, it will completely stop the VM and
> -#     cause a transition to the "paused" state. (Since 9.0)
> +#     cause a transition to the "paused" state.  (Since 9.0)
>  #
>  # Example:
>  #

This hunk belongs to PATCH 11.


