Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B699606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kdyCSOdf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLIqs-0007ae-KL; Mon, 26 Oct 2026 07:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xLIqm-0007aO-Kb; Mon, 26 Oct 2026 07:26:48 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xLIqk-0000wS-GG; Mon, 26 Oct 2026 07:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD6GEpIM+SOxyRf6p2HIvZzCDsAdI7BX/AEuyJVQM4jkyPZstX5vH5hnxoUIWEBV2BBwgxCXbkECfwNcJZdsn8bKg/aG/oaSpDzEi4eIL8j/cso8ExihNQgJRd8AtFhqHqucxEx8bDwJLxVSam0AmpcL+IwzlCgAqELMprEniOGaPb8lfeTZ0msUZrqCGsMDywm/3TJjKh7y+/NSZRWEVCSAJDLsYBuDS8m8byN0Aq2B4peCclG1hJOV1GFdxFuNNhVwKJ8rTo5XW+2q4o7ocuzwA6si2XZn90+Z8AhPJvlvxsG77Ctxgqlj3o6XKDGXMh5llnAC8EB23qie5II7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIUw8nip8p0H1JYzQkLO3bfE/5OG8xuKguEO71ePzcU=;
 b=ef8ZF4HoFRLFwSFWZF4kftoByoQRnFVSyIytbuWFq8zAfNSqkGXu/kAoYi4VfYNaIU0rKb4OMnyysg2PWaEk6pFrNpPkaePqFUew6AsPgxZKo086blvtRoLbSmh8Ah69eO2InT+X6sdsz3E/0vaepWUDwH9pyllGGMpqOcVyh6iuHRacpenEMVTYn4guvDZft6AcY5vaC4fwmlxBcgmrJ6ODAICSvgLpI1DXulAAwaHmnzmnysHmwRf83By6JMAA1YB7iPLMRFcA4B2TPEEv8OWK06AKfWb5CylSFz/jT+pUGo1snt5Qa88fMtcnABd0rUxZNEjr8eh+ePOl0FGeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIUw8nip8p0H1JYzQkLO3bfE/5OG8xuKguEO71ePzcU=;
 b=kdyCSOdftXpQJYTc9a1ZjJIy6yTm0Kv82d9Ap2poHx6TqrDP1zmgf+kknGMVwsCcdAZTk2XFf+Cg38o/SrhOUeZXZ2fe4dELBg5QWOUO+B21152SFkr8ZkTXKNIUIpiO1r2Sv/nrULepVjfnD6chrn150T+VlpbBb4+hgMJF5zbwEBXWPcaWqpaPF2uABZuLkRVnB+4j/7xFeN+VdPy6N6k/FUxoQCALNgFs2EQLEYvdUxOIh6iT0FKjLcC2hYCNoKHUbug4la38akeMIxpIaeHbUHMcgoRR6V6pZdH+36b0bdZIj3JzaeCQXHR+/bDuBoB92F6CypqDIkK9qdczRw==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by AMDPR04MB11651.eurprd04.prod.outlook.com (2603:10a6:20b:71c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:26:40 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 11:26:40 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Topic: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Index: Ad1kUFII4MKnDgaKRE22YiQ/acy/SwAFsFQAADP9ZyA=
Date: Mon, 26 Oct 2026 11:26:40 +0000
Message-ID: <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
In-Reply-To: <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-26T10:44:53.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|AMDPR04MB11651:EE_
x-ms-office365-filtering-correlation-id: b55253c9-2d1e-41be-6293-08df33540168
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|376014|1800799024|6133799003|22082099003|18002099003|4133799003|38070700021|56012099006|11063799006|5023799004|4143699003|261021121427099003|261022075727099003|10067099003|261021123027099003|261009221227099003|261009223027099003|261022105027099003|261021133027099003|261022115727099003|261021130227099003|261022113327099003|261021135927099003;
x-microsoft-antispam-message-info: s8cNLYXMVd2GNjVq3Ctz7HGZNsLTH4Bdvzz8RCEkq+tw6b7wL24e0/ji9T9q2PgZ44+HzQ17IXZJ+hDHsQZS52h7Key97uy/XjFLqTPKnUoxwOFV1Y9ickqWcl0UoVFyLdjVseVVmdvxMh2yJK3KMifU4g5oMNbF1nzUyaZjR9W4j9H3S8p3e3fZ8ReK+mAiCPYiJTkpG4NsDjs2yCaVCnbRR/sgX1jqf4m1Q+ibO6K5KLD4HRUdXCj5jOH+02ckixzIuzvRi4nhHuNZFmj7nuQpi/SfMNQyRkCNPD9OzZBnpc688wsyH15ZQhS1K5HCMoWKNtwNQuxb6SOGG1ZRB+RiB7CgQvTPu1NWxsM1ihFWiNSPaEen06NA4RvQlQFGtCly7JInPOPMk1zyj3ITcZ2e2fQdBZR5Ja1F4pNxzz+39kyvqh4khAPY+uYfNqzroA0jWVSt5mlPQDW1swOcex4+Sx1S6RifBpHRTMf1QFPbRu8txplhaoFSkYHLsc0+fGS7Dmy2yox/ZDBZ2YxTMRF+ypMscZRe1+CO64t8UspRmgP+1zUU58m55VfNClrux/ts1stmNQdapjZ+V1qZSEZVg4tfNqI6oEeWePsU8eu+t1l7YQAFT0MAoW4/r+0amvWrQWOmdiAF61eoRc3Srj4U5leO1PpHy4+6fWYkXvw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4133799003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(261021121427099003)(261022075727099003)(10067099003)(261021123027099003)(261009221227099003)(261009223027099003)(261022105027099003)(261021133027099003)(261022115727099003)(261021130227099003)(261022113327099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDlkQjk2bEFwZU5pczk0d28zalE1VlJOeGlYcHpwNzdGUzFxbUFLNVdGRndC?=
 =?utf-8?B?d050akxVNE5kREE0N3JyUittTFNXbnNpNG1XRnlEUGpnaXZ1L0RuSFBMRWsz?=
 =?utf-8?B?YjNlZG5zQ3VxUi84VlppU3VJV0JKY1JDaGhFZXJIM21HVjhSdXhqOTFOcDBD?=
 =?utf-8?B?SmM1bFlnRGlwVi95OWhZUVBQRmw2eS9ZelNyZVRyVlN0VzRMRlNZM2hBWnA4?=
 =?utf-8?B?TkJmRTN3ZnpQQWFyY3hrWlBLZnJyNTA5cHVMeGlZUElqWUkrWWFaeEdCeWpz?=
 =?utf-8?B?WHBUK2NhS0ZYRVpHMGhFOXZNanhhU25HV3FPdzN5NWFLdHB5NUl2SDU1ZitY?=
 =?utf-8?B?MkdpVTlhdXUzR0ZSSHMzV295RkdMRlVHV0RuUkMwUlFzVDVWNms1Y3hKeDVu?=
 =?utf-8?B?dUZ4bWFpaGF4ZG16YTkzcURsenVhLzlyaTVUSkZpRkNlK3VUdUdGLzNCZUdJ?=
 =?utf-8?B?MXRIQXh3OE9vK3R0eWhpNUMzZkxVaGt1c0RKNmFLK1pQUUVZWTdQZXRtaGg5?=
 =?utf-8?B?QXZ5ZGNLUUQ5OWhWOWp1ZU1iRE00NnYyT1AyMTdLTjl2K3pMaHIvTll1SEc3?=
 =?utf-8?B?TEFlK2Jsb09wZ2MwNUUrMjU3ZkNQMTlKT3FuaFFXTXV3ZlRQMVVNVS9XUWtW?=
 =?utf-8?B?dEJoVER3cFlvcElOTVhtUldBSE4yZ0ZCbk1qZXZNL0k5QU1UQUppNTVTdUxq?=
 =?utf-8?B?V0dmQStJeUZXTFJzTWZWa1VWeG5nTGZxNXVtaXI2aWlaRmdPNld6dUEwcjMy?=
 =?utf-8?B?NUFHU3RhOHZFaWN3S0lHdVJCQ2FYOUFlNHpkeDVJUXJNQUdYcWdnMFd0WG9y?=
 =?utf-8?B?a0dFL2tiUUNOS3hJRGJzaXkzNTdoUzlsRERCa3BNYmJXNHRaRUVONFhWWTRV?=
 =?utf-8?B?eUVlRFp1VjZmQ1hXTHAybTVxNkpZdnVVN0VuOHRJclZmVlBwaVVDTWV0MHdr?=
 =?utf-8?B?NnZhZkEwaERnNkZGVm5ENENwVUJOaFNCenVzNDNEWG1CN3BycFZuU1Z5Uk84?=
 =?utf-8?B?a01Ub1dqU3ZlU0d0OUNxbUh3YzZJNlA3Y1o5TTlOSzFVSjFhVGU3eFNMR1VH?=
 =?utf-8?B?ZkRoeTJuMndhSE9HK2QveENPdlY4V3V0YjhxcVZseUZRV25Vdk05d0ZCNG9r?=
 =?utf-8?B?QlF4akZhWXQ1SUxlQitMV3ZZSXRBZ1gzUUNycnVKVmsrZ3Yrc3JhSzc3bWhy?=
 =?utf-8?B?djFvRm1nZmh6OE1sZWszOXhabzZqMlVyRkV6bExCQ3N0VVJXdVhSYU84azB1?=
 =?utf-8?B?bmx5QmprdzZzM0NWdWVidVV5bE5ETjhQNGJNWi8wdHZTaXdIR1NmRDRPakdq?=
 =?utf-8?B?eHByd0U3bHNPcklaL2JmbXlwOEJlT1dpL3BOcU8yNW1VQmttQUZXSFZmYllu?=
 =?utf-8?B?anpFdVZLMFBTeDlyQ3RWK0plckZaWWZsWUUraFAxZWYzcGptYXNxSFlsdW9M?=
 =?utf-8?B?dmdsaXlqeXVhWGV5elRsL2c5Z1pzNm1nQW1FbXlHdE1pWnZxa0lxcUg5UG5w?=
 =?utf-8?B?bWNIbG9saVVEelZDWGxFajJpUXgyTW8xbk1JZG5SL2pRZGM3ZlRwRzN6dEVJ?=
 =?utf-8?B?cjgrb0w0L281RDE3Y2FEYStqaWdGWlBYSXViOUpvTkxsV3p0K1FYK05DM2Nx?=
 =?utf-8?B?V2Q4NGlmRE9NQi9SWnFWc21ON2QyNWVVU2V4VkhXWW1mRHk4VTdqdEVNUDhh?=
 =?utf-8?B?NGE2dVh4MWNsZGRqaFpVaTEweXFXb3ZQTUh3TGFvRTllQjZaUlRWR2gxS1p6?=
 =?utf-8?B?RGJuRHdKd1NsNFh0USsrdmVCN3BwOFlXTHIyanh3dXcyZEdWSHZBUFd1SkQ2?=
 =?utf-8?B?cGt2R05PQTlsNDIvMWJabm9nSXJhdEJ2WEVOaEJJSVJ3WXlLL1ZPSkc4UFJZ?=
 =?utf-8?B?alFyRy9KMlEwOXVpOU1KbGNsMFdPcFE3bVpXSFRXUXRYdkN3S0lvL2NNMk1q?=
 =?utf-8?B?alUyVHArSkJ5V3VMc1k2VjZqS25RYko5NUJrUFhPWE5NSkNFL3lwOG43OXV0?=
 =?utf-8?B?WjIwUEFYVSt6WnI0bkpRWUlyeDNyS1hqUDA2dlFSUGd5eXZXM2tjd3Z2alBr?=
 =?utf-8?B?dDhRTWhQYkV0NzJDT21qVEVXWFRsZEpoQ3NTYlFPL0t2R21hbWV0V3ArN1pz?=
 =?utf-8?B?WU5TTXdMV2R6V09nR1M5Z3dzdzZCQnNjSmcwVjJmUlQrMnZZM0JIZHVVbEto?=
 =?utf-8?B?c1MyN092b05yWnk3VURFNVRtRGZPakxNcVFNQ0IrWk5JUnp3T3IybHE0blJl?=
 =?utf-8?B?L3lGalBrUlp1Uk82bDJqS0lJL1ZtcVI2blhpS1k5Q0tScVRQdzJCczZzWUdB?=
 =?utf-8?B?N1l4Zkd3SlNYbWlFUyt1YnN5WTg2cFE5eDROdTRtOFRWbkFNZ3ovUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55253c9-2d1e-41be-6293-08df33540168
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 11:26:40.3750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reURvnGAWg4Ccak/oPccTUAm5HQdHXcRf0WbArauBNhafENgPBs3juY/7w70TcTFYW2eWkFwHe8CyOzxY3bGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11651
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDI1
IE9jdG9iZXIgMjAyNiAxNToyNg0KPiBUbzogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83
QG54cC5jb20+DQo+IENjOiBRRU1VIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBxZW11LWFybUBu
b25nbnUub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUkZDXSB0YXJnZXQvYXJtOiBDb3JyZWN0
IE1QSURSLk1UIGhhbmRsaW5nIGZvciBpLk1YOTUNCj4gQ29ydGV4LUE1NSBBZmYxIHRvcG9sb2d5
DQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNh
cmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGlu
IGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFp
bCcgYnV0dG9uDQo+DQo+DQo+IE9uIFN1biwgMjUgT2N0IDIwMjYgYXQgMDc6MTQsIEdhdXJhdiBT
aGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiBJIGFtIGxvb2tp
bmcgZm9yIGd1aWRhbmNlIG9uIHRoZSBhcHByb3ByaWF0ZSBzY29wZSBmb3IgY29ycmVjdGluZyBD
b3J0ZXgtDQo+IEE1NSBNUElEUiB0b3BvbG9neSBpbiBRRU1VLg0KPiA+IEkgaGF2ZSBlbmFibGVk
IGFuZCB0ZXN0ZWQgaS5NWDk1IG1hY2hpbmUgbW9kZWwgdGhhdCBib290cyB0aGUgY29tcGxldGUN
Cj4gTlhQIGZpcm13YXJlL3NvZnR3YXJlIHN0YWNrIGZyb20gdGhlIGVtdWxhdGVkIGJvb3QgUk9N
Og0KPiA+DQo+ID4gICBCb290IFJPTQ0KPiA+ICAgICAtPiBTeXN0ZW0gTWFuYWdlciBmaXJtd2Fy
ZSAoU0NQKSBydW5uaW5nIG9uIENvcnRleC1NMzMNCj4gPiAgICAgLT4gQTU1IFNQTA0KPiA+ICAg
ICAtPiBURi1BIC8gQkwzMQ0KPiA+ICAgICAtPiBVLUJvb3QNCj4gPiAgICAgLT4gTGludXgNCj4g
Pg0KPiA+IEZvciB0ZXN0aW5nLCBJIGFtIHVzaW5nIHRoZSBZb2N0by1nZW5lcmF0ZWQgV0lDIGlt
YWdlIGZyb20gTlhQJ3Mgb2ZmaWNpYWwNCj4gaS5NWDk1IFlvY3RvIEJTUCBhcyB0aGUgZW11bGF0
ZWQgU0QtY2FyZCBpbWFnZS4NCj4gPiBpLk1YOTUgcmVwcmVzZW50cyBpdHMgQ29ydGV4LUE1NSBD
UFVzIHVzaW5nIEFmZjEgYXMgdGhlIGNvcmUgaWRlbnRpZmllciwgd2l0aA0KPiBBZmYwIGZpeGVk
IGF0IHplcm8uDQo+ID4NCj4gPiBDdXJyZW50IFFFTVUgcmV0dXJucyB0aGVzZSBBZmYxLWJhc2Vk
IGFmZmluaXR5IHZhbHVlcyB0aHJvdWdoDQo+ID4gTVBJRFJfRUwxIHdpdGggTVQgY2xlYXIuIEl0
IGlzIG5vdCBzdWZmaWNpZW50IGZvciB0aGUgaS5NWDk1IGZpcm13YXJlIGFuZA0KPiBMaW51eCBz
ZWNvbmRhcnktQ1BVIHN0YXJ0dXAgcGF0aC4NCj4NCj4gVGhpcyBpcw0KPiBodHRwczovL2dpdGxh
Yi5jLw0KPiBvbSUyRnFlbXUtcHJvamVjdCUyRnFlbXUlMkYtDQo+ICUyRndvcmtfaXRlbXMlMkYx
NjA4JmRhdGE9MDUlN0MwMiU3Q2dhdXJhdi5zaGFybWFfNyU0MG54cC5jb20lDQo+IDdDYzA0YjE4
Mzg0ZGI5NDM2NDU0YmIwOGRmMzI3ZTNlNjYlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMN
Cj4gMDE2MzUlN0MwJTdDMCU3QzYzOTI4NTE4OTk1MDY1OTExNSU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDgNCj4gZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFp
T2lKWGFXNHpNaUlzSWtGT0lqDQo+IG9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3
QyU3QyZzZGF0YT1IT0R6THVOc0RKUHdiR0MNCj4gYVlGMlpUWWxxdEpEdnZEcDF4b2pvY21RdU1W
byUzRCZyZXNlcnZlZD0wDQo+DQo+IGJ1dCBmaXhpbmcgaXQgaXMgY29tcGxpY2F0ZWQsIGJlY2F1
c2UgaXQgcnVucyBpbnRvIGNvbXBsZXhpdHkgd2l0aCBob3cgaXQgc2hvdWxkDQo+IGludGVyYWN0
IHdpdGggdXNlci1zcGVjaWZpZWQgQ1BVIHRvcG9sb2d5IGNvbW1hbmQgbGluZSBhcmd1bWVudHMu
DQo+DQo+IFNvbWUgb2YgdGhlIGRpc2N1c3Npb24gb24gdGhpcyBvbGQgdGhyZWFkIG1heSBiZSBy
ZWxldmFudDoNCj4gaHR0cHM6Ly9sb3JlLmtlLw0KPiBybmVsLm9yZyUyRnFlbXUtZGV2ZWwlMkYy
MDI0MDQxOTE4MzEzNS4xMjI3Ni0xLQ0KPiBkb3Jqb3ljaHkxMTElNDBnbWFpbC5jb20lMkYmZGF0
YT0wNSU3QzAyJTdDZ2F1cmF2LnNoYXJtYV83JTQwbnhwDQo+IC5jb20lN0NjMDRiMTgzODRkYjk0
MzY0NTRiYjA4ZGYzMjdlM2U2NiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZA0KPiA5OWM1YzMwMTYz
NSU3QzAlN0MwJTdDNjM5Mjg1MTg5OTUwNjg5MjgzJTdDVW5rbm93biU3Q1RXRnBiRw0KPiBac2Iz
ZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0
ek1pSQ0KPiBzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNk
YXRhPWpSJTJGdW03dw0KPiB3V3VDVEMyWFNMb1ZHMFBrRWxIejQzamExR2Q4RiUyRk51V1U0VSUz
RCZyZXNlcnZlZD0wDQo+DQo+ID4gV2l0aCBNUElEUl9FTDEuTVQgY2xlYXI6DQo+ID4NCj4gPiAg
IC0gVGhlIGNvbXBsZXRlIFJPTS10by1MaW51eCBib290IGNoYWluIHJlYWNoZXMgTGludXguDQo+
ID4gICAtIExpbnV4IGJlZ2lucyBicmluZ2luZyB1cCBpdHMgc2Vjb25kYXJ5IENQVXMuDQo+ID4g
ICAtIENQVTEgcmVhY2hlcyBMaW51eCBzZWNvbmRhcnkgaW5pdGlhbGl6YXRpb24uDQo+ID4gICAt
IENQVTIgdGhyb3VnaCBDUFU0IHRpbWUgb3V0IGFuZCBmYWlsIHRvIGNvbWUgb25saW5lLg0KPiA+
DQo+ID4gV2l0aCBNUElEUl9FTDEuTVQgc2V0IHdoaWxlIHJldGFpbmluZyB0aGUgc2FtZSBBZmYx
IGFmZmluaXR5IHZhbHVlcywNCj4gPiB0aGUgc2FtZSBjb21wbGV0ZSBib290IGNoYWluIHN1Y2Nl
ZWRzIGFuZCBhbGwgc2Vjb25kYXJ5IENQVXMgcHJlc2VudGVkDQo+IHRvIExpbnV4IGNvbWUgb25s
aW5lLg0KPg0KPiBUaGlzIHNlZW1zIGEgYml0IG9kZCBhbmQgbWF5YmUgd29ydGggaW52ZXN0aWdh
dGlvbiBhcyB0byB3aHkgZXhhY3RseSB0aGUNCj4gc2Vjb25kYXJpZXMgZG9uJ3QgYm9vdC4gV2hh
dCBRRU1VIHByZXNlbnRzIGlzIGFyY2hpdGVjdHVyYWxseSBjb3JyZWN0IGV2ZW4gaWYNCj4gaXQg
ZG9lc24ndCBwcmVjaXNlbHkgbWF0Y2ggdGhlIHJlYWwgQ1BVLCBzbyBpZiBpdCBjYXVzZXMgc29t
ZSBiaXQgb2Ygc29mdHdhcmUgdG8NCj4gbm90IHdvcmsgcmlnaHQgdGhhdCBzb2Z0d2FyZSBpcyBw
ZXJoYXBzIGJ1Z2d5IGFuZCBwZXJoYXBzIGJlaW5nDQo+IHVubmVjZXNzYXJpbHkgc3BlY2lmaWMg
dG8gdGhlIGV4YWN0IENQVSBiZWhhdmlvdXIuIE9yIGlzIHRoaXMgcGVyaGFwcyBhICJEVEINCj4g
ZW5jb2RlcyBhZmZpbml0eSB2YWx1ZXMgdGhhdCBkb24ndCBtYXRjaCB3aGF0IFFFTVUgdXNlcyIg
cHJvYmxlbT8NCg0KSSBpbnZlc3RpZ2F0ZWQgd2h5IHRoZSBzZWNvbmRhcmllcyBkb24ndCBzdGFy
dCB3aXRoIE1QSURSX0VMMS5NVCBjbGVhci4NClRoZSBmaW5hbCBEVCBwYXNzZWQgdG8gTGludXgg
aGFzIGNwdUAwIC4uLiBjcHVANTAwIHdpdGggcmVnID0gMHgwMDAgLi4uIDB4NTAwLCBtYXRjaGlu
ZyB0aGUgbXAtYWZmaW5pdHkgdmFsdWVzIG9mIHRoZSBRRU1VIENQVSBvYmplY3RzLiBTbywgdGhp
cyBpcyBub3QgYSBEVC12ZXJzdXMtUUVNVSBhZmZpbml0eSBtaXNtYXRjaC4NCg0KVGhlIE1UIGRl
cGVuZGVuY2UgaXMgaW4gT1AtVEVFLiBUaGUgaS5NWDk1IGJ1aWxkIHVzZXMgdGhlIGdlbmVyaWMg
Z2V0X2NvcmVfcG9zX21waWRyKCkgaW4gaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9v
cy9ibG9iL21hc3Rlci9jb3JlL2FyY2gvYXJtL2tlcm5lbC9taXNjX2E2NC5TLS4gIFNvLA0KDQpX
aXRoIE1UIHNldCwgT1AtVEVFIHJlYWRzIEFmZjEgYXMgdGhlIGNvcmUgYW5kIEFmZjIgYXMgdGhl
IGNsdXN0ZXIuDQpXaXRoIE1UIGNsZWFyLCBpdCBhc3N1bWVzIHRoZSBjb3JlIGlzIGluIEFmZjAg
YW5kIHNoaWZ0cyBldmVyeXRoaW5nIHVwIG9uZSBsZXZlbCwgc28gQWZmMSBpcyByZWFkIGFzIHRo
ZSBjbHVzdGVyLg0KDQpXaXRoIE1UIGNsZWFyIC0gT1AtVEVFIGdldHMgdGhlIHdyb25nIGNvcmUg
cG9zaXRpb24gZm9yIENQVTIgKGV4YW1wbGUgLSA4IGluc3RlYWQgb2YgMiksIGxvYWRzIGFuIGVt
cHR5IHBhZ2UgdGFibGUsIGFuZCBmYXVsdHMgZm9yZXZlciB3aGVuIGl0IGVuYWJsZXMgdGhlIE1N
VS4NCg0KVGhpcyBpcyBPUC1URUUncyBnZW5lcmljIGltcGxlbWVudGF0aW9uIHJhdGhlciB0aGFu
IGkuTVgtc3BlY2lmaWMgY29kZS4gVGhlIGltcGxlbWVudGF0aW9uIGlzIGFwcHJvcHJpYXRlIGZv
ciB0aGUgY29udmVudGlvbmFsIGxheW91dHMgaXQNCnN1cHBvcnRzOg0KDQogIE1UPTA6IEFmZjA9
Y29yZSwgQWZmMT1jbHVzdGVyDQogIE1UPTE6IEFmZjA9dGhyZWFkLCBBZmYxPWNvcmUsIEFmZjI9
Y2x1c3Rlcg0KDQpUaGVyZWZvcmUsIEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgbm90IGxpbWl0ZWQg
c3BlY2lmaWNhbGx5IHRvIGkuTVg5NS4gQW5vdGhlciBwbGF0Zm9ybSBjb3VsZCBlbmNvdW50ZXIg
dGhlIHNhbWUgaXNzdWUgaWYgUUVNVSBwcmVzZW50cyBhIGNvcmUgSUQgaW4gQWZmMSB3aXRoIEFm
ZjAgZml4ZWQgYXQgemVybyB3aGlsZSBsZWF2aW5nIE1UIGNsZWFyLCBhbmQgdGhlIGd1ZXN0IHVz
ZXMgdGhlIGdlbmVyaWMgT1AtVEVFIGNvcmUtcG9zaXRpb24gaW1wbGVtZW50YXRpb24uDQoNCj4N
Cj4gPiBJIGZvdW5kIFFFTVUgaXNzdWUgIzE2MDggYW5kIHRoZSBwcmV2aW91cyBxZW11LWRldmVs
IGRpc2N1c3Npb24gYWJvdXQNCj4gPiBDb3J0ZXgtQTU1IHVzaW5nIE1UPTEgd2l0aCB0aGUgY29y
ZSBpbmRleCBpbiBBZmYxLiBUaGUgZGlzY3Vzc2lvbiBzdWdnZXN0cw0KPiB0aGF0IHRoaXMgc2hv
dWxkIGV2ZW50dWFsbHkgYmUgYSBnZW5lcmljIENQVS1tb2RlbCBjb3JyZWN0aW9uLg0KPiA+DQo+
ID4gSWYgdGhlcmUgaXMgYWxyZWFkeSBhIHBsYW5uZWQgcGF0Y2ggZm9yIHJlc29sdmluZyB0aGlz
LCBJIHdvdWxkIHByZWZlciB0byBhbGlnbg0KPiB0aGUgaS5NWDk1IHdvcmsgd2l0aCBpdC4NCj4N
Cj4gTm8sIHRoZXJlJ3Mgbm8gcGxhbm5lZCBwYXRjaC4gU29tZWJvZHkgbmVlZHMgdG8gdGhpbmsg
cHJvcGVybHkgYWJvdXQgdGhlDQo+IGludGVyc2VjdGlvbiB3aXRoIHRoZSB1c2VyIHRvcG9sb2d5
IHN0dWZmLCB3aGljaCBoYXMganVzdCBuZXZlciBzZWVtZWQgdG8gbWUNCj4gdG8gYmUgd29ydGgg
dGhlIHRpbWUgYW5kIGVmZm9ydCBmb3IgYSBjb3JuZXItY2FzZSBvZiAid2UgZG9uJ3QgcXVpdGUg
ZG8gd2hhdA0KPiB0aGUgcmVhbCBDUFUgZG9lcyIuDQo+IFNpbmNlIHlvdSd2ZSBmb3VuZCBzb21l
IHJlYWwtd29ybGQgc29mdHdhcmUgdGhhdCBkb2VzIGNhcmUsIHdlIHNob3VsZA0KPiBwcm9iYWJs
eSBsb29rIGFnYWluIGF0IGl0Lg0KPg0KPiA+IE90aGVyd2lzZSwgd291bGQgYSBnZW5lcmljICdt
cGlkcl9jb3JlX2luX2FmZjEnIGxpa2UgcHJvcGVydHksDQo+ID4gaW5pdGlhbGx5IHVzZWQgYnkg
dGhlIGkuTVg5NSBtYWNoaW5lIGFuZCBsYXRlciBleHRlbmRlZCB0byB0aGUgb3RoZXINCj4gYWZm
ZWN0ZWQgQ1BVIG1vZGVscywgYmUgYSByZWFzb25hYmxlIGRpcmVjdGlvbj8NCj4NCj4gSSBkb24n
dCB0aGluayB0aGlzIHNob3VsZCBiZSBtYWNoaW5lLXNwZWNpZmljLiBXZSBrbm93IHdoYXQgdGhl
IENQVXMgd2hpY2gNCj4gc2hvdWxkIGJlaGF2ZSBsaWtlIHRoaXMgYXJlLCBhbmQgaG93IHRoZXkg
b3VnaHQgdG8gYmVoYXZlLg0KPiBXZSBwcm9iYWJseSBuZWVkIGEgUU9NIHByb3BlcnR5IGZvciBi
YWNrd2FyZHMgY29tcGF0aWJpbGl0eSBmb3IgdmVyc2lvbmVkDQo+IG1hY2hpbmUgdHlwZXMsIGJ1
dCB0aGF0IGNhbiBnZXQgc2V0IGJ5IHRoZSB1c3VhbCBiYWNrLWNvbXBhdCBtYWNoaW5lcnkuDQo+
DQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

