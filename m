Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBE0C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIaV-0004Mo-Cv; Tue, 04 Aug 2026 13:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wrIaM-0004Ct-W3
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wrIaI-0001d1-Ct
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785863140;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yie30L0qKT2c0irlVD0qEe285lolG/KMXSWh0a+eGs=;
 b=gUNRu+Gy6lhtyKRCgcjh7HA/jd6e7z5WZpBJVJ/29r+EQqOYbPkE0nSKzdwdd+++glyzBA
 MPbYTWD16F2QimbG7vzCMgFDBgv00peATjgS7pEvga785G3SwEYWdkvTs8u0IJ83cUJQYf
 RHLIeXs6ba8f/hwwOvdfTEP0ZXEOoho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-EHq9o_OFM3u3ke2dLIGD6g-1; Tue,
 04 Aug 2026 13:05:39 -0400
X-MC-Unique: EHq9o_OFM3u3ke2dLIGD6g-1
X-Mimecast-MFC-AGG-ID: EHq9o_OFM3u3ke2dLIGD6g_1785863138
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4E9918004AD; Tue,  4 Aug 2026 17:05:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.191])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3ADE1956088; Tue,  4 Aug 2026 17:05:35 +0000 (UTC)
Date: Tue, 4 Aug 2026 18:05:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-11.1] gitlab: disable provenance attestations to work
 around CI bug
Message-ID: <anIb2ymLGZPUDz2W@redhat.com>
References: <20260804165414.480435-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804165414.480435-1-stefanha@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 04, 2026 at 12:54:14PM -0400, Stefan Hajnoczi wrote:
> QEMU's CI pipeline involves building container images that will be used
> to run builds and tests. A recent Docker change triggered the following
> error:
> 
>   $ docker push "$TAG"
>   ...
>   error from registry: blob unknown to registry - sha256:4401f6f779caf8841cafd5f483e642fcac56a23a4e4a59523231e101c890dad9
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/15701875927#L2372
> 
> This happens because Docker now pushes out-of-order and the GitLab
> Container Registry rejects due to an unknown reference:
> https://forum.gitlab.com/t/started-yesterday-docker-push-error-from-registry-blob-unknown-to-registry/134733/5
> 
> It is unclear at this point whether GitLab will modify the behavior of
> Container Registry or whether Docker will ship a fix.

The forum post links to an issue where this comment:

  https://github.com/moby/buildkit/issues/7007#issuecomment-5178990414

suggests we can just set

  BUILDX_NO_DEFAULT_OCI_ARTIFACT=true

...except I don't think they've updated the docker docker image
with this fix yet. Once they do, that will be better as we can
set it in the GitLab env such that it applies to all branches,
instead of havnig to cherry-pick 

> 
> The current workaround is to disable the provenance attestation that is
> involved in this issue. QEMU's CI pipeline container images are used
> internally for testing and are not widely distributed. Provenance
> attestation can be disabled as there are no external consumers of these
> images. Expect to revert this commit in the future when GitLab or Docker
> have released their own fixes.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Note that this is an urgent patch so that the CI will pass again and I
> can tag v11.1.0-rc3 later today. Currently it is failing due to this
> issue!
> 
>  .gitlab-ci.d/container-template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index 8c7311cca57..88317d650e2 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -14,7 +14,7 @@
>      - echo "TAG:$TAG"
>      - echo "COMMON_TAG:$COMMON_TAG"
>      - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
> -      --build-arg BUILDKIT_INLINE_CACHE=1
> +      --build-arg BUILDKIT_INLINE_CACHE=1 --provenance=false
>        -f "tests/docker/dockerfiles/$NAME.docker" "."
>      - docker push "$TAG"
>    after_script:

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


