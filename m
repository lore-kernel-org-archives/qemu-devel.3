Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE7EF46C56
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mD5-0005aJ-Gv; Mon, 06 Apr 2026 11:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD3-0005Wc-9f; Mon, 06 Apr 2026 11:49:53 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD1-00021U-T1; Mon, 06 Apr 2026 11:49:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAMUIrdKPs4BnGlSuzO/ZjOtOnjHuE7KiJyOfjNb8AZMVPyXBopSTOhmuGOTM/J/KNC0dulFQXlC+fCbajPHm1yKWlksXkhCMDLBL612f8/eJEETIC7Y/zVmfiMtcWGWMehzg90leCYt25RC75PTZ3I1cBqhE3/fedLfYcbNgGOG/iF1PW+req6w/BjTc9gNBBdNDmW3UAWFfkCFbzdcmhJbALHsalgdf79ED4PeoJewccrwCYCawjd4NthJUCXj7EzmpqezJX7t7U1rlGbTqDTa57/9s3Qg2WxYxfl5/HRuuxGXCvr5lrjGPGg6d4lDNPrGA06bp9V+K0bZLJmS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFS2bocjopt9JcLptnVKBLFV3kuaoabxxjLxZXVHQu0=;
 b=k2/6JJ0enixHhUOTiJMcRz7Ej3DZRQqj3VlFFSY8sPU/9IaPU4ZdEMvT2RDBcDEUZCw/h0pJY9UsUX265WijFd+p4bU/cx7kaIzG5WfnMs6KsnLqMpN5kimpjj9Hx2qdNIpcog8CB0PINOd9+8xz9UXiWVX4Zz2N7xdtYZUmPCr2W3KuNQaVLfWPgwufqn9p/ofC3YFTa6Qnen5CmeDqeYZ2tz2Wtjf8H+ImQsIWO+ETDs1ljrbuUP8HLT1m0HpSADfVmv/Xu8j3xqVkCiyhrPmetWeUJhk7L8MP7wG8UPb8jlaq41u7HvtzOaqo+teNTmNBN85c3MrQjecy9S4nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFS2bocjopt9JcLptnVKBLFV3kuaoabxxjLxZXVHQu0=;
 b=jY9UaGTH433zuG6n4kPhkGum+qIr7HizDdOY3Vr5716KkuwnkxAP14pprx6sRTSfw2IwN+8p16Gtc3aP5xDudoY1BeWIaYVnT95kwYWCaRjOorX+5Nf9ji2JmcT1xaSOAQimrStaLhey/kESu4cV4vYsCcFf14Y2Wizxi9AoGMJ1wQsdnCczba35MvQSChuxlm3mSb8vr/tmnAElTdoR94ajpkVjo+Q40rlNQpkaIUFqeS8N9Sd9wA9lUSVSYBjoYvFWqd5pi4a4JI5wy1BddPKNI0xeuJwPVzIK20DN6OgzcHYLHgrUh/vn7PwO6omKwsvkBPl3e4ux831vQ8G7cg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:49:42 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:49:42 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v6 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHcxdz7F+GgfLpRZU2hzXBWhLs/DA==
Date: Mon, 6 Apr 2026 15:49:41 +0000
Message-ID: <20260406154935.144674-2-djordje.todorovic@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: ad2dff92-cfbd-4348-b9e5-08de93f41e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: we29LETso0f5TqCqnGLMwNDrEIurBW/iK5WE1O4NRCU9TNGQrUnOj79+tVFutGGYSH5VUkN4hIdeN3N0BSVwQLgIyO6w7iiiDef50NcXcqzA2rWSfp70xj8MUloqRl5JhexfzyP6JZHvdTF8OX1F5qAJ5kECxwkBSmWI1XmxgOn96ueiSUQRKXIsGTH0tzDccEt1VpIujJmeTyEEVq8Qn12k2ra8HCX7gei51l0rwrwN2b3T7zkZAnGeQg6qiMV0ieZC6uBY97wLIgjt4c5PNR2kd9se67MrVlmpYM+KQAuhPWs2waCGAVAtQinLPVb44ug/5zbpmuainZd/UT/dCbjCDrqA1Nh7MLg1gL9aCIw5L7i9VABLIoJI34iiNZm+ZBHZyzlrj/4kevK/m+jK0lHbkLIlHLWlKGEM1oZsIyh+XhD9If5z3iCKPBc8i0Nd/AMHpW1EaUZhLjKF+39RWxaCzxSoWwqVvChT1x6VFkjpTPLo4EzSPaoYqASVlNbj3g32OS1JP/t0+0qVDeWTi3XbeQ4qGyGh6uu5DSnJl6VXfJP0Cy6xiywuvfAYaWmnmKLTcEvBUjDk+L2EoDVUusExNZtPKrFYUbUu8BGNT0POlqxVnj1KfsCp7j2I72N7BVKLhwezeAsL4kAE3yvQ+9JX7M1gX0tA3J0jEBaA8VWZDaLsWSt13Ba8N6AuDk0kVErhDBapA4PFVi+5IgZtSHOowI/K7szAe4dvIVY2bAgsSQyZ//q1BFxn1UZ9U49zqGNtI3/E4LbA5VyusojSlwf1uvzNxr8xWN1Y6HoOwy4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFhqM2trWE4vMGhmYzJxb0JLenliekhjajArbnBtZThhNWFPdDZPZ0J5UkpX?=
 =?utf-8?B?RDNCYllmbnhBMkwrUFFvdWRIUHdiak84SllZK2FRT2ZPcHhrblZCdmNwcVUy?=
 =?utf-8?B?MS9vNFZBSUxWMkpiVUtUTzhiRVlGRll2TXhrc2pScUZ6SEdDV3J0KzdHK2o4?=
 =?utf-8?B?eWNKVWQzcDdMenN6SmtUU3NOVXBkc1l4RlFRdHVGMzBuZjM2anZhaENrRVlG?=
 =?utf-8?B?eTI4V0w0TmFsSGJULy9HTXg3MXhnanBoT3FyaTFSalk3NTZlTStLMDY3dVNM?=
 =?utf-8?B?Q1k3TGk4RnBkcFdnWEZQaG5KNW14Um5jeTQvczhWV0c3TGY3MGI2N3RQdWho?=
 =?utf-8?B?d3BMbDVXUklWejhuQVNtVHB6aytTUDk3bm9BVVZOVzh2OUVhaDRJclhYZFlz?=
 =?utf-8?B?ZkdwY1pRQ20wSFR4Z1IwRmRFNG9qbWVBUFhDNUJwSjFNczlzTWpTcVJ1bllJ?=
 =?utf-8?B?a0xZUXowQ2wrVnFqSDF4VEF4dGRLVUpkQ0dIcWZiTlJScm5MamVVdFBuNFZu?=
 =?utf-8?B?YW1Tb0xCY1hRVFVzZWN3MXR1SmhVYzFWUmYwSEVxVFlZMERYWE1tWWtlSHZv?=
 =?utf-8?B?NkpTN3dWNDJNbkEyOUtxdlJFN2NMdTZpRFgwUzRBUDFxWlNUN2d3ZC9OOEl1?=
 =?utf-8?B?elphVDlCc2pUaDhOSzBBY2x5aERZeVZ3KzduWUQ0elNTdlY3VU5lOEVqbGI5?=
 =?utf-8?B?QTFOVGRvcWg0emVMTko4dllHU1lDMDBLa0xRaXFaT3RIbkx2OE42T2lteHU4?=
 =?utf-8?B?NGNSZ3FRRWlDeFczSGp2aWZoMnl5MHFWenJrV2xEMWVUbnpiSm9oY0lSMEp3?=
 =?utf-8?B?VFJ6bHFrdXpGYThBK29yVTh1WUJJQmZYWUZQNkZLUnBUWS9MSTVsSnZCU1V6?=
 =?utf-8?B?RDl4cjIvNlVwZ09Scm94VXNINjZmZEllb1ZDME5jTkR1SFdnMnVNWmdvLzVj?=
 =?utf-8?B?T01MUlN6Y1JQNTBISVpMZm8wRWVacjhtZTVLMzlHSTlIOWNob2cydlRUZE9v?=
 =?utf-8?B?T3BmbjZqcHVlT2FZdGdHWHMyZ0lCOUJQWTdpZk4vN3g3TUxvZUVwYXF3alZB?=
 =?utf-8?B?U2ZyVUpuNmlHNnRLdWsxV0dSeE13RkpHRFdCWkkyUWExUVdSVWJoanpSdGZI?=
 =?utf-8?B?ZzA1Ni9Wdnlpei8vMjFTZ3hEazU2dXk0amRzbDBiWUs0SmRaVkhJYi9FR2Iv?=
 =?utf-8?B?U3BIQTk0NjhBV3hyZnBiOTBJZDZuaElzWlhaK2JEc05HZ3JiWEdXRktjbkpq?=
 =?utf-8?B?dVlQOE9OcW9pdWhkMUJpNHFkcGc1WUNxZXJ5MTc0Y0R0VWFPTHhPVmJUc3ZP?=
 =?utf-8?B?V0N6SkNGK3BLc3VWU08rS3Yrb1MrZE1QVlNKbERYMWI1Zlh2c05zVVg5bDhD?=
 =?utf-8?B?ZWlHRk1SbUZ5ZWwrWmhVdnEvL0Z4bFhTNGRIOElpZ2lWdkxPcndSWEdiRUdt?=
 =?utf-8?B?QXRyYkVmSGtJMU1SQ0lEU1BlR3FKTm0zRVVaSWt5MEZSTE1oT0x1QUJiVGgx?=
 =?utf-8?B?NGhSZjByTStnd2lkRncyQVJHMDRiT0hMaXF5MnJ5TG9IcStyUDlYZnZ5Tm1y?=
 =?utf-8?B?YUhMQXhGZDZrc3dBQ20rcTlrYTRuWmNKUHFYZHpSdER3UGU3cFBsZHNCcXVk?=
 =?utf-8?B?dzZ3Y3Vvc1BpNTY5NjJ6WWk1L3BGbFU4VTd4TW16N2l0OGo2eVZFMWl1UnJr?=
 =?utf-8?B?NUQ4djhlbVh5OFRHd1lPbitCTlE2MzNzQkUzbHpxOXJ5aGlubVZSam1sZjZq?=
 =?utf-8?B?Q0pPaW1xNVRKUkZvWHFjZWIwU1IzQk51TGUzWm0xZkxoeTZVc2dMR1ZVcEQr?=
 =?utf-8?B?bFFoQmtLZUFpWmo1N1hmcnMvSVVnc01YWnZSODZuRXVmZ2UyTVJOMnJKZ3ln?=
 =?utf-8?B?T1FJM1p4bEQxUEVLeHdObU8wOGtQSHlqYjV6Nk9xenhPaW5RcTFGVjkzaXFL?=
 =?utf-8?B?ZjBOYXpRNTl5TjZ0S3EzSjhETlNpR3JteTBKNWowS0IzaXJPbUdQTTFWRHpr?=
 =?utf-8?B?M3ZramJoVWNkVkl1d3NMbHdjQlM1TFFUWm9BL0Z3REVvdktRM2ZrSmdPM2lL?=
 =?utf-8?B?eUtWb1VHNnJPeTljV01qbUpRU2FiNUVzeitFL2Rsbk1jcVBuWDhNQ3JZLytQ?=
 =?utf-8?B?SVZVbHVPMjZNWnY0WDJtSDBWbmdMRGc1MzcxeDZYMGkyeEk1T0RBWWhCZFll?=
 =?utf-8?B?NHBlamtTRUViZWdXQno5OFFzZEhTczBJRi96N0k4RkEwR1U0UE9uK0xCMWcr?=
 =?utf-8?B?MnZnMzFyeFhJUnFSYWhRSC9pNTIwQ2NZeSt2RW52RWc4REcrcUQwRHBtNENa?=
 =?utf-8?B?NlNFUGFLSjVGNzI3aGlNamNnK0EwUWFBelNWdXQ5UHV0TGtpeWRXc2lyS0lO?=
 =?utf-8?Q?lIoUcQWQa+QZD8Y9nbRi5iWbgKuAnJGNUE0Jl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A81C358F35EF44188DE60D42CA0B69B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2dff92-cfbd-4348-b9e5-08de93f41e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:41.4602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/re0g/f+uTGU/CExZC00CwSlcbbT0eMfCzBZjpFwRrZkBN77jBD0N8P+Rmx4RkCX3WiLiuL3YLjSiA4JuB7GBdhWyn0d8rv/K3wnS9Pn7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9i
aXRzLmggfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0K
aW5kZXggYjYyZGQ4MmZlNy4uYzJhM2VlNGJmMyAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9j
cHVfYml0cy5oDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KQEAgLTYyOCw2ICs2Mjgs
OCBAQA0KICNkZWZpbmUgTVNUQVRVU19UU1IgICAgICAgICAweDAwNDAwMDAwIC8qIHNpbmNlOiBw
cml2LTEuMTAgKi8NCiAjZGVmaW5lIE1TVEFUVVNfU1BFTFAgICAgICAgMHgwMDgwMDAwMCAvKiB6
aWNmaWxwICovDQogI2RlZmluZSBNU1RBVFVTX1NEVCAgICAgICAgIDB4MDEwMDAwMDANCisjZGVm
aW5lIE1TVEFUVVNfU0JFICAgICAgICAgMHgxMDAwMDAwMDAwVUxMDQorI2RlZmluZSBNU1RBVFVT
X01CRSAgICAgICAgIDB4MjAwMDAwMDAwMFVMTA0KICNkZWZpbmUgTVNUQVRVU19NUEVMUCAgICAg
ICAweDAyMDAwMDAwMDAwMCAvKiB6aWNmaWxwICovDQogI2RlZmluZSBNU1RBVFVTX0dWQSAgICAg
ICAgIDB4NDAwMDAwMDAwMFVMTA0KICNkZWZpbmUgTVNUQVRVU19NUFYgICAgICAgICAweDgwMDAw
MDAwMDBVTEwNCi0tIA0KMi4zNC4xDQo=

