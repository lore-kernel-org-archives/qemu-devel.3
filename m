Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A6CCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjse-00012V-TS; Mon, 07 Oct 2024 05:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxjsV-00011l-Ja
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxjsR-0002lF-17
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728292681;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQDAmT7m3jYRK7xNBKftKMWpYG4Nud9vmhAEHJh+4Ck=;
 b=Lg91nvumT7qEhZAg5EXA4ffx7arDvXDfFW+/FSuMpPg//XcBvnGUgHRHp7A6ChpXzCVZV8
 qA5F7kJ3AAI4p8+zzpkDpWkK8sr56aA/RSC5G/SDoTHlVJufbwyQsTjTUO5wjCrsj/nqBS
 8RjPtnmigCoR1tqL0muXsXpGfSsTvIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-wi20FpIFNv2XdNQSPydyHw-1; Mon,
 07 Oct 2024 05:17:57 -0400
X-MC-Unique: wi20FpIFNv2XdNQSPydyHw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D68E1944EAB; Mon,  7 Oct 2024 09:17:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9C9019560A7; Mon,  7 Oct 2024 09:17:53 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:17:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/3] .gitlab-ci.d/cirrus: Add manual testing of macOS 15
 (Sequoia)
Message-ID: <ZwOnPdXY8sMJfas-@redhat.com>
References: <20240917085058.1740-1-philmd@linaro.org>
 <20240917085058.1740-4-philmd@linaro.org>
 <Zul7dIheGE03MtgQ@redhat.com>
 <d2d5706c-882c-4643-bda7-c820fb2a42d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2d5706c-882c-4643-bda7-c820fb2a42d5@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 07, 2024 at 11:10:20AM +0200, Thomas Huth wrote:
> On 17/09/2024 14.52, Daniel P. Berrangé wrote:
> > On Tue, Sep 17, 2024 at 10:50:58AM +0200, Philippe Mathieu-Daudé wrote:
> > > Upgrade libvirt-ci so it covers macOS 15. Add a manual entry
> > > (QEMU_JOB_OPTIONAL: 1) to test on Sequoia release. Refresh the
> > > lci-tool generated files.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > > Pending libvirt-ci MR 501: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/501
> > > 
> > > CI job: https://gitlab.com/philmd/qemu/-/jobs/7841560032
> > > ---
> > >   .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
> > >   .gitlab-ci.d/cirrus/macos-15.vars | 16 ++++++++++++++++
> > >   tests/lcitool/libvirt-ci          |  2 +-
> > >   tests/lcitool/refresh             |  1 +
> > >   4 files changed, 35 insertions(+), 1 deletion(-)
> > >   create mode 100644 .gitlab-ci.d/cirrus/macos-15.vars
> > > 
> > > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > > index f061687f1b..b84b42cce5 100644
> > > --- a/.gitlab-ci.d/cirrus.yml
> > > +++ b/.gitlab-ci.d/cirrus.yml
> > > @@ -66,6 +66,22 @@ aarch64-macos-14-base-build:
> > >       NAME: macos-14
> > >       CIRRUS_VM_INSTANCE_TYPE: macos_instance
> > >       CIRRUS_VM_IMAGE_SELECTOR: image
> > > +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
> > 
> > Something isn't right here - the existing 14 release is "sonoma", "ventura"
> > was 13 IIUC which you just removed
> > 
> > > +    CIRRUS_VM_CPUS: 12
> > > +    CIRRUS_VM_RAM: 24G
> > > +    UPDATE_COMMAND: brew update
> > > +    INSTALL_COMMAND: brew install
> > > +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
> > > +    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
> > > +    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
> > > +    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
> > > +
> > > +aarch64-macos-15-base-build:
> > > +  extends: .cirrus_build_job
> > > +  variables:
> > > +    NAME: macos-15
> > > +    CIRRUS_VM_INSTANCE_TYPE: macos_instance
> > > +    CIRRUS_VM_IMAGE_SELECTOR: image
> > >       CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
> > 
> > And this should be sequoia
> > 
> > I think the info we've committed to libvirt-ci is probably wrong.
> 
> FYI, I'm going to queue this patch with the update to the fixed libvirt-ci
> commit and this patch on top:
> 
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -66,7 +66,7 @@ aarch64-macos-14-base-build:
>      NAME: macos-14
>      CIRRUS_VM_INSTANCE_TYPE: macos_instance
>      CIRRUS_VM_IMAGE_SELECTOR: image
> -    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
>      CIRRUS_VM_CPUS: 12
>      CIRRUS_VM_RAM: 24G
>      UPDATE_COMMAND: brew update
> @@ -82,7 +82,7 @@ aarch64-macos-15-base-build:
>      NAME: macos-15
>      CIRRUS_VM_INSTANCE_TYPE: macos_instance
>      CIRRUS_VM_IMAGE_SELECTOR: image
> -    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sequoia-base:latest
>      CIRRUS_VM_CPUS: 12
>      CIRRUS_VM_RAM: 24G
>      UPDATE_COMMAND: brew update

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


