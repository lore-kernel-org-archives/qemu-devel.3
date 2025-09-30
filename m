Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2360CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VcU-0008LY-N7; Tue, 30 Sep 2025 04:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v3VcQ-0008Ks-DZ; Tue, 30 Sep 2025 04:21:56 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v3Vbs-0000ZU-Fn; Tue, 30 Sep 2025 04:21:54 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cbWGv70cNz5xGp;
 Tue, 30 Sep 2025 08:21:11 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 10:21:11 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0042842693f-52d8-497d-bfb5-f13445a95ff8,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3c61d5e6-e571-40a1-a770-7e9d2f53a189@kaod.org>
Date: Tue, 30 Sep 2025 10:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] aspeed: Add support for the g220a-bmc board
To: Lei Yu <yulei.sh@bytedance.com>
CC: Joel Stanley <joel@jms.id.au>, <f4bug@amsat.org>, Andrew Jeffery
 <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
References: <20201025131435.144-1-wangzhiqiang.bj@bytedance.com>
 <20201025131435.144-2-wangzhiqiang.bj@bytedance.com>
 <a3e42923-d81a-40c2-8b17-28d6264d5518@kaod.org>
 <CAGm54UE3D_gd8=iDMkF+nPUqZN5-Mhp-46HONi3Ok6oEkdyDwA@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAGm54UE3D_gd8=iDMkF+nPUqZN5-Mhp-46HONi3Ok6oEkdyDwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 74f355fb-5371-4ae2-81ff-81e41641aa00
X-Ovh-Tracer-Id: 10589933051308575593
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEb+59aVXm+xTCRNPDkeC5Vc4pHTbJSw1UdlBSUppB/wjFsgHAvJLzfZHr102KY08rYr6e2fF2YjJhHkrw+vkKpWHKqyDA3ptpXY0ZvJ7131zNM2BYfHO/ZYjKDi8D+ILA6EBa7rCmmSxpLSPqNoimjf9l3ceU0HO7Be5THbXsSmgNF6x1Ic/+S6K/btntpnZiS7Z5os8OPKD8v6e2/WCkITUXSiGYEC+EiJwPg/jeQp/M+XjtQKt1xfMLoPutdrGbiVpmugG6MLDJaFU1zlG36OT8uWlp4u+G6MORI6wMlbn26/qcvwSGFb9BKTYlpfP+qzZOhm7U5oAlyi926JyhyWCbZ2n2UiySF5ieZWasPh8G9aWqBP+xrz0ELUw6gxYN140aaDne+4U/ffielFrleyJ0YwGplU1x9PN5oAKqZkGI8FowXDO1HrW36+6URWIgK6yRVjzRAnBkTHmbhF77W95XdGd4As+qFeLKTlTKK+xcGk86y6IIxF2A7EEW0r9OjAn1GIgqv+qsDmQxz5OVrbQvKacscR4NUrGSIppYomMqi95JzxQstHQq91zy+sfDy0tj3yV4oJgyKfinTWm8NeRdxwTMdXZ0c+JvJvP++8Joh7IRIz+dZkO2EiYhDDUQUXJBTVG6urkO9ixIpvHQrkBpx+rjVJ5eoeGh+IROShQ
DKIM-Signature: a=rsa-sha256; bh=igPEfX3D64iFbnFeJT/tMDQY7qNPi6idlwWif8oBoSE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759220473; v=1;
 b=PD22tFcjYrll6p3SEsPxhDOxlJ/70rWhqt8TeQlwmDJ6RiGX3t0ZzWTPviRxniEdbtOMHJdS
 OKeUgOThCCeu7m/mr31RTrAg7I8fF2LAvfX9eoGiLMnkGenj63ez6eL+s2jKmh8UCmgwQJbi5yO
 ZZ1OFPWj1/jCV7TGo6MFabYNrArpggsuA6kvIE2MDtqc8EVJGLd0Z17U4sAPnVUACNS9lSa4It2
 DbSlR3QGo4KCN9pDdYzt5xbhRf4W7J7jZwajwKhnHCvKT5iWkTWy4dLrez3EQEnfREsngtYjx9e
 4+fnZW2FeO5CdjCdwloVnftYqSGNvE5XLgzykAz7tKTtA==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hello,

On 9/30/25 10:13, Lei Yu wrote:
> On Tue, Sep 30, 2025 at 1:57 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 10/25/20 14:14, John Wang wrote:
>>> G220A is a 2 socket x86 motherboard supported by OpenBMC.
>>> Strapping configuration was obtained from hardware.
>>>
>>> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>
>> Hello John
>>
>> Would it be possible to contribute a functional test for this
>> machine ?
>>
>> Since this machine contributes little to the Aspeed models,
>> its value lies in the firmware it can run to exercise the
>> models. Without functional tests, I plan to schedule the
>> removal in the QEMU 10.2 cycle.
>>
> 
> This model is used in the QEMU CI for g220a in our internal CI.

Good to know !

> May I ask what exactly are expected to do "to contribute a functional test"?

It's a small python test downloading a FW image and booting
the machine, possibly also testing that expected services are
up and running, network, I2C devices, etc. This last part is
optional.

See the test_aspeed_*.py files under :

   https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional/arm?ref_type=heads

test_aspeed_bletchley.py is minimum
test_aspeed_ast2600.py is complex

Thanks,

C.



