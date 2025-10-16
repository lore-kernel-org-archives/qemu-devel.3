Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACFBCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Iu7-0006xJ-H3; Thu, 16 Oct 2025 04:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Iu4-0006x6-Vt
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Iu1-00073N-EV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760601598;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvqJ7ToVQcGN+jjlD/BlmIxOBwmydSlBKtCzY2ZXVvg=;
 b=gb4AI3MUXBvfSJO1/AoqLiVc/5P2+SlDlYjDfsgG0ap2yxQIBUz6PpM5SPVp2roHshKkmz
 LqvbgY5C5aS7vKNBqWJkUlbfH7PkZdiTJ4Nce4+9VsAvlEUMM+ArYZF6T8+pmFfbbGaC+1
 Z4Kx2Mh8LMjjOgU5a3iD6RVGmz8Vbzo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-jiOPcYXVMI-1EBw8rssJFg-1; Thu,
 16 Oct 2025 03:59:55 -0400
X-MC-Unique: jiOPcYXVMI-1EBw8rssJFg-1
X-Mimecast-MFC-AGG-ID: jiOPcYXVMI-1EBw8rssJFg_1760601594
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 090FC18002E4; Thu, 16 Oct 2025 07:59:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4129F195419F; Thu, 16 Oct 2025 07:59:51 +0000 (UTC)
Date: Thu, 16 Oct 2025 08:59:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 1/9] gitlab: Stop cross-testing for 32-bit MIPS hosts
Message-ID: <aPCl9VPKPLSDmjiG@redhat.com>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015213843.14277-2-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, Oct 15, 2025 at 02:38:35PM -0700, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 32-bit host support is deprecated since commit 6d701c9bac1
> ("meson: Deprecate 32-bit host support"). Next commits will
> remove support for 32-bit MIPS hosts. Stop cross-building
> QEMU on our CI.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20251009195210.33161-3-philmd@linaro.org>
> ---
>  .gitlab-ci.d/container-cross.yml |  6 ------
>  .gitlab-ci.d/crossbuilds.yml     | 14 --------------
>  2 files changed, 20 deletions(-)
> 
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
> index 8d3be53b75..0fd7341afa 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -52,12 +52,6 @@ mips64el-debian-cross-container:
>    variables:
>      NAME: debian-mips64el-cross
>  
> -mipsel-debian-cross-container:
> -  extends: .container_job_template
> -  stage: containers
> -  variables:
> -    NAME: debian-mipsel-cross

The input to this job is

  tests/docker/dockerfiles/debian-mipsel-cross.docker

which should thus also be deleted, along with removal
of the line from tests/lcitool/refresh that generates
it.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


