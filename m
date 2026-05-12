Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01302CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMh0S-0007aP-Ax; Tue, 12 May 2026 02:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wMh0O-0007Zc-Fs
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:54:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wMh0K-0007Sp-GB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:54:12 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64C6rjXD027754
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 12 May 2026 15:53:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4SZOxTx2ngUWWDMYQqQOHUP9oy/jvPtZDSnQs3QJjok=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1778568825; v=1;
 b=sz0zzkpKjq4w2CwJWpisGKHV5PpsbKNg1zy/SBo71AsN7yMYnJeahwhKBIQOJYVq
 WvD0TW9XyPzZQazTEH5WfPvMLobHM12BI05BtagrQt4/5BUSLr24qbkeTGUnWS7G
 +l3VlCSp1Z3GbyxyodOLE2Xm3ICdWi274SigVDim6o2tFU+j5KrMzklj2E4oG+kV
 9Cz9sGucCjTDE9l0hxUnOjLYJPFqr3s4LpXWO9qjAox5LwBFJ/+oZ4DtK+fQ8ZCC
 8RfdFSaXtwrohqFARuJ20ga6hpyAxPBvqhs4gsRRJZ5iw6V8U4X7BKUOvBBevXTa
 lRaB9qb3By6WFKXLIyxCAQ==
Message-ID: <5618003e-a138-42de-b41e-90ef76d23aa6@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 12 May 2026 15:53:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] tools: Move qemu-vmsr-helper up a directory level
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <20260508152428.2648560-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260508152428.2648560-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/05/09 0:24, Peter Maydell wrote:
> We currently have exactly one subdirectory of tools, i386, which has
> the qemu-vmsr-helper sources in it.  An entire subdirectory isn't
> really necessary here as we have only one i386-specific tool binary
> and no expectation that we will have many more.  Move it up a
> directory level so it's in tools/ with all the other tools sources.
> 
> This was previously covered by the "X86 general architecture support"
> section of MAINTAINERS under the tools/i386/ path; add both the
> source file and the docs file to that section.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                         | 3 ++-
>   meson.build                         | 2 +-
>   tools/{i386 => }/qemu-vmsr-helper.c | 0
>   tools/{i386 => }/rapl-msr-index.h   | 0
>   4 files changed, 3 insertions(+), 2 deletions(-)
>   rename tools/{i386 => }/qemu-vmsr-helper.c (100%)
>   rename tools/{i386 => }/rapl-msr-index.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f2c66d7cc3..88cc1516d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -153,7 +153,8 @@ F: stubs/hmp-cmds-target-i386.c
>   F: target/i386/*.[ch]
>   F: target/i386/Kconfig
>   F: target/i386/meson.build
> -F: tools/i386/
> +F: tools/qemu-vmsr-helper.c
> +F: docs/tools/qemu-vmsr-helper.rst
>   F: tests/functional/i386/
>   F: tests/functional/x86_64/
>   
> diff --git a/meson.build b/meson.build
> index 8164458eea..1dad3a2462 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4569,7 +4569,7 @@ if have_tools
>                  install: true)
>   
>       if cpu == 'x86_64'
> -      executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
> +      executable('qemu-vmsr-helper', files('tools/qemu-vmsr-helper.c'),
>                  dependencies: [authz, crypto, io, qom, qemuutil,
>                                 libcap_ng, mpathpersist],
>                  install: true)
> diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/qemu-vmsr-helper.c
> similarity index 100%
> rename from tools/i386/qemu-vmsr-helper.c
> rename to tools/qemu-vmsr-helper.c
> diff --git a/tools/i386/rapl-msr-index.h b/tools/rapl-msr-index.h
> similarity index 100%
> rename from tools/i386/rapl-msr-index.h
> rename to tools/rapl-msr-index.h


tools/rapl-msr-index.h lost maintainer coverage when F: tools/i386/ was 
narrowed to only tools/qemu-vmsr-helper.c

Regards,
Akihiko Odaki

