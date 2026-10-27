Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA2606BAA7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OluAQzxF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLify-0000Go-Cv; Tue, 27 Oct 2026 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xLifw-0000GE-0p; Tue, 27 Oct 2026 11:01:20 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xLift-0008R0-IB; Tue, 27 Oct 2026 11:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5EwGVTTI8ISwMiDnENLFFy8gG4YJccDF1ljAeVI2zFRM1HtkrfzaI93lrHVJYtAj3P4hqQR8bS6gnquVMjujifwCvXkOvvraeotSgD6AS1Muz91k0IjvgqdPOuRvKW5hOFqW8HGhBIf/yPnkFYebAKHvN7EKWSDt5m+N9ZoEf3xBrVYQTwSlRXcMT0YwFQWCM8NRlhjuRyotdruwLBrq2Z2HbGv4bWgdOjXL+JSEChN63yRYS2OMrHzACtFBwD1WxK86scdqFHzfCO1w6TCvGJnGB2Sdt3tQ4jU9nGC8edNIZIzTbfIqDbq7PQva8bldc2XXOuhRCUeBBq6glH0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1XAdx0r8cfj1MzHhit8726+y4l4IhhoSr99MspJUug=;
 b=ud8EO5/7dgXfwt8HPkLz1SyJoZXGJfoJC2dx75LcNxr+m/FYJ/6rpXl8MH09cZ0mjyih2P+I1GmWJ/VCg7T8t7vTInGYXBA7W4CrQGlgXyNPhUfyNUxIUscvDd0/UQdI01H5kOooctBqtoh7CW2fXhQRlZrBIDgI09OHIRdzblb81OFiXPV3b33eZ2pwJ4NNuJKlQKIWT2+V/BKb/HTRoZkjMzoJpqmZDHMdPy5B7mGFzd4hBDOBvah0rw0aqtIxNenEGi75pdSc98BzEfgaY1qq3KF4ho//aAXztKVsiLAv5cGeTUd+GNpwEbXwkm/iOirWwpCmxXC4RvOtuNxSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1XAdx0r8cfj1MzHhit8726+y4l4IhhoSr99MspJUug=;
 b=OluAQzxF6b4AP5nqSQjZDGppZXy2vxX5LtKr6Y9lFF/lwFXlGtVGsimICo2G6FH6YS87Eqn5vlNm/A2XcqtVvE1KkFCJ/rlzRcrb9aVFQa+zR6hKNaWzJI18MtWfaqT97ouiaRWoLezoOT1PmOB5c5CQRDvOQDiO9Sya6iPi7fnEV1XNANivxNy4yxq80XzkUekzZeLVWLpafH2AE0cQZ3u/B5Cm84YIwnA5/nhhoayE90BEInIJ5fBGKP7DbIBbxoS/qZe1Tfr0nstVmoKNKRk1eAcBczu038jBb362TyoR4yTAdX4MQgBASeqDvyIlj/DftRzWbb0JCE4IjGB+Pg==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:10 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:10 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Topic: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Index: Ad1kUFII4MKnDgaKRE22YiQ/acy/SwAFsFQAADP9ZyAAApnzgAABA1LwAAEayYAANm7KQA==
Date: Tue, 27 Oct 2026 15:01:10 +0000
Message-ID: <DB8PR04MB717789469E7A52109B5AC9E787602@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
 <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA_BNjFC4vEJ2h62NytzYQXKE0o4MvB2jpN74S05kHRLMg@mail.gmail.com>
 <DB8PR04MB717745592F89F86226B7E73787612@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA_z5n9obipm=jOieJD0VoSJOTN1MVpRdtHgEDDfq5SfUg@mail.gmail.com>
In-Reply-To: <CAFEAcA_z5n9obipm=jOieJD0VoSJOTN1MVpRdtHgEDDfq5SfUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-27T14:58:35.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|DU4PR04MB11006:EE_
x-ms-office365-filtering-correlation-id: 2b7e78fe-c8ef-42af-1c9f-08df343b22e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|1800799024|366016|22082099003|18002099003|3023799007|56012099006|4143699003|5023799004|11063799006|261026121527099003|261026140227099003|261021123027099003|10067099003|261021121427099003|261009223027099003|261022105027099003|261022113327099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: ycT82k+RCeSbJwa8Die38Mocj/H/HJswLe/msrQ3UnXlnzn5bNchzrSVr4Dll75qM4k+BSQh5uvERmEk9QVh50zYqGDXA/aqKqvbQYdF0sCHeOK7MZXdU/dBzlMAYApIQEGQr4ILytNCk2RInxAVwXNmkzso+ANToQ1axf+ZVX1GpkTzNHtEbB7hbHxX1Fi6aVYtsuKnwc2HUIN3Ayn1zajUAKrAfpAZjlidyWtzZQAgxd3Ox6vSigV6hH6Laf2GUmZh4iumqP896pMnzHY1oM6c1rZiw4qPKP2D9uqIsOxa52udVLKoj7PFYFRuW7SVERmT8fFAOb7g5d6luY2bS7EL0wu8eazYKDqXvlV6l64p/pRcmUMJVp1OXubdju4oT3efu2RlNOsJ8sZ4mtbLjBT7vi20HmdZdOUKKmBo3U25Z165iHxQ4UJG5K3tF2kcGHFgj3WUn5auQrTDxHylgGPr5SmMaApyxfMWScqP/En9zCGiVzvHFXqsfQFdpdKNSArtWQpIy7JJEd5pdi4JfZF3mWZoNHuuVDs0EBRUObZXYdjBoJYjZRTXtm4BrGEqKG8EkF4FUDucL8hDAZiUgi6OwVk0/A1Iy994g2H++CxhaGeXxDX3/u1RiVKdr/GZv7oiw0P29JwJxyYr1NLklgrXmiaoTek/JkdII6FIwqi0HghSJgPqttrP4vfPfW7clO7qySEoZOXUnO0EnAMb396WNm6xVcvtcI/vVU7Erv4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022113327099003)(261022075727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01CSmttWDZPT0J1VmtrZHdJZi9CdUhISFNIS091QkJPa1BqQXA0MTlZazcv?=
 =?utf-8?B?a3UvZ2h3TFpCbXFSMTZWUEpIL0N5U0dtQ2RJNjlVdUhZZGttbFhZT3BnSk54?=
 =?utf-8?B?ZlNzTGo4RW9sUUpTRHc4MjV4a1lkMUc2Y0FEU09nbGUyM0tMVENhVEo5dkdX?=
 =?utf-8?B?R1pIRUtXa0VsQzZvSnhlTXJQZ0Evay9jU2VHeW9rMjFoSEVzWHJqUldURHZS?=
 =?utf-8?B?aU5TcnptUzNsN0pMS3BUaVZNM0JiK3NROHhJczBIazJ4MmswUEdabnAvaVdF?=
 =?utf-8?B?bFpDQkJtc2dqaDU2d045YitaMmM4NGh1cmR6ZG9QNTU5SUdvcm9ZS054VG9F?=
 =?utf-8?B?cGRwcFpBUjIzamVCUjBCcXZkMSswbGFhWFhlT0pYcGpsRHJ2bmIzZkJMZnls?=
 =?utf-8?B?bjVrR3RkVGl3eUhGcU5NbTNRZzlMa0FZQm9leEpEOVdHR1lOSmJVN3R3WVIw?=
 =?utf-8?B?YXhWaDl3Ri8vWkhjL2NEcjZ5emFVYTBsRmRxUmhkTzlFRDNKSTJhZ1JZcnRC?=
 =?utf-8?B?TzJrbDlqeGs5MkdFYU9hS3lYR1E4alVXSDdNUEdWeWhvVit5bE40TzBIcVlX?=
 =?utf-8?B?NER6U2RXQUlubThnSm83M2RjekFBdEt1Y2JOVTF5TkdnVUZFNllVUktvYmxr?=
 =?utf-8?B?K3kzNU1PbUhNQzV1NktjelJ4VGgvWEtvYXBEMmh0UHZMMi9WenhBd3BMY2x6?=
 =?utf-8?B?dkc4R2ZKSFptYURnUnJuSW9LSHZRQVZmMnZVTGdOZHI2cVJxaUJwb05HcTJ3?=
 =?utf-8?B?UFRWcGFrOFBnTS8wK0U1cmVSdVVIdk11Q0tKaHlDSzhWUG80U3B3cVJvdSt5?=
 =?utf-8?B?RUJlbUs2R3k2SkpQbXRlMDFsVUtKaEhaenFjZXhXRFIyMUhWeG9qUUFuYzdT?=
 =?utf-8?B?azJrTjdsWjNmQjdrMEJvUjVEeDBLTWRFLzVJRWsxT0tIZWdNMTRSaWNtUmly?=
 =?utf-8?B?bldjS1JTTkhyUW5vbUtNbzlCWnZnK01iZzFwVmhaazR4a2c1RENxVHJnYjFy?=
 =?utf-8?B?NXJjYUVDRFJyenplc2JKQmgxcmpxK1JhSU5HcUhtOGh2YXZuTjFxNjcySHU4?=
 =?utf-8?B?NzR6Yk54bkFWeVEyL0h0eUdQT05KNjBVaUhtSFNvTnFkYlZOUHRsbWxCVTZn?=
 =?utf-8?B?TVBzcHRXZkZnekJySGtnSG9MOVJacVRkS1lTQ2hMV3d2S0hWQVJISVJUdm1Q?=
 =?utf-8?B?YXBJOGVOeDVvVlhVSUtMWjlhendaTlZWK0xtM0ZPdTBKMzlaRisvODd3TURr?=
 =?utf-8?B?bnlRSHhHcEhOa2NIQmo3RFlOZ0lEaE9aNFdib0xDTUNRRklvdG40SC8zZTdw?=
 =?utf-8?B?YXBPL3NOaXdqaEY2Uk14U2NuNUpCYkV1TjM3OTRES0lHVmpBaU52NUEwOFZL?=
 =?utf-8?B?NzJRWW1sSVFUNk1pUW9jVVRNQ0Uxd2l3clp6L1lIUDJlVXprd014Q2Q0VnRJ?=
 =?utf-8?B?QktOamZ3SFk5dyszV0hPbG44d2Znc0grTXFVWHVaclgyS3hOOVJFSis3b3Jl?=
 =?utf-8?B?ZEV0Z3UvaFl4OFpVV2FybGhENFlLU0h3Nkxsb3U1dzFJcGhSaUtWNkV0bENG?=
 =?utf-8?B?Y0FZTHNhdDFjWFBpVjB2Q0lYM0c5Tmh5T1FZZUhPMDR0L0pKQ0Nzdkd2emNi?=
 =?utf-8?B?M2FWNkM4dTVkMlUrSHZIcURjbll5TGQwZjJlQjNGTzJhVTJMT0dYVW01R2Vs?=
 =?utf-8?B?cHFQSDZFSFR5RjB3REJSUHB2VWI4bi9qcXNHMk1sb2tRbEtXeitMU2JJWTUw?=
 =?utf-8?B?dy9heEpxZzVwekJzUktNbSt5UmFHb0tpeW5jNnR2VldIMHhFQm14RUlaQ09U?=
 =?utf-8?B?WGtZTUszbTBDanpBcGZ6TkxKYStyZTBvQTlOZ1FPMlQ3MG5sNFEyYWdkNWRX?=
 =?utf-8?B?S25IOGtHbE1uaG1WMExxemdhT1JlL0g3OXhCNmRHc1kxT0ZBM0x5VlZLZWFt?=
 =?utf-8?B?UllUMGRkYVhOeEdiYzV4RDIzUTdqQW1HbmhKTUVEVHJYNmZUSUt4N1hoRGQw?=
 =?utf-8?B?eEhmTEl2Y0RMNkVyNkNLMGdTQmZVSXlVN0NTMU5KVzNKbVdMUU9vc0RkM09T?=
 =?utf-8?B?dlFzejROQStzdUo0V3NvbURVWHVmNjVvOHFJS3RzRXNhK1I1Vklrbng3T0dJ?=
 =?utf-8?B?OGdHQXhUNkYzQ3BuTWF3aWFlU0VVSWQ0YWNnVHRETGxWK3Y2NjMxNkxORURo?=
 =?utf-8?B?eWhSc1hGVVlob2hEKzdic241NFhWTGRRelZTaUR0OUpUZmYwd1VYZDh4Qk0w?=
 =?utf-8?B?SXo1UGd4d2c0MU5MbFFWakpCSU8yVkVFTDFmZnVEM1ZiaGwvZUtmVzBHbzNa?=
 =?utf-8?B?bW4rRWxrM0UvWm5VZFlhOUhwaG14czhTUmp4NE9SQ0hXWEtCTHViQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7e78fe-c8ef-42af-1c9f-08df343b22e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 15:01:10.3147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiHjNESCxZCokgnUhoA0bLfYNEMjSnf/U7kD/PNLBh+SC5XYwfLJ+0zE2Or7t1BGhHIEaElSvDWH9Zej6KChGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006
Received-SPF: permerror client-ip=2a01:111:f403:c200::1;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDI2
IE9jdG9iZXIgMjAyNiAxODozMA0KPiBUbzogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83
QG54cC5jb20+DQo+IENjOiBRRU1VIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBxZW11LWFybUBu
b25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1JGQ10gdGFyZ2V0L2FybTogQ29y
cmVjdCBNUElEUi5NVCBoYW5kbGluZyBmb3INCj4gaS5NWDk1IENvcnRleC1BNTUgQWZmMSB0b3Bv
bG9neQ0KPg0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFr
ZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMg
ZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBPbiBNb24sIDI2IE9jdCAyMDI2IGF0IDEyOjI5LCBHYXVy
YXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+DQo+ID4gPiA+
IFRoaXMgaXMgT1AtVEVFJ3MgZ2VuZXJpYyBpbXBsZW1lbnRhdGlvbiByYXRoZXIgdGhhbiBpLk1Y
LXNwZWNpZmljDQo+ID4gPiA+IGNvZGUuIFRoZSBpbXBsZW1lbnRhdGlvbiBpcyBhcHByb3ByaWF0
ZSBmb3IgdGhlIGNvbnZlbnRpb25hbA0KPiA+ID4gPiBsYXlvdXRzIGl0DQo+ID4gPiA+IHN1cHBv
cnRzOg0KPiA+ID4gPg0KPiA+ID4gPiAgIE1UPTA6IEFmZjA9Y29yZSwgQWZmMT1jbHVzdGVyDQo+
ID4gPiA+ICAgTVQ9MTogQWZmMD10aHJlYWQsIEFmZjE9Y29yZSwgQWZmMj1jbHVzdGVyDQo+ID4g
PiA+DQo+ID4gPiA+IFRoZXJlZm9yZSwgSSB0aGluayB0aGUgcHJvYmxlbSBpcyBub3QgbGltaXRl
ZCBzcGVjaWZpY2FsbHkgdG8NCj4gPiA+ID4gaS5NWDk1LiBBbm90aGVyDQo+ID4gPiBwbGF0Zm9y
bSBjb3VsZCBlbmNvdW50ZXIgdGhlIHNhbWUgaXNzdWUgaWYgUUVNVSBwcmVzZW50cyBhIGNvcmUg
SUQNCj4gPiA+IGluIEFmZjEgd2l0aCBBZmYwIGZpeGVkIGF0IHplcm8gd2hpbGUgbGVhdmluZyBN
VCBjbGVhciwgYW5kIHRoZQ0KPiA+ID4gZ3Vlc3QgdXNlcyB0aGUgZ2VuZXJpYyBPUC1URUUgY29y
ZS1wb3NpdGlvbiBpbXBsZW1lbnRhdGlvbi4NCj4gPiA+DQo+ID4gPiBCdXQgc2hvdWxkbid0IFFF
TVUncyBBZmYwL0FmZjEgYmUgdGhlIE1UPTAgYXJyYW5nZW1lbnQ/IFRoYXQncyBob3cNCj4gPiA+
IGFybV9idWlsZF9tcF9hZmZpbml0eSgpIHNldHMgdGhlbSB1cCwgZm9yIGluc3RhbmNlLg0KPiA+
ID4NCj4gPiA+IElzIHlvdXIgU29DIG1vZGVsIHNwZWNpZmljYWxseSBvdmVycmlkaW5nIHRoZSBk
ZWZhdWx0IHZhbHVlcyB0bw0KPiA+ID4gc29tZXRoaW5nIGVsc2UgdmlhIHRoZSBtcC1hZmZpbml0
eSBRT00gcHJvcGVydHk/DQo+ID4NCj4gPiBZZXMsIHRoZSBpLk1YOTUgbW9kZWwgZXhwbGljaXRs
eSBvdmVycmlkZXMgUUVNVSdzIGRlZmF1bHQgQ1BVDQo+ID4gYWZmaW5pdGllcyB0aHJvdWdoIHRo
ZSBtcC1hZmZpbml0eSBRT00gcHJvcGVydHk6DQo+ID4NCj4gPiAgIG9iamVjdF9wcm9wZXJ0eV9z
ZXRfdWludChjcHVvYmosICJtcC1hZmZpbml0eSIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHVpbnQ2NF90KWNwdV9pbmRleCA8PCA4LCAuLi4pOw0KPiA+DQo+ID4gVGhpcyBnaXZl
cyBDUFUwIHRocm91Z2ggQ1BVNSBhZmZpbml0eSB2YWx1ZXMgMHgwMDAsIDB4MTAwLCAuLi4sIDB4
NTAwLA0KPiA+IHdpdGggdGhlIGNvcmUgSUQgaW4gQWZmMSBhbmQgQWZmMCBmaXhlZCBhdCB6ZXJv
LiBUaGlzIG1hdGNoZXMgdGhlDQo+ID4gYWZmaW5pdHkgdmFsdWVzIGluIHRoZSBEVFNJLiBUaGUg
VEYtQSBwbGF0Zm9ybSBjb2RlIGFsc28gZGVyaXZlcyB0aGUNCj4gPiBBNTUgY29yZSBJRCBkaXJl
Y3RseSBmcm9tIEFmZjEuDQo+DQo+IFJpZ2h0LiBJIHdhcyBob3BpbmcgaXQgbWlnaHQgYmUgcG9z
c2libGUgdG8gYXZvaWQgaGF2aW5nIHRvIGdldCB0aGUgTVQgYml0IHJpZ2h0DQo+IGJ5IG1ha2lu
ZyB0aGUgYWZmaW5pdHkgdmFsdWVzIHlvdSBzZXQgb24gZWFjaCBjb3JlIG1hdGNoIHRoZQ0KPiBN
VD0wIHBhdHRlcm4gKGFzIEkgdGhpbmsgd2UgZG8gb24gb3RoZXIgU29DIG1vZGVscyksIGJ1dCBp
dCBwcm9iYWJseSBtYWtlcw0KPiBtb3JlIHNlbnNlIHRvIGdldCBRRU1VIHRvIGFsc28gaGFuZGxl
IHRoZSBNVD0xIHNldHVwLCBnaXZlbiB0aGF0IGJpdCBvZg0KPiBBNTUtc3BlY2lmaWMgY29kZSBs
b29raW5nIGF0IEFmZjEuDQoNClllcy4gSSB1bmRlcnN0YW5kIHRoYXQgcHJvcGVyIE1UPTEgc3Vw
cG9ydCBuZWVkcyB0byBiZSBjb25zaWRlcmVkDQp0b2dldGhlciB3aXRoIFFFTVUncyBnZW5lcmlj
IENQVSB0b3BvbG9neSBoYW5kbGluZy4NCg0KSSBkbyBub3QgeWV0IGhhdmUgYSBwcm9wb3NhbCBm
b3IgcmVzb2x2aW5nIHRoYXQgZ2VuZXJpYyB0b3BvbG9neSBpc3N1ZS4NCldvdWxkIGl0IHN0aWxs
IGJlIHVzZWZ1bCBmb3IgbWUgdG8gcG9zdCB0aGUgaS5NWDk1IG1hY2hpbmUtbW9kZWwgc2VyaWVz
DQppZGVudGlmeWluZyB0aGUgQ29ydGV4LUE1NSBNUElEUiBoYW5kbGluZyBhcyBhbiB1bnJlc29s
dmVkDQpkZXBlbmRlbmN5IG9yIGFueSBvdGhlciB3YXkgdGhlIHBhdGNoIHNlcmllcyByZXZpZXcg
Y2FuIGJlIHVuYmxvY2tlZD8NCg0KTW9zdCBvZiB0aGUgc2VyaWVzIGNvdmVycyB0aGUgU29DIG1v
ZGVsIGFuZCB0aGUgY29tcGxldGUgYm9vdCBmbG93IGZyb20NClJPTSB0aHJvdWdoIHRoZSBTeXN0
ZW0gTWFuYWdlciBmaXJtd2FyZSB0byBMaW51eCwgc28gSSB3b3VsZCBsaWtlIHRvDQpzdGFydCBn
ZXR0aW5nIGZlZWRiYWNrIG9uIHRob3NlIHBhcnRzIHdoaWxlIHRoZSBnZW5lcmljIE1QSURSIHF1
ZXN0aW9uDQppcyBjb25zaWRlcmVkIHNlcGFyYXRlbHkuDQoNCj4NCj4gdGhhbmtzDQo+IC0tIFBN
TQ0K

