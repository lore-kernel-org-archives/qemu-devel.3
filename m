Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FB9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKx4-0001hF-8C; Mon, 13 Jul 2026 14:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjKx0-0001gv-MI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:00:18 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjKwy-0005b6-UM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783965613;
 bh=W7EXMWvi+CButZfpZYU9913tpFHtDzjR78UmRocEFis=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=O7lGUHxkmbzJ7jKp6Mx1rXv/So9JVN89a4zVDL9LHaZQIUoz7hUmkHFmxqFYwjob0
 csYwZweWqwvIWhMicuO2X5dLBQitVDxp/fhIcI9QtCBp8DfZVctCdN+VmNKRFKWRL+
 3hKRI4Hgqf37/7BmGHFz+ue6S+5nuFujgxUlGyHodvBGCi1iQcHHo0Wj+astHy4uAU
 jfRdO4HdrshuxeaOeNhR8wdfrxV07nmr4chiGQLXuhaaBxpF63qHdh6KUk2kewpBWD
 0MpeiuzUm/tbECNTSxz2DSe2nw52+6oxTC6OyxwJWKHX827LkNcltEK43UK0Fb8Jbf
 f1BliraCZ7vfw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id DFE082FF367;
 Mon, 13 Jul 2026 18:00:13 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 80DF537C8C7;
 Tue, 14 Jul 2026 01:59:43 +0800 (CST)
Message-ID: <31b69c4d-1a30-4791-a5e4-349ad98c67cd@sjtu.edu.cn>
Date: Tue, 14 Jul 2026 01:59:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260710212601.583352-1-functioner@sjtu.edu.cn>
 <20260710212601.583352-3-functioner@sjtu.edu.cn>
 <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
 <5a303ce5-cb6f-43b9-857f-39cffc8c7d67@sjtu.edu.cn>
 <8c2aa5fe-026e-45c2-a908-5f6c245b2993@oss.qualcomm.com>
 <2c57e188-b9f5-45b9-90b3-81a3d128254a@sjtu.edu.cn>
 <69924eee-ba12-4a3e-baff-8ecb86d1ce77@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <69924eee-ba12-4a3e-baff-8ecb86d1ce77@oss.qualcomm.com>
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

On Mon, 13 Jul 2026 10:53:56 -0700, Pierrick Bouvier wrote:
>> There's also an active reason not to static-link. Both the Lorelei
>> runtime and the generated thunk libraries depend on libstdc++. If we
>> statically link libstdc++ into a thunk while the host library it
>> dispatches to links the system libstdc++ dynamically, the process ends
>> up with two libstdc++ copies on the host side, right across the boundary
>> where C++ objects and exceptions pass between the thunk and the real
>> library. That can break:
>>
>> - Exceptions: one thrown in the host library may not be caught in the
>> thunk. The two copies have different std::type_info for the same type,
>> so the match fails and it hits std::terminate.
>> - dynamic_cast / typeid across the boundary: they assume a single
>> type_info per type, so they can start returning null or misidentifying
>> types.
>> - Duplicated global state: two sets of the iostream objects, the locale/
>> facets, and the exception emergency buffer.
>>
> 
> That's a good point, but does lorelei even provide a solution for that?
> I guess that exception raised from an host library and sent back to
> guest binary with target specific types will not result in what is
> expected at the moment.
Currently, the Lorelei host runtime disables exceptions. However, it is 
possible that the host thunk library enables exceptions, and these 
exceptions should be caught by the host library.

Additionally, in the Lorelei guest/host runtime, there is a logging 
module. Therefore, if the stdout buffer of the host library is not 
consistent, the output will become disordered.

