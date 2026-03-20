Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC55D1098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQT-0002mp-GB; Fri, 20 Mar 2026 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQM-0002kp-WF; Fri, 20 Mar 2026 11:06:07 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQL-0002Q3-AI; Fri, 20 Mar 2026 11:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg+DqSoj3JOjShdbFrC39KDoSK1gXEycOwpYSeX9FtEjnFUE9U7uKR6ae3aV/3+0dggLypZdIHpS/M4wx+D5juvRofuOLdFa7x69PQW01J54Virk8cHtvQC6h7e6d22TQuL/IBFiY9hFMtr/6FWxHhV2pn5VG9/YQ/6kvDsAVruSC4D9AJwcNVuszfwYrSP40zNgi/PeEQruyR2xzOSJm8vpaTqz/IVVLVwb5IXhbBpeBYyvjfxRLLRwwTvMlC1O5akxrNudQDNzzf2gUfaGr2hQbM6/rRAf4EF3nL+nfspZkOmB5GHxJqSyTsIuz5SaCADDQKWNPsxWLCOZF6O2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFS2bocjopt9JcLptnVKBLFV3kuaoabxxjLxZXVHQu0=;
 b=ljUKr8mcAqBS3fqSWf8etoeGTikun5fNFXoUTShqVI9H7JXLDTSSJ2dJUU769mW8uPkF2F94rtz1L8EbbVd/pLKAkhh+Gh8uYbEB5voLozklJlyxosi++HJWtFQmwCvan9fsel61Cm2F8aY/8br7bdx4ozsnX5TXZ9glPCGaEdlZkf+lBK+L68hBoIXWbSN+SiswILKoig2mZAjpuvOY2tD8jHCDb5esnVefYcYtvHo1HEzCVVDlFRkuGc403XpTG9TcN54Ia5tsri9Y0u4U5WAHhzWOtpPQHL8aYrGQMtJiCsQM9j+SjHS8MWLcBLQDj6Tydf7aWuFiT2T5bQBV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFS2bocjopt9JcLptnVKBLFV3kuaoabxxjLxZXVHQu0=;
 b=R3Y8SQfRTlNH8VNjVUE6erUXF3aq7xbmPi9wmva4X7wZQ5e92onN/AE9P9J3hgs/CrD7OnjBVrVvx5fEdIU8NPiDFTJGTPOJSHcoo2LQgbpuLsF3n8wZapzqmEPlkYtvl1MIlF0KqCQ5yIsFe03o7yrEg3gupOTr49e5/R5Z7zjP4+DEf9XZuQihFtF0OgmC4k4BmScjg33mT65el0vdI0RlKED5HCZgO3tkZ0Sr7n7qHoQCudB8o1edcgG1Czy5lkJ6jHFoL1wH2YqKO3bdfSX1cDKdyx7EcxbJVZ0AXBTEHZDpLxtMD5AIaRsSn8Ch7of6jeUiiRBBUvl46X5aZg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:05:59 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:05:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v4 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHcuHsOfwwXmhr8UUqIhRcaFi4v+g==
Date: Fri, 20 Mar 2026 15:05:58 +0000
Message-ID: <20260320150552.169480-2-djordje.todorovic@htecgroup.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA2PR09MB7446:EE_
x-ms-office365-filtering-correlation-id: 211a09dd-647f-4510-b50e-08de869231c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: FA4rz6thGBESPj4Hk0ZvBbtPBl0F8w59ixqwZH8znbQP5IJNUGAqvHZMZOErpwU87YDctB0FnhRLmSmWHMD3267UfLtJ0lyKdiUxeMoEIdLvcNvl9G58TEs0bLQl/Gvle88IBoiLvmDZ4ZMlDYWMjcXoaIbnNKZpkLUfQmwj0JwRW2077irCZ3ekBb5Ol6BEue4+3XEDR3dct4IqAabvpW5g8o+Bzm6KDDVuvUEE41oz0mGZz8ofgb2s0arArX3De/VYYhaaUNmuPgTwnrDc3LM4kXfeX5hrnuMt9NRXHQeYWH6XF6k9Tj545+W9CojgLtT4vP7qI46eoVzFkIAwfC8f42v/JzeQ8xSbyzzu4L5dpFIruwp6cdRTVIMmw6m/8AtcwlWiigE4u3/ZtCIY1QXhl7Z1ZaUGsrqoB9gB2UKaFUKV2l30ChlXgay4c5mV0YSLQysarOLyWFJufD7/jxRzNAKcaxIGc+QbcUvKL0GnUsWUxwRNH1KbsMY26Urzp2SLQazPfHAXB0oDGPw2CjUR356WdbvdzcFNfpYBDjBS9bi4o0KW7Rrw45ASLWZqCjH3C1r3RF4z41fsJYtOjhSWDEgKVq9N8h+QJhuEfDvw3qOkU0tiJhgy0sTEAw8dTKuq6DQkj+19mPKT/7cYJkfxyKUbxp6ubHC1h/ysUFSxWA7iNJKw2uzJYuQiLcBTXSw7bQvSLrG4nCfrc4l5lT1ddPauaa235H/aOyemHCRCJ2aaOxxGBIfwoafeSSs7Z9nsvr0SyS8QjMU1Y4/6VySAVqF/hNIZ0hg+QKnmAxU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE9xcERhQ0NYTlVJZjlwZ25NZDhjbW1aVTNmemZ2Zjg4TERnUnFucGJxSWM1?=
 =?utf-8?B?SVpoRHJudk9DRi9xM05la2VvS1dqMWNCbWt1VFdFVzY2ZFFjSy9lbUZxcEQw?=
 =?utf-8?B?K01iODN5eGlrV2JGRC91aFdFcHQ0NGkwQm1oSmFJMlM3NWorZFprR1pROEVC?=
 =?utf-8?B?WWhZTW5raGxMVi9weHRKQUdsTkhyQ3Z5QUNsNVJ5a2Z0a294ZWtaaGZZZkZU?=
 =?utf-8?B?SzhmREx3aVc0SUc2V0gyd0pRSTU3RkRiMmwzbUplelBFTEVvUnJ0QnRWNklG?=
 =?utf-8?B?M3JSS2kydTgzNi9ieXgzQkhadGhGOVlFb1ZleUNSa0FJY2ZJWDJxNHpCbFJE?=
 =?utf-8?B?ZldwNWNsK1c3SkFPNXRuc2Jaa01uWnVXTVZzd2dIRTNFbWdwQi95cUFtdWdj?=
 =?utf-8?B?MmZQVWJ5M08yd1dKWHhISklHLzZwajJTSWRHRk16Ymw2aWI1R1F4ZmovQWcr?=
 =?utf-8?B?STVLNmdXM3M0aHBzY0VCUUU4dVl3T2dvcHE0M2wxNGlNc3QvSjRRbnh6bDZi?=
 =?utf-8?B?NnUxcDZzeHIvZWFlL2pUck9sU08yekVMY2trcFJiRmNqMlFMdldTSGRKUW03?=
 =?utf-8?B?OU5vcHZTdUVHcStMUzJHRmRISEJJWERwMEl6anRpbmVjdENzemxwVXZ2WFBC?=
 =?utf-8?B?dXdkNkVnNk9Hdm1vYmJhVHlGZE9rbFdTcTFVNVJGQ1h5RkZPOGdZMXJuakIx?=
 =?utf-8?B?RGg1MERUK1hmbjlVV0l4S1J4b2hwYXlCYmxnU2RDVXNpaVNvVVcxZkFpVzlE?=
 =?utf-8?B?U3l4Q3dpZjJoUmhMMEZWemwxdmljZjNZdVJpTVRMaml2emRTTm9naXVrMW04?=
 =?utf-8?B?UjVsQWRqUzMvV2VnRmJFakg2ZHhEd0h6UG9rS2Jxd1ZwczA1MnZmRUxvdzRR?=
 =?utf-8?B?TFdJdEpiZVlCWDBHUFFWa1g4M1M1WXV6Y1d5VnEyS0NqRkgwSjEwS3lMVWdT?=
 =?utf-8?B?TE9aN3hiWitoRzBIMGVlU2ExUUszR3ZuVDlVSzFtMk1NZmtrNFNJa2ozcGRV?=
 =?utf-8?B?TWQzTE1rUnNjVkdZeGRjS1NWOGdqSWVlZkxTa3RsUmJIZys0S2l6OEZEMm54?=
 =?utf-8?B?SmFmalZZaVR4UStOMXNuY05oOUxSWTFjK3ZTQmRHbDhTQytTeEcwY1VRQlZE?=
 =?utf-8?B?czJ1WTB0OU4wV3lQVVBvRzlHV2pvTmxyaUYrZDNsUndhalhoSHE0Rml2U0Zx?=
 =?utf-8?B?QkMzazUvVDl5cnhnY0c0VkJEUlhVVTVQeWs2a0lOR0FYRnhEWmFkdXRDaVJw?=
 =?utf-8?B?dURlTlJOYlB3VEJLcVVWYVZ2bHFQQ1VnYmp2V1R2L2ZyMksvbVBtMjd0Q1d2?=
 =?utf-8?B?bHQvSXRJdjMwd3dneEFFb2xVeDRPQ1lpTzZ3MnN1aDFCNXVmQjkvcWNWdzVy?=
 =?utf-8?B?RXdQeWlNdTNtaUg2OVV1eHhSSyt6S2NpR1BwVDUyblJtMjZHOTJYT1M3Qzd1?=
 =?utf-8?B?MU9PaDJVbUxZMXI0dEExQU5RY2hPWEhockgxY0IzN1pKcWtkcVBwWWRUWnNV?=
 =?utf-8?B?OVEzVS9MaU54RGN2dHV2MWNRMzhOK2JBOHV6dmlaS21RdG5mUU8xbVpjWlhZ?=
 =?utf-8?B?MlRmYng1S3p2MWwzN3NxY1hrNjFDdm8rOFM4SzRFK09JbHV1ckFocnZHM090?=
 =?utf-8?B?NUdNbkllNTVvRThHRlhkYmszd3lWRkp0TGt3dnA2Wk9GazJncmtESC9mQldp?=
 =?utf-8?B?cDZodFh0dWVQbjJ1cXJySXdQcmg3ZlFYUUpKeXpKRFF1bWE5aGxCTG5FOWE5?=
 =?utf-8?B?RXdlUEFjQ0s0c3V2UTZsclMvMVB6a1RjbzJUREFVUkRkb1pkdnlJYys5bytq?=
 =?utf-8?B?Z1RqWWNoWGo3c2V1T1lENjVEMkJqMjJNNGR5TkhpcWNPNkZndy9xUGZkemJh?=
 =?utf-8?B?bnU0Ukw4ckpuL0F0akNzVWppUjgrb2xoTXQ2amlSdnJqZWQ5N1AvRzJybnZP?=
 =?utf-8?B?NHJyZS9RTzViSVQwTjd0NjRKTXE1Vmhvc01ORkdYa2JhY0FPeWhMQmZZT05D?=
 =?utf-8?B?OE8xZlpTTlFoN1pmSCtNZ200MFhQcTB1aEJUWDNHQlFxMHFjdDA4MDlHY3Rm?=
 =?utf-8?B?VzBvOTA5dzZoYmJ0NXBrcUNBT1htK2NETC9UVlVDeVhqNUo1c2ZFWFJPbE5U?=
 =?utf-8?B?MHdlamtVMjhjM1MwTmVQMEpMOXZNLzBVWnZZSFp1Q1pjajRjU0pGTDBqV2RR?=
 =?utf-8?B?Mjlvdk9JNVp3WkZOQnNlZkY1Z0JQbkIvTlFHMzJjaXFnMVppRnVHN0N0S2dm?=
 =?utf-8?B?RkQ0ckt0MW5DUjBiYzNyOUZ3UlFEVDFFeVpCd2dZNEpkSTFydjFlNTFuVnFJ?=
 =?utf-8?B?WHI0MHpWYXhzL2NpdEhSaTA2eVhmTnk2alBnb0txdm1kUWxTY1h1OHdZc3pV?=
 =?utf-8?Q?tLMKPeRZ8sa3DCN93CcTxarUtObnWlgnpoPtj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC5598305C3083479EDA29519A01E988@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211a09dd-647f-4510-b50e-08de869231c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:05:58.5628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUe2/EcvxI40HZMsx03vODDJLUzEa8rZBRgoi1mgpDJ5QDSj2GmbEG+noeqj924j6VzB8SKQscDHHw5RGJwx66b9jxovwWY8bHecbfMF7fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7446
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

