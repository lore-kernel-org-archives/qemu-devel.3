Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F03AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNeo-0006FS-4t; Thu, 18 Jul 2024 05:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNem-00064B-8K; Thu, 18 Jul 2024 05:42:36 -0400
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUNek-00075H-AE; Thu, 18 Jul 2024 05:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSoUVYeHjPGhCjg273LOtrJMtIb1yCxa+2ax//mabQavrVrb/MVK69Sl8F5R4ZN9BKMGZXmX9ewkG5CufcIpGaS8wtidlbBM30RBini3bbEmQ99nBDv+dluWZ5E8duxvsHujDh7r0Mw0EseNzyUvduNIJ2GHePXh9/qNsM61XSBGj1IIjwHEf4zprbLYTDZRWC+jNQCmoAOt337JTTTNuJ7gihmove6RLf9EVzilVAZbkF8noYJuCFRwPf0Nz6nLYkGqnF8zh5e61vJKyqGmeJwD4p2W7FEyaFHnDMgcMpFsbOoZTQSh65si+jXyVHzxgc//EPnsOi/LEVQ+TOXTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+98vdL5rdtcmgQlHs9xfq7PqRelGIueBL4AOvGUgC8=;
 b=gkIc1XcNNN9TurFaRw6br61Ru5oPok3SKDxfb7PjQ3Rp2jE8fAK5bVU1QfzvAvQpaLMoTL137cUpxoZO9OS1ki6HgkQnSjRzV0TVgMCUg5u55skhwXUFAEqufEriTI9eK42kc5zooIvYZ++UKnNfSnih/yesWxAloCRw7678Gv0gllzVgwvonSah4OlCg9Km7aO9/1URV6XUs9oHy+XKeEO3GV/enO4PsUoliVllN5ZnXYre4fAVF5g2CkxP5y3gTvf/TShK792Q2SYEB49Y3bgXePPaZ6smd8LyzKNsDwfHU/p5asK+zLemZxKYSl1uh4MMwZOHn1Gqr7ECuHIFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+98vdL5rdtcmgQlHs9xfq7PqRelGIueBL4AOvGUgC8=;
 b=J7hvRS+X0YcWPwx9Jg9bP+rUo5VVsZRPKq6SKodNB4oEkGuopOAx4TP8qqaihDj4iMy8Bs6a6GykVZOl02D2+5kqIeTOPaBfvdpXX/v8mMmuF/f662IpR3mPevuf0xLL/+NTEFIxYtGC7nPT24W186wTWaKTpVVt6yUwRCO/8L56Bqs1Tcmi2lJ9BRwGHbkjO+nGbGK4UrP2OTMNEfv1XAJwI0DKqrJqDgFA+RLjQV95kNiQCAGQBbZ/U0gmNdK25uu5rCF2vfDkKY7nsKynhrR6iVI8attGvIErxkanOF+KCRu7adJm6zYnoEAFUKFa368MooLjAF/XmqQMcCXfiw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5108.apcprd06.prod.outlook.com (2603:1096:4:1cb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Thu, 18 Jul 2024 09:42:23 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 09:42:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
 memory size
Thread-Topic: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
 memory size
Thread-Index: AQHa2N7EjNjdflIlaU+vGz4Ys7QZsLH8HzuAgAAau6A=
Date: Thu, 18 Jul 2024 09:42:23 +0000
Message-ID: <SI2PR06MB5041287D9E64F7D0E25968EEFCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-4-jamin_lin@aspeedtech.com>
 <311c3893-4e27-4472-8356-889fdaaade6f@kaod.org>
In-Reply-To: <311c3893-4e27-4472-8356-889fdaaade6f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5108:EE_
x-ms-office365-filtering-correlation-id: 3daa7cc8-7fb7-4020-cf71-08dca70ded47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dnhnK1dDZ2Z4OGRta1BGUDJaN3psMjVlNW4wdUhSbW1TTWZpb1NTZ0JGeXpv?=
 =?utf-8?B?SlFiYmZsSXVXdU9MSHN2dklpOUlMWGYxNGxKMnZ4TW5NSlYwL01TZ1F2UlND?=
 =?utf-8?B?SlZQSlRBdVhYdXR6Z0MrTm5NNytlVGl3dHowcENJeUFZY0tjN2FjWVV0ZFJW?=
 =?utf-8?B?eHhGeXFIRDdib0lUamdwVnF4WkpvUVp5b1lkbW9VVmI5dEQ0RnJPRk9ESFBr?=
 =?utf-8?B?OHFkOHZGenpWYjgxMUlrSVMzbk9NbVZPdVp2K2QwKzhXNENJM0JjRGN4c3FN?=
 =?utf-8?B?UDVoa3Y1N2xhVHpZSEhnc1hiRjZ2bFN6c2lIdmc0MUQyeE1JcmtuWGRKbW56?=
 =?utf-8?B?YlRONHBZeTVCYndoZ2E3UzV2R3VGRm9adTRIcFM0OGd5U0tMNHc3dDNjcVZr?=
 =?utf-8?B?Y0s2YjlxMXVYRGFNTnBZeURJWjliR2ZCZXJGM2MvWDZkMTUxaElVSXVFc0lI?=
 =?utf-8?B?bEFETWVSMXRLWkRsaHBTWkJ5dnNLei9HYjg0c0RqRWxmZ1poQ0J6YjRqdWZJ?=
 =?utf-8?B?a1RIVHZwUkYvd1JJUjE3TmxELzRjUExISEJaVk1oRFBNdTVSelVUQmpYTFdh?=
 =?utf-8?B?TXZMNVFVZTdsNW55NWlSY0poMmdOdk9UL2hTeUZodHlORDR3aW1nL3crR1ZI?=
 =?utf-8?B?TytFNDh5TEJGczRsZjFPUXZGcUFHK1RRd01FWGJIdHRWTFJxZk9LUHBwOHAr?=
 =?utf-8?B?NWk5UEFCWDdHbzdHUnViTTJFRHhHUWpGdXBKZmdqc2FUY01Bb1FQZzlUZkxn?=
 =?utf-8?B?N041Mk1GbFlRZkRHUE05Q2tMSGc5Sm5nb050REFnSUdCRDloREhyMHZkQjdP?=
 =?utf-8?B?TTRoNWFHTkR4cS9DcHFFNWJHazVhUXZEU0RYd0JWS3g5Z3FlcUhNcHpST2d4?=
 =?utf-8?B?dlJjOGxhd2gxKzM4TCthUk9nK1FzV2J5dEFYMllWbHZNVUIrN0pqb2RHUGRm?=
 =?utf-8?B?bWFpbWE4Q2J6SGU2U0I4TWYvZ1crT1ZnN0ZQMmwrSTRjMHZTaUUvNUhDa3Ay?=
 =?utf-8?B?cnhDa2lYN2NJWXB0bnVMZm40VjNPeHAzMk9pNEZjc0hsS0psQWZ1QjRBc1Fp?=
 =?utf-8?B?eWRpSXJEWURmS2FDOHVlWlZIR2xHOU1oUDgrT1ZpMCtSQnBERzJHdEN0aGVp?=
 =?utf-8?B?WkdHRUNQNkZqWXZCbGFlUmxLOURvamw2aFVZb3Q3TjE2TjBnOEZOM2FBejdZ?=
 =?utf-8?B?RjNuTUdJRXVsY1lPK2ZKK2pZQ1lKNGhCSm5hbmpLSGlxVndVR3VhVzZ1bHBn?=
 =?utf-8?B?WHFCNURWYk43eG4xVm0rZmhSdytuZEtoOFZUR3NNclhmT3Z0andVZVczYSt3?=
 =?utf-8?B?NHZ4QmtONDI5dUx2cUY2b1NNMlZHOENFNWwvVjFicjBqYkhSdnJhU3d1K1lP?=
 =?utf-8?B?MHR2MmJWdlpEK0U1akt0NjNzZUQwOGk2NFh5ZHBtTGdVdDFIWGY3T0xMOW44?=
 =?utf-8?B?eDdUV3pYdXdweTdyRzQ4Y284VFNDTkRCZDF0R1BNaExkME96RWtDOHZzWFJq?=
 =?utf-8?B?N29mZC9CallIMC8wOE5NbUxNZ1lFeDJZS3NOSldOMThpYXdnekg5WWs3cDNw?=
 =?utf-8?B?TzFma3FmVGZmV09Bck1XT0wyMmlxcHB5ZEJHMVJ3Tk1keTlIYTZiVWxGZ21P?=
 =?utf-8?B?bGdrQUxxb1pzTW9kbDhqd2FianVxa3Qya2N2TE4yL3hVYW1DV1RXSjJ6bGdH?=
 =?utf-8?B?MFZxM0J2NlV5QTBOOXo4NzhBeDRuK1F1SktybXB0cFJnY2RwQzgxR3YxeXZJ?=
 =?utf-8?B?ZHlsR0lkcitkQXhOV0xPWFJHV3ZqMlpldWd6Y3ZkYngzSjl5Vmo0V1R6MmFi?=
 =?utf-8?B?OE1kUytKcUlMMmZhVFdDcVprM3gxak9FSDZkSnRtNmwvazI0VmcyWEMrQXVI?=
 =?utf-8?B?UkxnNVU3RFJlNXNZRjRuSTYxVkxCcGF6OWVzeUVQN1BWWVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWhxK096bS9NaHFXbEkyV2g2cG1DQzZLWHNtQ0s1Q3BpSFJkYTIxM3VSVE5v?=
 =?utf-8?B?ckd0enRCdjdSL0RKZVkyTjhnT3J4RllMQ0IvekNHMWwvVWVWUFQ3WmhOL0h4?=
 =?utf-8?B?Q0lSRzZ6cE40cXZVTkI1RUdTclIyQ1RBSGs1cGJYOGdwMFkwaHRybE9hZWZz?=
 =?utf-8?B?RlEvenZYYzNNWVR0T1ZXeEFDTDVGNkVrclBwalRtbUhaaFk0TlAvVUorZUxH?=
 =?utf-8?B?eCs4TWRYRXo2ZTYxck9MOWZDOG5XMnIyU0s3SEREaUEyZkRRZWtDa0d0dDZZ?=
 =?utf-8?B?STN5UE1SMWI3Wkk0YnRZMVN3cTg0R3FNMXZNVHhuaElTYXE0TUVVY1p4NC9x?=
 =?utf-8?B?a2I2MGJKNmx0OVc5RXViUUVPbU1XR2d3d29sTzBpbTZXSFJoYU50WVFkM0RR?=
 =?utf-8?B?TlhpMWNOZURoZ1JNSDd4RnF0VVE5bytmZStMYmlJbEwxNUVyWUthZG04NUNj?=
 =?utf-8?B?VEFBc3lsS1piZ3JEU3FQMlRRWnlQV3g2Y3RLeFhFbXlYZzRzSlFZK2tjVHFl?=
 =?utf-8?B?UGE0Tks4NEFQakoybUVUMEkzM0F2R1k3U0VDY1l1em9wbWR2Mms1SjE5cFBQ?=
 =?utf-8?B?Tzhvd2FVUERLRjZ0enU3bDR5UDJTK2I2c3A3NTkzbVFYdzNhSHh1MGl1Zmxm?=
 =?utf-8?B?a2tmRE1zNEtaTU11TGJtOUcyU3JDOUNGeDlqZFZ1QmYzdFZ6T1l1TGF5RWRp?=
 =?utf-8?B?TGNlcVFDQnZpVlduL0FYdVV0N2ZReTlaYWRVRVdQQXBQaHlTdW5wYkFOaEFI?=
 =?utf-8?B?dmdkU3h1R3YrY0cwMG9qNkR0ak1YSFh0aFFlOFUzaEhwRmQ3cXVHVExGRVN2?=
 =?utf-8?B?MWt6dnQybm1RR1RsZ3F0eEZCUEwwbHBoNWd1TEF4TEI1cDdaT3haVVRMYlFz?=
 =?utf-8?B?QkRrcHhKMEIzN2FJRmp6eGVPcnJqeUpOK0pKa3NacUZEZ09TSHNFRUZWemU4?=
 =?utf-8?B?UWxtMThBVUxOVU8zOWxyeTIzMkh0K2FBNzBFb2lqUHUxRnA3NEpiVWdacXBr?=
 =?utf-8?B?cHYyMlNSL0RqSDVMR0syZVpmQ0d1TEErUlc3eXc4cGF0R1NpeVNkT0p4U0NH?=
 =?utf-8?B?ajdtTG1wOXFQSENKWVZkRDg5VEJvU09rdStiREhVRHk0eVVuUHhiNWRBdDFI?=
 =?utf-8?B?NVF6Tm9rZEVqQ1A3eHgvS1JhTGlWdTJabnFlUzRVL3d3TkR3RTg3N1Y1WFZW?=
 =?utf-8?B?OWNjeE1WZHBuTlFjUURBdmxxTEdEdHpnRWtGSFdiTjdudnB6bmVvaldicjBJ?=
 =?utf-8?B?dkV5RlR4K2htU0ZiV05XdmZmTGlmWHhnN0hMWmlaVEdERkdRWWVITGZybnRE?=
 =?utf-8?B?UlJMRXpRMHRyV2JaSkUxck9TVmFOUUFRNFlrNUUxeWFEVi9lR2p4NXluUUs5?=
 =?utf-8?B?NEtiYWVCMlJZZFBRR21YRjRWNmhmQ2QreXdIbVI2aUZzdkxkb21uS0NZL2U3?=
 =?utf-8?B?RlJDVGdVdkUrdTNJd1R6WGNBcFp4V2JHK3p1OFh4L0Z3WTVKa2ZqSUpPZHNr?=
 =?utf-8?B?NnA2bHZBbnE5bEx6VEUvLzFrangwMkVpNUhMR2lxRUgxT2taaUU5UjFyVkJy?=
 =?utf-8?B?ZXBtL1E1UkFrNVh1YlNOcTFjbnorM3FIdlZobEx1UEFSSUtpUXRMemRScnU2?=
 =?utf-8?B?ODU2dDBKSE5rTmUrSzRtTFc2SWpVYkpUZVlFL2RvR3RWRUk5UUxUbjFDQzRp?=
 =?utf-8?B?WU94WWplR0IvUnd0V0lkVGsrWWMyWWFIUjJEb0VRK2FpUHpoQUdCcGxrYi83?=
 =?utf-8?B?ZDREWXFsUEZKSmNkbEMzcWdQS2dCbDVmUm1ZamNPMElHRlJIOTBQT1NrVGdV?=
 =?utf-8?B?WkorRWhxVXV5bThHRUs2bG9tSzlnalFNSVNUMUx2bTJGem9BcllVMzJmN2Jm?=
 =?utf-8?B?VWlmb2hxMnhWRnYzOFI0RVBxZ1dzZ1BoTWE4M0RrWHVTVFMxODhicEdDdDhB?=
 =?utf-8?B?N2hEZHJNOTNLcXo3OGdHdkhNbXhwTjdUZnowUGRYcHJzVXdVM0JvWWVGNWFu?=
 =?utf-8?B?VVF0NjJUamI0T3MzajRBdW9aaTYrWEZqMTluYkROUHl4Uk8rMGUrQnRiNUlO?=
 =?utf-8?B?bGxGVklEcm0xQU9aSTd1SWZvenR4MytmUGVua2hBY3lFRlVpZmJpbVVhQ29x?=
 =?utf-8?Q?lj1JH8mP/8gacRXUiZ8+ZT9gx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daa7cc8-7fb7-4020-cf71-08dca70ded47
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:42:23.7048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlT+sBMu5Ps6TSHFeey5Be5IcqWUUt8xKPv1ZXY/uFoNG6W0/42z8vKDosT3Vs7sCw2DezRM75BZP4nYAQWA/d1le8DXxgr0DD3dX/4h1kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5108
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMTVdIGh3L2kyYy9hc3Bl
ZWQ6IHN1cHBvcnQgdG8gc2V0IHRoZSBkaWZmZXJlbnQNCj4gbWVtb3J5IHNpemUNCj4NCj4gT24g
Ny8xOC8yNCAwODo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byB0aGUgZGF0
YXNoZWV0IG9mIEFTUEVFRCBTT0NzLCBhbiBJMkMgY29udHJvbGxlciBvd25zIDhLQg0KPiA+IG9m
IHJlZ2lzdGVyIHNwYWNlIGZvciBBU1QyNzAwLCBvd25zIDRLQiBvZiByZWdpc3RlciBzcGFjZSBm
b3IgQVNUMjYwMCwNCj4gPiBBU1QyNTAwIGFuZCBBU1QyNDAwLCBhbmQgb3ducyA2NEtCIG9mIHJl
Z2lzdGVyIHNwYWNlIGZvciBBU1QxMDMwLg0KPiA+DQo+ID4gSXQgc2V0IHRoZSBtZW1vcnkgcmVn
aW9uIHNpemUgNEtCIGJ5IGRlZmF1bHQgYW5kIGl0IGRvZXMgbm90DQo+ID4gY29tcGF0aWJsZSBy
ZWdpc3RlciBzcGFjZSBmb3IgQVNUMjcwMC4NCj4gPg0KPiA+IEludHJvZHVjZSBhIG5ldyBjbGFz
cyBhdHRyaWJ1dGUgdG8gc2V0IHRoZSBJMkMgY29udHJvbGxlciBtZW1vcnkgc2l6ZQ0KPiA+IGZv
ciBkaWZmZXJlbnQgQVNQRUVEIFNPQ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2kyYy9hc3Bl
ZWRfaTJjLmMgICAgICAgICB8IDYgKysrKystDQo+ID4gICBpbmNsdWRlL2h3L2kyYy9hc3BlZWRf
aTJjLmggfCAyICstDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9pMmMvYXNwZWVkX2kyYy5jIGIv
aHcvaTJjL2FzcGVlZF9pMmMuYyBpbmRleA0KPiA+IGI0M2FmZDI1MGQuLjdkNWE1M2M0YzAgMTAw
NjQ0DQo+ID4gLS0tIGEvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+ICsrKyBiL2h3L2kyYy9hc3Bl
ZWRfaTJjLmMNCj4gPiBAQCAtMTAxNCw3ICsxMDE0LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2ky
Y19yZWFsaXplKERldmljZVN0YXRlICpkZXYsDQo+ID4gRXJyb3IgKiplcnJwKQ0KPiA+DQo+ID4g
ICAgICAgc3lzYnVzX2luaXRfaXJxKHNiZCwgJnMtPmlycSk7DQo+ID4gICAgICAgbWVtb3J5X3Jl
Z2lvbl9pbml0X2lvKCZzLT5pb21lbSwgT0JKRUNUKHMpLA0KPiAmYXNwZWVkX2kyY19jdHJsX29w
cywgcywNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLmkyYyIsIDB4MTAw
MCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgImFzcGVlZC5pMmMiLCBhaWMtPm1l
bV9zaXplKTsNCj4gPiAgICAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwgJnMtPmlvbWVtKTsNCj4g
Pg0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBhaWMtPm51bV9idXNzZXM7IGkrKykgeyBAQCAt
MTI4Niw2ICsxMjg2LDcgQEANCj4gPiBzdGF0aWMgdm9pZCBhc3BlZWRfMjQwMF9pMmNfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgYWljLT5wb29s
X3NpemUgPSAweDgwMDsNCj4gPiAgICAgICBhaWMtPnBvb2xfYmFzZSA9IDB4ODAwOw0KPiA+ICAg
ICAgIGFpYy0+YnVzX3Bvb2xfYmFzZSA9IGFzcGVlZF8yNDAwX2kyY19idXNfcG9vbF9iYXNlOw0K
PiA+ICsgICAgYWljLT5tZW1fc2l6ZSA9IDB4MTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3Rh
dGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF8yNDAwX2kyY19pbmZvID0geyBAQCAtMTMyMCw2ICsx
MzIxLDcgQEANCj4gPiBzdGF0aWMgdm9pZCBhc3BlZWRfMjUwMF9pMmNfY2xhc3NfaW5pdChPYmpl
Y3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgYWljLT5idXNfcG9vbF9iYXNl
ID0gYXNwZWVkXzI1MDBfaTJjX2J1c19wb29sX2Jhc2U7DQo+ID4gICAgICAgYWljLT5jaGVja19z
cmFtID0gdHJ1ZTsNCj4gPiAgICAgICBhaWMtPmhhc19kbWEgPSB0cnVlOw0KPiA+ICsgICAgYWlj
LT5tZW1fc2l6ZSA9IDB4MTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5
cGVJbmZvIGFzcGVlZF8yNTAwX2kyY19pbmZvID0geyBAQCAtMTM1Myw2ICsxMzU1LDcgQEANCj4g
PiBzdGF0aWMgdm9pZCBhc3BlZWRfMjYwMF9pMmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xh
c3MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgYWljLT5wb29sX2Jhc2UgPSAweEMwMDsNCj4gPiAg
ICAgICBhaWMtPmJ1c19wb29sX2Jhc2UgPSBhc3BlZWRfMjYwMF9pMmNfYnVzX3Bvb2xfYmFzZTsN
Cj4gPiAgICAgICBhaWMtPmhhc19kbWEgPSB0cnVlOw0KPiA+ICsgICAgYWljLT5tZW1fc2l6ZSA9
IDB4MTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVl
ZF8yNjAwX2kyY19pbmZvID0geyBAQCAtMTM3Niw2ICsxMzc5LDcgQEANCj4gPiBzdGF0aWMgdm9p
ZCBhc3BlZWRfMTAzMF9pMmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRh
dGEpDQo+ID4gICAgICAgYWljLT5wb29sX2Jhc2UgPSAweEMwMDsNCj4gPiAgICAgICBhaWMtPmJ1
c19wb29sX2Jhc2UgPSBhc3BlZWRfMjYwMF9pMmNfYnVzX3Bvb2xfYmFzZTsNCj4gPiAgICAgICBh
aWMtPmhhc19kbWEgPSB0cnVlOw0KPiA+ICsgICAgYWljLT5tZW1fc2l6ZSA9IDB4MTAwMDA7DQo+
DQpUaGFua3MgZm9yIHJldmlldy4NCg0KQWNjb3JkaW5nIHRvIHRoZSBkYXRhc2hlZXQgb2YgQVNU
MTAzMCBpbiBjaGFwdGVyIDcgKE1lbW9yeSBTcGFjZSBBbGxvY2F0aW9uIFRhYmxlKQ0KLCB0aGUg
cmVnaXN0ZXIgYWRkcmVzcyBzcGFjZSBvZiBJMkMgQ29udHJvbGxlciByYW5nZSBpcyBzdGFydCBm
cm9tIDdFN0IwMDAwIHRvDQo3RTdCRkZGRiBhbmQgaXRzIHJlZ2lzdGVyIGFkZHJlc3Mgc3BhY2Ug
aXMgNjRLQigweDEwMDAwKS4NCg0KVGhlIGZpcm13YXJlIG9ubHkgdXNlIDRLQiBhZGRyZXNzIHNw
YWNlLiBXZSBjYW4gY2hhbmdlIG1lbV9zaXplIGVpdGhlciA0S0Igb3IgNjRLQi4NCkNvdWxkIHlv
dSB0ZWxsIG1lIHdoaWNoIHNpemUgeW91IHByZWZlcj8NClRoYW5rcy1KYW1pbg0KDQo+IEFyZSB5
b3Ugc3VyZSB0aGlzIHZhbHVlIGlzIGNvcnJlY3QgPw0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IEMu
DQo+DQo+DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRf
MTAzMF9pMmNfaW5mbyA9IHsgZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9ody9pMmMvYXNwZWVk
X2kyYy5oIGIvaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oIGluZGV4DQo+ID4gYTA2NDQ3OWU1
OS4uMDY1YjYzNmQyOSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJj
LmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiBAQCAtMjgzLDcg
KzI4Myw3IEBAIHN0cnVjdCBBc3BlZWRJMkNDbGFzcyB7DQo+ID4gICAgICAgdWludDhfdCAqKCpi
dXNfcG9vbF9iYXNlKShBc3BlZWRJMkNCdXMgKik7DQo+ID4gICAgICAgYm9vbCBjaGVja19zcmFt
Ow0KPiA+ICAgICAgIGJvb2wgaGFzX2RtYTsNCj4gPiAtDQo+ID4gKyAgICB1aW50NjRfdCBtZW1f
c2l6ZTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBhc3BlZWRfaTJj
X2lzX25ld19tb2RlKEFzcGVlZEkyQ1N0YXRlICpzKQ0KDQoqKioqKioqKioqKioqIEVtYWlsIENv
bmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNCuWFjeiyrOiBsuaYjjoN
CuacrOS/oeS7tijmiJblhbbpmYTku7Yp5Y+v6IO95YyF5ZCr5qmf5a+G6LOH6KiK77yM5Lim5Y+X
5rOV5b6L5L+d6K2344CC5aaCIOWPsOerr+mdnuaMh+WumuS5i+aUtuS7tuiAhe+8jOiri+S7pemb
u+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7tuS5i+eZvOmAgeiAhSwg5Lim6KuL56uL5Y2z
5Yiq6Zmk5pys6Zu75a2Q6YO15Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA5pyJ6KSH5Y2w5Lu2
44CC6Kyd6Kyd5oKo55qE5ZCI5L2cIQ0KDQpESVNDTEFJTUVSOg0KVGhpcyBtZXNzYWdlIChhbmQg
YW55IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBsZWdhbGx5IHByaXZpbGVnZWQgYW5kL29yIG90
aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgaXQgaW4g
ZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwgYW5kIGltbWVk
aWF0ZWx5IGRlbGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgd2l0aG91dCBjb3B5
aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5b3UuDQo=

