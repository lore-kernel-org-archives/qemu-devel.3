Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F93CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umr3l-0003gy-08; Fri, 15 Aug 2025 05:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umr3j-0003gf-K8
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:49:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umr3i-0005H1-5d
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:49:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC4996115D;
 Fri, 15 Aug 2025 09:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA0C4CEEB;
 Fri, 15 Aug 2025 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755251352;
 bh=ger4pW/7/dVJUlPP77OjVfyBs1Rjqp0f7hULlHFZgDQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fH3+4tZT1ZP4EeVE8qXZ4Myg8ieCg8stfcbFzAVmxw/p0UR9ZLTtZXRXIsVvjQjGe
 AXYPK0i9BcQ5lsqZvJDatZ4BE9wfF/faz+vaxdka6MQvgVLBATgee2tYVtXVZxPNbc
 weCAOnZf2KGmsgowV+CFj3ftGS4EB3FswzFX64ZxyMexWTTPVAeYTnINIm29vaPGF/
 ZfEIXGpG9AmU30UnC5dr1J74RYLgA9Pfrn/oyGzBsytE4RIh8M5soUzaLSZC4D9Sgu
 CaLvcN8G+FrDFFRHfjAdx4FhVsRpi675zOhqjsmCEDz3FVJ3HFFSFdYVS04o88Cv7O
 vG+FmUEamMKPg==
Date: Fri, 15 Aug 2025 11:49:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 1/8] docs/sphinx/kerneldoc.py: Handle new
 LINENO syntax
Message-ID: <20250815114908.52d7e488@foz.lan>
In-Reply-To: <20250814171324.1614516-2-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-2-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Thu, 14 Aug 2025 18:13:16 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> The new upstream kernel-doc that we plan to update to uses a different
> syntax for the LINENO directives that the Sphinx extension parses:
> instead of
>   #define LINENO 86
> it has
>   .. LINENO 86
> 
> Update the kerneldoc.py extension to handle both syntaxes, so
> that it will work with both the old and the new kernel-doc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  docs/sphinx/kerneldoc.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
> index 3aa972f2e89..30bb3431983 100644
> --- a/docs/sphinx/kerneldoc.py
> +++ b/docs/sphinx/kerneldoc.py
> @@ -127,7 +127,7 @@ def run(self):
>              result = ViewList()
>  
>              lineoffset = 0;
> -            line_regex = re.compile("^#define LINENO ([0-9]+)$")
> +            line_regex = re.compile(r"^(?:\.\.|#define) LINENO ([0-9]+)$")
>              for line in lines:
>                  match = line_regex.search(line)
>                  if match:



Thanks,
Mauro

