Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C734EC49EA1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZahj-00013W-Jq; Thu, 01 Aug 2024 14:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZahh-00012E-GI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 14:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZahf-0000b9-MV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 14:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722537545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KhQzkF+doxEnfCrfk3CA66aicUlOg5P9VPSpXa1z/js=;
 b=gT6WbCDYyWPLPYDF3Z5ICa5p54m2araq6yyDBn6vPoCIx+qSRZVgR6myerCyEwU8TObrkR
 5Et/uCriRQwdQI9vu5tYuS4hPRwBgQ/ow+Ad2s/u7dRezmrgSksj7KAID5Yc83e95zgvuS
 A7dJVq17Ia7H4ST+f1Y3zCloQLxYkwU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-UJwlzfHcO5ShqP3VLEJlHQ-1; Thu,
 01 Aug 2024 14:39:02 -0400
X-MC-Unique: UJwlzfHcO5ShqP3VLEJlHQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A38E19560A2; Thu,  1 Aug 2024 18:39:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42F943000198; Thu,  1 Aug 2024 18:38:56 +0000 (UTC)
Date: Thu, 1 Aug 2024 13:38:53 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 2/5] docs/interop/nbd.txt: Convert to rST
Message-ID: <okjnkgp7cfoa53ubbkeotfanyijak7x4avhlwa3ydfwzpo2qk4@7vni4uw4ihtc>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
 <20240801170131.3977807-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801170131.3977807-3-peter.maydell@linaro.org>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 06:01:28PM GMT, Peter Maydell wrote:
> Convert nbd.txt to rST format.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS            |  2 +-
>  docs/interop/index.rst |  1 +
>  docs/interop/nbd.rst   | 89 ++++++++++++++++++++++++++++++++++++++++++
>  docs/interop/nbd.txt   | 72 ----------------------------------
>  4 files changed, 91 insertions(+), 73 deletions(-)
>  create mode 100644 docs/interop/nbd.rst
>  delete mode 100644 docs/interop/nbd.txt
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a183fe960b..dd159053dbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3869,7 +3869,7 @@ F: nbd/
>  F: include/block/nbd*
>  F: qemu-nbd.*
>  F: blockdev-nbd.c
> -F: docs/interop/nbd.txt
> +F: docs/interop/nbd.rst

Upstream NBD has a link to the nbd.txt page; I'll have to update that
link to the new name.  Is it worth creating a git symlink so the old
name remains a stable point to link to (even though it is no longer
purely text)?

>  F: docs/tools/qemu-nbd.rst
>  F: tests/qemu-iotests/tests/*nbd*
>  T: git https://repo.or.cz/qemu/ericb.git nbd
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index ed65395bfb2..b9ceaabc648 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -14,6 +14,7 @@ are useful for making QEMU interoperate with other software.
>     dbus-vmstate
>     dbus-display
>     live-block-operations
> +   nbd
>     pr-helper
>     qmp-spec
>     qemu-ga
> diff --git a/docs/interop/nbd.rst b/docs/interop/nbd.rst
> new file mode 100644
> index 00000000000..de079d31fd8
> --- /dev/null
> +++ b/docs/interop/nbd.rst
> @@ -0,0 +1,89 @@
> +QEMU NBD protocol support
> +=========================
> +
> +QEMU supports the NBD protocol, and has an internal NBD client (see
> +``block/nbd.c``), an internal NBD server (see ``blockdev-nbd.c``), and an
> +external NBD server tool (see ``qemu-nbd.c``). The common code is placed
> +in ``nbd/*``.

Accurate translation, and accurate information although incomplete -
maybe I should do a followup patch to mention that qemu-storage-daemon
can also expose an NBD server?  Doesn't affect review of this patch.

> +
> +The NBD protocol is specified here:
> +https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
> +
> +The following paragraphs describe some specific properties of NBD
> +protocol realization in QEMU.
> +
> +Metadata namespaces
> +-------------------
> +
> +QEMU supports the ``base:allocation`` metadata context as defined in the
> +NBD protocol specification, and also defines an additional metadata
> +namespace ``qemu``.
> +
> +``qemu`` namespace
> +------------------
> +
> +The ``qemu`` namespace currently contains two available metadata context
> +types.  The first is related to exposing the contents of a dirty
> +bitmap alongside the associated disk contents.  That metadata context
> +is named with the following form::
> +
> +    qemu:dirty-bitmap:<dirty-bitmap-export-name>
> +
> +Each dirty-bitmap metadata context defines only one flag for extents
> +in reply for ``NBD_CMD_BLOCK_STATUS``:
> +
> +bit 0:
> +  ``NBD_STATE_DIRTY``, set when the extent is "dirty"
> +
> +The second is related to exposing the source of various extents within
> +the image, with a single metadata context named::

I'm not an rst expert, so I'm assuming the difference between ending a
line in : vs :: is intentional and affects the rendering; but as far
as I can tell, the rendered result worked, so I don't see any problems
with the patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


