Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E883C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 01:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLvP6-0004AM-C4; Mon, 24 Jun 2024 21:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sLvP4-00049y-My; Mon, 24 Jun 2024 21:55:27 -0400
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sLvP2-0001uV-2I; Mon, 24 Jun 2024 21:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0NE4u6NslqJH+glLy+mguuVuAmrCh7y4VhuYLKtsMh3H63y4/DHPCmc2Wqc6uy3zo9FDecz6IYLCAn7Xyt2W8hL6xRBYiV3abpj4Tl+IAc+h0OT6nmSYzCkyPf8+Zmp6nK6ifD84d3zpJXpYajH6HIHrPzOxPuu9j4YAa7Q8IclhcgIp/1O1POsRqwQtEH2x9YHSeO7Iw2AllDK+PW69vA6OE3Yt8Wsk2OxlWAb0xp6eeRNhjnq1LTS5GaRH3rnZKMkMN0n5X/58xIMKryXzIb8KeI/SRMCxXazfGVi0/4SjvjcwcRBlXJqsYap3MxPnU2xa05K3ur6y7TYR1R5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgrIDtDlDGhQqIgwzpOS83uDb0BWNUB1zyQwtoD8F5s=;
 b=iShgydIJHdDL58S+AtVzNuuLHIQwqTG9XTTXNO1nQ5xa/y79cYfc6a3CzIhEWkxd6rVtHPGGyYEYyd5D/ptwARxHgZjiDG0+9hArsXyHOaQBB6eVwfOj2Adyi+4bljgoWH1Lm3U1BTfFXZFyn1XBnzwWYVQrUaM5nE36mZn1fUouDfIjyPoM1+FHCvIX670sil/Re9M+4+s9sdHOAzlACXCD3JAsKmOQw2h0WH7BAEK70cKyyQCpbm2XpYGbqHxnCKemNytoBPZpJkMKO7vTO91ARS/F7LclUunwx78PFIFY3RKlDOWxlgAf/A6t+GNSqLuNVLGlRkTEtB4Z+X87TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgrIDtDlDGhQqIgwzpOS83uDb0BWNUB1zyQwtoD8F5s=;
 b=J81qAtn2LFErUYQA+p2HbhcYEZXDyqiXi22/NX9Nlb7FwBXSoaHjxT3SH4kmFcYm6zgGYhMNyPjJtJG1KDeSAUwjzwXViDy3pYOvoUCpIn68bYvEVva3vuVn2AYZoy8Cm8EhcHuW4+wQgpl6j4qxDr3roQtFKTWmP6k+OQxlUW4Cc+AGguO70aXgQnSWY9G5UR2PPobK1MWybG+O9+GENomCml0Xgqb8kMTcjHMEt69hG0tEPhrVBrLvVrp0Srm4A5yN6TsyeRgyc6bMTin7c6t9LWRqlnq8Jj2/qQrKyhs79U7SimGz6TD0Mp9H9j7KYKT0w20ry/EhlJfoZ1UdQA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5118.apcprd06.prod.outlook.com (2603:1096:101:38::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Tue, 25 Jun 2024 01:55:10 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:55:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>, Yunlin
 Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 1/2] aspeed/soc: fix coverity issue
Thread-Topic: [PATCH v1 1/2] aspeed/soc: fix coverity issue
Thread-Index: AQHawiv9tvtH3acF/EeO4aBMMhGyy7HW3PKAgAAbz4CAAMceQA==
Date: Tue, 25 Jun 2024 01:55:10 +0000
Message-ID: <SI2PR06MB50412C68BF0AD9B4ED91B75FFCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240619093508.2528537-1-jamin_lin@aspeedtech.com>
 <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
 <CAFEAcA8tTHusKOR7JhyU+wwA3JJWq1o5wVaNXugw2S9SjAsESw@mail.gmail.com>
 <b013bd79-c206-446e-b482-91eeb926c70a@kaod.org>
In-Reply-To: <b013bd79-c206-446e-b482-91eeb926c70a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5118:EE_
x-ms-office365-filtering-correlation-id: 1f93a340-6c64-4fcc-edaf-08dc94b9d882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?WW1lWFA4Z09FMGpMaHltT2hWODFmaTBMMllWSGYra0lXU3FiMHhYNmF0aUlJ?=
 =?utf-8?B?R3p2MFhBQURaTU92UDUwL25TTjRGUmY2M1FpM3h3K1M3Nkw0RndIaWs4Y3Rs?=
 =?utf-8?B?Wm9jdHl0dG1EaEw1VHcrMmY1MGlvQTNQM2FadklwRitxNDgwS0M3QnlmTmo3?=
 =?utf-8?B?bll3MHBFbmZDYWhVL1ZWcnlMU3JLaUF0c1NtMlRaMFlFZCtsV25GUjNlc25w?=
 =?utf-8?B?QnB3TFRXaXBXaVFDbHZieXlRRkhsWVNQZllkcktYMHNGZGdzOGlsck9LNmVt?=
 =?utf-8?B?aWFpa3o0bUk4ZGQ3OWpPaHJwNHViNlczeStNOURMRnk1VERGazRSc2V2Um1T?=
 =?utf-8?B?S0xHeDQ5dDRxcVE3ZnFSdzBxSi9GWTg3blZQaWhQNUVwTU1HZGJNb2dOWVdN?=
 =?utf-8?B?NCs1TTN3aElJb1E1dGRxTldxRFpEMm52MklrQXh1cVdGUzhHQVN2MUUyaS8z?=
 =?utf-8?B?b1M5WUhoK3M2KzlPU001QTlZT3o1WW5mVW1TWjR4a2ZnS0RZSjgzTWdmUFJG?=
 =?utf-8?B?RHJTMW5PamRsWnNXUW5jelhpRnFsQXNXa1Y1Mm1icklSWkNlekJmbUVlNHIy?=
 =?utf-8?B?V2RDVFZhdEtpamkrRzlubkp6cnA2b0N2VE45b2w4eEtTRE5SSE1KK3BrcnBI?=
 =?utf-8?B?WTlzUld5b3RDMkp0TjdOTThLK2l5bHJlYzVaOWx2RnhBMWZpN1cvZ2RESi9S?=
 =?utf-8?B?bm53bjJScUhtUkJiKzRqSS84bVI3OTQzb04rZDlkU1hwRnR1dEVtRGpndWhI?=
 =?utf-8?B?b2dyUURDY1JsSXQ3cUo3T2F0VDd5V0YwSGdoMUZadlVhYXJSVmFHd3hkSnBZ?=
 =?utf-8?B?V1Zwd3VjT05ObWVzWVFoSDJxdXEwa1RIa3pTSmpqKzFBc3hacHJXcTRJTGlw?=
 =?utf-8?B?S3F1SWpTOWd6cmtSM0ZmTHhCRWlDcVdJTGx6VDk2UHEwWnNVRml5TFQ5Y2J5?=
 =?utf-8?B?RVdHMU9RUFF2TlRudEkyU2VIZ3krbU9wY1dvcFJ2T1o4REgvc3haZjJ2dExp?=
 =?utf-8?B?V1RpQ2xLVkh6a3JmSGp3RHhjNlIwSFBmeFlqUk5oVitPT01rWWZyQjJQSEIr?=
 =?utf-8?B?SjNTbDB2MnhYSUZyTFdhZlVpRmtKZXBRYjhxQjF0VVBNbncvQ2dETURUa0d6?=
 =?utf-8?B?RUI3RDN1eVpwcGZSVHBTdHoyTklndlhGZ0hWTllxOE9uRjF1Q05HTU5PSUQ2?=
 =?utf-8?B?azllcXVsK25nc1JvWXZiVzFnb2xtZHRHTEZxbk5IaVF4QkNWbFpUV21TOU8x?=
 =?utf-8?B?c0RwOG9vL1UyNzdqVGljMVl2UlljVWZsdVplUzhIRjdMTXJBdllNSXNSZlJ4?=
 =?utf-8?B?LytDNmRRRFZiOCtnUGNaQTdrMjJ5bUhyNkdiUEZQMkxrRTVEZncvaG8yY21P?=
 =?utf-8?B?cHkzVCsvaWY0N05zMXhudCs1bEZnVHFGMmZjZHp4WVhmRGZFSXBjSWQ4cWJh?=
 =?utf-8?B?M2xtVlVQZXpDaktvTCtDS0lRUzI3NktxSGxwRmRBbG5oSUxTRVBXSFZmVHky?=
 =?utf-8?B?UExFYldFaElLZjNPcG54aVFiQUtVckt6TEZ2VWpYaGhDajFYUU9pNWNBcnVX?=
 =?utf-8?B?WlhUMGpPcGIxb3htVit4ak1kbk5GaVNhM0ptdFNNNjlIaFRhMzdsSFpiR3hK?=
 =?utf-8?B?UkJQUXpSOXlkVFd4MWVaYVR1Z25xdHRwT08yVUFhUjBhU0UrOERnTzZYMUx0?=
 =?utf-8?B?VXpiZUR3clpKZDZVZWtKcURSMnFrTXorVDc4OVRKMDR6ZmY5R2tvSS9WdFFG?=
 =?utf-8?Q?FNpHeUoQF3gQ68W+UcrSiIdm126pmrssz347DPX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(366013)(1800799021)(376011)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJJV0VhVW4xSXltMXZ3UWw0MzI3SVZNNGVzejdSVjZ6VTJKb3ZmRXZBWktU?=
 =?utf-8?B?QXBGcTBwcmYycTFKeXJjMUlWZGpNaDg3b2xQNVYvdFFkbG9lbUlJY2kvN25J?=
 =?utf-8?B?MnRFcU0ra1BEUmhLdW1oejFtVyt4Y25iVHlpZjdrdlFRUUVhYXZjK0FSSGFp?=
 =?utf-8?B?bnhjdk9KYXFuK0ZzQktyL1ZEOC9qYmNiWHhYd21LV09lUzNDZnFMRzR6OTBs?=
 =?utf-8?B?M0J3RWFQZUQ1bGdLVHFleURWcXBieUdpR1VBSkhCMU1pK0Y5UmpEdktxTVNR?=
 =?utf-8?B?R1BQeTF3U2EwZVE1L0lGaWVLWVBKOUdDcytmN0Q0eXlhKzkxOFhjbzZsNi9h?=
 =?utf-8?B?WFd6NXlMbXd2NUdFeEJWSzhqM2tTclNRSEJ5Mk8vVktZZ054cGNlbGhqUkx4?=
 =?utf-8?B?SlBLQXc1RW1iT1NFYlJPeC82VUY5MnhGa2FWN01aTkNzdDdRU0Y4dVZQeXdu?=
 =?utf-8?B?amtqUTdsUUduamltVnF4MjlyZWltY005YzcvdTBPY2JmVUJEclpzTC9yK3Rh?=
 =?utf-8?B?cG51clNiZFFuSStuZFlsN256Wm9FcDUvblNZTTJYYXFDZlNCS25yeStmUXcr?=
 =?utf-8?B?bWhySmNKVnFJY295ZDhUV0dBOW1ZKzcyTGZnSzNRV2F4SFhxSEl3cTBiOXpw?=
 =?utf-8?B?ZUU3S2MyRW4yQlJTdXNmWWo2RGZzSkZRM3lOdVpiUTlUMzFhdmRXRjRHTlcy?=
 =?utf-8?B?YTRjdTdrWDFoMzhZOXFxQzg3NFdJNHRvUnZCZ3dYQTMybGV0TTRBM0F4bHFM?=
 =?utf-8?B?UG9Rd0lDTmlsZytrNXlQcmZwc01yTXlSWmpBV2REc0hrSUViSUsxUEtEQ2l0?=
 =?utf-8?B?a1hKNlF1dXZxa21iME5iUXFjVmtyWGdIK21JblN5azc4MWN3Wkg4WnZ2amxm?=
 =?utf-8?B?aW42TXl5bmtnY2FrQ3FlSGlsTElJVVBEL05QK0h0Wms5TE9MeUYvNVVraWJD?=
 =?utf-8?B?UVJ1bmFqbGlUNUJkUVdOeU1qS2d0T1kvMG9UTy9SVExaMERKdmtBV3hyVWVh?=
 =?utf-8?B?ZThMRCt2U0FnVlVzUUhUblE0cm10QzdNVVBYc1AvYlYzVjd5ZTVXaFcxYlcx?=
 =?utf-8?B?bTNoM0gvalVEUXVkdjhKaW5YNS9MQTRPd2M0NDhxWjR3YWhCNEh4aERRRU81?=
 =?utf-8?B?MjFsbTg3dFlaaDlsV2VvWU0ydHBLYytBMysvMXFScXVYdHp1dUtHWUJIQ016?=
 =?utf-8?B?WUxVZXd6eXNqczArazdtY2R4aEVDWjJXdHV1QUtlcUFSWTJsaXYwelJhY2U4?=
 =?utf-8?B?d2ZqREs0YktWOXZtaDFqd0tVbkVEMTB3S2RadjdrSGVvcFBqRzdtSmJJY0k4?=
 =?utf-8?B?ZEdaWVdHSGpVZENOUHFQSWVod0NldjA5bWZUZ2ozaHJsSkpuZENWdHEvVURZ?=
 =?utf-8?B?NWs5VFJYelJDd1hVWndZTVdrTXoxTFBOdDVRVWFIREM3YjA2WkpuRkh3UCtP?=
 =?utf-8?B?em5yUXo0cW1sRS83Lzd4RmpLV0VTZ3pxYlNxazNaZjhZVG9BVVhNeUZYSGVx?=
 =?utf-8?B?T0NjTGFCRkpKSWZqRkxBaXhENXc2dXNDc2JOaHZOSVVDRTc1MkYwR2p6cHZk?=
 =?utf-8?B?dHdMc2V3SHNoRGNsVUhlNE9KMU9ZRElXQUUyRXJNOUxNelp4TGl6ZEkvTnZt?=
 =?utf-8?B?N051ckpHSExKaUpJOS9wM3QrVFlIS0lMUkltZkt2VDZ0Wk5QUG1lN1lzWU95?=
 =?utf-8?B?OGU3WjF4QVlaZ1REWFkvVHVoVE4rSC9yQitoWlladWdzQm90bUovZDhKSGpp?=
 =?utf-8?B?dmNuTklMWFlod09qUHVKT3dEb2F3QWZOYjlkQmRZMDczVGRwUG03aVBRd0dR?=
 =?utf-8?B?S2lSYXpJeitHcFl6QWptYjhyY1NWYVFLQWZiOTI2RVZqc0thOU9sSGIveWNz?=
 =?utf-8?B?bEVLZk1DWUJ5U1M2ZkVmNmdCdy9qWVFGRTNXZ2hLVjVubXhjeFVTVzRqUVdy?=
 =?utf-8?B?Mm1rYXJMT0Mrd2RRWHJ4OThPMExXMGd3bzdLRnFSSWhRTzBBRjlJVUx2Um83?=
 =?utf-8?B?VFEvV0c0eVlCS2h2VHNqNVlJdGJTV0pvVVVsVGJ5bFA4U3BBRDVWblhDRmRJ?=
 =?utf-8?B?aG1xUS9qVTcyaHpnM3hsYzBRTlVKL1N4ZjMvWGlybllwaTFESzNKWWN2b1pk?=
 =?utf-8?Q?f9Fyx6OodyqAB5+IDQvLNq3F6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f93a340-6c64-4fcc-edaf-08dc94b9d882
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 01:55:10.1993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EkRY+n3WKzSc6q5RdFA4sgSOOIBRpe1KXVysAQAu2ra8+hvXg/12qM+rrLCWdtnsgV0UyD9RMd5l04Fb95upbmXOgsmeZ63XtN0zXdZM6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5118
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjQsIDIwMjQg
OTo1OCBQTQ0KPiBUbzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
SmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IENjOiBTdGV2ZW4gTGVl
IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUNCj4gPGxlZXRyb3lAZ21haWwu
Y29tPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwN
Cj4gU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUt
YXJtQG5vbmdudS5vcmc+Ow0KPiBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1k
ZXZlbEBub25nbnUub3JnPjsgVHJveSBMZWUNCj4gPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsg
WXVubGluIFRhbmcgPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxIDEvMl0gYXNwZWVkL3NvYzogZml4IGNvdmVyaXR5IGlzc3VlDQo+IA0KPiBPbiA2
LzI0LzI0IDI6MTggUE0sIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+ID4gT24gV2VkLCAxOSBKdW4g
MjAyNCBhdCAxMDozNSwgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IHdy
b3RlOg0KPiA+Pg0KPiA+PiBGaXggY292ZXJpdHkgZGVmZWN0OiBESVZJREVfQllfWkVSTy4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4+IC0tLQ0KPiA+PiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgNiArKysrKysN
Cj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5j
IGluZGV4DQo+ID4+IGI2ODc2YjQ4NjIuLmQxNGE0NmRmNmYgMTAwNjQ0DQo+ID4+IC0tLSBhL2h3
L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5j
DQo+ID4+IEBAIC0yMTEsNiArMjExLDEyIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9yYW1fY2FwYWNp
dHlfd3JpdGUodm9pZA0KPiAqb3BhcXVlLCBod2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwNCj4g
Pj4gICAgICAgcmFtX3NpemUgPSBvYmplY3RfcHJvcGVydHlfZ2V0X3VpbnQoT0JKRUNUKCZzLT5z
ZG1jKSwNCj4gInJhbS1zaXplIiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gPj4NCj4gPj4gKyAgICBpZiAoIXJhbV9zaXpl
KSB7DQo+ID4+ICsgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICIlczogcmFtX3NpemUgaXMgemVybyIsICBfX2Z1bmNfXyk7
DQo+ID4+ICsgICAgICAgIHJldHVybjsNCj4gPj4gKyAgICB9DQo+ID4+ICsNCj4gPg0KPiA+IElz
bid0IHRoaXMgYSBRRU1VIGJ1ZyByYXRoZXIgdGhhbiBhIGd1ZXN0IGVycm9yPyBUaGUgUkFNIHNp
emUNCj4gPiBwcmVzdW1hYmx5IHNob3VsZCBuZXZlciBiZSB6ZXJvIHVubGVzcyB0aGUgYm9hcmQg
c2V0IHRoZSByYW0tc2l6ZQ0KPiA+IHByb3BlcnR5IG9uIHRoZSBTRE1DIGluY29ycmVjdGx5LiBT
byB0aGUgU0RNQyBkZXZpY2Ugc2hvdWxkIGNoZWNrIChhbmQNCj4gPiByZXR1cm4gYW4gZXJyb3Ig
ZnJvbSBpdHMgcmVhbGl6ZQ0KPiA+IG1ldGhvZCkgdGhhdCB0aGUgcmFtLXNpemUgcHJvcGVydHkg
aXMgdmFsaWQsDQo+IA0KPiBUaGF0J3MgdGhlIGNhc2UgaW4gYXNwZWVkX3NkbWNfc2V0X3JhbV9z
aXplKCkgd2hpY2ggaXMgY2FsbGVkIGZyb20gdGhlDQo+IGFzcGVlZCBtYWNoaW5lIGluaXQgcm91
dGluZSB3aGVuIHRoZSByYW0gc2l6ZSBpcyBzZXQuDQo+IA0KPiBTZXR0aW5nIHRoZSBtYWNoaW5l
IHJhbSBzaXplIHRvIHplcm8gb24gdGhlIGNvbW1hbmQgbGluZSBkb2Vzbid0IHJlcG9ydCBhbg0K
PiBlcnJvciB0aG91Z2ggYW5kIHRoZSBzaXplIGlzIHRoZSBkZWZhdWx0Lg0KPiANCj4gPiBhbmQg
dGhlbiBoZXJlIHdlIGNhbiBqdXN0IGFzc2VydChyYW1fc2l6ZSAhPSAwKS4NCj4gDQo+IFllcy4N
Cj4gDQo+IEphbWluLCBjb3VsZCB5b3UgcGxlYXNlIHNlbmQgYSB2MiB3aXRoIHRoZSBjb21taXQg
bG9ncyB1cGRhdGUgSSBwcm9wb3NlZCA/DQo+IFNlZSB0aGUgcGF0Y2hlcyBvbiBteSBhc3BlZWQt
OS4xIGJyYW5jaC4NCkkgcmVzZW5kIHYyIHBhdGNoIHdpdGggeW91ciBjb21taXQgbG9nLCBodHRw
czovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2cxMDUwMzAy
Lmh0bWwNCkRvIHdlIG5lZWQgdG8gZHJvcCB0aGlzIHBhdGNoLCBodHRwczovL3d3dy5tYWlsLWFy
Y2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2cxMDUwMzAxLmh0bWw/IA0KDQpUaGFu
a3MtSmFtaW4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo=

