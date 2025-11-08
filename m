Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F07CCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 07:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHdV8-0001AU-OU; Sat, 08 Nov 2025 02:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHdV5-0001A4-N9
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 02:36:44 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHdV2-0000Ui-LB
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 02:36:43 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.106])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d3SRS2Q4Tz5x3y;
 Sat,  8 Nov 2025 07:36:36 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Sat, 8 Nov
 2025 08:36:35 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002755191ae-5907-4d5f-98c4-418b9c2fb3fb,
 E0A8580B6113EA10CBA0CB14685D14F0C86E4A22) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <db898f19-da96-4ef1-97ef-b8226a8b4065@kaod.org>
Date: Sat, 8 Nov 2025 08:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
To: Nabih Estefan <nabihestefan@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
References: <20251104233742.2147367-1-nabihestefan@google.com>
 <TYPPR06MB820663370307D783EA2AF733FCC5A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SEZPR06MB76199F82F5B0D106C85E3080F7C5A@SEZPR06MB7619.apcprd06.prod.outlook.com>
 <CA+QoejVLkP6g43PJYpJacqVcNB+VRkQwSa3HYQbA1zJxT1d9Cw@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CA+QoejVLkP6g43PJYpJacqVcNB+VRkQwSa3HYQbA1zJxT1d9Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: a0b7522c-2dc9-4a34-a903-d9eab9013fb1
X-Ovh-Tracer-Id: 17511121253335272300
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFz5ELqS5f2AjbWrfxs0JO+28fqLI011BQ8cNIgq9IAU1r5XQ3ZR2yan1wYc4VSRayjzHL0keYkElXx3sbns4rC0Gd0QRXtfrsMP2JyrKdm/vhCg6ASN3jSLGZkua/eUmvyrvILGenk3wjD4sGiypdZyyG4LdujttfFuGYmKQLZOQ8Vn04uYSf7l2+RW5pCXETN5MGggH+vS9doY573I4myigpbWKFjJgiUdEmRCEBvJkb7cA0iYwe2RrWCMRJTitX5bdV1RmjI36E0IUUWpr+DIOoPx93hzvs8DEYug3MHF8mkkCEw+vsN2LEXgktmo6dAmrveNsZvovdM2caRUrq1IQU1lxJjaFs0jYBocG03ne8/rm0wY2T4N0OdrMXThFH5GYt/5Ajked3O8zGxBejDNWnqYXz+tiq2j0xI3Z2ADs8/7ahuGagLVHIfAGqEp6OAuzwUFFx72HH6pYZXI6WGWhAPZqxWkUj6iB+idkGIEd12TpWRwJ0oQc0ZFWlRcDIi6Mfb/4flLL+tWrm5KVp56r/gDGge1NhLOd4uk5YC+pfUxHLdVa8vuO7NSCjykfypbpcLrorZMzQ9Vt+yApbyFV7h12PyYT6OwHjqtFijHLzygv929UfLnl+XY8V/316uglaj3YIh5LjGipopibEQiDRNLpFyLQnVizzJffHKGg
DKIM-Signature: a=rsa-sha256; bh=FNBKG0xYJbbkIZ5UwvLYJNNU1u43nTfxsaaPjl2qmqo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762587396; v=1;
 b=qI5Q8N+jrdI+9o6ggl9UL4R1LdfEnpw7TzwTAKpr3zWSCSGUjR5mtSMf8ercrVNJ8JJv2nhJ
 ILaTOk7yslgCbzTJU03Eq90ECF8uYMXPPxuoiP9PrFqUv5xpSmcZXqUN1mxMJKaSUeUq33iWFZI
 BCmGI0Oto+YhCaqnzMNN8T0kJxmnaFqzbWKUqbt8T1JI7/EvRbuWlhRuzopM7SEk/aBBnBaPgEL
 m0IenveKRWCBU+bPm0qBTGDaZN54owE7aYQSXiA8h3kv3JfT0o0fAebCbFozGfJmwbPTEXR2+ZI
 1kv4rlQH1zH8IlYmSFIMREWYKnJ74PvPkz4V9vNnP9dxg==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/7/25 19:28, Nabih Estefan wrote:
> Given that 10.2 is closed for features, 

We are in the soft freeze period :

   https://wiki.qemu.org/Planning/10.2

Features are still possible if reviewed. None on the Aspeed side.

> but not for bug fixes: should we try and land this in 10.1, 

Yes. That would be the plan. There are a few other patches Jamin sent
that could be candidates too.

   https://lore.kernel.org/qemu-devel/20251106084925.1253704-1-jamin_lin@aspeedtech.com/

> and get the LTPI patches in for 11.0?

LTPI and AST1060 SoC and EVB support are for QEMU 11.0

Thanks,

C.


