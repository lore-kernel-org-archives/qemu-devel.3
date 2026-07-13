Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB668C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDJx-0002zO-Us; Mon, 13 Jul 2026 05:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjDJs-0002z6-Q5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjDJr-00046v-2N
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783936282;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5wlxbAq4pDK3cgqDS5mWb3MH/RxUPgffkK4ECP7xfbs=;
 b=gn+waNb6689zo2b3Yofo3KpTZw8z/wwE9WWWAZll+tpmQfb4vWRYxzQd1wpx/ZTxecsWKO
 xI0TWmspJwdy6iigVEYjoyrNFyH1Qga8Qy4CS0Sp4CAIZ08erkzmVdzuu7AGkI8r3ge15I
 uUNFwWV/rzoRjS8fPNS1IKbCAyn9Sfk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-EyJLA95PMkGj9kVElF7zhw-1; Mon,
 13 Jul 2026 05:51:18 -0400
X-MC-Unique: EyJLA95PMkGj9kVElF7zhw-1
X-Mimecast-MFC-AGG-ID: EyJLA95PMkGj9kVElF7zhw_1783936277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE1B180064A; Mon, 13 Jul 2026 09:51:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B9B6180065F; Mon, 13 Jul 2026 09:51:11 +0000 (UTC)
Date: Mon, 13 Jul 2026 10:51:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
Message-ID: <alS1DMD_pRrklFRb@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710191809.721154-10-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
> 
> In this commit we introduce a migration parameter, which enables
> the feature for devices that support it (none at the moment).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Ben Chaney <bchaney@akamai.com>
> ---
>  include/migration/misc.h |  2 ++
>  migration/options.c      | 18 +++++++++++++++++-
>  qapi/migration.json      | 12 ++++++++++--
>  3 files changed, 29 insertions(+), 3 deletions(-)


> diff --git a/qapi/migration.json b/qapi/migration.json
> index 66bd900465a..03bdf19f3a6 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -830,7 +830,8 @@
>             'zero-page-detection',
>             'direct-io',
>             { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           'local'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1012,6 +1013,12 @@
>  #     Must be set to the same value on both source and destination
>  #     before migration starts.  (Since 11.1)
>  #
> +# @local: Enable local migration for devices that support it.  Backend
> +#     state and its file descriptors can then be passed to the
> +#     destination in the migration channel.  The migration channel
> +#     must be a Unix domain socket.  Usually needs to be enabled per
> +#     device.  (Since 11.2)

What happens when this is enabled and there are devices which
don't support it ?

What happens when this is enabled and a device on the src
does not support it but a device on the (newer) QEMU dest
does support it ?  How does the mgmt app know which devices
support it ?

Can we document the semantics in these cases.

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> @@ -1053,7 +1060,8 @@
>              '*direct-io': 'bool',
>              '*x-rdma-chunk-size': { 'type': 'uint64',
>                                      'features': [ 'unstable' ] },
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*local': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


