Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83792C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94xA-0000NC-Ac; Tue, 22 Sep 2026 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x94x1-0000MX-Nh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x94wy-0002fp-Hb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790100639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWHJlCIUOotW1IdR8C8AeFjCPJeBPSms1ipvi6lN0Xg=;
 b=XOphWHwmJVVykLR2BCseaJ/NfEZrcTL7P3wU0dy2HEV19VNC/mEs5XQBGi/+acFh/nbdJ/
 kksAHREy64SCOWHRssD9WFG3ZdYXYA2q8kTsZCJYuPW77NpYjt1LbtbO2GhKGV/gmj6GjP
 DDTCnhszcxjle25egfQxPPxh+5oSkA4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-qUNfgcWXMei7ny-DOQNUbg-1; Tue,
 22 Sep 2026 14:10:35 -0400
X-MC-Unique: qUNfgcWXMei7ny-DOQNUbg-1
X-Mimecast-MFC-AGG-ID: qUNfgcWXMei7ny-DOQNUbg_1790100634
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CCD21954229; Tue, 22 Sep 2026 18:10:34 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 975F8418; Tue, 22 Sep 2026 18:10:32 +0000 (UTC)
Date: Tue, 22 Sep 2026 19:10:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 1/7] tests/tcg/meson.build: force use of linux/amd64
 platform for containers
Message-ID: <arLElaXA4vLEPL6h@redhat.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-2-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921231458.3369-2-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 21, 2026 at 11:14:52PM +0000, Pierrick Bouvier wrote:
> On hosts != x64_64, we detect if host can run amd64 containers (usually
> through qemu-user-binfmt). If not, we deactivate container support.
> 
> We could technically stop here and force container engine to use this
> platform. Since existing base image (docker.io/library/debian:13-slim)
> is multi platforms, container engine will enable this variant by
> default.
> 
> Now the problem is that if user reuses this image for their own
> Dockerfiles, they will run into unpleasant surprise that now, their
> container engine is using x86_64 variant by default, on any host.
> 
> So, in next commit, we'll change base image we use to x86_64 variant,
> which has a single platform: linux/amd64. This ensures we don't generate
> any unwanted side effect when building our images.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 75f0a52fd22..4cf4865461e 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -81,6 +81,7 @@ tcg_tests_summary += {'gdb': gdb}
>  
>  docker_supported = false
>  container_command = false
> +docker_platform = ['--platform', 'linux/amd64']
>  if get_option('containers')
>    if get_option('container_command') != ''
>      # make sure command is working
> @@ -99,6 +100,15 @@ if get_option('containers')
>                          container_command]
>      endif
>    endif
> +
> +  if docker_supported
> +    docker_supported = run_command([docker_wrapper, 'run', '--',
> +                                    docker_platform,
> +                                    'docker.io/amd64/debian:13-slim',
> +                                    '/bin/true'],
> +                                    check: false).returncode() == 0

IIUC, this is checking that  podman/docker is capable of running
(potentially)  foreign-arch containers ? ie that qemu-user is
setup on the host.  If so, would be worth a short comment here.

> +    tcg_tests_summary += {'x86_64 container support': docker_supported}
> +  endif
>  endif
>  tcg_tests_summary += {'container command': container_command}
>  if get_option('container_registry') != ''

None the less:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


