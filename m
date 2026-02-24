Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62211EFB7EE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuonZ-0003nZ-7l; Tue, 24 Feb 2026 04:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuonV-0003n6-Oc; Tue, 24 Feb 2026 04:33:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuonS-0007sm-Up; Tue, 24 Feb 2026 04:33:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYnxbsHO3Ws/HMti/L7SvYAxFqA31+5NPXq3S9N6GcFE8Gd7acKbCWfudrsCHToK2v68xm2+Bw6RojT/0NLUGMOBNRxJbHl13GraYfL2S28bq+oPE6gLy9B7zPtIGParFLNC7+Ph0PiU/4Q4tB3k/cohfw0KS46LbjQX1wDgPSNCGjKCMgcGbdaW2yUGjD6TR9uCiAiLePYa0USqslZLzagJE+chxiRVydEB7FD5cMBlBqWEA8Cde937TNfI03B5w5U/2cxFmdYBhPbeoyBLZt4qmfkqr98fhI2bPZFbZiECyB8mBiHTUuRC6tZRw1LVTcL+YdMFXrKJajLrhqjYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73f4RsGa0tuulCoqwEaygtXlnZT29+27CWKpN8f6qRY=;
 b=k1FBY30mRItG30cpavP4DKW2Ama6k9jMb1pksKJZl5YAgyyoyP1a2VHcMZ4Re9UbhDTlyXzY3uQcF3uiF0o22hNll+Lu+k34kau9Hng9vkHMb+JkttPPJ5JlcIAFmYbckpPyJv8c1B1dLGQDXVFpHn1ctoXSf2OYI//WnSAjzCkK0UTw1rWvT8zy5V9OHix7odM4reg4FJR265i0QzoQTTHPeKyNl6p6fSeH2rU7VSwvkznUKbY1xcR/p/9g7XlrSayGT+CA9O6uh6rrAu9ibITn3hQWH4dx6I+7TAr9guR5EnipuSRN0mSGrAXiZAwnU53mztRziewpU6zzAv1Maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73f4RsGa0tuulCoqwEaygtXlnZT29+27CWKpN8f6qRY=;
 b=kR8eYaKLKvpwOXaME8QnKzQxMkGG2VY6aV5kYRDFbr/FUw6rPVHP23DmVI1/16NL4NXS5VDEIFERHGgKCgIpw/aJYpp7tClIqU9MVqO4L4PYaq7wjn45dAGydtEcTxM8JHcNaWTwNeHuTuyTZoywjt/llws9ripEcL18YXomGtuQgfODKcH1Cwbw0T7Xz4RpU/aTVji7G109dSkejRNfdguLVDmSrlgRAO8vc+2k17OWlAT67aq24r0EpPhJAmpwyT4arZG/etXN5aoDRldPE21o76p0bM0J6aOz23VXsDR/E+QcMXJsGTX847XB5nqHlMx5O9Q8jErjxdaFdK1jdg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6302.apcprd06.prod.outlook.com (2603:1096:101:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 09:33:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:33:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kane
 Chen <kane_chen@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Topic: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Index: AQHcn/bXw5yLp/LOskOx+2qAxSW0vLWRLc5ggABt1gCAAAOLEA==
Date: Tue, 24 Feb 2026 09:33:31 +0000
Message-ID: <TYPPR06MB82061B01B8E9B13A241A6AF8FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
 <98898cd4-de19-41b7-b519-541c48b462ea@redhat.com>
 <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
 <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aa6cbbb8-d8db-451e-9f9d-c430b2e030d9@redhat.com>
In-Reply-To: <aa6cbbb8-d8db-451e-9f9d-c430b2e030d9@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6302:EE_
x-ms-office365-filtering-correlation-id: a2360efd-b36a-465c-7783-08de7387c624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bWdjb3oxNVVCY28wRDhlY1c0MTk1c042YjBlN2F4YnNXblp2QkEyOE54VXNU?=
 =?utf-8?B?MU14OGs5bGI3SWg2MEdkMlVZdTJ5U1Z0SGM5NngzWEp1S1RhNDJaZm9PNWxl?=
 =?utf-8?B?cGYxTm1sdnBkcVl4WVRiazhkeHM4bnNrclQzdjBXU3d5Y0hwd3pibkFxajFm?=
 =?utf-8?B?Z0pwVlJqUVNQcFFFNm5meTM2a0hQMk9ZdVh5ZTNUTS9ReDdTVlRpd2J3RXpH?=
 =?utf-8?B?WTVEUzNuR1lKakszWHBSdk1aemJBVEZrWTcyQ1l5bE9iOGVyY2hkVTJqYm9w?=
 =?utf-8?B?WUhZNVduWjRyZVVDRVhPVDgyVnRKM0Y2L1FRTlJjdzB4aG1IN0hKSFdjbTRL?=
 =?utf-8?B?TXk2MDZwS3RnRFRjSzg2WG9XRmUwZ1I0aXU2Z3BmbmZ6T2R2Zml3KzNOT3ox?=
 =?utf-8?B?VmRjNGl6Sm9qZThSZUIyRHB5MXFsVnBudFRSM1A3OWhSanpnQk4vMytET0F0?=
 =?utf-8?B?by9rVkdsQWlIbHRLM1dqaEtvb2pYMTcrVUxGUkxHREJVZEp5Q3R0SHhJZ2dv?=
 =?utf-8?B?enpBVStPZ051YzQ3ZW5KUzF6WTduaDc5RmJVWldkeThRL210S3BKWnVCWlJz?=
 =?utf-8?B?UWFNN1ZlcEhvWS9yUzNYTVpHNWxyd200OUpuQ3QyR0doMXJpOVNvbFdibVMz?=
 =?utf-8?B?VEU1Q09rak9vdFlld0x1WXhraDBlL3cxWTJNUlRYOWI3bThZRCs3cm1SbG9J?=
 =?utf-8?B?ZlhXd2RsRGpKQ1FzV2pFQnpTTXlvU1JSbUVQTHJsTzlBUnJzbWxtVS8rdE5U?=
 =?utf-8?B?dDN3RklsMm10cXpaVE00OW9vKy9SeURqNTJsa0pDL3NBM1p1R0NmSDlqQUtH?=
 =?utf-8?B?QzNwOFZYSklObnRJY1BaeE9TaVQzZFVUSDZkTDNSa0JjZWl1T3JUcGhoaEww?=
 =?utf-8?B?TEx5RUFlV0dIYnVCU0dRUy9SR1FxYWtzdTlhdWQvckVMNlVLTkZtdFA3M1Zu?=
 =?utf-8?B?RE9UTTQvM3VGQVN2ejIxOFY4MXZLZC9rZ3JMRVl2dkZsbUlCeUdJYmJQc29S?=
 =?utf-8?B?WVFHenN5NFJsYjJ1d0MrWlFKWEg1cy9aQU9HL2ZHdkIrWHgrRmU2bDc1YjV0?=
 =?utf-8?B?elRyQy8xaUI1d3grd0NDYVRBQml3ekdnZW5lQ3hzaUFtd0s5TXpUMXo0UTdG?=
 =?utf-8?B?TC9pSG5mQmxrWEl4MENDamYrbE9ZUUREZXpjQm9OMXVHSk9oc2NpTU1wV2Fz?=
 =?utf-8?B?Zm9GRm9QMk1wdEU5cC9NU3ozTGdnNXFuV1lPWHIvSG1RaUl3UHN4WW5XUVZz?=
 =?utf-8?B?TEd2TmdIOHJ2dTdNRTEwWEpFbGo5b2daT2pSOUtPK2dTcDJ0bTU5Yng3aTZN?=
 =?utf-8?B?a3dxbkJ4SVU4VVZLeGF3dVFHQjZDQkpwYmFkNXU3dFRsRjFnL0ZvZEZkYURK?=
 =?utf-8?B?VU9hSjFIT2s1blZWZUUrM0IvRi9kV2tYRlpMRm9qUnZ4dXRnck1MNHFjWDBt?=
 =?utf-8?B?QTJmRjM2RXJBazk5WUJxMDMybStIalYxRE9oWWRYeTFVN2I4T2lkRVZDbjAw?=
 =?utf-8?B?aDlGcHYxNWNzL05BQlMxaSs4aHh5cGM3TkpJR0xHdG9Qa0xmZmk0MGwyeUww?=
 =?utf-8?B?OVZsMDhBcTVrb3ZYa2FEdE1vb0Yvdm5XakhTT1lIR0xxSHdlekdyNk4wd0p2?=
 =?utf-8?B?aVM1N29xT2V2c3Q3ZzJlWEpzYjJzdDJ4bjR1aDd6S04xcS9za1U1UnpaTHJV?=
 =?utf-8?B?b1dvNWxTNWEvQXR6L0hiL2xJd1hzOTlmbmNjMHN4L3c0cVlhOWZSdUk3Yys5?=
 =?utf-8?B?bnB2TUNNaGI0Yzk5TXdvcjU1OUF4VXVPNTNjSjZ3TmtQa1c2aW1jVkRjNGsw?=
 =?utf-8?B?eU5nTlNMdGMwem1hZ1VHWjEzVDY1bVUvV2RpYkJRbC8zclNHMGNtc2FSbmNa?=
 =?utf-8?B?dG1OWDMxMHMvdDJpMUZZcisrM01KMis3MENFcGZnalY2WWFZV1czV0FRVEdE?=
 =?utf-8?B?SGdGL1JYdHBjVHpMRlJjVmZnbmM1MG9TSzBsS1FTMGYrMG14ZXVlMWxya3dm?=
 =?utf-8?B?a2htTHRPb0kwdlJHZUlqZ0s2ekt4YndYUlVVV3l5M1hrSDFyU3Zab3VmWVBH?=
 =?utf-8?B?TU8wVkdJR0VWT0NBWWxweE1NUitwb1BLdkhOaGhmbVlYbUg2SW5LVzBtdlI0?=
 =?utf-8?B?dFJaaTIybW0rSUxkR0t6b1FrU2RBRGtHSERWRDNlY3lxdUdhV0FIWXE5MW90?=
 =?utf-8?Q?20NkGvJHumvt6pmPAVOLrFo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHREL25ySUlpK0VjTTZEaDdKMEVtQkJaNyswOGErazBOTmw0YUhGbVJUdTEr?=
 =?utf-8?B?bHNZMld3aUFaS2dCdFVqRmF2STdZMEtDd05CY2tRanVHWS9OVkZ6czQyVDZk?=
 =?utf-8?B?SXFsMzBGNUNHWW9jcjg2a3FhcWNwUnZkL2o5OE1ZSFUzY1JNY2xEUmFuc2h1?=
 =?utf-8?B?UUd6WVRYeHN5R1o0RElvUy8vWVE3b2FlclU1MlFWTVJvaUVEblIyUllYb2Q5?=
 =?utf-8?B?SjYyNnNZU1lWOXY1bDZzMTZMYkNUWE1XYTJZdlF1U3NWRWJQNnE4OWtrNnRO?=
 =?utf-8?B?ZTdZTHN5d0EyL1VUNGd2ZGFOWnBwSWVVTU4xYUlWVjNIaTJueHJyUVFGUXhk?=
 =?utf-8?B?ZHQ2WW5TY2NtWTJpYUh6NzNaaFZOQUJ1QXRxY2NZK2NMR0haTTFlZkd1NGJX?=
 =?utf-8?B?NW55TUdHamhhNFFJalBTZlBaUm9qVDNFWi9jcHd4MVpuUndwOXNQQ24zajZW?=
 =?utf-8?B?Q09WbmNxVFdpUWhHR0M0MlZNWXhId3h2REJZSTF4SCtSSkxHWVlzNEkvbjBn?=
 =?utf-8?B?RkN6cmNDTmFxaGE0a2ZZUDdxRnpKQmMzTEZFMGcvZnN0UjZnM0xLMkR5Q0Vq?=
 =?utf-8?B?SWtTd3FYVWNGQkJ6c1ZXQ1lWSmpWNDJCWWZFRDU5Snp6N21Xc1BlRUFyOWhE?=
 =?utf-8?B?TnBHUlJTZzVmWW1abHI1ankvKzZBOG9aaWdQaUFDMkUwWUNBMTVmS21PdTlt?=
 =?utf-8?B?L2NlYmw0QXQzTUVVaWJiM3hiaUI5SWNDbjE1VzNhTVMrei9YRTh4NzdKaS94?=
 =?utf-8?B?SVlPc1VHa1B5TU1naWZOWnEraTFxUHYyQ083bmU4R1NjUXkySEZzaWpiNUhP?=
 =?utf-8?B?UzJNZERFNitvYlp5RXc0enR5REtDb2cxN3RQY28yanZKUGZuZytaN0FHQ1Qy?=
 =?utf-8?B?YjhOV3o3VTlFY3JhbGtFSzA5NitxdVM0UCtHOVNnTW4xMGpaYzZHMXJtUXls?=
 =?utf-8?B?RjV2c1pxM0RvTFQvZUxHeG1TbGhUbDhBY1dLYTVvcnIzNHR4cEVYdk5qWUJ5?=
 =?utf-8?B?VWpvN1Y3WTg1YWl5OHN0by9QMTlZK2VYUzlRWXR1TUZhckZRaHFCRUFVYnAv?=
 =?utf-8?B?NHErMjkrZDhRNFpKVTRsRENpTmJ5cVVhSE9FWndrNTE3a0xkSW5uWGkvYUNF?=
 =?utf-8?B?eEc2MjFwWGpLVkZzMXZVRVMxejFOOHhZSy9Wdk1DRGVlY084cCt3RmYrOUd0?=
 =?utf-8?B?ODNVa0prMm1EcHpwQkI1aDhQUEhXZm03QitRaml4ZGs4ckluekZMWGE3MkNt?=
 =?utf-8?B?dXJVcXhpdWhFUDcyeUtSTGxWcVQxWlJZeG9oZkVpZHdybDlZT2l4MUtYM2NO?=
 =?utf-8?B?YTJQZGJ6dzl1dkgrZ290c0xZQ1l5ZXVPa2NjTlNpQjB4U3RmTGtWWkhxNE1k?=
 =?utf-8?B?clBvTGhPcFpxZEp5NlU5cjZNR2cvMGx2T2lSTmZoamhvSHNsR0NaZzNTaWVv?=
 =?utf-8?B?TjhnTUtQclBXdHVIcFRPQjN1R2pFcE1pNTBTY3Q4Wm1ybkFWcllURk5nK05u?=
 =?utf-8?B?RlMzbGVGb3lxYVVHckxiSXFyenBsZG0xL3ZOL1NxV3RlU0d4MUc2NGE2T0pm?=
 =?utf-8?B?Tmg2UXJHMzdKUDE0VE85aFVrR0U0NTRYZmJwK2xJSzFVQkhkM0FiZ21DUDkr?=
 =?utf-8?B?M2xQYndLRlFsa012cUl0NU5KWmFyZ0g0WUVBeUVlWDcyVm1WMzhCSk5zK1BT?=
 =?utf-8?B?Um9qbTFDM1REVlY2VXEyV0luM2hLS1pMcnNJU29RT3hGbVFlK2d0bE5jSkVy?=
 =?utf-8?B?RVV0ZUZBMXluUEhwQjlEUm16VGYvakZoYnZVQ2lnWExpd3ZpYndkMzhDQk9K?=
 =?utf-8?B?MHJuNkJaNzM1UWZIeUpzdXFpR0ZTV3B3SnVtMUY3L21lU1VaeCtianNjZlJK?=
 =?utf-8?B?UHZ2dEFQWXFrbTVjY2RmRkJwV1VZQ3pScTZxMGFYVE9pTHowM1pndFJaeWwz?=
 =?utf-8?B?N1JMRG8vTWYvMWJMOTBwUi9KU3ZFMHJsMzlVNzF1RFpkNUxGRHZXbXpJZ2pJ?=
 =?utf-8?B?d283ejZxbDIwU1BtS05PZFgyYkxUQThkYkdjU0Z6T1c0OVpjMEJHNWhQSkdC?=
 =?utf-8?B?eUlHMXpCNVA2V1lkT0hBSUpZckpBVTFFSTd5STNiUEVGNHF0dWtzZytTTzJN?=
 =?utf-8?B?dHRZOGhrNXpoc0RtNFY2aG5EUmxtaWFRbUg5TWZuY0k3ZVRyNy9ueFhCUTFP?=
 =?utf-8?B?WkFuQVFWeUZ2dzlJWWw4MXZuRlRNSktQOTVrSmsrelF6R1pucy9XTlQxTytY?=
 =?utf-8?B?aWZjMGJ3ZXlIelc0czMzWEQ5WVBib0tJMmM2c2JQV3BXNTdVRU9WRmdwMHQ5?=
 =?utf-8?B?MkFyS0JLeUhVUHZ4SDF2WjlzTHlqSFRxSjRGam9vSU0vWEF3Qjk2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2360efd-b36a-465c-7783-08de7387c624
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 09:33:31.4040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NXS/vgAToOAHF2ZS5i3ruGyZK/CeUKOZ2phk7BsOaF6NoxBfKAUtUYUMT2KNXzTpApx5lYWE7qb7Zg1vtMHF837rNYG8oTrINgRhl0ksOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6302
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BVTEwgMDIvMTZdIHRlc3RzL2Z1bmN0aW9u
YWw6IEFkZCBTREsgdGVzdHMgd2l0aCBMaW51eCA1LjE1DQo+IA0KPiBPbiAyLzI0LzI2IDAzOjUz
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gKyBUcm95DQo+ID4NCj4gPiBIaSBDw6lkcmljLA0KPiA+
DQo+ID4+IFN1YmplY3Q6IFJlOiBbUFVMTCAwMi8xNl0gdGVzdHMvZnVuY3Rpb25hbDogQWRkIFNE
SyB0ZXN0cyB3aXRoIExpbnV4DQo+ID4+IDUuMTUNCj4gPj4NCj4gPj4gSGVsbG8sDQo+ID4+DQo+
ID4+ICsgSmFtaW4sDQo+ID4+DQo+ID4+IE9uIDIvMTYvMjYgMTY6MDgsIEPDqWRyaWMgTGUgR29h
dGVyIHdyb3RlOg0KPiA+Pj4gT24gMi8xNi8yNiAxNTo1OSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4gPj4+PiBPbiBNb24sIEZlYiAxNiwgMjAyNiBhdCAxMToxNzozOEFNICswMDAwLCBQ
ZXRlciBNYXlkZWxsIHdyb3RlOg0KPiA+Pj4+PiBPbiBNb24sIDE2IEZlYiAyMDI2IGF0IDExOjEz
LCBQZXRlciBNYXlkZWxsDQo+ID4+Pj4+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+ID4+
IHdyb3RlOg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIFRodSwgMTIgRmViIDIwMjYgYXQgMjE6NDIs
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4gd3JvdGU6DQo+ID4+Pj4+
Pj4NCj4gPj4+Pj4+PiBBZGQgZnVuY3Rpb25hbCB0ZXN0cyBmb3IgQVNUMjUwMCBhbmQgQVNUMjYw
MCBtYWNoaW5lcyB1c2luZyB0aGUNCj4gPj4+Pj4+PiBPcGVuQk1DIFNESyB2MTEuMDAgd2l0aCBM
aW51eCBrZXJuZWwgNS4xNS4gVGhlc2UgdGVzdHMNCj4gPj4+Pj4+PiBjb21wbGVtZW50IHRoZSBl
eGlzdGluZyBTREsgdGVzdHMgYW5kIHZlcmlmeSB0aGF0IFFFTVUgY29ycmVjdGx5DQo+ID4+Pj4+
Pj4gYm9vdHMgb2xkZXIga2VybmVsIHZlcnNpb25zIG9uIHRoZXNlIHBsYXRmb3Jtcy4NCj4gPj4+
Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4+ICvCoMKgwqAgQVNTRVRfU0RLX1YxMTAwX0FTVDI2MDBf
NTE1ID0gQXNzZXQoDQo+ID4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+DQo+ID4+ICsnaHR0cHM6Ly9naXRo
dWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjExLg0KPiA+
Pj4+Pj4+ICswMC9hc3QyNjAwLWRlZmF1bHQtNTE1LW9ibWMudGFyLmd6JywNCj4gPj4+Pj4+PiAr
DQo+ID4+Pj4+Pj4NCj4gPj4NCj4gKydlY2UxYTkzNDA5NTM3ODkyOTc4MGYwM2U3ZDA5MmU1NjJm
NGIzM2IyODQxYjgwYWQ3YzNkMTJhODU3NDRjMGY2DQo+ID4+Pj4+Pj4gKycpDQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gVGhpcyBhc3NldCBmaWxlIGlzIG92ZXIgYSBnaWdhYnl0ZSBpbiBzaXplLCBpdCB0
YWtlcyBmb3JldmVyIHRvDQo+ID4+Pj4+PiBkb3dubG9hZCwgYW5kIG91ciBmdW5jdGlvbmFsIHRl
c3QgYXNzZXQgZG93bmxvYWQgZnJhbWV3b3JrIGhhcyBubw0KPiA+Pj4+Pj4gbWVjaGFuaXNtIGZv
ciBnaXZpbmcgYW55IGtpbmQgb2YgcHJvZ3Jlc3MgaW5kaWNhdGlvbiBmb3INCj4gPj4+Pj4+IGRv
d25sb2FkcyAob3IgZXZlbiBmb3IgdGVsbGluZyB5b3UgdGhlIFVSTCBpdCBpcyBkb3dubG9hZGlu
Zw0KPiA+Pj4+Pj4gdW50aWwgYWZ0ZXIgdGhlIGRvd25sb2FkIGlzIGNvbXBsZXRlKS4NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiBDYW4gd2UgaGF2ZSBhIHNpemUgbGltaXQgZm9yIHRlc3QgYXNzZXRzIHBs
ZWFzZSwgYXQgbGVhc3QgdW50aWwNCj4gPj4+Pj4+IHRoZSBmcmFtZXdvcmsgY2FuIHN1cHBvcnQg
bGFyZ2UgYXNzZXRzIGEgYml0IGJldHRlciA/DQo+ID4+Pj4+DQo+ID4+Pj4+IEZvbGxvd3VwOiB3
ZSBoYXZlIHNpeCB0ZXN0IGFzc2V0cyB0aGF0IGFyZSBvdmVyIDUwME1CIGluIHNpemUsIGFuZA0K
PiA+Pj4+PiB0aGV5IGFyZSBhbGwgYXNwZWVkIHRlc3RzLiBQbGVhc2UgY2FuIHlvdSBoYXZlIGEg
bG9vayBhdCBzbGltbWluZw0KPiA+Pj4+PiB0aGVzZSBkb3duPw0KPiA+Pj4+DQo+ID4+Pj4gSSBz
ZWUgMiBiaWcgYXNzZXRzIGZyb20gYXNwZWVkIG9ubHkNCj4gPj4+Pg0KPiA+Pj4+ICDCoMKgIDY0
ZDg5MjZhN2QwMWI2NDkxNjhiZTk2Yzk4NjYwM2I1NjkwZjA2MzkxMjg2YzQzOGEzYTc3MmMNCj4g
OGM3DQo+ID4+IDAzOWU5Mw0KPiA+Pj4+ICDCoMKgIGVjZTFhOTM0MDk1Mzc4OTI5NzgwZjAzZTdk
MDkyZTU2MmY0YjMzYjI4NDFiODBhZDdjM2QxMmENCj4gODU3DQo+ID4+IDQ0YzBmNg0KPiA+Pj4+
DQo+ID4+Pj4NCj4gPj4+PiB3aGF0IGFyZSB0aGUgbmFtZXMgb2YgdGhlIG90aGVyIGZpbGVzIGlu
ICRIT01FLy5jYWNoZS9xZW11L2Rvd25sb2FkDQo+ID4+Pj4geW91IGhhdmUgdGhhdCBhcmUgb3Zl
ciA1MDAgTUIgPw0KPiA+Pj4+DQo+ID4+Pj4gV2l0aCByZWdhcmRzLA0KPiA+Pj4+IERhbmllbA0K
PiA+Pj4NCj4gPj4+IFRoZXNlIGFyZSB0aGUgZmlsZXMgOg0KPiA+Pj4NCj4gPj4+DQo+ID4+DQo+
IDU3MzIyNTVkNDYxN2Q5OGI3NmJiYmMxMTZkMzMxZDZhYzg5OTA2ZmEyMTI5NjllYjgyMTNmZGM0
YWVhODY0NTENCj4gPj4gICAxNjZNDQo+ID4+PiBhc3QyNTAwLWRlZmF1bHQtNTE1LW9ibWMudGFy
Lmd6DQo+ID4+Pg0KPiA+Pg0KPiAyNzY4ZTI1MjZiZGQzZjkyOGRmMzEzNDE4MDFjYjZkZTNiOWE0
MGNhOTQyYjUzOGEzZDA4MDBjZDI2ZmJkYmZlDQo+ID4+ICAgMTY2TQ0KPiA+Pj4gYXN0MjUwMC1k
ZWZhdWx0LW9ibWMudGFyLmd6DQo+ID4+Pg0KPiA+Pg0KPiBlY2UxYTkzNDA5NTM3ODkyOTc4MGYw
M2U3ZDA5MmU1NjJmNGIzM2IyODQxYjgwYWQ3YzNkMTJhODU3NDRjMGY2DQo+ID4+ICAgMS4xRw0K
PiA+Pj4gYXN0MjYwMC1kZWZhdWx0LTUxNS1vYm1jLnRhci5neg0KPiA+Pj4NCj4gPj4NCj4gNjRk
ODkyNmE3ZDAxYjY0OTE2OGJlOTZjOTg2NjAzYjU2OTBmMDYzOTEyODZjNDM4YTNhNzcyYzhjNzAz
OWU5Mw0KPiA+PiAgwqAgMS4yRw0KPiA+Pj4gYXN0MjYwMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+
ID4+Pg0KPiA+Pg0KPiA0Zjg3NzhiZTE3NmVjZTFiNTdkMzNjNGFlZTEzYmI5ODliZTExNGMzZTQ3
MDMxNTBlYWViNmY5OTZiZDU1ODdmDQo+ID4+ICAgNTgyTQ0KPiA+Pj4gYXN0MjcwMC1hMS1kY3Nj
bS1vYm1jLnRhci5neg0KPiA+Pj4NCj4gPj4gZDVjZWVkNTExY2QwZGZlZmJiMTAyZmZmMmQ3MzEx
NTllMDQ3Mjk0OGEyODA2NmRjMGQ5MGJjZDU0YmU3NjUyNQ0KPiA+PiA1MjBNDQo+ID4+PiBhc3Qy
NzAwLWExLW9ibWMudGFyLmd6DQo+ID4+Pg0KPiA+Pg0KPiAwZTkzZjc5NzYxMzlkYTcxZmFiOWRm
Nzk1MmE1OGJkZDgwNjUwZTIzZTdhYmY1ODUzYjBlYjY2OTVkZWIwMmQwDQo+ID4+ICAgNTgxTQ0K
PiA+Pj4gYXN0MjcwMC1kY3NjbS1vYm1jLnRhci5neg0KPiA+Pj4NCj4gPj4NCj4gZTJiOGYwNDNm
ZTgwNjNkZDNiNmRlZDkzNDIyZTM4YmQ0MTkxNGRjOWMzMjAyMTk5NTA3NjUyZGYwMjRkZTRkYw0K
PiA+PiAgIDUxOU0NCj4gPj4+IGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+Pg0KPiA+
PiBUaGUgaW1hZ2Ugc2l6ZSBmb3IgdjA5LjA4IHdhcyBhcm91bmQgMjUwIE1CIGZvciB0aGUgYXN0
MjUwMCwNCj4gPj4gYXN0MjYwMCBhbmQgYXN0MjcwMCBTb0NzLiBJdCB3b3VsZCBiZSBiZXN0IHRv
IGtlZXAgaXQgbGlrZSB0aGlzIGZvciB0ZXN0aW5nLg0KPiA+Pg0KPiA+PiBXb3VsZCBpdCBiZSBw
b3NzaWJsZSBpbiB2MTIuMDAgPw0KPiA+Pg0KPiA+DQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlv
dXIgc3VnZ2VzdGlvbiBhbmQgZm9yIHJlcG9ydGluZyB0aGlzIGlzc3VlLg0KPiA+DQo+ID4gVG8g
YWxsb3cgUUVNVSB0byBhY2NlcHQgdGhlIGltYWdlIHRhcmJhbGwgc2l6ZSwgSSB3aWxsIGNyZWF0
ZSBuZXcgdGFyYmFsbHMNCj4gc3BlY2lmaWNhbGx5IGZvciBRRU1VIGZ1bmN0aW9uYWwgdGVzdGlu
Zy4NCj4gPg0KPiA+IFRoZSAiYXN0MjYwMC1kZWZhdWx0LWltYWdlLnRhci5neiIgdGFyYmFsbCB3
aWxsIGJlIGJhc2VkIG9uDQo+ICJhc3QyNjAwLWRlZmF1bHQtb2JtYy50YXIuZ3oiLg0KPiA+IEl0
IHdpbGwgY29udGFpbiBvbmx5IHRoZSBuZWNlc3NhcnkgaW1hZ2VzIGZyb20gYXN0MjYwMC1kZWZh
dWx0LW9ibWMudGFyLmd6DQo+IGZvciBRRU1VIGZ1bmN0aW9uYWwgdGVzdGluZywgc3VjaCBhcyBp
bWFnZS1ibWMuDQo+ID4gSW5jbHVkaW5nIG9ubHkgaW1hZ2UtYm1jIGluIHRoZSB0YXJiYWxsIHdp
bGwgc2lnbmlmaWNhbnRseSByZWR1Y2UgaXRzIHNpemUuIEluDQo+IFNESyB2MTEuMDEsIHRoZSBz
aXplIHNob3VsZCBiZSBhcm91bmQgNjRNQi4NCj4gDQo+IEkgdGhpbmsgdGhlIGluY3JlYXNlIGlu
IHNpemUgY29tZXMgbWFpbmx5IGZyb20gdGhlIHJzYSogZGlyZWN0b3JpZXMuDQo+IFJlbW92aW5n
IHRoZXNlIHdvdWxkIHNhdmUgMUcuDQo+IA0KPiBDYW4geW91IGtlZXAgdGhlIHNhbWUgdjA5LjA4
IGNvbnRlbnRzIDogdS1ib290LmJpbiwga2VybmVsLCBkdGIsIHJvb3RmcyBldGMgPyBJdA0KPiBp
cyBnb29kIHRvIGhhdmUgdGhlIGRpZmZlcmVudCBPcGVuQk1DIGZpbGVzIGZvciB0ZXN0cyB0b28u
DQo+IA0KT2theS4NCj4gDQo+ID4gSSBwbGFuIHRvIGNyZWF0ZSB0aGUgZm9sbG93aW5nIG5ldyB0
YXJiYWxscyBmb3IgUUVNVSBmdW5jdGlvbmFsIHRlc3Rpbmc6DQo+ID4gMS4gYXN0MjYwMC1kZWZh
dWx0LWltYWdlLnRhci5neg0KPiA+IDIuIGFzdDI2MDAtZGVmYXVsdC02Ni1pbWFnZS50YXIuZ3oN
Cj4gPiAzLiBhc3QyNzAwLWRlZmF1bHQtaW1hZ2UudGFyLmd6DQo+ID4gNCwgYXN0MjcwMC1hMS1p
bWFnZS50YXIuZ3oNCj4gPiA1LiBhc3QyNzAwLWRjc2NtLWltYWdlLnRhci5neg0KPiA+IDYuIGFz
dDI3MDAtYTEtZGNzY20taW1hZ2UudGFyLmd6DQo+IG9rLiBObyBuZWVkIHRvIGNoYW5nZSB0aGUg
QVNUMjUwMCB0YXJiYWxscy4NCj4gDQpEbyB3ZSBuZWVkIHRvIGdlbmVyYXRlIGFzdDI3MDAtZGNz
Y20taW1hZ2UudGFyLmd6IGFuZCBhc3QyNzAwLWExLWRjc2NtLWltYWdlLnRhci5nej8gDQpUaGVz
ZSBwYWNrYWdlcyBkbyBub3QgaW5jbHVkZSBzaWduZWQgaW1hZ2VzIGluIHYxMS4wMCAoZS5nLiwg
dGhlIGVjZHNhMzg0IGFuZCBlY2RzYTM4NC1sbXMgZGlyZWN0b3JpZXMpLg0KRnVydGhlcm1vcmUs
IHRoZSBjb250ZW50cyBvZiBhc3QyNzAwLWRjc2NtLW9ibWMudGFyLmd6IGFyZSBpZGVudGljYWwg
YmV0d2VlbiB2ZXJzaW9ucyB2MDkuMDggYW5kIHYxMS4wMC4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K
PiA+IEFTUEVFRCB3aWxsIHJlbGVhc2UgdjExLjAxIHRoaXMgd2Vlay4gQWZ0ZXIgdGhlIHYxMS4w
MSByZWxlYXNlLCBJIHdpbGwgdXBkYXRlDQo+IHRoZXNlIHRhcmJhbGxzIGFuZCB0aGUgUUVNVSBm
dW5jdGlvbmFsIHRlc3RzIGFjY29yZGluZ2x5Lg0KPiANCj4gR3JlYXQgIQ0KPiANCj4gVGhhbmtz
LA0KPiANCj4gQy4NCg0K

