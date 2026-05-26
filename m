Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C398CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRr2P-0006Ev-RD; Tue, 26 May 2026 08:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRr1o-0006DS-VN; Tue, 26 May 2026 08:37:09 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRr1n-0002Tx-0x; Tue, 26 May 2026 08:37:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OscIACRsPbestwiek9Y6K2DSzusY+5K3PVMf0ouklFvshEi9xCXTJ/rlT+xPFwy9s/XZXotZb3yROPP4qy3wO5Rach/PrIEmrPiw2n5jseWH9GoFgDcu9GQsnnp2YIr8p/xNhVLF16GmSJWY8mn2yy2hedz/ZDfufK25vw9xA+KHgjGkataN33tJDRl1aPil21TGbrBA7yMkW6R9bdRIczXjorwiKo9oHyayj8nCEEREwglQqNol3y3QDK9UULo45iIgplfyDJNnHvPEb0CLktTqz73y7hE6MGBNcHjl4ao+VAR3yLej9lzvS2k7fAipu7SGY46zQf2VMnvIx/f5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxv3YfPgdyS+I8dtrW1f6kyoTxEg8FYI6JW/y0Iz9Zs=;
 b=ftfKCUFD9mayT4DJp1Bo301YmgVEhr0jisk7ZLZfNTE9Fv9gv5B88LSPWvG8wHKHBqvvam1c+cxG68T3n6ktx5gN3SXBWFgyCRvvXENUdGiYyAksnCeh2lbaiMagrJJDdK3Z50oZFl1zc4TbG0OULt8yn/hc4bpd8a9moi5PCCyAbKAtXddtot9p8NJke27bt+v41jYud81WZyWMvkn1kOEVb/7/kvEPHHwBms3uC24PWe+86S9A10BYoNSQya3GJcLS3xoiOA1MfC/gCVujr+lFLBGeeyMuMy7Gu0VJOx2p88mihCO5/tAeZLk7UKR/Wk3i+BH35GOtqhWAHRuLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxv3YfPgdyS+I8dtrW1f6kyoTxEg8FYI6JW/y0Iz9Zs=;
 b=g6e2M88+QRwUZ9tf/trTS5sr48AQ9KwTht/BJWt/k4avdxy5vHqrst7VcB1bhBjkBjPzQBL7QyPp6P/J3YDYfIkIkF5GYuFD3o5bY9tixQkcxFoAJXG/x3I32l/7txZTsHg2Uk//YqqNkIi2m2UvTBcbHrbm7jw1pUUH29MeO9nTK1wFqw72crlsaRH9nAfiYonSat/OobasVzBsUWwNh7NSHgv9AK5NvI5889W0YTcVmsuMpNPnV+xgd3eW/BxDUvFonGlItfJtpTF9yUNPO2i5h9G8l7YELC3lZikc7DXWhXvBhazxFBahK++xGva/xmRGJWiojBj1f3JAn1WkAA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 12:36:52 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 12:36:52 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 31/32] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Thread-Topic: [PATCH v5 31/32] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Thread-Index: AQHc53v5gxRmnJXzvEWUPrztzqci6bYgQfaAgAAHjhA=
Date: Tue, 26 May 2026 12:36:52 +0000
Message-ID: <CH3PR12MB7548F470992DA008B6EC0E5BAB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-32-skolothumtho@nvidia.com>
 <ff0c7dda-5694-4635-a75c-5ae6b83623c5@redhat.com>
In-Reply-To: <ff0c7dda-5694-4635-a75c-5ae6b83623c5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7267:EE_
x-ms-office365-filtering-correlation-id: cdd713a7-6599-4e43-be3e-08debb2376a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|6133799003|22082099003|56012099003|18002099003|4143699003|11063799006;
x-microsoft-antispam-message-info: 23bjb3a7wEukT4V9qhWgLVScD6FdPXo9BZbR/5s/T/BDK9h5kXx9iPgW4VjFVeofJ6YUxKyQCTibfF7rvsFXaJZhbM7RHvx25u++jHB1KKb5q6KKcCdP7QhkESOXmdDExRpQEBAyVmbc2vJRSSNniypHPqFbJpFBAnErx/ciHLCehrd1LvVQdL9KTMLzHEPwr7b7hsU44bpSwf76q35rOX8QQ2CaXZu6anE8xs8C/lAjirF0nPx9PoNDxBiqTSNj7QFKYWreXzXbOoRDQJCDK0OE/NmIKP6Sxv09JW1EXTx3jyaNU7qzpxlN6TUQO1TDY2U8WK8I4/Mh9/AYvnvzr/SA8+e9vRNFofRZbaOcXj/jJhHShbQ8DPZkuNCrWSopD4n1YkmO1rxEyPzOUGSH0aUZIUw/9xs/VuLocI8d+9+CxAy+O29UK+HCWwTtUi8Foi4Fy+Jb4w/HQRG2jX5knZoqJsuDo1cIboWS8E05lIOSKf/T63VapEgAXoj52GEyZauTfnIMJ6fHr3vGRqQXCV//3U/7F/Ysf9inJzXbyrjkt3iGuRpHVoxOzSLaT8Ut3iHjYqJvUKrdN6r7nGY+HhA00qI/blCd/vAzqrP+7gAfsB8x1thOU43xjEavqN4RlLO/niijQKTcXYi8u2lU5nV42ybOo1YszxJA7Yki5zY0HHcmTnncIvNSCKBsxnqXA6QLMDOuWx51oGK0CKssqsLucySD0SOq0bgPXnaU9S34W7P8W4Kw9zPtMj8IXA1O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(6133799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OER5QkNaZFhBZ0grZkt6VUYxV3BuL0szZUZaYVdwWFF6aldwS2U4SnRKWUpX?=
 =?utf-8?B?V0x5bm1jTmx6YmZ4NlpDR2xsYjRnbXk3ZnU0K0QxWG1tSWxjRmswb1lFYnBm?=
 =?utf-8?B?NXlLeWVBRHFub0FvZHJvbG9HUnNaSyt4Nk5jZVdydnVqYnJwR2NOODBFdWZC?=
 =?utf-8?B?UXVLdGZ0SXNuQUt6UDNUb2QvSXZNQldXSnk4U2xPMnIweUJpb2VKMSs3RWtV?=
 =?utf-8?B?cHhGWFIyK2EvQ3NON2ZXTzB0UVI5YXk2Q01ZU3V4VkdQNUNZc2ZiYmNkVHZl?=
 =?utf-8?B?VVFmcFp3c2ZsS1ZQSzJJdjE0ak5sNXhEUUhUN3IzMklKK2h1ZlJUOVIwUzFE?=
 =?utf-8?B?c0RKYSt0aGdndEVuaVpXSlE1blVpSVFldTVlZmxQVkY3WlZIVzBRK3UzaVdi?=
 =?utf-8?B?RHBOZ0J0enVWbHQxOWN6QzJPSGVkOElqaGl3QnlLVGpYSlZseThsb0hvcnNv?=
 =?utf-8?B?WEFSOHNFOGdoMkNqN3ZFaE04SVZoUFhVNkV0UGEremdDWWV5em9rYnNJTGI3?=
 =?utf-8?B?QmIyUlZFTGVtTlB1VXNrL1J3TThKeXFCV2lZTWdTSzVieUdlZzVwWTNSM3Rj?=
 =?utf-8?B?MEZIanpSTVpoRjQxNG9NT1FpVFBpYklsYXlOUjBjUFkvNjYxbWxmZzVrV1R5?=
 =?utf-8?B?RVdBSUN3S2x1M3k5cG0yVHJZRW1mM3dBMVY0ODI0RThhU1RjSTdGanlhVU1y?=
 =?utf-8?B?QnAwakZudlFmMzFLcFo0eDFSaXJhL2pKQmtobVhXdGt6OXcwUTBER0l2RUkz?=
 =?utf-8?B?OW1ZeWtqMnVUUTA3c0Y2ZWQ5Q3ZEQmRVZlJocmxkZitiSEN1Q2kza05IUWhn?=
 =?utf-8?B?azZDV3RtMDJCTmpFUEVEdXR3QTBZa01ZbDZWY1VvUjFBSW1iSkplLzNXNDNE?=
 =?utf-8?B?c3ByVUgvbE5zTXZXMWlCeDkzWmhqODRBd0thM3ZIek1BUk4xQkYvN1o0NjA4?=
 =?utf-8?B?WlI2SUdJSzBkNURvVlNHQjg2cTBmUFpweXgybGJBanBBMDE4NXBxSXV1RFV6?=
 =?utf-8?B?NWorWnFGbUhsMWlidlE0Uzl6UE5aR2lJQ0JSRkw2RW1NS2d6OTd4N2kreFln?=
 =?utf-8?B?WDJpd1BPS2pveGoyd29aVXoyVmdVNUxrVUYzc1BjWWJFTm9rQjJZbXBJbnN1?=
 =?utf-8?B?clZ3c3QrU2xyODZhY3NmOXdLWEdadjhDWDB4V2VLeThHam9CQ2wrY0FkbkFs?=
 =?utf-8?B?aFVSK084MVM3ejZuR1d1eG9weVREd0txMWZSZTNZMXIvNlgrYkJtcnpSVWxR?=
 =?utf-8?B?VXVNbEZnVzhBMHlVd21wcTRETU5LQVNOVmo4dnJDTmpNanA2TURabWwzaGc1?=
 =?utf-8?B?bS9ScTVpT0x1Y0VzN2xqOXNHOXRXcHRqOTI3b3pPT0dsWVZlWTBkOEFXRUJT?=
 =?utf-8?B?aUdQN051T1hYVURKVzZ4M3pZWFZYWk9UaThEMkx6QjJ1S1ZFK2lRTzFHcDZR?=
 =?utf-8?B?eUZDdlhUU2c5NzJMa2E0d0xPRm43SjQ0U014K2ROQ0hEWkR5dDlpTSt1R294?=
 =?utf-8?B?aGE5Qy84ekZCR29DQjhyMHBWWmN5ejYwaU1PL1Y5M3A2cjNpbXVVVGFRbDIw?=
 =?utf-8?B?TmY1bTdCREZaTjRaVmo4eHczTUxsdlRBZXVFVmNLQytsS0ROT3RuM1h2eXYx?=
 =?utf-8?B?THUyc2JLaE1xZ2VVM3hsL3FaKzFiSisvNjhjVENidFdLMXJjOTFTYVBJR3dF?=
 =?utf-8?B?MWQ4OFdtUDhzZjFkSVc2aDBOUTRQamtYSTRBOVBQMjR6c3JSejF6YVZ3T21x?=
 =?utf-8?B?d3VxeUxFWktDa204YlFLU0lPWnhuZTUwNmZhVkVLSU5wNUdMc3dUSDhpYzBS?=
 =?utf-8?B?cGhJZ0NyUkw3dVdlNVNLTFFlWGJBM3h1ejVHK3FvSU5PbStkdXZEQytMYXJu?=
 =?utf-8?B?VFlzN3ZweXQrR2hHeVpNWDQzaEp4dzE1MTJIWm1naUZGOEtscFBrM0lEVGR3?=
 =?utf-8?B?QU42ZXJnRlNRQ2hqSmcyK2VWbDhzZllvL0l1bzc0bHVDSmNwSTZ4RDQzY3c3?=
 =?utf-8?B?bEhEQUpXdWtqQk9TQ255WWxPckRGSnF4ajJYeUwrUVpHOFlwSmVnMEkzemt5?=
 =?utf-8?B?OUcrWG1ZcjRlb1pOZWdiaVRDZk1PWFVDU2FsdFFJZW1rRFkvZktBR3NJOFk1?=
 =?utf-8?B?Q09EelJmMjRyNGdxcElNd2J5UUsrOHdwck1XcU1QWTJHaHRvb1JuTEJPb1o0?=
 =?utf-8?B?MzgrRGRJL2NleGFEUVZ5c3dKMitRM2hOVUoxNnY0NWNBbXhTYmVCSUFhS3ZN?=
 =?utf-8?B?VEhmYk0zalpDZkd1UWYxK1N5cjhQYUsycS8vWDNYYkxKMXMxVTFVUnpnSnpl?=
 =?utf-8?B?YjdpRGdNelk0b0pId0pmUlJBb2lQa2hCcGU3VnRQZGRNcURnbmprZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd713a7-6599-4e43-be3e-08debb2376a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 12:36:52.0862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVI2rSYHISVwz1CkpH9oClne/RuzYq13uAXtmvWPddXBHg/wc4SEyOvwrlbcnNyD5XHXIrrJ4+pITiW6WCG9aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNiBNYXkgMjAyNiAxMzowOQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAzMS8zMl0gaHcvYXJt
L3NtbXV2My1hY2NlbDogRW5mb3JjZSB2aW9tbXUNCj4gYXNzb2NpYXRpb24gd2hlbiBDTURRViBp
cyBhY3RpdmUNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gNS8xOS8yNiAxMjozNyBQTSwgU2hhbWVlciBL
b2xvdGh1bSB3cm90ZToNCj4gPiBXaGVuIENNRFFWIGlzIGFjdGl2ZSwgdGhlIGZpcnN0IGNvbGQt
cGx1Z2dlZCBWRklPIGRldmljZSBlc3RhYmxpc2hlcw0KPiA+IHRoZSB2aW9tbXUgdG8gaG9zdCBT
TU1VdjMgYXNzb2NpYXRpb24uIEJsb2NrIGl0cyBob3QtdW5wbHVnIHRvDQo+ID4gcHJlc2VydmUg
dGhpcyBhc3NvY2lhdGlvbiBhbmQgdGhlIGd1ZXN0J3MgYm9vdCB0aW1lIENNRFFWIGNvbmZpZ3Vy
YXRpb24uDQo+ID4NCj4gPiBBbHNvIGFib3J0IGF0IG1hY2hpbmVfZG9uZSBpZiBjbWRxdj1vbiBp
cyByZXF1ZXN0ZWQgYnV0IG5vDQo+ID4gY29sZC1wbHVnZ2VkIFZGSU8gZGV2aWNlIHdhcyBwcmVz
ZW50IHRvIGluaXRpYWxpemUgaXQuDQo+IA0KPiBUbyBtZSB0aGlzIGlzIHN0aWxsIG1pc3Npbmcg
dGhlICJ3aHkiLCBzb21ldGhpbmcgYWxvbmcgd2hhdCB5b3UgcHV0IGluDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC9JQTBQUjEyTUI3NTU1MTU5MjRBRDcwQTI3M0I3ODc5QTFBQjNEDQo+
IDJASUEwUFIxMk1CNzU1NS5uYW1wcmQxMi5wcm9kLm91dGxvb2suY29tLw0KDQpPay4gSSB3aWxs
IHN1bW1hcmlzZSB0aGF0IGFuZCBhZGQgaW50byB0aGlzIGNvbW1pdCBtc2cuDQoNClRoYW5rcywN
ClNoYW1lZXINCg0K

