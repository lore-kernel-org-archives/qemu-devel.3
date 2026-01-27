Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9A9D2FEC2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 17:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkmcM-0005hq-OI; Tue, 27 Jan 2026 12:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkmcJ-0005VM-2H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkmcH-0005Dx-Fe
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769533956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khtDpl0KQ0jRa+YbxT1kYeYNNzWYcvJZUvXcCqwaHAM=;
 b=N+AlIK1qx4Jv1OxwiHjqLdy/5SG08grLOGLMRBK1vkyRh7iaSTGmzkL1V+SQlzwLcT6hcn
 R6XJFMiDzoV0o0UBMK4AMmPcqsNUUEXWxaMmmjzLbCK+6m25hLJE7wpGzls6H47+iIUM+Q
 +AtVYnWGFDjCIk45gpv+JYQ+C3PuaQI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-MQyTZih5M26sos0GyMmGKA-1; Tue,
 27 Jan 2026 12:12:32 -0500
X-MC-Unique: MQyTZih5M26sos0GyMmGKA-1
X-Mimecast-MFC-AGG-ID: MQyTZih5M26sos0GyMmGKA_1769533950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06FC41956094; Tue, 27 Jan 2026 17:12:30 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74A901800285; Tue, 27 Jan 2026 17:12:27 +0000 (UTC)
Date: Tue, 27 Jan 2026 17:12:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] tests/docker: rename wasm cross container
Message-ID: <aXjx9yeOfdiOLJnv@redhat.com>
References: <20260127092745.2978371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127092745.2978371-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 27, 2026 at 09:27:45AM +0000, Alex Bennée wrote:
> Now we are 64 bit only there is no need to keep the generic name. This
> also fixes a check failure in the weekly container build which was
> checking containers based on the expansion of DOCKER_IMAGES which is
> based of the dockerfile names.
> 
> Fixes: 4203ea0247f (gitlab-ci: Add build tests for wasm64)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/container-cross.yml                                | 2 +-
>  .../{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker}      | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker} (100%)
> 
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
> index d7ae57fb1f5..923044e9a12 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -78,4 +78,4 @@ wasm64-emsdk-cross-container:
>    extends: .container_job_template
>    variables:
>      NAME: emsdk-wasm64-cross
> -    DOCKERFILE: emsdk-wasm-cross
> +    DOCKERFILE: emsdk-wasm64-cross

Drop this variable entirely, since it duplicates $NAME, which already
sets the default value for DOCKERFILE.

Given that this naming divergance broke the CI job, we should also
modify container-template.yml to revert all the changes that were
introducd as part of 4203ea0247f

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


