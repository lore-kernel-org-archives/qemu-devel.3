Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14357FC617E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 17:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc5H0-00069k-T0; Sat, 03 Jan 2026 12:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc5Gz-00068X-0z
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 12:18:41 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc5Gw-0008OV-Lt
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 12:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767460711; x=1768065511; i=deller@gmx.de;
 bh=jJsinxqtRGDq7vGM8CFsvKDkSeyqarbsbESD7nie3BQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k2gCXUbwVwN1ghCYXxMSfSFv3NAIBZS1FBhWp/w++ObgDs83Q0OZREWoEmy9cVxs
 3/7oxIMeRHnM4g+p58X7R/D4lLUaD6V1GpEFXdz/N5ySP6lb/gT+gpsdCdFlVSt7Y
 ZEFsiiHOePfrvs5ibitChXMIsAIAtEbJNnit6WkuEZRliAE0kcZ3NVcWAFcrvh3jz
 EDcGR/C3vZiC3ybFZ7cmOVoumh0DlE+sxYwr/H01GSAXZZrM8mnsCQ3dItfeCYVBo
 qn7ux088Eg2glgV53nesr+SeiyktNhZJBZpkaLjGL13gmvenElqVXWzerDMq3q+Ep
 DLT8ngnvMpruRa2Whg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1vii2J2Hf6-00AYzZ; Sat, 03
 Jan 2026 18:18:31 +0100
Message-ID: <cda6a75d-f09f-4f8c-b532-86eee20e4c19@gmx.de>
Date: Sat, 3 Jan 2026 18:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] Add termios2 support to hppa target
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-4-dilfridge@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260103153239.15787-4-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qkhH1UV5EmyfFXfbqKu42xB4XEoGYHt/4wfi77MMwya1fKKtoK2
 D1N3sA0UMCm04vMR5Hf5w4RkMLE8j30g3E3nmHYP9N4UhXZi9lcdHZFyxTemjjCK8nyaE3L
 qtQy43sKJIytp7cN4aYKk6K+yM2523/w8R1Uw8d869mVlY8A8oc62Zkqg9ndI1YYybx3eWT
 5VzuBGkZCcdYn9I2+2hyQ==
UI-OutboundReport: notjunk:1;M01:P0:tOBeIhllzyM=;0ExFKybkurRUNPjZJz0/eCNQjcT
 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
 Sst2FZsQ=
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
> From: Luca Bonissi <qemu@bonslack.org>
>=20
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> Link: https://lore.kernel.org/qemu-devel/ccf1be5c-9e2e-46f6-b303-d298883=
71fb0@bonslack.org
> ---
>   linux-user/hppa/termbits.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

