Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961B7CD98F6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZujS-0000Ri-0P; Wed, 17 Jun 2026 14:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZujQ-0000L7-JG
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:11:20 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZujP-0005Y4-1q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781719876; x=1782324676; i=deller@gmx.de;
 bh=mbdkEWCUGUYeewxN78pQfTIbeiMjJ6RRrpj66BlQvzk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=szX5gI32MLJW5XTQhmcnEdxG97v1fV1ILn/1sc60deLKF3J71DXsneMKRjVu+yc8
 Q5vR8dPI0oO6AKaqRM0EfNSllc1DgNCXCnM/wVF00K3aEwOZOrggz8Lb77yToaN6n
 TuJwGuPo+jk5lTicPQuIccENMUkUrUGE6V+vnQOu1J1GPVquQGosIopSdE0VI6TAl
 Qo/RWNwPN0M96G0AZyfxOq1/+9NTnHq1OCgyT4OGzkfHDGzCwnodv32sIKtKjVsX2
 3jnoUK+Klx1kATVlCWI1LzHn6f6gZMd5FqbEkXPq206b9NopvFlvF5cA4tObwC7yi
 mj60A1g2+lX2Wep0Xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1wO4m130gX-006YhT; Wed, 17
 Jun 2026 20:11:16 +0200
Message-ID: <e6a053a0-6fe1-4de4-b956-2da0ea521063@gmx.de>
Date: Wed, 17 Jun 2026 20:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] common-user: Implement read_self_maps for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-11-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260616212055.334466-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eQ4ynPIL5dUSqqNVo5e1/J4XBXjaQ834u06JhdVY9j6b+rMYwGS
 5cGgKkQZM5QKSV50/WY14w5w7OrHMm3XwaI/a2yOcHlsPdGBaJKMiGwLg6EHShJ4du9VaJ2
 Ql6Y+II67wV9Y22KRO2DY59rj7TqbzXSpQzMLix6CMOdkDimHNOjh3BylCge8HlycNykhV9
 rnb+fqjXYpOLJAy4zIQEw==
UI-OutboundReport: notjunk:1;M01:P0:nNncuusbFKQ=;Damwyn0l/qBXwI/OA+RTc2yf2jV
 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
 RymHcGr+g2bXqjTI3gVpMQYPX7g=
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
> Use kinfo_getvmmap from -luser.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de


