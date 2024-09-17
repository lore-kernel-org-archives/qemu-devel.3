Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26056C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXhU-00055t-PX; Tue, 17 Sep 2024 08:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sqXhS-00054g-34
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sqXhP-00042C-HX
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726577573;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onY/0oVqtSaTGPe24KpVqaK7YuKAFxmzXej+ATw9Ocs=;
 b=KDQggfYqT7DFNSb2LY6zY9GJfjICEdVPc0FJ8wzbwj+YSyhjfDCTFxhYBIDs//diiIFm+4
 HvvbvTGn44S8jQX+b3wrK3QR5bpGADhAmhOjoSgZWDeGnQUXfLuwh0TbiDHpFugfjV3qrp
 f+0jJ0XDWCVR7E6QdeyFOosJrfu70IY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-OliiuwCYNniWgtzCFvqT8g-1; Tue,
 17 Sep 2024 08:52:49 -0400
X-MC-Unique: OliiuwCYNniWgtzCFvqT8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8242F19560B1; Tue, 17 Sep 2024 12:52:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.193])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7445519560A3; Tue, 17 Sep 2024 12:52:46 +0000 (UTC)
Date: Tue, 17 Sep 2024 13:52:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/3] .gitlab-ci.d/cirrus: Add manual testing of macOS 15
 (Sequoia)
Message-ID: <Zul7dIheGE03MtgQ@redhat.com>
References: <20240917085058.1740-1-philmd@linaro.org>
 <20240917085058.1740-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917085058.1740-4-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 17, 2024 at 10:50:58AM +0200, Philippe Mathieu-Daudé wrote:
> Upgrade libvirt-ci so it covers macOS 15. Add a manual entry
> (QEMU_JOB_OPTIONAL: 1) to test on Sequoia release. Refresh the
> lci-tool generated files.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Pending libvirt-ci MR 501: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/501
> 
> CI job: https://gitlab.com/philmd/qemu/-/jobs/7841560032
> ---
>  .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
>  .gitlab-ci.d/cirrus/macos-15.vars | 16 ++++++++++++++++
>  tests/lcitool/libvirt-ci          |  2 +-
>  tests/lcitool/refresh             |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 .gitlab-ci.d/cirrus/macos-15.vars
> 
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index f061687f1b..b84b42cce5 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -66,6 +66,22 @@ aarch64-macos-14-base-build:
>      NAME: macos-14
>      CIRRUS_VM_INSTANCE_TYPE: macos_instance
>      CIRRUS_VM_IMAGE_SELECTOR: image
> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest

Something isn't right here - the existing 14 release is "sonoma", "ventura"
was 13 IIUC which you just removed

> +    CIRRUS_VM_CPUS: 12
> +    CIRRUS_VM_RAM: 24G
> +    UPDATE_COMMAND: brew update
> +    INSTALL_COMMAND: brew install
> +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
> +    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
> +    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
> +    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
> +
> +aarch64-macos-15-base-build:
> +  extends: .cirrus_build_job
> +  variables:
> +    NAME: macos-15
> +    CIRRUS_VM_INSTANCE_TYPE: macos_instance
> +    CIRRUS_VM_IMAGE_SELECTOR: image
>      CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest

And this should be sequoia


I think the info we've committed to libvirt-ci is probably wrong.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


