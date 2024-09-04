Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4626ACD37BD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 02:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slfYl-0005kz-QB; Tue, 03 Sep 2024 22:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1slfYe-0005jb-Rg; Tue, 03 Sep 2024 22:15:46 -0400
Received: from mail-tyzapc01on20725.outbound.protection.outlook.com
 ([2a01:111:f403:2011::725]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1slfYb-00012h-10; Tue, 03 Sep 2024 22:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlqWBCqviCj5pafHZXdYLB0HJx95mxup63sBdROc1GTMoVnWhR0oTCMej5vkly07aOOgsAM+HCy6yyUcklOVupZzPAxnXi275CpBiCVHqKw6KTIYGr9fhXrtjineSJtetCVn+/Zh4q/6yLn207JUX6u/Lz9jJ198AAb4jXmvYtWndnPBRQNBfXfP4pD7Hq4r55ij2dhc09qkaEFmeHoMBTQTX62zDlROm03dES/bVvsXa3A3gnbb4WlOe0I9GUYpzJnTpXSKwUxd3UT3azc7uvuskngKlS8tFJemgI2ggy3Ms5ohDjFECZbmSS2AbuOhLmZghwunqwFQskbulfvxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS43MfqeNStrE8m46KGS6DTqRTww20oskQLe9mC7vLQ=;
 b=KOZhth4RsmgKhNzwFN+DmCYVFougLGov7pCR45hkuu5UWAEirpg0FCJcDNwp5rQfypqeYaxR4ged8Vapbzg9vDDTzpthVKcOSIeVGvFImtpqBETLcN0IW0KIXoGDUelRCQtMG4g1hQHgA46OevJdQI55osV4TLw7q9ftKTBQxdioNOqN+I9lUZYhc+IqTptCavahPGSbw181aYwLUdkfHx2L6gr7ANX+slmDuWYq/QOe1gG3JXpR+IzBKZfJZVlh3sqZwzrds98hzKUjZbxklhBkB+cMpYHWy2SlfAgnvOggtDC2VUrRpC4tqLOFmPph6IhhhQh9fHz2/XEoUzRRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS43MfqeNStrE8m46KGS6DTqRTww20oskQLe9mC7vLQ=;
 b=OMFJqcpFBgdSfVy6VKVDpyPGXXUvs3uobYpNmhUD1QREBoHKWk9Snsvdjs+Soh06bfVzvoeytgGldyTccyBUzEJpj4Kz5VuJojEqorMB37tFxVnisvGcCK4jZqsGTZ5/+csYyRVU3P9+5K6XJZYcy2rmrlXuXAs4IxUz/B7e2AvjzMhkJTHNBTtCLkixNlPplNPjpUdrfOZZcPFPQaNVF0dEf8Wkf7o5Q4YAcGsWXuh7H9XgMBtrMdszeMeB41ctfGZlANEvuO26PJ95+SnL2w2i5JOT3ggDUcgS03BecAZOHgHcZW1U+/jnovA8zCD70yUoCGEfsxNEZKv13K/zSQ==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by KL1PR03MB7367.apcprd03.prod.outlook.com (2603:1096:820:eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 02:15:27 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 02:15:27 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v3 2/2] target/riscv: Add textra matching condition for
 the triggers
Thread-Topic: [PATCH v3 2/2] target/riscv: Add textra matching condition for
 the triggers
Thread-Index: AQHa2z8alulrSc8qyk+rtdBJu4fnVbIvsgWwgAk0i4CADkKiYA==
Date: Wed, 4 Sep 2024 02:15:27 +0000
Message-ID: <SEYPR03MB670022F7CD2B2C81AED34A13A89C2@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240721072422.1377506-1-alvinga@andestech.com>
 <20240721072422.1377506-3-alvinga@andestech.com>
 <SEYPR03MB67002DA61D8E15CD006817B1A88D2@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <CAKmqyKN2rBBhO3BWs5kNUWKqPcH0dZS7ETPp-gHpe1AnDd=MiA@mail.gmail.com>
In-Reply-To: <CAKmqyKN2rBBhO3BWs5kNUWKqPcH0dZS7ETPp-gHpe1AnDd=MiA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|KL1PR03MB7367:EE_
x-ms-office365-filtering-correlation-id: fd3f23f1-6964-4801-246f-08dccc87716d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a0lyTGd2YmV4QjdBYnI0dzMwaHJ4WUZaZXlrWXI4Ri9xZHFaYytaaFdodnp6?=
 =?utf-8?B?ZFdQYmhpYzhnTllqSzZGQ2djcHlrVkp2dHNrL3QvUGphNGUxb2VKYldJWnpn?=
 =?utf-8?B?aVJnTG40L0E5NVhYL3BIOWFnajhZMDUrcTRUbUwwZDFHVFNWWmt1TFNubnk4?=
 =?utf-8?B?c2paVXRJT1VoUE0xRGlMbU5aSXlUTWlhaWp4ZzVlbzdxU1JmUHZxck1VOG5Q?=
 =?utf-8?B?eWIwVG9yUTlhTWtEZWxXV1hwaHhYT3FPKzhYNFkyOGFoei9pMVozMDNCM09J?=
 =?utf-8?B?Qjc0K2ZPVGVMV1d6MDZWYTNKMHRJQURreXNvaHczcVpJMDk2ZDhxWVA5RnFm?=
 =?utf-8?B?M1lWQkJ5VlcyajNBSE1OZmRDSkJ3ZGNqTWlaZlU2emErMExqbHg2K3ZPR016?=
 =?utf-8?B?Sk1namZkcWVoUGdRMFJYK3Rmbkx0YzBUZUxNMGFySDNmd3czbURncWN4clZL?=
 =?utf-8?B?U1ZsVjErQ2o1ZW5zbG1QWkRLQm56ZW9ZeTRxaE9jS0lTM3l5ZDhuUGdHaFRr?=
 =?utf-8?B?c1hyWHBmYUovUEdxOEk2Mi9TZ3FEU0pDeGl5dzcrT1JPeUNCSnJseXpDSzcr?=
 =?utf-8?B?cnIvT01HaTBPdk83ak15dHArVVNUSVphMUM1TUZLZ29ST3krdWEwdFEvcTVq?=
 =?utf-8?B?VjdwV0JJRnNYdFNIa2w1UXVuYzJPYktpQmYwL2tYN28ySkN1LzhDSFE2UmQx?=
 =?utf-8?B?U3VpV0RWNXpoRURpVzFOOW5mN3B0aTRabVkyMEkwTXhrRFlkMFpGRW0xNkZs?=
 =?utf-8?B?Wnd1bEVXOWVrSmVuTHFERk5pSUhkQ0lXWVpHM2tRY2QzKzhReFNyQTBPL1Qv?=
 =?utf-8?B?ZlUyd0U2QzBFYVh1cWNROFBFZHpVSXpRYXZlTngyOXVzdlYxTGVOM1BDU2dM?=
 =?utf-8?B?ZGx1aXpDSVNFZU5waTZ4b216bGZYZDk4bzZzMi9PVVZIOWtqQ3pMZ1ArQTN2?=
 =?utf-8?B?Mlo5MmwzdzZWd1l3REc5MHdMTVhKRzQ4RXRpWVAwcHdaZnZNTjR1R0xTaEdJ?=
 =?utf-8?B?SkJmaGhwZGk4NlZkUVIza0lzeUpsVlJ1S2pGcmgycUd2Qlp0SWNWNHVaQ0dt?=
 =?utf-8?B?WG5aRS9Gb1NuNXZCQnN3VW5hT3JwU1hKcGlNbHJvay9wUG1VZ05Qb2pLQ2NW?=
 =?utf-8?B?L1cvci9QcGNtQzgzMHV5eUF6YmVScWg5dFFGQzU5VUxrU3grWE5TN1NIdW5D?=
 =?utf-8?B?c0RmNFF2SXdjRm1XVmt4Ykx0eEtKYWU5bHE3WHY4TStVRm1UM2NndEx3RTMr?=
 =?utf-8?B?U1FFdEFQUDVzOTZmalE4NGRCZVZQUTNubTBlUWxLS3drMXBJVHRUeFJNaG1B?=
 =?utf-8?B?aVF2bXdjckRzMGdXWm4zblNCdSt5Q0N5N2RuU1JzMjV2cjBDbi96ZUx5Y1Ar?=
 =?utf-8?B?d2pGRW1qdFVSMDVxeDNjRk9tT0VHTm5KaExCNVg4QWFhSitrTU5pZEJrYnpI?=
 =?utf-8?B?WTN3TXp4RHNXcXpjWXNET3Y5Y1ViVloyR1BTQU5iSlM4L1pIUG1Dbm5yNHNJ?=
 =?utf-8?B?VHI1MityZWJHVm9RcStESDgrTGJpQ1lMSUJ1MlVsRmUrU1E0NUpjeCtDNkc2?=
 =?utf-8?B?ekRDZWtWY3NybmhSb2VNaVYvS3l1bkxsdlREYzFtQkRoMkl0VjcxekFBa2ZW?=
 =?utf-8?B?citMUGhjQnE3cGg5WTI3dmYvbGxad05BdGxsLzRPbmJOMDZMZlh3K2FDUTB2?=
 =?utf-8?B?dkZoOFVNVklpTitiZVhzZExmanQ3WWQ1bFBwWE5GcS9JdHhCSnhPbWFvcGlj?=
 =?utf-8?B?d3VScmQ5dHJHRjFYY1ZRc21CWFEycERBQXo4QVpDRkNmMFpQZE5iQ1pZMnZJ?=
 =?utf-8?B?ZjNxVnRDbFRXYXRBNkdpV2d0aGxlUFZPTWV5MWdKcDc2WkpzemJTUXlkNGYx?=
 =?utf-8?B?RTUzaFZqZTJOajJHTzZMR1BqYUhlVzBQb0tvZDAzc0laUHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNIc1llbTBPcm14d0VER3FocUlOTllaTG10Sy90aDJwaktVNjFDVkZPUlp5?=
 =?utf-8?B?ZmQxSHpkM2NpS0pueDFxdk1PeldqSjBJQkRiR1Y2S0dkdjlvZ0dKOWxtNG5N?=
 =?utf-8?B?bUJQVHNzcFdreE9vVS9zdUhBVlVNSHlPangwT2ZYTnh0WUprUUQ2UnBweGxC?=
 =?utf-8?B?UHVRYk5oZk1MNmFLVmk1dWJjNDVXOHNET2xkNEs0NEJnS0IydkZQV1BBeURT?=
 =?utf-8?B?RGF4VnRNdENOTjBKNXpGS0xEWnppMjNJazAzWjZJbVMwNGN3QlVvMWxLa1Zi?=
 =?utf-8?B?bEl2cmQ3VlUvRytnaGFnNWtOaWpSVFpYMUF6ZVJiMG1rNW9wc0ZLdGd3TkZ0?=
 =?utf-8?B?a0YvbW5SRUZVK01icFk1b0R6ZW85L21qeHpLVC9Ca05hR0lEVlYwUlhSSGRH?=
 =?utf-8?B?Lzh5ZXFZQi9DTzFVN0M0anFvc3ZKNW81b1E1SHI0ZlB1azdxR1oxeW4xdWI3?=
 =?utf-8?B?eDdQN1BDU3FnUzVvTTE3QTRDd1BWS2czVGptVUZCSzNUTmFaNGhPcDAydXla?=
 =?utf-8?B?L04wdkxMcDAvUSsvcy84S0JhbW43dllWcHVkQ25IeE03UHREN3piQWR6ZVdQ?=
 =?utf-8?B?NTY0SDNRTWlQRE5RcXpnZGgxY1ZPUjZRUzhkanpZdklmQWhhOER2N3Nja29k?=
 =?utf-8?B?SU9tSjBtREpvdkwvNE9HTVhaQURPMTRQSERaN3BVRERyejZtS2xrKzhQL1FV?=
 =?utf-8?B?bHh3c2NXQWE0djB1TnVtRk5wWmxGMnl4QkpaMWJQOXJSZTZzU0ZheDFNWkE0?=
 =?utf-8?B?MDV2N1FETHF0ZkRsN3pEVFdIWlZrMjVlV1p3V2N4b25NZXQwc1IwbmV6RmJU?=
 =?utf-8?B?RExlbzd5WXRRcG1SSkpzNkdDcnVtc1czenVSbUMzQW5oV2tLWlpZOXM5WG5D?=
 =?utf-8?B?dWRNc0poQmlITTViRE5oSStJQllpT21VUTBsUndVNTQxKzR3SlFCOTZLQ0dV?=
 =?utf-8?B?VStsSk05K2J5YU9EQ2VkRWVGZ1MxdThwR0RQYjFhUzdUdFR3Umw3N2loakpY?=
 =?utf-8?B?SHJsa0pqbU9vNVBock5lTzFSMzA4MFI3NUZmM3Z1R0RWeUoxamlKUkhPWkNn?=
 =?utf-8?B?RW81MkpEQ2JzUnJ1SEpiSXd6aElZOEgrY0U1L2FBZWlTNnpqWmhITmdzL0Jm?=
 =?utf-8?B?T0dDSi9BYmpVa2RtbFU2em4xeWNVM3QyN3ozcFphR0x4Uk1Lc3hybXdFNFl0?=
 =?utf-8?B?b25QWlVPUGs3NThhRTlTSXBHemdBdXdFVnlhZnlOK2NiWldhNHZwdUJ4eTda?=
 =?utf-8?B?bVJsUDQ1NTdybWJjQkROY1FnT3VTL2lGNGo2L2wxT0VvOUF4Y0I2YjdPNXVE?=
 =?utf-8?B?bG11QUxyVkRmWkZpdjkxOG1OamFHSExqMGU5MmZES0VpamgvR3dmbEh6QXJZ?=
 =?utf-8?B?YXlKUHozcjlKWVFnOWF5K3JuVFY1ckhRMTJUT0JvbVRRVkxpN3IremQ2QjIy?=
 =?utf-8?B?eTJ3U3EyYU5SMGkzTTN5c1Z2NUg2T2tOR1dzUm5iSlIwSTRNcFljVzNwc0l5?=
 =?utf-8?B?ZGdmSFYwYUxaRm5DMGlKVndoSUMyWE02bG5SYURhRDFOYVhCUis0WENwMFVy?=
 =?utf-8?B?NGZjUmMzZ2tjSkw0M0F5ZzZHdTdhL24yV0hQQ09yQm1Nc3NMVEpObC9sbjJU?=
 =?utf-8?B?QkZUdDAxUWVNVkRNRjQwdGhHZGVpWERRYWRtbU5zbHJTUlpGbWdWZnRINjVi?=
 =?utf-8?B?SkZodWljNG0xYjV5UFJsbnExQ0lMeE1VeFNtSHJxWDFvNE9NbTV2ZW1XbDdu?=
 =?utf-8?B?QXZjeTZnV1FlOW5uNG9IdmgyL0NTUkp0VnZzRlloS2orTjFnSHlRaTF5U1Vt?=
 =?utf-8?B?TTVrcWhXdHVQeERqbU1XMC82bkdsWDRCWm51cFdpY2tBWVNLMDJkaWdySmZ3?=
 =?utf-8?B?QkFqMW54ZXZIcDMzNGsvTVh3Zms4T0tlYjBJbkMyWXRncUpFOENkT0Zib21Z?=
 =?utf-8?B?Wm5wdEZka3pDbktjNWRTbDFiSytHRkVTbXp5Vnh4MnZOYjNjUHpTa0tSMFpk?=
 =?utf-8?B?WEJKeGV4eEF4NUxabEZ1Qkw0UUJ5Tm0rYnZBR1RWemd1ZjREVk51VllpN2Fa?=
 =?utf-8?B?ZjRlVWlMTm1JaDBKOWM4YXZnZzdOenJrT1podStYcDJIL0UyR3NYVXdjalc0?=
 =?utf-8?Q?WFG+iqY+jTBUuXKGzjyHwND7j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3f23f1-6964-4801-246f-08dccc87716d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 02:15:27.3349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fN6YEAK9L+pV19tyGMyfN0F/abdL4HSVK6inACxS/6qqgkpc+iYPegvgOjy170CTrdaEMwYTcjEbDaDgfnII4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7367
Received-SPF: pass client-ip=2a01:111:f403:2011::725;
 envelope-from=alvinga@andestech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVn
dXN0IDI2LCAyMDI0IDg6MjYgQU0NCj4gVG86IEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWY
iSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gQ2M6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsg
cWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBhbGlzdGFpci5mcmFuY2lzQHdkYy5jb207IGJpbi5t
ZW5nQHdpbmRyaXZlci5jb207IGxpd2VpMTUxOEBnbWFpbC5jb207DQo+IGRiYXJib3phQHZlbnRh
bmFtaWNyby5jb207IHpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAyLzJdIHRhcmdldC9yaXNjdjogQWRkIHRleHRyYSBtYXRjaGluZyBjb25kaXRp
b24gZm9yIHRoZQ0KPiB0cmlnZ2Vycw0KPg0KPiBbRVhURVJOQUwgTUFJTF0NCj4NCj4gT24gVHVl
LCBBdWcgMjAsIDIwMjQgYXQgMjowMOKAr1BNIEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWY
iSkNCj4gPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBBbGlzdGFp
ciwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEFs
dmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWYiSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4g
PiA+IFNlbnQ6IFN1bmRheSwgSnVseSAyMSwgMjAyNCAzOjI0IFBNDQo+ID4gPiBUbzogcWVtdS1y
aXNjdkBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiA+IENjOiBhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb207IGJpbi5tZW5nQHdpbmRyaXZlci5jb207DQo+ID4gPiBsaXdlaTE1
MThAZ21haWwuY29tOyBkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tOw0KPiA+ID4gemhpd2VpX2xp
dUBsaW51eC5hbGliYWJhLmNvbTsgQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ0KPiA+
ID4gPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MyAyLzJd
IHRhcmdldC9yaXNjdjogQWRkIHRleHRyYSBtYXRjaGluZyBjb25kaXRpb24NCj4gPiA+IGZvciB0
aGUgdHJpZ2dlcnMNCj4gPiA+DQo+ID4gPiBBY2NvcmRpbmcgdG8gUklTQy1WIERlYnVnIHNwZWNp
ZmljYXRpb24sIHRoZSBvcHRpb25hbCB0ZXh0cmEzMiBhbmQNCj4gPiA+IHRleHRyYTY0IHRyaWdn
ZXIgQ1NScyBjYW4gYmUgdXNlZCB0byBjb25maWd1cmUgYWRkaXRpb25hbCBtYXRjaGluZw0KPiA+
ID4gY29uZGl0aW9ucyBmb3IgdGhlIHRyaWdnZXJzLiBGb3IgZXhhbXBsZSwgaWYgdGhlIHRleHRy
YS5NSFNFTEVDVA0KPiA+ID4gZmllbGQgaXMgc2V0IHRvIDQgKG1jb250ZXh0KSwgdGhpcyB0cmln
Z2VyIHdpbGwgb25seSBtYXRjaCBvciBmaXJlDQo+ID4gPiBpZiB0aGUgbG93IGJpdHMgb2YgbWNv
bnRleHQvaGNvbnRleHQgZXF1YWwgdGV4dHJhLk1IVkFMVUUgZmllbGQuDQo+ID4gPg0KPiA+ID4g
VGhpcyBjb21taXQgYWRkcyB0aGUgYWZvcmVtZW50aW9uZWQgbWF0Y2hpbmcgY29uZGl0aW9uIGFz
IGNvbW1vbg0KPiA+ID4gdHJpZ2dlciBtYXRjaGluZyBjb25kaXRpb25zLiBDdXJyZW50bHksIHRo
ZSBvbmx5IGxlZ2FsIHZhbHVlcyBvZg0KPiA+ID4gdGV4dHJhLk1IU0VMRUNUIGFyZSAwDQo+ID4g
PiAoaWdub3JlKSBhbmQgNCAobWNvbnRleHQpLiBXaGVuIHRleHRyYS5NSFNFTEVDVCBpcyAwLCB3
ZSBwYXNzIHRoZQ0KPiBjaGVja2luZy4NCj4gPiA+IFdoZW4gdGV4dHJhLk1IU0VMRUNUIGlzIDQs
IHdlIGNvbXBhcmUgdGV4dHJhLk1IVkFMVUUgd2l0aCBtY29udGV4dA0KPiBDU1IuDQo+ID4gPiBU
aGUgcmVtYWluaW5nIGZpZWxkcywgc3VjaCBhcyB0ZXh0cmEuU0JZVEVNQVNLLCB0ZXh0cmEuU1ZB
TFVFLCBhbmQNCj4gPiA+IHRleHRyYS5TU0VMRUNULCBhcmUgaGFyZHdpcmVkIHRvIHplcm8gZm9y
IG5vdy4gVGh1cywgd2Ugc2tpcA0KPiA+ID4gY2hlY2tpbmcgdGhlbSBoZXJlLg0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFsdmluIENoYW5nIDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+DQo+
ID4gPiBSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgdGFyZ2V0L3Jpc2N2L2RlYnVnLmMgfCA2Mw0KPiA+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ICB0YXJn
ZXQvcmlzY3YvZGVidWcuaCB8ICAzICsrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvZGVidWcuYyBiL3RhcmdldC9yaXNjdi9kZWJ1Zy5jIGluZGV4DQo+ID4gPiBkNmI0
YTA2MTQ0Li42MmJiNzU4ODYwIDEwMDY0NA0KPiA+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2RlYnVn
LmMNCj4gPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9kZWJ1Zy5jDQo+ID4gPiBAQCAtMzY0LDExICsz
NjQsNzIgQEAgc3RhdGljIGJvb2wgdHJpZ2dlcl9wcml2X21hdGNoKENQVVJJU0NWU3RhdGUNCj4g
PiA+ICplbnYsIHRyaWdnZXJfdHlwZV90IHR5cGUsDQo+ID4gPiAgICAgIHJldHVybiBmYWxzZTsN
Cj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyBib29sIHRyaWdnZXJfdGV4dHJhX21hdGNo
KENQVVJJU0NWU3RhdGUgKmVudiwgdHJpZ2dlcl90eXBlX3QNCj4gdHlwZSwNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgdHJpZ2dlcl9pbmRleCkgew0KPiA+ID4g
KyAgICB0YXJnZXRfdWxvbmcgdGV4dHJhID0gZW52LT50ZGF0YTNbdHJpZ2dlcl9pbmRleF07DQo+
ID4gPiArICAgIHRhcmdldF91bG9uZyBtaHZhbHVlLCBtaHNlbGVjdDsNCj4gPiA+ICsNCj4gPiA+
ICsgICAgaWYgKHR5cGUgPCBUUklHR0VSX1RZUEVfQURfTUFUQ0ggfHwgdHlwZSA+DQo+ID4gPiBU
UklHR0VSX1RZUEVfQURfTUFUQ0g2KSB7DQo+ID4gPiArICAgICAgICAvKiB0ZXh0cmEgY2hlY2tp
bmcgaXMgb25seSBhcHBsaWNhYmxlIHdoZW4gdHlwZSBpcyAyLCAzLCA0LCA1LCBvciA2DQo+ICov
DQo+ID4gPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+
ID4gKyAgICBzd2l0Y2ggKHJpc2N2X2NwdV9teGwoZW52KSkgew0KPiA+ID4gKyAgICBjYXNlIE1Y
TF9SVjMyOg0KPiA+ID4gKyAgICAgICAgbWh2YWx1ZSAgPSBnZXRfZmllbGQodGV4dHJhLCBURVhU
UkEzMl9NSFZBTFVFKTsNCj4gPiA+ICsgICAgICAgIG1oc2VsZWN0ID0gZ2V0X2ZpZWxkKHRleHRy
YSwgVEVYVFJBMzJfTUhTRUxFQ1QpOw0KPiA+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gPiArICAg
IGNhc2UgTVhMX1JWNjQ6DQo+ID4gPiArICAgIGNhc2UgTVhMX1JWMTI4Og0KPiA+ID4gKyAgICAg
ICAgbWh2YWx1ZSAgPSBnZXRfZmllbGQodGV4dHJhLCBURVhUUkE2NF9NSFZBTFVFKTsNCj4gPiA+
ICsgICAgICAgIG1oc2VsZWN0ID0gZ2V0X2ZpZWxkKHRleHRyYSwgVEVYVFJBNjRfTUhTRUxFQ1Qp
Ow0KPiA+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgIGRlZmF1bHQ6DQo+ID4gPiArICAg
ICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4g
PiArICAgIC8qIENoZWNrIG1odmFsdWUgYW5kIG1oc2VsZWN0LiAqLw0KPiA+ID4gKyAgICBzd2l0
Y2ggKG1oc2VsZWN0KSB7DQo+ID4gPiArICAgIGNhc2UgTUhTRUxFQ1RfSUdOT1JFOg0KPiA+ID4g
KyAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgIGNhc2UgTUhTRUxFQ1RfTUNPTlRFWFQ6DQo+ID4g
PiArICAgICAgICAvKiBNYXRjaCBvciBmaXJlIGlmIHRoZSBsb3cgYml0cyBvZiBtY29udGV4dC9o
Y29udGV4dCBlcXVhbA0KPiBtaHZhbHVlLg0KPiA+ID4gKi8NCj4gPiA+ICsgICAgICAgIGlmIChy
aXNjdl9oYXNfZXh0KGVudiwgUlZIKSkgew0KPiA+ID4gKyAgICAgICAgICAgIGlmIChtaHZhbHVl
ICE9IGVudi0+bWNvbnRleHQpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ID4gKyAgICAgICAgICAgIH0NCj4gPiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gPiAr
ICAgICAgICAgICAgc3dpdGNoIChyaXNjdl9jcHVfbXhsKGVudikpIHsNCj4gPiA+ICsgICAgICAg
ICAgICBjYXNlIE1YTF9SVjMyOg0KPiA+ID4gKyAgICAgICAgICAgICAgICBpZiAobWh2YWx1ZSAh
PSAoZW52LT5tY29udGV4dCAmIE1DT05URVhUMzIpKSB7DQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiArICAgICAgICAgICAgICAgIH0NCj4gPiA+ICsgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgICAgICAgICAgY2FzZSBNWExfUlY2NDoNCj4g
PiA+ICsgICAgICAgICAgICBjYXNlIE1YTF9SVjEyODoNCj4gPiA+ICsgICAgICAgICAgICAgICAg
aWYgKG1odmFsdWUgIT0gKGVudi0+bWNvbnRleHQgJiBNQ09OVEVYVDY0KSkgew0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKyAgICAgICAgICAgICAgICB9
DQo+ID4gPiArICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gKyAgICAgICAgICAgIGRlZmF1
bHQ6DQo+ID4gPiArICAgICAgICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ID4g
PiArICAgICAgICAgICAgfQ0KPiA+ID4gKyAgICAgICAgfQ0KPiA+DQo+ID4gSSBoYXZlIHNvbWUg
bmV3IGlkZWFzIG9uIHRoaXMgcGFydC4NCj4gPiBTaG91bGQgd2UgcmVwbGFjZSB0aGlzIHdob2xl
IGlmLWVsc2Ugd2l0aCBqdXN0IHRoZSBmb2xsb3dpbmcgc2ltcGxlIGNvZGUgPw0KPiA+DQo+ID4g
ICAgIGNhc2UgTUhTRUxFQ1RfTUNPTlRFWFQ6DQo+ID4gICAgICAgICAvKiBNYXRjaCBpZiB0aGUg
bG93IGJpdHMgb2YgbWNvbnRleHQvaGNvbnRleHQgZXF1YWwgbWh2YWx1ZS4gKi8NCj4gPiAgICAg
ICAgIGlmIChtaHZhbHVlICE9IGVudi0+bWNvbnRleHQpIHsNCj4gPiAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAgICBicmVhazsNCj4gPg0KPiA+IFRo
b3NlIG1hc2tzIG9uIG1jb250ZXh0IGhhdmUgYmVlbiBhcHBsaWVkIGluIHdyaXRlX21jb250ZXh0
KCkuDQo+ID4gSSB0aGluayB3ZSBjYW4gc2tpcCB0aGUgbWFza3MgaGVyZS4NCj4gPiBXaGF0IGRv
IHlvdSB0aGluayA/DQo+DQo+IFllcCwgdGhhdCB3b3VsZCBiZSBtdWNoIGJldHRlcg0KDQpJJ3Zl
IHN1Ym1pdHRlZCB2NCBwYXRjaCB0byBzaW1wbGlmeSB0aGlzIGNvZGUuDQpQbGVhc2Ugc2VlIGh0
dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1yaXNjdi8yMDI0LTA4L21zZzAw
NTEyLmh0bWwNCg0KDQpTaW5jZXJlbHksDQpBbHZpbg0KDQo+DQo+IEFsaXN0YWlyDQo+DQo+ID4N
Cj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQWx2aW4gQ2hhbmcNCj4gPg0KPiA+ID4gKyAgICAgICAg
YnJlYWs7DQo+ID4gPiArICAgIGRlZmF1bHQ6DQo+ID4gPiArICAgICAgICBicmVhazsNCj4gPiA+
ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gPiA+ICt9DQo+ID4g
PiArDQo+ID4gPiAgLyogQ29tbW9uIG1hdGNoaW5nIGNvbmRpdGlvbnMgZm9yIGFsbCB0eXBlcyBv
ZiB0aGUgdHJpZ2dlcnMuICovDQo+ID4gPiBzdGF0aWMgYm9vbCB0cmlnZ2VyX2NvbW1vbl9tYXRj
aChDUFVSSVNDVlN0YXRlICplbnYsIHRyaWdnZXJfdHlwZV90DQo+IHR5cGUsDQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHRyaWdnZXJfaW5kZXgpICB7DQo+ID4g
PiAtICAgIHJldHVybiB0cmlnZ2VyX3ByaXZfbWF0Y2goZW52LCB0eXBlLCB0cmlnZ2VyX2luZGV4
KTsNCj4gPiA+ICsgICAgcmV0dXJuIHRyaWdnZXJfcHJpdl9tYXRjaChlbnYsIHR5cGUsIHRyaWdn
ZXJfaW5kZXgpICYmDQo+ID4gPiArICAgICAgICAgICB0cmlnZ2VyX3RleHRyYV9tYXRjaChlbnYs
IHR5cGUsIHRyaWdnZXJfaW5kZXgpOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgLyogdHlwZSAy
IHRyaWdnZXIgKi8NCj4gPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvZGVidWcuaCBiL3Rh
cmdldC9yaXNjdi9kZWJ1Zy5oIGluZGV4DQo+ID4gPiBjMzQ3ODYzNTc4Li5mNzZiOGY5NDRhIDEw
MDY0NA0KPiA+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2RlYnVnLmgNCj4gPiA+ICsrKyBiL3Rhcmdl
dC9yaXNjdi9kZWJ1Zy5oDQo+ID4gPiBAQCAtMTMxLDYgKzEzMSw5IEBAIGVudW0gew0KPiA+ID4g
ICNkZWZpbmUgSVRSSUdHRVJfVlUgICAgICAgICAgIEJJVCgyNSkNCj4gPiA+ICAjZGVmaW5lIElU
UklHR0VSX1ZTICAgICAgICAgICBCSVQoMjYpDQo+ID4gPg0KPiA+ID4gKyNkZWZpbmUgTUhTRUxF
Q1RfSUdOT1JFICAgICAgIDANCj4gPiA+ICsjZGVmaW5lIE1IU0VMRUNUX01DT05URVhUICAgICA0
DQo+ID4gPiArDQo+ID4gPiAgYm9vbCB0ZGF0YV9hdmFpbGFibGUoQ1BVUklTQ1ZTdGF0ZSAqZW52
LCBpbnQgdGRhdGFfaW5kZXgpOw0KPiA+ID4NCj4gPiA+ICB0YXJnZXRfdWxvbmcgdHNlbGVjdF9j
c3JfcmVhZChDUFVSSVNDVlN0YXRlICplbnYpOw0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KPiA+
DQo+ID4gQ09ORklERU5USUFMSVRZIE5PVElDRToNCj4gPg0KPiA+IFRoaXMgZS1tYWlsIChhbmQg
aXRzIGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIGxlZ2FsbHkNCj4g
cHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBvciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJvbSBkaXNj
bG9zdXJlLiBJZiB5b3UgYXJlIG5vdA0KPiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJl
IGhlcmVieSBub3RpZmllZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLA0KPiBkaXN0cmli
dXRpb24sIG9yIHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpcyBzdHJp
Y3RseSBwcm9oaWJpdGVkLiBJbg0KPiB0aGlzIGNhc2UsIHBsZWFzZSBpbW1lZGlhdGVseSBub3Rp
ZnkgdGhlIHNlbmRlciBieSByZXR1cm4gZS1tYWlsLCBkZWxldGUgdGhlDQo+IG1lc3NhZ2UgKGFu
ZCBhbnkgYWNjb21wYW55aW5nIGRvY3VtZW50cykgYW5kIGRlc3Ryb3kgYWxsIHByaW50ZWQgaGFy
ZA0KPiBjb3BpZXMuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCj4gPg0KPiA+IENv
cHlyaWdodCBBTkRFUyBURUNITk9MT0dZIENPUlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZl
ZC4NCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6DQoNClRoaXMgZS1tYWlsIChhbmQgaXRzIGF0dGFj
aG1lbnRzKSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIGxlZ2FsbHkgcHJpdmlsZWdlZCBp
bmZvcm1hdGlvbiBvciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJlLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBub3RpZmll
ZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRpb24sIG9yIHVzZSBvZiB0
aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJ
biB0aGlzIGNhc2UsIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkgdGhlIHNlbmRlciBieSByZXR1
cm4gZS1tYWlsLCBkZWxldGUgdGhlIG1lc3NhZ2UgKGFuZCBhbnkgYWNjb21wYW55aW5nIGRvY3Vt
ZW50cykgYW5kIGRlc3Ryb3kgYWxsIHByaW50ZWQgaGFyZCBjb3BpZXMuIFRoYW5rIHlvdSBmb3Ig
eW91ciBjb29wZXJhdGlvbi4NCg0KQ29weXJpZ2h0IEFOREVTIFRFQ0hOT0xPR1kgQ09SUE9SQVRJ
T04gLSBBbGwgUmlnaHRzIFJlc2VydmVkLg0K

