Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCCFC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUEb-0000bV-VF; Mon, 10 Aug 2026 13:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUEY-0000b9-LD
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUEU-0007wV-CH
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 13:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786384577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QObAgGrCPbIuhP2ErIVNg1K+lJvDUayU/7GIQSLUcio=;
 b=NZ5n4eZu4sLbk1gXVL+05mWVH4AqiOtUWvGS21KGqV/0xJgONGu2QQz60d3c8VH8HJWvPT
 +4IP7QyD8HAgrdkrGQdZa+0pZqzWby7W6taYbN9dpxWCmL4vjcs++uRBsDnvNw9zjjlzDn
 lkIkGwUX1hrxU99qkWbd1bzFjbngBgE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-JAC8DDIiNVaFh2s4xiRsjA-1; Mon,
 10 Aug 2026 13:56:13 -0400
X-MC-Unique: JAC8DDIiNVaFh2s4xiRsjA-1
X-Mimecast-MFC-AGG-ID: JAC8DDIiNVaFh2s4xiRsjA_1786384572
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A9F51800149; Mon, 10 Aug 2026 17:56:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A6EC1800346; Mon, 10 Aug 2026 17:56:10 +0000 (UTC)
Date: Mon, 10 Aug 2026 18:56:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 12/39] net/qapi: add x-query-usernet command
Message-ID: <anoQuGQkHTkgwqDX@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-12-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-12-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 26, 2026 at 01:19:13AM +0400, Marc-André Lureau wrote:
> Add a QMP command to query user-mode network stack (slirp) connection
> states, providing a structured alternative to "info usernet" HMP.
> 
> The new command returns a list of UsernetInfo, with hub-id, hub-name,
> and connection info for each slirp stack. It is marked unstable as it
> is meant for debugging.
> 
> Rewrite hmp_info_usernet() as a thin wrapper over qmp_x_query_usernet()
> so the HMP and QMP paths share the same implementation.
> 
> This is part of the effort to decouple HMP from QEMU core.
> 
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/net.json | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  net/slirp.c   | 34 ++++++++++++++++++++++++++++------
>  2 files changed, 72 insertions(+), 6 deletions(-)


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c5..08ec7f37946 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -1261,3 +1261,47 @@
>  ##
>  { 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
>    'data': { 'netdev-id': 'str' } }
> +
> +##
> +# @UsernetInfo:
> +#
> +# Information about a user-mode network stack (slirp).
> +#
> +# @hub-id: The hub id, if available.
> +#
> +# @hub-name: The name of the hub.
> +#
> +# @info: Network information from slirp.
> +#
> +# Since: 11.1

s/11.1/11.2/ when you rebase here and the next
comment.

> +##
> +{ 'struct': 'UsernetInfo',
> +  'data': {
> +    '*hub-id': 'int',
> +    'hub-name': 'str',
> +    'info': 'str' },
> +  'if': 'CONFIG_SLIRP' }
> +
> +##
> +# @x-query-usernet:
> +#
> +# Query user-mode network stack connection states.
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: list of user-mode network stack information.
> +#
> +# Since: 11.1
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "x-query-usernet" }
> +#     <- { "return": [ { "hub-id": 0, "hub-name": "vnet",
> +#                        "info": "..." } ] }
> +##
> +{ 'command': 'x-query-usernet',
> +  'returns': ['UsernetInfo'],
> +  'if': 'CONFIG_SLIRP',
> +  'features': [ 'unstable' ] }

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


