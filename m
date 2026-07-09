Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8C5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 04:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whgQa-0003CY-JA; Thu, 09 Jul 2026 00:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucien.murray-pitts@siemens.com>)
 id 1whdNM-0003A6-AL; Wed, 08 Jul 2026 21:16:28 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucien.murray-pitts@siemens.com>)
 id 1whdNJ-0001Lt-EU; Wed, 08 Jul 2026 21:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETiQwa41qUHV58uAHRuiKmY2XBA+rb00O55a9XzztHuBHX0LAmO7IT6WlxIb0bzFMbIZyM/Oh3GPKQV6c5naxtX5AwG1kIM/j2qWKLqjC0+8w8aoUwe966POOTvvA+/7o5NFsVLC0RNirqew6MbxCrZBUKRYv6NxRpD9qmyo+WggIPIhrvYOIa/1VSL4nYvCNPrv5M4RXF+jCmBcidlZZIZTahX/WM4DhtC9N0B7QqLcuSBLv96mHdZOowg7HgrMMb1ZqDl62x+9PCIivGIVzJNXzbjk1thO0L3lH39GFGSF2+GC9X7kPp/gFOmUBZn7xhYADFSxp45MY/Bbve2j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUUzqF4gbYNiiSvIDHGoFzXfinFT3vW13ZQcTwK9CZ4=;
 b=N9mXmsnam+s+wYqbsoF0Bx5LB7sUHfZLgqJI0HUd8Ri5zJe1sCHm2NveiNkBQzNm6yhUbQWAVa+aBMH3T+rVHbJgDGOFBK1NENO8SP2JgbzjhPSBFwdl4Re8NZE9jGvCTGXqEqW9f75Mo9KUtQ35J6KNNuwTDcrLFVdi8ribWiBaPpEUb+5x/n4QRzGpWoJvShHJMe/qXh2bvxItb5YzJ220MtztcL2qT/AdcRGHVSzX5ybfHZ6rI1SEmG7rbJeXBwfkxZvLO1DNZB8HO/1FjvYVO2uw3s8iM131U7ybNAcFHBV+qWwRl8BJ+VnQfybuMlaOz+X13uTL/RiB9G5Cjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUUzqF4gbYNiiSvIDHGoFzXfinFT3vW13ZQcTwK9CZ4=;
 b=uyqHgIAYtAslZqPjndefSG9yrHK5MSeGBeRbIGKOs++aPBBpQhfCkmEaaKo8eNNK6jkLw1I6vcSMnutmWyLUY53wd8K/6KHqXwxiGmf6cgS6dlOw2ryNOS1JcK1ZVliLUQVwIUK+ezelnjeHiO/COX19O+D9LRNTOVGMbiB5VY64Knw11vsX07gThYJwtnmL5OpQMCAVWy3xJMKowqadLe5v+kOZ5xeZ6vXifeQPBoqyPSCgZsCuVqfwy4ZtbfdmDi7yI5jFqxhlClTowdz6sjfLa6hhV2Y97g3RYriFiUXqraNJNxehPt75lyGM/uY1y0GmWozkm7W525msFxWWdg==
Received: from PUZPR06MB5618.apcprd06.prod.outlook.com (2603:1096:301:e8::9)
 by KUYPR06MB8841.apcprd06.prod.outlook.com (2603:1096:d10:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 01:16:16 +0000
Received: from PUZPR06MB5618.apcprd06.prod.outlook.com
 ([fe80::e58c:5a72:1e0d:2df6]) by PUZPR06MB5618.apcprd06.prod.outlook.com
 ([fe80::e58c:5a72:1e0d:2df6%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 01:16:16 +0000
From: "Murray-Pitts, Lucien" <lucien.murray-pitts@siemens.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Nabih Estefan <nabihestefan@google.com>, Joe Komlodi
 <komlodi@google.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support
 for AST2700
Thread-Topic: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHdDrsB0PfBWMtPU0KIoukeQI21FLZkPUyAgAAhSYCAAAInQIAAAcfg
Date: Thu, 9 Jul 2026 01:16:16 +0000
Message-ID: <PUZPR06MB56188114958529179B1BB185AEFE2@PUZPR06MB5618.apcprd06.prod.outlook.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
 <3d2d869c-d1a0-40d1-83c2-755c080bd17d@oss.qualcomm.com>
 <TYZPR06MB4980E558390882926C5263ABFCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
 <TYZPR06MB4980C0620EBAB68031639EB2FCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
In-Reply-To: <TYZPR06MB4980C0620EBAB68031639EB2FCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d287feb2-f2df-4361-abf6-240bd501e101;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-07-09T01:12:19Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5618:EE_|KUYPR06MB8841:EE_
x-ms-office365-filtering-correlation-id: 9e09fc91-f8b5-45fc-0257-08dedd57aca7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003|55112099003|921020|38070700021;
x-microsoft-antispam-message-info: avQs6nWLmDNkfkGgVkDzqUxR21AhAY+oVfL1rN4QG2BdvhUpGyF05fs02b6G0zc5FtvLK3Y6mP+Ks2xTdO4qig4jkEOQgHbDo6l14AJEII/QxXntyiwbtS9w1tT+YaflUgEzsocFWdw4vpEzbK4oy2VlSqk0OYXaAjF6tS6484WO8nQWGQatVYdzCJLo08/2eL/UDvTCSwcrA00mNHWHJoov0Bt3kO4v6El7Z7y/wWIdFHts9pla1Q51erkGLI3TogyqXv7yzWsq+oL88GYXBFyRd6DVYQU8WtSe8vtxd06WRbCD2lDtG7feEAK4HvG6M/zzn4Thqp96NCfsORDv9tCjZaeLSR8tULMMQlzdhu6xJT59TB5JZl4EwKM7vTgLYjpLxfHMUXP/VBp5hIHf5Ityq+RW+R9xLGzuVqspesf+KM85CYpM8LArQg2yd6waQbffg1StiCJzPXnOHmwC97xRxOKFQtru9ZC+DVfUCqrdhwgYUMalS8c/Zw550wykGyP0yxP9XOaRGDDmWaZP0ssFUQMcduAlIfOh/KsPpcWxCY8qyzbiAVOsvwrieITX4dkcGDiRO0ogRaEwsiYRWir51645ZLtH7itW1QCvzihGFAwoaS95xaOe52z1z3HhGQhk1bXyG6bsiMWWKcoemcHiSENtcm6ya3LaWZYOUafMM4vUxate9Snw0DLtKhM0t4Kd00gKzqueZqdEM2jLzfFrlWdCBjWvfZ20eOUfDIInugS9OQ9An5sRiZ6Cw4G2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB5618.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkNpbzBQWHJKNUV6YVcrRU5FY3c0T0o3NU1CeENRR0NIallSZkRkZE1sTXlY?=
 =?utf-8?B?YmJKMjk4YUtKdnZ0SWJaUy8vL05vQlZwNzRSSEJqcUN5Q21mWitISEZEazRK?=
 =?utf-8?B?UXhpOHY0OGxiNHE0S2JUTUVaU2E0dHAwUlJST2QzMzlEUzdTbDhCRnlnR1Vv?=
 =?utf-8?B?d21lVHdxZEhFQkVpU0xkL1ZjRzVvbUVmV2wrU3RLdGtqN2pXT3VhZnVYaVM5?=
 =?utf-8?B?LzZiNjhSRHd6YmJVZnFTR2pZZGJHRnZ2SHZmR0l0UVcrWUhPTjRRdWhkZHNr?=
 =?utf-8?B?UisyYzdoMUs3WTZxbUloN0t3c3NtSVRtM3FOODNLQnMwM1NxZ0xWbitCL0Rt?=
 =?utf-8?B?cC95eHdDRE1meXB1K3NQOGplQ1VVaDFMUXRoMGpmOERRZElLbVVmMFl0ZS90?=
 =?utf-8?B?QlNFSHRmZWlPZ3VFNlhraG81emkwaXJIQW15cjJqNDZnSzJ2Wi9BMlJtTllH?=
 =?utf-8?B?RGlyclhhTTFRSFNiWXdkR3hFNWRvWnhVelVPR3BHUE5BT1F4NHplK29UL0Jz?=
 =?utf-8?B?dkhRd3dxSllXQVk5bW1yNmtVS3B3ek5uMkpaZW9HbDd4N0QvVC81TXNTaVBR?=
 =?utf-8?B?S1FsNVBHOWRZTkY3T3NoQ1pQdGNrK3VJWjlXSitxeG43ZXpTY2JyWGk0K3FC?=
 =?utf-8?B?b0dKa3NBTEE0eG9SSzRKYnRXRG85WWpIU2hMQS9zQWlkWGJJbzdkcUNQYjg5?=
 =?utf-8?B?c0V4NFc2Z2NOK2VUZlBrdGNsOHVSK012WXBnbjBzcEJtR3FZdDd3dzVWdHRV?=
 =?utf-8?B?MHpwbnBrMzR4aUhiUFZvODdyaVc1bnVSSm42TEt3SThMVEkwSXU1a3duc2xQ?=
 =?utf-8?B?dWNyamdvTUE0bE9tVlNsemNsN04rS0RJMlc5RmxpMStCU1ArZm1aemdjdysw?=
 =?utf-8?B?MlY3V1g3UDFIcHNuNTg3ZjRla1hLU0t1YWZBTWFSWjc0ZnBRbThiMklqSkZQ?=
 =?utf-8?B?N2N5YUw5bWJRQm9aZTdIV0lHdEFOYkZPNk5mbXJ4OWxqQ2xuK1V3VUNmYVJ0?=
 =?utf-8?B?aHBYTlMya1V4VHJObXJLZHNKTUdLZ1RmR2lCazNSTWRRaDQ2QTFHVkxFRlFM?=
 =?utf-8?B?MGdhZm5CbHZFbzRnRG1Sd3hjZHQ1UklFUG91SUVBckFMdGhWc2xrMGhuN1E2?=
 =?utf-8?B?MVdFU0M3TVJvQjlSY3daaUVwdjUxYVlTU3FITEVSMENxQWJCck1xNXdUT3hK?=
 =?utf-8?B?Tzh2b2lKQndma0dPS1J3blRTNDZhcWdtTUtLdzdFSlVBdmw2QkpJV2dQZERR?=
 =?utf-8?B?OWxuSkN5Sml4ODhyTGFGRmFoem5Yblk2Y1BQZVkwNzdpd0kwS21SeFovZ2ls?=
 =?utf-8?B?SFlIdWt5VDdMUTNQZUJkWTZiaE96OUFsYXRKK096RG9oaDlsMkdJRndNY3FF?=
 =?utf-8?B?c3MwWmtnMUlOYUZ4RjZqRFVxa3ZvcVdFSEx5RDZyb3ljQy9vdk84Ujg1WUFq?=
 =?utf-8?B?TktwYU93bmp3ekpTY1pqbGVJY3pMaG9jQ2JUYVBIeXRQN0djUHpUbk03cUsx?=
 =?utf-8?B?cnJGMmVuVS9qL21PRDUxQnlwaXRNZ0gvVzR2ajZaU2YzMnhNSWozb0xKMG1U?=
 =?utf-8?B?aUxxNTlYdk8zbFN4bHNvV2VtWG0ySkZZOE1NMGZLVTBWVW1aTG9jaWRSWmxM?=
 =?utf-8?B?ekE1OW0raTZrRVdmaVVqWEUwbUI1TFFTOTJKSWtHOVphS3Z3MmZrSUxDRDl3?=
 =?utf-8?B?RW9BZGJ2SFpPYzYvR1JMWnowanFoMEkrd2tHTTBmOUNleHNubmd0QmhjVzVV?=
 =?utf-8?B?OWMrVFRBb0FTd0d4NTdYcFc5d2UxbDZPemFIV01yYUk1V2Y5a1RmNmo4NVI1?=
 =?utf-8?B?ZzJmR2NIV0dNbnRrZEZPOWo0cDdkMitIeGZCeHk4SThGYnB0S3hNTnNLeUJu?=
 =?utf-8?B?T2VqbWNkRXovSFp3MW01dURzUFdEWWlDQ2JLcGcrWmhvQ3dVT3VlMXMzVWhQ?=
 =?utf-8?B?QVU3NnVCRUMxcE5aUzd1TFA4amw5cUZDZG5rYklWdWVIT0hhUjIzdTNwZVhp?=
 =?utf-8?B?bXRwVS9ENFdkdHVOVER3dCs1dzJ6TzdMUmMxREplTzNjbmV3bFpITDJiZEpQ?=
 =?utf-8?B?YmpsWUlmVHlxaHNCVVpIYnNSdHVJU1I3a1ZQZDV3NlhvdzFWZ0RYaFFTYi9W?=
 =?utf-8?B?TTZ5aU5zdm9nYU5oRHNkNmdCTFd2ME9pN1NERFVKc2U3N0xsYWFtcUFkSk9M?=
 =?utf-8?B?d0l2dmh3dmNleGNPOW9uYUdTN3RmMzVBYnp1UHR2REdLU2w5N2o4dGkzU3Fj?=
 =?utf-8?B?UC9aeVpKL3VMdVJTVWZEUUg0N3dWbUVDRFRNK1RQRHRMYUFuUVpsQ3h1VjBQ?=
 =?utf-8?B?eFc2b2tsby9tVmRHRDM0bEdxbzVpcVNrd2k1V2JHalFielhmb3Avb05Sejdx?=
 =?utf-8?Q?iHQ99Dtrs+ji1zPw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5618.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e09fc91-f8b5-45fc-0257-08dedd57aca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 01:16:16.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNWkAS+IiGnuF2QQq/aTKWuseJqkY5aLfsYDEE3Q3e/ZCmxGjHDmdf7EYqpOfc+QiCf+SyggVIS7RvtshaSwHDF00n96clZzefxyRNje4xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8841
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=lucien.murray-pitts@siemens.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Jul 2026 00:31:59 -0400
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

SGkgSmFtaW4sDQoNCj4gQXMgZmFyIGFzIEkga25vdywgeW91IGhhdmUgaW1wbGVtZW50ZWQgc3Vw
cG9ydCBmb3IgdGhlIEkzQyBIQ0kgY29udHJvbGxlciBvbiB0aGUgQVNUMjcwMCBwbGF0Zm9ybSwg
YW5kIGl0IGFwcGVhcnMgdG8gd29yayB3ZWxsIGluIHlvdXIgbG9jYWwgUUVNVSBlbnZpcm9ubWVu
dC4NCg0KVGhlIG1vZGVsIHdlIHdyb3RlIHdhcyBhZ2FpbnN0IHRoZSBMaW51eCBrZXJuZWwgZHJp
dmVycyBzcGVjaWZpYyB0byB0aGUgQVNUMjcwMCBrZXJuZWwgZHJpdmVycyB3ZSBzZWUgYW5kIGFy
ZSBub3QgZ2VuZXJpYyBIQ0kgdmVyc2lvbnMuDQoNCldlIGhhdmUgZGlzY3Vzc2VkIGl0IGJ1dCB3
ZXJlbuKAmXQgbWFraW5nIGEgaHVnZSBydXNoIGJlY2F1c2Ugb2YgaW50ZXJuYWwgcHJvY2VzcyBv
ZiB1cHN0cmVhbWluZyBmcm9tIHRha2luZyB0aW1lLg0KSWYgdGhhdOKAmXMgdXNlZnVsIGFuZCAg
aWYgdGhlc2UgYXJlIGFoZWFkIG9mIG90aGVycyBpbiB0aGlzIHRocmVhZCBJIGNhbiBleHBlZGl0
ZSB0aGUgd29yayBvZiB1cHN0cmVhbWluZyAtIHBsZWFzZSBsZSBtZSBrbm93IHlvdXIgcHJpb3Jp
dGllcyBmb3IgdGhhdC4NCg0KQ2hlZXJzLA0KTHVjDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4gDQpTZW50OiBU
aHVyc2RheSwgSnVseSA5LCAyMDI2IDEwOjExIEFNDQpUbzogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPjsgQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9k
Lm9yZz47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBM
ZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVldHJveUBnbWFpbC5j
b20+OyBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldyBKZWZmZXJ5
IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlk
LmF1PjsgUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
Pjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0
OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IE5hYmloIEVzdGVm
YW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPjsgSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xl
LmNvbT47IE11cnJheS1QaXR0cywgTHVjaWVuIChESSBTVyBFREEgSEFWIFNMU1BFKSA8bHVjaWVu
Lm11cnJheS1waXR0c0BzaWVtZW5zLmNvbT4NCkNjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVk
dGVjaC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIIHY1IDAwLzEwXSBBZGQgU1NQL1RTUCBwb3dl
ciBjb250cm9sIGFuZCBEUkFNIHJlbWFwIHN1cHBvcnQgZm9yIEFTVDI3MDANCg0KKyBKb2UoR29v
Z2xlKSwgTmFiaWgoR29vZ2xlKSwgTHVjaWVuKHNpZW1lbnMpDQoNCiogDQo+IEhpIFBoaWxpcHBl
DQo+IA0KPiA+IE9uIDgvNy8yNiAxMToyMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4gVGhpcyBz
ZXJpZXMgaW1wcm92ZXMgQVNUMjcwMCBwbGF0Zm9ybSBzdXBwb3J0IGJ5IGFsaWduaW5nIFNTUC9U
U1AgDQo+ID4gPiBwb3dlciBhbmQgcmVzZXQgYmVoYXZpb3Igd2l0aCBoYXJkd2FyZSwgYW5kIGVu
YWJsaW5nIERSQU0gDQo+ID4gPiByZW1hcHBpbmcgcmVxdWlyZWQgZm9yIHByb3BlciBmaXJtd2Fy
ZSBib290IGZsb3cuDQo+ID4NCj4gPg0KPiA+ID4gSmFtaW4gTGluICgxMCk6DQo+ID4gPiAgICBo
dy9hcm0vYXN0Mjd4MDogU3RhcnQgU1NQIGluIHBvd2VyZWQtb2ZmIHN0YXRlIHRvIG1hdGNoIGhh
cmR3YXJlDQo+ID4gPiAgICAgIGJlaGF2aW9yDQo+ID4gPiAgICBody9hcm0vYXN0Mjd4MDogU3Rh
cnQgVFNQIGluIHBvd2VyZWQtb2ZmIHN0YXRlIHRvIG1hdGNoIGhhcmR3YXJlDQo+ID4gPiAgICAg
IGJlaGF2aW9yDQo+ID4gPiAgICBody9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNT
UCBTRFJBTSByZW1hcA0KPiA+ID4gICAgaHcvYXJtL2FzdDI3eDA6IEFkZCBEUkFNIGFsaWFzIGZv
ciBUU1AgU0RSQU0gcmVtYXANCj4gPiA+ICAgIGh3L21pc2MvYXNwZWVkX3NjdTogSW1wbGVtZW50
IFNTUCByZXNldCBhbmQgcG93ZXItb24gY29udHJvbCANCj4gPiA+IHZpYQ0KPiBTQ1UNCj4gPiA+
ICAgICAgcmVnaXN0ZXJzDQo+ID4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEltcGxlbWVudCBU
U1AgcmVzZXQgYW5kIHBvd2VyLW9uIGNvbnRyb2wgDQo+ID4gPiB2aWENCj4gPiBTQ1UNCj4gPiA+
ICAgICAgcmVnaXN0ZXJzDQo+ID4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTQ1Ugc3Vw
cG9ydCBmb3IgU1NQIFNEUkFNIHJlbWFwDQo+ID4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEFk
ZCBTQ1Ugc3VwcG9ydCBmb3IgVFNQIFNEUkFNIHJlbWFwDQo+ID4gPiAgICB0ZXN0cy9mdW5jdGlv
bmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjOiBCb290IFNTUC9UU1AgdmlhIFBTUA0K
PiA+ID4gICAgICBhbmQgbG9hZCBiaW5hcmllcyBmcm9tIERSQU0NCj4gPiA+ICAgIGRvY3M6IEFk
ZCBzdXBwb3J0IHZib290cm9tIGFuZCB1cGRhdGUgTWFudWFsIGJvb3QgZm9yIGFzdDI3MDBmYw0K
PiA+DQo+ID4gU2VyaWVzOg0KPiA+IFRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPg0KPiA+DQo+ID4gMiBub3RlczoNCj4gPg0KPiA+IDEv
IEkzQyBlcnJvcnMgaW4gZG1lc2c6DQo+ID4NCj4gPiBbICAgIDguMTUxMjMwXSAgMTRjMjAwMDAu
aTNjMDogTUlQSSBJM0MgSENJIHYwLjAgcjAwDQo+ID4gWyAgICA4LjE1MTQ5OF0gIDE0YzIwMDAw
LmkzYzA6IHVuc3VwcG9ydGVkIEhDSSB2ZXJzaW9uDQo+ID4gWyAgICA4LjE1MTc2MV0gbWlwaS1p
M2MtaGNpIDE0YzIwMDAwLmkzYzA6IHByb2JlIHdpdGggZHJpdmVyDQo+ID4gbWlwaS1pM2MtaGNp
IGZhaWxlZCB3aXRoIGVycm9yIC05Mw0KPiA+IFsgICAgOC4xNTIyNTBdICAxNGMyMTAwMC5pM2Mx
OiBNSVBJIEkzQyBIQ0kgdjAuMCByMDANCj4gPiBbICAgIDguMTUyNTE4XSAgMTRjMjEwMDAuaTNj
MTogdW5zdXBwb3J0ZWQgSENJIHZlcnNpb24NCj4gPiBbICAgIDguMTUyNzc5XSBtaXBpLWkzYy1o
Y2kgMTRjMjEwMDAuaTNjMTogcHJvYmUgd2l0aCBkcml2ZXINCj4gPiBtaXBpLWkzYy1oY2kgZmFp
bGVkIHdpdGggZXJyb3IgLTkzDQo+ID4gWyAgICA4LjE1MzMyMl0gIDE0YzIyMDAwLmkzYzI6IE1J
UEkgSTNDIEhDSSB2MC4wIHIwMA0KPiA+IFsgICAgOC4xNTM1ODhdICAxNGMyMjAwMC5pM2MyOiB1
bnN1cHBvcnRlZCBIQ0kgdmVyc2lvbg0KPiA+IFsgICAgOC4xNTM4NTNdIG1pcGktaTNjLWhjaSAx
NGMyMjAwMC5pM2MyOiBwcm9iZSB3aXRoIGRyaXZlcg0KPiA+IG1pcGktaTNjLWhjaSBmYWlsZWQg
d2l0aCBlcnJvciAtOTMNCj4gPiAuLi4NCj4gDQo+IFRoZSBBU1QyNzAwIEkzQyBjb250cm9sbGVy
IGltcGxlbWVudHMgdGhlIE1JUEkgSTNDIEhDSSBzcGVjaWZpY2F0aW9uLCANCj4gd2hpY2ggaXMg
bm90IHlldCBzdXBwb3J0ZWQgYnkgUUVNVS4NCj4gQ3VycmVudGx5LCBRRU1VIG9ubHkgcHJvdmlk
ZXMgYW4gSTNDIG1vZGVsIGZvciB0aGUgRGVzaWduV2FyZSANCj4gY29udHJvbGxlciB1c2VkIG9u
IHRoZSBBU1QyNjAwLg0KPiANCk5hYmloLCBKb2UsIEx1Y2llbiwNCg0KQXMgZmFyIGFzIEkga25v
dywgeW91IGhhdmUgaW1wbGVtZW50ZWQgc3VwcG9ydCBmb3IgdGhlIEkzQyBIQ0kgY29udHJvbGxl
ciBvbiB0aGUgQVNUMjcwMCBwbGF0Zm9ybSwgYW5kIGl0IGFwcGVhcnMgdG8gd29yayB3ZWxsIGlu
IHlvdXIgbG9jYWwgUUVNVSBlbnZpcm9ubWVudC4NCkRvIHlvdSBoYXZlIGFueSBwbGFucyB0byB1
cHN0cmVhbSB0aGlzIHdvcms/DQpJZiB5b3UgYXJlIHBsYW5uaW5nIHRvIHVwc3RyZWFtIHRoZSBJ
M0MgSENJIHN1cHBvcnQsIGl0IHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuDQoNClRoYW5r
cywNCkphbWluDQo+ID4NCj4gPiAyLyBzaHV0ZG93biBub3Qgd29ya2luZw0KPiA+DQo+ID4gWyAg
MjQ2LjQwNTI5N10gc3lzdGVtZC1zaHV0ZG93blsxXTogRW50ZXJpbmcgZXhpdHJkLi4uDQo+ID4g
c2h1dGRvd246IHBvd2Vyb2ZmIC0tdGltZW91dD05MDAwMDAwMHVzIC0tbG9nLWxldmVsIGluZm8g
DQo+ID4gLS1sb2ctdGFyZ2V0PWttc2cgLS1sb2ctY29sb3IgLS1leGl0LWNvZGU9MA0KPiA+IC9z
aHV0ZG93bjogbGluZSA5NzogcG93ZXJvZmY6IG5vdCBmb3VuZCBFeGVjdXRlIHBvd2Vyb2ZmIC1m
IGlmIGFsbCANCj4gPiB1bm1vdW50ZWQgb2ssIG9yIGV4ZWMgL2luaXQgc2h1dGRvd24tc2gjDQo+
IA0KPiBPcGVuQk1DIGN1cnJlbnRseSBvbmx5IHN1cHBvcnRzIHJlYm9vdC4NCj4gSW52b2tpbmcg
c2h1dGRvd24gY2F1c2VzIHRoZSBzeXN0ZW0gdG8gcmV0dXJuIHRvIHRoZSBMaW51eCBpbml0cmFt
ZnMgDQo+IGluc3RlYWQgb2YgcG93ZXJpbmcgb2ZmLg0KPiANCj4gVGhhbmtzLA0KPiBKYW1pbg0K
DQo=

