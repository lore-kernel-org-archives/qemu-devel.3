Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310AEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKtp-00011H-Dq; Mon, 13 Jul 2026 13:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjKtm-000112-Km
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:56:59 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wjKtj-00053T-BF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783965404;
 bh=ccJTLNQ3W7+iSP2sg8o+Gm0l+NeKXNFTBSuABlh0NSY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=S4JEQRnO6GrA/hTPCinO196nUU3stwfr4wBVLImnaCoJwEFCIkrTcDRzfXxPp/WH2
 fvJCraX1uIQVuCB8csnCjrvs8yTsqey4UTskJjj1h5Ay7+tefk6IfF/wBApNyZR43h
 YOwqJ6dGyZuXqzS0u20FtnMK9jlcFPTY5CmZQlsjx8zWTenMNGD1OQcJP373dZNkjQ
 xQncDoFcyi6+OgZtIdse3Wsrtvgvm1gI4KG6Ukav1YgSO/NYEqo+h0RypqvkkvJ4Ca
 rkkfPOrlNq5evzFYMmunMVVjHr3p/T6HTLNWPgCWPdfii/TFdAHaFVPjnzufzJwp/G
 bZU3dQE6W/Inw==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 41BAD2FF367;
 Mon, 13 Jul 2026 17:56:44 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 538E437C91E;
 Tue, 14 Jul 2026 01:56:13 +0800 (CST)
Message-ID: <37b40d64-aaa7-4358-ad5d-70c15dc05cba@sjtu.edu.cn>
Date: Tue, 14 Jul 2026 01:56:11 +0800
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
> On 7/13/2026 9:34 AM, Ziyang Zhang wrote:
>> On Mon, 13 Jul 2026 08:31:18 -0700, Pierrick Bouvier wrote:
>>> The problem is that if that the guest program, or the host library (host
>>> libhello) may depend on libstdc++. If they do and if they depend on a
>>> (newer) symbol not present in lorelei libstdc++, we break ABI. Same goes
>>> for libgcc.
>>>
>>> By not doing this, you'll be forced to provide a lorelei devkit
>>> everytime a new libstdc++ is published, or a distribution updates its
>>> gcc.
>>>
>>> The only solution is to embed libstd++ and libgcc statically, or rely on
>>> host libraries. If you choose the second option, you know have the
>>> opposite problem. So I think the only way to solve it is really static
>>> linking, even if it will slightly increase binaries size.
>>>
>>
>> The devkit already ships libstdc++ and libgcc anyway: its own clang/
>> LoreTLC link them dynamically, and we bundle them so the toolchain even
>> starts. So bundling libstdc++ for the thunk flow adds no new dependency,
>> it just reuses one the devkit must carry. Static-linking the thunks
>> wouldn't make the devkit any smaller or more self-contained either,
>> since clang still needs the dynamic libstdc++; we'd only be adding
>> static copies on top of it.
>>
> 
> There is a difference between the toolchain dependencies, and thunks
> dependency. For the first one, it's perfectly find to provide libstdc++,
> for the second, it can create conflicts at runtime that may be very hard
> to diagnose and solve.
> 
>> On the ABI risk itself: libstdc++ keeps a backward-compatible ABI, and
>> the copy we bundle is recent, so a thunked host library only breaks if
>> it was built against a strictly newer libstdc++ and references a new
>> symbol. Even then it needs no new devkit, because the resolution order
>> is the integrator's to choose. On a host newer than our bundle, putting
>> the system libstdc++ ahead of the devkit's on LD_LIBRARY_PATH lets the
>> host library bind the newest one, while clang and the Lorelei runtime
>> keep working against it by backward compatibility. So a gcc update on
>> the host doesn't force us to reship.
>>
> 
> Sure can choose indeed. However, he has to find where such libraries are
> located on his system, and prepend that to LD_LIBRARY_PATH. Not the most
> user-friendly thing to guess and debug IMHO.
> 
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
> 
>> Based on the above reasons, I prefer to do that than statically link and
>> grow the big artifact. Does that hold for you?
>>
> 
> Ok.
> 
>> Thanks,
>> Ziyang Zhang
>>
> 
> Regards,
> Pierrick


Wait a second. I missed something.

Sorry, last time I answered without actually checking the libstdc++ 
situation on the four distros. You were right to push on it, so I looked 
properly.

You were right that the x86_64 sysroot is the crux: libc6-amd64-cross 
gives /usr/x86_64-linux-gnu/ a libc but no libstdc++, so the guest side 
has no system libstdc++ to fall back on. That's the side we should keep 
providing ourselves, and the devkit already ships the x86_64 libstdc++ 
next to the guest runtime for exactly that. It's only a default, though: 
if a guest executable needs a newer libstdc++, the user can put a newer 
x86_64 libstdc++.so ahead of ours on the guest LD_LIBRARY_PATH (the -E 
one) and it takes precedence, while our runtime keeps working against it 
by backward compatibility. So we are not locking anyone to our version.

The host side is different, there libstdc++ is reliably present. I 
checked each distro's stock minimal base image, with nothing installed 
on top:

Debian 12: libstdc++6 12.2.0-14+deb12u1
Ubuntu 24.04: libstdc++6 14.2.0-4ubuntu2~24.04.1
Fedora 40: libstdc++-14.2.1-3.fc40
Arch (2024-08 snapshot): libstdc++.so.6 from gcc-libs 14.2.1
It ships out of the box on all four, and the C compiler pulls it in on 
Debian, Ubuntu and Arch.

So the split I'd propose: provide libstdc++ only on the guest side (the 
x86_64 sysroot has none), and on the host side rely on the system's, so 
the host thunk and the real host library both bind the host's own 
libstdc++ rather than a copy we ship. That directly addresses the ABI 
point you raised: nothing we ship shadows the host's libstdc++, so a 
thunk never forces an older libstdc++ onto a host library built against 
a newer one.

Does that split sound right to you?


