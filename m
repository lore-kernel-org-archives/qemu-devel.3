Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF57C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKvq-000811-2M; Fri, 07 Aug 2026 09:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsKvo-0007zl-9P
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:48:16 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsKvm-00046e-HH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786110488; x=1786715288; i=deller@gmx.de;
 bh=DCoiJZ9pLGJKNMXJ7jjllxKnIBrvULhaGAQ8M45wN20=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V6L+9PPKfsv9lH6V0CgbwSA7j4Nc2695d/Yb1WdaKFivBdyPcjNAjaB78x2lJYRf
 M+SC5lwhDyMze0/hfV7tU5PfB8L0FoR3u8epyHH0lw8JrUmJQ2QspzK9Dn6nBhNgP
 Auov3lmshPJM9APACEXf7KRl60bKI93S4xZ2H971oLHGmzoT8JGcIdfsKtdIhS9mP
 V6EP3RJN+p+GtAungszSAailLuL92vhmxm0Q/7t98yK9wQqxJhfZ6JaLB21L3pMeu
 zf+n9mk0oXxPEj4ZlLnrmr7uq3zWHAGc0XdUWXJukROpWCDW7skYJSS7CMaIj7cP4
 c/tFIaWpQD/czFKW6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1wM5Eb0haH-00UK0H; Fri, 07
 Aug 2026 15:48:08 +0200
Message-ID: <dd2d4ad9-8e80-4c2b-b5b7-570bf90add7c@gmx.de>
Date: Fri, 7 Aug 2026 15:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: implement mount_setattr(2)
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260805171605.3119981-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260805171605.3119981-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ki32iucgO9ng2PF+KZLvFz3og34OzWjytLqH3qRT4ZxtnSlq/wY
 UkHWjk+5HPtptJ7FoH4hUAzYE7meddrUtzqqOiCsCXrrU5Yz372twpK/rEbndtLCw5uY/ra
 EFg+sZUJPB/Pbzx6E4CxhWHQJjEHn9uc1+2kssPzOGNLss2zLbLPYdiuRb/N0vhs9ZdN7Af
 gzdi3tt54zHYcBXs9ybaQ==
UI-OutboundReport: notjunk:1;M01:P0:YLfTcZOsYjA=;5QcCptd02s3iZf4vzCFOUIBVMzj
 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
 0RSLXQhfMz+wwuMA==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

On 8/5/26 19:16, Matt Turner wrote:
> mount_setattr() was in the syscall tables but had no implementation, so
> guests always got -ENOSYS. systemd uses it when setting up per-unit
> credential mounts, which fails the affected units with EXIT_CREDENTIALS.
>=20
> struct mount_attr is an extensible struct like open_how, so handle it th=
e
> same way openat2() does: reject sizes smaller than the ver0 struct and
> require any unknown trailing bytes to be zero. All of its fields are
> 64-bit, and the MOUNT_ATTR_* and MS_* propagation values are identical o=
n
> every target, so only the byte order needs fixing up.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/strace.list    |  3 +++
>   linux-user/syscall.c      | 44 +++++++++++++++++++++++++++++++++++++++
>   linux-user/syscall_defs.h | 13 ++++++++++++
>   3 files changed, 60 insertions(+)
Reviewed-by: Helge Deller <deller@gmx.de>

I'll queue that patch (and the others) up for after qemu-v11.1 has been re=
leased.

Thanks!
Helge

