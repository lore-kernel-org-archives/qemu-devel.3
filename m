Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A287CDB466
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 09:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1was2A-0000iU-2A; Sat, 20 Jun 2026 05:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1was1y-0000cA-Dj
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 05:30:26 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1was1u-0007hc-Hq
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 05:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781947808;
 bh=IWMx93kfpTOlj4W3gWHZphkQHug17j77qhHq9kbM+gU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cOtAouYYRjfgJl20Cp+RT4t6rrgymd/r4GQFAoPXajsJ1dXigW1/9fHS9hbTzwRfj
 Wnp5dz3dO4/Pkvu9b4EraAU0H11SF3ARdNEnapZAHNDIzO/IlxGhU27nNpnP41L8C1
 nMIKl8h2gelNEYuGu3SjZC5ieik4SfFQDO7hSqv/GFujJK/K6U1b//0oJX937J5G9s
 BmvJr2xjM0zPXMMofb68n1zrNGKaOw8xOu4sntKxRtCDSsTzn1h9Csm77l4s/wQQH0
 i351VfQ5mlgN8xI+tJWtNgNuyZZywn9EgPXPKU9YDeJc2kwn3jKVU4/lMdhdnj4hVg
 eX76E6MPIIubQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 5E9B32FF379;
 Sat, 20 Jun 2026 09:30:08 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 3C21D37C951;
 Sat, 20 Jun 2026 17:30:07 +0800 (CST)
Message-ID: <92e1f282-2044-43bc-bf83-f172ed019af3@sjtu.edu.cn>
Date: Sat, 20 Jun 2026 17:30:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] contrib/plugins: add a minimal dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260617130742.769234-1-functioner@sjtu.edu.cn>
 <20260619045404.820960-1-functioner@sjtu.edu.cn>
 <ef66ef33-22fc-495b-ab2b-dd4db88c3d8c@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <ef66ef33-22fc-495b-ab2b-dd4db88c3d8c@oss.qualcomm.com>
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

Hi Pierrick,

On Fri, 19 Jun 2026 09:44:37 -0700, Pierrick Bouvier wrote:
> 
> Makes sense, thanks for your answer.
> 

Thanks, glad it makes sense.

While I'm here, a question about a convention I noticed: most of the
QEMU code that loads external modules goes through GModule
(g_module_open() / g_module_symbol()) rather than the libdl functions
directly. Is there a specific reason for preferring GModule?

https://github.com/qemu/qemu/blob/3b50303f9563a42538a1fd5c0ea7f952e23016e1/plugins/loader.c#L190

https://github.com/qemu/qemu/blob/3b50303f9563a42538a1fd5c0ea7f952e23016e1/util/module.c#L171

In the plugin I used dlopen()/dlsym() directly, because their interface
is more standard and more flexible for this use case. For example,
g_module_open() does not expose RTLD_DEFAULT, which I rely on. And since
recent glibc (2.34+) folds libdl into libc, no explicit -ldl is needed,
so simply adding the file to meson.build builds cleanly.

Does using libdl directly in a plugin violate any convention I should be
aware of? If GModule is preferred for portability or some other reason,
I'm happy to switch where feasible.

Thanks,
Ziyang Zhang


