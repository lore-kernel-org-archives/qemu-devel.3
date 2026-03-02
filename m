Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F46EB3637
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxB0t-0004vB-St; Mon, 02 Mar 2026 16:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vxB0r-0004uG-GI; Mon, 02 Mar 2026 16:41:14 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vxB0o-0006Cw-GZ; Mon, 02 Mar 2026 16:41:13 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.53])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4fPsn75FRKz5vpd;
 Mon,  2 Mar 2026 21:40:59 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 22:40:58 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0057e4016d2-1971-4de7-9c03-06f8e185834f,
 6520E4CE77CE7CD2B48A5FA96F3F74AB8B9EF5F9) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <748b06c1-b106-4e69-8cc1-bf315c73b664@kaod.org>
Date: Mon, 2 Mar 2026 22:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: Jamin Lin <jamin_lin@aspeedtech.com>, Joel Bueno
 <buenocalvachejoel@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:Block
 layer core" <qemu-block@nongnu.org>, Marcin Krzeminski
 <marcin.krzeminski@nokia.com>
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
 <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
 <b780d16f-82ba-43e2-b189-ba70594c7d7a@redhat.com>
 <CAPDLHD6ecMFX-Ls0inPM6kDrWXAKLiqf+jLXbUiFDgVGjBCruA@mail.gmail.com>
 <928e51e5-3111-46fd-88b3-c1a1e82666c5@kaod.org>
 <TYPPR06MB8206F1C6DAE37D32D4024207FC7EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206F1C6DAE37D32D4024207FC7EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG15EX1.mxp5.local (172.16.2.151) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: cafc059d-00c8-4057-b5b1-89c2cb4fe14f
X-Ovh-Tracer-Id: 282319404775541682
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEObwjTSUtx9HjgbPdW0IRydpsm9jyzMGVkKwZI82pgHwXoIlZu9rdZGpeEeP7LcaS76K4X+UcOFs8FSvbAkATi2oaJWo5gfQduTxcOJp8WpqiNy7Wg1ugQVJCL4Cv1D88RveRUb6cMqyA058LiNOA9leqtC3bbvM20rp8kvfApMPFMPG7nBVS7NeKuX9GIJqW8bQgviKeIEdHO6Cg4u+lypx29Prss9PUzFk0FsZoli6pNVMBwzbqpy3a3n+kXsHcNgfYVd+Rb+/ijX6iXIMZh4KyVjvBUVG+iaoXzJ47JsoB2wzB1PAIU/uG6sLi1Ce+AYvKG19w1bHpplQPsDQUzj/94MZI/zcXwTCq7DZ8WLJEYETUuXJSQKj0ysyAsUR2Ub2nsK1XK/amTOxkpr3xRPigCAx9oY2zVykczuFIK4CJJj3xwagyM6kUkEtn3vOewcpA9u4XXQwf5+Vg8f58waYZ113lYSYDESb8lvemd3Re5EPSpEYCQZJBNdaX8f5moWm4xMFxRWjMuEfJ3dIjaQhcLLe4o4v8KnS/WqxoAfqcOF8RGKi6KwnYre0ZNrYZclx/lf3bX+GaqzHonfZubYYE1kF0xiUV3ZnVYfgYJnTxIYqzmJ7ugmgHgzOp63DbGmdjRU1QPlT12nQsY+sDT5bpc4L2p6Tn1xTUxxK+xsw
DKIM-Signature: a=rsa-sha256; bh=2kfyA6hkS3YXKGV9THsPFs8sJMeadAihjMgAyexjc04=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772487660; v=1;
 b=ANRSLebwt909+Q04q1zvwQDSSQcxzYK6dZvNJXESfsVIJ9Q5aJ0c4moY/AiJfWMQ1euLbOuC
 kSAJzhMbZFNpWxreH8zVKtcgviNoQxWEJWjBZEP+OqbfQ3CV2yVwP5vNIeEBcpOQCbXYLooGFEN
 C31ijQwaxVwGUkhgN8iC+15zUEfykGseSz7zEJpqp7e7b0P9Po2TILvry4kvFqO03pa1tfuFg2C
 3h1AMCpKnBowbAWS9Mzf+iSq8yIqEnmq34CLjTd/C2WmDjoFifa6R7BN63s0raV837hZoIstpuI
 s0l7bQAF8iz9LOZ/wPrZBkABMMoeqgbdZtygPrQj4iOqQ==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/26 02:14, Jamin Lin wrote:
> Hi Cédric,
> 
>> Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
>>
>> Hello Joel,
>>
>> + Jamin, who spent time on aspeed_smc and m25p80 models.
>>
> 
> We currently do not have a dedicated owner for any specific model.
> I’m willing to help analyze the issue once a bug report has been created.
> At the moment, I am focusing on the following high-priority tasks:
> 
> 1. Updating the functional tests to ASPEED SDK v11.01
> 2. Implementing 64-bit support for the platform USB EHCI model to enable AST2700 support.

yes. Thanks for doing so.

I don't have time to work on it either. That's why I asked Joel
to open an issue on gitlab with all the necessary information,
so that we don't forget about it.

Cheers,

C.

