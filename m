Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5129CF6ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnBw-0007Iy-R0; Thu, 08 Jan 2026 05:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vdnBv-0007ID-65
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:24:31 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vdnBr-00027L-T4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:24:30 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.159])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dn1Gt6dqBz5vqP;
 Thu,  8 Jan 2026 10:24:22 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 8 Jan
 2026 11:24:21 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0027da31559-35ac-4fcd-8d66-2eb9b74e98d0,
 149C89F7FC287B932C0337C7351631586067857D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
Date: Thu, 8 Jan 2026 11:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
 <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
 <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: b97eb05a-5209-45f6-a12e-347277b838f8
X-Ovh-Tracer-Id: 9643895654039915509
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEIZ7KaFB4bLIPpihfZ03QTYxGuPB/VcbybNWEb0k7vs5DMxZE5AA8HT+YuCeCE3H1Rdvs0M9KUjdp4jLNmWGZwqFOgAUm6pK7hq8QQtbAEHubyNUiDXq+kICNHP539Mhde0+lMVwvd/DpvnmknSNbKK+uwtwd4jEOjgQvBQ2etzEaaLR203iau2KtjGO4vgvtNIvnZoJJ2QId40cGlSOWKGi6pSi8f2lT2cM/E6DqhT7gHIryN/ETylWngdCuAaezsSbpbaxBO6ncHgR6w/2YUSEor4b8rEEvCwDPXzbt/UG8r0fG5E7Md5a6N7zi/z+w4IYQeDWNX9lcyRlQbay3TKP+K8ypFhOCyLUuHhvrT4xPn/Igu1Em1/miN7Kxy4Od9z2XhE1hp8NAFFqCZJYNROKHWYA8vvzP0AxZ4bKFc6i07aQDw0MDy/cXoczZB4lyZS9zJC/3IE3QvmH0t/IEBx3XqlGT/W5NaV5HPxVBJ7eM9DLqwFsHV5w5uUKXJVvRXA3dfQbyzs6DQEWrsvi5smpfANerJJT54dX3U5o2ydWJ+5SvSG0z+eH1YnsfaJ9HaSlxAU+wJiGItBzDjK+iRaaQoAcM8lknqlwMK9cKONVsttPdQ16jQWg3e1UFtl9OZ+sdkr+q8HyMV2oc/GhIjMorBALsGw10mSgd2wGYQnw
DKIM-Signature: a=rsa-sha256; bh=E6F+QTIjepG/DbnH3kyuSWJpmWLzJurUZYAOPTEQRJo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767867864; v=1;
 b=D23MQiuBmcUqIr3NhNQ0pIh5OldBVIt/kaExXa46PaSXE8F2Ei7533Wa/VJU2MW+vVYBU4nE
 RCKiML7LivTG9U5aVIJGqTnsuH1IbkUF+mk6HzWDexQY49GFt0UzJa3RZ7k9hCYVJKC/5uNktGv
 gY/O+AxwSMWqGJOhhSMrhK2JoiMiQx0ATztr44lHRCExVhqSde59Fz0A/WIrIjIOErjWnrefE/2
 J59XsTRXSfyeIvdx20zsDn7f8pPCzIKT+tVuNrCMaCFTZcglGhkMF7Zh2k6gyKF+NicyCrAaxfP
 7JmjaeyGdYywRTIckNJ3ZWrGIcJleSp9nTOy9pcS/37wA==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
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

Hi Kane,

> Thanks for your suggestions. I have refactored the bus naming logic to align with
> your comments. The decision making for the bus name has been moved up to the
> SoC level, and the redundant "aspeed" prefix has been removed.
> 
> Here is a summary of the changes:
> 1. Added a bus-label property to AspeedAST1700SoCState. This allows the top-level
>    SoC (e.g., AST2700) to define the label during its initialization or realize phase.
> 2. The bus-label is passed from aspeed_ast1700_realize to the I2C controller
>    (AspeedI2CState).
> 3. In aspeed_i2c_realize, the controller generates unique names using the bus-label.
>    These names are passed to the AspeedI2CBus through a new bus-name property
>    during the initialization of the buses.
> 
> With these changes, the new object hierarchies and bus names are as follows:
> BMC: /i2c/bus[0]/aspeed.i2c.bus.0
> IOEXP0 (LTPI0): /ioexp[0]/ioexp-i2c[0]/bus[0]/ioexp0.0
> IOEXP1 (LTPI1): /ioexp[1]/ioexp-i2c[0]/bus[0]/ioexp1.0

The names in the object hierarchy should not have changed, only
the bus names exposed to the user are impacted.

> I have also verified that this naming convention does not require changes to existing
> test scripts, and all functional tests passed successfully.
> 
> If you have no further concerns regarding this approach, I will submit the updated patch
> series.

Please separate the bus-label change from the rest. I am expecting
a functional test case too, maybe we should update the sdk version
to v10.00 first ?

Thanks,

C.



