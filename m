Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDB0FC037D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwQR-0008Nz-JW; Thu, 23 Apr 2026 11:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFwQP-0008NM-5x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:57:09 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFwQN-0004V5-4B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776959825; x=1777564625; i=deller@gmx.de;
 bh=lEWjx+DC1UThTfyivqVqKTp9gDviJ+quV++/zg6pa2w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aPRFm/EsX4O6XJyXLr+6K2+FAJtsw598QQzUF2hdmkY8kewsFQFhKdwmRZFv2BFW
 2UONr9KH7PcBiSBYtdRa4Hd7aSVKRRB7RmLx3QNzcE4Vvyla5nImwiTXLIxloOUKV
 eI0EJ2GACFf40WLVtjmJ2dALupV8Jzdm6WIzq3/3BP2lVCJarmFAOLf8jA0evc+uC
 pefqRYNHE+88zRtZlBcRUOJ7jaiCLW5+bmUEonuS+RFaZDPzknKplDA2DIsxIs9Qu
 9/zjNcGaJ0FDngGbtoQeoRvLVJQeGy/wgEwaYkZI3ko2wYsp05a3Jcdg7Xoq82FJU
 zSWhT4p1/H8ODFHy8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1wC9LD0khK-001OaW; Thu, 23
 Apr 2026 17:57:05 +0200
Message-ID: <6964cdc9-f730-46bd-874e-99c29600c5d3@gmx.de>
Date: Thu, 23 Apr 2026 17:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
To: Peter Xu <peterx@redhat.com>, Helge Deller <deller@kernel.org>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
References: <20260423151521.3969-1-deller@kernel.org>
 <aeo_xCeDUu2VRKyc@x1.local>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aeo_xCeDUu2VRKyc@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GtNadevSXxD+py1GVvEXqcjuyHw/WNoZMhbYqpJxe9mYGMUzqVE
 eKrtNP5PLjX3/GfQRgUKhq7qpuDprI8vYC+/ITOBUlVtsL6DDgXEi21BIN0zoMZmDS0pkjm
 HgQrKDlB0oAD1kiWPG4fTDODEuVT786jHJFTgCXNFbvZNKH4jRDRR8lh5Vz1xtCZn5/dw3r
 Gqq6dg9H81vxijtauKK3A==
UI-OutboundReport: notjunk:1;M01:P0:OcWzq5MwPi8=;jmPhVWmZCFl3Yooa71otMJQBP+i
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

On 4/23/26 17:50, Peter Xu wrote:
> On Thu, Apr 23, 2026 at 05:15:21PM +0200, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> I'd like to step up as maintainer for linux-user. I'm actively using
>> linux-user to emulate a HP-PARISC (hppa) linux environment on my debian
>> buildd servers, so I'm very much interested that linux-user is running
>> good and stable.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ad215eced8..4736f5ad74 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4074,6 +4074,7 @@ F: tests/vm/*bsd
>>   T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase=
-3.1
>>  =20
>>   Linux user
>> +M: Helge Deller <deller@gmx.de>
>>   M: Laurent Vivier <laurent@vivier.eu>
>=20
> Will Laurent still be maintaining?

I don't know. I added him when I sent the mail, so I hope he will answer..=
.
 =20
> I don't know if the order matters at all, no matter so.. IHMO it might b=
e
> good to keep Laurent as the 1st entry.

That's fine for me. I'll change it in my commit.

Thanks!
Helge

>=20
>>   R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>   S: Odd Fixes
>> --=20
>> 2.53.0
>>
>>
>=20


