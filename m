Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF7D44C43
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMz3-00060x-Qx; Thu, 15 Jan 2026 08:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMyh-0005Mn-Mf; Thu, 15 Jan 2026 08:01:32 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMyg-0007Hj-Dr; Thu, 15 Jan 2026 08:01:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkVWlahDBtoMbwfUajg9B6IFXtsHflmF7jxPah8+EML7S6ODtGEPUoczK32x73YW9y7zGboVCt1QJDcVcWBEC5UR30uH2u4oIkbA6RQr5KVX4NHvdNye4apaPvpbS4LvknGVoyCqre7Q0oTO360PeNC9dlHyEEVXCAs4YYBpeQI5vhz7NSfUz27Uar8k8sLydLLHmgrfhImkE3jeczR97l7e+0MimyD41DAPfiLoLJVhF3F7ofgHc+DWe3om96xk4oIVCwvmW+WIf5Z+PjrJdw96Pl7EdzjyohOwRaaEZXT0oVvlM9A6rqH2zpWN4ScktxAEl7wUX585Lr4PYmum5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krfl2gwdvnSA+0lAFv7znqwiowlDWWJUTHB0VWIYSvE=;
 b=eWiBMyAYPS4OLrCR/17PQ+cCOjkhfUMwkZr5EMonkmAeYrkFm+Sqn2Cke+ao4ItMtBgGCyw1W9LajqiOSv8b1v46v5/ZYgjN9USEr2/4Itcp71Ql/JpwTDaV4GLvlr0RVgOPvDVAHrGAMgHhaowJPc4FKDmhVP2QM88+DnaH2nLZ+FpSkT20ADl3uEVDP2C4+sbvVzWEkYn5aBxofq/DKM71HKG9/bGVVrrO80a3skCLjVBbWduZ0l/IlpffF14wm6/KOrgOSI/YJrY+FLtwqM1/p5ks/keeWv0uwfzbKvZ+SAR8YCK/tUh40jkWdw7uUjDuM/xihQhBrpfGCUrQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krfl2gwdvnSA+0lAFv7znqwiowlDWWJUTHB0VWIYSvE=;
 b=U+TFgbERK3jGlpcCh3OwqP3sTHHyyfct29WiWoMhoR5g1kBVYcczdr9WJJ0omsAyLtAfc3mSBw0oOeZntL+18r+0Lx75904Ai3IqNeEJ4wN6WwFDFWMNxXvsWUSwwVXi9Fy6Bc4ssR+vY52dM/oaCl6JyFbJPmRLLWL3yzImhuHoGwiJW3gBXdAN7auoXj4nJ9iwAt03w2aKEX9o1LSR9BZJmKBp5abKbbT3oUuzODVw5LMaPGINy++v8pqELth8ATLG+WQ2LOZqqReHNLYDeQ4KtHfz234NjRB+jOawUXTyb3deEZIAL4HEq10c8t41qgg9HRbSQ0MAzJVYnmV3WA==
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com (2603:10a6:803:e6::13)
 by DB9PR09MB6507.eurprd09.prod.outlook.com (2603:10a6:10:304::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Thu, 15 Jan
 2026 13:01:16 +0000
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387]) by VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387%7]) with mapi id 15.20.9542.001; Thu, 15 Jan 2026
 13:01:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 0/2] [riscv] Fix issues found by Coverity
Thread-Topic: [PATCH v2 0/2] [riscv] Fix issues found by Coverity
Thread-Index: AQHchh8InyAyqdZIsECBkGNERH0wBA==
Date: Thu, 15 Jan 2026 13:01:16 +0000
Message-ID: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2798:EE_|DB9PR09MB6507:EE_
x-ms-office365-filtering-correlation-id: aebdae24-9ec0-45e4-6090-08de54362b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N0Z1b0h4c2JjRUFuempjRk0vTzUrUlEySGsvUnl3RGNIZGJ2a21uOVljUWFh?=
 =?utf-8?B?SU1uMmNKZlpFMjVlZERoS1ZPclJwV3MwcVNuVlRQanYwaTE0Ujg3VjdPSHFi?=
 =?utf-8?B?alY3REVJWEJIaERnZXhLOSt3N3dwNlNDTm9mdnMwb0ZGU3J5bmJEc3MzSU5w?=
 =?utf-8?B?dy9vUHpSNUExTGhnNjNoUTYzL1RFTlRJeUpSODM0c1QwVVNVbXY2a3ZhRkNx?=
 =?utf-8?B?RFR3KzNPR0JnbWFQaWwzWko0WnIvWktqZ1hIN0tEcStkWEIrd3dFYXZVWFRh?=
 =?utf-8?B?UXA0UFl5bXhZZG5JNENVYU02TWFSZkpldXJzVEhUc3lMMWtxa3JEWEFybjVr?=
 =?utf-8?B?cGZGNkw1cnFzM0E4VkUySEpCWHJ4NUI5d0ZodXJySnl3d3F6d1htR3VRbDVO?=
 =?utf-8?B?MmVBQ1BxNXRodXM5bDNmcStxY2tKS3RNSXd2Rkx3YkpEQjl2RGRhUUh3NU8x?=
 =?utf-8?B?RXBNaU5YbmtNYXljdlFkVXJ5QXlFSHV4dld3K2o3YnZEOVY3bWNIQXBhMXN3?=
 =?utf-8?B?NjlPbE4zWHFXV1JPRDRrRDc2MWwzWk5jUTZDbzlMUDRwZitSYXhCb2lrWWhz?=
 =?utf-8?B?QXQ5UHV4QVRRUGFvblJzTmlMUnhCcHdIeVlmUGtkVVpkeHNxdmYwbE56NmtW?=
 =?utf-8?B?SmVuWHJTS2thTHAzQ0ZDU3BVNmpqM3JjUmV6NzVLY3NWUVM5YVVydXBkMWht?=
 =?utf-8?B?MnkxQXNRNi95d3ZQTjVHc2ZVZUd3OU4rR2RmVnUxSktvb2lhQmtDNnJTL3NQ?=
 =?utf-8?B?VW5aTU9TYXF6TGtJNlRUZHZjQ3VlbTFBV0FFTUVjajBKSC9OcER4SmNJY1hh?=
 =?utf-8?B?UWtlQTltSWZlMy9HNjhQemdEZFk1TlVjenRsbUtlRThnei9jMzlpUVpFTUZj?=
 =?utf-8?B?NFhSYW11UUhFREZwWHp2c2xGejFYVGFzbWxJeTlNbjFWT2FwL3pzeU05ckFG?=
 =?utf-8?B?ajV1MHozbXZGRGZRcXYvbm52ZGkrY29rU1R5TGhrWE9YVXY5WHZmcjQwZXBm?=
 =?utf-8?B?VlA1cWtoaEl3Q0kzQ2JYY2dYd1BTZi8rV1gzc3luSDBUck1sWTg3b0ZGSG11?=
 =?utf-8?B?emIrelRMNk5vUEpVVmZHWEZXWnBmNnJwbGtXdDhiRFk5bUdxcWE5dm9RTFlZ?=
 =?utf-8?B?cmg3Sy9adUt3dzBERXgzaUw1UmhkazN5QUNFUjZDM1UySmxTS1pEbmJpL3dq?=
 =?utf-8?B?TlU4T1YvamFCeTMzdm9VVFJKb3pEaC94TkRndmZHUkRGL2JBMVhYY3NjK2p3?=
 =?utf-8?B?SXVpejBsdkp3WUtwVEFPcXlVK2J0Q2Q5d1lBNThhTlNQU3RUYk9aSGFPdXhK?=
 =?utf-8?B?UXMwUDJ6UEs3bEwybEJYYUJScDhTQkxJbVVZZ0JqSjlJNkhtdUxDS0ErbUJX?=
 =?utf-8?B?L2I2Ty9UOWZmbE9TRXN3ZVBNd25UTktWNFBnZmNPbEdUZmhpT1AzLytpeXFS?=
 =?utf-8?B?bTk0K0RRckZESE1hRVpIZGp4T1pFelRqamhrOTh4MWg0S2FEWFR6a0dsUzN1?=
 =?utf-8?B?WkE5VWRQdWdwei9KNzJqeW81VTU3d3FwMXZXaWJldjZtcWdldTBnS0prenQx?=
 =?utf-8?B?bUtUK2pYbVhma2lhcC8xWGZJbjgwSXJsSWkweFVwcWp1dU5pc1dzclppZ3JR?=
 =?utf-8?B?NWl2eTlRNmt3RERwTTVKODI5TlVlbmRob28zVmhHOG9ldUpoYm40OWRTRzhu?=
 =?utf-8?B?ZXEwb0VobFlham1zSmlZV2l4ZGttSmtOL3c1dTBKOFY4MnhueDlhQ1VuNi9W?=
 =?utf-8?B?azZHTkw4TWMvYWR0aGEwQS9DMktaNWIxWHFEcHRVT2x3RkhQbVJMT2M1YkhL?=
 =?utf-8?B?QU9TSEJIMHFmd0tEVzR2QURuU0hSWmE1MTNWNzJ3V2dnRUw5TWxneXA0K053?=
 =?utf-8?B?L0RLZzhkTEd6S21EQ29MRWp6SnQ0ODJjT3dCM3BHazM5V0FjbHFRWGJLeFNk?=
 =?utf-8?B?MlUrLzcyMHNyUGdqdGNaVzhidkh2a0pBc2Vod0JYYmZ0NDVSWTVvSU11RVJm?=
 =?utf-8?B?bm5UYmFpV25tWTllV0t0NWRCc2RoT2FxN1VzSFV6SngxeDArK2Y1QTB2dEpB?=
 =?utf-8?B?U0F5b2dQY0FlNTNYZWhXdVlPUnp5ckJLaDFsd1RqRks1NFV5ZWpOS0UyYXV4?=
 =?utf-8?B?SEkwaHZkczlEN01pbmVZZkFNWFYyOHN2YjlXVzNQekR4Z3RrMCsxZ2poM1A3?=
 =?utf-8?Q?xSXTfGEjPw1KmMqTehwYMIM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR09MB2798.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0hrOTlucWdnS2Iydlg2bW41eDhCZzFvZlZENzR4NjRDTXJ6RVRFWS9NcjZu?=
 =?utf-8?B?MVVyNHhBNDhnSGI0L243ZjZ5aXQzRGloQlhHVnZrU2Z1N0dGRVhQSUE2QzBB?=
 =?utf-8?B?NFA2QlY5QW5mODhGQWYwMU9LWlE0aG5icHYwRXlOeTBmSHpCWlVPdnNkcnFy?=
 =?utf-8?B?U1puSlZiY2lrSEwwVkIwM0JRb0N3aUFCRjZFRVBjVXE4aWdJbkVnUm9JcE1G?=
 =?utf-8?B?VGNMNUpoRUkvamErNHJDQ3pPc3NXWmZETTM1YmhSWDJXWFVqV2lmY2U4VHpX?=
 =?utf-8?B?dTAzS3dnMUtFOEovbEN2aGR6dEQzcm1XY3gwRWExb2ljNXRPbEJWajFnYVBG?=
 =?utf-8?B?cTNJNGpNbjBSRGdHaS82NU4yUENVOXFsL0FmR2Y4bHV5OUI5L0dySGp1c3ln?=
 =?utf-8?B?RDY1OHM0RkJDQXR1czFKc2dPWWE0QW1jdWhhNVVzN0o3bEQvbTVyYzVwbUh6?=
 =?utf-8?B?R1hJYWx6ZkFlVW5PQ29lM0YxQ0RFOG1wZmJHWE9KeFE1Rk01dCs3eUx0U3dM?=
 =?utf-8?B?QzZBdzNtT3Znc3o5Q0tKeE56MTFoZ1p4eVNDei9NZkdCSFcyVUZjUVk2TzJU?=
 =?utf-8?B?Qnd5WUlkM00zZjVhOHJ2a0lEYW9CaWprMXUwbUNLVzA0WkVVcUxRTTMzM0VT?=
 =?utf-8?B?Y3NvR2ZnTWh3QUNjOGJhMEppRDRVV0JIbDJkTmpuNVpDa29XeGN0aVMxQlNz?=
 =?utf-8?B?aWN2RHlwbnQzSUhOYTMzUGhaMmhHd1NxVzFxclJGZ3VLU2tsUXBiWXpNbFcr?=
 =?utf-8?B?L21JazhUN1M1LzR4RjJYaUhTZGlUTEVUQTAyU09iVVk5SGU0ZVRad1ZieHRO?=
 =?utf-8?B?bzE3SDNmd2Y5cyt1RGdJdXowdGJlS2FqTlpudWV0YU84RlJpcGJBL2tLcndK?=
 =?utf-8?B?bkZtWkRsWDcvOHZvVDNwd1RsZ250Y1NudHlTa1FjLzVFeVY0Skp5cm9URWJ4?=
 =?utf-8?B?YkJXM2xpbndwR3RtczJQT0JtNEw1M25aRC9zQ0JjdG1UM2lKWWtaMElDQ1FP?=
 =?utf-8?B?TnRZVWpiYmF5L2Y5clRxME03VFRjZWtGdGdhMHhTWkRiZDErdlBCWU9TUVBD?=
 =?utf-8?B?UlhyVDM2TXNTNEhkaC80MEszTC9UbDBnYzI0MmRCQXhlUUV0T1BqdjloUnJj?=
 =?utf-8?B?eGh0RGJIdk82NXdSRkJFNGZDb2p0ejEvR2lrSzcwZWlsQjJNUTRKbVcwdkJD?=
 =?utf-8?B?RHBqRTk3Ly9sbTZXVFdoNlhOSmpjZkhoNFQ1dVZCdTExaTlJbnpUbno0UHBW?=
 =?utf-8?B?VXBOSTdvUzNySW53ZS9oU1lYZy9td1JvZ0RuOHZ0V2lUWFRRM052UjR1dlM0?=
 =?utf-8?B?UVRSTjAzVVJFZEd0TlljUzNjeWEzNHR1UGJEV0hDUEtkMHBiWWpIaGN1SlF2?=
 =?utf-8?B?M3pOcEZUdzk1d1ZYV2xJMGxzKzE0Wmk2TTZyOFRZOXVVS0orOFRBNEhPRmJY?=
 =?utf-8?B?ZGZaVWhSQlJKc2tSZW5jT04wVHVTam9yZnVqOEVFS1A5bEVVKzRMRFFuWGh1?=
 =?utf-8?B?UHFQck1wdUNZUlZjYlZSSTVidTVZSk4yMldZNnlPb0tqYTdFejU3TkRIZWxG?=
 =?utf-8?B?VFBTdjRWaDNrVGd2eVRCK1N3Nm5VL3VxdXgzNGRZQmxDME1sc2pKWUdmWU5V?=
 =?utf-8?B?Tml1Q3RPZzRWdXFITWprUTR3c21raGJOQ2NYRVNrU1NjVHFOQWdPMGFJSWlO?=
 =?utf-8?B?SVd2d3d2MCswMjNHUGlraU1sRlJDbmFUUUFMaUYrRkdnK1E4TU8yNE5hTUtH?=
 =?utf-8?B?TVYxUWpVVEQrLzVHeEtNNjZ3MjNxMEVKd2s2VndxNnNHcTVJSHpWQWZ3TmpZ?=
 =?utf-8?B?anJjL21Zem9OdFpsei9QWXVQRDZTbm5xSlFXSmFXUUtzUzJpVjd4TlpheE11?=
 =?utf-8?B?U3ZFNkZvcGJFRGtZRGw1THROakF6Ujk4Tk55bU12eXhPTHpaZXNaWFlXQmg5?=
 =?utf-8?B?SzBTcTJiSGZCZzhwSHFVdndyTXNyeEdlZXpCTjRkQmhRN0pyNzduMm4yZ3dn?=
 =?utf-8?B?WUhGazgxa09IVEpTcmt0dXVidmg2cHNwZXBPY3BVbkJiZVVTN0tNcVp5UFRE?=
 =?utf-8?B?RjdIRDJzQUcvN0VVYW1SeHhlQVJEUEFhZXBBVnc5ZEdZaUhic1F3NnlFcmFN?=
 =?utf-8?B?VGFwMTg0Q1dTZkhub3l0bGN4RG5MdzBtM0cwS1BQZFlaaEZkN2FTbDA2dGdV?=
 =?utf-8?B?anVDQmlRZzhDTFJ6ejVDQXVwakc3Y2k2NEZVNXRrL0VobUpLYURoQkY4VkFz?=
 =?utf-8?B?Tk1aZHVuMDNGQ1BvaG80WUNOQkNGZDQxdmd2NEVHOXFldGloeXljemloNm9P?=
 =?utf-8?B?cGdYdzlnVUh5TmFkUUpydE1Ydi9jaDMyTEtTQWhPbENGdDVnTDVCcVEyL2d3?=
 =?utf-8?Q?vw0m/U1xvOv7yVdMWv8vS8v8CU0zM6mWaZ1qw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F857712253305F4EAA81C2B7E7AD5A8B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB2798.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebdae24-9ec0-45e4-6090-08de54362b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 13:01:16.4051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbJsj4wwKoztKS5VuQZJ7uaR5EH0/vwGIQr/o/UHYITLeabS5IGwoHXgrYhY4fNUr9eQvPEWOQBonST2T/7+Z0cWauxFas26Lp8LT/ODpSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6507
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

QWRkcmVzcyBvbmUgY29tbWVudCBpbiB0aGUgZmlyc3QgcGF0Y2guDQoNCkRqb3JkamUgVG9kb3Jv
dmljICgyKToNCiAgaHcvcmlzY3Y6IEZpeCBpbnRlZ2VyIG92ZXJmbG93IGluIGNtX2Jhc2UgY2Fs
Y3VsYXRpb24NCiAgdGFyZ2V0L3Jpc2N2OiBGaXggbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIGlu
IGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2UNCg0KIGluY2x1ZGUvaHcvcmlzY3YvY3BzLmggfCAyICst
DQogdGFyZ2V0L3Jpc2N2L2NwdS5jICAgICB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCi0tIA0KMi4zNC4xDQo=

