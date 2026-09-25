Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA39C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2Qb-0003lb-Ec; Fri, 25 Sep 2026 05:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA2Qa-0003lT-CH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA2QY-0006Yv-3F
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790329269;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4JJLi/dBRDNA+i0UzyaygvALiYy7Tu4RBQE60JItg/Q=;
 b=V9VImCbODWmVXe1hRJ9X1y4RaT9rx7Gbh0JBQUfP/ZZ9xnW0ZMuqYFdLmAiUuqBpgJm9nB
 alqTHk/oH7j2BG0KxscujvqX0Ll3+AMNormnckevf5YySruCCNWVgf8fHK9oXLjUb808JZ
 R5fCtq0mJeprVFpH+qmFEJJNWvdvyCA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-sXeYcXraNAKgsvZ82VfCuA-1; Fri,
 25 Sep 2026 05:41:03 -0400
X-MC-Unique: sXeYcXraNAKgsvZ82VfCuA-1
X-Mimecast-MFC-AGG-ID: sXeYcXraNAKgsvZ82VfCuA_1790329262
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9207A1956065; Fri, 25 Sep 2026 09:41:02 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D24E300022A; Fri, 25 Sep 2026 09:41:00 +0000 (UTC)
Date: Fri, 25 Sep 2026 10:40:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/4] tests/tcg: add alternative cross-compilers for fedora
Message-ID: <arZBqmDtOX8YoJaA@redhat.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Thu, Sep 24, 2026 at 09:39:41PM +0000, Pierrick Bouvier wrote:
> This allows to pick host compiler automatically on fedora, as those
> binaries are installed with 'gcc' package.
> 
> This covers all host arch supported to this day:
> https://fedoraproject.org/wiki/Architectures
> - x86_64
> - aarch64
> - ppc64le
> - riscv64
> - s390x
> Note: QEMU and Fedora don't support 32-bit hosts anymore.

Regardless of what installation arches Fedora targets, it
ships cross compilers for pretty much everything. In F44
I see the following GCC available:

gcc-aarch64-linux-gnu.x86_64         16.2.1-1.fc44 updates
gcc-alpha-linux-gnu.x86_64           16.2.1-1.fc44 updates
gcc-arc-linux-gnu.x86_64             16.2.1-1.fc44 updates
gcc-arm-linux-gnu.x86_64             16.2.1-1.fc44 updates
gcc-avr32-linux-gnu.x86_64           16.2.1-1.fc44 updates
gcc-bfin-linux-gnu.x86_64            16.2.1-1.fc44 updates
gcc-c6x-linux-gnu.x86_64             16.2.1-1.fc44 updates
gcc-frv-linux-gnu.x86_64             16.2.1-1.fc44 updates
gcc-h8300-linux-gnu.x86_64           16.2.1-1.fc44 updates
gcc-hppa-linux-gnu.x86_64            16.2.1-1.fc44 updates
gcc-hppa64-linux-gnu.x86_64          16.2.1-1.fc44 updates
gcc-ia64-linux-gnu.x86_64            16.2.1-1.fc44 updates
gcc-loongarch64-linux-gnu.x86_64     16.2.1-1.fc44 updates
gcc-m68k-linux-gnu.x86_64            16.2.1-1.fc44 updates
gcc-microblaze-linux-gnu.x86_64      16.2.1-1.fc44 updates
gcc-mips64-linux-gnu.x86_64          16.2.1-1.fc44 updates
gcc-mn10300-linux-gnu.x86_64         16.2.1-1.fc44 updates
gcc-openrisc-linux-gnu.x86_64        16.2.1-1.fc44 updates
gcc-powerpc64-linux-gnu.x86_64       16.2.1-1.fc44 updates
gcc-powerpc64le-linux-gnu.x86_64     16.2.1-1.fc44 updates
gcc-ppc64-linux-gnu.x86_64           16.2.1-1.fc44 updates
gcc-ppc64le-linux-gnu.x86_64         16.2.1-1.fc44 updates
gcc-riscv32-linux-gnu.x86_64         16.2.1-1.fc44 updates
gcc-riscv64-linux-gnu.x86_64         16.2.1-1.fc44 updates
gcc-s390x-linux-gnu.x86_64           16.2.1-1.fc44 updates
gcc-sparc64-linux-gnu.x86_64         16.2.1-1.fc44 updates
gcc-x86_64-linux-gnu.x86_64          16.2.1-1.fc44 updates
gcc-xtensa-linux-gnu.x86_64          16.2.1-1.fc44 updates


> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/aarch64/meson.build        | 2 ++
>  tests/tcg/aarch64/system/meson.build | 1 +
>  tests/tcg/aarch64_be/meson.build     | 1 +
>  tests/tcg/ppc64le/meson.build        | 1 +
>  tests/tcg/riscv64/meson.build        | 2 ++
>  tests/tcg/riscv64/system/meson.build | 1 +
>  tests/tcg/s390x/meson.build          | 2 ++
>  tests/tcg/s390x/system/meson.build   | 1 +
>  tests/tcg/x86_64/meson.build         | 2 ++
>  tests/tcg/x86_64/system/meson.build  | 1 +
>  10 files changed, 14 insertions(+)
> 
> diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
> index cc2c59fb4b6..1cec335df04 100644
> --- a/tests/tcg/aarch64/meson.build
> +++ b/tests/tcg/aarch64/meson.build
> @@ -1,4 +1,5 @@
>  cc = 'aarch64-linux-gnu-gcc'
> +cc_alt = ['aarch64-redhat-linux-gcc']
>  cc_dockerfile = 'debian-all-test-cross'
>  
>  cc_feat_cflags = {
> @@ -196,6 +197,7 @@ if 'qemu-aarch64' in emulators
>    tcg_tests += {
>      'aarch64-linux-user': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'cc_feat_cflags': cc_feat_cflags,
>        'folder': 'aarch64',
> diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
> index 6ba35a9f722..fb3b33861ea 100644
> --- a/tests/tcg/aarch64/system/meson.build
> +++ b/tests/tcg/aarch64/system/meson.build
> @@ -96,6 +96,7 @@ if 'qemu-system-aarch64' in emulators
>    tcg_tests += {
>      'aarch64-softmmu': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'cc_feat_cflags': cc_feat_cflags,
>        'folder': 'aarch64/system',
> diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
> index e45a49ec2da..509408de8e7 100644
> --- a/tests/tcg/aarch64_be/meson.build
> +++ b/tests/tcg/aarch64_be/meson.build
> @@ -10,6 +10,7 @@ if 'qemu-aarch64_be' in emulators
>    tcg_tests += {
>      'aarch64_be-linux-user': {
>        'cc': 'aarch64-linux-gnu-gcc',
> +      'cc_alt': ['aarch64-redhat-linux-gcc'],
>        'cc_dockerfile': 'debian-all-test-cross',
>        'cc_feat_cflags': cc_feat_cflags,
>        'folder': 'aarch64_be',
> diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
> index a0f3e62e4d3..9f386287e7a 100644
> --- a/tests/tcg/ppc64le/meson.build
> +++ b/tests/tcg/ppc64le/meson.build
> @@ -2,6 +2,7 @@ if 'qemu-ppc64le' in emulators
>    tcg_tests += {
>      'ppc64le-linux-user': {
>        'cc': 'powerpc64le-linux-gnu-gcc',
> +      'cc_alt': ['ppc64le-redhat-linux-gcc'],
>        'cc_dockerfile': 'debian-all-test-cross',
>        'cc_feat_cflags': cc_feat_cflags,
>        'folder': 'ppc64le',
> diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
> index 5ee20a1e98d..91c840b0058 100644
> --- a/tests/tcg/riscv64/meson.build
> +++ b/tests/tcg/riscv64/meson.build
> @@ -1,4 +1,5 @@
>  cc = 'riscv64-linux-gnu-gcc'
> +cc_alt = ['riscv64-redhat-linux-gnu-gcc']
>  cc_dockerfile = 'debian-all-test-cross'
>  
>  subdir('system')
> @@ -26,6 +27,7 @@ if 'qemu-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-linux-user': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'folder': 'riscv64',
>        'gdb_arch': 'riscv64',
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 87c3f9f11ce..c87e3eee1ad 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -65,6 +65,7 @@ if 'qemu-system-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-softmmu': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'folder': 'riscv64',
>        'gdb_arch': 'riscv64',
> diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
> index 1f9aa57fc73..f2328d9e5cf 100644
> --- a/tests/tcg/s390x/meson.build
> +++ b/tests/tcg/s390x/meson.build
> @@ -1,4 +1,5 @@
>  cc = 's390x-linux-gnu-gcc'
> +cc_alt = ['s390x-redhat-linux-gcc']
>  cc_dockerfile = 'debian-all-test-cross'
>  
>  cc_feat_cflags = {
> @@ -140,6 +141,7 @@ if 'qemu-s390x' in emulators
>    tcg_tests += {
>      's390x-linux-user': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'cc_feat_cflags': cc_feat_cflags,
>        'folder': 's390x',
> diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
> index ef19c4831fd..359d124cc78 100644
> --- a/tests/tcg/s390x/system/meson.build
> +++ b/tests/tcg/s390x/system/meson.build
> @@ -82,6 +82,7 @@ if 'qemu-system-s390x' in emulators
>    tcg_tests += {
>      's390x-softmmu': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'cc_feat_cflags': cc_feat_cflags,
>        'folder': 's390x',
> diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
> index cfeef1d969c..968fe27cfc5 100644
> --- a/tests/tcg/x86_64/meson.build
> +++ b/tests/tcg/x86_64/meson.build
> @@ -1,4 +1,5 @@
>  cc = 'x86_64-linux-gnu-gcc'
> +cc_alt = ['x86_64-redhat-linux-gcc']
>  cc_dockerfile = 'debian-amd64-cross'
>  
>  subdir('system')
> @@ -72,6 +73,7 @@ if 'qemu-x86_64' in emulators
>    tcg_tests += {
>      'x86_64-linux-user': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'folder': 'x86_64',
>        'gdb_arch': 'x86_64',
> diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
> index 43e7d7afa85..08b770d43ae 100644
> --- a/tests/tcg/x86_64/system/meson.build
> +++ b/tests/tcg/x86_64/system/meson.build
> @@ -52,6 +52,7 @@ if 'qemu-system-x86_64' in emulators
>    tcg_tests += {
>      'x86_64-softmmu': {
>        'cc': cc,
> +      'cc_alt': cc_alt,
>        'cc_dockerfile': cc_dockerfile,
>        'folder': 'x86_64/system',
>        'gdb_arch': 'x86_64',
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


