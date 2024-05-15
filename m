Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F6AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 10:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7C2g-00065K-9i; Wed, 15 May 2024 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7C2e-00064a-2m
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7C2Z-0008Ra-Sf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715769558;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICbjxbO6o3KU1iT2thoCQZSXg0CeYpcXBoTfnQfVrpA=;
 b=WulwK6ahux3ygiNxTfqjstzqEl8ujceBelZS9aZ6BZoSwt7tcCAjhMCmTTkjOzq2TJrjDF
 FLoy0S9QTM6Rh6uGiDHXPwVpDCavdoXCow9bMjLAiZanam+9CMum3yPTnK5YEHKiAjJsvk
 6GJ0t5FuI5zbzlnkBlE+q1YHI7AP7Fk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-jNxBq8z3NbuKAvm4oCjyXg-1; Wed,
 15 May 2024 06:39:14 -0400
X-MC-Unique: jNxBq8z3NbuKAvm4oCjyXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D95A29AB3E7;
 Wed, 15 May 2024 10:39:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D8217412;
 Wed, 15 May 2024 10:39:12 +0000 (UTC)
Date: Wed, 15 May 2024 11:39:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 00/11] gitlab CI fix and glib update
Message-ID: <ZkSQzui3Wn66wryK@redhat.com>
References: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Michael,

In this pull request, patches 2, 3 & 4 will be applicable to stable
to fix the tsan CI job which broke with the latest GitLab software
release.

On Tue, May 14, 2024 at 02:51:08PM +0200, Thomas Huth wrote:
> The following changes since commit 9360070196789cc8b9404b2efaf319384e64b107:
> 
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-12 13:41:26 +0200)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-05-14
> 
> for you to fetch changes up to da79537e0c8cef007d30298343d05acb0ba8b427:
> 
>   util/uri: Remove the old URI parsing code (2024-05-14 12:46:46 +0200)
> 
> ----------------------------------------------------------------
> * Fix the "tsan-build" CI job on the shared gitlab CI runners
> * Bump minimum glib version and use URI code from the newer glib
> * Fix error message from "configure" when C compiler is not working
> 
> ----------------------------------------------------------------
> Daniel P. Berrangé (3):
>       dockerfiles: add 'MAKE' env variable to remaining containers
>       gitlab: use $MAKE instead of 'make'
>       gitlab: use 'setarch -R' to workaround tsan bug
> 
> Thomas Huth (8):
>       configure: Fix error message when C compiler is not working
>       Bump minimum glib version to v2.66
>       Remove glib compatibility code that is not required anymore
>       block/gluster: Use URI parsing code from glib
>       block/nbd: Use URI parsing code from glib
>       block/nfs: Use URI parsing code from glib
>       block/ssh: Use URI parsing code from glib
>       util/uri: Remove the old URI parsing code
> 
>  configure                                          |   11 +-
>  meson.build                                        |   16 +-
>  include/glib-compat.h                              |   27 +-
>  include/qemu/uri.h                                 |   99 --
>  block/gluster.c                                    |   69 +-
>  block/nbd.c                                        |   76 +-
>  block/nfs.c                                        |  110 +-
>  block/ssh.c                                        |   75 +-
>  qga/commands-posix-ssh.c                           |   12 +-
>  util/error-report.c                                |   10 -
>  util/uri.c                                         | 1466 --------------------
>  .gitlab-ci.d/buildtest-template.yml                |    6 +-
>  .gitlab-ci.d/buildtest.yml                         |    3 +
>  .../dockerfiles/debian-all-test-cross.docker       |    1 +
>  .../docker/dockerfiles/debian-hexagon-cross.docker |    1 +
>  .../dockerfiles/debian-legacy-test-cross.docker    |    1 +
>  .../dockerfiles/debian-loongarch-cross.docker      |    1 +
>  .../docker/dockerfiles/debian-tricore-cross.docker |    1 +
>  .../docker/dockerfiles/debian-xtensa-cross.docker  |    1 +
>  tests/docker/dockerfiles/fedora-cris-cross.docker  |    1 +
>  util/meson.build                                   |    2 +-
>  21 files changed, 194 insertions(+), 1795 deletions(-)
>  delete mode 100644 include/qemu/uri.h
>  delete mode 100644 util/uri.c
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


