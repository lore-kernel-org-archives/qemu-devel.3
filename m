Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5CECD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZObn-0005st-Pi; Tue, 16 Jun 2026 03:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZObm-0005sf-Jz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZObk-0004w6-OS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781596395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8PVurZHmWl3iHnYBjOWWX6fTyAU/RDEvMw8ujMjSXYU=;
 b=Ni0Y5Jcua1nYB+7hyyMM9PS+pyaveX3XGpb6+gI2/fZIergg9udJykOs4DUkXnDiAybbTM
 SBHCazEqGPFRGzjJd2qv0lkAeIfUe4oRhFg6pP7A/ml1Ve4/xkxWXg5+v7UuvvXGzxAC0Y
 65Ms7XAI4c8/Lhh8/8Lz3p0LXhjtDdk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-ZaGXA91CMkKsD_j6dLS3yg-1; Tue,
 16 Jun 2026 03:53:13 -0400
X-MC-Unique: ZaGXA91CMkKsD_j6dLS3yg-1
X-Mimecast-MFC-AGG-ID: ZaGXA91CMkKsD_j6dLS3yg_1781596392
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46381195606F; Tue, 16 Jun 2026 07:53:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.111])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DDF919560A2; Tue, 16 Jun 2026 07:53:08 +0000 (UTC)
Date: Tue, 16 Jun 2026 08:53:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 armbru@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
Message-ID: <ajEA4CybcZHwYEEF@redhat.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 15, 2026 at 01:17:23PM -0700, Pierrick Bouvier wrote:
> We add a new script: scripts/check-maintainers-file.py, that will run at
> configuration time (and not at build time), to not hurt build time.
> This script runs in 0.2s on my dev VM, which has an old cpu.
> 
> We can expect things to be mostly in sync since adding or removing a
> source or test file will trigger a configure step.
> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
> build things from scratch and always run the configure step.
> 
> With this, it should be impossible by design to have an upstream
> MAINTAINERS file with non existing file entries.

Accuracy of the MAINTAINERS file is an upstream-only concern, but
IIUC, this check is going to apply universally to every build of
QEMU which is undesirable. It is irrelevant to end users and not
appropriate to check in downsteam vendors forks.

In a "normal" modern project this kind of check would be done in
a CI job on the merge request, since that's the only place it is
relevant. In our case, the nearest fit is the checkpatch.pl file.

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build                       |  5 +++
>  scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100755 scripts/check-maintainers-file.py
> 
> diff --git a/meson.build b/meson.build
> index 19e123423b5..57e9c9de42b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,6 +17,11 @@ add_test_setup('thorough',
>  
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>  
> +# check our MAINTAINERS file is consistent
> +check_maintainers = find_program('scripts/check-maintainers-file.py')
> +maintainers_file = files('MAINTAINERS')
> +run_command([check_maintainers, maintainers_file], check: true)
> +
>  ####################
>  # Global variables #
>  ####################
> diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintainers-file.py
> new file mode 100755
> index 00000000000..b001816a401
> --- /dev/null
> +++ b/scripts/check-maintainers-file.py
> @@ -0,0 +1,53 @@
> +#! /usr/bin/env python3
> +
> +# Check incorrect file entries in MAINTAINERS
> +#
> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import argparse
> +import glob
> +import sys
> +
> +
> +def check_one_entry(line) -> bool:
> +    return True
> +
> +
> +def main() -> None:
> +    parser = argparse.ArgumentParser(description="Check MAINTAINERS file")
> +    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
> +    args = parser.parse_args()
> +
> +    found_file_entry = False
> +    found_incorrect_entries = False
> +    line_counter = 0
> +
> +    with open(args.maintainers) as file:
> +        for entry in file:
> +            line_counter += 1
> +
> +            if not entry.startswith("F:"):
> +                continue
> +            entry = entry[2:].strip()
> +            found_file_entry = True
> +
> +            file_exists = len(glob.glob(entry, recursive=True)) > 0
> +            if file_exists:
> +                continue
> +
> +            found_incorrect_entries = True
> +            print(
> +                f"No matching files for {args.maintainers} +{line_counter}: {entry}",
> +                file=sys.stderr,
> +            )
> +
> +    if not found_file_entry:
> +        raise Exception("no file entry found - is MAINTAINERS path correct?")
> +    if found_incorrect_entries:
> +        raise Exception(f"incorrect entries found in {args.maintainers}")
> +
> +
> +if __name__ == "__main__":
> +    main()
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


