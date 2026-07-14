Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81623C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjWB7-0006jy-A9; Tue, 14 Jul 2026 01:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjWB4-0006jT-0u
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 01:59:34 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjWB0-0008Dl-8a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 01:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1784008759;
 bh=c54CWLujTkzK1b2AlJocU4lyzm4CEBChx6WRCrLdA8k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KOQUrqasfFktOqxKwO4dP+dBlHG+i5bTEIXZwIX4MsmxwbD2HX0dtxqGmTtzskHM+
 tm8/FwTHt3mJpUmgfl6/930pZMsOiCvIuIzILWKl9S5SnUsIRGNa6yJNKT6tSBoTc4
 SaajQkpmEt0NDzICz4RPc9+oEVIj8QP0+R1O2m336eVkKisJK63nb/pXlh6SYpWANV
 0aXU5eyDGWCkaE/zXdhFTxcQpddcY6pZkIX6YV5G/psDsXuxdDB1Tow6qrRsekRauJ
 Dc8guyhWFlCki1ggIeu7iy9nyoZZI3kB0j73b6s7/zZV6TI1OO60OoaeLHDox2wDgV
 6Ced+XO7YlpAQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id B48F42FF893;
 Tue, 14 Jul 2026 05:59:19 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 85CB5380C9A;
 Tue, 14 Jul 2026 13:58:48 +0800 (CST)
Message-ID: <fc17e8c9-9090-438b-b8bc-4eedc7117c5f@sjtu.edu.cn>
Date: Tue, 14 Jul 2026 13:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260711094523.622997-1-functioner@sjtu.edu.cn>
 <20260711094523.622997-3-functioner@sjtu.edu.cn>
 <2bd62d89-bc53-477b-8c5e-5eec69b344f8@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <2bd62d89-bc53-477b-8c5e-5eec69b344f8@oss.qualcomm.com>
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

On Mon, 13 Jul 2026 10:55:04 -0700, Pierrick Bouvier wrote:
> On 7/11/2026 2:45 AM, Ziyang Zhang wrote:
>> Document the dlcall plugin under Example Plugins: what it does, the trusted-
>> guests and guest_base == 0 constraints, how to load it, and a pointer to
>> Lorelei, one end-to-end userspace implementation, for the toolchain and a
>> runnable example.
>>
>> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
>> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
>> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
>> ---
>>   docs/about/emulation.rst | 158 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
> 
> Thanks for your updates, this is now ready to go.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Thanks for your review.

The Lorelei 1.0.8.0 has been published.

- The devkit no longer ships a host libstdc++.so / libgcc_s.so on any 
runtime search path.
- The guest side is unchanged: the x86_64 sysroot carries no libstdc++, 
so the guest copy still ships next to the guest runtime.

Thanks,
Ziyang Zhang


