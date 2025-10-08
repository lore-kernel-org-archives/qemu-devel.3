Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2217DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WYO-00080R-AB; Wed, 08 Oct 2025 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6WYL-0007zu-Jz
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6WYD-0001Oe-AZ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759939076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBNCSxW1vannHZzDX8K8aKItoHf65X2ZY/RRBbEu8eI=;
 b=bH3sBjBBSYt1IhVYPfv8xISLMzaykmPDcOUOALtNE64cRcKHh4QFMbnpVPLdQiLVsdoYIA
 d2+HzKlxbZKYrzP63+N9Qki/aGiucWw1+gidjbb6s0kzZDJVgDEdaHEMHIXi2PsZq2vNAL
 XeAMRazYNGizAaIuwdt1ocPxYuZ0raA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-h5As5PDlP6WxEZ9m2syoLg-1; Wed,
 08 Oct 2025 11:57:52 -0400
X-MC-Unique: h5As5PDlP6WxEZ9m2syoLg-1
X-Mimecast-MFC-AGG-ID: h5As5PDlP6WxEZ9m2syoLg_1759939071
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 104691800371; Wed,  8 Oct 2025 15:57:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F2FB1956056; Wed,  8 Oct 2025 15:57:48 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:57:45 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH RFC/WIP 4/4] gitlab: add jobs for thorough block tests
Message-ID: <wboov2wdkicvhzwpkckoav3d4uwghdzd7g6kwzy3ynrdt3cyr4@qeu6nviffl2i>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008113552.747002-5-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 08, 2025 at 12:35:52PM +0100, Daniel P. Berrangé wrote:
> CI is only exercising the qcow2 'auto' tests currently. As a result we
> get no exposure of changes which cause regressions in other block format
> drivers.
> 
> This adds new CI jobs for each block format, that will run the target
> 'make check-block-$FORMAT'. The jobs are separate so that we have the
> ability to make each formats gating or not, depending on their level
> of reliability.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 63 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)

The idea makes sense to me.

Did you have a link a URL of a CI run that failed tests on NBD, where
I might be able to help make the tests more deterministic?

> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 0502094b9a..e4ee48cf9e 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -176,6 +176,69 @@ build-system-centos:
>        x86_64-softmmu rx-softmmu sh4-softmmu
>      MAKE_CHECK_ARGS: check-build
>  

> +
> +check-block-nbd-centos:
> +  extends: .native_test_job_template
> +  needs:
> +    - job: build-system-centos
> +      artifacts: true
> +  variables:
> +    IMAGE: centos9
> +    MAKE_CHECK_ARGS: check-block-nbd
> +
>  # Previous QEMU release. Used for cross-version migration tests.
>  build-previous-qemu:
>    extends: .native_build_job_template
> -- 
> 2.50.1
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


