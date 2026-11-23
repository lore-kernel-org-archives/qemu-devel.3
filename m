Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B8606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jEK/uVPe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQrN-0005Ms-DA; Mon, 23 Nov 2026 05:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVQrH-0005M2-1A
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVQrE-0008EI-ST
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795428062;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YJB0ycLEAXlsbR6coSPsP8EG7I+yXrW0k5YpdRbQbg=;
 b=jEK/uVPecMRiDCiDiKQEcrNTnYQhWRQDm3UpOpYDdlb5PKC/EtXANP+GGsAbA2rVL9fj1Q
 WMlBvemKN7MBnQglgVX+FfSDZk3OihVepXnOk3w0SHxvWKhrsMA2tZzXF736oqdfOHCuZJ
 e7kFmMPVFbnbXQuClpBZ3vU0rt+/S3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-3JHkTXzRMWuYEf8PaC3CQw-1; Mon,
 23 Nov 2026 10:00:58 +0000
X-MC-Unique: 3JHkTXzRMWuYEf8PaC3CQw-1
X-Mimecast-MFC-AGG-ID: 3JHkTXzRMWuYEf8PaC3CQw_1795428057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB531955EAC; Mon, 23 Nov 2026 10:00:57 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C33F53001DB4; Mon, 23 Nov 2026 10:00:55 +0000 (UTC)
Date: Mon, 23 Nov 2026 10:00:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 01/22] scripts/get_maintainer.py: minimal argument parsing
Message-ID: <awQO1JtvT429LQRT@redhat.com>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
 <20261120200511.822573-2-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120200511.822573-2-alex.bennee@linaro.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Fri, Nov 20, 2026 at 08:04:49PM +0000, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - treat dir as valid as well (as git ls-files lists it)
>   - move arg parse into own function (parse_args)
>   - set files nargs as + for more flexibility
>   - use python3
> ---
>  scripts/get_maintainer.py | 49 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100755 scripts/get_maintainer.py
> 
> diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
> new file mode 100755
> index 00000000000..47673a5013f
> --- /dev/null
> +++ b/scripts/get_maintainer.py
> @@ -0,0 +1,49 @@
> +#!/usr/bin/env python3
> +#
> +# get_maintainer.py: Print selected MAINTAINERS information
> +#
> +# usage: scripts/get_maintainer.py [OPTIONS] <patch>
> +#        scripts/get_maintainer.py [OPTIONS] -f <file>
> +#
> +# (c) 2025, Alex Bennée <alex.bennee@linaro.org>
> +#           based on get_maintainers.pl
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from argparse import ArgumentParser, ArgumentTypeError
> +from os import path

This shouldn't be needed if you're intending to use pathlib.

> +from pathlib import Path
> +
> +
> +def valid_file_path(arg):
> +    """
> +    Checks if arg exists and is a regular file or raises ArgumentTypeError.
> +    """

IIUC, if you add add "type=Path" to the group.add_argument() call in
parse_args, then you can assume 'arg' is a pathlib.Path and so....


> +    if not path.exists(arg):

  arg.exists()

> +        raise ArgumentTypeError(f"File '{arg}' does not exist.")
> +    if not path.isfile(arg) and not path.isdir(arg):

  not arg.is_file()  and not arg.is_dir()

> +        raise ArgumentTypeError(f"Path '{arg}' is not a regular file.")
> +    return Path(path.abspath(arg))

   return arg.absolute()

> +
> +
> +def parse_args():
> +    """
> +    Create and parse the arguments.
> +    """
> +    parser = ArgumentParser(description='Extract maintainer information. ')
> +
> +    # We can either specify patches or an individual file
> +    group = parser.add_mutually_exclusive_group()
> +    group.add_argument('patch', nargs='*', type=valid_file_path,
> +                       help='path to patch file')

Personally, I'd put the final positional args after all the option args
but that's a bit bikeshedding.

> +    group.add_argument('-f', '--file', type=valid_file_path, nargs = "+",
> +                       help='path to source file(s)')


> +    return parser.parse_args()
> +
> +def main():
> +
> +    args = parse_args()
> +
> +if __name__ == '__main__':
> +    main()
> -- 
> 2.47.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


