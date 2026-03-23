Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EF9D58CBD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Tp8-00018F-L0; Sun, 22 Mar 2026 21:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w4Tp2-00017d-2R; Sun, 22 Mar 2026 21:11:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w4Tp0-0002Wg-Cp; Sun, 22 Mar 2026 21:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPWeehd882RwYg/aJzMmgtZt9xEhnFTe5yAlv4ZHwiExDDAznVfSLK4pGLPSCorxIf+fhAfWALZSC9CITpG8iR8xdwYWI6BGJrKIyUIIjoiwPrtG7HI/6rEByZSdlfj2RnNyyY4erBdg+K/nDtsJeVLiK+C6v2zqdH8ZCmC8JZ3ZGzhUu2M+TbCDX6kgIV7zXCQfQBXpzOPnDJ4R/SG3ktBZ2DvEwg/ej2tR9nRid1qF6qdTpRPXd6Vv/NQPw9HwX8jFoTr+FTPi0vsttA3YpX4Ki2pt7r1BuGcqEbpg3u5cns14lxL9y3Lexrg7teghzJ7kbYZNAQ7MJBVC6XfrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld54+NbKwY4xtsirsWVCNlFaWyD8edF9USWQcL4iNZ8=;
 b=T05tmu4mprTKzeyNLGlDQV9LzvU+VZXFgAKsNJKDfYDQd23upQhkP+yz9j8JUcF+ftYg3oNQ2bgoRNYT3Qwa7zVLHBgOgr9k6ifKgkd7fps4ZKhkM4cilxGPTkdHW6p26IBb+0Qe6U5W9uinQhFwzozEvUjgOCjpgfq6tDF1RJA+H1m700Ff7TIpSDju7lz/sU+1fxFpKpMnRanqLg2PFCJlqLt9/6CMhOkhng7O3/Nq5FjX0SZPtl56HmTMQBpvHOspvfTsEbqagR9PmwnPVVo3vYYsMMBZLz4hWSF6pI/tOl9XOZTZN43NPRQYv8VCLKV22n1PM5ZczPCiuw0jZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld54+NbKwY4xtsirsWVCNlFaWyD8edF9USWQcL4iNZ8=;
 b=UBQs8eLmER9mbUnciQZcXvXQnxTKTScIeGOwVv/PjF3IbctYpGgSuisauTesRAnwvoRBmQdbiTQTpz3PqBGV26L47kkRX0dZpEkOWgDgl0g3zoAG59eXChqySRiBLRH1dJFdhuuPBHK0XAJvgUlxKSQqB5C+MWk4jMnxAqEL/T29WGEWsDItFQY/OX9NP1i+M6ZKETzUglzhiK8ZO98WgyJZArbhHYKgbLZQtbJy7uuZQnlvKozblEp8+0L4g3kq4fndoKSjnjq4L+9/YA5KMp4t1wXjWm5gTM6Guvyv2LWuonu3UK5I0dVMLxecZ+DL0wiShA1pkHp2Ya4+anhzEQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB6851.apcprd06.prod.outlook.com (2603:1096:990:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 01:11:03 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:11:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH 3/3] hw/i2c/aspeed_i2c: Remove assert
Thread-Topic: [PATCH 3/3] hw/i2c/aspeed_i2c: Remove assert
Thread-Index: AQHcukbvGmJeKkWLIEiimFlH0LtRpLW7TzPw
Date: Mon, 23 Mar 2026 01:11:03 +0000
Message-ID: <TYPPR06MB8206DDC6B2599FF40FE34FB5FC4BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260322215732.387383-1-clg@redhat.com>
 <20260322215732.387383-4-clg@redhat.com>
In-Reply-To: <20260322215732.387383-4-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB6851:EE_
x-ms-office365-filtering-correlation-id: 5529927b-e50c-455e-e187-08de88790d7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 5GXWX+HmcLI5wNnmvImIuNxmJkpPft1ZS9HLus2IAs1kLZvFGO8tPQNfmyOneyYSkz6TNG088mCorbO1yr0WTSU5gcYrCjV1zsGNq8ihMapDFM0el2ie9nCGfy+7SqReKo5rSOBz/mUlx0/NjPlu+JQkXI631aB/4rzUEahyGaO1frbY4r4i+a32eOXMHyCpUeKfwrm2TYchFi4jkad4+Q9t/VcOEhwjk+LikRggH0AKJ80NNFoODBWNq67+KL3n7ISXNgJLtNdVvMgVhKwnlYR+vKq3ezkUn0+khu1EQX7Xui2WUfsztOmRU4SbCRy0qfBZ+u2IAODt8JvjJ14FM4GA1IdqSulZYF3kdlf2cJUDe34VaPj1GlYs7AfbWXm3z7/0e1wKg3KZmXqryZo32/HuXq6ihG/c2WS67A5Vx/zIWEZxH4RoJam/xGX8G2wHtB1iknOrhRvZR8+bfRlGA8zwGSYr6QQrO2xJzU858M3vZQDokW9sM1S8WaSvGb2aMi4btYt1qPWp1t5PFUdXbwqjlvlMZGiWVfryU0GEib5TmanbJxEdvvAzaAFPKqoEByJHvqXTmsKCcBE86hQXYXoHkvnnd73HvvvN2iQ9kBo/H/hFUB5KqnsHWOAfa2zfevo09L8kRUeupe6/5naMCeV27DeNQllaImVjA1q3hOfIdclwKUIOvS2KTma0e99snA1umVly/nk+ocsjK1G5LfgVVj3L7Au06oGm1tPPFPUnPFrsnvXqvOw1hjUeViYXq6e7I6Eun7l9HiXp8HgouCHdZW+WvY3XRNJ0+mebcC8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWZYQTJSNWtMd2NLa05QNmZTWEIyUlhJdmdQWE1lRERYbGdaZEJDSFJ6K0t2?=
 =?utf-8?B?V0pqMnViWnk2Zkp2aGdWdWIraVpydXgweTFxZlo1QWU1UjRJSW9qdTViWHlu?=
 =?utf-8?B?bVlyZ3dXalU0c1BvcWtSZ2tVR1lCem5UZTVjU0VMYlFwUlUvZlZGVS9jTU9G?=
 =?utf-8?B?TUxtYUdJYkpMWi9rOFdzS21paUFtZ0dRZUU3eTd4UDFpVU5kWkxiWkFYMHFj?=
 =?utf-8?B?bDVWMmhPY0pGQW5IZWVieXNnbXBhRWI5RjVKUFRHNU5rUytabmNQcHNqQXI0?=
 =?utf-8?B?akNmZlVmUnVXMWdJNy9XV1Z3aXFlL1hLMHBWVWN5WVpmRTJtSEcxNVJDcjhw?=
 =?utf-8?B?a29jU2pUOGtzd2E1eVVDT212ejBqNmVYYTJHRzBqYnZ5WVlucFBPbkNSMlpZ?=
 =?utf-8?B?Wkw2QXM4am9MamZPTlVMV2l2cHVzU3ZlQnJBK0p5RkdJTHpyQ042UWtTMy9J?=
 =?utf-8?B?Tk5ZOUJMVXJJYXBZcEJhZThyNjg0dXNnamR2dWMvdHVReTYzU2FBT2hJMW5n?=
 =?utf-8?B?Q0NNWDlua1d1WEhvaWxWTW00YVpQdGtZcWs0cXpDRGdDdzNEQUFCUDZpdGhR?=
 =?utf-8?B?eGdwWUpHNjA0SzVtcHJKRW9ob0NBOVJzaitKdktWaFJLWmI0WkFwRXVzY2pq?=
 =?utf-8?B?VTZNZW9iVUxiK1pFMlpIZDFFTXBGTEV4YUdhZ2ZRWllPS29JSEVqYTg4VElX?=
 =?utf-8?B?b1VhdEVBY3JlQURjYkFNajFHRjNmcE8xNTRQNlRRT2MveFBWTkJvTjlxRnhu?=
 =?utf-8?B?NlNacnVLMHNsSEFnWVFHanJXRllTekVTcHVzVkt3RCtoRExNM29vMXVMWUpT?=
 =?utf-8?B?ZzBGcWlSZ3NRRWZnYW12Z09OcytZdUdvK056WWZGZ2F1VnRSN3BlUGM0aDlV?=
 =?utf-8?B?Wk9UOHRzQ3dLYk9kSm1Mcy9OMW9KekNOTmMvOWg2T1ZBODM2c09iOHpQeHJx?=
 =?utf-8?B?UkRucEdwWHFPMlV1M2ozcDgzL1hnMDczbUUrSkkyZ2FXS0xScW1kUDBoVTBH?=
 =?utf-8?B?d05TV1F6NWQza2tEN3JxZzFtVjZqR21PV0Q1dGdURWlYWjdsODJkWGFUaEhn?=
 =?utf-8?B?M0R3RDRYS1VCcnlVbjZqZG9heG1CMHNkeHVHLzEyVDltc3BKbFlvSHBoY3NR?=
 =?utf-8?B?NzE1UjhFaVltVDV6M0VSMVpjY2xDMWNBUDAyRjNPdXJLMWMxNHVIV0NFQXJ6?=
 =?utf-8?B?cWpCaXgwNzdBdURMcEZEZ2s3YklOaGJpdVhxMlIvWGNySW9udk5IbUhoekhp?=
 =?utf-8?B?MmhMdFR0TGNqTGJWNE1DSkF3QU5zRndIMDl1Ty93NERoTmZaTmdCNnZpcGlY?=
 =?utf-8?B?N1d4VC9YMnMvbFF6VXBFbFI1TEFmVk0zdHBlREE5VVFobXk2dEJLeW56MUxO?=
 =?utf-8?B?Y2pmaFZFVHdIdXpsYUtpelY2eWRISnhiRUFlL2VmZmJhbGV6N1F5cUFsSnNv?=
 =?utf-8?B?RkxUbEZJQjU5VzJiTjdacDNnRmN1N2dEayszNHI4cE5NQS9QUnZtZUwxSkIy?=
 =?utf-8?B?dTNoZzZhM2ZGTy9yazhQRUZ6VzBPMnZ4SlV5S25Tc3ZRVjBpcTdzWUcwVVlZ?=
 =?utf-8?B?ZzdzQ0hndzNGM3NRdU51OUJsREdZYVlzU01UMEFNQU9ueStXZkxadHg0bCtz?=
 =?utf-8?B?Ny9TVTNENDJOeEVWSVNubXVFSllrb0dHMExhUVl3MS81aDlqQUVkQ1hRMVpV?=
 =?utf-8?B?bC9aeHFDam9qaG93TE5vODZzSlpwTTJiK012Z3cvQ25QdTJyWEJnd0ZmZzJt?=
 =?utf-8?B?N3IydWpXY2E0NUIrdUhVWWVHZ2RDMTN1RmdGY0lIZG80bGI2bUlEMFEyd2t0?=
 =?utf-8?B?aGt1cSthclJpT2ZxUnpseUFOS05HeDNKM2hQVW9ZNTFTYUVQQk5RQW9IMUpw?=
 =?utf-8?B?K1hjV3RUVTN6K1NJOXFtZStxbldPRzZZVW5QejFXZWU1dXQwVk1QQVZFSUVx?=
 =?utf-8?B?UStacGpISUkxeFBlTWtEVVM0SmNFSFpuYnNxMjB4a2F5QUxnNGFBQVZTVTh4?=
 =?utf-8?B?OSttMEpwa3N6Rnp4NGdaVkVhWjRYWFJYUlRIYjErN1laQzduWGZwTHBmWC9V?=
 =?utf-8?B?S2xxVGZqc280NS9XRTdXZDZHbGFVUzBKMStvbkt6czR4bzRCckJDUXZSOXF0?=
 =?utf-8?B?bEVrT0hSalVwQW5LUnQxa2lrU1NsMTNTMEZRUnpJNTNkSjE5ZzJDOCtDN252?=
 =?utf-8?B?SzR2b2JzYkRlMHFqL29IY3RUS1lSdzhuUXQ2bnJPWmhpb0ZwZDRqdHU0d1cr?=
 =?utf-8?B?djIrYjV5UHBTL3BScVpJbGcxVDVQQzFmTnFTbjJDcDByN3BqUDhoK2hlenlk?=
 =?utf-8?B?ZWpDMUEyYkl5WnBOQ3hBWDJWT0JhaXBrZFZVV0hmbW9VdmltOXRUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5529927b-e50c-455e-e187-08de88790d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 01:11:03.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7DWEDirZppzijih+pZwbTu7jUbx2opYVg2ARppG56FAmsJsazRQD5PLFn46bsUP9rEJEjKJsHgjyf746qt/rRiUqZn+IWWchqAJHF6mQfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6851
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjMsIDIwMjYgNTo1OCBBTQ0K
PiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBQ
ZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBKYW1pbg0KPiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2gu
Y29tPjsNCj4gQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMy8zXSBody9pMmMvYXNwZWVkX2kyYzogUmVtb3ZlIGFzc2VydA0KPiANCj4gQWNjb3Jk
aW5nIHRvIHRoZSBBc3BlZWQgZGF0YXNoZWV0LCB0aGUgUlhfQlVGX0xFTl9XMVQgYW5kDQo+IFRY
X0JVRl9MRU5fVzFUIGJpdHMgb2YgdGhlIEFfSTJDU19ETUFfTEVOICgweDJjKSByZWdpc3RlciBh
bGxvdw0KPiBmaXJtd2FyZSB0byBwcm9ncmFtIHRoZSBUWCBhbmQgUlggRE1BIGxlbmd0aCAoVFhf
QlVGX0xFTiBhbmQNCj4gUlhfQlVGX0xFTiBmaWVsZHMgb2YgdGhlIHNhbWUgcmVnaXN0ZXIpIHNl
cGFyYXRlbHkgd2l0aG91dCB0aGUgbmVlZCB0bw0KPiByZWFkL21vZGlmeS93cml0ZSB0aGUgdmFs
dWUuICBJZiBSWF9CVUZfTEVOX1cxVCBhbmQgVFhfQlVGX0xFTl9XMVQNCj4gYml0cyBhcmUgMCwg
dGhlbiBib3RoIFRYIGFuZCBSWCBETUEgbGVuZ3RoIHdpbGwgYmUgd3JpdHRlbi4NCj4gDQo+IFdo
ZW4gc2V0dGluZyB0aGUgUlhfQlVGX0xFTiBmaWVsZCwgdGhlIFRYX0JVRl9MRU4gZmllbGQgYmVp
bmcgc2V0IGlzIG5vdCBhbg0KPiBpbnZhbGlkIGNvbmRpdGlvbi4gUmVtb3ZlIHRoZSBhc3NlcnQu
DQo+IA0KPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0v
d29ya19pdGVtcy8zMzE1DQo+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBody9pMmMvYXNwZWVkX2kyYy5jIHwgMSAtDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3Bl
ZWRfaTJjLmMgYi9ody9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+IGFkNjM0MmJlYzBkNC4uNWQx
OGY4ZDQ5ZWE0IDEwMDY0NA0KPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ICsrKyBiL2h3
L2kyYy9hc3BlZWRfaTJjLmMNCj4gQEAgLTc4MCw3ICs3ODAsNiBAQCBzdGF0aWMgdm9pZCBhc3Bl
ZWRfaTJjX2J1c19uZXdfd3JpdGUoQXNwZWVkSTJDQnVzDQo+ICpidXMsIGh3YWRkciBvZmZzZXQs
DQo+ICAgICAgICAgIGJ1cy0+cmVnc1tSX0kyQ1NfRE1BX1JYX0FERFJdID0gdmFsdWU7DQo+ICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgIGNhc2UgQV9JMkNTX0RNQV9MRU46DQo+IC0gICAgICAgIGFz
c2VydChGSUVMRF9FWDMyKHZhbHVlLCBJMkNTX0RNQV9MRU4sIFRYX0JVRl9MRU4pID09IDApOw0K
PiAgICAgICAgICBpZiAoRklFTERfRVgzMih2YWx1ZSwgSTJDU19ETUFfTEVOLCBSWF9CVUZfTEVO
X1cxVCkpIHsNCj4gICAgICAgICAgICAgIEFSUkFZX0ZJRUxEX0RQMzIoYnVzLT5yZWdzLCBJMkNT
X0RNQV9MRU4sIFJYX0JVRl9MRU4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZJ
RUxEX0VYMzIodmFsdWUsIEkyQ1NfRE1BX0xFTiwNCj4gUlhfQlVGX0xFTikpOw0KPiAtLQ0KPiAy
LjUzLjANCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KDQpUaGFua3MsDQpKYW1pbg0K

