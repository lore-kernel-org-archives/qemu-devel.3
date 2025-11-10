Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF49CCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 04:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIJsO-00010x-GV; Sun, 09 Nov 2025 23:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIJpM-0007PS-DR
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 23:48:28 -0500
Received: from mail-francesouthazon11011049.outbound.protection.outlook.com
 ([40.107.130.49] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIJpK-0000bQ-Cz
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 23:48:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3wqzKRe/sohgHlZHxjC2coKB10npH5Gz4AY2nCbFuVKRF5TBwO7Vyh+xda08P4HsovndnlBJeukCLSmZmpdptzi6XoGydTS4/LCK01ZNZn6ReaM8zcE1qZKDJAf2qyBKtjYujQxMUCn1nqf3/BLKv0dPqTvaK8uP8VESxeaU37BHgIZTOXIY2b/tpHJKatKYlxOHW2wzGRAIrkJuwrfOAoIQG7GjltGcU1XMfH7PJ7W/jl0N1/Wldh1/rYmcSoAywwfFngY5WWRCcClon//dzJbJMOT9enfADUogRSBMWXRvPoKO2GKWvvDXPX5UJpXF5Y3+jF8gp2foNAqy/MiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvCP4gaURuonTs0h2cXmK8giBynUpFv45EB5loC+zzk=;
 b=mm7dak19oCp3eT8E9QZyIiwAnINjH9AHwL2wlFkCaij2tdAguKkgCSVEVnejVVfVBBog11RY5lAdCvKtEjJ4t9/kf8l/sTbIJeVdIOhR5+mAZ2ZA7xoD8s5jUbzAuDWNUQOm33LpNejHseJgE6ZCsESgu7rQOF18Fs+iPnh1+HyXVEqqzZbpZrN716B89IPddC/9DKAG85gKHDHbTgUODtExhkxKG5dpQkG4vy8cRiF+rAiX3HdxzC2+J431v6RSwIR1HjhpweZzO2+WkZwNN/8dJ+Yh9OwaCI+FZC0/RHhSYtCNePVodV/a3tPdH7PFIdkgftTehcl+dVa+2OWfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvCP4gaURuonTs0h2cXmK8giBynUpFv45EB5loC+zzk=;
 b=FoWrXKwykQa5tG8YSWolSZz8l7UWwkoal422NlLRtjnFk/3vAvw4oYk41rHFvVzGJJc8bPpEjXMd/m+MdYP7YjxpQdP6kUu3Sn4JPedpab2hUlir/tl4e7LfrPbrF4J5m/TArFYa0/mSSCvTddIGbuEI9QV/AE+BrFeRa/gP+4CT5auLxiiLh0S8ATpEOKr18X8/D4cqG1GfP3DizGq8X7QT0rs2syk6co5vW9TPz3CFAe6EcLonAiVJHYvXF6bGF0QwBqD5M71FCVlSUU6VhY3s5fk8A1fQT6P01i14C0gmyhaCNWa7p2AkgYOiGla3tn2Tjqma1Aoo7M3v19O12Q==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:43:21 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:43:21 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCH] Add support for the NXP i.MX8MM EVK
 (Evaluation Kit) board
Thread-Index: AdxQqdBqB5QK53glTVSBm5Ki3qf1GgAOL2eAAEZYsTA=
Date: Mon, 10 Nov 2025 04:43:20 +0000
Message-ID: <AM9PR04MB84874C7B2D4410AF0E54A5D387CEA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <AM9PR04MB8487562AFE05FFEF901244E587C0A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA8wF30KdS=hdr1RfpEcgBA5epXgRXrJ=HvtCr=p8__EGQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8wF30KdS=hdr1RfpEcgBA5epXgRXrJ=HvtCr=p8__EGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: peter.maydell@linaro.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|DB8PR04MB7099:EE_
x-ms-office365-filtering-correlation-id: 9bacdb43-84d3-4983-f106-08de2013acdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cprBzlaEXF9NoE9/z/pmZi87A7YxhrZZ8+zSOyvLyewxb0dZ75Ua14MBifEk?=
 =?us-ascii?Q?2UIrIRLTYcViCiIIZS26zSeoH+uFQTq61h3BLqQSjwQPgJO6cuxfI/cNrHpA?=
 =?us-ascii?Q?hlIXgkoWfD5tqeXyKvbAIObVYnbP0iHIL6+tcqAWGQr9IwsvA4pTCORjWyvR?=
 =?us-ascii?Q?1tYZQWAeLs87SxDKmCsDfLik7y3PLX4AMuwG27Zk90XEDPeWGk0yrNq9gTBQ?=
 =?us-ascii?Q?ZR3b1gXfiDTXvwDTQ/Ea/RAuAi/GJWTI+BO0VHgXYNhmnxQD7WHTT4815SsZ?=
 =?us-ascii?Q?sfkypvnmi2xx56x7ufRXmJiRKf6yPGuM76YboviQ5WnbsX9JBFns6MZd8bUL?=
 =?us-ascii?Q?FPGJbSsPCEUBtQ+jUfINR90oVSZIfcGgWh07Wj67UbIYApA1HCjCRAsx17lv?=
 =?us-ascii?Q?mAzjbuoEwg4dtMi3ZVFU8iV8pv4rdgp4VEVwtXGaZPvT1CbB63Ye0YMZrOrX?=
 =?us-ascii?Q?DrKmMTjAdU4azFI6JBfBIVC+HDVqetcweHrWHcUedk+2hGbQEEIdgu6x2Mli?=
 =?us-ascii?Q?7vw9p/XrW6vMQ6ZreDnW6ahDO5RIpWcchBhWIr9wyDtt95La6ZG8nzlPR6Gy?=
 =?us-ascii?Q?8PuFzUwGsIYuI8kiMqgYr/AMD0+ZfoY9ox9FbyFUMrMxjUjnmC6JfJFxapXm?=
 =?us-ascii?Q?b14gB1M6RSV53noWEWlEWUDAX6nvR6NTW5Jbu6vY1UuYXSr8ZujjXyU2n5Fn?=
 =?us-ascii?Q?uF11fZ0dVPAKX+ZvjwG5HKE3lbXvlNCnicAJC9xheqv1dWBBvXitSS8C7Pjl?=
 =?us-ascii?Q?EoYc5JAdYkFaIqRq/FGBx2M4Nh/jru9mSm98DrYQkWqZzZiyxS8bDj6Fzx7E?=
 =?us-ascii?Q?eeLJ/h4s0Acrys1rDIG9HvyOl1+WdhLaOSms+ISNNqhvL8rsJRHax0/2h8bi?=
 =?us-ascii?Q?yzQGSuV+jcRfjVX5R5oI2iq7q7woEwcAhK9vB1xFzuctNHt/LL/B40zT3uOd?=
 =?us-ascii?Q?rA8ewb5Axub3/+YR8yzLlZxgFcS0n4gNc+W4Da8iuZ0oo4SVqveCtOa4iBbU?=
 =?us-ascii?Q?q8lX7n85vCxQzuWoaUeebfBcLST8C1SazJ8MrlRodU3HHdUdJw+/qhiqmv7Y?=
 =?us-ascii?Q?ubON0yqmhkduzxPR8/r6r+wWjfTdbM6BFkSOVby0WwqBSDPvcaZfdjyrnfpk?=
 =?us-ascii?Q?zZ7ZCie9EJos9LtOzYqjDNN9GClkx8vc5LM/0dMLHaUhFZ30xg7kPIhrM2uC?=
 =?us-ascii?Q?M0sEU/YtOARDSYuRG2R6lM0owVt5pNOhCqOSxQGIvDrkzlhd52TNWCtUC1et?=
 =?us-ascii?Q?zXwMAEg/5b9gNUmRfD8qx1lOBHalGtbQvyzJjlRHnSfU11SrCigHQmB8NPlf?=
 =?us-ascii?Q?Jh8Njw7wE5I9AN6Kt6/Csv4HP4xs5DWWZWKbw3YH2V46491I0cNzq1AoTAe3?=
 =?us-ascii?Q?qwBfyCYeL3V0V1yEmPo6qOiKTXazdfElob+3mnHJhxRtvYxXgnDytcRdpwz2?=
 =?us-ascii?Q?x638hYVLw2LZ2AfIQ1J06Wv6bzJkERLkeey4gK541kkdHKrxtytDrmCMiNC9?=
 =?us-ascii?Q?pHbDCP3+dTROUfY8lotn9Bt1ATDyoLxUe5sl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WF+NoV6zhB/S+TCvsqCKlibNkCWkC3fPB5O7L4K4H5uqRSSWHukD1IZFPubv?=
 =?us-ascii?Q?4f4Mr4fnQuiAniU2Wb1a7TKuTsgxQ1W0g+m0a6NS4GV/LoLg4TPV8hKU4DA2?=
 =?us-ascii?Q?Jnuem3i0VB6VODm2YTUtEvu/SeikRU1glhg0TWLtAXUwMH4lTpTRXhKpaXRg?=
 =?us-ascii?Q?ZL6BP+dGDUwv6MfpYzhQmgePyqgssVKRBP+qSusFRDxao7KYY+xqFVBpJfJt?=
 =?us-ascii?Q?HPCLGxRfbKFLBeb+m3tOxveSfD8Zqa7LngVrkV82vQTh+pz3BXtekSSYWM2L?=
 =?us-ascii?Q?Ay0X8d2LqgnJq2dB0wVmvgUJO7LSPkFADNk1KN/UzwE5hFezyMoJCZY5JoZj?=
 =?us-ascii?Q?jAt5UQ3teX56R+WY97b8XblA/9L5CDRz93UAk6yGv7PAgCsOwgw/HLnjanfL?=
 =?us-ascii?Q?uW4GKaXIkpW0unu9G4bv3RkQscM8XTwiOqWWEtleMAfEDxgFaq6jMn9Y9eIa?=
 =?us-ascii?Q?QVZu/rmccb+sVNJSv1hbkMtEBlw+meQkSXTlfbwxmUHSkQHYSwR8fzsWgV27?=
 =?us-ascii?Q?dviCkhBjg/dsJf9nEYI3JyVRrSYM1Sau46kUprK47fOQSSlrqZYX67BcMblY?=
 =?us-ascii?Q?YDl9rIO8JU39L3bY3Ik5MS2+k3HknqbEPwWGLbhNG0qM+InsW8LXuY1icv1Y?=
 =?us-ascii?Q?RFdfEDh34J/dzJ9FP1DmxItDB4khAZSt7/1d/nejSQfn+3JhF2dwXHYtM3Wc?=
 =?us-ascii?Q?gtYlZBSAjPd+wlgSwgXLkPfw9aEjyLgK/qNSoBmIMo0E9maboSS6DL59ITdS?=
 =?us-ascii?Q?iKjVxvERwIwccbhm3oX1Wa1+8akxoez1jpC/O6sRER6kk1kdANY54DiUQw9g?=
 =?us-ascii?Q?Wj8yiDJnelkA6AATZn0h7Sxr6fIWdzU8M3001iZImTNcrn9PYBDfwJDMH7C6?=
 =?us-ascii?Q?M9/bNVoywJUKL69K1HiVTr51MX79t5ENY39Bp4C1BPSVdm2IuxUEqN7u0UlJ?=
 =?us-ascii?Q?fZMR7lhhRF84t6jI0nD5VCbq/BL9a/i7IPLt5RgaTfSf8je/pv5ItFGJYGQz?=
 =?us-ascii?Q?aQtzLYp+USm782hXW027t8lngZGhiNU1+oeQCLBZeq9h5DcqdjB1azH/dtQM?=
 =?us-ascii?Q?eNNukbPaRTU9kTVipQFIfpc03NdSoJaLu0IcdvpAy+Jhxb7qHkv/mZb6xjsj?=
 =?us-ascii?Q?RosgMT5lwyWYrjY/OBoVX0SXGonNPy8OM6DCCsmm3UkhNvRrU/4yOqTKrnDP?=
 =?us-ascii?Q?hWepc5xEsZiLbyCB0vZO6QdkM94YLBVmsK1mz0WRz8BidBi/dyZZ4dbu9//c?=
 =?us-ascii?Q?o5FnIUk+8KbcFgkT8fms3rkE1AHsNP5QobRrLW5A434m65LKNoodhuDcGwNP?=
 =?us-ascii?Q?qo/GeCKs/w+1VRxRq8BnBT2GQCqYKLUBhqZPEkwg2j6ccv0MdWufTUcSxJMP?=
 =?us-ascii?Q?ARkjHGydSd3Cay5V9w8ftLBkBAp/c58U5gsMbJHgnMV8ZVawWvcqTZ3Pg81a?=
 =?us-ascii?Q?Vk7kshe4YZeuKH5QnlIuHYmyN5aTUQFgX83meMMbRIxCnggG/gW0/+4/EiG2?=
 =?us-ascii?Q?bZ7eH20q4XvSW8nr/F6SbqnaJMshxA4EHE0T4JGi6hfDtENz7QbuNaOge1ky?=
 =?us-ascii?Q?q4dA9tOqlUNGBZSf85bqyevDYbJWzK9CVo/r5Snw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bacdb43-84d3-4983-f106-08de2013acdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 04:43:20.9866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rrqNA1MJfyYvJWPT4p8uR255Eh/nygJFdiBPbF3DBFOPKYaG9w4/G4LS2EsBDHu+SygaU3ATt/hI+vaIg3Uqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099
Received-SPF: pass client-ip=40.107.130.49;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Thanks @Peter Maydell for the guidance. I am splitting this patch into a se=
ries of patches. I will soon send it across.
For some reasons, git send-email doesn't seem to work on my official machin=
e due to some smtp restrictions from IT. I am figuring out a workaround wit=
h the IT dept. so that I can use 'git send-email' itself. Otherwise, I migh=
t have to resort to another alternative.

Regards

-----Original Message-----
From: Peter Maydell <peter.maydell@linaro.org>
Sent: 09 November 2025 00:35
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org; pbonzini@redhat.com
Subject: [EXT] Re: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation =
Kit) board

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Sat, 8 Nov 2025 at 12:27, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> From: Gaurav Sharma gaurav.sharma_7@nxp.com
>
> Date: Sat, 8 Nov 2025 17:12:56 +0530
>
> Subject: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation Kit)
> board
>
> including: - i.MX8MM SoC implementation with CPU, memory, and
> peripherals -
>
> Board-specific configuration and device tree - Clock Control Module
> (CCM) for
>
> i.MX8MM - Analog mixed-signal controller - Updated GPT timer support
> for
>
> i.MX8MM - Documentation for the new board
>
>
>
> Signed-off-by: Gaurav Sharma gaurav.sharma_7@nxp.com"
>
> ---
>
> MAINTAINERS                     |  12 +
>
> docs/system/arm/imx8mm-evk.rst  |  69 ++++
>
> hw/arm/Kconfig                  |  24 ++
>
> hw/arm/fsl-imx8mm.c             | 675 ++++++++++++++++++++++++++++++++
>
> hw/arm/imx8mm-evk.c             | 103 +++++
>
> hw/arm/meson.build              |   2 +
>
> hw/misc/Kconfig                 |   6 +
>
> hw/misc/imx8mm_analog.c         | 160 ++++++++
>
> hw/misc/imx8mm_ccm.c            | 175 +++++++++
>
> hw/misc/meson.build             |   3 +
>
> hw/timer/imx_gpt.c              |  28 ++
>
> include/hw/arm/fsl-imx8mm.h     | 242 ++++++++++++
>
> include/hw/misc/imx8mm_analog.h |  81 ++++
>
> include/hw/misc/imx8mm_ccm.h    |  30 ++
>
> include/hw/timer/imx_gpt.h      |   3 +
>
> 15 files changed, 1613 insertions(+)

Please can you split this up into a multi-patch patch series where each pat=
ch is a self-contained reasonably sized change?
You can look through the git history for examples, but typically adding eac=
h individual new device model should be in its own patch, for example.

Also, it looks like you've sent this as something other than a plain text e=
mail. You'll probably find git send-email will produce better results than =
sending it from your normal mail client.

You can find our guidance on how to send patches here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html
(which includes some tips about setting up tooling to send patch emails).

Thanks for including documentation with the new board model.
Another thing that we like these days for new boards is a simple functional=
 test under tests/functional/ which exercises the board by doing a simple "=
run a guest image and check it boots" test. You can find various examples u=
nder there to use as a template.

thanks
-- PMM

