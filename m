Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59E9C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsN68-0005sJ-QP; Wed, 12 Mar 2025 10:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tsN5n-0005qg-TX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:29:57 -0400
Received: from mail-vi1eur03on2070f.outbound.protection.outlook.com
 ([2a01:111:f403:260c::70f]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tsN5h-0003TJ-S2
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efU7kbWurdvATqokM3dWvA8OfXQ6grtYg2CRA41fBmLhFyyq/JF0yAs9N4Ig1YnHsGc54WQjP/t6+GWlxldtqnHqq9UpuTCadiO9z8Pd4bn+289IJ923OxiWaEC80Z7JkSAs1meJhnhIJmy4fib+K7NPJgsCJ9XbhM/HSrUcHBZd2+Kwd7SmYoEGetSMo9VIJ/U4yr3p23DKncKDpP3jhRIuuakHeN+bxcV+V65pIhbBcFBMmdqKtrZA/p80QJijbxcNaLUKV6Jwfja1VKmTarNggMkvjr0s3agaz8o1mI+gTDa4z4RlBpWfSW9nb1n4INnLQn6F4ykgaW0+SNhE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=DyFhItvArbRc6pssyVbg5qactDBlBPu5p3Mw7e7Ys0g3ep4UqNrZtJAbjM2KmoSNQ3VnHGSgSl8ocFQSNfps7Yw/XqitjmOaNQkERi8xidzFpAQlds5S89o3yygmSqlSoUqaQMZBRaqixoglJOfwW/5nyvFh3OaaL5rjxdF1gI6yAKS5SB3wg9XE7jwigEkcJThaWTZSImDP6Hz2IPiaqFgZ3p01riFjrnDpY2e7SnKnOQexI0TpBVUJTFX1PeqixW4EiN+6hcrgO7C8ebDOw6b8E7uZceojXJwbr1r6NCpyvpr0xDN27ToBO1+bP11OO+yWKzDc/2clYITNMUwrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=Ush+ufLsfTkMxPi3Xrv94+f4WDd2fM2CZw2HJ6SahE2hGqF5FV13fJ2vlU/JhmHxK6KwxHJzT9JuDchdEBhC54WghnuDmwf65XBZ7hNv5EORviAh0/5J9daCLH67M1vMZOHDx3IPs4Rr+MoegoLitJ/pSCh+uxtnwboV2bVinNXVCRVwIxmx4qvb3HVvo5AVNmJkMCHGYG51UaxIK+5Y5R7d3n/zh9H/ycA/oipmIj0CG/PuEuyw27CJJTGp4ebO9FFvoz0X4POTl7DFRk5GnMdIU0YjAFabj1mcOQfZDLdBnh0gdk2HGThjToqvJ+qTPf9aX4eWYZsdWAvf/0VDew==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by GVXPR09MB7253.eurprd09.prod.outlook.com (2603:10a6:150:1bc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:29:43 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:29:43 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>,
 "fshahbazker@wavecomp.com" <fshahbazker@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "philmd@linaro.org"
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Index: AQHbiHBN9WWu61L0jUe8EWyWqAJpArNvpUkA
Date: Wed, 12 Mar 2025 14:29:43 +0000
Message-ID: <20250312142854.114061-1-aleksandar.rakic@htecgroup.com>
References: <20250226170246.1971355-4-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-4-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|GVXPR09MB7253:EE_
x-ms-office365-filtering-correlation-id: c00234a3-d2f7-4985-d124-08dd617254e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4FpU0PAyQ0qQK6ISwboL7WqxynSguiQlSpqatizJpFzu1KOnXC2ZNpwFVn?=
 =?iso-8859-1?Q?KiRkrilbaFzwokhz+qn6ixyYFqzpOEkc13919Byocyr4BbtiueCvKwgQcF?=
 =?iso-8859-1?Q?GE4GUfMUy4F+Nha5ZFjKEkz1h4F1KwY0npxYY2VlX5eLzyFguwImoA5gbu?=
 =?iso-8859-1?Q?Xcv9e2TKAUmtJRAt75Rz7OPFwp2C9bywzNVtpTqXft17Zjo6KGCggxZjU/?=
 =?iso-8859-1?Q?lFlaCYdpdjCpv8qyDz+p9O+8h2dukmouyBuxR0o9QbN6xs1FtSyVHjz1QL?=
 =?iso-8859-1?Q?rXig0ySAIjtisdzeI9uHJEwoAw20wnvImltvtcWLBpkspAA5CLga8L4IE/?=
 =?iso-8859-1?Q?dfW9AeeMy8LqklpXKHMfB+Besq/b2h9mY3b/PGD+l21w75ls0atKt3ZfbH?=
 =?iso-8859-1?Q?5fQ/s5ReUtXsMbR2hBZT7mPhplfKo9HDi4jxbEIXcBIAeLuz8J+gQhaDCq?=
 =?iso-8859-1?Q?/EWUDpNWuBT2A3jIwXYoJhzzzJhnXjiR8jkSK2qnXaFI2+f9x3xqOTBger?=
 =?iso-8859-1?Q?v2sNSrshWu6/+e5lQDE+/59Oaj+DytNcdjuoDl2kW8DNEYRn2HRHc5rmva?=
 =?iso-8859-1?Q?jFJg4uBZOKeg60XUKAHJAoC0nW2UspmulkO5jlWPoAZCk3usxdgl9vhzDl?=
 =?iso-8859-1?Q?j8qU+H5gxGhD1UylysbqCLebTHfUnr1M/JbBvmB0EYMNprKCnC7QmIMmKU?=
 =?iso-8859-1?Q?2mZxJGW2TL6kjHmcfXAb39Fk0tei6g15nvBuacgSkuyf+y68z4XH1Xlz8/?=
 =?iso-8859-1?Q?5P2w8kxy3qhWfkDvGlmQGyCMrITL1kEkcrhHw0JHcLlJrS9j8QoQdUtpXV?=
 =?iso-8859-1?Q?icgEN9BNx+FnZmJVnKdg5DQTL48OLttBiLDfRoGN5f7N4k/i0kNRqA1XXb?=
 =?iso-8859-1?Q?Hx+UE/6dbma5RCXcYgSkcICVgfayuha3nGSFeIqfYd1CGgWF0Eb/EPZ+fT?=
 =?iso-8859-1?Q?uY+q1HXnHAPCN7vtPCVUzxPLMFDFi7QEIzJYvviZevKVgC9aIxVQUu+9G5?=
 =?iso-8859-1?Q?uGXfHQIXMcagAf4ZmsrIY+a95grhPLafnQqdcQGtpeMnOWY9wv1Hk3jxzH?=
 =?iso-8859-1?Q?OsnOFz1M5jSozizlp05/ZEE5U5a9ExMwQncVOZbPTDilo7FLOIbYMHaS7d?=
 =?iso-8859-1?Q?Q3IXrAQ1dDSXRwRkDawLqQ0KUm1uCiYnriAHMzQlFVKgw4U/MwR2XCgRdI?=
 =?iso-8859-1?Q?5M4zIRDntTuKgPZF2rOS2UA/kz3IQiHEzxlUg9uHTNo0BxWw5E4rGLeVgq?=
 =?iso-8859-1?Q?WJQDJBDxobEmSfk4YpMmC9ofyrj3GuHCz5+lyZpB9MZbMs8rT3aMyHyoAO?=
 =?iso-8859-1?Q?UBbA9woyeCD2Bm3U4am9YUa5yg9PuFOVhyC9MsUmu3+rLbKoWgTm5L8BuU?=
 =?iso-8859-1?Q?sAmipU6Ayg9uyS5A+CJeJQy6QW4Acjsy9bUqZfB3baXd5aWY0u5Ep82S4M?=
 =?iso-8859-1?Q?h8Q5qwm/fdz5/6NAUECWIFz3jciUPB41l9SNc7cz3Fn9vMbJS7c1ONQYSn?=
 =?iso-8859-1?Q?e4ls+RGYPBM9QoBqXyiAnU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LcNamfHtjpA8CasaEItZBZdkryyLyF4rQ14CLYSwPWOXi/K9eCHFgQdisO?=
 =?iso-8859-1?Q?93mgPsg0VJISFtlzKnMErD7UACNhc1+IqLU+7cZ5KGUd7kW/DmJE4Gus/e?=
 =?iso-8859-1?Q?yc5ZPz2P4O8dzNe8kPBCiUY5t6s/yZ2oMPhBotj5fj5taltX30lzR6D/qR?=
 =?iso-8859-1?Q?d+wQRWnF7/0RFnq7HXp7agMBi9GDddXETa89Hc+Rzsp64bORLI0KfSYqiW?=
 =?iso-8859-1?Q?pAFd33SFIFTs1LQvhDMnmmJ5/fc6rc9rvM023qwoCiWhOhn2SVOfQRJQxi?=
 =?iso-8859-1?Q?5cawhKcdcBJ+f/Odi+ympH+MKqn9ToUHgQ1QOPtP3IZbBW2YIDxWXNW0sU?=
 =?iso-8859-1?Q?jeiwSKkvEIEvllQmiO4C+b08wmpoMf4e0VdCtAUuSL4JnzRyziqbrU37AR?=
 =?iso-8859-1?Q?PiSzTCJmG7tJXlU5HpxYl44SFO4sKAVC/nrNBj7k7hKaAjY+nR03ypyT7V?=
 =?iso-8859-1?Q?S6qHtNZ7KwIqaYzjAorSxwuJjSzjuIAedwt4yJMZI7upZQXB8C9bLOsETk?=
 =?iso-8859-1?Q?rpfLfUzB27uJNrxar3rFW0BxatzdzQ3JFRfelk+IKJ08IVdzqqrL7p8qEA?=
 =?iso-8859-1?Q?b3qRsTZaOrDuuXnmJ13mVcVLPYnTYlWHhSM8zNZYtoZmcBOU8XO96b+k+D?=
 =?iso-8859-1?Q?Bb6RxEkLrcjxHrYSHKkttsiu2J9m8nWx03APi1KPlCOUW5gFciVXYZRFiY?=
 =?iso-8859-1?Q?TXCz6FBZRNUJShRGPLzfSxh9pfWarOljBc/gmo/vMiCjNANN2LD4G6lY2l?=
 =?iso-8859-1?Q?ZDSXm3a23rwlUGuhcdzUQT/Jhn6tEfPMlj/f/OIGx2K421laouRrf+/Dse?=
 =?iso-8859-1?Q?9c0tkjC+rq/O5sJ5lRdrXS+J0QbCcwN8YgcOsK9O5c/cL6Ab1X/+SOnplx?=
 =?iso-8859-1?Q?sW7sP0S8Hpe48k1mNsTxls3BgMz7rTq4gms2OnNncSfNEXn7s1GZARpC9o?=
 =?iso-8859-1?Q?j8gnpMD2HwGSSkOXNYaGEv4XhhqYVGepUFv49D6/VBjTgzX080U6au/lkd?=
 =?iso-8859-1?Q?9Vpq9jXJ1XhCUYAWbc0NyrPrpa+604UlANUVtLqBMEWzNEFtJpvXcR2ibj?=
 =?iso-8859-1?Q?A256GG9fdQQUdJP0V3MZI/An65RWeYw4bX6NSVKjaEVHXBTzlHzTjaxvsu?=
 =?iso-8859-1?Q?5bgIRfNmzVeQke9avzFA/Ag+7AY3c9Cf688UBhsIbndDvlnIz83ErMQybA?=
 =?iso-8859-1?Q?hmaQ9D2Jly0mom9sBqV2ujm2tAuJL8UKvdDz6iAd47L5aDQRD902Yf8KPo?=
 =?iso-8859-1?Q?uKao3mvDbC1QZm4lIeIg9Q2WqiOItCT3WZGh0xNZ+QnOiglbLPWSzx/S1C?=
 =?iso-8859-1?Q?/rUyzAuM/6rWIQ3MoD1oBKd41ScJt7ad4jBAXyv2pli6PnZR3Pv0iXba42?=
 =?iso-8859-1?Q?fGVphugCt35/Pbf3mFy35qvG8wta3Xx4BTpJLr6S2V7fSxCk0HpNe6XoY3?=
 =?iso-8859-1?Q?juICPb5SZfRtr6XQ2hvaqd65ZYqo2quMj3/Z21dbt8IT6rqAWgub37wPMU?=
 =?iso-8859-1?Q?aKGY5IGJVxamKSOwk+SDYMPfadH2QXOWL+oPhHfRoyH5qKaSCOXaZw+si8?=
 =?iso-8859-1?Q?5jEUCJDI5TzQwBSt47ev4JOnWlLr+bCe5yfmIORoYuVgQDGDkPueySejpD?=
 =?iso-8859-1?Q?utiGjLHz6CKfm+Ybrh7AcbBbY4ddkIo4A2xEZuTjlde/W2hecjvPw/Pl+B?=
 =?iso-8859-1?Q?hYZ5Jxj5ZwpqfMLGVU4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00234a3-d2f7-4985-d124-08dd617254e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:29:43.4266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2l7vy3qZNLx03sUiaF49fOgA6IMcmGUBov2Dqlj2KY4aScv79hPx8Sh42Lpyp9Ng9lgz3k4obcd/bGsU40Gd4soDli0kMVQc0X3RB9cE/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7253
Received-SPF: pass client-ip=2a01:111:f403:260c::70f;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic=

