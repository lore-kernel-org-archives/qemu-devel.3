Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE7EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 05:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxgqr-0008Bp-Gd; Fri, 19 Apr 2024 01:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rxgqp-0008BZ-EJ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 01:31:56 -0400
Received: from phobos.denx.de ([2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rxgql-0004bK-AZ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 01:31:53 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 83AC7885D7;
 Fri, 19 Apr 2024 07:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713504706;
 bh=wV96HqWBdqwDbyueyRTSZ+AZX2Ljv6f2TS0EOlD8u7c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=x9gYRolBVaLXV1oOR/cSD3fTeNE1KW4c+Ma/xYyunWngODJ6/qrc4iYhld0UEZMwR
 +pXHSSc17CoCLVgdgwqLXBV0kL9zo/f3ftTLnFRwLkkfDORYxa/xafHd5bRmuJQVSk
 R1JpW3FayI7yX6x3HCIM0JIMqlz3U5rwqFctocCcPhft3o9NwSnL43RdaIIUbxTPG9
 ATld3D8vmC7LBCzG9ybVxSKVggVZ7v0J4JxPGDtHxduf7yq64AtKoUQUCxk92Za71Y
 c0BUbhGLpgPvUuSknVa9CAafuhh3zdCRwFMVIXZY2i/05twH33nCnJ5943olOfx0bo
 qETWf3B863SEg==
Message-ID: <df85fb74-4e34-46bb-857b-0d4d483d0625@denx.de>
Date: Fri, 19 Apr 2024 05:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deprecation/removal of nios2 target support
To: Arnd Bergmann <arnd@arndb.de>, Joseph Myers <josmyers@redhat.com>,
 Sandra Loosemore <sloosemore@baylibre.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,
 Xi Ruoyao <libc-alpha@sourceware.org>, Chung-Lin Tang <cltang@baylibre.com>,
 andrew@reenigne.org, Yao Qi <qiyaoltc@gmail.com>,
 Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org,
 newlib@sourceware.org, Andreas Oetken <andreas.oetken@siemens.com>,
 Bernd Weiberg <bernd.weiberg@siemens.com>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <b5d375ed-283-974a-febf-892760ff855@redhat.com>
 <320677a6-1c3a-477c-95fc-b74cb5a4c5c6@app.fastmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <320677a6-1c3a-477c-95fc-b74cb5a4c5c6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Received-SPF: pass client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01;
 envelope-from=marex@denx.de; helo=phobos.denx.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 4/18/24 8:41 PM, Arnd Bergmann wrote:
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

I might still have the 10M50 board, but it wasn't powered for a very 
long time.

