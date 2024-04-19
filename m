Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F320CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 12:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxnhe-0007e8-9O; Fri, 19 Apr 2024 08:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinguyen@kernel.org>)
 id 1rxmzW-0004FF-18
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 08:05:21 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinguyen@kernel.org>)
 id 1rxmzU-0004KF-2U
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 08:05:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 88757CE1A9C;
 Fri, 19 Apr 2024 12:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E45AC072AA;
 Fri, 19 Apr 2024 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713528307;
 bh=JjhfgGKDvS+BVkDg6yV/bx1++/VQqZcxH99bfPJLXFA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZRi/Twb2b25FmwmLZzpZoGNmcAmcD4Zwai1c+o6wgMdl6hlcBYFiGmTNh3GxgxkQl
 sH2Np8vgm99LX/UJMrhAReObqzK8Hruz3WxGRxlFBc3GVfhuMm+RXTFdRIzfF3jrcD
 9aC27k87ZVh75j4BfLP1Y4jTfqH0WPIKnZwoJRuoMwd9udxr+2z/djqk4Z7dO4RNLp
 qgfUIcD0ybqIFBT7/DqYGVY8grI9QIDJR1I4uzKDvRua3EyPfg4oWxYWWcHmFsjHpj
 yHYKuRSWxZXFSp+91xML8nK2fu0FUqxtr2ypjnwPehOyasprDZxnBUl37C8yza8E12
 5424pPP/9b6tQ==
Message-ID: <975c8ed9-e0b0-4b5e-8a4c-0970c98fa3e6@kernel.org>
Date: Fri, 19 Apr 2024 07:05:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deprecation/removal of nios2 target support
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Joseph Myers <josmyers@redhat.com>,
 Sandra Loosemore <sloosemore@baylibre.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,
 Xi Ruoyao <libc-alpha@sourceware.org>, Chung-Lin Tang <cltang@baylibre.com>,
 andrew@reenigne.org, Yao Qi <qiyaoltc@gmail.com>, qemu-devel@nongnu.org,
 newlib@sourceware.org, Andreas Oetken <andreas.oetken@siemens.com>,
 Bernd Weiberg <bernd.weiberg@siemens.com>, Marek Vasut <marex@denx.de>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <b5d375ed-283-974a-febf-892760ff855@redhat.com>
 <320677a6-1c3a-477c-95fc-b74cb5a4c5c6@app.fastmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <320677a6-1c3a-477c-95fc-b74cb5a4c5c6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=dinguyen@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Apr 2024 08:50:53 -0400
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



On 4/18/24 13:41, Arnd Bergmann wrote:
> On Thu, Apr 18, 2024, at 17:44, Joseph Myers wrote:
>> On Wed, 17 Apr 2024, Sandra Loosemore wrote:
>>
>>> Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and remove
>>> support from all toolchain components after the release is made.  I'm not sure
>>> there is an established process for obsoleting/removing support in other
>>> components; besides binutils, GDB, and GLIBC, there's QEMU, newlib/libgloss,
>>> and the Linux kernel.  But, we need to get the ball rolling somewhere.
>>
>> CC:ing Arnd Bergmann regarding the obsolescence in the Linux kernel.
> 
> We have not yet marked nios2 as deprecated in the kernel, but that
> is mostly because the implementation does not get in the way too
> much and Dinh Nguyen is still around as a maintainer and merging
> bugfixes.
> 
> Almost all nios2 kernel changes I see in the past decade have been
> done blindly without testing on hardware, either for treewide
> changes, or by code inspection. The only notable exceptions I could
> find are from Andreas Oetken and Bernd Weiberg at Siemens and
> from Marek Vasut (all added to Cc in case they have something to add).
> 
> We should probably remove nios2 from the kernel in the near future,
> but even if we decide not to, I think deprecating it from gcc is the
> right idea: If there are a few remaining users that still plan
> to update their kernels, gcc-14 will still be able to build new
> kernels for several years.
> 

I'm planning to do this soon.

Dinh

