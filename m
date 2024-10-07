Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D17CFB450
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 18:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxsKq-0007ei-5Q; Mon, 07 Oct 2024 14:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxsK9-0005jR-IW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxsK5-0003m6-GY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728325148;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFF0OgxxrUO/z2O//4S1ndSQLFvCOugkCt+VZGyS9uw=;
 b=CaKvhPE5g+eG46AqeLrUXitX8ZXWRN9nAL7XvVRzgAH0UMBlk4kf/bkHmrfDWNQOpY4Cb0
 5oyTIzpr5rD80l7/nWrNdXJZ8ENahF7BrVHoMrfugjqxDdq5nRiRd1fJwNmRUC3HRQh9Yj
 8sX8PHxS8u8CFac7yjqRKctHmCZmgSk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-2yLHIDSdMfWPZoEZ_OROow-1; Mon,
 07 Oct 2024 14:19:02 -0400
X-MC-Unique: 2yLHIDSdMfWPZoEZ_OROow-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A629C1955EE8; Mon,  7 Oct 2024 18:19:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85831300018D; Mon,  7 Oct 2024 18:18:59 +0000 (UTC)
Date: Mon, 7 Oct 2024 19:18:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
Message-ID: <ZwQmDzjojjAs-dQR@redhat.com>
References: <20241007171717.1436982-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007171717.1436982-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 07, 2024 at 07:17:11PM +0200, Paolo Bonzini wrote:
> Right now only Fedora 39 and 40 (with updates) are able to compile
> QEMU with Rust enabled. Full CI enablement requires further work to
> reduce the minimum supported version of the compiler, and is not a
> requirement until Rust is turned on by default.
> 
> Since a CI job based on nightly Rust will be needed later on, to
> integrate clippy and have a heads-up on future clippy warnings,
> adjust QEMU's 'refresh' script to customize a Fedora 40 dockerfile
> with trailing text that installs nightly Rust and compiles the
> latest bindgen.  A matching CI job, using --enable-rust, ensures
> that the toolchain is installed correctly by the Dockerfile and
> that QEMU builds with Rust enabled on at least one platform.

I think that in addition to the nightly job, the mappings.yml should
add rust toolchain, and have a 'system-fedora-rust' job, since you
say that Fedora 40 should already satisfy the min version requirement
without needing nightly there.

Even though the mappings.yml addition will add rust to /all/ containers
this is fine - a perhaps even a good thing - as with any dep we have, it
shows that QEMU does not mistakenly try to enable & use a feature on a
rust version that is too old to work - it reflects that most developer
envs will have rustc present, even when its too old for QEMU to use.


> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Based-on: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
> 
> Paolo Bonzini (2):
>   dockerfiles: add a Dockerfile using a nightly Rust toolchain
>   gitlab-ci: add Rust-enabled CI job
> 
>  .gitlab-ci.d/buildtest.yml                    |  13 ++
>  .gitlab-ci.d/containers.yml                   |   6 +
>  .../dockerfiles/fedora-rust-nightly.docker    | 173 ++++++++++++++++++
>  tests/lcitool/refresh                         |  26 +++
>  4 files changed, 218 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker
> 
> -- 
> 2.46.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


