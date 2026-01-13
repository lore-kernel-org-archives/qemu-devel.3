Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00327D2D0F9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfeFh-0003h1-Cb; Tue, 13 Jan 2026 08:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vfeFc-0003gC-Uo
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:16:00 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vfeFa-0003Ff-GC
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:16:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.110])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dr8rL5Jbyz5vpG;
 Tue, 13 Jan 2026 13:15:46 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 13 Jan
 2026 14:15:46 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0048cc2fa0c-96f1-49d1-80ce-bcda955ad104,
 CD8D63582BF20F4415B5621A262754E3DD632153) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1c0e0499-97a7-4b3a-a116-a7c781d23a5b@kaod.org>
Date: Tue, 13 Jan 2026 14:15:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: migrate aspeed_rainier image
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20260113115138.3171479-1-alex.bennee@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260113115138.3171479-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: e7bb7692-5c5d-435d-98b3-1ecbe5ef5179
X-Ovh-Tracer-Id: 5008565736743865135
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTExtmyqRdo56gfQKtLtX/X7VBf+2lsalS43v0gaF3G0fbrkfuhzCilOgnaecIgZ4NnA92AmBdYuddTEAFKS6EfVrrBVViGHqMG/PZy/uJaex85ZX4d48jMbDzHrohHNm2EDdy4ZFoo6pnE8c7kNk7Kp8+Nu2oeaJnjk1SiCDD0Rycl8aq+wmzFUneGVai7yayHrjy/CC1UrOKogaqmYz4EKXbW0ovQwiYa9AidLlswLkIX/QBgNcWnHV2ZdfxmFevjvlXh9FsOUo0zA/FG1TtC7u3/3kEmUAg5Hm33h0KoekIt/yXS9mp6lSnR5rgp+1NTNrixkwfPUJZA8tZfYUvtnpzuc8w2Up7XQl0Qqrunnlo2a6TKXQ6845C5W6/VYXbKIogHZPSFBW0rjeYWmYadXFUwQMStqkZ8hnc9UFOfqJxvQwjHUGIzA6WsagFozS24lX+Z7c+XsJyLJJyLVsQz8cnGOnIT85yMnqVsjtnGEjYFyv65XdQsTHJGlstAsTZ2M4TGYDtvACLm51e0F8U8VlsevDQ1QEuF14/1YPiU9m8U8rvZpOn5nPQJACOcmcPrKzoa+o4VYsR+iAQssR9l0zoCJecSYnrNUCR0spIIfrh91dl8HsOuQ1dmXWduTNc+VaGGFtjSN1xTXMevh72F1dYG3H5Q54CtYWRhrx20PVw
DKIM-Signature: a=rsa-sha256; bh=vTNTDpe52ZfV+nrxlOK2dFCFa26v7FrUCYk2+IY8mLk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768310148; v=1;
 b=bS8H6n/kNsJE8bq0NcdVcPoXjeTq4ztMr2fU4uveiamJzopcd5jYcBOlSyopvkopO1+3cNp5
 qqsycqGU70uMrMJnNQc+4O8YlnWc3+d55k5XoNwcvKXTvOIsiIupmnt8leZOkXkyqWtel08OIM7
 LdQo+B2IvtjHpGnXE5qb/RXJ6Y29Ew5R8OqxR4g7fmg7kgvClCjGq18wd9NiphoG2NIG5TkqqGx
 5OKuTzaYZpPedyYiwW4CScBt9seebkjkSLrlWzpSncm++1hrGyykOfZHrMVmlMN+7q3ar/B/lyH
 yeRHNn6xe0/+UvSrSXY5Y4B7TmwK0nR6FdIOeGoOADnTQ==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/13/26 12:51, Alex Bennée wrote:
> fileserver.linaro.org is going away, migrate to the new share server.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/arm/test_aspeed_rainier.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_rainier.py b/tests/functional/arm/test_aspeed_rainier.py
> index 602d6194ac8..025e5751dc7 100755
> --- a/tests/functional/arm/test_aspeed_rainier.py
> +++ b/tests/functional/arm/test_aspeed_rainier.py
> @@ -9,10 +9,8 @@
>   
>   class RainierMachine(AspeedTest):
>   
> -    ASSET_RAINIER_EMMC = Asset(
> -        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
> -         'mmc-p10bmc-20240617.qcow2'),
> -        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
> +    ASSET_RAINIER_EMMC = Asset('https://share.linaro.org/downloadFile?id=PaCHfyerwpSr0CV',
> +                               'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
>   
>       def test_arm_aspeed_emmc_boot(self):
>           self.set_machine('rainier-bmc')

An alternate location is :

   https://kaod.org/qemu/aspeed/rainier/mmc-p10bmc-20240617.qcow2

It is backed by OVH in Europe.

Thanks,

C.

