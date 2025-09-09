Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1677CA1016
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 00:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvmGP-0003ZA-IH; Mon, 08 Sep 2025 20:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uvmGL-0003O7-OX; Mon, 08 Sep 2025 20:31:09 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uvmGF-0008HL-ME; Mon, 08 Sep 2025 20:31:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4okjLZPIR50cOWtkLGRIUrh4S7wsQ5mccQuseLun3pSetgAkBl0KidaAatwmR4KjB5D9AbihuOXnOiUjNQ3jcj/jsXeeK4Ro6bXUfJMTz6KfqFes8Sbd8J27f7+2NtIrEb7+UubDuKMsgGTiGOOt4Ijpbi3LfTE+KgFp/40CauUI0AWbzvi94W01rngr1X4ep7dCKIBieH3Wm5dXb/IfZPb2p4HFxLnT2ZR9UMYX4AEq131K/iizoRozDYhTgbcZ8LSc+Cp0/b7yRlibkY9v07PX/QD2JsUEbxSRSmR+BVzACkgFV2p97PF2sFRPQZWLzM5A2XqvPCUtR9u7MjzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSO/NF3RJC28VJ/w2ih0/FQqZ3zyPply7Z90TWAo2RI=;
 b=HUtaaq7k6N9i4wmJxWad8eTNyxs79S4aYAFBZgYWAf1aYtyVOEWxAIgGjr4J+Y4/vQOLOKznXeCG9+laBFgxf9mIP7EHOvENvL6J4HFCp+z33XRJzcj9O9jWFQUsPtZPzTIhkU16iVAoZrtdmzhdVyhaXsvYxPZq4FVlE/sMU3AQPM0YdSwNsF+cAUjYHDLW8v/qc8xJTY9IKff6rEiGpIJkiirsLsSffl7Hy8TVQqSlWiLGpSGYoaTRXeKU8HtXrtTY4/IFFVT2+uXPHyjDrhAKirPXgUrTkO2u63wWcqkpVsosD6gGitATLMfKCHY1eGbgvm3gPN994rDST62tBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSO/NF3RJC28VJ/w2ih0/FQqZ3zyPply7Z90TWAo2RI=;
 b=oX0NLNKwO3rZCl2z6lrhJrSHYWriUMUWYm6Ar/gwLU0xZBGMYWFwdkn1Y6RwRC7OMAIxK4uU+P+OjaRg1GPZ3uri8asXdQT7mA9Kf0JFm5gf9IrkUzK3zGb18ovm/oXf1ErfoyAIugJ2NO+eNeuu2ZwyNwtFe9c9YneCQiXvZgoxZVW2NnrmCIln2TMlvJUpBwF5Y1JkdxeKj2AoeJCHjNIOphLp4xpb5AmafD8YTto6eN5JDz/FsRwIfsxdXfAh3CKO+M7mD0zU3pAIhyEblKnpd+jfi1KtXVc6SVaqUWk0ACAhqH2SKZ8OUEXGysZp9p6UvikDb4hheJIQjzhMbA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB6508.apcprd06.prod.outlook.com (2603:1096:101:172::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 00:30:52 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 00:30:52 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "thuth@redhat.com" <thuth@redhat.com>
Subject: RE: [SPAM] [PATCH v1 0/4] tests/functional/arm: Update test images
 for ASPEED chips
Thread-Topic: [SPAM] [PATCH v1 0/4] tests/functional/arm: Update test images
 for ASPEED chips
Thread-Index: AQHcHYOD6xLzvRHE6ESGx+FNDPC5I7SJCIGAgAD9NaA=
Date: Tue, 9 Sep 2025 00:30:52 +0000
Message-ID: <SI6PR06MB7631BA054304EB6A3A798440F70FA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250904100556.1729604-1-kane_chen@aspeedtech.com>
 <a552ccb8-2498-45f9-aa36-5b34de868b48@kaod.org>
In-Reply-To: <a552ccb8-2498-45f9-aa36-5b34de868b48@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB6508:EE_
x-ms-office365-filtering-correlation-id: 952b6d98-4722-4164-ff82-08ddef3821ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?QkN5eE1HK2M0cGI4L2R1RTBlalA0cVMvWkJnWk43T1JBLzNHU0MrRmhsSGFh?=
 =?utf-8?B?KzJaWHRlb3NLb2xxL2lrc1BwMEx5NkJTQWFjVkVEZUpSQjR5UG1ibkUzd0ZZ?=
 =?utf-8?B?bEVSUHZJcng5NklVN1VKSUpTK0lmZDB5ODU1UHpvR2lVVEtxbHZoOHplTzU4?=
 =?utf-8?B?azFkYS9JUVZsdWU3bXZleWhnNkNyTmNucUJ6bXh3VzVqNWJVaE5RK1VSeXFZ?=
 =?utf-8?B?M1FFM09CRVg0em5Gb1lFS2ZmeVBheWMzWjhnNElUNk1UL09tK1B6QmZXdDZY?=
 =?utf-8?B?SVk4ZTluSXRyVWljNTFFMlgyaGpXbTlsbXIvKy9HajhKcjFFYmhPTlM3d1ov?=
 =?utf-8?B?Z0RtUElSZ3hYanBySGI5VFY5YjBHRFhtSUZVeGJObTROYU1QR3pVVkE2RUxr?=
 =?utf-8?B?V2YrbytvUWxVV0lnWGR3Zkx6QzBQdjl5emdxNDhJMHFiTkQ0c1ZvSlFCY2pm?=
 =?utf-8?B?dTZLWUd6RHRCMDRrZnladXZ3QlpRNHFBblpxQXZOOWQzekVpcVBaSEpQTXJq?=
 =?utf-8?B?MnZCZGJiM2JYeENHeXVqSlorRWIybGpPTUhnQmsrVmd4WDBiV2Fha1ZFdWd0?=
 =?utf-8?B?bmNXS3g2UC8zQmhqUnh2S1JEVFpZUVRBbjJwa0IrVVlQTHdrVzNyUE14QTBL?=
 =?utf-8?B?OGl1dzFxTzhwSUJIaTN6U2pIVHluLzRaMml0QW9JR0MwcHAxS1BzR0QzQ3Iy?=
 =?utf-8?B?WXNPelhBeUd1TE02VTdrSk5pMVBPRzMzTUZWNVJkdGdxODVZSGNya09Dc1p3?=
 =?utf-8?B?TWRKMlZNRVBDSkxBOTY4blJFOTZ5b2JTcFhQNmQ5MXhZVnZuTGJEVXA1M0RR?=
 =?utf-8?B?MG0vLytCeTd5MzdTU1cwU3JVTkwzWmFpK3h0ZmErd2xKR0pScHJySm8zV3BS?=
 =?utf-8?B?S1BhZ3BUdjk1MzMxY0VRTW1UUWU0UEVNTGZhazJSNERtNkJtYmJDdU9sM0hE?=
 =?utf-8?B?K2p4aHVhb2lnY3NQV0dVdzVsZnhicGYxM0lzTnFNYWF5WjBGdzI0QVRmVXBU?=
 =?utf-8?B?UWhUOE0zQnhaczZDQjU2Y051a1FvRWw0RHRENVJzOFh4L1JrTmNURDVaREVR?=
 =?utf-8?B?NURML25Rek10a3k1OW1lU2NpbzVlUHFhL3JCZzVQQ2Nub2Q4QnZHajQ4SEpp?=
 =?utf-8?B?UjV2L0FtOXBRaUlmSERTNUJhbTFYRXhycko2SmxyblJVK1BJUVZLYW0rN252?=
 =?utf-8?B?MDFYc3k2NVhjTlI5TDZneHVSTWttd3hMS2orckN4dDNGcmpORzAvaTM1dk9S?=
 =?utf-8?B?aEdOSmVxeFJmc0FnVnZ0NmZNWmEzdzdpZ0tiTGs0bkFFWHVXUjgxdVRmZUNN?=
 =?utf-8?B?ZGJvSm95Sitxb0kxa0FoMkhVK2NNK0pMSDNsTlE2WU5peDYvTkp2UG1ydE14?=
 =?utf-8?B?MlFVUTJMVHNjY0RuaFpoNGI2ZGpEVnJlRUJvZkN1dDRxakl6VE1BNnJGR1Rk?=
 =?utf-8?B?bEV5QWpxVE5TVkM0bWx3enB6MDgvTC9qaGNkbWFFUUpjNFJlSkJ5cUdWNzA2?=
 =?utf-8?B?ZWtRRG8vazdubm4wL2NMU05RZjhnVGNQOVNQMGNwd3BBMUNveEFUdHU1QVQ2?=
 =?utf-8?B?TEdSV2lWazhWOFZ5YS9SUExtMlRQMytvSnRTQzBFbE56TE5aME41a0FJclhm?=
 =?utf-8?B?SjNEaU9kM3hzT0F4ZDNuZkt0YUdXd2xxc3V6MlBqK3RVL1lJbzB6V2xGOThZ?=
 =?utf-8?B?SlB0ZWx0cXU4cFoyTHhuSS9yVzJWbW9kT0wwb1pFOVl3eXlVdzluU09vbU40?=
 =?utf-8?B?MC9ZMUVJVUk2cEljTVp6VTlKWm1pWjJId3QybnNGQkJ0cThtRGRmc0R6b0hy?=
 =?utf-8?B?ME1NTlRPNWRsZDhIZFA1ekhzUHpTNlNweUdMRHpwelhyMFMzbGhlSEsvWStG?=
 =?utf-8?B?ZW5XcjB5S1lmbGZic3Zvc3NGc05DOGhWMnk1VVk0MDZPWVdJSlRZbldWV3dC?=
 =?utf-8?B?dGloWnBlTlE3a2hRSnB1TFVzazZBdHEwMDNMaVlzWFUyb0FaM0FaODZXajN2?=
 =?utf-8?B?d25hYWp3aEl2S2hpNkNpRWpsdUN6SWZvcGIrWFB3T3lxVHhQL0tQR0dKYVlB?=
 =?utf-8?Q?KgWGro?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWR5ZFB3YUFYOWllcnQwUFp0djlEOEY3VTFqNVFhd1BFNk1EZEZwTW5MMmRt?=
 =?utf-8?B?YkU2M2J4bXVoYUpqSTRUL09IRjRnZXl4OXBUNHJ4RS9oWEJ5eE92ZEpDaUNK?=
 =?utf-8?B?d0llbGUraEJmUlc2aWlMYUUyRjJSSjQ5QndLMjV3R1hqbzZWV1cvanlxNDFV?=
 =?utf-8?B?T1J2UUxCWE5HaVhQdldHeGFJODlmaFhCVTRFL0dlaDJzK1BjRENFNVRzejdQ?=
 =?utf-8?B?TkkzOVo1NEhCNEdrL2hqZWtGLzhEL3FvZXRaQUk2ZVN3NEdBRkk0QTJuTUd1?=
 =?utf-8?B?RFA3MlozZFJlVEdpYnpNTmJ5SXRZdTY2eVRuRXc1TlMrci9jSjBOSElZbm56?=
 =?utf-8?B?Mk5pcFQzMjNGT2Z2UFZ4OU8ySTZLUHhSZVZUSGhmRkpCbU9HNjdZMGk1ek45?=
 =?utf-8?B?YWphKzZJUWpCSFJKeXJGTjNGL3ZOcVRiZnpoYWRocVJJemRDeldFZXpIdlY2?=
 =?utf-8?B?aWl3WlpONURzNWJKUThTaTBLQnhGZjJISjd6Y0N1a2Y5eTEwSlhlcmVXWEpG?=
 =?utf-8?B?ODVDUitJbFFYWDk1U21yeXVzZXNiUk56RVN2WERYSzc0RzdNTGk1Nk90SUlL?=
 =?utf-8?B?VVh3WlZsaUtJMW1jek42cVgyNUYrc2dlU1IrRWhLdVNNS2M2TXdNZHhvNUJM?=
 =?utf-8?B?d2RnTTk3SW95NzE3V3hQVCtwSVBPVnZpWU53RjdDU0hmUkRsUmJSS2ZCS0x2?=
 =?utf-8?B?ZE9DU2t4NUZMZ3NaUVZHSEVSNHJFSE5TcFZnaFRqK2hLTXFrREFuUDg0bXhy?=
 =?utf-8?B?dTRxbDJlMWZycGxmMDlMcVZaSi90T2IvYkJWRnlheHZ2ZnZCSWNZODg0cTF4?=
 =?utf-8?B?YTBzbERyNk82VlA3bHJoOVdsNnViNTRWWUlMR1NIVUZCcHFEZTlYWmVWcG9p?=
 =?utf-8?B?Z3R6dHExaEtHbEw5cktrRHpKRS9hRTg4Y2hCZDdPOFB2ZjJBOS9ubE84UThj?=
 =?utf-8?B?U1J4SnBrbmdyMDdaNVhBQkhGTU5RRysvcVRLQUdab21iejZIakZOSnNKUHYz?=
 =?utf-8?B?RDQrRFVNWlg1akM5SkJaZytEVTlDeU53SldhOVNMRWZENTluZHdNMGwxZUg3?=
 =?utf-8?B?MHdZLzdSTDl0YnJOeGNSVFZ2RGVDZjdWMjY0cUNtbGhHLzd2RU9HM2E0N2Fk?=
 =?utf-8?B?RXloZjU1WTQyK3o3Zkh6bDZ4MjJ3ekEyWU5RbW9ZSXFCMjl0MDI3djhSemZn?=
 =?utf-8?B?RHptOXd1TGM4QXNWaEhFQ3llUnpiRVJDeDNPQVVjRjNOOG5ZMGJVRVoyTS9n?=
 =?utf-8?B?WElLY2V4aUxjV2RVNGVUUENqK1V5WUZGWmpSekJNalBxRy9nM2M0YnRLMVdp?=
 =?utf-8?B?ejlDNXlNY25pd0FmY0QxbUpQNEtuSUNLU3J1WnNmQ3IrOUVNdndxMUZvaVkw?=
 =?utf-8?B?c3hpOVMrM2wwOGVwQksxZDdRRW5kYzlrSVNOS2pMYzU1aXFuazBLTmwzd0lP?=
 =?utf-8?B?UFlQVWJQYVY2K3FZaUhqTzhWV3hET3l5WlNvTUZwU2JnbHE2WGdhNGV5a0Yr?=
 =?utf-8?B?cWViWmViZXZucTJRM0I3Mmx5a1dpYmQ5aU1nK0c4dUV0WDNzZElXODcrMjUw?=
 =?utf-8?B?ZkhtQnp3dHRtVUZySVVWVmRtZW9Jdk1zSTM4Z1VvdjljSE4wUVlheitSQWNi?=
 =?utf-8?B?TURIZDVqczlWUjlWcHgwTXEzMEpRNi9JUGVDK2FKSTB6WFBQSmxxTm5ES0dR?=
 =?utf-8?B?Q1ZXNEZ3dEZyRjN2RzhCMmRSM3dpZjBMNzY0RFVYSDdWeGJrS2xwVC90bVpQ?=
 =?utf-8?B?RFFlRHI4bUU1WFVFcSt5bGJ5RW0zdlZFZUFVVHI2dXFGcVpodTNWVTRaL05x?=
 =?utf-8?B?QnpMdUVadXJmb2lHZnBtUEdud3RMajQydUZ5YlVmMGVBYTNMcEs4YjJSdmF1?=
 =?utf-8?B?ZCt5ZGxBSk4ybnFxWENqbnhMRExJUnJaUzFpanB2Kzg0SWp3NGtVMnRGNE9Z?=
 =?utf-8?B?TTFDK1BRRWNpd0QxRjZhTGMvWmNGbUVUL2llNjhpS1JaMUQzNk9RaWwvVmxt?=
 =?utf-8?B?TitBY0tsMGJ0NTJZM2RaUUVWZ1VmMUtXRDZUWDVkeTBHRkhZV1VuVC9SblhI?=
 =?utf-8?B?RjVNb3ZvdkNYLzMzaWVBdEJtQzNKV0R5NkRpMVZLcVRXZnBUcnN6dGI0U0Js?=
 =?utf-8?Q?faeJBhof8i9+50J4P0fhOaZrZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b6d98-4722-4164-ff82-08ddef3821ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 00:30:52.3657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AP4iqjUh051rTiV6e610PO9glIeeT4XxL+ph4N4TtmrHQUbEXbjrcZJpX5R62gEw70s2ZEqRzPXl2kMOjIxefOLz01WfByL+8nM3RVhQ01E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6508
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMsDQpL
YW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDgsIDIwMjUgNToy
MCBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBN
YXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5f
bGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5k
cmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47
DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyB0aHV0aEByZWRoYXQuY29tDQo+IFN1
YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAvNF0gdGVzdHMvZnVuY3Rpb25hbC9hcm06IFVw
ZGF0ZSB0ZXN0IGltYWdlcw0KPiBmb3IgQVNQRUVEIGNoaXBzDQo+IA0KPiBPbiA5LzQvMjUgMTI6
MDUsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBh
c3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IFRoaXMgc2VyaWVzIHJl
ZnJlc2hlcyBBU1BFRUQgZnVuY3Rpb25hbCB0ZXN0cyB0byBuZXdlciB1cHN0cmVhbSBpbWFnZXMu
DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGJleW9uZCBhc3NldCBidW1wcyBhbmQgdGVzdCBu
YW1lL3BhdGhzIHVwZGF0ZXMuDQo+ID4NCj4gPiBBbnkgZmVlZGJhY2sgb3Igc3VnZ2VzdGlvbnMg
YXJlIGFwcHJlY2lhdGVkIQ0KPiA+DQo+ID4gS2FuZQ0KPiA+IC0tLQ0KPiA+IEthbmUtQ2hlbi1B
UyAoNCk6DQo+ID4gICAgdGVzdHMvZnVuY3Rpb25hbC9hcm06IFVwZGF0ZSB0ZXN0IEFTUEVFRCBT
REsgdjAzLjAyIGZvciBBU1QxMDMwDQo+ID4gICAgdGVzdHMvZnVuY3Rpb25hbC9hcm06IFVwZGF0
ZSB0ZXN0IEFTUEVFRCBTREsgdjA5LjA3IGZvciBBU1QyNTAwDQo+ID4gICAgdGVzdHMvZnVuY3Rp
b25hbC9hcm06IFVwZGF0ZSB0ZXN0IEFTUEVFRCBTREsgdjA5LjA3IGZvciBBU1QyNjAwDQo+ID4g
ICAgdGVzdHMvZnVuY3Rpb25hbC9hcm06IFVwZGF0ZSB0ZXN0IEFTUEVFRCBTREsgdjA5LjA3IGZv
ciBBU1QyNzAwDQo+ID4gICAgICB2Ym9vdHJvbQ0KPiA+DQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFs
L2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMC5weSB8ICA4ICsrKysrKy0tDQo+ID4gICB0ZXN0
cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QxMDMwLnB5ICAgICB8IDEyICsrKysrKy0t
LS0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjUwMC5weSAg
ICAgfCAgOCArKysrLS0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRf
YXN0MjYwMC5weSAgICAgfCAgOCArKysrLS0tLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gRm9yIHRoZSBzZXJpZXMs
DQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNv
bT4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

