Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA335C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 10:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpPNv-0000bY-B7; Tue, 04 Mar 2025 05:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpPNq-0000Zp-H1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 05:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpPNn-0007LZ-NO
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 05:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741083610;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CrI5udJio8AH2ajlJAW3Awj3cBKbPIDKwgqS3yJAFA=;
 b=Mh5AM5lw3QWw5zNQByj10llNyJMI6vLt/wQy0Ycwo0ZXaxgge3rFb4BFINwKLAwny1G/eW
 HinwwtVYYiIjqFtpZ5SJ1Dr9jh4abDQIpMBE0NR6Uu8uSuR/7zje+8AcXRjMV6BHOZr3Sy
 LZPsgQ9rQE7FGW/72Wtqpa+jwhBAxXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-Q9LRNADmPo28yx8GTk7klA-1; Tue,
 04 Mar 2025 05:20:03 -0500
X-MC-Unique: Q9LRNADmPo28yx8GTk7klA-1
X-Mimecast-MFC-AGG-ID: Q9LRNADmPo28yx8GTk7klA_1741083602
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60DCF1944EB8; Tue,  4 Mar 2025 10:20:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041D119560A3; Tue,  4 Mar 2025 10:19:58 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:19:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
Message-ID: <Z8bTy54Jgaddg6V3@redhat.com>
References: <20250303221703.1291078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303221703.1291078-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 03, 2025 at 10:17:03PM +0000, Alex Bennée wrote:
> This option is supported by both gcc (since 4.7) and clang (since
> 7.0). Not only does this make the linkers job easier by reducing the
> amount of ELF it needs to parse it also reduces the total build size
> quite considerably. In my case a default build went from 5.8G to 3.9G.

I've not come across this option before, but the docs say

  ‘-gsplit-dwarf’
     If DWARF debugging information is enabled, separate as much
     debugging information as possible into a separate output file with
     the extension ‘.dwo’.  This option allows the build system to avoid
     linking files with debug information.  To be useful, this option
     requires a debugger capable of reading ‘.dwo’ files.

In Fedora and RHEL we build QEMU will full debug enabled, and then a feature
of the distro RPM build config will post-process all ELF files to extract
the debug info into files that we store under /usr/lib/debug. eg for
/usr/bin/qemu-system-x86_64, we get a separate
/usr/lib/debug/bin/qemu-system-x86_64-9.1.3-1.fc41.x86_64.debug, and
tools like GDB, etc know to look for these separate files.

When I test our RPM build process with this -gsplit-dwarf flag added,
we fail to find any debug symbols in the QEMU binaries and thus the
whole RPM package build aborts.

IOW, if we add this to QEMU, my best guess currently is that we're
going to have to revert it downstream.

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> RFC:
>   - currently and RFC because it should also apply to test binaries
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 4588bfd864..a936d1b422 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -363,7 +363,7 @@ endforeach
>  
>  qemu_common_flags = [
>    '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
> -  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
> +  '-fno-strict-aliasing', '-fno-common', '-fwrapv', '-gsplit-dwarf' ]
>  qemu_cflags = []
>  qemu_ldflags = []
>  
> -- 
> 2.39.5
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


