Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A6DCDB46B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbrEg-0007RB-4w; Mon, 22 Jun 2026 22:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wbrEc-0007Qv-92
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:51:34 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wbrEY-0002IT-Sf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782183079;
 bh=xnrHQu6JusFR03WIYS0LynwJcd3S+3Gfea3emHYKRn4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jSQIpVOuj2E8bTQz3BZ3hYMIrxrDtMSWmovpSqzhlfaGS0kFxAI6hSjuEDljQdYjA
 R2GGap9361uzByo4Mp6PvMC8a8MiwRWyTKLybO4vb+Niyk+ig95zSjiE7pHoHjpKWj
 pqC0dQ2LwMDD/92LKQbfmQt7mXI5xV/6LZRw7kcXMTKnN7tYCqzqpgZ3v33nEB6NIU
 6FSKDS4qSQp4HYqJanOPfyYAr6WnqJx6/Lt49lAq/vYKxsDKqs92tKg1N05I7HeTfX
 CryPiW15sdOvda6TO4SEhmXYnCC82hBcujyPNv9PgmuUNBMvfyaBHXwC57J5IRyljn
 DI3wBqcrcVNvw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id A4AC62FF555;
 Tue, 23 Jun 2026 02:51:19 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6F5F237C8C7;
 Tue, 23 Jun 2026 10:51:18 +0800 (CST)
Message-ID: <fb504309-4e3e-48e6-9e33-108edbcbb173@sjtu.edu.cn>
Date: Tue, 23 Jun 2026 10:51:17 +0800
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
 <06e6901f-0f45-4f01-bd06-eb1928548367@sjtu.edu.cn>
 <9cbeb740-405d-4738-90cc-fce7eca7d9ec@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <9cbeb740-405d-4738-90cc-fce7eca7d9ec@oss.qualcomm.com>
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

On Mon, 22 Jun 2026 11:04:43 -0700, Pierrick Bouvier wrote:
> That's my point. As long as Lorelei is not a stable tool, we can't
> really integrate the current plugin upstream. However, it's great that
> you posted this as a RFC, as it shows the approach work.

The main reason for Lorelei's instability is the repeated modifications
to the plugin API. However, this current PATCH indicates that the plugin
is at least stable now. Therefore, Lorelei can become stable very soon.
I will release Lorelei in a few days.

> For now, I think the current plugin should stay downstream, until
> Lorelei is officially published and people can take any library and
> compile it with it. Once we have this, it's easy to motivate integrating
> this plugin upstream, as people can do everything themselves.

Since the current QEMU does not force the guest program to load at a low
address as it did in version 9.0, the callback functionality in the
earlier versions of Lorelei was limited. However, I don't think this is
a major issue. I must first publish Lorelei and integrate the plugin
into the upstream before we can discuss the modifications to the mmap
handler.

What do you think?

> 
>> Regards,
>> Ziyang
>>
> 


