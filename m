Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5177C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qWU-00028j-RW; Thu, 24 Sep 2026 16:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x9qWQ-00023b-N4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:58:26 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x9qWN-0005sZ-Dn
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790283493; x=1790888293; i=deller@gmx.de;
 bh=u1mHhh2a4zG2RjUVyv4zBl+NgSpfWNtvIWIBldk/Jyk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IAlBzUx/ZC9saNlFT2SjE3uPKYyPCUwaXaDAaVmX5WoVafTPidHhw3m5/g1hHXYD
 ABTlcx0p4XUsr5WrGBCBRDw7GRIXpxpYtAOGy1NN8ssBkShotDh2PP6alwfMJxc0f
 zmF6wq/WyfLByMdw5hoNM69BVHdAlkzBpAaiQ9hjfFk3iY7yBCQ+RtXKzV90WgsIV
 e2h4TQcA673MucwZAxzni/i8J5xjzAcvS4pdrRurliL0nsYiB9C3H5CcBKnxxpTo6
 dMtENPB76/EeJCPKAVG4Y8RTri8W5UArEFsWM81TrYRdCoymKXxvmp8RpUPZnQipV
 vkrCeLh/w/5sMPykpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1xBCtm0mx5-0021iI; Thu, 24
 Sep 2026 22:58:13 +0200
Message-ID: <0bcf35c2-0baa-4857-9e90-0bee10e4d855@gmx.de>
Date: Thu, 24 Sep 2026 22:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: report EINVAL for a misaligned mincore() start
To: Michael Morrell <mmorrell@tachyum.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Igor Shevlyakov <igor@tachyum.com>
References: <20260924193143.2062533-1-mmorrell@tachyum.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260924193143.2062533-1-mmorrell@tachyum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chhjh+IiC7qiVTsrgnKaS9LH+0ewkFzxuO6Tcs1h8J5uFJBx2o4
 fsTAN0BdyNjVsoh2BQQwy92/z+LEl4erLcb3y5raCL16sHBf77LZbnU8j3kWl/eHwmdYfsf
 cNZiMes1xAoKRF5ldEc1SD8HK2gpcb64SmwdYYB6IpfwUd2u+CANmEHvuTlkdF5HtEM300y
 QOXGAQdjNjoifpUT6lSZA==
UI-OutboundReport: notjunk:1;M01:P0:Xj4re0JLjL4=;oibif6V1uguSJJWRlyctoB/PM9e
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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

On 9/24/26 21:31, Michael Morrell wrote:
> From: Igor Shevlyakov <igor@tachyum.com>
>=20
> mincore(2) rejects a misaligned start address before it looks the range
> up, so a start that is both misaligned and unmapped is EINVAL.  Here
> lock_user() runs first and fails, and the call reports ENOMEM instead.
>=20
> When the range is mapped this changes nothing -- the host syscall
> receives the misaligned pointer and answers EINVAL by itself -- which is
> why only the unmapped case is visibly wrong.
>=20
> Caught by glibc's misc/test-errno-linux.
>=20
> Signed-off-by: Igor Shevlyakov <igor@tachyum.com>
> ---
>   linux-user/syscall.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
Reviewed-by: Helge Deller <deller@gmx.de>


