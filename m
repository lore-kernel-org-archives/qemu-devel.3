Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED638FC617C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 17:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc5Wt-00013r-V7; Sat, 03 Jan 2026 12:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc5Ws-00013i-RH
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 12:35:06 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc5Wq-0001vu-PD
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 12:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767461693; x=1768066493; i=deller@gmx.de;
 bh=azjRcFhjvNUgHQPQB2VLz0b5BLy/KbWP0Cuu8brhwgk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QehEUQH05F+FeVtN6YiQtJykZt/ao/WJ+Pw8L/gMCsoy8dwaV37Gqd9sXo24Tr1f
 p4Tw/wnlLtxHh1rauYJp1rotfAROQIeHuKoRidBsSb15oQTRo9AqvHrZmBKYmgSca
 xYo4yQJxyAjsQER18+1LO9xG+NjhOhkWsjZwYL8GOAndTfBdMEiCiedjOQU3xs16o
 3yCZAkpJoTHzZSzj9Bo0JduTatv0lmNKbKwbq+FumkKHpCG6mefKnK5aEzLJjUSYC
 WMIgGHcqJu6t2GqMumy4sCXZJcQiQICsUI2mCEDBO+uHqtfYOM3vDXe+e5fSZCxpK
 yVKiLwj48upgZpwrCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1vWr7i2ZZf-002Gi9; Sat, 03
 Jan 2026 18:34:53 +0100
Message-ID: <51becfa3-cf63-4f88-b4a5-593b5363c0e9@gmx.de>
Date: Sat, 3 Jan 2026 18:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] linux-user: Add missing termios baud rates
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Vivian Wang <wangruikang@iscas.ac.cn>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-8-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-8-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F+g8gabm2U3Wqrt4dKmb+IkcMsp7EQhRtPjmSWqu41aWSzlPsBQ
 woW7r9e8zORYpplzfJxQLw0esAnU/sdKuv9pY4gz+MSfB7c4hDKfr7itUtusTUcWx7CohGS
 X6yRZURtxlKTY1ZDBTqym1h9/I2dPMh/3kbgWeTZ7Zx8uVhTOnwdUBQkRIdUzXIy3ho7N5/
 NVrpnJ+GF53hcEWWs6DBA==
UI-OutboundReport: notjunk:1;M01:P0:a37AYM4SAqs=;dIKdegeNti9NASi6iE1QmntzUyF
 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
 ccuILmcYHtklJG0tcwY9I+L+2h1Jf
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/3/26 16:25, Andreas K. H=C3=BCttel wrote:
> From: Vivian Wang <wangruikang@iscas.ac.cn>
>=20
> Add several missing baud rates and inputs baud rates in cflag_tbl.
>=20
> Add these missing definitions in termbits.h:
>=20
> - TARGET_BOTHER for alpha, hppa, ppc, sh4, sparc
> - TARGET_IBSHIFT for hppa, mips, ppc, sh4, sparc
> - Missing standard baud rates for hppa
>=20
> These are required for the glibc test tst-termios-linux.
>=20
> Link: https://lore.kernel.org/qemu-devel/20251203-linux-user-higher-baud=
-rates-v2-1-e45b35224437@iscas.ac.cn
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>   linux-user/alpha/termbits.h   |  1 +
>   linux-user/generic/termbits.h |  2 +-
>   linux-user/hppa/termbits.h    | 16 ++++++-
>   linux-user/mips/termbits.h    |  4 +-
>   linux-user/ppc/termbits.h     |  1 +
>   linux-user/sh4/termbits.h     |  5 ++-
>   linux-user/sparc/termbits.h   |  5 ++-
>   linux-user/syscall.c          | 83 ++++++++++++++++++++++++++---------
>   8 files changed, 92 insertions(+), 25 deletions(-)
Reviewed-by: Helge Deller <deller@gmx.de>

