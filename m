Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A8D61020
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTXd-0000tC-9L; Thu, 29 Jan 2026 10:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vlTXZ-0000pK-KP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vlTXV-0000y0-WF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769698953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8NtRQqtyu2u8dAjNQJ81xabpKO9VEga+TsMdwrxYGs=;
 b=hAOUepxixh34lQdxD5JU9XvJ1YXbxYwCIt+GTo9fUoOsQ00SRj4EBKZ1F34wHTE09EX6GG
 yYfZ1htrO2+Qz2jTjHG2VyqNtscLggdIHQnBVzBbpnLTmLkxU2z+9KZh6ASF0VEIlAoNpo
 cN7GqzIgAJVoX+Yl6dN+GJTEidQ7aIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-rRHd0OX0OmazKlfPjGuI0g-1; Thu,
 29 Jan 2026 10:02:27 -0500
X-MC-Unique: rRHd0OX0OmazKlfPjGuI0g-1
X-Mimecast-MFC-AGG-ID: rRHd0OX0OmazKlfPjGuI0g_1769698946
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACA1E185FBDF; Thu, 29 Jan 2026 15:02:16 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEA8B19560B2; Thu, 29 Jan 2026 15:02:12 +0000 (UTC)
Date: Thu, 29 Jan 2026 15:02:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 1/2] tests/docker: rename wasm cross container
Message-ID: <aXt2cToG5VXmUgEV@redhat.com>
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
 <20260128105839.3487840-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105839.3487840-2-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jan 28, 2026 at 10:58:38AM +0000, Alex Bennée wrote:
> Now we are 64 bit only there is no need to keep the generic name. This
> also fixes a check failure in the weekly container build which was
> checking containers based on the expansion of DOCKER_IMAGES which is
> based of the dockerfile names.
> 
> Remove the DOCKERFILE bits that were added to handle multiple
> containers from the same dockerfile.
> 
> Fixes: 4203ea0247f (gitlab-ci: Add build tests for wasm64)
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-ID: <20260127092745.2978371-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - also revert the DOCKERFILE bits that are no longer needed.
> ---
>  .gitlab-ci.d/container-cross.yml                              | 1 -
>  .gitlab-ci.d/container-template.yml                           | 4 +---
>  .../{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker}    | 0
>  3 files changed, 1 insertion(+), 4 deletions(-)
>  rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker} (100%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


