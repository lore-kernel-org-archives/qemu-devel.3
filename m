Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8322DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 18:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7fm9-00019V-01; Thu, 16 May 2024 14:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7fm1-000177-QW
 for qemu-devel@nongnu.org; Thu, 16 May 2024 14:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7flz-0007TG-IS
 for qemu-devel@nongnu.org; Thu, 16 May 2024 14:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715883850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tilooJ6E6zjhAncMnaGptFUPqsG968Sal20Wf3bI9LQ=;
 b=OH7ji2w53SXsl+8Z9wyWmLhJ6HHFQRCY2L/jrIe4S83DmqfwNI7EqcPAQx7t0WlgwOpmUW
 V3ghAJxCqTF/jUWldoroHG7hP4eBX6U3zYmJqqFIAAt7IoIFCJcECn42CLv/ynFy5Ejh2C
 LHZN3Px1Vjw4xbJaSoQbztDwiD+tjxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-T7NMwAm2NM-nxqAM-JD4NQ-1; Thu, 16 May 2024 14:24:07 -0400
X-MC-Unique: T7NMwAm2NM-nxqAM-JD4NQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2F87185A780;
 Thu, 16 May 2024 18:24:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 035A8100046D;
 Thu, 16 May 2024 18:24:05 +0000 (UTC)
Date: Thu, 16 May 2024 19:24:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH] gitlab-ci: Replace Docker with Kaniko
Message-ID: <ZkZPRILIqoyGbdEk@redhat.com>
References: <20240516165410.28800-3-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516165410.28800-3-cconte@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 16, 2024 at 05:52:43PM +0100, Camilla Conte wrote:
> Enables caching from the qemu-project repository.
> 
> Uses a dedicated "$NAME-cache" tag for caching, to address limitations.
> See issue "when using --cache=true, kaniko fail to push cache layer [...]":
> https://github.com/GoogleContainerTools/kaniko/issues/1459

After investigating, this is a result of a different design approach
for caching in kaniko.

In docker, it can leverage any existing image as a cache source,
reusing individual layers that were present. IOW, there's no
difference between a cache and a final image, they're one and the
same thing

In kaniko, the cache is a distinct object type. IIUC, it is not
populated with the individual layers, instead it has a custom
format for storing the cached content. Therefore the concept of
storing the cache at the same location as the final image, is
completely inappropriate - you can't store two completely different
kinds of content at the same place.

That is also why you can't just "git pull" the fetch the cache
image(s) beforehand, and also why it doesn't look like you can
use multiple cache sources with kaniko.

None of this is inherantly a bad thing..... except when it comes
to data storage. By using Kaniko we would, at minimum, doubling
the amount of data storage we consume in the gitlab registry.

This is a potentially significant concern because GitLab does
technically have a limited storage quota, even with our free
OSS plan  subscription.

Due to technical limitations, they've never been able to
actually enforce it thus far, but one day they probably will.
At which point we're doomed, because even with our current
Docker-in-Docker setup I believe we're exceeding our quota.
Thus the idea of doubling our container storage usage is pretty
unappealing.

We can avoid that by running without cache, but that has the
cost of increasing the job running time, since all containers
would be rebuilt on every pipeline. This will burn through
our Azure compute allowance more quickly (or our GitLab CI
credits if we had to switch away from Azure).

> Does not specify a context since no Dockerfile is using COPY or ADD instructions.
> 
> Does not enable reproducible builds as
> that results in builds failing with an out of memory error.
> See issue "Using --reproducible loads entire image into memory":
> https://github.com/GoogleContainerTools/kaniko/issues/862
> 
> Previous attempts, for the records:
>   - Alex Bennée: https://lore.kernel.org/qemu-devel/20230330101141.30199-12-alex.bennee@linaro.org/
>   - Camilla Conte (me): https://lore.kernel.org/qemu-devel/20230531150824.32349-6-cconte@redhat.com/
> 
> Signed-off-by: Camilla Conte <cconte@redhat.com>
> ---
>  .gitlab-ci.d/container-template.yml | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index 4eec72f383..066f253dd5 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -1,21 +1,18 @@
>  .container_job_template:
>    extends: .base_job_template
> -  image: docker:latest
>    stage: containers
> -  services:
> -    - docker:dind
> +  image:
> +    name: gcr.io/kaniko-project/executor:debug
> +    entrypoint: [""]
> +  variables:
> +    DOCKERFILE: "$CI_PROJECT_DIR/tests/docker/dockerfiles/$NAME.docker"
> +    CACHE_REPO: "$CI_REGISTRY/qemu-project/qemu/qemu/$NAME-cache"
>    before_script:
>      - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:$QEMU_CI_CONTAINER_TAG"
> -    # Always ':latest' because we always use upstream as a common cache source
> -    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
> -    - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
> -    - until docker info; do sleep 1; done
>    script:
>      - echo "TAG:$TAG"
> -    - echo "COMMON_TAG:$COMMON_TAG"
> -    - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
> -      --build-arg BUILDKIT_INLINE_CACHE=1
> -      -f "tests/docker/dockerfiles/$NAME.docker" "."
> -    - docker push "$TAG"
> -  after_script:
> -    - docker logout
> +    - /kaniko/executor
> +      --dockerfile "$DOCKERFILE"
> +      --destination "$TAG"
> +      --cache=true
> +      --cache-repo="$CACHE_REPO"

I'm surprised there is no need to set provide the user/password
login credentials for the registry. None the less  I tested this
and it succeeed.

I guess gitlab somehow has some magic authorization granted to any CI
job, that avoids the need for a manual login ? Wonder why we needed
the 'docker login' step though ? Perhaps because D-in-D results in
using an externally running docker daemon which didn't inherit
credentials from the job environment ?

Caching of course fails when I'm running jobs in my fork. IOW, if we
change container content in a fork and want to test it, it will be
doing a full build from scratch every time. This likely isn't the end
of the world because dockerfiles change in frequently, and when they
do, paying the price of full rebuild is a time limited proble unless
a PULL is sent and accepted.


TL;DR: functionally this patch is capable of working. The key downside
is that it doubles our storage usage. I'm not convinced Kaniko offers
a compelling enough benefit to justify this penalty.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


