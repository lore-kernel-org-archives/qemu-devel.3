Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05343C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJdD-0001rc-Us; Mon, 13 Jul 2026 12:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjJdB-0001rU-9f
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:35:45 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjJd7-0002iI-QJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783960526;
 bh=mxLpZivNlcYcew61qEUBQQP5zsbwUmco/vI/h/u9Xqk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=v9vtJ3Y8aGvekckLT689t9/HUfJfIT/w9Mx/kSBfKI9bfnuvsOHT40b/q+oFp63Lb
 HRf8tLXMRnLsTkaKJgDusVUy5Fw0CaStO9+Pg5xQpvZ+GWPq50VXUf5o+u0MEdvvRc
 d+rJro08xAkGhBh9r0jy6HxYlOc/sz28twJKHc4WcIq0txnGTsOPSRxo4GewMJLhY/
 M/U1RbbDlAi9qQIkFDPVX1Sd0cLThTPYYa3Ot0NpcMT+QoWXTwA78HzHQPQfUJgX0l
 wXG4tbRsxUI1crWuX4IpCVqpCR9BUGVq/u32XYUQHGzSpErY9nPiFN29oOtJhKiFv4
 Hf3gU4SQfFygA==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 825C52FF3FF;
 Mon, 13 Jul 2026 16:35:26 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 53B8637C8C7;
 Tue, 14 Jul 2026 00:34:55 +0800 (CST)
Message-ID: <2c57e188-b9f5-45b9-90b3-81a3d128254a@sjtu.edu.cn>
Date: Tue, 14 Jul 2026 00:34:53 +0800
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
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <8c2aa5fe-026e-45c2-a908-5f6c245b2993@oss.qualcomm.com>
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

On Mon, 13 Jul 2026 08:31:18 -0700, Pierrick Bouvier wrote:
> The problem is that if that the guest program, or the host library (host
> libhello) may depend on libstdc++. If they do and if they depend on a
> (newer) symbol not present in lorelei libstdc++, we break ABI. Same goes
> for libgcc.
> 
> By not doing this, you'll be forced to provide a lorelei devkit
> everytime a new libstdc++ is published, or a distribution updates its gcc.
> 
> The only solution is to embed libstd++ and libgcc statically, or rely on
> host libraries. If you choose the second option, you know have the
> opposite problem. So I think the only way to solve it is really static
> linking, even if it will slightly increase binaries size.
> 

The devkit already ships libstdc++ and libgcc anyway: its own 
clang/LoreTLC link them dynamically, and we bundle them so the toolchain 
even starts. So bundling libstdc++ for the thunk flow adds no new 
dependency, it just reuses one the devkit must carry. Static-linking the 
thunks wouldn't make the devkit any smaller or more self-contained 
either, since clang still needs the dynamic libstdc++; we'd only be 
adding static copies on top of it.

On the ABI risk itself: libstdc++ keeps a backward-compatible ABI, and 
the copy we bundle is recent, so a thunked host library only breaks if 
it was built against a strictly newer libstdc++ and references a new 
symbol. Even then it needs no new devkit, because the resolution order 
is the integrator's to choose. On a host newer than our bundle, putting 
the system libstdc++ ahead of the devkit's on LD_LIBRARY_PATH lets the 
host library bind the newest one, while clang and the Lorelei runtime 
keep working against it by backward compatibility. So a gcc update on 
the host doesn't force us to reship.

There's also an active reason not to static-link. Both the Lorelei 
runtime and the generated thunk libraries depend on libstdc++. If we 
statically link libstdc++ into a thunk while the host library it 
dispatches to links the system libstdc++ dynamically, the process ends 
up with two libstdc++ copies on the host side, right across the boundary 
where C++ objects and exceptions pass between the thunk and the real 
library. That can break:

- Exceptions: one thrown in the host library may not be caught in the 
thunk. The two copies have different std::type_info for the same type, 
so the match fails and it hits std::terminate.
- dynamic_cast / typeid across the boundary: they assume a single 
type_info per type, so they can start returning null or misidentifying 
types.
- Duplicated global state: two sets of the iostream objects, the 
locale/facets, and the exception emergency buffer.

Based on the above reasons, I prefer to do that than statically link and 
grow the big artifact. Does that hold for you?

Thanks,
Ziyang Zhang


