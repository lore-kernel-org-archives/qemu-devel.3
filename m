Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70D606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YOytiUVG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUz8-0003Dn-38; Mon, 09 Nov 2026 14:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQUz6-0003CX-15
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQUz4-0000d0-4C
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794252287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GSOF/WFVOxAgiOdwyHmZZjk5C8va+6Nl3U7/gZjr2wU=;
 b=YOytiUVGnd3nQGatXiQvhPghZOhBJbKSIogWU+rBB4NKAyf5RbdR9uEe7qb3jDaqO+Uh5/
 0cQRf79Uk/Gy+/Pkyf47Wb/7YLtGBdqF56M1mz/oFzomN03spZpo6xFljrbf6rVgOnGlyY
 9pEC38PD4tDwuNHiHfbV0R5tU7Pl+3c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-vXlDMBXYNHSQlroJfQVXtA-1; Mon,
 09 Nov 2026 14:24:45 -0500
X-MC-Unique: vXlDMBXYNHSQlroJfQVXtA-1
X-Mimecast-MFC-AGG-ID: vXlDMBXYNHSQlroJfQVXtA_1794252284
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B2C1195606E; Mon,  9 Nov 2026 19:24:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 678141800446; Mon,  9 Nov 2026 19:24:42 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:24:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] build: remove vestigial CONFIG_SGA
Message-ID: <avId9w77otpW6B1H@redhat.com>
References: <20261109183605.3210043-1-jsnow@redhat.com>
 <20261109183605.3210043-2-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109183605.3210043-2-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 01:36:03PM -0500, John Snow wrote:
> This configuration knob no longer exists as CONFIG_SGA was removed
> quite some time ago. Remove it from our sample config files.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  configs/devices/i386-softmmu/default.mak | 1 -
>  tests/qtest/meson.build                  | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
> index bc0479a7e0a..b935ee61332 100644
> --- a/configs/devices/i386-softmmu/default.mak
> +++ b/configs/devices/i386-softmmu/default.mak
> @@ -17,7 +17,6 @@
>  #CONFIG_PVPANIC=n
>  #CONFIG_QXL=n
>  #CONFIG_SEV=n
> -#CONFIG_SGA=n
>  #CONFIG_TDX=n
>  #CONFIG_TEST_DEVICES=n
>  #CONFIG_TPM_CRB=n
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ff4bf9528a7..3f1b5317fed 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -74,7 +74,6 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['test-x86-cpuid-compat'] : []) +          \
>    (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
> -  (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \

boot-serial-test.c still exists, and IIRC will probably still work,
so we should add it unconditionally instead.

>    (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
>    (host_os == 'linux' and                                                                  \
>     config_all_devices.has_key('CONFIG_ISA_IPMI_BT') and
> -- 
> 2.56.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


