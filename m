Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4D1CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZuhe-0006aY-2y; Wed, 17 Jun 2026 14:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZuhY-0006Yj-4w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:09:24 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZuhV-0004ui-Gq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781719758; x=1782324558; i=deller@gmx.de;
 bh=LtgiR9pJ0jg4VUriOVKL48NmmzpCLe6X9/9tK9txGKU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NxHC+Bw6fcCqjEQpGCxTabq6WLhPiTAHZCi6wu2kARzIVOx2NLbIPItRCG5j0gyz
 rzsePJsgALQYOTZTQZ0Pgp7Pi2wigV8DWAELANk/eABPQHqkbXGg/QVQ49zzXVDAK
 yPokmOyrssvdPBrr6tnaJEP6NJYSBsiAdctD8scftdcWRYzYbHHtHY3u1Jy41pPOU
 3BY5ux9FGrBGnWM0ZodSRvKpzDG9GnUWGrvfzpIpBkgV5j+xNKbTxOBV2pEttuR2t
 TEU8/CgPi7C6nH87S/4+G/bEw+I0yDfK143AdGU8O3rjP/VajcQnWEqU4QzvmaaMV
 Txg8M0z4C2ihs8e93g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1x2ckh19dR-00a9Ku; Wed, 17
 Jun 2026 20:09:18 +0200
Message-ID: <2d1c9a75-3762-4a12-9d29-3bd0617d97f4@gmx.de>
Date: Wed, 17 Jun 2026 20:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] common-user: Initialize mmap_min_addr for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260616212055.334466-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SW7nL76YnbwjouCx1ygecpbMCKLZYNNeEKeDhsDu4ab/SXJbLIY
 1sYFDyuT5sTR3dLgFfvQXfMhwcOQGfC2yeMH9tzRRiWJGs+yeBikTI+uWvg4bF7RFgxMkAp
 mEx1IW2yOApr5DpXTjyugJn4AYZItCSROrzSYdo0thGY68pD5t79yfneogp0dEZH+ETaSg6
 Z4+Bkx+kD3Rm7+MF40H3g==
UI-OutboundReport: notjunk:1;M01:P0:8bTHt/3Em2Y=;LSKePhJ81UPc8CY7OGeD/Zts27r
 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
 WmdeDCSyl1PJvDkp9hldo+BvUCw=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 6/16/26 23:20, Richard Henderson wrote:
> Use sysctl to fetch the vm layout of the current process.
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de

