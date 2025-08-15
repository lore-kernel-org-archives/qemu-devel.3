Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC318CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrFr-0007uB-Lv; Fri, 15 Aug 2025 06:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrFq-0007sL-LD
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:01:46 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umrFp-0001gW-17
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:01:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D2948A58193;
 Fri, 15 Aug 2025 10:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720B5C4CEF1;
 Fri, 15 Aug 2025 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755252103;
 bh=DwwfAzAg8sPAz3kSj7CSD3zdG7SqeKRPBs5nTD+/Atg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XyZZuZdpZ9qWFNFMqVr7wMip35v2nzZIY93az2lsf54hBRjwxralfsH8L3gcO592M
 QNfuJKcoDgQd+aIe8ZcUdDpNYFU5t6sifHt6OSciSuWhgtVGJlKf64J41Bw8nxtIsq
 pLln//FRcP6NX0bO7t+U3Cxqd4Z79TcO2zeQBvu6JtVXhJdqJkBJVqnBMdaqwtLA1e
 vWCw2wfItI6oCN0HaJq6Oky8KZA8wqR3KL/21gD+iUddZVPniP4hN+dtJFRPnPaHGi
 RFdHiJj8y5sOvtDNNYqC74o2CLTbMr6sSGoYVOWnym+Dy5QOeGwKVoWiLTYpvEi5sN
 2BivTkHnOpH3Q==
Date: Fri, 15 Aug 2025 12:01:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 4/8] scripts/kernel-doc: strip QEMU_ from
 function definitions
Message-ID: <20250815120139.514409ce@foz.lan>
In-Reply-To: <20250814171324.1614516-5-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-5-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Thu, 14 Aug 2025 18:13:19 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> This commit is the Python version of our older commit
> b30df2751e5 ("scripts/kernel-doc: strip QEMU_ from function definitions").
> 
> Some versions of Sphinx get confused if function attributes are
> left on the C code from kernel-doc; strip out any QEMU_* prefixes
> from function prototypes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Yeah, I saw this difference before when I did a quick test meant
to port it to QEMU.

So,
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index fe730099eca..32b43562929 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -907,6 +907,7 @@ def dump_function(self, ln, prototype):
>              (r"^__always_inline +", "", 0),
>              (r"^noinline +", "", 0),
>              (r"^__FORTIFY_INLINE +", "", 0),
> +            (r"QEMU_[A-Z_]+ +", "", 0),
>              (r"__init +", "", 0),
>              (r"__init_or_module +", "", 0),
>              (r"__deprecated +", "", 0),



Thanks,
Mauro

