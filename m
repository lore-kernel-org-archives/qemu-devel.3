Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F2FCE087
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvcCi-0005jS-3c; Thu, 26 Feb 2026 09:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvcCd-0005jB-T7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvcCb-0001ie-QJ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772115531;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMhb6thnqig8nYvPVv97TJJYWpE8nJEf71MnWLjx/b8=;
 b=fbg+478IEyRWLB++Q26ZqEiD9qkaAeLQCoJOANKqAtHW533DfBLk5xMN8gb+ZKXyPGJ5+l
 LfOptWol+c5R9vY20jqRy6hT7MEfxhY+Quemu3V+CY852+K90kJnTPU8Ctj/XCHZDyyrVV
 uRI7XOe7nvX08sA6vhgrgWPvjENyFUE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-m3g9SypnN1qSAksodD1UnA-1; Thu,
 26 Feb 2026 09:18:47 -0500
X-MC-Unique: m3g9SypnN1qSAksodD1UnA-1
X-Mimecast-MFC-AGG-ID: m3g9SypnN1qSAksodD1UnA_1772115526
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAE5A195605C; Thu, 26 Feb 2026 14:18:46 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.97])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69DAB19560B5; Thu, 26 Feb 2026 14:18:44 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:18:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 3/4] python: drop avocado
Message-ID: <aaBWQDN0zNzae1ds@redhat.com>
References: <20260225192808.957477-1-jsnow@redhat.com>
 <20260225192808.957477-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225192808.957477-4-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 25, 2026 at 02:28:07PM -0500, John Snow wrote:
> Avocado-framework is no longer used for anything, so it can be removed.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/README.rst              |  2 --
>  python/avocado.cfg             | 13 -------------
>  python/setup.cfg               |  1 -
>  python/tests/flake8.sh         |  3 ---
>  python/tests/iotests-mypy.sh   |  4 ----
>  python/tests/iotests-pylint.sh |  5 -----
>  python/tests/isort.sh          |  3 ---
>  python/tests/minreqs.txt       |  1 -
>  python/tests/mypy.sh           |  3 ---
>  python/tests/pylint.sh         |  4 ----
>  python/tests/qapi-flake8.sh    |  6 ------
>  python/tests/qapi-isort.sh     |  8 --------
>  python/tests/qapi-mypy.sh      |  4 ----
>  python/tests/qapi-pylint.sh    |  8 --------
>  14 files changed, 65 deletions(-)
>  delete mode 100644 python/avocado.cfg
>  delete mode 100755 python/tests/flake8.sh
>  delete mode 100755 python/tests/iotests-mypy.sh
>  delete mode 100755 python/tests/iotests-pylint.sh
>  delete mode 100755 python/tests/isort.sh
>  delete mode 100755 python/tests/mypy.sh
>  delete mode 100755 python/tests/pylint.sh
>  delete mode 100755 python/tests/qapi-flake8.sh
>  delete mode 100755 python/tests/qapi-isort.sh
>  delete mode 100755 python/tests/qapi-mypy.sh
>  delete mode 100755 python/tests/qapi-pylint.sh

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


