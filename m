Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A0606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bCn3rVwR;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=j6iGZNgu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRHkP-0003Ri-2P; Wed, 11 Nov 2026 18:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xRHkN-0003RT-HS; Wed, 11 Nov 2026 18:28:55 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xRHkL-0000q3-1N; Wed, 11 Nov 2026 18:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794439740; x=1825975740;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LjN3D/5lHT2xO9P4tkTM7U9aw8a/fcCtGbNMZuezqX4=;
 b=bCn3rVwRBocUQtX4VINYF61vPLoiBfZUdQVdpurF3u9LIsNEdUFIVNbA
 m3PuOfMKAweJ4iOxhuhfFylNtkxJQnpK8RWRSerNXs8BrIm6MuI8v0PF9
 qpv85ctcLQC8JRyWNdQMNYM8cLP8wtuUYEeAg7SKM6M5QD36mURYeHkZ6
 dQe8Y8wzzLr9hyY1b17wQSN4jIDwKGQeai0n8mhpy/27A07jFmyDK2GQ+
 Q2SGsfVelXIVLpiLgiEcrIZycPGycH6c0cI4qHBaskGnfOxlvFlrFdrYD
 pjIEF/xkRTEzmN83ELi5/7smueaqNuqJq0mmBbArl2Heg3ruOzonTNHIE g==;
X-CSE-ConnectionGUID: Mli04FpXSWaDH0/iqEmI2w==
X-CSE-MsgGUID: lugD9SGFSla/skwiUDDZng==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="161649917"
Received: from mail-westus3azon11010056.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.56])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 07:28:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr1kfHUDNmPV5UGMuDo5dyQQyxkaGSLhLW6/g+NQV7p7v8db6fdmV0+SDry/aU8D07O4h7lROAl4iqtdfHIJNHPlplek+7vgNYkVYc7Tf5yff7C9zhnl33Ycki4u3GrrM1FjvCD6CJqb72z/b2nhXA3z0XFDcLr5T3BIbdu9g0eQkybpOI5ezDN8X3yYpSwIUYFFmoHzQRl+noS7fisF1Ee98JxhMJUn0ubjsc9geZEIGMiyKlAnmLrYkt+vUPlSu93IulqLHtSLC88IJGx93SPLsaiVNOPkWACfoQGptVYZ/oBflovKXsEi5sYJ81Tdt7ZyCM+12tdYQtZGoZC3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjN3D/5lHT2xO9P4tkTM7U9aw8a/fcCtGbNMZuezqX4=;
 b=UzUspo6xKjXAB9y6sCn0uXXbFI7vNguOnA6NA+QR/pNPCr40HzBCUL9yWJxYgQlHyTs6xbCBAEYUPdfrBTbhhxQ9b9G6gfRsciGhMT4h7HklhH3GxYt8A/RgEBdAiJvhqoWLGjBRI3nihU9FMDJFKZBoZ2EfIQ3vY8Wb6AwFLSuCCDALWsRv3j5HxDmY3myFg31CrwuSown2sWP6ykMoIGqJkjkTCWGR1H7yKEeGhA+K0TBgWaINT1karvmB9L1B9l+VSN0OX3UyjdkdhHqeMI+LXp6uC7o+AUYYwKJDyfBxzwGyn5rnc0VvozEg7DFz5BlyFhCAwj58XHbYBGlrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjN3D/5lHT2xO9P4tkTM7U9aw8a/fcCtGbNMZuezqX4=;
 b=j6iGZNguMp1mHziO0zBrVOqFL3kyklw5iMMRaPeqrRNKjaaIpveZZ8h3wRrgpiODOh9sONYUVWpvbeQox5zEaukX4YztaJbDqt/umELZKCM4pNALZL2lGE8XbpKWtcWeYRcaGnzWyoGjYZjFNk8gHSRezyXRt4ChKuhjSTv7XA4=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by LV1PR04MB993571.namprd04.prod.outlook.com (2603:10b6:408:3f7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:28:47 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 23:28:47 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mpe@kernel.org" <mpe@kernel.org>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "joel@jms.id.au" <joel@jms.id.au>
Subject: Re: [PATCH v3 7/9] hw/riscv/atlantis: Load the RCPU bootrom
Thread-Topic: [PATCH v3 7/9] hw/riscv/atlantis: Load the RCPU bootrom
Thread-Index: AQHdaCQAGzecMkYvpky+DxHZpNu5/bcpmIMA
Date: Wed, 11 Nov 2026 23:28:47 +0000
Message-ID: <984d940733865ac292c34b7102f5e7397fdd0296.camel@wdc.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
 <20261030040516.853444-8-portias@oss.tenstorrent.com>
In-Reply-To: <20261030040516.853444-8-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|LV1PR04MB993571:EE_
x-ms-office365-filtering-correlation-id: ec6858ce-b047-41ae-9a9b-08df404b8922
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|10070799003|23010399003|376014|18002099003|22082099003|6133799003|261009221227099003|261009220027099003|261009223027099003|261009221727099003|261009223327099003|4143699003|261021123027099003|11063799006|10067099003|261102123227099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|56012099006|261022115727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: QdpR0DUobLLl9yg2aMCIlPpf+xKp12ZrxsRqY3PzeBWsaJWd1I+Un3mAaelOFtPvMj1xj6Cp9vWzCVN6jgsqacsNxMeJqQn4udcCz8hlJ0fE//5XSnI35G1SN+AAqtsYbVi24Ajdp3rNZdmogIsQyWBVMOIX7lGzpCKksymCEnGpRTlexgaz+Z6pr868XbNrPXo3oCefBtJeuyvRlIbigvASrVhpgYMTcxAAO94rCxTki6bi7W5PiYQvd80flkC3yfLiDEUbDHS1Pe86x1MDiQ0j05+4EzCiyIh2dng0Fu1PgRJuWQsUD2DtbG9myAqWIh1r9/WClcl93PqNZcckTIaym6Pc+tCdMcV08HGWs+RLzZkSEBDCWUWTo7ibSyIiwM/1Ahvf54Cx5GHb2PecEVXhc4dXFLkwE2D8OmgWLL2MxIkfp0pHUnz23+4Fnx8khhFZbaBt+a04Qb3qekuqZJ9RpvuJ0rQBP8VWJAEZ82MiJxO73eh/trBr1hkKrWFXeBluDlBW20RDHuPWCFsZCQUwpiIAmX9Ot/b3nhU9/drR/hz0WjjBXyd/bFEBzavNI1UjLk/u+j0UbpTSv7mISe0WrvdqISoJvwea9oXvrTu6JjKLE1/GSmB8YmZgXeaAyJHsNuTYvLjP3UMrwLMEcUKqC5sPIbwt5vNmlhnfieTSM33LVl6Sagj6U9QSzeHE/qTKNIKz55lHAAi5WBIZkyswUCgF/dzy2qiDjJd/004=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(261009221227099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009223327099003)(4143699003)(261021123027099003)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(56012099006)(261022115727099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW0rYTQyQTdpTCtpTXdRVVFDWTVROFdmM0F1cUFxeWVkWWIwNlRUWUxRTFBT?=
 =?utf-8?B?MjBLMkZOWFFIenpMb1BHR044ZC95bnJGL2FLSllmVXpaS0x1bDVCejRXQWJD?=
 =?utf-8?B?VEVSSlVQRVp3SG9yMFoxSTFic054c1grODB0LzlRRHgrazdtUFZvM1lRV0Qw?=
 =?utf-8?B?VnBOTkdMaXpZT1dFNHlKMGxWRENrTHVicjBKd0dDcXNBc28yVEEvQWQxVVkx?=
 =?utf-8?B?UDRqSXplcnpJUmlXNEx4MkNZOThsQXhMT0NPMWUzSytLbklUQml5V05EV0w2?=
 =?utf-8?B?N0xpV1lqamVoVENHMkR5aGtXbldtVDNMUVhFTkxiNlk2UHZNaWJtVjFaTVlp?=
 =?utf-8?B?cXc4YTJaUUZ1c1AyS3NybGx2TEVPcWNkeHZvaGNmMmxyY1BDN0djQ3VFQjVj?=
 =?utf-8?B?VVFtQnhwalpGUnRPREdrOEJOL1pqN1V4NXFrOXQwWHMyUGV6dWhHVytNVU5S?=
 =?utf-8?B?UVFQdkFPN1dKaFUzQ2VHSlBSQnNCcU9COVl6empoMGQxNWs2WUNwbkpzdkZQ?=
 =?utf-8?B?dHc2SnBEQVhFS2NQdFpUd2JBc2w3emFMTUVVTHM4OEdoc3NkYzVkK1A4Z1JR?=
 =?utf-8?B?TytGTzZUNmdxN3RUNkRkajBoV3BEN1J6cjBtcmdndDRIdWJSTmhadHF0anYv?=
 =?utf-8?B?QUNRd2w3emVHaytENlcwT0NKRzV4YXhqTHhadS8yT1FlNXNyNmVpYVlXSFVy?=
 =?utf-8?B?dHFubnNxQkFUTy9wQ0NKSnh0blNrbm1CNXIzMFJxUHZZeVFXcFZLaWFGM29h?=
 =?utf-8?B?YzUwRENUcFYrY0wydTFvb2dRdXRKMXR2LzROREVERDlnK3BpaTFSMXQ3Q0ZZ?=
 =?utf-8?B?RUxGSHFHblErWnV3QzNwZGZ5ZEpoOXd2Y0F4UkExZjhBenc0Q1NkeHZoSFJO?=
 =?utf-8?B?dThVdTVjcEhvTTZLczZzNW9ZVTZHMEV3ekNzUkNOMUdMdXl5cytIMTVzV2Ny?=
 =?utf-8?B?S1RQVU9IOXlyQmpyQXN2WU9YZ0tKc2tjWTk4VXg4VGppZGxCRmZLSHJKWUhB?=
 =?utf-8?B?cDlkU25FOXdEc1hneXczZjQwcjFPSm16c1RmR2RXdjYveEFWM0I1V1FGbWVu?=
 =?utf-8?B?NE1ZV1Y4ZDVXRkJpRnFOZGh6bTdTQlMzdHllSFNwdHJQZlcvcDIvZmoxMTR2?=
 =?utf-8?B?eUFQUitQSkZ5TTY2bEUxZkNyY1YzS1VyNThReU5PQXhvZlhhN1Fsdit6bnVy?=
 =?utf-8?B?WmNRT0doZ3JmU21FSVB1VDZBMWNqd2ZjM2RvaW54VHVXTXhSdzBpellXR0Y0?=
 =?utf-8?B?N2RqZEZaT2JBdm1IUGd1d01XU0lub0FPbksvUVI0OTVLSUFTdVZ3NGdzSTlr?=
 =?utf-8?B?Y245RTRRdUxaNkRxbW0yNXZzUDFMS2RET0RJc1N5Y0QzbHZPM3BoL2JYUEFv?=
 =?utf-8?B?MXcxSmJOOHZDdmo2MzJ4YW5hSXpEd2NUVGpudStQVkk2K0ZYZzA5dUZWaUdE?=
 =?utf-8?B?ckRGRksxVUtSSXVFZ1FvU1BzYU1IaFlsWGQzbm9XSjgvRVI3Rk5GRHNjYWg4?=
 =?utf-8?B?RTE4YyswdkJXTDUzY1hLRnBWNXVjWCtWbWZndWhqeCtLR2dTVXlMaUhBaGFa?=
 =?utf-8?B?b1ZNV0xKR093YWJWTHM1bkZGdG1PVnd4Si81NjhzMjczZWZUSjVtdklnOURu?=
 =?utf-8?B?VGZwcm1Jc1V5T0wwaTNUY2c4S2RGOERPNHIzSStvYUlsTzFIKzhoOURaWjNh?=
 =?utf-8?B?WUJoVWVVOGdZYkRoMVNJaWpVUS9NUnhwMUJVRitLYm5QU0NZUEpwaVViWWVQ?=
 =?utf-8?B?UUhoa2ZLYllwMkdpYWo5bVFmcldtRHpEdHBiWFZXSUhpTk5WSzR2ektvREtG?=
 =?utf-8?B?OHE1UFpDajc4SFhMbTJ3V0Nsa2dyNjNLK0VzM3Y5RGlBZENlM0NmTFdYYU9E?=
 =?utf-8?B?UXRMdS9iQnZ0YStaQkJjSE5jSFBocDBSM24xMFliaGczRW5yK0JlcFBpUHVm?=
 =?utf-8?B?Y0c3QUFqZ1FzZTJualJOcmZBSHBUOE80R0tXbFFkeDhUNHlyWHExZzVJOEVZ?=
 =?utf-8?B?R0JsdXNuNlR5Sjh3aFl4SUhmMlBKd3JQeDl4YVdxTTZTVzVXa1gxQjE4dFlz?=
 =?utf-8?B?cGZyMjBJejJ6YytOK1FiQXlaUmxxVUVQL2RWZG5yTWpyTHJYdWFHZ1ZXWHFF?=
 =?utf-8?B?TjRwOG1IekxROUpKYkZsV05CY1I3UGdHNTBlL1dKWm8xK1pnT0g2SXJYeEtC?=
 =?utf-8?B?c3NnZmJ4RU5lZ1VVSURRRHB0U3dKTUQyMittdXNUT2lzQ1Q1SXZrclFqSnpY?=
 =?utf-8?B?REk3b0hibFdiRXd5OGZVbnE5cjhhajZTSVdFVWVZV0oxWEZTSFRRVVBOZ3dn?=
 =?utf-8?B?aGRaVGJCYzJWS0RneURWQzlGbzBaQUZwcGVwMDBQVWdXM1puck0rRHQzcVhX?=
 =?utf-8?Q?la2n9hNcJbKi8bmiZJI9WFf+80cvEwJhPMtw3vk75zmOL?=
x-ms-exchange-antispam-messagedata-1: fdcGedXBIxpwZw18b1JtJJVyB+9c4WAK4sw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E73055358D1377488617E2AEB23468C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kkru02n3P70IHaxo6QJiT4Q0Ij2LlEbVCvpR0jSaQGzCg49J4EwxAXrgA9j17S/QidIlqWBwHd0RuHSO0HWlKVxOumMSDEmZiwGbYzFZX3raXIPNgL/LtUb56HvYB5b0wWZvli28ufpKgH76DbGUkmEMd9c9lXrIf5FKtQYVJnoLEVuMhj3SS+hthmahq5bXg6HmJc+rP/FhseiZMLpiv/xrsaQAUOtXgXH9Q162Fky4NpA95TD/ylvZGixugGDCto4LtOQRGxgQVbEE98uP3kLxMKOIZTnN6rqJOdE+zljfbjE37qBJF/GH73jLIr8KiW28fHRQSV2fNnY1AmmeRw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yyupfIfdNy0x+EdWkBirCI8wqS9pZCEtWgWlG68KykzW0GrnmPJLLNH65YN+ijWpb6e2X/fc8LlM/y3E8R8VQ17IplUXZdPm/hMvQE7dMCqKZlDl29uGJ3P4/CnrZSs9blk+L2R6fi+HBbQW34OXYqoTsrIwSUNVLCJgLM1mqhpIaO2eG7ulngO31ftr0aXHHS+7xSB1yABWIZm5vqIwnRWsO6NsYGd2c1Vkfics9/sZeA+W8hHPZpCfb2KZMAGcW7Xp4WTnc7UOFnYn4OUsb7z0Z46BNgDIoKvGNcVJQI9sIJC7kCO7bJgf9nqu+eiEcGsuH+kpo11fcOvwRyCsrPdpBGZrIkBm/6QIF7zwOczrWCUg3QBrO5rtsIqls6f1MNwqvJv59+He8r8P2KMmWLsX8m6iYpTTtXpijQjvoVkLEPqFeJ1QjfZcvI8tp7pzBUcbfHXlgGprUc564482ojiiMPdsgeD+pmg+LngzODteBjxYDi51AfGRjSvk9/ahSB7n2zkFKFq8+h7fFramoEi5yjTSHw3sz9vW4syOWjP5CXq55w1EwhZUgD3fNfepG1GJWk50I15C6DqlESUH26Z5Ztp/3/zIEsi6aAPEK42m09zioVtJnCJ2luG1bFJu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6858ce-b047-41ae-9a9b-08df404b8922
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 23:28:47.6353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syXVpzDZj7/cqXshUXMXCOs6oRzviKqKlQwK+6+yNLmaYlKM//i2XFoIt9pIjfvfxtyT3hqeJ8o4f1WVkK+mJVXM8IaNphpqQoKMbvvFVJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR04MB993571
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDE0OjA1ICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
Cj4gVXBkYXRlIHR0LWF0bGFudGlzIHRvLCB3aGVuIHRoZSBSQ1BVIGlzIGVuYWJsZWQgYW5kIGJv
b3Ryb20gYmluYXJ5IGlzCj4gcHJvdmlkZWQsIGxvYWQgdGhlIHByb3ZpZGVkIGJvb3Ryb20gYmlu
YXJ5IGZvciB0aGUgUkNQVSB0byBleGVjdXRlLgo+IAo+IFRoaXMgYWRkcyBhIHR0LWF0bGFudGlz
IG1hY2hpbmUgcHJvcGVydHkgJ2Jvb3Ryb20nIHRoYXQgdGFrZXMgYSBmaWxlCj4gbmFtZS4gcWVt
dV9maW5kX2ZpbGUoKSB0cmllcyB0aGUgZmlsZW5hbWUgYmVmb3JlIHRoZSBzZWFyY2ggcGF0aCwg
c28KPiBib3RoCj4gZnVsbCBmaWxlIHBhdGhzIGFuZCBmaWxlbmFtZXMgcmVsYXRpdmUgdG8gLUwg
d29yazoKPiAKPiDCoMKgwqAgLU0gdHQtYXRsYW50aXMscmNwdT1vbixib290cm9tPW91dC9ib290
cm9tLmJpbgoKV2Ugc2hvdWxkIGJlIHVzaW5nIGRldmljZSBsb2FkZXIgZm9yIHRoaXMsIG5vdCBt
YWNoaW5lIGFyZ3MKCkFsaXN0YWlyCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBvcnRpYSBTdGVwaGVu
cyA8cG9ydGlhc0Bvc3MudGVuc3RvcnJlbnQuY29tPgo+IC0tLQo+IMKgaHcvcmlzY3YvdHRfYXRs
YW50aXMuY8KgwqDCoMKgwqDCoMKgwqAgfCA2Mwo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaCB8wqAgNCArKysKPiDC
oDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvaHcvcmlzY3YvdHRfYXRsYW50aXMuYyBiL2h3L3Jpc2N2L3R0X2F0bGFudGlz
LmMKPiBpbmRleCBmNzc4MDkxZTkxLi5mM2UzNWM2M2VhIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2
L3R0X2F0bGFudGlzLmMKPiArKysgYi9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gQEAgLTksNiAr
OSw3IEBACj4gwqAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgo+IMKgI2luY2x1ZGUgInFhcGkvZXJy
b3IuaCIKPiDCoCNpbmNsdWRlICJxZW11L2N1dGlscy5oIgo+ICsjaW5jbHVkZSAicWVtdS9kYXRh
ZGlyLmgiCj4gwqAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCIKPiDCoCNpbmNsdWRlICJx
ZW11L2d1ZXN0LXJhbmRvbS5oIgo+IMKgI2luY2x1ZGUgInFlbXUvdW5pdHMuaCIKPiBAQCAtNjYz
LDE1ICs2NjQsMzYgQEAgc3RhdGljIHZvaWQgdHRfcmNwdV9jbHVzdGVyX3JlYWxpemUoRGV2aWNl
U3RhdGUKPiAqZGV2LCBFcnJvciAqKmVycnApCj4gwqAKPiDCoMKgwqDCoCBjcmVhdGVfdW5pbXBs
ZW1lbnRlZF9kZXZpY2VzKE9CSkVDVChyYyksICZyYy0+bWVtb3J5LAo+IHJjcHVfdW5pbXBfZGV2
KTsKPiDCoAo+IC3CoMKgwqAgLyogbm8gYm9vdHJvbSBpbWFnZSBpcyBwcm92aWRlZCwgZG9uJ3Qg
bGV0IHRoZSBjb3JlIHJ1biAqLwo+IC3CoMKgwqAgQ1BVKCZyYy0+Y3B1cy5oYXJ0c1swXSktPnN0
YXJ0X3Bvd2VyZWRfb2ZmID0gdHJ1ZTsKPiArwqDCoMKgIGlmIChyYy0+Ym9vdHJvbV9pbWFnZSkg
ewo+ICvCoMKgwqDCoMKgwqDCoCBzc2l6ZV90IHJvbV9zaXplOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqAgZ19hdXRvZnJlZSBjaGFyICpyb21fZmlsZSA9Cj4gcWVtdV9maW5kX2ZpbGUoUUVNVV9GSUxF
X1RZUEVfQklPUywgcmMtPmJvb3Ryb21faW1hZ2UpOwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJv
bV9maWxlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiY291
bGQgbm90IGZpbmQgYm9vdHJvbSBpbWFnZSAnJXMnIiwKPiByYy0+Ym9vdHJvbV9pbWFnZSk7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoCByb21fc2l6ZSA9IGxvYWRfaW1hZ2VfbXIocm9tX2ZpbGUsICZyYy0+
Ym9vdHJvbSk7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyb21fc2l6ZSA8PSAwKSB7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiY291bGQgbm90IGxvYWQgYm9vdHJv
bSBpbWFnZSAnJXMnIiwKPiByYy0+Ym9vdHJvbV9pbWFnZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoCB9IGVsc2Ugewo+ICvC
oMKgwqDCoMKgwqDCoCAvKiBubyBib290cm9tIGltYWdlIGlzIHByb3ZpZGVkLCBkb24ndCBsZXQg
dGhlIGNvcmUgcnVuICovCj4gK8KgwqDCoMKgwqDCoMKgIENQVSgmcmMtPmNwdXMuaGFydHNbMF0p
LT5zdGFydF9wb3dlcmVkX29mZiA9IHRydWU7Cj4gK8KgwqDCoCB9Cj4gwqB9Cj4gwqAKPiArc3Rh
dGljIGNvbnN0IFByb3BlcnR5IHR0X3JjcHVfY2x1c3Rlcl9wcm9wc1tdID0gewo+ICvCoMKgwqAg
REVGSU5FX1BST1BfU1RSSU5HKCJib290cm9tLW5hbWUiLCBUVFJDUFVDbHVzdGVyU3RhdGUsCj4g
Ym9vdHJvbV9pbWFnZSksCj4gK307Cj4gKwo+IMKgc3RhdGljIHZvaWQgdHRfcmNwdV9jbHVzdGVy
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkCj4gKmRhdGEpCj4gwqB7Cj4g
wqDCoMKgwqAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKG9jKTsKPiDCoAo+IMKgwqDC
oMKgIGRjLT5yZWFsaXplID0gdHRfcmNwdV9jbHVzdGVyX3JlYWxpemU7Cj4gK8KgwqDCoCBkZXZp
Y2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCB0dF9yY3B1X2NsdXN0ZXJfcHJvcHMpOwo+IMKgwqDCoMKg
IC8qIFRoZSBjbHVzdGVyIG11c3QgYmUgaW5zdGFudGlhdGVkIGJ5IGEgbWFjaGluZSBvciBTb0Mg
Ki8KPiDCoMKgwqDCoCBkYy0+dXNlcl9jcmVhdGFibGUgPSBmYWxzZTsKPiDCoH0KPiBAQCAtODMw
LDYgKzg1MiwxMyBAQCBzdGF0aWMgdm9pZCB0dF9hdGxhbnRpc19zb2NfcmVhbGl6ZShEZXZpY2VT
dGF0ZQo+ICpkZXYsIEVycm9yICoqZXJycCkKPiDCoMKgwqDCoCBpZiAocy0+aGFzX3JjcHUpIHsK
PiDCoMKgwqDCoMKgwqDCoMKgIC8qIE9ubHkgY3JlYXRlIHRoZSBSQ1BVIGlmIGl0IGlzIGVuYWJs
ZWQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChz
KSwgInJjcHUiLCAmcy0+cmNwdSwKPiBUWVBFX1RUX1JDUFVfQ0xVU1RFUik7Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoCBpZiAocy0+cmNwdV9ib290cm9tX2ltYWdlKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9zdHIoT0JKRUNUKHJjKSwgImJvb3Ryb20tbmFt
ZSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+cmNwdV9ib290cm9tX2ltYWdlLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICZlcnJvcl9hYm9ydCk7Cj4gK8KgwqDCoMKgwqDCoMKgIH0KPiArCj4gwqDCoMKgwqDCoMKg
wqDCoCBpZiAoIXFkZXZfcmVhbGl6ZShERVZJQ0UoJnMtPnJjcHUpLCBOVUxMLCBlcnJwKSkgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
QEAgLTEwMDgsNyArMTAzNyw4IEBAIHN0YXRpYyB2b2lkIHR0X2F0bGFudGlzX3NvY19yZWFsaXpl
KERldmljZVN0YXRlCj4gKmRldiwgRXJyb3IgKiplcnJwKQo+IMKgc3RhdGljIGNvbnN0IFByb3Bl
cnR5IHR0X2F0bGFudGlzX3NvY19wcm9wc1tdID0gewo+IMKgwqDCoMKgIERFRklORV9QUk9QX0xJ
TksoImRyYW0iLCBUVEF0bGFudGlzU29DU3RhdGUsIGRyYW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRZUEVfTUVNT1JZX1JFR0lPTiwgTWVtb3J5UmVnaW9u
ICopLAo+IC3CoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiaGFzLXJjcHUiLCBUVEF0bGFudGlzU29D
U3RhdGUsIGhhc19yY3B1LAo+IGZhbHNlKQo+ICvCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiaGFz
LXJjcHUiLCBUVEF0bGFudGlzU29DU3RhdGUsIGhhc19yY3B1LAo+IGZhbHNlKSwKPiArwqDCoMKg
IERFRklORV9QUk9QX1NUUklORygiYm9vdHJvbS1uYW1lIiwgVFRBdGxhbnRpc1NvQ1N0YXRlLAo+
IHJjcHVfYm9vdHJvbV9pbWFnZSkKPiDCoH07Cj4gwqAKPiDCoHN0YXRpYyB2b2lkIHR0X2F0bGFu
dGlzX3NvY19jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZAo+ICpkYXRhKQo+
IEBAIC0xMDYwLDYgKzEwOTAsMTMgQEAgc3RhdGljIHZvaWQKPiB0dF9hdGxhbnRpc19tYWNoaW5l
X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9hc2NfaGFydHMsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2Fi
b3J0KTsKPiDCoAo+ICvCoMKgwqAgaWYgKGFtcy0+aGFzX3JjcHUgJiYgYW1zLT5yY3B1X2Jvb3Ry
b21faW1hZ2UpIHsKPiArwqDCoMKgwqDCoMKgwqAgLyogU2V0IHRoZSBSQ1BVIGJvb3Ryb20gZmls
ZSBuYW1lIHByb3ZpZGVkIG9uIHRoZSBjb21tYW5kCj4gbGluZSAqLwo+ICvCoMKgwqDCoMKgwqDC
oCBvYmplY3RfcHJvcGVydHlfc2V0X3N0cihPQkpFQ1QocyksICJib290cm9tLW5hbWUiLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhbXMtPnJjcHVfYm9vdHJvbV9pbWFnZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2Fib3J0KTsKPiAr
wqDCoMKgIH0KPiArCj4gwqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChz
KSwgImRyYW0iLCBPQkpFQ1QobWFjaGluZS0KPiA+cmFtKSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZlcnJvcl9hYm9ydCk7Cj4g
wqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVCgmYW1zLT5zb2MpLCAiaGFz
LXJjcHUiLCBhbXMtCj4gPmhhc19yY3B1LAo+IEBAIC0xMDk2LDYgKzExMzMsMjIgQEAgc3RhdGlj
IHZvaWQKPiB0dF9hdGxhbnRpc19tYWNoaW5lX3NldF9yY3B1KE9iamVjdCAqb2JqLCBib29sIHZh
bHVlLCBFcnJvciAqKmVycnApCj4gwqDCoMKgwqAgcy0+aGFzX3JjcHUgPSB2YWx1ZTsKPiDCoH0K
PiDCoAo+ICtzdGF0aWMgY2hhciAqdHRfYXRsYW50aXNfZ2V0X2Jvb3Ryb20oT2JqZWN0ICpvYmos
IEVycm9yICoqZXJycCkKPiArewo+ICvCoMKgwqAgVFRBdGxhbnRpc1N0YXRlICpzID0gVFRfQVRM
QU5USVNfTUFDSElORShvYmopOwo+ICsKPiArwqDCoMKgIHJldHVybiBnX3N0cmR1cChzLT5yY3B1
X2Jvb3Ryb21faW1hZ2UpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB0dF9hdGxhbnRpc19zZXRf
Ym9vdHJvbShPYmplY3QgKm9iaiwgY29uc3QgY2hhciAqdmFsdWUsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVy
cm9yICoqZXJycCkKPiArewo+ICvCoMKgwqAgVFRBdGxhbnRpc1N0YXRlICpzID0gVFRfQVRMQU5U
SVNfTUFDSElORShvYmopOwo+ICsKPiArwqDCoMKgIGdfZnJlZShzLT5yY3B1X2Jvb3Ryb21faW1h
Z2UpOwo+ICvCoMKgwqAgcy0+cmNwdV9ib290cm9tX2ltYWdlID0gZ19zdHJkdXAodmFsdWUpOwo+
ICt9Cj4gKwo+IMKgc3RhdGljIHZvaWQgdHRfYXRsYW50aXNfbWFjaGluZV9jbGFzc19pbml0KE9i
amVjdENsYXNzICpvYywgY29uc3QKPiB2b2lkICpkYXRhKQo+IMKgewo+IMKgwqDCoMKgIE1hY2hp
bmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsKPiBAQCAtMTEyMyw2ICsxMTc2LDEwIEBA
IHN0YXRpYyB2b2lkCj4gdHRfYXRsYW50aXNfbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNz
ICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlNl
dCB0byBlbmFibGUvZGlzYWJsZQo+IG1vZGVsaW5nIHRoZSBSQ1BVLiIpOwo+IMKgwqDCoMKgIG9i
amVjdF9wcm9wZXJ0eV9zZXRfZGVmYXVsdF9ib29sKHByb3AsIGZhbHNlKTsKPiDCoAo+ICvCoMKg
wqAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9zdHIob2MsICJib290cm9tIiwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHR0X2F0bGFudGlzX2dldF9ib290cm9tLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHRfYXRsYW50aXNfc2V0
X2Jvb3Ryb20pOwo+ICvCoMKgwqAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X3NldF9kZXNjcmlwdGlv
bihvYywgImJvb3Ryb20iLCAiUkNQVQo+IGJvb3Ryb20gaW1hZ2UiKTsKPiDCoH0KPiDCoAo+IMKg
c3RhdGljIGNvbnN0IFR5cGVJbmZvIHR0X2F0bGFudGlzX3R5cGVzW10gPSB7Cj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IGIvaW5jbHVkZS9ody9yaXNjdi90
dF9hdGxhbnRpcy5oCj4gaW5kZXggNWEyMDA0MTBmMy4uZTljYzE0NzA2MCAxMDA2NDQKPiAtLS0g
YS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgKPiArKysgYi9pbmNsdWRlL2h3L3Jpc2N2
L3R0X2F0bGFudGlzLmgKPiBAQCAtNjQsNiArNjQsOCBAQCBzdHJ1Y3QgVFRSQ1BVQ2x1c3RlclN0
YXRlIHsKPiDCoMKgwqDCoCBDUFVDbHVzdGVyU3RhdGUgY2x1c3RlcjsKPiDCoMKgwqDCoCBNZW1v
cnlSZWdpb24gYm9vdHJvbTsKPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gc3JhbTsKPiArCj4gK8Kg
wqDCoCBjaGFyICpib290cm9tX2ltYWdlOwo+IMKgfTsKPiDCoAo+IMKgc3RydWN0IFRUQXRsYW50
aXNTb0NTdGF0ZSB7Cj4gQEAgLTg0LDYgKzg2LDcgQEAgc3RydWN0IFRUQXRsYW50aXNTb0NTdGF0
ZSB7Cj4gwqDCoMKgwqAgVFRBdGxhbnRpc1BSQ01TdGF0ZSBwcmNtW1RUX0FUTF9OVU1fUFJDTV07
Cj4gwqAKPiDCoMKgwqDCoCBib29sIGhhc19yY3B1O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIEVuYWJsZSBSQ1BVICovCj4gK8KgwqDCoCBjaGFyICpyY3B1X2Jvb3Ryb21faW1hZ2U7wqDC
oMKgIC8qIFJDUFUgYm9vdCBST00gaW1hZ2UgKi8KPiDCoH07Cj4gwqAKPiDCoHN0cnVjdCBUVEF0
bGFudGlzU3RhdGUgewo+IEBAIC05Niw2ICs5OSw3IEBAIHN0cnVjdCBUVEF0bGFudGlzU3RhdGUg
ewo+IMKgwqDCoMKgIFRUQXRsYW50aXNTb0NTdGF0ZSBzb2M7Cj4gwqAKPiDCoMKgwqDCoCBib29s
IGhhc19yY3B1O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEVuYWJsZSBSQ1BVICovCj4g
K8KgwqDCoCBjaGFyICpyY3B1X2Jvb3Ryb21faW1hZ2U7wqDCoMKgIC8qIFJDUFUgYm9vdCBST00g
aW1hZ2UgKi8KPiDCoH07Cj4gwqAKPiDCoGVudW0gewo=

