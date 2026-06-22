Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE78CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbinb-0006Ll-RF; Mon, 22 Jun 2026 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wbinY-0006LO-0U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:51:04 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wbinN-0001Sm-Nm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782150642;
 bh=9UyW1d4HIIbV1fGB2kMwNxh/g5/CNKVnjZ8kocbRF1o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AcxqhWIPwxSxn7AKnmUnjJ0FB94QhrOnbNpHi9EIj++FJM+bhD4D0OjpWZsn6PpzL
 18vhwB33LVt0As5TWZZ+F94HWsZK8CMUiBROuo3SIdOPfEl2aaorjhQEVPd1bet6eN
 7mZr8Eg7C1KY3PAK/dLtAZCgI6KlmQJy1HljgDRgAr5RJ2e7s6IBXIC0Un2ewKSJCn
 MJSFZtSgRb7MjYDcUT/pmQ9CLLIj7BhnxNfZCopk7SdrUiq5om2x+ZW688iy/SJEmL
 yokbNh+hg9r9Ytq+aFF5ZM47zB60BUa1iwNnQfOYdRKCmGAO5wvot4sopYeUDXNUnf
 MDu7/lgQN4y4Q==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 00AFB2FF3F6;
 Mon, 22 Jun 2026 17:50:42 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id C931037C925;
 Tue, 23 Jun 2026 01:50:40 +0800 (CST)
Message-ID: <06e6901f-0f45-4f01-bd06-eb1928548367@sjtu.edu.cn>
Date: Tue, 23 Jun 2026 01:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <70f7c4f9-ab2d-4a5a-b440-0599b4c16242@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <70f7c4f9-ab2d-4a5a-b440-0599b4c16242@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 22 Jun 2026 10:16:29 -0700, Pierrick Bouvier wrote:
> Thanks for the update.
> 
> At this stage, even though the plugin in itself looks good, it's not
> something we can really merge in, as it's relying on external behavior
> that is not specified or being a standalone tool.
> 
> For instance, if we have a public Lorelei toolchain that implements this
> for libraries, it would definitely have it's place upstream IMHO.
> 
> Also, the same kind of contribution can be done for other
> instrumentation frameworks, so we can end up having a single interface
> (and set of libraries) shared among all of them.
> 
> What do you think?
> 

Hi Pierrick,

That makes sense.

A few thoughts in response:

The Lorelei toolchain already exists, but it will take me a little time 
to migrate it onto this minimal plugin interface, since the ABI changed 
somewhat over the course of the RFC.

I think Lorelei is better kept as a standalone repository: the thunk 
libraries and the guest/host runtimes clearly do not belong in the QEMU 
tree.

Since the plugin only defines the dlcall interface and says nothing 
about how thunking is implemented, the Lorelei repo is just one 
reference implementation of that side; a user is free to build their 
own, with any toolchain or for any framework.

So, to make sure I take the right next step: would you like me to make 
the Lorelei repository public, with CI that demonstrates the automatic 
thunk generation? And should Lorelei be referenced from the plugin's 
comments as a reference implementation?

Regards,
Ziyang


