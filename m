Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25634EB597C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5ef-0004pu-VT; Wed, 11 Feb 2026 03:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq5ee-0004pa-Re
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 03:33:00 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq5ec-0002Nk-AK
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 03:33:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.73])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f9sBR0NWZz5vyk;
 Wed, 11 Feb 2026 08:32:47 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 09:32:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002c13e72d4-da62-4325-b3ac-350552b3dc81,
 3A8D629C33260B61B1BB8F65C34560168E726884) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d56d900f-d9cd-4c6f-ac44-a0cb0e6e6b13@kaod.org>
Date: Wed, 11 Feb 2026 09:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Kane Chen
 <kane_chen@aspeedtech.com>
References: <20260209065044.239378-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260209065044.239378-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG13EX1.mxp5.local (172.16.2.131) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 5c4e0a10-4a7f-451d-a12b-02a9337393fc
X-Ovh-Tracer-Id: 4516547480309697525
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGJePbD+Qym0b6GLqPhKzngwoS1MoycbGisGGOTca1+f7Jk5Rj+arP6O9Xy1TFjwbcXqlb2tPdKD7Sx7i21YsssAQ0B5mXetYAvBap1/VQPfUMTX17NyuTauxO5EkH3zMVYlU33EDWw0Cf2PnZCVbxpAwVA+i5I3DDu5hMj3K4W9f7SX8RMNBX4shG2sxls0UCFu4Nocs8398CO44fqLBh0QAxO+ESJhYNJkll/7vrfmYq9ykmZAzwSW0v1eIJu7PKjrN1UtF8NizAIniht2X/vrfopmDlBnn68a2wP2ILTRI5Tl/EK0DIs3Wk6GaRcYn5ey4fvkHuo7f9rF96W6AHzRPjbOaEZ+BZv70wUhbUuQfDtHQVj94jhdcCnl0VAP47VgRl4lo0r7Mj0mALFv1i0qWTNA31jsLhQlZkb/R0gIZ/r7FyujqYuw9azPd0i+1D3RnYv4Awf4cXQjLdsgD1eX3uRTkK8OMv98wGLmJxqk9fGJT9F5OkcAnjFaE3aZA6P7Irq2voOClhko2SnZBzkXX8mEZI5HmLHQhB48a4tIJOi/zwp9O3q5l7AupevTEjnITWpE4ATNKNQ2SFQg7YouHxThC/cgzo8WLs8SY8KEuVQbXxerb3bBD7j1gPnptkl6/T5apuHceKR/AdmlE12LDcPYIuBWnu/KkESz7E7YQ
DKIM-Signature: a=rsa-sha256; bh=6afOnp9fxSd3vFuIrUaQhuyik0iz5fd31XJcKz0KmSs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770798768; v=1;
 b=mZ+2QpGyx0wMKVlttECDNONyd9bNmQxSPeIDrn1cInYi9Ggwr2acFNiBF7eJis3ZuDL194By
 ufwplMWXJiGYz41KkKOBexIFzDIySQcwSqb2KQxY0WqdWSYm8PEv9P4LGCsda49dndiDAxceCS5
 3i0KjIttwGfCiS/KrFSHIF9K9CCR1tqzYllrf0SH9Ol65xbalJaNtg3wfbeEZrtOuidndCjDxR5
 MqU7REVFiPVDZSb5WDcC+09bxgqUfkHw/XlubqBgrRHgYoL2a7IFpIekW39tlgcGOCC+YOgxbxL
 ec2k3vQQbdkygSBRiEhb5wO4enN8r6YzK2gMCoS6EndEw==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Jamin, Kane,

Could you please review this series ?

Thanks,

C.



On 2/9/26 07:50, Cédric Le Goater wrote:
> Hi,
> 
> This allows the functional test suite to run tests in parallel more
> effectively and adds a new set of tests using the older Linux 5.15
> kernel.
> 
> Thanks,
> 
> C.
> 
> Cédric Le Goater (2):
>    tests/functional: Split Aspeed ARM tests into separate files
>    tests/functional: Add SDK tests with Linux 5.15
> 
>   tests/functional/arm/meson.build              | 18 ++++--
>   tests/functional/arm/test_aspeed_ast1060.py   |  0
>   ...00.py => test_aspeed_ast2500_buildroot.py} | 14 -----
>   .../functional/arm/test_aspeed_ast2500_sdk.py | 29 +++++++++
>   .../arm/test_aspeed_ast2500_sdk_515.py        | 29 +++++++++
>   .../arm/test_aspeed_ast2600_buildroot.py      | 41 +------------
>   .../arm/test_aspeed_ast2600_buildroot_tpm.py  | 60 +++++++++++++++++++
>   .../functional/arm/test_aspeed_ast2600_sdk.py | 15 -----
>   .../arm/test_aspeed_ast2600_sdk_515.py        | 29 +++++++++
>   .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++
>   10 files changed, 196 insertions(+), 73 deletions(-)
>   mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
>   rename tests/functional/arm/{test_aspeed_ast2500.py => test_aspeed_ast2500_buildroot.py} (74%)
>   create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
>   create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk_515.py
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_515.py
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> 


