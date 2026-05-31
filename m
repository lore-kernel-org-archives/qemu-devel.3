Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29D4CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wToAm-0007V4-GC; Sun, 31 May 2026 17:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wToAj-0007Tm-EW
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:58:17 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wToAh-00044L-Uq
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780264693; x=1780869493; i=deller@gmx.de;
 bh=+1bYsqzAU2EkkobNsKTtKDZLXOhwCAUYm+KmzprvQe8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CtkK2VWZHllXHsFLDqXuA2Olf3SyMlHsU5VB/4WtYXeS3zylgivMtdnrcZyFTNJ2
 WR+zPO9p+lHt9VdE5q4T3j4N58sHS8tqZBw18WbY4Bmp8js6LBs3gkeeC0/9k6jYC
 yNKjbi5eDyqJXpkkmxD2fXSQPgt8FUQXovIKo3j61cXSr9S5/qqe9HNH9ieDuaKCS
 cvmo6XV96B4Bgf4wLqJ/b7z/qKrmNZOQElGJE97J8FovM0ok5XAAJPuV4Ci8ZHIlI
 td0aOvTqwq8nhH3YsZDoL7GQqU6NTATLc+h2diMlj+tId/LAiQMSFdu2GSVFWlIBk
 uqDW1nYL/KoAzMxF6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1xRdiZ1L2Y-00wmhI; Sun, 31
 May 2026 23:58:13 +0200
Message-ID: <af3915eb-0421-4cfe-982c-73e5d0678cf9@gmx.de>
Date: Sun, 31 May 2026 23:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] linux-user: Pass image_range to probe_guest_base
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-5-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260530211248.375318-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EEj4Z6TEvYSk0V/Geewq7XXKI6V8h52+5Te50o7no4DQBzGz/ak
 BxRzP9yhBlwEZWOWInGLhMMBpVj8PTZmns96REFKNFA7+vNTBi2L/ErpqZooEeG88/FWKeU
 VESFyigHs+faNrz0pN3LyFElWv7jRCnM76LhWQWpC2st2D5gf14VVnSE5U0bwQkudQu5Vc8
 Nsj4vQhSSpK7yQqJJG8Mw==
UI-OutboundReport: notjunk:1;M01:P0:p1WjtJGvToM=;m+H3qclXeMRSCtpKnoYV5wGWuXu
 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
 5E399iJADciZZyVxszTFVEHBWMU=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/30/26 23:12, Richard Henderson wrote:
> Pass a PGBRange structure instead of separate guest_loaddr
> and guest_hiaddr parameters.  This allows NULL to indicate
> that the image is relocatable, so that image_range->lo =3D=3D 0
> is a valid fixed setting.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-internals.h | 13 ++++-------
>   linux-user/elfload.c        | 46 +++++++++++++++++--------------------
>   linux-user/flatload.c       |  2 +-
>   3 files changed, 27 insertions(+), 34 deletions(-)


Reviewed-by: Helge Deller <deller@gmx.de>

