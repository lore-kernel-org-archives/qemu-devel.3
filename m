Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5194BE73150
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 09:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmqVp-0005hg-3h; Mon, 02 Feb 2026 04:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vmqVi-0005hD-7A; Mon, 02 Feb 2026 04:46:23 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vmqVf-0006nx-KP; Mon, 02 Feb 2026 04:46:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/nTNp3BhIpibC7ru/TqCLEErPN0U500/8d1y0+N8VldKG5qwn8zbaLI6fCoejtIqK1Gsf5sDR8tMvIIvsoV8VLFGjQkGiPF+pVGSnukyr+Pgkmie/GcRuzDAOpSFQ0OyPZUcHDI68iRneqrFLd+ndvc+idArGzBYXCmiH4d7hPDm8N0zIxbD8vplc3ScokrBzkTo7T1tKlBuTuhew0ix+asuWCJjmihO9sCHF//ESwdSAnyFoYh+o+n5KSKUPzl6IRObN34+qPzBIUMvgZcAw1Nd7G6GqBqOhP8ma1L1JOximYsnWHoL0EGO6otzgh5uY6BZQkWpJFIXPJSiPPd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nwxlzuv+V/rBPxg9yk1m8M48ByRr3LeqiKYV9LHo9v8=;
 b=bba3S5CPFeR4oy/bDdInzPkuykHCJXY46uPqHSpJTECMpVta9A/vckDyBr+sWyNzs4dNWknUO6a27L3vHOZF7lc4pKggmc7Wku699DEUE9dl0XI8o/BNFREFI1usVZPaBwvW9TheTfuQC2qg0x6PLYwuFYbwFWSfLx9hbdKTLmhzxE6o3kZkP881SJxSQsmKOLDjUyGVXf5hmEK0XGQKYUBvw1NOV0ttUaiTf//dTJjqZfqRB/gqmPvICsZxJxrWzOKoYMbW7KHyFtf/9zTWb+5uuTxNwGlewjFn3edmGvFM4bHmlg9dQY9ktnkfFEZvKVovWFce181BK13/2Y6SVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwxlzuv+V/rBPxg9yk1m8M48ByRr3LeqiKYV9LHo9v8=;
 b=SMj6I1mbKR4IjD3UeAo3q+T4lcL7n/oUwH6lAS0gd0RGF6K7zf9WjT+HGRtgry9CnUBJytP+FIBCtk6QtJBldfU3Tsqy/pm15Utr1C0mxxSQTuAHFey/ZR8J92KYL3hA3nMoBAoXmYKWg4Wov77lpgQQ6c4AwKzLqVLF13/xZisTWXveTOCRaUeDoFaOAYLLtzQ/ZK/TvCSrbql6i0gboN31qlJNZtTnsIR1B1UEtuTLQQfcbqd8qIfXqHyV9C9nmtD9JR8HvfjjuyxDktar5ByEOEckoB7NI+SJWabqVWg6AxE0N0j5pXeq+MqQJjNW3V2OH8Qtuj8UNXKpMtzB3A==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUZPR06MB8214.apcprd06.prod.outlook.com (2603:1096:d10:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 09:46:11 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 09:46:11 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Topic: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHcie9SKTdPnCSFkUWsdzq93BR4GrVkMO6AgAFQ/ACAABFPgIAAPRoAgAk8RICAAC2PAIAAAIag
Date: Mon, 2 Feb 2026 09:46:11 +0000
Message-ID: <SI6PR06MB763184DBA59EA9E61B97C3A5F79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
 <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
 <TYPPR06MB8206FD6566DFDE3BA513FBFDFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SI6PR06MB763182A3E4BC0C6ADC0555CEF79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <05782501-e775-4065-820e-1b599674f478@kaod.org>
In-Reply-To: <05782501-e775-4065-820e-1b599674f478@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUZPR06MB8214:EE_
x-ms-office365-filtering-correlation-id: f5a64542-5eaf-4e26-f959-08de623fe5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dDV6TUVYTmwvbXhIcUUweEtVWjlwU1BUWTFwLzBFN25KbXBqckVQOFlCbDFS?=
 =?utf-8?B?WUNjMVFPaFJRMCtUd28xSWorMlphV2g3dW9GYTJ4QVVmS2JUYlR4VHJzZmgz?=
 =?utf-8?B?cDBjVmhXV25IYjJONE1PRnVsbXE4ZkVoZE1ieWtQQXNRM3h4TWcxM096OVQ0?=
 =?utf-8?B?aFJzOStRSngydHhITURqMG4vYkJXdW1nOTYwQUZEOUxzT1Y3eHVvdTBNQjZ2?=
 =?utf-8?B?NDFoOFhRVExpdlRnOVJhQ2Y3RFZ4TWU2OURGTnRPemJCQUJtZU1LUWRwSk9h?=
 =?utf-8?B?d1EyLzBxMEFsblBQK043bU5zbmJzaFRZNnlSTFdvNkw1anRyWi83SW9icDFi?=
 =?utf-8?B?amlUd1g4WU5adzR5dCtJa1cybEJZV0NrRVBRVzdVUlZwWm1ROUdsU01Ubnp3?=
 =?utf-8?B?c2h0YVZXUlROVHN6R3FBNmJPcnFnSlk3aTc2VS9XRWN2c0FIWWFicU5XVGV0?=
 =?utf-8?B?bXV1TmVpMWNpV0pPVDVpdDR1MDBTTWt2MjZKZ3N1YkpGaTR5T0JyVkRDSFNI?=
 =?utf-8?B?VUlsZU54SC9hYnVXSm5PdTRlTEtNb1lYR2xkeEQrUWovMEg4M0F5SExhTDhN?=
 =?utf-8?B?VUlwdjR0WVNINENoa1Jwbk9MRU1WMU5MRnJwQlBBQWVXQWNFZElqOXhKYWFr?=
 =?utf-8?B?YXdzUFRDOG54S0RRVmtVd1djVTVISEczSFRXZEJBNWVrNTc2emRKQTFnWXBw?=
 =?utf-8?B?cVoxTGF1ZmpXajRuV1hpWURIM3AwQXBrei9zc00yWjZyTG9hKzBkUTZ0aUpS?=
 =?utf-8?B?ZGsvaTE5UmpGMkRsM1FQS1Rrb1BEdVRlZDlxU1RFci9rbVV5SWtGZnlOZVdK?=
 =?utf-8?B?c3JSWDdJVmN0QURqam1hMGJ1c1BFUyt2UjdRa2FsZjZseTZ4TEx5Qy9TN2x4?=
 =?utf-8?B?clV3N2VhSmRpN2kxZFhVa2NzYmVTSGYvSWx5N1pPUndGRm1sdUhVY0tIU0p0?=
 =?utf-8?B?T0U1L2RUTE9KeFpLL1BycndDdm1ya3BNMTZBdjZpS2h5QlptT1NIbjNnR0pz?=
 =?utf-8?B?RlZZVEZGRWhVeWFHeWZVMSsycFFFVzJ5ZjNBRzU3K1dKeGxHRXFRRkljMENo?=
 =?utf-8?B?ay8wVWsrY3NZdHdUWHQ1d0R2dGJKZlJOc2hwbjdWV3FnU0UxaVhVK2F2UFl6?=
 =?utf-8?B?K0U0SldWcXFHbVJCTUxmTWJEcURJb0F2VGdtTFo0aHN2N21waUxSOVRuZHFI?=
 =?utf-8?B?WHpIQlc3ZFJUY0VpQmRSQ3pvSk9WQWFkVSt3KzQ1UW1udTFvRHd2d0x6a1Iy?=
 =?utf-8?B?akxMNWhIVUtXTXVETkh5Y250aWdYaVBoaXNpTERIWFVnQllqTk9NTk40bmY1?=
 =?utf-8?B?MG5FNVNTektmaUNmdXVpUnpaV0xkaWFFVVk0Y05WeEdoVENDbExCRStGRmlx?=
 =?utf-8?B?SW1BMkZnZnhLRG95RWtwVXZQT3JJQWVjREVNc2ZpeHlKZDRIYXE5U1pOQUlO?=
 =?utf-8?B?cVRQM3NmMHZ3amcyZEhveXNjeGNiVlk1b3NZN20vUFJ1RmpMYnhXV3lpK2Ft?=
 =?utf-8?B?Vk5PSTNGR2V0V1BiYWg2N3VJOFpxVE1TcG1pdkU0aG1HWi9zK0ZkbjZhRzZk?=
 =?utf-8?B?Q01uV3N6b2kwZkJqYUtySkNRUG9Vc1NyOHNCWGNZK042N3RoRUNFQVNJamxx?=
 =?utf-8?B?NG1EM0FYN0tJajgzV1Jjd2JjSWRtL3dWRnlOM2lUajM2RjdmczdkeFpTa3pE?=
 =?utf-8?B?V0pNZXZvVnRKWEVWeS8yZmNNemQ0cFV6eGdycko3NGlmWm1MYlgva3Vqck5x?=
 =?utf-8?B?eDM3ZWhHTFhyUUJZUHVFZWc3bmpkUS83M1Z3cmhCSFhsS3pRS0IrSE9aMG5S?=
 =?utf-8?B?TkJKaTVycFduR2RLSU5Td3RWMkJJclBPa2NrMVJCbjl6eWNSTWg2OU9RTWVq?=
 =?utf-8?B?cXgvakkyamt6ZmJJMFNyNmpKUGxIS1RWa2djZGkwMmxNaXhITEVVdGd1VXVM?=
 =?utf-8?B?bnluRHNKeVpZbWR0dDRxZ1VMOTV5WnhEMFRqRVZYOWQ0NER6T3NTZm9RdUlm?=
 =?utf-8?B?OWt2Y1R2SVVMUlRWNGdNeDFEZ0pydWhrZUk3K3ZBaHFtQzArMnBTR2hJOVVQ?=
 =?utf-8?B?RHFHOE5jOHMrTkxtcFVDNjFMZGtVZENkMkRFdk1Wcm5STnBVZCs0ZkNVRWxD?=
 =?utf-8?Q?NwruDRxrQ2MAqt1zDXj1QdhTy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0oxZWc5TEcwN0drR0hTQnd6aVlyaHhzQXFuanRFdTlDQTBVZ2c0OFJob3Ex?=
 =?utf-8?B?OC94ZmVPNDhUeC9vVHlnMlpQLzJMemZFZ1hvS2ZMcEpGTnBjMzRDTkk0T3ZT?=
 =?utf-8?B?b3dRV3RGMW01RGpraGUvQTBVWFdoQm5Lb1RuaE1HWlJIZ1hrTzE3N29PcndE?=
 =?utf-8?B?dHpHMXl4Q2xaUFFVL3Avb0tROEx0eHpYQ3pXQ3FNWkJEME02ODQ2SDh2Q0h3?=
 =?utf-8?B?SzBpS2dMVTY5NFdjQkhreWIyUEpZKzB1WWNwbGRMbnJWSXMxNWkrbW9IcDYr?=
 =?utf-8?B?UlMzRmlYZnBmL2hUcXAxM0E1Z1dBMUlXRHRGM1lWenpzanZTOW42dEJkN1g0?=
 =?utf-8?B?YSt0OG43YjNLZDdla3E0djdoWFp3WExmSkxxZTRBQ3lqeGxFTXJoU3VkVVY0?=
 =?utf-8?B?M3BuTE8yK1pyRlVpQkZxNlpEcUxaZm1Gd1FhRHdTQTZYcEpWV1VpRTVoM2tl?=
 =?utf-8?B?OWU4ZmVHS1M5bldTNi9qWmRFRGhCUG5lVlIzMmJWeEZHbkp2TGZVVVBOd2hi?=
 =?utf-8?B?RkJ3YnF5WnFuYm1nNStJRUNZck9jemhhRDFldzZzVTFzakI5cmJpc3h1dXhX?=
 =?utf-8?B?TFRqUC91ZGxtWHJWRUxsdlAzWHZPbTRnV3VLYncxRFc0N2xzTW45MkpmeUc5?=
 =?utf-8?B?WlhhQ2JtQU4vMlg3VDJzT2o2cGZsc3NoVlJNVEJtMHp5SGNOZUx5clB5eGxI?=
 =?utf-8?B?WlZKZFYzYVo1UDV0c0YyeTdzVXpDWFM4cGl6VFVOVDVjSGVoMjRLOUJLbURC?=
 =?utf-8?B?VHhHZHdsbG9qQmVsd0x3SlBtaXcyVE5nbEdrQUZHeTJhWXcxS29BMFBIcmRi?=
 =?utf-8?B?bWJjUGoweVpsVmFCVmIxVTNYSG13WGV5S0ZxYUtUVUN2ai9uMjVUbGhaMDBy?=
 =?utf-8?B?RlVReDc3Y3REbnZ1QzU2UFR0c1FEOUFYVzhldFNiaU1IVjlmdzV3Vjkyd2tZ?=
 =?utf-8?B?eitGaDNGenVXMDk3eG5TS3JyejNmNjBoQ0xOYTN2TSswMlBlYU0xVFU3VGE2?=
 =?utf-8?B?ZWRnUDNLTThCMTlVeVpkNmFCT1RDM3dhV1RpREZCSGVFSEJUdlNKczluUTdq?=
 =?utf-8?B?ek0yRkZuOUM5cUhmQmdBM1NyUUJWK0wrKzBwYkx2S21zdTBTYlhDb3E1eENL?=
 =?utf-8?B?b2QzWFp2ai9xRUNyS2RnTGhTTUNZVjRReE9RRm9rdHM4Y1pLZlRQTHdVUFYy?=
 =?utf-8?B?Qjc5NWN4NkRRbnBqL1pXbVBIV3RyeG1kbTUyeld6T3V0ZitpOUpoVkZmNldN?=
 =?utf-8?B?alcxMjlkYzVvMExwR1NwK3pTbjNUaVgvYjR4R0UyejVsTGo0TXRLRXBhZkRk?=
 =?utf-8?B?bVRrSENRdllrbTVqZVBLekgrTUJ5UXVoVGt5Q0U0dklnZ3Y4bmY3cXJadmwr?=
 =?utf-8?B?RHYzS2VsK28vU0pFWmJiRnJZdE83dDF6alB4RjR6bDNZWkM5YzlrNUtaME05?=
 =?utf-8?B?aFVsZHRja0JENmh4YmVWTXZXb0FFczNsYlBaSnQzY1gzcFZUOWRZM2thdVBJ?=
 =?utf-8?B?T1FQZU9vT2pQQ2YwRHpyOFNDdTgxNVRQeVRHZlhvSmtZOWl3OU9yQXhMb2NO?=
 =?utf-8?B?VDM2OHJmVlUzU05yaFpnbVdjY25BZU1SM00vRXhaRzc5MEw1aDdDako4eUVY?=
 =?utf-8?B?VjI2N1VtRStvZmRsTDlEOE5lcHhpdEJ3MlBDUVBYbjR4bmhRNTZqRHRCZkhm?=
 =?utf-8?B?b3dhYjVwS2tqaGV6WlgxdFJWS1MzZnR4Ukl6UW11U2RINDhXWk9JNWRxVkNh?=
 =?utf-8?B?NTRsMGhTbGcrNEt2Zmgyd1o0b0d6b2xuQmtBR3BmUUFVV0ZQL0ZiblYwWnhK?=
 =?utf-8?B?N3VzckNtY09RNmlOZGJXZFBSY1F5eXlRbkd2Q3E2K2k1T2xTQ2xoL2dGWXIv?=
 =?utf-8?B?bmFhS25qZlNCODU5TGpjSGJkS0JNWWFqS3JSdm91d2JsVGMrNnF6RURyUVhV?=
 =?utf-8?B?bXdqV0dsVmwweTFadC91cEhDRGRaT09oNmJyTFFXOUFyY2h2RkxMTE5GRE83?=
 =?utf-8?B?NDNmTWxaOGg4dUJPZlVRdWhrSnUvV29qdHlyZXNJdEp4QXI1QkhncEFQNFRU?=
 =?utf-8?B?bEpSelhZTmhST0hQMm8zVlFzcG9ER3JJc2Fod1lLWHVlWmNGOTNIbDJUM2lw?=
 =?utf-8?B?VlBBL0toVS80V0xaZ0FmRmd4K0ZTYjRNVUpnRzVHM2h1V3N6a0pYQzQyZ1hY?=
 =?utf-8?B?ek9MMVFyOWdTeXZyWGZFR3VOTmhZWXBmei9jbmRLRjhtUnczVTlPeUgvL2lH?=
 =?utf-8?B?QUZqZ1FJNVBVQlpGSStPeUNncXU4d3VRejFZcjVYRGNHaXhEVjg4dEJQUzJN?=
 =?utf-8?B?S2t1SzBGbmJ1M3liY3lhWVpjNlRWTXNXZjVZSzV4bVNCeFYvUmZtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a64542-5eaf-4e26-f959-08de623fe5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 09:46:11.3882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vE7p8JGuYh9MkFveWBHcF53VfH3aeNw/RLWS/464vbcWCE2OT5r9hrKPYnGN/OQlKX/am3afI8xC+TNj3NpM74k+dk4cdu/Dxs3eWda5jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8214
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDIsIDIwMjYgNTozNCBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBKYW1pbiBMaW4NCj4g
PGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz47DQo+IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBU
cm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+Ow0KPiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT47IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gbGlzdDpB
bGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQv
MTFdIGh3L2FybS9hc3QyN3gwOiBBZGQgRFJBTSBhbGlhcyBmb3IgU1NQDQo+IFNEUkFNIHJlbWFw
DQo+IA0KPiBIaSwNCj4gDQo+ID4gV29ya2luZyB3aXRoIG91ciBJVCB0ZWFtLCB3ZSd2ZSB0cmFu
c2l0aW9uZWQgdG8gYSBNaWNyb3NvZnQgbWFpbA0KPiA+IHNlcnZlciB0byBlbnN1cmUgREtJTSBp
cyBjb3JyZWN0bHkgaW5jbHVkZWQuIENvdWxkIHlvdSBwbGVhc2UgY29uZmlybQ0KPiA+IGlmIHlv
dSd2ZSByZWNlaXZlZCB0aGUgYmVsb3cgcGF0Y2ggc2VyaWVzPw0KPiA+DQo+ID4NCj4gaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9RRU1VL1NFM1BSMDZNQjgxOTlGNEIwMDY5RjkzMjYwMzQ1ODVENkZDOUFB
DQo+IEBTRTNQUjANCj4gPiA2TUI4MTk5LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20vDQo+IA0K
PiBJIGRpZC4gQWx0aG91Z2gsIHRoZSBzZXJpZXMgaXMgbm90IHRocmVhZGVkLiBQcm9iYWJseSBk
dWUgdG8gdGhlIHdheSBpdCB3YXMgc2VudC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhp
IEPDqWRyaWMsDQoNClRoYW5rcyBmb3IgdGhlIGNvbmZpcm1hdGlvbi4NCg0KSXQncyBwb3NzaWJs
ZSB0aGF0IHRoZSB0aHJlYWRpbmcgaXNzdWUgd2FzIHJlbGF0ZWQgdG8gc29tZSBleHRyYSAnRnJv
bScgaW5mbyBpbiB0aGUNCm1haWwgYm9keS4gSSd2ZSB1cGRhdGVkIHRoZSBzY3JpcHQgdG8gcmVt
b3ZlIGl0LCBzbyB3ZSdsbCBzZWUgaWYgdGhhdCBmaXhlcyB0aGUgaXNzdWUgaW4NCnRoZSBuZXh0
IHZlcnNpb24uDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

