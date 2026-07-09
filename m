Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D4AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsF0-00057Z-JO; Thu, 09 Jul 2026 13:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whsEs-000578-8f
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:08:42 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whsEq-000097-Ha
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783616917;
 bh=JY5m9e73I2Ro8DNBStQNZNnS90ICZoLL/BUcVAY/dRQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=vlK3tVaErU5Bw8H3ndfcvzaAqrwqHASt7XG+9QGDyfNERznegsTGNXrFDthuQQ+Wh
 VIRiwU3V0pS5OW13375cOI5F/avuA1BIv2zitQB1VJAWpjhOooBO9VTboqpGI2kpJc
 IJW+2zqSKTSqbSKBXafw8wjf5AboXqwKNt0yrmdhvN47ZCTKQf8qUGTgp8oQU1QYv5
 YM26v7dIEnpngSgfFYygdfdwXAwdnBtInKTNUUNLcVPe7hiptJF+vdIcXHPQ6W2Yi4
 jYeL4ttePYc2yppbpJY0TgEXJL1g/EVN817CkUzVpQ3HoJerucmZPA5zk/odjlgt07
 JvDC/U2NzEWHg==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 3E8802FF87D;
 Thu,  9 Jul 2026 17:08:37 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 70C0437C925;
 Fri, 10 Jul 2026 01:08:06 +0800 (CST)
Message-ID: <dbfa0357-da8f-4b22-bb1d-eb5e4af4e095@sjtu.edu.cn>
Date: Fri, 10 Jul 2026 01:08:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] contrib/plugins: add dlcall to call host functions
 from a guest
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709025528.300019-1-functioner@sjtu.edu.cn>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <20260709025528.300019-1-functioner@sjtu.edu.cn>
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

On Thu,  9 Jul 2026 10:55:26 +0800, Ziyang Zhang wrote:
> Feedback on the plugin and on the pass-through approach is welcome.
> 
> Changes since v8:
> 
>    Following Pierrick Bouvier's v8 request, the guest program in the
>    docs/about/emulation.rst example no longer links with an rpath. It carries
>    no rpath at all, so which libhello.so it loads is chosen entirely by
>    LD_LIBRARY_PATH at run time: the baseline run puts the guest build there,
>    and the thunk run puts the generated guest thunk there in its place. The
>    plugin code is unchanged.
> 

This PATCH is deprecated, see v10:
https://lore.kernel.org/qemu-devel/20260709170437.363560-1-functioner@sjtu.edu.cn/

