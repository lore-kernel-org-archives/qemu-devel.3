Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D0CCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PIo-0006Gx-Fk; Mon, 29 Sep 2025 21:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PIj-00060F-M0; Mon, 29 Sep 2025 21:37:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PIT-0003vn-WF; Mon, 29 Sep 2025 21:37:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkxkWaGIs1LKyAeeze+l060ahvyh254ydWoETgspC/mXcyGRGSRjCY/4yQY3VdGwgXHWV2haJlmzYi8gGyEa+nRgEw8G3v9Sqgaf3rfZAIj7xRyb0B1DDTI1KKyTyqn1xTVGODHxcB/3utTxOwsRzyk5F2N+0Ir3Lrfly/bQoDnSpbVII6AAYsRjIkrc3SejFLrw6AgR/wIAgHFbUd7evoBnq686lwmyKcbrakoknRANGdHuuS3PtQOYgaUD8L1jkskBuPvGROy5Gocvm1b+h5EweQ0Y+nv6AqVBiRNNJiDCXfBiF3gFr0tUkvzyTuPb8LDWpd6+u1jMeKs3dWThVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvnFgW0MaCOi8zcA7GZh7MQaZykUxO7kQq7EUYv345w=;
 b=mgISPLg5HiLEUhf06Le94IM6AEbdMehgj7ZCzgnlFP1NyfkSaiitVlF2nZc9Rd6A8TOc9OZ73Oq/ydrcYmSDsBSe6PaNp3itE2S9oDlVln0rDh+XYEZZY9AC8nM8AdJPMukaeqcdo95ZKUr+CEk9id7CR/CaOTVAXYMXavjTmYhxhRQtiL4docNVdH8OL+4J0P3c3W0yVx7QuzGex7uccgV8J0cVLBSz7iak1hk3TQreuHG70xps6l62O/mzbtk4WgvutAOnZuoWCcLNQyDYXCRDbgs15D11TNNk3lfSdmtfUmM1HOnce90xHMtKt4ufiponCQtBz2GQOn8HN4awBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvnFgW0MaCOi8zcA7GZh7MQaZykUxO7kQq7EUYv345w=;
 b=FLEBVirJobAIG5d0orUlT94weQYxcgEjNSEXVxpGJPCjVfM36WxleRU4dS8J+7CfRTBakRpPsP0JhPRmMQdG39AG4SeAHlYEmNsIc1hZCBiVXR6uegMOYO3aVFQbKcAST4nPRGt/c8pjfeAjASrRHXsmKz1dcfHA4LTe1jJLWpltb8esdewx5bdgofj3mNjRP2EC21x9KWXualnX09sljSfOhMr3L1yFHH2Li22mnGzEN4bLLP/Gu02w22H+2FzyFRyuQ0HCpxDAxjKqgtQFOFvNi6zEs/508BrLxDQf8TmOHTP5QtQ5JIp4h1wvTRKYFJIad9CECy+H8YrFEtP7rQ==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:36:41 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:36:41 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com"
 <Avi.Fishman@nuvoton.com>, "tomer.maimon@nuvoton.com"
 <tomer.maimon@nuvoton.com>, "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 7/7] hw/arm: Add PCIERC to NPCM7xx SoC
Thread-Topic: [PATCH 7/7] hw/arm: Add PCIERC to NPCM7xx SoC
Thread-Index: AQHcIda2vXmHmadpqk+HTnyGftOkpLSrEZhg
Date: Tue, 30 Sep 2025 01:36:41 +0000
Message-ID: <TYPPR03MB9497FC46114108BE3B887EF7DB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-7-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-7-d85883b2688d@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: 5f55545c-b1c4-45c6-369a-08ddffc1ce84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?anBxUnVYT1ZWeVB3eG1pWFJOZUQ4OFl6OUxEZHV4MUlGS1N0RHNZTmJaTGM3?=
 =?utf-8?B?Q0NqMmpwWlN6RlpVRUsySTg0MWxQalpjemtJc2xwNGcrVlRBZnJzZm5iMlhC?=
 =?utf-8?B?aFZOQk4xUEVKRDRZOWJXN3hiWFFTWTk2c0w2b2tEMTVKYnJUVEdIUzBVNzVC?=
 =?utf-8?B?c3h4VG04K3I2K2JvY25kUzI5WXlhS1BkZm1BcHBja09QOGxiKzBTVnpsczdG?=
 =?utf-8?B?UFBPUUJhSy9KZTlIRUUxVUlxMEFKTVViZ1A2U1ArcnZLS3p4TkNGUDNCWTJh?=
 =?utf-8?B?R0ZCaGpUcVRQWEJNVlpsbGx5WUhaWVdYNmtJdzRFdldaWUxFRnUyMm9NWlhQ?=
 =?utf-8?B?SEFjdmVRc0E0cTVKUVR6clN4SjdDYzZRcU1MOTk5SU9QQ3VwbVZ4cHNyUnpy?=
 =?utf-8?B?UUFGL2NTaFBmU3k3ZWNiR1FzdnlFVVFYZ1VFeWtSbHpLcjl0UGIzK1U5KzZp?=
 =?utf-8?B?ektRNVZlZ3haRHkveWVROTFML0RGMGMzTnE4VDFVVmdpay8vMDlzYjZTc1po?=
 =?utf-8?B?b2lxcGNOaGpjcmtxV1pMa0FUT3dxeXZwMTAxY1JEcGI2T21YL01NZC85Q0NI?=
 =?utf-8?B?aEd3MW8rbnRIbDhhaHliOStiYnNEaElTNXJzUmt4d1UwRVhWZ01HM1NMNWJa?=
 =?utf-8?B?ZGhTRFJieWdycWRPdUIrZ2FFdDFOUzNlcEpRcXFhRDIyN2hmb1V0VXNWU20r?=
 =?utf-8?B?aFNkOWs0NXlRandPZVZJQ0R1Z2ZlUDlqVEdScWFxK0dMMTlnWHdjM0F1N21x?=
 =?utf-8?B?RnExQVFLQ2JFd3ovOWw5SWJOeGZjQ0tYSVRUWGh3b1FUenYxZ1NheXNUYURk?=
 =?utf-8?B?Tkx0NWlOQUFFNXFVSXQyNGl3Y1ovdkFoeXVQZG5WcHVRdThTTXYvQzQ0L3BN?=
 =?utf-8?B?RUxBalF1cXlaUTFxbG5hYkI4R0xiV3dXbEg2eUl2Wk5GVHV2TlFiS3NJRkdL?=
 =?utf-8?B?Wk5BUUdaRmdFVmg0WDhxWVlPc3BWem5xTXNrSkFvU1dEdjVheG1UdHluWktl?=
 =?utf-8?B?UkxxSXNxQ3BIZkZyUXJEZXVjTFFvWUdsN3FrUjhHM25UL1BKb1hybUVkcVNI?=
 =?utf-8?B?bUFudzBqQjYxOFhrdjMydGhyZiszY2NTaU1BVlZKWm1xSXpEcTlPVTVaZ2U2?=
 =?utf-8?B?eHNZMWJVRGQ4UlVVM3FJa2RyZC8vYlVSdWhzUnZoaXFwTHBtZEtsWjFNMUFj?=
 =?utf-8?B?TWxPa3htUFZMd1FrcnJWUlQ2SThtczQzaVB2SVdHQjJNdXFMOTJBc3QyL24w?=
 =?utf-8?B?NU44ZFZvSmZVQU1FQ2NIZ29PMGNKWCs3dlN6dnhOODlHVjRJalVpNVpFUFda?=
 =?utf-8?B?VW5Ed3BHVlVGdkkvUGZ4VjdvSGg3T1RaNVRvU280QXB2cDRRaWp2TzRQVmU5?=
 =?utf-8?B?dlMrVmdYanBWK05JNUNGVFVNQjd1YW5GdEFsVW9zYWRYNmhVUkVIS1VON0tk?=
 =?utf-8?B?RmxzWkJTY0VRQW1JTUxJdnNTUUoyQnlDbGRuajFJRzd5NUd4eElmd3Z0eVZN?=
 =?utf-8?B?VDdmVms2UUQ1ams3VVROYTdIZlhsQUhFbkdEL1dZblBPUDVtY3IzcVlyWm5P?=
 =?utf-8?B?bjR2dDVDZWt6cUFkLzlJZWI3dXNqR0E0UWlVT1hHb29tb1ZZRXYrYnJ6Zm90?=
 =?utf-8?B?OGN1YmVtOENpbjFBbmhjdEtFcG5iN3Q2Z3Q2djQ0clpVRUxiV0dzejlVbVlM?=
 =?utf-8?B?QU5WZnRTRFh0VmVBQmJEUGlWcnk2dURCMFgraHRuUWxlOVhiT3VpbzVlVEM0?=
 =?utf-8?B?RU9QdHJ3d2VJaW9LejNUUWUydTVBWVZleUVlSlJ6YWMvd1h6VFZ0aVJZMWlr?=
 =?utf-8?B?c2lIWmJjZUIxLy9SdmNTcXdjTU9FOVhGQXYvdUpTUXlLUGl6cmJqMkdMdzZ2?=
 =?utf-8?B?RlZZR1V2UXZnTVRhT3REMlZzMjRQNHRCODB0ZnR3c1ZZT0tKVGhhYW5ndjIz?=
 =?utf-8?B?VGk1RjJWdHJPSzFNTWNRRXlMV2gxT0ZINU1RdHVIQ2toMm93dmlxdVBPQ0xI?=
 =?utf-8?B?U3FORWFFQTBGV09RWUREUVQrRHliazg2Y0tMSjZJQWJEQ2tnWG5INnZKbFEx?=
 =?utf-8?Q?1+PRJ4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nlo5ZFFyckFIeEEwRWxPOGhJMXhINTdaU3RFVlc2VmU3WDZVeXFGcFFVMENo?=
 =?utf-8?B?WGcvZ1l6UGtPdUJQMmRQMGRvOVpWOUltV3lIOU40VldNRHAwWUxCMHEwMTJq?=
 =?utf-8?B?bWFLeHludDdZbERqZEhXb1dobEpEZDFzTWtRaWtvM3hTa2NKUVVjOUFNckd5?=
 =?utf-8?B?WFF0UThHU1lkb2NYUExRMWdxbG56Mk0wWTFKdnc4MGw1dUVISHVJQnZ5dHJN?=
 =?utf-8?B?ejBkRG1tdi9xTnVhUFVCdmdxVk8vNHNMUWtTaFdWNTJ5N1cvdWJqV3FiWFNQ?=
 =?utf-8?B?bkgwVG1vU1JJNFM3RkVSdzhYTWVVbUY1U1RDeXVRK0RXajMyWjhWajRoTkg0?=
 =?utf-8?B?QlZLUDhLdW5iYjhLY09lVzJoeW4xOU96WVcraGNGWTkra0hMa2ppRktDakxP?=
 =?utf-8?B?YnpMMEN3dnJONWRYYVNmTXNPQ0ZFNHA3T3h2Yk9ETnRacDVpK3dTVW55dkZz?=
 =?utf-8?B?elJ0UUZ6OTBSTjNWZFNiU04wNHhZaG03VUwwNHNDZndtUGQxU3BlMXovUW11?=
 =?utf-8?B?L1VHOXp1bFZVRVNBenlCTFh6U3JFL05XOE50TDJnc3VoTzZoUFJvRWE5cWFx?=
 =?utf-8?B?MDVyRVorZE9iL2J5NS9rUjIyazA5QitxNnIzeWQzWFI1Qlc3S253Sk1GQno2?=
 =?utf-8?B?bDNDRStPZUU0bXUrNHFpdFRNVFBiZHNMWEwxMGR5d2JyVitheG43TkNNY2Jo?=
 =?utf-8?B?TUZQTW9vc085WFdMeXhRbGxGUEJQNW00d0loT1Y3M3p3UW1Iai8yQVFUUjg5?=
 =?utf-8?B?K2M0azJEanlOSndRUjF1QktVQjNkVEcyRUlvcklpZmlmTVkzQWQ3TnBpdTNW?=
 =?utf-8?B?dUlaMDFPNG5OQll5UTZsU3ZUSE53WWpldU1ucHVlcmI3aUlrMkdyQ2owM1Vn?=
 =?utf-8?B?RWtBKzJNODhGdVhGdEJQU3E4UUtqelc1Z0hRTW1vQmNEMTcxTExraXZ0MEtr?=
 =?utf-8?B?ck5yRDVNY1h5bkFaTHRhYW8xWlAxYStGdnZ0QWM4OFlCUnFvK1gybU5sMlA0?=
 =?utf-8?B?Qm4xNkgvTS91RjFJM0hUdTF3UWc3bDJ5NEJMVFJWQkFuU0FiWTRwVTNnd3p2?=
 =?utf-8?B?Z0dZeEt2ODl0Yms5S09Yck5weldiZU9uOFVab0Z4a1JzMUtsbUVVaVNHNVE2?=
 =?utf-8?B?K2l2d0RKdUdpTTBDVXFUN1g5SVZVdFFobE5pWGViR3Avb2NPQUI5djVDNTIx?=
 =?utf-8?B?M090c25mU1J0OCt5V25Fd0lrcTJkNmZmSElySTF3MmNsYXd1MnkvTXozU0U5?=
 =?utf-8?B?UFZXM1pQbHl2UkFQYlZtRERtMm8vSUFGWG8vVTByVGhHN2hKa2VjVERSZTZa?=
 =?utf-8?B?cGRwVExRaU15alM3cXFXOElIRmlJQ2U5cWwzb3gzaXhwRkM5RzNVckhVbGZL?=
 =?utf-8?B?a3ppSnptNVlkKy9Hd1F6VWNWeC9DTExob1dZS3dQOG1HNUNGVEwwbVRXek5C?=
 =?utf-8?B?THU4UXp1b1diQXF4SGdicGc1ZkJJdzljUTRRVGpjMkVOSE9WNGtPY1k5MDhx?=
 =?utf-8?B?aVVKUVUyWE1wTkh5Ky9SRW1NRUpBQlNzYThCMkxqU2V5TTJJOWpDZ2NDTitv?=
 =?utf-8?B?WGEwUGlzMzBoc1dQZ21FNjRMZk9WNE5VR0NjMzhNS2IxZ05xazBmYzlVdkZh?=
 =?utf-8?B?cnFrOFhneUw0Tmo2SU1sNDF2Lzc0RWlDaXRvUUk1aGFNUS9tWkhJM2ErelM0?=
 =?utf-8?B?UlRtOGF5K25QNkV2YkNkbE9XZ2E0TnlCV2N4UTV0RzRVRThPVERDdGpNVjc0?=
 =?utf-8?B?UEZ5eGsycHIvd3grQWpGd2lJeHVOaFI2YzlBUUVNZDZweEFOVGF2YmdscVgw?=
 =?utf-8?B?YVp6b0ZnZGtVSlV5QXl3S3krN1MwcHpRSnRoNUUzQzhXVmVZYUo0REQ0b0pP?=
 =?utf-8?B?SGtUcC96YUhaSmxGRzlNaEVzWnRlNmxidVJPZ2J4d1BvQmRFZUtpWUZOamtZ?=
 =?utf-8?B?dDBvcmdhRllzZWpEKy8zNHNwRXNqSUtxYlFPeXdpNDVtNURDeDZ5UG5Hbndp?=
 =?utf-8?B?NCtPVmpxR2JZSy9GSzBqWlFCcCtjcVhUMHQ2RnkrZ1l4c2pUVVY4T1pua2hW?=
 =?utf-8?B?RDdHdFNQQmlyM01sOC8vUEVSbDd6bHZlYUc0c1FaUkF3SWhWd1R3MGFoS29j?=
 =?utf-8?Q?uhgDXb007BRzpnea/vsqoxJxG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f55545c-b1c4-45c6-369a-08ddffc1ce84
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:36:41.4581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJ8QdyilSIsrQRJQV+bEWIA9BBRLv6bZJWgWd0qDOZ6Oat2Rp9j1XUJc8yuR+z59mXL32OP8hfaWzLR3L8qkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=KFTING@nuvoton.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTAsIDIwMjUgNjoxMSBBTQ0KVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBDUzIwIEtGVGluZyA8S0ZUSU5H
QG51dm90b24uY29tPjsgSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUuY29tPjsgcWVtdS1hcm1Abm9u
Z251Lm9yZzsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgWXViaW4g
Wm91IDx5dWJpbnpAZ29vZ2xlLmNvbT4NClN1YmplY3Q6IFtQQVRDSCA3LzddIGh3L2FybTogQWRk
IFBDSUVSQyB0byBOUENNN3h4IFNvQw0KDQpDQVVUSU9OIC0gRXh0ZXJuYWwgRW1haWw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgYWNrbm93bGVkZ2Ug
dGhlIHNlbmRlciBhbmQgY29udGVudC4NCg0KDQpGcm9tOiBIYW8gV3UgPHd1aGFvdHNoQGdvb2ds
ZS5jb20+DQoNCkdpdFdhdGNoZXI6IGlnbm9yZQ0KR29vZ2xlLUJ1Zy1JZDogMjYyOTQ2MTAzDQpH
b29nbGUtQnVnLUlkOiAyNDAxNjkyODYNClNpZ25lZC1vZmYtYnk6IEhhbyBXdSA8d3VoYW90c2hA
Z29vZ2xlLmNvbT4NCkNoYW5nZS1JZDogSTc3Y2U4NDlhZjMwZTk5OWVjMjZhZWFiNjJiN2RiNDM3
ZGIyOGMwMTINCi0tLQ0KIGh3L2FybS9LY29uZmlnICAgICAgICAgICB8ICAxICsNCiBody9hcm0v
bnBjbTd4eC5jICAgICAgICAgfCAxMCArKysrKysrKysrDQogaW5jbHVkZS9ody9hcm0vbnBjbTd4
eC5oIHwgIDQgKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvYXJtL0tjb25maWcgYi9ody9hcm0vS2NvbmZpZyBp
bmRleCA2YWMzOGQwODNlNGEwMWUwOWZjMDBlNjNkZjY2MDQ2YzdjMTdiMzU2Li5hM2YyMDQxZGI3
OTIwYzEzNGEyZDlkNzllZDQ4MzZiZDM1NTA3ZDdiIDEwMDY0NA0KLS0tIGEvaHcvYXJtL0tjb25m
aWcNCisrKyBiL2h3L2FybS9LY29uZmlnDQpAQCAtNDg3LDYgKzQ4Nyw3IEBAIGNvbmZpZyBOUENN
N1hYDQogICAgIHNlbGVjdCBVTklNUA0KICAgICBzZWxlY3QgUENBOTU0WA0KICAgICBzZWxlY3Qg
VVNCX09IQ0lfU1lTQlVTDQorICAgIHNlbGVjdCBOUENNX1BDSUVSQw0KDQogY29uZmlnIE5QQ004
WFgNCiAgICAgYm9vbA0KZGlmZiAtLWdpdCBhL2h3L2FybS9ucGNtN3h4LmMgYi9ody9hcm0vbnBj
bTd4eC5jIGluZGV4IGVjZmFlMzI4YTk2YTQ5YzgyYmVhYTUzYTVkODAzNDY5YzhmMDJkOTEuLjEx
ODQ3MGFmMDY5NDcxODUyMGI3YzM4MjhkM2EwOWVjZmFmYjMxZWMgMTAwNjQ0DQotLS0gYS9ody9h
cm0vbnBjbTd4eC5jDQorKysgYi9ody9hcm0vbnBjbTd4eC5jDQpAQCAtNDcsNiArNDcsOCBAQA0K
ICNkZWZpbmUgTlBDTTdYWF9DTEtfQkEgICAgICAgICAgKDB4ZjA4MDEwMDApDQogI2RlZmluZSBO
UENNN1hYX01DX0JBICAgICAgICAgICAoMHhmMDgyNDAwMCkNCiAjZGVmaW5lIE5QQ003WFhfUk5H
X0JBICAgICAgICAgICgweGYwMDBiMDAwKQ0KKyNkZWZpbmUgTlBDTTdYWF9QQ0lFUkNfQkEgICAg
ICAgKDB4ZTEwMDAwMDApDQorI2RlZmluZSBOUENNN1hYX1BDSUVfUk9PVF9CQSAgICAoMHhlODAw
MDAwMCkNCg0KIC8qIFVTQiBIb3N0IG1vZHVsZXMgKi8NCiAjZGVmaW5lIE5QQ003WFhfRUhDSV9C
QSAgICAgICAgICgweGYwODA2MDAwKQ0KQEAgLTE0OCw2ICsxNTAsNyBAQCBlbnVtIE5QQ003eHhJ
bnRlcnJ1cHQgew0KICAgICBOUENNN1hYX0dQSU81X0lSUSwNCiAgICAgTlBDTTdYWF9HUElPNl9J
UlEsDQogICAgIE5QQ003WFhfR1BJTzdfSVJRLA0KKyAgICBOUENNN1hYX1BDSUVfUkNfSVJRICAg
ICAgICAgPSAxMjcsDQogfTsNCg0KIC8qIFRvdGFsIG51bWJlciBvZiBHSUMgaW50ZXJydXB0cywg
aW5jbHVkaW5nIGludGVybmFsIENvcnRleC1BOSBpbnRlcnJ1cHRzLiAqLyBAQCAtNDc1LDYgKzQ3
OCw3IEBAIHN0YXRpYyB2b2lkIG5wY203eHhfaW5pdChPYmplY3QgKm9iaikNCiAgICAgfQ0KDQog
ICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgIm1tYyIsICZzLT5tbWMsIFRZUEVfTlBD
TTdYWF9TREhDSSk7DQorICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInBjaWVyYyIs
ICZzLT5wY2llcmMsDQorIFRZUEVfTlBDTV9QQ0lFUkMpOw0KIH0NCg0KIHN0YXRpYyB2b2lkIG5w
Y203eHhfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIEBAIC03ODEsNiAr
Nzg1LDEyIEBAIHN0YXRpYyB2b2lkIG5wY203eHhfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBF
cnJvciAqKmVycnApDQogICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEoc2JkLCAwLCBucGNtN3h4
X2lycShzLCBpcnEpKTsNCiAgICAgfQ0KDQorICAgIC8qIFBDSWUgUkMgKi8NCisgICAgc3lzYnVz
X3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPnBjaWVyYyksICZlcnJvcl9hYm9ydCk7DQorICAg
IHN5c2J1c19tbWlvX21hcChTWVNfQlVTX0RFVklDRSgmcy0+cGNpZXJjKSwgMCwgTlBDTTdYWF9Q
Q0lFUkNfQkEpOw0KKyAgICBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMtPnBj
aWVyYyksIDAsDQorICAgICAgICAgICAgICAgICAgICAgICBucGNtN3h4X2lycShzLCBOUENNN1hY
X1BDSUVfUkNfSVJRKSk7DQorDQogICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgibnBj
bTd4eC5zaG0iLCAgICAgICAgICAweGMwMDAxMDAwLCAgIDQgKiBLaUIpOw0KICAgICBjcmVhdGVf
dW5pbXBsZW1lbnRlZF9kZXZpY2UoIm5wY203eHgudmRteCIsICAgICAgICAgMHhlMDgwMDAwMCwg
ICA0ICogS2lCKTsNCiAgICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJucGNtN3h4LnBj
aWVyYyIsICAgICAgIDB4ZTEwMDAwMDAsICA2NCAqIEtpQik7DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9hcm0vbnBjbTd4eC5oIGIvaW5jbHVkZS9ody9hcm0vbnBjbTd4eC5oIGluZGV4IDU2NTM2
NTY1Yjc0OGM1ZmIyZjQxNWQ4NWRmMzZiYzAxY2I2NGRjNTQuLjY2MWQ0MDUwMTU0YTM2ZGMyYjkw
ZTk2OTE1YWU1OTk3MWE4YzRhN2EgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L2FybS9ucGNtN3h4
LmgNCisrKyBiL2luY2x1ZGUvaHcvYXJtL25wY203eHguaA0KQEAgLTMxLDYgKzMxLDcgQEANCiAj
aW5jbHVkZSAiaHcvbmV0L25wY203eHhfZW1jLmgiDQogI2luY2x1ZGUgImh3L25ldC9ucGNtX2dt
YWMuaCINCiAjaW5jbHVkZSAiaHcvbnZyYW0vbnBjbTd4eF9vdHAuaCINCisjaW5jbHVkZSAiaHcv
cGNpLWhvc3QvbnBjbV9wY2llcmMuaCINCiAjaW5jbHVkZSAiaHcvdGltZXIvbnBjbTd4eF90aW1l
ci5oIg0KICNpbmNsdWRlICJody9zc2kvbnBjbTd4eF9maXUuaCINCiAjaW5jbHVkZSAiaHcvc3Np
L25wY21fcHNwaS5oIg0KQEAgLTEwOCw3ICsxMDksOCBAQCBzdHJ1Y3QgTlBDTTd4eFN0YXRlIHsN
CiAgICAgTlBDTUdNQUNTdGF0ZSAgICAgICBnbWFjWzJdOw0KICAgICBOUENNN3h4U0RIQ0lTdGF0
ZSAgIG1tYzsNCiAgICAgTlBDTVBTUElTdGF0ZSAgICAgICBwc3BpWzJdOw0KLX07DQorICAgIE5Q
Q01QQ0lFUkNTdGF0ZSAgICAgcGNpZXJjOw0KK30gTlBDTTd4eFN0YXRlOw0KDQogI2RlZmluZSBU
WVBFX05QQ003WFggICAgIm5wY203eHgiDQogT0JKRUNUX0RFQ0xBUkVfVFlQRShOUENNN3h4U3Rh
dGUsIE5QQ003eHhDbGFzcywgTlBDTTdYWCkNCg0KLS0NCjIuNTEuMC4zODQuZzRjMDJhMzdiMjkt
Z29vZw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCiBUaGUgcHJpdmlsZWdlZCBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBvbmx5IGJ5IHRo
ZSBhZGRyZXNzZWVzIGFzIGluZGljYXRlZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVyIG9mIHRoaXMg
ZW1haWwuIElmIHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGluIHRoaXMgZW1h
aWwgb3IgYXJlIG5vdCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVtYWlsIHRvIHN1
Y2ggYSBwZXJzb24sIHBsZWFzZSBraW5kbHkgcmVwbHkgdG8gdGhlIHNlbmRlciBpbmRpY2F0aW5n
IHRoaXMgZmFjdCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgaXQgZnJvbSB5b3VyIGNvbXB1dGVy
IGFuZCBuZXR3b3JrIHNlcnZlciBpbW1lZGlhdGVseS4gWW91ciBjb29wZXJhdGlvbiBpcyBoaWdo
bHkgYXBwcmVjaWF0ZWQuIEl0IGlzIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIHVzZSBv
ZiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gb2YgTnV2b3RvbiBpcyBzdHJpY3RseSBwcm9oaWJp
dGVkOyBhbmQgYW55IGluZm9ybWF0aW9uIGluIHRoaXMgZW1haWwgaXJyZWxldmFudCB0byB0aGUg
b2ZmaWNpYWwgYnVzaW5lc3Mgb2YgTnV2b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMgbmVpdGhlciBn
aXZlbiBub3IgZW5kb3JzZWQgYnkgTnV2b3Rvbi4NCg==

