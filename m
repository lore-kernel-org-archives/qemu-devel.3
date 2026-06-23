Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FF5CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbtNx-0000kL-Cp; Tue, 23 Jun 2026 01:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wbtNt-0000k4-BF; Tue, 23 Jun 2026 01:09:17 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wbtNq-0000rN-KC; Tue, 23 Jun 2026 01:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1782191355; x=1813727355;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HZUhpA1uPlNVGSIYMfFEbQ8+iTahtqbcs8SK4kpl8co=;
 b=k42EdPt4tmvYNF5uBjRDrmR1x4JZWC+5Lko5M+xCtft1ngHN98FWCLwq
 5GGV6xYdlNx0bMqyGV7Am2kMR9NuIM8MbyoViqo8ch6+/e6M+28HOFWI0
 +aSGVkzdiyDWobD7dt0U+eDHZjAm8SS1CjLR9qCGZaWB5v5R+QKoLsyaZ
 gU25PPcUYRpEfrm+UkKBGk3ekMH8FD76jjHgBakB0/RgrBFR0ieAG4raj
 CzgQgsBMlbXk2Ryj008+41GNucg6WYJpNcIpvTcJP0h57CiCEwskhXnGR
 ocfNXlb5e7XkkboXETngNQU/6KRfvbNTjXy7Y2QmLNPTEf2ExhOvJYsg9 w==;
X-CSE-ConnectionGUID: 3Wcw1fZQSGiQQkL0tb9RIA==
X-CSE-MsgGUID: GrWbd1V/S5us947Mvi5JMA==
IronPort-SDR: 6a3a14f5_bX5gwmIX24OYdUGBQAZ7yvSk4tIwIt4yn0f2+BQI4kXJO1Z
 Vk1zZ9X9FICD3Rf9vVHZ8oYjeVtfj3mncqvDI7Q==
X-IronPort-AV: E=Sophos;i="6.24,220,1774306800"; d="scan'208";a="48292215"
X-MGA-submission: =?us-ascii?q?MDFLUCpj3YUSr7XDlcVZTBtyql2tJ+KmRPVbID?=
 =?us-ascii?q?MPHqLcKaEd8SQYolIPe/SEEVDodiTK6OBQ8+aVm8fYkO/UDKvzQ1cSQl?=
 =?us-ascii?q?7SkdEl4gKkXVl3MTzRDxGkrIvAjTSRB1gcFHJWURdou30MG+V7XipWbu?=
 =?us-ascii?q?yuTP2KMH8k0rZ/J/NGC/slIg=3D=3D?=
Received: from mail-northeuropeazon11011024.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.24])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 23 Jun 2026 07:09:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF9wD57B7LvJas9jHLac4Tfgy79t8nl55iQpOIq/8qgdyiKtoOE9obgaOBL6a+aWe0/hGd1G9S2QWwDXYpci2yfY5hKNgiCWfHZjD+VD4haFh5owwYEG+gbEq2+U28rgeaLCCuqScORFH15HgozA4W9nA/dTmL8UImXs64deT5yl/TVGyhbMZMgtfPFBIfC3XxZIvic+J0sQ2QCbsz4hiTerF6rfmEb56ieQtrx/3fyG4ukN3rRI7gJgSTDM4jxYDrdPGJj8qoWBNy13PyB4kGI+Ga83uZi2smJZ1r1FdvofBijbhVKwRLt21oexK4Vdu7XK7aVr22zbbgE6gB+PaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZUhpA1uPlNVGSIYMfFEbQ8+iTahtqbcs8SK4kpl8co=;
 b=czE6n8qW1l71ZqvFC6ihr0wxe/4bQ+vh1Ttx9oh2hooKcEudYjTTDfFApDkVdqIL7ow5qoZYooYDGkdOaxIwoWnSOW1ovsoymrqpm/NbgpgtDluuc3RTG9q06YoCOuUqIvSmFo6EycyhNMrH6HZcduuVHnBSEn9h8At14NckgdY4goj3I5LHXIJ1XzxrM1c4L1RO9Me9HFLS/MNmltV5UjRGC9g3kGFn4UCUa1Z07GzE6APYZnc48emtETB8xl4ypQk2OgLknFHIwfxuWWaOuzy8IgaAWecwucQZ1Lvc00hzmbkrAk5f07gKxtAqeer+8pSUaHcnlEv3JKChpC4QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU2PR07MB9585.eurprd07.prod.outlook.com (2603:10a6:10:49e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 05:09:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 05:09:06 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: no92 <leo@managarm.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Thread-Topic: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Thread-Index: AQHdAmNwkAevjAAd6025+Uh17c2vRbZK1QKAgAAlaoCAAJ2hAA==
Date: Tue, 23 Jun 2026 05:09:06 +0000
Message-ID: <bce49ece6d0cf679749df8b4ef659600834829e4.camel@bull.com>
References: <20260622162138.1045170-1-leo@managarm.org>
 <0b93c0b06c39f7dc6faa7ab21f57034081df83dd.camel@bull.com>
 <20260622154210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260622154210-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU2PR07MB9585:EE_
x-ms-office365-filtering-correlation-id: 8deaa017-33c3-4e8a-abc3-08ded0e58cf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4133799003|13003099007|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: bBkYRDG85dzWREr3n4tdy2pTDT++0UZKWYYiG9mcnWQLklH+0B3luvP1D/KbD5E1nqoScUDYlrfMMX5BK0iRKIboCi5gnXr7rRUEDk3n/0Zct0P4Z6ZvOPCtW08w9I7vXyCBQ2YU0+6+ktB1pyyiWl1gygYwdOCCoR2Ys9P6SMj3MBKdF6qPVf8t1+zYG/MfPeTKNUGKY7lkI69bnA9Zjh98L/mBQUuDTed7O71ay1ovonmTBMiLAYA4yWKKYuR0Lh/4jpVyqFqRyfL9UZY3MtcLHFNh0czqYlLngU9XkbzzUTiqMFI4dbDg7cd8RuW1MmXM8utVt3o2PCUQqGr4CZw48iOV18dgf1690O5fSdQp47nEIH4PWD0YtNYu0ua2vH2sUu/Cxt542sH3jmWaw0pnI7/qOSHLRwyUL1Hf1vXKDLY7sWaRZtnqygXYOmDzUla3J5VN2FidhVEat7pG7lh/b8/213KxsAO+rqQ87HNhzH7/WMRdqvzYG+YNJIhQkOw10Tdek3govKEWD3LJhy9zSfGYdpKWdaZwPjnOGnvd+q2G7uG9a0UWD/MqQdPMGpmjkN/xWbxTwJl1fTFP+4f+zlO/OPcoywyAtd+VPuZIpZqPJ5wFLQwLVmjRWDnpPjwFGEC9xTzjOwAoCJxDNi02BnbzCFoZuw21/ABGR2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4133799003)(13003099007)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjFOcGZJNGhXN1BtUVpFU3BzNlRDa1FIM2VPSmpJYXdZSTUxS1VWNExkRFlr?=
 =?utf-8?B?VnIzNjFMS1NIRFVUTklhelhhb2ZjUmo2WnZXVjdDWUU4RTVwQ0FBcEgzVWlM?=
 =?utf-8?B?RjRTWmJibzFETnIrcW1Jc21yOXRvSnBFd2s1aXJ3STRGSlkzaE9aaDhYZTlv?=
 =?utf-8?B?YmJpNHlVTTBsMXN0Z1hVTE9iV3dBMTF2OEYyUkhXVk91TGZpZnlQV096ZHlq?=
 =?utf-8?B?UEN1ZVE1Tnh6aWpRenVpKzZVaHlPRWVwOFdXa05JZ1Z2YzJpcVJnTVJjUjMy?=
 =?utf-8?B?UjJ6MHBIclhnNlhCWnZqQzVUSy90dXUzVlJDclZoa1pCNE9FRUNaTzU0cTlL?=
 =?utf-8?B?N0NYeWxZREF1d2hTVEpicEpQR3hBTHRnRjdOM2NQWUVFTTNqNDcvN2twZTk2?=
 =?utf-8?B?UjhXNkZKOVg0TTliOTg3VlMydDdqS29oSkJxYU5pR1BWbWl6Q2RHMW1ESEdH?=
 =?utf-8?B?amJQdS83d0I3R2JTTWRvY2ZyamMvOEVYSW1ERkhRbjY3RkxDNE51VTA5MnE5?=
 =?utf-8?B?SUwzKzF6Y0lNdXZqd2E3NHEzTHc1eWQ2V3l2MkZ1OEQ2ci9NTVBjbXVxWUk4?=
 =?utf-8?B?QWxySTlOUzhkWURrRnNyUkFkQjB6WHNySzA5cjg2R1g5cTc5dDdLWVdFZVh0?=
 =?utf-8?B?dk1WMkxkVFY2SjNkcXF1dUhmcGp5WEw3MGRPa0JKalBpUmZ0TlJSUUh4OFov?=
 =?utf-8?B?d0hZTmM4WkF6WkhsRnZwS3lJUGpiNXR2VjBKNFArZTRINUovVkY1TithcURJ?=
 =?utf-8?B?ekxhejAvQ21NRnUweDVhTThQeDdNM2orV0pjb0xyVnN2T3EvL3paQzRFUWo4?=
 =?utf-8?B?T21qTFlBYUV3R21DVFNlT1pkNVYyeGc4a0IrK2VyY1F4K2VocC9kNGwvUmds?=
 =?utf-8?B?VEJ1Q2xGeG90d0hZUVNUTC8wc21ZeTNsNjdqcnlNTVFDRHc5U29WOGJtazNS?=
 =?utf-8?B?eHk3Vk91ODgzeno1Y09BMEhCUkg3dVlPUU1HYm1VT1JtODNHaEV3VktZMjBV?=
 =?utf-8?B?Q1JacWVFL0xMdncxWTNXL0IycGk2RlZncHRlZ0x6OS9mMlF0VGRhM0RRdGhK?=
 =?utf-8?B?VEZtUkVFeUVHUkUrbXJsN3NJUXlhVUIveFIrczM3allPZlI2dWZVZi95N3Zv?=
 =?utf-8?B?M0hnL1ZNMDV2Vkt6b0xaZTRhbENySllza0Z0UUJRcFo2TmF6cWJTNmxVUkM3?=
 =?utf-8?B?UzdiR013cE54ZUxqYm02eEtFR3VlelVGb1RrdUJLR3ZxemYzUTYwU2FZTk9W?=
 =?utf-8?B?WU9lMHhzNVBlWHBPZzRjMFp3WmQ4YVdpVklmTDZxano4QlE0UGQ2T2tKQjhr?=
 =?utf-8?B?MVAyR0RIY2ZFSUt6Ykt2QnhkRllQZVNOeERaZzVWSEVwWjJ4VHhJT0RCTER0?=
 =?utf-8?B?M0JYaTI0c1kyejVQcHcvSE5qZllTdGxGQVZ5ZERLN2JZbWlObTZwUnI3WnRr?=
 =?utf-8?B?K200cW5zbkt2bEdnbE5reUV5L1pkaW5vSyt1N0c0eGVmTEFzZG8zbXdTTlBH?=
 =?utf-8?B?Qkl0a2laQ0p3ekZsRnAyMHVBdU4yaDFqUEoyazFJZzVKUUVwZUtJd21sakVX?=
 =?utf-8?B?cmpLaEhRcjVkNFM4OFdDbFZ2OHB4UEYvU0RxdW5wQVhTWDJ5WGJ3akc3WDVH?=
 =?utf-8?B?dzFlR0lFajdXNlJUZm1VV1A1T0RWa3hJbWZsNUFqd1lxUzh2MVM4UEpkS2ln?=
 =?utf-8?B?S0ZhanJKa2k1UGQ5QnBHUHlrNVRiT0c4RzIyZ0hPa3RSd01VUnQwSVRwdVlr?=
 =?utf-8?B?MEdmMzloenV4OFhiU25zc1lQemc5NmZvZGY3UmpCUFV2QkRtaUxUYittakRU?=
 =?utf-8?B?azNkYyt5QVA5WjMwRjJBZFFJNzJHdmVSN2trWFdBcEM0NFVjaGdsNWl2VjVY?=
 =?utf-8?B?alczK0dnWjNGQVhnNjhReGdGMVk1dnR4WEgrV0hGMENadUYzWUVjQUtMZDNq?=
 =?utf-8?B?Z0tQbm0vMFl2cEFxaFdvMlBNTTdsUkQ5L211aXJBQVN5L29uZ1RVemFKZUVa?=
 =?utf-8?B?QlNJZEdtMEZMT0FnNUNaZkdpOCtjcjN0c0J3a29zOTdTbVFBYXpRYlNwZEdD?=
 =?utf-8?B?RTljb04yWTA0a3dTeHZZR0hQNXQzcTE3V3ppeWlBeEl1cGpBVTU4L0RjYzlH?=
 =?utf-8?B?TDdpQmZ4eTdTbldMcE9HMWUvRWY2SkM1SjE5aDlBeW1WUTFDaUkxZmlSSno2?=
 =?utf-8?B?bHNkVXhQbUNQdFo1NGRpRXU1dEk1WXRLV0RyZ3BXQ0dWc09CaTZiaFV3bCti?=
 =?utf-8?B?a3BuNStQeE15Zk5MYml1bi81VWhaSjh1S2hkT09aTi93aExaZlg3YnVGOWlW?=
 =?utf-8?B?NW9SQ1YreEJvaSs3cmYvd25iaUE0dC90ZGpMOGlMb1diYzlmOURobHlBNlhG?=
 =?utf-8?Q?gfCStP/ZH28a09RWn7GElwoabENWxy5TRPitV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CF9B66092383A41B838191173667AE2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NM8PITdXUlPu3iLwL3KUteWRaM/HW4lOAkYuKg+P6zwpprQSBN12WcJMUNRjRMARni0rGf3CSdJKRkPy2/5g9WTgx/uJqEFneScFPq/bo2VFizXNC+pXiFif89Tj/t3iLnWXRCjrkU4Xwo8thWlsKeSz6iEPZqmL3jRJsDFtkw/OzcIZ07HVBIFOty0tpDnYZ6r/LT6ORr6otVF0NmpZY7OTCNr1xqpHXqR/1TN+4RGI888Y7Fa5ZbLKT+h9VqYc+FFVzzjdgAKP1adtGDx+eVEUB5uOP5L985M5fXaYdXxzcw0jDBMm+Tis27YqlA1v0TjlOj800W7dZibEebrwNg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deaa017-33c3-4e8a-abc3-08ded0e58cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 05:09:06.3975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sy4iD39JiOti7nVWqYciRFMqxDsRKd31W1RzCIOqC/QBW/95yQQstVKuHsd9c5YTIiU2JY7fzi2jdmxndmZN7heW4zNfVPIDQO9N1iohKwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9585
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIE1vbiwgMjAyNi0wNi0yMiBhdCAxNTo0NCAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVu
dHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBz
ZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9uIE1vbiwg
SnVuIDIyLCAyMDI2IGF0IDA1OjMxOjAxUE0gKzAwMDAsIENsw6ltZW50IE1BVEhJRVUtLURSSUYg
d3JvdGU6DQo+DQo+ID4gSGksDQo+ID4NCj4gPiBJIHRoaW5rIEkgaGF2ZSBzZWVuIHRoaXMgcGF0
Y2ggYXQgbGVhc3QgdHdpY2UgaW4gdGhlIGxpc3Qgby5PDQo+ID4NCj4gPiBJdCBzZWVtcyBpdCBo
YXMgbm90IGJlZW4gbWVyZ2VkIGludG8gbWFzdGVyIHlldCAoQE1pY2hhZWwsIGRvIHlvdSB3YW50
IG1lIHRvIHNlbmQgYSByZWJhc2VkIHZlcnNpb24/KS4NCj4NCj4NCj4gcmViYXNlZCBvciBub3Qs
IEkgd2FzIG5vdCBDQydkLg0KPg0KDQpVaCwgaW5kZWVkLg0KDQpQaWNrIHdoaWNoZXZlciBvbmUg
eW91IHdhbnQsIG5vdCBhIGJpZyBkZWFsLg0KDQpJbiBhbGwgY2FzZXM6DQpSZXZpZXdlZC1ieTog
Q2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQoN
ClRoYW5rcyBNaWNoYWVsDQoNCj4NCj4NCj4gPiBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VL0NB
RkZFMmF2ckhES1pkNW03ajNFM3g1PUY9cHpuLTNjOXZ6R1dQMys5LUFWUHdRbmc3d0BtYWlsLmdt
YWlsLmNvbS9dKGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9DQUZGRTJhdnJIREtaZDVtN2ozRTN4
NT1GPXB6bi0zYzl2ekdXUDMrOS1BVlB3UW5nN3dAbWFpbC5nbWFpbC5jb20vKQ0KPiA+DQo+ID4g
VGhhbmtzIGZvciB0aGUgZWZmb3J0IHRob3VnaCA7KQ0KPiA+DQo+ID4gY21kDQo+DQo+DQo+IGkg
Y2FuIHBpY2sgdGhpcyBvbmUgb3Igd2FpdCBmb3IgeW91ciBwYXRjaC4NCj4NCj4NCj4NCj4gPiBP
biBNb24sIDIwMjYtMDYtMjIgYXQgMTg6MjEgKzAyMDAsIG5vOTIgd3JvdGU6DQo+ID4NCj4gPiA+
IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGlj
ayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gV2l0aCB0
aGUgY2hhbmdlcyBpbiBjN2IyZTIyYmQ5NTcsIHRoZSBgcHRgIGJpdCB3YXMgc2V0IGluIHRoZSAo
d3JvbmcpDQo+ID4gPiBjYXBhYmlsaXR5IHJlZ2lzdGVyLCBpbnN0ZWFkIG9mIHRoZSAoY29ycmVj
dCkgZXh0ZW5kZWQgY2FwYWJpbGl0eQ0KPiA+ID4gcmVnaXN0ZXIuDQo+ID4gPg0KPiA+ID4gRml4
ZXM6IGM3YjJlMjJiZDk1NzEwZTQwNGMzOTNlOWY1NjNjZmU3NDA0MjIwYzEgKCJody9pMzg2L3g4
Ni1pb21tdTogUmVtb3ZlIFg4NklPTU1VU3RhdGU6OnB0X3N1cHBvcnRlZCBmaWVsZCIpDQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBubzkyIDxbW2xlb0BtYW5hZ2FybS5vcmddKG1haWx0bzpsZW9AbWFu
YWdhcm0ub3JnKV0obWFpbHRvOltsZW9AbWFuYWdhcm0ub3JnXShtYWlsdG86bGVvQG1hbmFnYXJt
Lm9yZykpPg0KPiA+ID4gLS0tDQo+ID4gPiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNCArKy0t
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiBpbmRleCA3NDRjZGZkMmU2Li5kMWFmN2EzMTM1IDEwMDY0
NA0KPiA+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4gPiA+IEBAIC00OTg4LDcgKzQ5ODgsNyBAQCBzdGF0aWMgdm9pZCB2
dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiA+ID4gIHsNCj4gPiA+ICAgICAgWDg2
SU9NTVVTdGF0ZSAqeDg2X2lvbW11ID0gWDg2X0lPTU1VX0RFVklDRShzKTsNCj4gPiA+DQo+ID4g
PiAtICAgIHMtPmNhcCA9IFZURF9DQVBfRlJPIHwgVlREX0NBUF9ORlIgfCBWVERfQ0FQX05EIHwg
VlREX0VDQVBfUFQgfA0KPiA+ID4gKyAgICBzLT5jYXAgPSBWVERfQ0FQX0ZSTyB8IFZURF9DQVBf
TkZSIHwgVlREX0NBUF9ORCB8DQo+ID4gPiAgICAgICAgICAgICAgIFZURF9DQVBfTUFNViB8IFZU
RF9DQVBfUFNJIHwgVlREX0NBUF9TU0xQUyB8IFZURF9DQVBfRFJBSU4gfA0KPiA+ID4gICAgICAg
ICAgICAgICBWVERfQ0FQX0VTUlRQUyB8IFZURF9DQVBfTUdBVyhzLT5hd19iaXRzKTsNCj4gPiA+
ICAgICAgaWYgKHg4Nl9pb21tdS0+ZG1hX3RyYW5zbGF0aW9uKSB7DQo+ID4gPiBAQCAtNDk5OSw3
ICs0OTk5LDcgQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHMtPmNhcCB8PSBWVERfQ0FQX1NBR0FXXzQ4Yml0
Ow0KPiA+ID4gICAgICAgICAgICAgIH0NCj4gPiA+ICAgICAgfQ0KPiA+ID4gLSAgICBzLT5lY2Fw
ID0gVlREX0VDQVBfUUkgfCBWVERfRUNBUF9JUk87DQo+ID4gPiArICAgIHMtPmVjYXAgPSBWVERf
RUNBUF9RSSB8IFZURF9FQ0FQX0lSTyB8IFZURF9FQ0FQX1BUOw0KPiA+ID4NCj4gPiA+ICAgICAg
aWYgKHg4Nl9pb21tdV9pcl9zdXBwb3J0ZWQoeDg2X2lvbW11KSkgew0KPiA+ID4gICAgICAgICAg
cy0+ZWNhcCB8PSBWVERfRUNBUF9JUiB8IFZURF9FQ0FQX01ITVY7DQo+ID4gPiAtLQ0KPiA+ID4g
Mi41NC4wDQo+ID4gPg0KPiA+DQo+DQo+DQo=

