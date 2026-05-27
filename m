Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C76CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gW-0001C4-4K; Wed, 27 May 2026 04:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gQ-00017e-Ln; Wed, 27 May 2026 04:32:12 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gM-0003xv-HI; Wed, 27 May 2026 04:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBUk49qq+SDTnvbWm7Hd4p3PH2xuA2EYmREzOryjJEIxhgljKXmW/g7+mJiIDxiN+BiyZeGi2gUm9B70eeJhnjs9/L93iCCps40RIh5t6iSG5C5X+AfRr692GzvykDUtEpyVXbyWzM6TqYfE9FbPVYl6Mbux+PhM0IkhcvSiD7GjeiQ1THZ3ek0XtA723/ETk1mFv1ogPCJuvDJh/ZIurZ2BsQU1ktHoH9Uc5ZMWlJe1Ckn108Vcrxrf9Y9mnSLdqANCY8eQEgTYkKFfcxdHejnrmy8h3VmwgEwzc4PKh3Yf/9Xt+TtsthfUKjcV1g5bGBEG08wz7/sia8dDx8MYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=uOK8ToziUfXaHh5fWaOPuYFtauWbkOmQonTomTXDRhEhGaUIL9rnZ0l2jidMWUruz/6sY2wow0r5NOSfibfm+J//wPadwhKzTGUgXT7B+v36z7iGCp6xN1R7tHb+MUtGhMnB5k/gcl8KExB3Zru7wie6vYGuVFnlqqFamhQGjF6o2RIpTdhkKu9Ji3yP6S+AOubG9RwfradE/gNYycITn05mKGpCnJNaMFtvfDiSIb0vc+DPlOmqFlvOpG0vHFV23SRDa0gmhMlFhEP2y2opXnHYSKI3Fffq0UAP18S7UH8bEmSDE+ANCQJYWBYnARThQGEI+DuwTEPQ2Lu3qJaoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=e3HLx/lNap8jFCDjpWWAOTMCMWGjG9C9+jfltPqQDPVIQjCwKPoKT+Quy2DnKSJdZA8O1PbXRAfl3hZzGHZ6lRzWGdrjei3t5hVPi+cQdE6/FKxNzg5sAOspjkvCVI77/l3/TwhHNBrWUJys1hdBMtm7zJR5aA+fYXjZazUehO4mq5+DPmHxZwj4luua4k0q0F+tkfLEGDmLL0wyL7ePnsHnAa2J20SdajrP3V+xmJlXYvjN6XOFU+3fBNzQ67pHexVLzcHkP/Y1tByHZzlqx8/UufVYNXsmLIigNoJaWv1Ugu4naxzFmyQ6UaSDVXE3NmEpNP5n7R9JEU3PNByhtQ==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:31:59 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:31:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v10 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v10 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHc7bNI0emHXYxUnk6HtyUJHDMNKg==
Date: Wed, 27 May 2026 08:31:59 +0000
Message-ID: <20260527083151.17876-2-djordje.todorovic@htecgroup.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: 664881c6-4015-4b25-4c1d-08debbca6b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: /xY5h6pYIgK1SZFXbIYDu4rlm1xzmHRQpkAmwN4T1QEh8Ztft1wAJc+oQk1Oi7xtaI9VcD1wTPeVHRs4MtbKj54QVKx+gqFGsCxb/VYOp5MoEjEZKZBjZBPkjcV+HXaVCw4sGKo4BI5UtFO1vFOLlOuBHx1GStW26McWAiSSQLu2VVwsiy953ARu1/gGaTv5CK4NLpVpsHo45B+W98GdaXC+0CH8HbRxUqnbIHLlMr+dd2oqnUJEtp6m7rsha/P3gDbb73lOcQEYVGx2Ie6dToKUUub/S2vAjc8xAxhbz08/zJEqo0eVsgaWhP1hNzOa0I17CVpJyOb+ulWTavNi9LtjUJx5ryxtc6KtpRQTrzn/G2PBnd3HvTbs9SoxpUM7rJp8M7ILeWomg7NIxhCMe4Gx2EpU0pTUP/YXhOzk6phM4K3JxSMxjiOMlGOQ6w0grFo2Ur01JU1+p1ccixZh/tb3IA661WzpzeRtrbFLEwRhVAYozycpdk/aV2vOT919erWuiON7I/Vh5tFJvsZdgGrUdNjKC6QbkDIgb4r4pcK9R2hZPJpbZqDMlTGAJP14jWdsZQ3Io3JnPd9Td5Gw3S/FbQFPfd7GR9dvu5sHr1utXT5TDU2UCuiS3Dw1/gnI1lx/S5LZV1a7dFwBTRxHbLNSm8VRRgCyEsUeuT9Cb3ec5DfkJtgC141VvsrDiXiihWNLHkkncsWILi7g59E0G6lA1HpvfXKWywNbO7cnl+TEd69Q1mYKGrMII4vUsq79
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkl4aTU2c0R5dXlSQVN0MjJ2NDduVDJadERBLzYxamR1Nm5jZHFlTUN5eWx2?=
 =?utf-8?B?RkxmVEpPNEMvUHdkOVhUbTJlc3Q5dTFyOXZuaHRHZ25JYU4zdUJPVjRIKzRM?=
 =?utf-8?B?ODUxVXBSYThaSm9ReVhUbkpmenp5anNBZHFFaHM5OFJRMUtFNENUNHVod0dP?=
 =?utf-8?B?M0orZWxUV1RZK09WaGhHRGxPZDM3RXlYZ1I4RHdkU21FYURQNE9TVjlqR2dT?=
 =?utf-8?B?bXgyeUFKZEdodEo1STR6NGFaWVZjSzRONDh4VDM5aCt1MUN5eFk3WDhYQXlk?=
 =?utf-8?B?TGY5KzZCNUIyYUtGUHpPTXAxai9iYUtqTlAxYXVhdlRnT1h1ZFVlOTBLMWdM?=
 =?utf-8?B?MVIyK3pSOEZEaVdGL0xCa1JwcGtZd21relplbmxVeXV1NDhkdTQ4UUtaVjlt?=
 =?utf-8?B?ajRuNUlycEQwYzA2UG0wRmJjZ2hWaDM1S1pMS0czMTBESms3dnIwenJFbnRh?=
 =?utf-8?B?bWtNV1l3ZUpKdllwY2ZGSVFxMTJyRWtGTkUxQ1AydWhZcDV1UVdoRFM0aHpj?=
 =?utf-8?B?NjZHTWNMNGw4VTVSRWt1ZnlNWDJScFdPQW5mVHhwZmhkeVdRTEtSQTRsTnNx?=
 =?utf-8?B?U3FQZ3k0L0dpTGpxZ1FWNTJiQ3FkMDRibWVxcFRCVjVYV2NFSVZzd21ETWhJ?=
 =?utf-8?B?NzVtbm5qUUFTSDZldnNhSHNIeDNuZUxrT1JQRTBWa0E1cmxzeGtLNklucmdE?=
 =?utf-8?B?S0dMcW5neHdWVjVDb2J4bjhGb2hXQmU0MStYTkM4cFdtdkNwdUlZT1o5bEdy?=
 =?utf-8?B?VStTR01kR3JYRzBxUW5zaVJVSVp1ejVvTXFYZ2wzeGRtZnNkU1Fic2dPYStT?=
 =?utf-8?B?NDRTdjhaWnlkUk01VkJ2U0V2RUhROTFMT3hGWTJzeU9IVEU5RDBDeFBtZE5p?=
 =?utf-8?B?R3k2UzV2a3pBNFRrdjJLR0pmaVRPMUx1WUNmNzFCMkR2UEhaM2lFN3VFaEtY?=
 =?utf-8?B?UnhrM1lqWEM4OEd1eFROUExjaUFqRGtISFR6YjdwOFJzSG1TNDlDblFWNktt?=
 =?utf-8?B?dTc1dmNvRGxrLzFod2QybmxkVTg3ZHFHNlpkUEt2SDFVNG91Tm1PQjIzY0lh?=
 =?utf-8?B?YU93NTBFbVg1d1lWQ0t1aDI5M3pXYmFCRi9KeXlmaVRrdllYakx4M2JrUGZP?=
 =?utf-8?B?Y3FDMVRjKzJmSU1GZUZ0SDc5RXk0ZTFPdW9NMGlnaktwUkVWcUdENjloblJz?=
 =?utf-8?B?Njh4S0NRREdpYWVRZGxIa3RRZTc0ZVloZ1Q3TGNJd2l6bWxyMFpDTnBTaHJQ?=
 =?utf-8?B?WlVNK1VxbmxlTjc2eWIvaHJwT3hMWkhORlNRbGJzcXFpRHZKK0lxRTdpRG9a?=
 =?utf-8?B?Y0xYblp3dTVHcElTbktVTmJMRDJrSUlRQ0dIQlhwb1ZFaWU2UjZjamRUaGhH?=
 =?utf-8?B?QkRRNGNCNkZJWHFyWldiczc4WUw3dFlBOWpGVzVBQk54dGZNaEFhYzc2YS96?=
 =?utf-8?B?MW96cnJZenA0SmpGZk40MGU0THd6dEhDeTRUcExJQW5XUmFSeGdxdFEzR1Av?=
 =?utf-8?B?U0ZicEk5bHdGKzNTdUx0TXlEWkxGNWJJY21PejBGTFdEWlkvUU1MYitNSmtD?=
 =?utf-8?B?WjFxZ2RqMlVCb0dlNjNRME1LWmdxbkViVXl3Z21aT05ZNHlzbEMzcC9uREpn?=
 =?utf-8?B?ZnhWYnkxS3hlSnkwVkdTeHhQMFNEb0FOd2hITXVUNnhzeVlGWnBhYnltNEZM?=
 =?utf-8?B?QlJLWDZpb2JibkloZkZGSXFOdHRnMFhod0F4ZzgxQkx0M3hjcU9IbnFpMy9T?=
 =?utf-8?B?YjZSWFVpa1hFUS83ZEpJYjcyczlSYmplbzlob203VDYxY25rQ1BmdEU4UVEw?=
 =?utf-8?B?RkJEbFBIajdwbU5JK1lZWFk5ckZTbXljRnl1VHRVT3Z1MEMxWXZqb2IyVVUr?=
 =?utf-8?B?T0U5MTJGY0NPeEQzQkU0UUhJa3dETWlTcGRHbXBKQklHbnBRL1RIU1FPSnhS?=
 =?utf-8?B?WTV5SXhBdDJGOFZEOGJVVElrWVEyY05MOHRybFdMemVzMW9uYkRJS1pqR1Vx?=
 =?utf-8?B?dEl5S0pGTjRyeHVmTXdTbWw1blBVbTVCODVEdVYxcjBYWFBFVE9ZMUFCYUFB?=
 =?utf-8?B?RUtFemVGblh2a0wrWC91YUY2WlRjdDNvaHd1VitOZmhmWW1McEpIZktIdEJu?=
 =?utf-8?B?eFZXbDRyNk9lQjM3SDlzLy9KejY0NUZtUUxoQ0dFUms3UHVaa0psWWkxcldN?=
 =?utf-8?B?emZ4WVk4NzBpQlhLWFczZHNJUW9mYmd6dWZkMUtkbjJ6RGxjR0lUZEh5cmN6?=
 =?utf-8?B?aENHVFEzRmRJZDA3NmxBK0NWUFp2VHJlTWV1ZG1wbnFaT1hhWG1mdk9nSkxr?=
 =?utf-8?B?NnVuOUp3Ryt2Tko4K0twWmJzeS8yUGx0a09IajZqdllYQlFZdnlRdlJpRUVT?=
 =?utf-8?Q?NAQMaLlITRgn45w9znNC8IpIoaZbCBpbWEYKw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF1108B6A08734F86F62D0813748EF2@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664881c6-4015-4b25-4c1d-08debbca6b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:31:59.1664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/TwDP4FQalNzd9mLZGpw0wgNoUdx4MmQcAUeOnJbcn/az4eGwY9smsnbZiXYLYVu8AohMbjG2d9BFTkDndaAmKeOk1vjgMbssVFeYyLjGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

QWRkIHRoZSBSSVNDLVYgcHJpdmlsZWdlZCBJU0EgZGVmaW5lZCBiaXQgcG9zaXRpb25zIGZvciB0
aGUgU3VwZXJ2aXNvcg0KQmlnLUVuZGlhbiAoU0JFLCBiaXQgMzYpIGFuZCBNYWNoaW5lIEJpZy1F
bmRpYW4gKE1CRSwgYml0IDM3KSBmaWVsZHMNCmluIHRoZSBtc3RhdHVzIHJlZ2lzdGVyLiBUaGVz
ZSBhcmUgdXNlZCBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nDQpNU1RBVFVTX1VCRSAoYml0IDYpIHRv
IGNvbnRyb2wgZGF0YSBlbmRpYW5uZXNzIGF0IGVhY2ggcHJpdmlsZWdlIGxldmVsLg0KDQpUaGUg
TVNUQVRVU19VQkUgZGVmaW5pdGlvbiB3YXMgYWxyZWFkeSBwcmVzZW50LCBidXQgU0JFIGFuZCBN
QkUgd2VyZQ0KbWlzc2luZy4NCg0KU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRq
b3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZy
YW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCi0tLQ0KIHRhcmdldC9yaXNjdi9jcHVf
Yml0cy5oIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgN
CmluZGV4IGI2MmRkODJmZTcuLmMyYTNlZTRiZjMgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaA0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCkBAIC02MjgsNiArNjI4
LDggQEANCiAjZGVmaW5lIE1TVEFUVVNfVFNSICAgICAgICAgMHgwMDQwMDAwMCAvKiBzaW5jZTog
cHJpdi0xLjEwICovDQogI2RlZmluZSBNU1RBVFVTX1NQRUxQICAgICAgIDB4MDA4MDAwMDAgLyog
emljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19TRFQgICAgICAgICAweDAxMDAwMDAwDQorI2Rl
ZmluZSBNU1RBVFVTX1NCRSAgICAgICAgIDB4MTAwMDAwMDAwMFVMTA0KKyNkZWZpbmUgTVNUQVRV
U19NQkUgICAgICAgICAweDIwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBFTFAgICAg
ICAgMHgwMjAwMDAwMDAwMDAgLyogemljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19HVkEgICAg
ICAgICAweDQwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBWICAgICAgICAgMHg4MDAw
MDAwMDAwVUxMDQotLSANCjIuMzQuMQ0K

