Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DE4EDA68D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSna-0002nk-QO; Tue, 03 Mar 2026 11:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vxSnZ-0002nL-GI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:40:41 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vxSnS-0005pn-Mh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:40:40 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.239])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4fQM3s5y5lz5wC5;
 Tue,  3 Mar 2026 16:40:25 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 3 Mar
 2026 17:40:25 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004e905d217-c8a2-4265-a199-da2aa9cd3de5,
 98E95E7FEDB3EB848AAA79F7F8576E65DBD0C5BF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <1d36cebc-51fb-48b0-a2de-6c19ec74d046@kaod.org>
Date: Tue, 3 Mar 2026 17:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Update test ASPEED OpenBMC SDK v11.01
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG11EX1.mxp5.local (172.16.2.111) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: f0acb06d-415a-41a1-9905-729a7258a064
X-Ovh-Tracer-Id: 1078893588667272114
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG1l9M/jNgo6YYDJtmB906eX+DYBP3lnCkwOh/Jt4DMizuEtbkvbbUj7UDuD9lpgA2Il/mdUhAwzFM8chjv9XCnr/1zePyR7OsJ36LuCpsc2hjS4NkEBX1CagmfQy3OhWP+tE5p19uDTlMI4Sdud0V5D+dqwkFECMpoaWorjMczBHhMGtVsexUPFarObsF+i1mQbj6F7q6g033qMUFk8OiAeH5SqfEI4CgavT4cC15RoM58UMuYZsbysHJTUbbf319mJC2Naqi5xjA1wyNIJAQLxNo456FdotgHQ5aYz+RW0xUNHa23Vg+oTkljrhrUFOop6iI/thDPzvkshjRK3+GnaChGQwSrTx3z6RVaykP5ICmXFQKzG0Ke6srfITfR239dsE4bFXDowbB67mPeSezzxjIZWO8sGNtXMgVh0deed93YFh39ztUz7f8cQg+A0NzPC77HdWvxia0/2k5llBmcjhoYLh+RqtQ8YG4X4zAkbFE+wDOMW7LBY17yxKGSP/o1S2B+L/h2Ve24QgvB1ySE9pyc6pm78aaIKDs/PMyM+NWilyaBDm8kmn0fa88mYUI3LRym6eFDaVbvd9w0fmrw03wtrUUC3FHHeINR0CWNeSGSNpjTUpt/8V7g6ILDAwQp64TWYiTUvQVuyntBGzRhtIXVhEBL6dyOk9XQYAHRJg
DKIM-Signature: a=rsa-sha256; bh=COC4/E+SQuWy/msSS/L3EC7Fj1qfliuSv6EGnPYcHvw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772556027; v=1;
 b=ZpRvEilYLvYu4pdNPolgjKLOFIDhCdw1cQTn3xrYXwfaYg3XXBUUDa+W51mnab+8wftHxPtp
 MCF+zee2IUsEg8gjLlUkG5sJ+xb7OhBCzeqR7y8lcqiIPuzGnsMZGsUhaTbT+n2O9Adv72xgjS/
 oLgxg0RewvjWWx00FpXD33BdUR73FHA9+iNfQEsPAHh2dZAp8ypd2k37JhxRTxkEUIdth3n/N5P
 N+xt5holNKCoG9ZIr5qBEbYSdSMD83cjSNzA+XgcSvo95eG3ggg/yYVM0/cD+BQ4lOvHkVhdVE5
 nc/ZqT7v8mPfqMnUHJ/8WVYs/Y+PzzX3XKVALgm9y2drw==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

On 3/3/26 07:39, Jamin Lin wrote:
> v1
>   1. Update test ASPEED OpenBMC SDK v11.01 for AST2500, AST2600 and AST2700
>   2. Update test ASPEED Zephyr SDK v03.06 for AST1030
>   3. Update test aspeed-zephyr-project v03.05 for AST1060
>   
> v2
>   1. Update sha256sum of ast2700-dcscm-image.tar.gz
>   2. Update sha256sum of ast2700-a1-dcscm-image.tar.gz
> 
> Jamin Lin (10):
>    tests/functional/arm/test_aspeed_ast1030: Update test ASPEED Zephyr
>      SDK v03.06
>    tests/functional/arm/test_aspeed_ast1060: Update test
>      aspeed-zephyr-project v03.05
>    tests/functional/arm/test_aspeed_ast2500_sdk: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/arm/test_aspeed_ast2600_sdk: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/aarch64/test_aspeed_ast2700a1: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/aarch64/test_aspeed_ast2700a2: Update test ASPEED
>      OpenBMC SDK v11.01
>    tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED
>      OpenBMC SDK v11.01
> 
>   .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------
>   .../aarch64/test_aspeed_ast2700a2.py          | 30 +++++++++----------
>   .../aarch64/test_aspeed_ast2700fc.py          | 18 +++++------
>   tests/functional/arm/test_aspeed_ast1030.py   | 12 ++++----
>   tests/functional/arm/test_aspeed_ast1060.py   | 14 ++++-----
>   .../functional/arm/test_aspeed_ast2500_sdk.py |  8 ++---
>   .../arm/test_aspeed_ast2500_sdk_515.py        |  8 ++---
>   .../functional/arm/test_aspeed_ast2600_sdk.py | 10 +++----
>   .../arm/test_aspeed_ast2600_sdk_515.py        | 10 +++----
>   .../arm/test_aspeed_ast2600_sdk_otp.py        | 10 +++----
>   10 files changed, 75 insertions(+), 75 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



