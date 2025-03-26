Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB5BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNQS-0003Ah-E2; Wed, 26 Mar 2025 05:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txNQP-00039i-EA
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txNQN-0005On-3v
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742982710;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qvTmSKpPwBTdKRLhsj6NcvXib78Hh3Xi98EbDRMVnM=;
 b=bdcZ+qhqdQ/Hqnf5OiUj/NMyWz0TcbrXtEvT2/vvk05K0w3q3Cvb56juv1UhAzpfL13wk1
 b3vQvf2PbYafFql+WD3UooHuh9Fs9I28gExkzqfo+Ejyfy6Z2vGh892Nkqpr1O8Yupt+SE
 hnNMJJaD6JY7nmIUx9MMozqkdGdPPwg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-DbduuwAaN8Cyr4G3hiTdAg-1; Wed,
 26 Mar 2025 05:51:48 -0400
X-MC-Unique: DbduuwAaN8Cyr4G3hiTdAg-1
X-Mimecast-MFC-AGG-ID: DbduuwAaN8Cyr4G3hiTdAg_1742982707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB20196DF01; Wed, 26 Mar 2025 09:51:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79241180B489; Wed, 26 Mar 2025 09:51:46 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:51:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 15/15] Remove the remainders of the Avocado tests
Message-ID: <Z-POL1OScOz2KP0i@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-16-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325200026.344006-16-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 25, 2025 at 09:00:23PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that all Avocado tests have been converted to or been replaced by
> other functional tests, we can delete the remainders of the Avocado
> tests from the QEMU source tree.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                             |   8 +-
>  docs/about/build-platforms.rst          |  10 +-
>  docs/devel/build-system.rst             |  11 +-
>  docs/devel/codebase.rst                 |   5 -
>  docs/devel/testing/avocado.rst          | 581 ------------------------
>  docs/devel/testing/functional.rst       |   3 -
>  docs/devel/testing/index.rst            |   1 -
>  docs/devel/testing/main.rst             |  15 -
>  tests/avocado/README.rst                |  10 -
>  configure                               |   2 +-
>  pythondeps.toml                         |   8 +-
>  tests/Makefile.include                  |  60 +--
>  tests/avocado/avocado_qemu/__init__.py  | 424 -----------------
>  tests/avocado/avocado_qemu/linuxtest.py | 253 -----------
>  14 files changed, 16 insertions(+), 1375 deletions(-)
>  delete mode 100644 docs/devel/testing/avocado.rst
>  delete mode 100644 tests/avocado/README.rst
>  delete mode 100644 tests/avocado/avocado_qemu/__init__.py
>  delete mode 100644 tests/avocado/avocado_qemu/linuxtest.py

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


