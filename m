Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EE6EF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHCx-0008UT-Oz; Sun, 08 Feb 2026 21:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpHCs-0008Tm-GM; Sun, 08 Feb 2026 21:40:59 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpHCo-0002ob-Rz; Sun, 08 Feb 2026 21:40:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITe0ZPNpAbaXAay55+DJOSHH55zLkS+sUHLHx5iVDVgDiDV7fW0ZJLHE7mZqU9oQ09GGU2pNryw1iUfbtEyKQazDOrnTfLtLqg45ZA280NC9PNjgjcw40RM4rGju64mF1F28FFIrw8r8Psw2ruRSgOZYpTeIFC75xx9kSdESUQrTS/kdrPnOZ1nl/oPM0w0Bhzo0RsOB4naLcjh3kx0czpuw2M6jZQTA9o9d05yniALC+mzAwk6SnGlgASmmcgxrRMaJuj16rrzSyU9A9FU0R3d6KcDKaiGsLpq2eq7FoAmzuNpxLW7qqhcwcX+eHpG7We+zrnZ5KbZyvyx7RnDF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPaft6bY8XdbMGr+ps1qRX01MJFVR0u7I7S46+AiMM8=;
 b=duu8vFw5KLQpwrewpeCr+9AkTGpe7LJjhXkFQTYdtxr+T2yhrj2cx8+GI+LGn2EOpcSmanzkp1RsAMiKEHLZ3S5EcTST94x6Nl3OmI5prYBP0vuWBtoYhXptLJCM1vOkqiHLjsY+t7hYaiXtl2FosyQh340ULNumau1dy14prdrJOmquXwnFgnSJ8LQAlgwsdpA/l/CE+/NKwda2h063zBEzSeXD80b86Wo6w/LNUqJahlS41by8/JCt0NW2cWoAFTyYOUXSr+WiEhixonhuOiSdIckgU3ud7LrV9Jt6EneAtzTJIjuJWkOdyBcbIi/rrB4fI7Gk8DG3q6kfcgZreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPaft6bY8XdbMGr+ps1qRX01MJFVR0u7I7S46+AiMM8=;
 b=mVMozVzwnMmXgpLHloe087GsKDMh0Wve1YS8LbC6NrFBHGGGu+q41SljKVc8LH+3nTrywSePCsGyjk7oxXahaIfPqWn1O2L8XP4eITLG2dD9YMweMnydASat4cPmXCDrFoyiZ3R1VBBPjGsKH/SfF0wg20hCcBcCXDn0d8BO21CLwzGQZr8dtSbYgIHGC4hAxU6r52bU7B7Nci7uS2VlucKEGGUC4ieNqtVAzfdySC8Uj6gMIfCYonP46d+SazhRNR6zO8YN0AQ32cBitxKKX2EvUyVfom7R40EM1lCD5PZK7X47Jt6wOXHy7DRhxU58tqd5Ujpuu8OajJobrgqujA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB7261.apcprd06.prod.outlook.com (2603:1096:101:226::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Mon, 9 Feb
 2026 02:40:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:40:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
Thread-Topic: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
Thread-Index: AQHclyotTMSkhEzxh02MKNnGkZXEgrV1c6WAgAAIAQCAAA7BAIAAAMgAgAQgJ0A=
Date: Mon, 9 Feb 2026 02:40:46 +0000
Message-ID: <TYPPR06MB82067F58E9552791FF94FE3BFC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-10-jamin_lin@aspeedtech.com>
 <83d409cf-868c-4a2d-b1c9-5741d3e36adc@kaod.org>
 <a6757611-32d0-4451-be0e-724648e1654f@redhat.com>
 <CAFEAcA83c+ZHANxxKQBhCNvX1ObTp9hk+Wb0Yzb8ezx7HqDxpg@mail.gmail.com>
 <61774393-0aaf-46bf-8bc7-cf79d5a98cfb@redhat.com>
In-Reply-To: <61774393-0aaf-46bf-8bc7-cf79d5a98cfb@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB7261:EE_
x-ms-office365-filtering-correlation-id: 68a7deeb-db00-4ef5-b2c0-08de6784a09d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bUZyeTdpaFhEZGhnNG52TFpEaGsxRnMxTGF3NzJncjhlNEVNejdCeHR3OCtR?=
 =?utf-8?B?TlpxYUlwaHJDNDVIOGdlaE9yK2xEWUdEdlFUUWlsSThPZVlTeFRKOXVvdU1D?=
 =?utf-8?B?ZU81TFFGOWNNc1N6aEorR2Zncmo4WVRMUnV6bmFrM0ZyVnIrbWpUUzJXb3pu?=
 =?utf-8?B?MVFFZXB3RmpMMHVCdzF3YWtDSUxuVFh1UzZnWHVGV1RPQmNTcCtMNklFTHJD?=
 =?utf-8?B?V2tYK1lwaVFWSXVkOXhLaDFCZmZEelhjUTFWT2Q5ZmUxb0pYRXBCTkNTV0dC?=
 =?utf-8?B?L29pZURDSFBOcFBCM0lHY0lhSWN5cVhkWElySGlSVno3RTRzR3BJeWtBNXpq?=
 =?utf-8?B?THdsTmg2aEY5Rkp3c2NFd2YvNGNCRkwrdlZDbnZ2aHFnalJjbkpOaWxnWS91?=
 =?utf-8?B?Y0lKUFJZaWt0K3A5dGVBRmVRNU9vMG9ndkdHNkJPU2M2cStFbkZrdjZnVnpr?=
 =?utf-8?B?SmticFRLbndSMm1QVitZZFlVMDhMRmpITGlxTTZ2dDdJTUFxL3E3T2ZFRUJ6?=
 =?utf-8?B?NElZYW9yVWJaYXYrbzBYZ2hvS05hT2tEdCsrRTJvUzB5djlTRk9RWjRlTklE?=
 =?utf-8?B?OVpNdkY3V0M0STB0YWgvbjdMb3NIWXh1aUZlZ3VvVjdIaElXdWhMQjUxZjAx?=
 =?utf-8?B?ZkIreHovSkFENkh6Uk5CTjhhZVdCNFVlRkt4VjVNTW5FaGkxRGtnNjUwdGh4?=
 =?utf-8?B?dlYxUlNFWnQ2ZEszQnZheUFjVlhSSTEwd25LdS93NVg2bDc2YmExQkp0MzBF?=
 =?utf-8?B?VXcrd1J5eEY5TlRJTE1QOFpnVmpKbDNsdlhFU0xzcTNwS3kzS1dDS1hIcEZN?=
 =?utf-8?B?akFTQ1ZHM3lYdlUxRmNaR1k3c1NWaGhiTEMxY1FQYXg4WlRVTWVnUSt2WHds?=
 =?utf-8?B?cXlDSnpIOW4xeDhTelA3N3VYaXBUL2NhZ3RyU2ZlVVZZS2kvNG82TDEyN2JF?=
 =?utf-8?B?dE1NSG9BSWZmaHNpKzQ0RmsvNysvSzBzc0tRS25MeFZBSXdqQ3lQbXhRUllj?=
 =?utf-8?B?a1I2bVVsQ0Y4c2J1d25hcmdGcWladzZVcHI3aVhqYWh3M1ZHdjhuOTlCT25l?=
 =?utf-8?B?Y21qMUxBZ1V0ZGpQYWNoNitNREs4K3hHTCtrN1czTDZtTEhiNTltQVpXcWlr?=
 =?utf-8?B?L1R1WjBmV3UxZHBLRDZqOG11MnhsRjVrSkxwb2NUbi96NGJxWmZnSi9tZXZs?=
 =?utf-8?B?eWhPZDlJaWlObExHQ3N5bW1ML3VqS2NadUdiSGZOSi81Yll4R0hXM0JiZk1p?=
 =?utf-8?B?UWs5S3FOQmZTeFJOU29wQk9wbmpSdW9LV2FZblM2YTE4eitBcytiNmdLOTlJ?=
 =?utf-8?B?dHZ3ZzdvaGlWUno1NVUwSXhZZzNCUjJmR3NrdnVUR3RFQnkxTzNBbW9jT2Rr?=
 =?utf-8?B?RVdweEljR3VMcVFCa3g4RVlRV2twNjlWNVhLdnJ4VEJDckk5VHZkeS9WUEdR?=
 =?utf-8?B?a3JkRndUMjlOenF5akd6YUVLak1wc2R5S1BpTUpkajJ1WEtmakxRR2ZZVE5w?=
 =?utf-8?B?L0NzejREZ3VFQ1BuREFyaWFuSEVIeGthbno1VkpIb0l0WllxVE5QYk9LTE9O?=
 =?utf-8?B?VzVqNktoS0VKYUhOKzA1SWl6TzB3a1ZHMmhRR1RyVUNIN3dqNU51U2FaVHQ0?=
 =?utf-8?B?ckdKOXZTUG0xeVdWellaS3Zvb2dDZCt1ZzVldUZyOHpGa0ZmT0hBOGExaEF5?=
 =?utf-8?B?cFdISkV6bmRPNHFianNranlMVHV4cCtNejVjemFOejFmclJkOEtxMXZ0TjZv?=
 =?utf-8?B?VXNHUU5nVjR6K014LyswRERDVDJJR3ZxL21kNzQ0OVlQUWMrZ0p5SzhqM2pH?=
 =?utf-8?B?NzgzbjNFMk1lcC9zZzVxUTRJYU9rMWNXRE5zMVZYYmJIbzFRNmVsbFRoRmpm?=
 =?utf-8?B?ZFdJVDY4RitzbXYvdEphbUZnNjhpUis4TGEyek9sUHRhdGFyd2FYcDljSUxx?=
 =?utf-8?B?WUREd25lR1BpZ2U4UXFxYW1XY2l6N1R2cExIWVhyMUFiYXN4dWtzZ0Z4OGVs?=
 =?utf-8?B?bDB0UjVIMnUrMkoreTZCa3ZzYlpwblhWelE3YnJ0Zi96SEoramVYRVBVajFs?=
 =?utf-8?B?Q3hZem5FK3l0U0pUczA3dWtKaWxGdXNYT3V6aVJvczNROG1pSWhJeWVtTy96?=
 =?utf-8?B?RWVTQy81cUZaZGFieWdhUmkrM3UwYjltMlFUcTBrWTRjMm5vN2tPcC9zcjVp?=
 =?utf-8?Q?QDZgZmKMxGaRvnZUdLOD7t4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2F4aU4rUnhFVlFld0pRcUxTZGpnaEdURmVNWHk2L1RZbnNiemF2dE00QTNC?=
 =?utf-8?B?QkR3Zm10QXZKaEtUeFB2U2FGU1IwS01yRHJZem5WWUFRaUVqMU0rWitPOURU?=
 =?utf-8?B?SDhFTGxqN0JVUE91cHlEODJhU1pNOG0vemx0Sk5Rc29aQ0JJNlZWekxrZG9U?=
 =?utf-8?B?ajg2NVA1WUQrb1NTL2NyWVlRUTZoSEh4NGtmT3JYMm1jZUR5VHpVWS9kYms2?=
 =?utf-8?B?eCtPN1ZOazdhRlJxbmNJdElUOGVJWVhmUjhIWFhsZHM2bXE0RnREM2VocGZi?=
 =?utf-8?B?eTBWdFQ4VmIvVjhKZVVLTElHd3dRVjc3OTM4UmVGWnYvd3dmVGI3TDlWMjhO?=
 =?utf-8?B?S0VtV0JSZ09PWVFLdUtTRnAxWnFLeXF5djBEL2tZUGxxY1BXSjFvTW1uWDhy?=
 =?utf-8?B?Tmt5ZHJSUVQ3dFJpcG1TSUJJSXlhUmdaQVprSFpPWmJha0w0TGJVNWlkQUVk?=
 =?utf-8?B?UVR4QkFPUXdNUnRZZXBBa2pPczhYZmR6UVQ4WE4zNVN3c1lreTFqUXVWQmtv?=
 =?utf-8?B?MG5TWkdKbUhGV1FNYWtBb0c1aURKSHlLVVJ0L0RKU2JjeTI2UjQrN1V6cWZM?=
 =?utf-8?B?MVlRZE5HZXlmMGZuT2hRWXg2YVpoekFvQm5MWEdDRzVXbTVReE9SMko4R3FB?=
 =?utf-8?B?YnF1UlcwaGJIbDFhZWVQbUVGUTJXRGNPcVVBMkpHYUtGWTJUV3BBZit5N0hW?=
 =?utf-8?B?bU9IMS9aY3FCMHJHMko4blV3Z2Z0ck93dDJKSUVIWS82ay93aWVOVUxVc3JW?=
 =?utf-8?B?SEdyZW5keHorTXhTSnVyTDAvT3NoY1laMlFLMTZzOUEwZU40bWhteHlpQUY2?=
 =?utf-8?B?eDM1UDBaM0prcEtCYWd5dWNwYlQwaHc3b2dtQ2pSbm50OHIzUHJmMnNtNG51?=
 =?utf-8?B?eFU5UXpYUTBpbzY0cjRqSnNIUXhqSWd0Q2VOcHJDUGhHeGN5ZHlyT09zWmRh?=
 =?utf-8?B?M1ZwL0RLVGJRbXNRbUJETHBTN2VYQnBzRit1RXRYNUFCYnoyVENtekdSaFAw?=
 =?utf-8?B?dzh0WldUYXhkTnZlM2ZLeTdWdFltcFY1d1pRVHY5OVFQWmFpM2ZFVEZaNXV4?=
 =?utf-8?B?ZlZEM3l2Nm9qN0xHa0pUQ3dKZW5WQS9ITVNQSllTSzFnNzEwU0U4dWkwaWwy?=
 =?utf-8?B?WGp2cy9rSU5wQVMyMjdzUHQ1RUxJcjd0NE1IMklnc1ZIQ3RLWmp0b3lUbm9L?=
 =?utf-8?B?VWNMNEQwODhjQzFuSjFFTFU3Q0l1RmxCNEc0OWF6bUJhbUc2eUhCc2JRSXpF?=
 =?utf-8?B?SUJ6eVJzZHZ4RXMwbG50S3NvRTlXZDRteElBMjk1T1BTZ2VQRytyU29oRnFR?=
 =?utf-8?B?dXlvYmpUdUR3VEZvb3dxZ2QzaW1oa3UwQzBiQ2RpTzVKc1FTc1JBVFlXdWlt?=
 =?utf-8?B?d1VTNjk2eVZGYmppSzR3RXFQbDVEcGxFWlArU2lGVGQ3OTJGZnFjeVB3OVBm?=
 =?utf-8?B?enFra0oyMDR2VzZXNlgrK0k0VU9tbFF5L0FieVI3NW9IcE4reGdYV1QyTEFV?=
 =?utf-8?B?aW5oYjZzOWxhNmNrQVFsSmRqTDZDdHoxemxELzh2bHlkb0Z3TENGYUZNZmRW?=
 =?utf-8?B?V1Q1S1U0Q2RmNmRYQ3hWa3Rwbm8yMjZIY0F5TW5tYmFOTkxXSCtQK3RXdVVj?=
 =?utf-8?B?eUNXS25oZG1XWERkZEFjaHlUZVpFeXVuVWZLOEpPS2F3ZTZEL3VUTWQ0NnVM?=
 =?utf-8?B?QUVzUlcreklGMWovbnovNEpGZ04veG9xaTZ0TjU5OTVEQmZxMm52NU1PREpy?=
 =?utf-8?B?RXExNHk2RjRjZEN0bmIzQWRFRlZVNVorMC8zaDIzT2I5TStxaXU3aENOYWVH?=
 =?utf-8?B?TXQ3NFFqNm9LQnpQUllrbU44Y1ZMNzQzd202c3B5TkZaQ1FJelJHWENDUm4x?=
 =?utf-8?B?ZmpsWU9Tek9ndktpOEYzeitYYlYzZ3ZPWEdoL29NSVFUbXc4ckJTWW1RUTg3?=
 =?utf-8?B?T05Tc1YyU2d4c3dJNlVIbG5YNzJMcnZ2cWprVE5vMWliTHJNZk9uaDhtaFZS?=
 =?utf-8?B?N1d3dytES1lpRFJTUUVZUzBjcXROWFYwZ05MTktjK1lDdEk3NEFjTVk4UXBm?=
 =?utf-8?B?SVJPTkxmQVJtK25XUituVnU1M1BlbWZlbC9WZFVTVE9uM0w1alNyTHFOUkFl?=
 =?utf-8?B?UUo4WGdhTEM5SGd0RFRQUDJyN004WEhiS3BpNldQN3ErUlRoVExaQitONFNY?=
 =?utf-8?B?dUtpRXpsSVU3QlpFQ250a1psSEtGNDBLQm15NGpDL1B0RWE5Y0gvVk5GMVN6?=
 =?utf-8?B?ajcvdTVvQ0dncFQ0TjlweElySTEyRXRtb1NBdHZaeXhxS3JTNHh4VjRoSzhI?=
 =?utf-8?B?bDBpU0RFOWlLaVU0NHFkbkJSY051c0hKOUhoT3NvTnROTHVFbTczQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a7deeb-db00-4ef5-b2c0-08de6784a09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 02:40:46.0814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bX1qAYv0FRIbUjXfH2WLZTL0zzTQfOl51bbavk1x+RudYhI/AOBWKVY7f3XrKB8YYw0qhWzq055TI7VVrRlUty7mWJIbR5mL6dfe4ErY9/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7261
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

SGkgVGhvbWFzLCBQZXRlciwgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgv
MTBdIHRlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9hc3QyNzAwOg0KPiBBZGQg
QVNUMjcwMCBBMiBFVkIgZnVuY3Rpb25hbCB0ZXN0cw0KPiANCj4gT24gMDYvMDIvMjAyNiAxMi4z
MywgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gPiBPbiBGcmksIDYgRmViIDIwMjYgYXQgMTA6NDAs
IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gT24gMDYv
MDIvMjAyNiAxMS4xMSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4+PiArIFRob21hcw0K
PiA+Pj4NCj4gPj4+IE9uIDIvNi8yNiAwNjozMywgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IEFk
ZCBmdW5jdGlvbmFsIGNvdmVyYWdlIGZvciB0aGUgQVNUMjcwMCBBMiBFVkIgbWFjaGluZSBieQ0K
PiA+Pj4+IGludHJvZHVjaW5nIHRlc3QgY2FzZXMgdGhhdCBib290IGFuZCB2YWxpZGF0ZSBhbiBP
cGVuQk1DIFNESyB2MTEuMDANCj4gPj4+PiBpbWFnZSBvbiAiYXN0MjcwMGEyLWV2YiIuDQo+ID4+
Pg0KPiA+Pj4gSSB3b25kZXIgaWYgd2UgbmVlZCB0byB0ZXN0IGJvdGggbWFjaGluZXMuIFRoZSB0
ZXN0IGlzIGFscmVhZHkgcXVpdGUgbG9uZy4NCj4gPj4+DQo+ID4+PiBPbiBteSB0ZXN0IHN5c3Rl
bSA6DQo+ID4+Pg0KPiA+Pj4gICAgIHFlbXU6ZnVuYy1hYXJjaDY0LWFzcGVlZF9hc3QyNzAwICAg
ICAgICAgICAgIE9LDQo+IDExOS42OHMgICAzDQo+ID4+PiBzdWJ0ZXN0cyBwYXNzZWQNCj4gPj4+
DQo+ID4+PiBXaXRoIGJvdGggbWFjaGluZXMgOg0KPiA+Pj4NCj4gPj4+ICAgICBxZW11OmZ1bmMt
YWFyY2g2NC1hc3BlZWRfYXN0MjcwMCAgICAgICAgICAgICBPSw0KPiAyMTkuNzlzICAgNg0KPiA+
Pj4gc3VidGVzdHMgcGFzc2VkDQo+ID4+DQo+ID4+IElmIHRoZSBtYWNoaW5lcyBhcmUgdmVyeSBz
aW1pbGFyLCBpdCdzIG1heWJlIGJldHRlciB0byBtYXJrIG9uZSBvZg0KPiA+PiB0aGUgdGVzdHMg
d2l0aCBhIGRlY29yYXRvciAoc2tpcFNsb3dUZXN0IG1heWJlKSwgc28gd2UgZG9uJ3QgaGF2ZSB0
bw0KPiA+PiBleGVjdXRlIGl0IGJ5IGRlZmF1bHQsIGJ1dCB3ZSBzdGlsbCBoYXZlIHRoZSB0ZXN0
IGFyb3VuZCBpZiB3ZSBuZWVkIGl0Lg0KPiA+DQo+ID4NCj4gPiBJdCBtaWdodCBhbHNvIGJlIG5p
Y2UgdG8gaGF2ZSB0aGVtIGJlIGEgc2VwYXJhdGUgdG9wIGxldmVsIHRlc3QsIHNvDQo+ID4gdGhh
dCB0aGUgdGVzdHMgY2FuIGJlIHJ1biBpbiBwYXJhbGxlbC4gQUlVSSBoYXZpbmcgMSB0ZXN0IHdp
dGggNg0KPiA+IHN1YnRlc3RzIGZvcmNlcyBhbGwgNiB0byBydW4gaW4gc2VxdWVuY2UsIHdoZXJl
YXMgd2l0aA0KPiA+IDIgdGVzdHMgYW5kIDMgc3VidGVzdHMgZWFjaCB5b3UgY2FuIGF0IGxlYXN0
IHVzZSAyIGhvc3QgQ1BVcy4NCj4gPiBPciBkb2VzIHRoZSBxdGVzdCBzdWJ0ZXN0IGhhbmRsaW5n
IGluY2x1ZGUgcGFyYWxsZWxpc20/DQo+IA0KPiBObywgdGhlcmUgaXMgbm8gcGFyYWxsZWwgZXhl
Y3V0aW9uIGZvciBzdWJ0ZXN0cywgaW4gbmVpdGhlciB0aGUgcXRlc3Qgbm9yIHRoZQ0KPiBmdW5j
dGlvbmFsIHRlc3RpbmcgZnJhbWV3b3JrLiBTbyB5ZXMsIGlmIHlvdSB3YW50IHRvIGV4ZWN1dGUg
dGhpcyBpbiBwYXJhbGxlbCwgcHV0DQo+IGl0IGludG8gc2VwYXJhdGUgZmlsZXMuDQo+IA0KPiAg
IFRob21hcw0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHRoZSBzdWdnZXN0aW9ucy4NCg0K
SSBwbGFuIHRvIHJlbmFtZSB0ZXN0X2FzcGVlZF9hc3QyNzAwLnB5IHRvIHRlc3RfYXNwZWVkX2Fz
dDI3MDBhMS5weSBmb3IgQVNUMjcwMCBBMSB0ZXN0aW5nLg0KVGhlbiwgSSB3aWxsIGFkZCBhIG5l
dyB0ZXN0X2FzcGVlZF9hc3QyNzAwLnB5IGZvciBBU1QyNzAwIEEyIHRlc3RpbmcuDQpUaGlzIHRl
c3Qgd2lsbCBjb3ZlciB0aGUgbGF0ZXN0IEVWQiBtYWNoaW5lIGFuZCBTb0MuDQoNClBsZWFzZSBs
ZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcy1KYW1pbg0K

