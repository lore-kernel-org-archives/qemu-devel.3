Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B01C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7s6H-0007tA-PE; Thu, 24 Apr 2025 04:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7s6G-0007sA-6Y
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7s6E-0003KG-Gb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745483904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZLFKgxWDC4V6tQpUKz3n51Ae0kpBC+dQcS/w9pmPNtA=;
 b=N7q61TIbsJJ8ex6EDNW3uyW8B785CrflpTxBAV+e+ct3KiilOErANN+H5MT2QlVNS7YWm/
 JUIl6GspuMldi0w+AlM+QEHhhImqLu9yDQB0bxdk9JWqcUgM/I+8gqddvFsrzEy4vf+sPB
 EBFgyfYxYQ4JOYcyTthG4RcrDwaHd24=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-lXhJVEV3OIWvnBKowB-Zeg-1; Thu,
 24 Apr 2025 04:38:20 -0400
X-MC-Unique: lXhJVEV3OIWvnBKowB-Zeg-1
X-Mimecast-MFC-AGG-ID: lXhJVEV3OIWvnBKowB-Zeg_1745483899
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88D171955DDD; Thu, 24 Apr 2025 08:38:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C711800352; Thu, 24 Apr 2025 08:38:14 +0000 (UTC)
Date: Thu, 24 Apr 2025 09:38:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 mjt@tls.msk.ru, thuth@redhat.com, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH] scripts: Add exception to license check
Message-ID: <aAn4c6hy_kMcgwXO@redhat.com>
References: <20250423183728.3860325-1-nabihestefan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423183728.3860325-1-nabihestefan@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 23, 2025 at 06:37:27PM +0000, Nabih Estefan wrote:
> The documentation for trace events says that every subdirectory which
> has trace events should have a trace.h header, whose only content is
> an include of the trace/trace-<subdir>.h file.

Historically we have not bothered to add the license header to the trace.h
files, primarily because its size would dwarf the actual content, and
secondly because. the content can probably be sad to be not copyrightable.

With SPDX-License-Identifier being so concise though, the main reason for
omitting it goes away. So my feeling is that we should not exempt the
trace.h files, and stick with our default rule that *ALL* source files
must have SPDX-License-Identifier.

> Due to that, we should skip it in the checkpatch license check.
> I'm adding it as an exception to the check instead of its own if so it
> still throws the warning on all new files instead of ignoring it.
> 
> Change-Id: Ic2dae14f8cded0dd02d5b231588bd38d8a00e40d
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  scripts/checkpatch.pl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 365892de04..b2c6ac2477 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1685,7 +1685,9 @@ sub process {
>  		if ($line =~ /^new file mode\s*\d+\s*$/) {
>  		    if ($expect_spdx) {
>  			if ($expect_spdx_file =~
> -			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
> +			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/
> +				and not $expect_spdx_file =~ /(trace\.h)$/) {
> +				# Files to include auto-generated files don't require a license
>  			    # source code files MUST have SPDX license declared
>  			    ERROR("New file '$expect_spdx_file' requires " .
>  				  "'SPDX-License-Identifier'");
> -- 
> 2.49.0.805.g082f7c87e0-goog
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


