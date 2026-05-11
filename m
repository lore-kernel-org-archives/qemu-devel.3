Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81396CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUTo-0005Mp-So; Mon, 11 May 2026 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMUTo-0005Mf-3S
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMUTm-0001hg-F8
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778520701;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUSo2zNRZCgjUmsJTqcl8JJdEuuR3GFj+TyrO2Jdi0A=;
 b=P7/z8glwEPiU3hkAyPf5iYG2tuE5zZQwgL9H4V3qyEZKNcJMU6I++X0REVmiegzQeNm0y5
 9nWqCPZZ6czLZT+YU+Du46w+iSBDq3rjSl2BtVvYFQAF4dEb4621CHl6lXDbZ8hjWELIvI
 piHhSUYIZ8FRxFd/4Uik44lHWOe9YiI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-QYEVGyXKNqKguO7PwqM-WA-1; Mon,
 11 May 2026 13:31:37 -0400
X-MC-Unique: QYEVGyXKNqKguO7PwqM-WA-1
X-Mimecast-MFC-AGG-ID: QYEVGyXKNqKguO7PwqM-WA_1778520696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 462241956094; Mon, 11 May 2026 17:31:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7997418004A3; Mon, 11 May 2026 17:31:34 +0000 (UTC)
Date: Mon, 11 May 2026 18:31:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 02/10] scripts/expand-macro.py: helper script
 exploding macros
Message-ID: <agIScsrfiXudewZ3@redhat.com>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511170500.124211-3-alex.bennee@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 06:04:51PM +0100, Alex Bennée wrote:
> QEMU makes heavy use of C Macros which can be confusing to humans and
> seems almost impossible for AI agents to follow. In the past I've
> dealt with this by compiling with V=1 and manually copying and pasting
> the gcc command line and appending -E to run the pre-processor step.
> 
> With the modern build system we now have a compile_commands.json so we
> can automate the process with a script.
> 
> There is some trickiness involved in following the line markers so we
> know where in the source file we are. To handle this we implement a
> PreprocessorState object to track where in the include chain we are.
> This allows us to show the including location when we dump the
> expanded macro.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/expand-macro.py | 272 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100755 scripts/expand-macro.py
> 
> diff --git a/scripts/expand-macro.py b/scripts/expand-macro.py
> new file mode 100755
> index 00000000000..581f20b9897
> --- /dev/null
> +++ b/scripts/expand-macro.py
> @@ -0,0 +1,272 @@
> +#!/usr/bin/env python3
> +#
> +# Automate the expansion of QEMU macros based on compile_commands.json.
> +#
> +# This script runs the C preprocessor over a file to expand macros
> +# in a specified line range, using the compilation flags defined in
> +# compile_commands.json.
> +#
> +# Copyright (c) Linaro 2026

SPDX-License-Identifier  needed


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


