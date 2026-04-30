Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82FFCD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIZ0T-0004go-M7; Thu, 30 Apr 2026 17:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wIZ0O-0004gO-S6; Thu, 30 Apr 2026 17:33:09 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wIZ0M-0001Dd-E3; Thu, 30 Apr 2026 17:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777584783; x=1778189583; i=deller@gmx.de;
 bh=kJ98+qtY+j1EeguBI6V0trt9chl9AdBuSQ+KJloDMZc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s73EE8vWuEAVMxvQ2KJTPW2eGrnWA2tI1Ie3WgB/EQHnaZDiQrKjUIrmMrFYVPOZ
 dkLAE9sfTLUFOnUH19gjz6AibujmldaKY5FZuTUsH1ZQUOpOJPk1MFAKJHZHWKWrK
 L0yO2pl9cUITpexFzi/9vCw45ie5tkb+PP/GzKoQuhTBXFvSfyPiPL8WzyZx8Uok1
 TonefoMsKj4WUEiOsJDPOmX85+O0ezzdiec/yxHMha/xoHEOfGKtEe6PU27NwJaMp
 Lnfd6790msoc+nuxgf9vA5QVAz/2WaV9UoLTplcfkvtTUmjKDurmtTAz2pe+NW6mB
 XHAy9RGZaqwWv+sISw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1vKA1k04eh-00xcFX; Thu, 30
 Apr 2026 23:33:03 +0200
Message-ID: <1a6ba003-8850-4996-9aaf-1177e761de51@gmx.de>
Date: Thu, 30 Apr 2026 23:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20260424153600.46116-1-deller@kernel.org>
 <8e0011c5-77b1-41ef-8c55-9ec5f21c3a9b@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <8e0011c5-77b1-41ef-8c55-9ec5f21c3a9b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1X8D8OosX2Z8gzUdSwLxBQC+VYkQflMbHa8uzgZU+M+0DX3pFRN
 pdtOWp7eFmqhELMRwK66LbSyfLS9rwuh2WoFi8mYxGBbBXvZO2PlxIujKCIprT8h645B62b
 zAYQou2vnWcrTZfIIexjEDifVFZI1VvWBCyV0C0lSMhLaY8N1b7f4yYWwaraVmYEeUDUUKz
 l9hKJwpaxlAMDfQ8KHUjg==
UI-OutboundReport: notjunk:1;M01:P0:zq4KTnO5O5Y=;41g1d1a/zrXBp3SpFMkchxwSlIW
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Michel,

On 4/30/26 18:39, Michael Tokarev wrote:
> On 24.04.2026 18:36, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Peter Hartley noticed, that in the qemu code the imr_ifindex member of
>> struct target_ip_mreq needs to be of type "int" instead of "long", whic=
h
>> is what the Linux kernel uses on all architectures.
>>
>> Adjust the type accordingly, and add a QEMU_BUILD_BUG_ON() checker to
>> prevent such issues in the future.
>>
>> This change should fix multicast issues when using hosts and guests wit=
h
>> different endianess or bit size.
>>
>> Reported-by: Peter Hartley <peter@talesfromthearmchair.net>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2553
>> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> This too seems to be qemu-stable material, I'm picking it up.
> Please let me know if I shouldn't.

please take it.

In general, please pick up all linux-user patches which I sent in two pull=
 request
in the last few days, which are (the second pull request):
       linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
       linux-user: Allow getsockopt() with NULL optval address
       linux-user: Flush errors by using exit() instead of _exit() in erro=
r path
       linux-user: Add missing CDROM ioctls
and the first pull request:
       linux-user: Flush errors by using exit() instead of _exit() in erro=
r path
       linux-user: Use abi_int for imr_ifindex in ip_mreqn struct
       linux-user: Fix CLONE_PARENT_SETTID when using fork-like clone
       linux-user: Add getsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NE=
W
       linux-user: Add setsockopt() for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NE=
W
       linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
       linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON userlands
       linux-user/strace: Use pointer type for read and write values
       linux-user/arm/nwfpe: Use thread-local storage for qemufpa
       linux-user/arm/nwfpe: Replace user_registers with current_cpu
       linux-user: Don't define target_stat64 struct for loongarch64
       linux-user: fix off-by-one in host_to_target_for_each_rtattr()
       linux-user/ppc: Fix ppc64 rt_sigframe stack offset

Thanks!
Helge

