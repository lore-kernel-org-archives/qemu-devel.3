Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB884CAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyunY-0005RA-H8; Wed, 17 Sep 2025 12:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyunW-0005OG-94
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyunS-0000iV-Kc
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758125656;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hEWM4eRNWYPV/06GulkKXxgoBqaCpBgI+9ou6dQbjI=;
 b=ITuUY/MsJJ850PMsFBB93DkepFf2GX50P6dcCdRQUsirXvH6PzZiUBg+3TggHMirdXAm7R
 6DEUY8eZHP+nywDwSxF78B9L/TqDhWZ1Z0m6TGySftiF+2rTdg+J6dFcIGb1at1BeKpe5k
 5Xe9q8iyb+fCoTiGSrdF2YF/z1bYRaw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-rpEefQC-OPS74kZbyV04Cg-1; Wed,
 17 Sep 2025 12:14:13 -0400
X-MC-Unique: rpEefQC-OPS74kZbyV04Cg-1
X-Mimecast-MFC-AGG-ID: rpEefQC-OPS74kZbyV04Cg_1758125652
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3193F195604F; Wed, 17 Sep 2025 16:14:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72FC31955F19; Wed, 17 Sep 2025 16:14:08 +0000 (UTC)
Date: Wed, 17 Sep 2025 17:14:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH for 10.0.x stable]
 tests/docker/dockerfiles/python.docker: pull fedora:40 image instead of
 fedora:latest
Message-ID: <aMreTDMJVwrxLsil@redhat.com>
References: <20250917161236.1041820-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161236.1041820-1-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Sep 17, 2025 at 07:12:32PM +0300, Michael Tokarev wrote:
> All other fedora dockerfiles use fedora:40.
> fedora:latest does not have python3.8 anymore,
> so python minreq/etc tests are failing in 10.0.x.
> 
> This patch is specific to 10.0.x stable branch.
> In master, support for python3.8 has been dropped.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  tests/docker/dockerfiles/python.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


FWIW, we should also have 'master' on a specific Fedora release too
but then IIUC John plans to drop a lot of python code in this release
so it may become a non-problem on master ?

> 
> diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
> index 8f0af9ef25..e1ddd46f50 100644
> --- a/tests/docker/dockerfiles/python.docker
> +++ b/tests/docker/dockerfiles/python.docker
> @@ -1,6 +1,6 @@
>  # Python library testing environment
>  
> -FROM fedora:latest
> +FROM fedora:40
>  MAINTAINER John Snow <jsnow@redhat.com>
>  
>  # Please keep this list sorted alphabetically
> -- 
> 2.47.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


