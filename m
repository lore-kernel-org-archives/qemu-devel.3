Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E83C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNWc-0002hO-0L; Tue, 03 Jun 2025 05:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMNWZ-0002gv-HL
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMNWX-00042s-EG
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748941290;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nkvR2KXc4ovSdfv3vkWSvkxzjtwwjEsmgLiEp3byPyo=;
 b=QdStx9ReyzbTkb4P6my3wDeSI0j2V+mLRig1BL0Lo7vRP2HxcwybtG+zAqO+xcP7o7E5YT
 wNJY2j+UpT8EozLptbKPMqIe5n1/m25LtmEZ1fbmCWFdiB8SVKiiEZiG3yHYCMdezlxAsK
 zdoeTL4LmSmVeDj+C6hwKlOEC3h28c8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-od90qrU_OFmc-snYJy-MJA-1; Tue,
 03 Jun 2025 05:01:29 -0400
X-MC-Unique: od90qrU_OFmc-snYJy-MJA-1
X-Mimecast-MFC-AGG-ID: od90qrU_OFmc-snYJy-MJA_1748941288
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5744C18001E0; Tue,  3 Jun 2025 09:01:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3D8A19560AB; Tue,  3 Jun 2025 09:01:25 +0000 (UTC)
Date: Tue, 3 Jun 2025 10:01:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 16/21] qapi/migration: Mark that
 query/set-migrate-parameters support capabilities
Message-ID: <aD654nsXOrCg9umj@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-17-farosas@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 02, 2025 at 10:38:05PM -0300, Fabiano Rosas wrote:
> Add a QAPI command feature "capabilities" that can be queried by the
> client to check that the parameters commands now also support
> capabilities.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  qapi/migration.json | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5942622ba7..557a9c523e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -776,6 +776,13 @@
>  #
>  # Set various migration parameters.
>  #
> +# Features:
> +#
> +# @capabilities: Indicates this command supports setting the set of
> +# parameters previously known as capabilities.  This means this
> +# command can (and should) be used instead of the depreacated
> +# @migrate-set-capabilities.
> +#
>  # Since: 2.4
>  #
>  # .. qmp-example::
> @@ -785,7 +792,8 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'migrate-set-parameters', 'boxed': true,
> -  'data': 'MigrationParameters' }
> +  'data': 'MigrationParameters',
> +  'features': [ 'capabilities' ] }
>  
>  ##
>  # @MigrationParameters:
> @@ -1110,6 +1118,13 @@
>  #
>  # Returns: @MigrationParameters
>  #
> +# Features:
> +#
> +# @capabilities: Indicates this command supports setting the set of
> +# parameters previously known as capabilities.  This means this
> +# command can (and should) be used instead of the depreacated
> +# @migrate-set-capabilities.
> +#
>  # Since: 2.4
>  #
>  # .. qmp-example::
> @@ -1125,7 +1140,8 @@
>  #        }
>  ##
>  { 'command': 'query-migrate-parameters',
> -  'returns': 'MigrationParameters' }
> +  'returns': 'MigrationParameters',
> +  'features': [ 'capabilities' ] }
>

Adding QAPI "features" is only needed if there is no other viable
way to detect existence of the feature. In this case, apps can
trivially detect the feature by querying the QAPI schema and
identifying that the MigrationParameters struct has gained a
load of new fields. So IMHO this patch can be dropped.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


