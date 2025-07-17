Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A765C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJzq-0008VC-C9; Thu, 17 Jul 2025 04:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucJzP-0008Gg-Aj
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucJzL-0001jW-OW
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740949;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72xln8wFRY091wBs1I3ga0H4bMae1tHO1PEOMevYdos=;
 b=ROWNb2iyEZWtRiJpoFagfgao2TcB0Bks3jUmTnjjagXLy6FkP/VbLJw/+o+P24BhpKzT9G
 THpiaxTcCjzTRjzU4g1xRn/9lCkL02BZ+sfJ4HrYfiolMb26SU8CpHWFPg8cUXCOUodTEK
 e9tVLWTvx+wyAIu3vh9rPFxRjpI2fc8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-eIgkw_nOOLedUi6wkB-UhA-1; Thu,
 17 Jul 2025 04:29:05 -0400
X-MC-Unique: eIgkw_nOOLedUi6wkB-UhA-1
X-Mimecast-MFC-AGG-ID: eIgkw_nOOLedUi6wkB-UhA_1752740944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AE2C1800297; Thu, 17 Jul 2025 08:29:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65ADC1966650; Thu, 17 Jul 2025 08:28:59 +0000 (UTC)
Date: Thu, 17 Jul 2025 09:28:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com,
 kkostiuk@redhat.com, jsnow@redhat.com
Subject: Re: [PATCH 1/4] qga: Fix guest-network-get-route return value
 documentation
Message-ID: <aHi0ONG3lRokZdUg@redhat.com>
References: <20250717082117.3767754-1-armbru@redhat.com>
 <20250717082117.3767754-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717082117.3767754-2-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 17, 2025 at 10:21:14AM +0200, Markus Armbruster wrote:
> Tagged sections are only recognized at the beginning of a paragraph.
> guest-network-get-route's Returns: isn't, and therefore gets rendered
> as ordinary text within its paragraph:
> 
>     Retrieve information about route of network. Returns: List of route
>     info of guest.
> 
> Since there is no (recognized) Returns: section, the doc generator
> adds
> 
>     Return:
>        [GuestNetworkRoute]
> 
> Note: only since recent commit 636c96cd77d (qapi: Fix undocumented
> return values by generating something).
> 
> Insert the required blank line so that Returns: is recognized.
> Result:
> 
>     Retrieve information about route of network.
> 
>     Return:
>        [GuestNetworkRoute] -- List of route info of guest.
> 
> Fixes: commit 8e326d36dd16 (qga/linux: Add new api 'guest-network-get-route')
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


