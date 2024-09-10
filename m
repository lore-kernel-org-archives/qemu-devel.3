Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431D5ECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1ih-0005AM-AG; Tue, 10 Sep 2024 10:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1so1if-000524-5G; Tue, 10 Sep 2024 10:19:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1so1id-0008Ei-DI; Tue, 10 Sep 2024 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+3uvlrtFpJ3UWH3Top9OwdZbnBgpBIOESYNb4A7g1ig=; b=Vwz6HG3rS9WR3RM
 SK1xYTEGFAcMEv14LFuBYvFsv5ZJNXHn5PRv220KSbmmdO4eyiiLYmEQJNMFwx+9SnCamESlMIqHb
 qViDTO1AATb1TuxJoutlxBI1VI0gg4bsHZrZRbNKezxj07GejEwAWMU7ydkMp+NK00cEHB5fOUZeQ
 cE=;
Date: Tue, 10 Sep 2024 16:21:36 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <bcain@quicinc.com>, 
 qemu-trivial@nongnu.org, Alessandro Di Federico <ale@rev.ng>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 1/2] target/hexagon: Rename macros.inc -> macros.h.inc
Message-ID: <7o5kfqvytp7z4i27t7qzc5dkwhudjvi3xepwtyx4it4fojlnxv@gfcumwhumool>
References: <20240910112833.27594-1-philmd@linaro.org>
 <20240910112833.27594-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910112833.27594-2-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/09/24, Philippe Mathieu-Daudé wrote:
> Since commits 139c1837db ("meson: rename included C source files
> to .c.inc") and 0979ed017f ("meson: rename .inc.h files to .h.inc"),
> EMU standard procedure for included header files is to use *.h.inc.
> 
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented in the Coding Style:
> 
>   If you do use template header files they should be named with
>   the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>   being included for expansion.
> 
> Therefore rename "macros.inc" as "macros.h.inc".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/hexagon/idef-parser/README.rst                   | 4 ++--
>  target/hexagon/idef-parser/{macros.inc => macros.h.inc} | 0
>  target/hexagon/gen_idef_parser_funcs.py                 | 2 +-
>  target/hexagon/meson.build                              | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename target/hexagon/idef-parser/{macros.inc => macros.h.inc} (100%)
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

